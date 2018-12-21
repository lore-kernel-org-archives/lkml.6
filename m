Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6132C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29D4218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEf3nue1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeLUI7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:59:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37989 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeLUI7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:59:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id p86so3353014lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wEj9mf6/K3+8mm6FE491gffK4bFYjj0XiCuphCsYXng=;
        b=GEf3nue1FMYZIurUG7nhiRWjwxqUE+2r5/fOKV3Hiqhyi825c2CUGEB6S+NW734CY2
         8GXxN6O5iLI0oQ5ZzRwcpZndcL+wCWf39AXzN0wok52lezght2mPAyuyg+fFrfyp8zDE
         Q+leCaRHUoHJww5sL6jYmKaD7ODVJnH19l8OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=wEj9mf6/K3+8mm6FE491gffK4bFYjj0XiCuphCsYXng=;
        b=po2BC+xOOohGtUXhy28r1V3rzx29xM4jGLSyOZ3LzkmyTTW7F9+zg/Hk6doa22s0MP
         Ms93eBX7FCB54yQQyYnsUxPncxkm2fYSH2nZYQguxRlzuHhUMpX56NvByO9ovCjW7t9C
         7OdhSRGbVKPnjqdgv6u6w5WaAAht4y/dXkQiTTFEpaIg1kFB0A8tVFRFn4nO0ZdUfg3t
         Wbk/iGKKjRcOAtKGL7PO4xScpCR14EhNg3Z3+27NM4eL+e79qHbqO1pVYbwjk5KRp16E
         vHMOi+8JV2LGb106TS/SqOPMFdYqDp5yqqnMocOH5ql5BPrq9exCfvVW7q4SAzkwlfjt
         tCrQ==
X-Gm-Message-State: AA+aEWaULCifYqbcVjvCjkYVyOhsv+24j1K1IglFluTm/e6poG9Fw/03
        HNQSkAjUovcZGjUUGC+fPbki7zaMlXrE8yd+7TrQ9g==
X-Google-Smtp-Source: AFSGD/XRuBw4+GU+V3rE+WtyYwC1VbK3l0goZe1HGxUoHUFrBdF0dS0nuPw+Jl+cNnx+hPcUTnnLyT1vYGkPsjoOKOs=
X-Received: by 2002:a19:4849:: with SMTP id v70mr872433lfa.62.1545382761475;
 Fri, 21 Dec 2018 00:59:21 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Dec 2018 09:59:10 +0100
Message-ID: <CACRpkdYn7hPt5Etb5oeD-pTW6ME4QAwnTZEXu8siGNxi-OgQew@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the hopefully last round of GPIO fixes.

The ACPI patch is pretty important for some laptop users, the
rest is driver-specific for embedded (mostly ARM) systems.

I took out one ACPI patch that wasn't critical enough because I
couldn't justify sending it at this point, and that is why the commit
date is today, but the patches have been in linux-next.

Sorry for not sending some of them earlier :(

Notice that we have a co-maintainer for GPIO now, Bartosz
Golaszewski, and he might jump in and make some pull requests
at times when I am off.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436=
:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.20-3

for you to fetch changes up to c8da642d41a6811c21177c9994aa7dc35be67d46:

  gpio: mvebu: only fail on missing clk if pwm is actually to be used
(2018-12-21 09:23:46 +0100)

----------------------------------------------------------------
GPIO fixes for v4.20:
- ACPI IRQ request deferral
- OMAP: revert deferred wakeup quirk
- MAX7301: fix DMA safe memory handling
- MVEBU: selective probe failure on missing clk

----------------------------------------------------------------
Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Hans de Goede (1):
      gpiolib-acpi: Only defer request_irq for GpioInt ACPI event handlers

Tony Lindgren (1):
      gpio: gpio-omap: Revert deferred wakeup quirk handling for regression=
s

Uwe Kleine-K=C3=B6nig (1):
      gpio: mvebu: only fail on missing clk if pwm is actually to be used

 drivers/gpio/gpio-max7301.c |  12 +---
 drivers/gpio/gpio-mvebu.c   |   6 +-
 drivers/gpio/gpio-omap.c    |  64 ++------------------
 drivers/gpio/gpiolib-acpi.c | 144 ++++++++++++++++++++++++++--------------=
----
 4 files changed, 95 insertions(+), 131 deletions(-)
