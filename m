Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F4C242D0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F4C242D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeGBP2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:28:22 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33892 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeGBP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:28:21 -0400
Received: by mail-vk0-f67.google.com with SMTP id l189-v6so4857597vke.1;
        Mon, 02 Jul 2018 08:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdKsdGBaMX4jgtdrUK0OFk2EZvHh6tCcRtDft18XO2s=;
        b=WIouzAxeWDLyYHjor3qMJ3xIC+F9t1sEiyYh3VpsqEqJcJnurWxjjjvrSsZ57UAa12
         mblgV+KZZZj3JgtdUPkz5hNuDo9G7HYpLwZg4OPQnQI5LKRcaBrKWH/Fax36TqWY9dOy
         rU9d28lM5SbPYseKBSqpOlc/8yqzWz6olqeet86NwMz00MbeNb5BLkwGlgWILKMkkmgR
         aLoiVrJIKBK2g4OxqqD2Rs5Z9XHILCqnLq8H3MojLo/tAd6LsdjvcbJl/P7oO599VI2H
         1ACNOdCkYGCG34MOFMp18HLTx4pkcxasmudIHcWczoI3GSLpVGMCEF3cHDeMt8aT6vz7
         rywg==
X-Gm-Message-State: APt69E11oVnydOobFsVV4CH2H03lbLXj3/+mIXSAVvFgykM2a8E2ZVCh
        K4a0if6YAs8Tc2dH8CCUJsNIbjpiXtz4SNxA6yc=
X-Google-Smtp-Source: AAOMgpfiMQemEqDT9arT+7TyUnSIIDoYSkWLPVUuPi3izD8l/R99NJmqbucYQOyddIIfTFMT1jqFO5G/32owuQ0W02I=
X-Received: by 2002:a1f:f44f:: with SMTP id s76-v6mr753340vkh.125.1530545300124;
 Mon, 02 Jul 2018 08:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180629185107.GA37488@beast> <CAK8P3a30Q1ezvCWfudUY=z1q3NHdrkbwRsmSDso4s7TifQAmNQ@mail.gmail.com>
 <CACRpkdYbmu_Y6N1G3M3q3M=3ZaECFdgije6Qgwoo6qra4g06_A@mail.gmail.com>
In-Reply-To: <CACRpkdYbmu_Y6N1G3M3q3M=3ZaECFdgije6Qgwoo6qra4g06_A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jul 2018 17:28:08 +0200
Message-ID: <CAMuHMdUWATshtf8PX+QxwrOHaXt60j2e_GYx=L-UbWjYVL80yA@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: Remove VLA usage
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:22 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jun 29, 2018 at 11:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > - Nobody uses this driver in practice, as the hardware platform
> >   was a dead end
>
> Depends what you mean with dead end.
>
> The hardware was deployed in a few million handsets from Samsung
> and Sony.
>
> Some have been picked up as targets for PostmarketOS:
> https://wiki.postmarketos.org/wiki/Samsung_Galaxy_S_Advance_(samsung-i9070)
> https://wiki.postmarketos.org/wiki/Samsung_Galaxy_SIII_mini_(samsung-i8190)
>
> So it is no more dead end than anything else discontinued, and it
> has a living community who want it suppored by the mainline
> kernel if possible.

Mixup with SuperH-based ST40?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
