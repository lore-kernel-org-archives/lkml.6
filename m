Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D585C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D9C20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsvY9CXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfAKO0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:26:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36665 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732487AbfAKOZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:25:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so10937760lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMezhPlibajiGAUTYo08rPGVJy9LI+52kVipFELMAgQ=;
        b=CsvY9CXuHvuP2vTpRQyKuR/UFoKr2gc+Zd1n5HWeW3jeQeJrAzB8eBNZmGtnEZ6RdB
         vp8jZlgGDUgSR1AjbcHxNt00u5/mn/ScwOaE3oM2AZPDZJnNDU0+VSxfpEH1JEA9Rfk+
         LDNQzmeGNrE1fq1QcUooxTZdilxSiv5vEXc98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMezhPlibajiGAUTYo08rPGVJy9LI+52kVipFELMAgQ=;
        b=TiuKL3DppWHGUNtVs7zeLatfuz02vD1RgB4nbQMLC1gOzYl2BwCMoQJ8aco3jrkMKf
         fn/Bhx0nfpPuQ6CtHaLnD20dQoGFoQ6cKGGs3G/enn5ycVRHf1h/1ENM/aRzrdmqJtlD
         x4Ug30c8RcN8u8SLtNlV1nJakSrPp3PSuT4tVTLpAvjgBCbLF3QgdI2906hp68wbnLhY
         y6gOxLb9d/+rt8F7n/4RTM0Pk9enOCnmJnhN1OId1z8B9myvA3t28HwmibP0FTIibOaA
         3EDeysiSFDiRZ2hGnR5ZIRXVMS2uj/ztxmHFujQ2xf/MohKD9Wu/Gp6rRxewOwP4UrEN
         0jdw==
X-Gm-Message-State: AJcUukcUejPOhS5Utpw1eM+UG3VGeyZTF+iRZ7UtC0Nz+sbBBEOqq0S5
        hH8nDK+SqPwTKKQpHXtk5ZXNBzzrAArdLtQ4kpxNtKfZ
X-Google-Smtp-Source: ALg8bN6aiLFd5CFB+xSIBHKWd6SdJTQ+kll9fKsdXbyRMUwy4ow0dOqzUTcdToXSWNu3qzVWZgxi9O6aBOv+ycsVxok=
X-Received: by 2002:a19:f813:: with SMTP id a19mr7889089lff.67.1547216749948;
 Fri, 11 Jan 2019 06:25:49 -0800 (PST)
MIME-Version: 1.0
References: <64a23e6f8751ee6f1387a611a9d5dba43694b0d0.1546999151.git.ryder.lee@mediatek.com>
In-Reply-To: <64a23e6f8751ee6f1387a611a9d5dba43694b0d0.1546999151.git.ryder.lee@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 15:25:38 +0100
Message-ID: <CACRpkdaJ29di4GxcHNa+pUtV62aF+8SRKTzYMAJHd-8j0oiX=Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: fix build errors for moore core when
 CONFIG_OF is not enabled
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 3:14 AM Ryder Lee <ryder.lee@mediatek.com> wrote:

> on i386 or x86_64:
>
> Lots of build errors for drivers/pinctrl/mediatek/pinctrl-moore.c when
> CONFIG_OF is not enabled (but COMPILE_TEST is).

Patch applied with Seans ACK and trimming down the subject
and commit message a bit :)

Yours,
Linus Walleij
