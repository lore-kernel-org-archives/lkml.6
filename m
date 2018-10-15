Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23169C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD5F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ac46UByB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD5F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeJOVBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:01:53 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36407 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeJOVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:01:52 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so5278179itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=co7mz+GkOSuSkB0ex5RDDwY4fEPW/yOtU+bPu6vNy8w=;
        b=Ac46UByBhMgq16FaVt88viZfaARzcvfz718mzahvrStTY8uxlbpKFmSzDojEEXuv9U
         nbY2EhIERqzm5ySNnGZw9AcdiUgEXiHfKPe5/+NYIusJnGtiSnttIkrnq7OfcFNVunga
         S2gTqAHs67nWTLppbK4LocHWLUaWZqzKxHWJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=co7mz+GkOSuSkB0ex5RDDwY4fEPW/yOtU+bPu6vNy8w=;
        b=pbOLNhpcRZh/oLxcLYWfMJ5v1FpOIARI+4NQShEQeAknlAYk74ursyTRNNatKudptv
         nCeeGfjt7q3zLOWrNx6Fpo98libvOGqk9FbF7D9tuH0ltN1QlrFQmjwWtBOEAw/HPZvm
         fRJsPtXghrI0QrHfnu/y/ngvTqmQ5+OqkfWdJvo/QIMV2JyIPNfxZ9aUASYfaDOjs1L2
         dMUp8TGmjJX18Tc8CKEi2QPO7LE16hYSwztPd5HCn1rOroF4UIbIsDaI8nkTgHCtd0F1
         z9CJAu4SM7+3JZa6lr41hFjWJV/wLRlX23ddZY0h7wsgZtDb0kHPXSnezUYqCoc+LiiE
         xerA==
X-Gm-Message-State: ABuFfojjjl+tytdxD3ZGPnedyviNSPQ+h19R+5yWmj83v44Ehc7PFLq4
        q1Hcg21dOF4Uxk6PDneQho34R6nx3gBM9omT5yVjkg==
X-Google-Smtp-Source: ACcGV609qvkIAdHUZrdmyfyL/m+W9PjPUPOfBkcLhjAPD9bqTD8KgMiYqmH9wu+jmuputQyuDRcBdOUbMSodSBeLaw0=
X-Received: by 2002:a02:c881:: with SMTP id m1-v6mr13616717jao.43.1539609396007;
 Mon, 15 Oct 2018 06:16:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 06:15:55
 -0700 (PDT)
In-Reply-To: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Oct 2018 15:15:55 +0200
Message-ID: <CAPDyKFp3Wn9Wz8bmaSXFmNe0HOKCMcy7Pue3C7+9w5kq2AO0Sw@mail.gmail.com>
Subject: Re: mmc: mediatek: add MT8183 MMC driver support
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        jjian.zhou@mediatek.com, wenbin.mei@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 October 2018 at 09:20, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> this series of patch include below changes:
> 1. Add MT8183 SoC support in Mediatek MMC DT bindings
> 2. Fill mmc->actual_clock
> 3. Fix cannot receive new request issue
> 4. Tune CMD/DATA together to save tuning time
> 5. Add MT8183 MMC driver support
> 6. Refine the tuning method to drop too much redundant code
>
> Chaotian Jing (6):
>   mmc: dt-bindings: add support for MT8183 SoC
>   mmc: mediatek: fill the actual clock for mmc debugfs
>   mmc: mediatek: fix cannot receive new request when msdc_cmd_is_ready
>     fail
>   mmc: mediatek: tune CMD/DATA together
>   mmc: mediatek: add MT8183 MMC driver support
>   mmc: mediatek: drop too much code of tuning method
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   1 +
>  drivers/mmc/host/mtk-sd.c                        | 292 ++++++++++++++++++++---
>  2 files changed, 254 insertions(+), 39 deletions(-)
>
> --
> 1.8.1.1.dirty
>

Applied for next, thanks!

Kind regards
Uffe
