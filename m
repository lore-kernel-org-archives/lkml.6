Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74032C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425BA2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I2T7xdo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfBEQLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:11:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38264 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfBEQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:11:11 -0500
Received: by mail-it1-f195.google.com with SMTP id z20so9512547itc.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PDyxZQez69poaTeCS0qHlzzySskONvPAxl2nUBIaDiw=;
        b=I2T7xdo0NGWBOsDrCPMtF3kcpZzrI+Gp/0XelKJQAke5My9IXWsYa881sq41rS6ar5
         I5QI0nLPhSls1sICAjTUmdC0kjQt7zXT8rKKwbjiWF+PLGiAGK/fv1rrlEtNG3J5fUfL
         mcuP1ZU2bJZM/p2Hil5IVrftiksw/hNmqHCv+qsI7FXqeJ7w2nvDI7PvKsdQg2lUM4su
         KWj7xj4iMU0Zp7QB21DfLjTmq5l/NziDnBa549EL1Zg4Mc9IeWkVlUE1eYuk90WayYI8
         T6dB1Q45y4svkC1G8myc5bdr++RwTyjiT67Uzurn9HXMyM+HCXtMRRE3rbHQlKwAaL33
         2K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PDyxZQez69poaTeCS0qHlzzySskONvPAxl2nUBIaDiw=;
        b=TQ2YK+CuENRtPqZpRQ675sGZPwnOEEN0Fg4gHXS/U8AQg12aAeW37XHLZ/53WgucBr
         oJ3n5oi0AJLTr4a9HmYTHg0MH2wFNH7B4/ZnAlNMVo7z5vpkPc5WkaOdtQWMi5H/5m76
         BMewe3yW7vq6AV66GEL0IYMn0Bkc2QrHdNqR8pyKHKXT1GWygSBUzL3hqU6agQSjGMnU
         iHVnRfp7spnWWT8EVg+tnTaClEbttpujQdxmjR+mIj4T9z/zZRYOAhqIfywFQLIvgWuH
         Tl8zQWRXrwDPOyBYWuwXuhrQr6xFGb4VR2khf5t1MFx49/K8eRQ/C1n0WPrBh6DS/ghC
         v50A==
X-Gm-Message-State: AHQUAuaJEs4xPfbdAFOrH2SFAQ9QoH7G2fSPDVNm+rCvKlsIg1gdwWLR
        OG8qTCgCQSqcLk/7jjbPptdF2u5OREqF4oY4QtHLDA==
X-Google-Smtp-Source: AHgI3Ib8VcJBaKIDYqLflL+TBgTZ+UzWErLpmepkjsFM4MeivJf9N8w9cvtD4ABW8Z2p76z3fScOxgV3RzpnAu4O/+8=
X-Received: by 2002:a5e:dd0c:: with SMTP id t12mr574765iop.258.1549383071140;
 Tue, 05 Feb 2019 08:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl> <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
In-Reply-To: <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Feb 2019 17:11:00 +0100
Message-ID: <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 4 lut 2019 o 22:49 David Lechner <david@lechnology.com> napisa=C5=82(=
a):
>
> On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This series ports the davinci platform to using SPARSE_IRQ, cleans up
> > the irqchip drivers and moves them over to drivers/irqchip.
> >
>
> This has been on my todo list for years, but I've never had enough
> time to figure it out. Nice to see it finally getting done!
>
> Series tested on LEGO MINDSTORMS EV3 (da850-like). I can now use
> IIO triggers without having to patch the kernel to add extra
> interrupts.
>
> Tested-by: David Lechner <david@lechnology.com>
>
>

Wow thanks for taking the time to review it!

I'll address certain remarks - for those unaddressed - I'll fix them in v2.

Sekhar: are you fine with sending both the clocksource and interrupt
series together next time with additional patches on top making
davinci part of multi_v5_defconfig?

Best regards,
Bartosz Golaszewski
