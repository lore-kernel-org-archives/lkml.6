Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EF621909
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YltO5+fX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389362AbeLUKBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:01:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42880 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731987AbeLUKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:01:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so3481088lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAoEMsT2IMcQJB1nBDhNQagiQv6o4I/H6mhK69Y/SAI=;
        b=YltO5+fXyB+wRR6WVXASdFiQ6YbjMYULLg1Da/Op20rkcqYKePjv8w1Ren6dZzgDmC
         Cn5KJuZhUNwUBFxGJjup3cGdZ/G7J0m/Eccwvm/W8oSfMBO/J2r8+UxhOvdACmS+dvI8
         ox+LjAm8TgBJRD5EJBFTfeNkhnbpaSJeKaayM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAoEMsT2IMcQJB1nBDhNQagiQv6o4I/H6mhK69Y/SAI=;
        b=h9AT28pB6RUf/qiGjM3Q2Q4ZKCsF5zpjHn84JASVFsbHs+CU9HlhtR+P/5lAmObd16
         MI255jV2KjV+ZFSu3JjN/gaY/EKjSU/8Gvfh+A36EhaIm+wW8VIRdoppR9cfM+QqToHZ
         jCy+DDrxKQ1JPr/i5tISr1AZsJfmvA6RLKos96HReBRwFMnnyKRcgnt5f78atG7DC6I3
         TF6BfbMdcqZfu0EXFLqs6mtpdx0UgSIIDd61bUI/7CjRJ5VWE04gxbgYmyuZPROHapdL
         PGTySs55BZ4EWYCOASfdIn4TWw8a52ev8u/3GGa8m4nQW1GOQvbU+ZP1YvtUuNqD8nvM
         M4AQ==
X-Gm-Message-State: AA+aEWaO4i37rchrvpmFVIhyoOFzctsav7B4YVRsGNknVV3qUut+qKPl
        RMlV+LJ2TPLssnMp3x78huDHcs6GK3ckMehlc9TyZw==
X-Google-Smtp-Source: AFSGD/XAbRiaLmWNs6PS/cM2L4w/CMgvQ27ksMmkwA1Oz8gwgS1CVkWV6iVJoLu9oKCLDu030r1zPcRubaRgykvigHA=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1071666lfb.96.1545386506529;
 Fri, 21 Dec 2018 02:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 11:01:35 +0100
Message-ID: <CACRpkdZ+vUwEcEyMj0Snsy_F8AmELSMt1wGbhMsQi7A=_tY3RQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] pinctrl: various fixes for Meson8 and Meson8b SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 8:51 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> While debugging an USB issue on my Odroid-C1 I found a few issues with
> the pinctrl driver for the Meson8 and Meson8b SoCs:
> - GPIOAO pins cannot be specified as GPIO group in device-tree
> - (not a bugfix bug an improvement) make the gpio_periphs group naming
>   consistent with drivers for newer SoCs
> - add missing GPIO_GROUP definitions for the pins in the BOOT and CARD
>   banks
>
> I added the correct "Fixes" tag to all commits where applicable. These
> fixes don't affect any existing boards or functionality. Thus I suggest
> to apply them for next (v4.21) instead of sending them to mainline.

All patches applied for v4.21!

Sorry for taking some time to process.

Yours,
Linus Walleij
