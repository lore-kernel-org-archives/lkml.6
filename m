Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B480C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98E520843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="crAA0fGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98E520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeICWbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:31:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34194 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeICWbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:02 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so2326031ois.1;
        Mon, 03 Sep 2018 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNDQkbGZU6mWmkaNVutUS7qf+0WnepCF6fHiS59md24=;
        b=crAA0fGb6iz7MrBzfaUSq7I5Nvpy8M/RcdT/51KQA75f4/ac2cnIewQL7/CCjPknhf
         NVuc4Haw8cLhrjf2ys9b5vnBgtvnJQ74u5XRjPk0CVF5CC40p3kg7llUG6PK0b4TCqm4
         g8Utlz8XcpcZ54j5mZ00xod0wO6Wb0tWgSiowJE1BXK0mBn+R6MFrw0sUP1eXwTYidT+
         O3EpLSHSoIcRUr6fK5efUAi7iguwHfbJwNhzR1+eNB/Vszj1bHijyOSkeb/eVhHADPjz
         zM/YWVbmAfRLPOphzm3SsVO9QYE4vwbrIuG6PdKmpflH7QrAcGBAvDPxDGj+hJ+l46ke
         8J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNDQkbGZU6mWmkaNVutUS7qf+0WnepCF6fHiS59md24=;
        b=MbXvQ1PiPaRGHzGpR9ELNiVHzPZk553p260GGFP0lu49RMj15jPLGhMHIsfGknjK+G
         RqG0916aw19B5QeGOgCT+fH8EFaowLnAwyGFHTDlD+iY0DQx/uZLIqkBRnt54Pf3We6m
         QOF6Tb3Fq0uODTIKkwf9zIhcXMKDK0mtXR4c3NEaww1pFQpwEBRD4+T7Ow6nhV7PCI/4
         v22dfZ16VGS6U9Pj/iR2hkjAMQxFLpOhfEiaLAGu8IjmkDyhRh32Dqp1TIEFJQIiO4xx
         ruYMjUTeXmK8m6K/Y6JIUOwwh+GZ8pyotqzk7RcYhrVES0GZBHQ6qtyqW3JeBCEyBxTO
         9msQ==
X-Gm-Message-State: APzg51CooBKxPg5T4d/Nx4G1Q2JLIjwlMurGZ4+/zJqx7m2npfnUpnz6
        vwvUnNmVVXRCipa79Bwgg1mXxRe8kXCnx2LAeWI=
X-Google-Smtp-Source: ANB0Vda9YKWhAzSLO3zlL9rhBUDipTlHJKnM44SLAmIUgXmj2Hwv/a1Pvlbk20HkV/Trk1vYbZDMB0UtXB2zPr5wq18=
X-Received: by 2002:aca:31c6:: with SMTP id x189-v6mr19794733oix.213.1535998182379;
 Mon, 03 Sep 2018 11:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <18d8d311a32497abce39c796b353a878a13b09b6.1535709565.git.chunfeng.yun@mediatek.com>
In-Reply-To: <18d8d311a32497abce39c796b353a878a13b09b6.1535709565.git.chunfeng.yun@mediatek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 Sep 2018 20:09:31 +0200
Message-ID: <CAFBinCB8J1TP_xsg8cprHBzQrNwUVg7TxbRBw3GamyWUe8yH7g@mail.gmail.com>
Subject: Re: [PATCH v5] usb: core: phy: clean up return value check about devm_of_phy_get_by_index()
To:     chunfeng.yun@mediatek.com
Cc:     gregkh@linuxfoundation.org, felipe.balbi@linux.intel.com,
        matthias.bgg@gmail.com, johan@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:02 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Use IS_ERR() instead of IS_ERR_OR_NULL() because devm_of_phy_get_by_index()
> never return NULL value;
> But still need ignore the error of -ENODEV, for more information, please
> refer to:
> [0] https://lkml.org/lkml/2018/4/19/88
> [1] https://patchwork.kernel.org/patch/10160181/
>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thanks to both of you for fixing my code!


Regards
Martin
