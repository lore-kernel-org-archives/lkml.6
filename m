Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7731DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446D7219D6
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Hk7/tOSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391098AbeLVR2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:28:15 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43447 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeLVR2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:28:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so7923798otr.10;
        Sat, 22 Dec 2018 09:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJmJivfBFqLOcN6TtpH6HpKHEyAijaY/EYqQyvBRsyY=;
        b=Hk7/tOSk2lTgpVxfoZmtLgCG/Cz/dSMP0rDKgKJ3WJX80th/1nGSKiGZHU6P6+HnMf
         KuGwrhGoDBA1RKzzDYsCkBgcBRfsnLvDLgRE090aT2swNsf2h6msbXHAeeP7/JWtu7wf
         HNAfMRS9fylDJsFp0HJgX8Xl81wDUnDQ7glsI5+aG4rADCX4b3AyknshUy0VQfEoS5QT
         wzZ8cJj8rgJHnRyZACnSUlfz4w71A00StynPZSOpBW0RpxA/i74Zi9DLVHjroe4/3UjQ
         S796DxZjmdAvCJSCdmYeHERfnYk5aUWO8JEf/fka/t9t3ymvkji2sIpBlihY95nwBzLG
         r6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJmJivfBFqLOcN6TtpH6HpKHEyAijaY/EYqQyvBRsyY=;
        b=W8OULaQinx2ihRSUJq9ynrjoNUB1SnuUgnUJMS17sP+zkB3ig+BsplQ+oOPo6kDP/Y
         enc+fLLFVZYKAJ71pC/gIFyVQ7FRnvzDYHcP6YaTIE6RR2RxQxTQpo3nSBMkGl7C7GXM
         Yu0pKKrRfYGJHV3Gg0dB8l5MnuANWa/5OK4FT6YD/0hJrrF7Av5oYgxEG4rhHIaLttty
         pYk4KUg3avxJ/c5BC1aEFza96x2PcD9poQuLvu7utmGjcvsThd4pRQ6wgv+ko3V1UCQm
         qNRDhqBlJyYWHt8ZlblLTI7KhFuxkIQTU3MASF9JjCKIyASCr6rYMXLQbLd7pPDPZBa+
         0FdQ==
X-Gm-Message-State: AJcUukc0sqQ3LftPe3tJDMyckfvCZaNmW61Oj/XPmbiH3Q2NI5o30rPt
        MYuwOiNy+wtpTUkAJfoo2vXzn+LlXrzpjKZbfWU=
X-Google-Smtp-Source: ALg8bN54gfw5tixjH1TSeMscrYxm3+6mbfhLbTfOvL97Kk5ron7b5GnyKGWXXFYjJiRPly3z5enNakahWKyrTB8DLMg=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr4797932otg.308.1545499693815;
 Sat, 22 Dec 2018 09:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20181206151828.24417-1-jbrunet@baylibre.com>
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Dec 2018 18:28:02 +0100
Message-ID: <CAFBinCCUO6ihxNWDup5ZVKWBc8+oiW_-j8OUxRhb+tjpGsUBkg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: meson-gx: chained descriptor fixup and improvements
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, Dec 6, 2018 at 4:18 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The goal of the patchset was mainly to address the following warning:
>
> WARNING: CPU: 0 PID: 0 at /usr/src/kernel/drivers/mmc/host/meson-gx-mmc.c:1025 meson_mmc_irq+0xc0/0x1e0
> Modules linked in: crc32_ce crct10dif_ce ipv6 overlay
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.19.1 #1
> Hardware name: Some A113 Board (DT)
> pstate: 40000085 (nZcv daIf -PAN -UAO)
> pc : meson_mmc_irq+0xc0/0x1e0
> lr : __handle_irq_event_percpu+0x70/0x180
> sp : ffff000008003980
> x29: ffff000008003980 x28: 0000000000000000
> [...]
> x1 : ffff80001a71bd40 x0 : 0000000000000000
> Call trace:
>  meson_mmc_irq+0xc0/0x1e0
>  __handle_irq_event_percpu+0x70/0x180
>  handle_irq_event_percpu+0x34/0x88
>  handle_irq_event+0x48/0x78
>  handle_fasteoi_irq+0xa0/0x180
>  generic_handle_irq+0x24/0x38
>  __handle_domain_irq+0x5c/0xb8
>  gic_handle_irq+0x58/0xa8
>
> This happens when using the chained descriptor mode. If there is an
> error, we call mmc_request_done(), loosing any reference to the cmd. It
> turns out that the chained descriptor does really stops when we do so, at
> least not completly. Most of the time, it can be seen with this harmless
> warning because the descriptor will raise another unexpected IRQ. On rare
> occasion, it will completly break the MMC.
>
> This is mostly adressed by patch #1.
> With this fixed, I took (yet) another look at the ultra-high speed modes
> and the tuning.
>
> I came up with new settings in patch 3 and 4. I've tested them on eMMC,
> sdcard and sdio on the following platforms:
>  * gxbb p200
>  * gxl p230, libretech (eMMC only), kvim.
>  * axg s400
>
> So far, these new settings seems to be working great but I think it
> would be nice if others could test this and provide their feedback.
> This why  patch 3 and 4 are RFT tagged.
>
> Jerome Brunet (4):
>   mmc: meson-gx: make sure the descriptor is stopped on errors
>   mmc: meson-gx: remove useless lock
>   mmc: meson-gx: align default phase on soc vendor tree
>   mmc: meson-gx: add signal resampling
I gave all four patches a go on my Khadas VIM2 Basic (16GB eMMC).
regardless of whether I have your patch applied or not: eMMC
sporadically fails tuning (if I reboot the board a few times it starts
to work)
[    4.172686] mmc1: tuning execution failed: -5
[    4.182535] mmc1: error -5 whilst initialising MMC card

I'm not sure if this issue is specific to my Khadas VIM2 so this is
*not* a nack for your patches.


Regards
Martin
