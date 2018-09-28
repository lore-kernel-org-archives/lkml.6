Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60737C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EA8206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="quLFzC7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EA8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeI2Dif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:38:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37273 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeI2Dif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:38:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so7123532ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMp4u7sYnhkUHethiKEkqOVVbXpUHsk+wasup6xslf8=;
        b=quLFzC7lwz+uR2s7n7cpOyZxDhKOPnBtFuI55HcwJzu2ZP9UM1sRxRd9QCjSzSkk0a
         HZk8X4e7P8msgIIp5WuS+3DUcoKmS06zKQOB6mmhlwe4QXfLh94+qTTtwiZIPeaINMfV
         +uQxlRL65h/YxNEUZEcKxMGCB8lszotGZO8H/3sE1cY6i6KjPJYs2lze+P3qjKjMQXEb
         xjq8+zOKST3MHM1IQrCdniD8fOsvf0FCesyFJbkwJ26hNQoIVaJsg5oa8H8h6sag8vp0
         MnS2/d/EJVphRQvlfSrstpmuPXrgytsPB1+6Lqz26I6gMIPEM1v3TcLRlfyqlqvOyhy1
         lQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMp4u7sYnhkUHethiKEkqOVVbXpUHsk+wasup6xslf8=;
        b=Y75pzOWk9ysGgsHg0zwBWc3STA3rs0GJCLCKuyJqLFQVcEgRo+Nm9GpDxJP5+B4AdD
         +3PWd2LfgH4jFe1bZL4CLzmoYvhIYR8Vd2StVLTbDbau3/OkCWZ9zSR1mlAbj5Ej5Qg3
         IFshGFa231aU4LERb+d9lFeobmHccc/TaXtUPMI6FKOJRFAkg2jutsZE36FN7+ZPEL4m
         LCOhnE6Vn9ZJYTGg9BmT8efXCGdgocBNCAfdbyY6twaGc/Gg8+/7xfdEvNsipjWdRr46
         FBhjn+sh8FR3ex/HHoXAkn1hgaP3dPu+DPwAmv8vvCUG2mtDgiPRKwMv7w5yIzA5PFVT
         qGxg==
X-Gm-Message-State: ABuFfojsZZHCtxD+X4Gm8pXAdyvMDqeJzJWKoGiC6icwg7bjqKbCgxRk
        MGH848ksotWKGErr89HJwpl1HiD+1KCldAMX0tDkKg==
X-Google-Smtp-Source: ACcGV60zV/+48W9QraPEdXVYAeGe92gT7oHj4F9hTQN0npd/H2trJuKS6ZI1sO2Z7o0/bQC9xpPy4VxesHeFnBbvi6k=
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr206988ljh.49.1538169180419;
 Fri, 28 Sep 2018 14:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
 <1537985581-32164-3-git-send-email-jollys@xilinx.com> <CAOesGMhEcMB4caAPtCSq-m5zQBDc-8Z4f_xAkomnEwVaHyX2Mw@mail.gmail.com>
 <BL2PR02MB21308D0B6AF76A8094E70863B8EC0@BL2PR02MB2130.namprd02.prod.outlook.com>
In-Reply-To: <BL2PR02MB21308D0B6AF76A8094E70863B8EC0@BL2PR02MB2130.namprd02.prod.outlook.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 28 Sep 2018 14:12:48 -0700
Message-ID: <CAOesGMiUnVrnW1VDh1CKRKGpkwAC9G8tiHjpb+7bss6LpPWU-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] firmware: xilinx: Add zynqmp IOCTL API for device control
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:15 AM Jolly Shah <JOLLYS@xilinx.com> wrote:
>
> Hi Olof,
>
> Thanks for the review. Pushed v4 with suggested fixes. Let us know if series looks good and we can create pull request for same.
>
> Thanks,
> Jolly Shah

I'm happy with this one, thanks for revising the patchset with the fixes.

Feel free to add:

Acked-by: Olof Johansson <olof@lixom.net>

to the patches.


-Olof
