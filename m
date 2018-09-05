Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC21EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5849C2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdIVnz26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5849C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIEQ3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:29:51 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54347 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeIEQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:29:51 -0400
Received: by mail-it0-f68.google.com with SMTP id f14-v6so9459472ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lYhGd09aPcQAq/exWTUHGGwpextMVl6emunYiwEVmUU=;
        b=ZdIVnz26A0+MpZwdyMUazxGP9nkD1q+18nidS0re62ZgRP7BtW6qIP8MGXEDuH+WzP
         OqmhrOtZ76e2ZgO7TIf9HovPOs1gd9BdOcUNuSald7lkW/eWUfly1QBYi+lyWbttAaeB
         c+sblFMSic8v4HUkHRpGBjwCr3FsgjZvAjQ4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lYhGd09aPcQAq/exWTUHGGwpextMVl6emunYiwEVmUU=;
        b=qPi/ORe6dAd77Ffq2mEaroA3i9af5tYSJcLEC1SpG7IUd9oYgL7IzTZ/2py/aHOmEO
         QFdxQcsMbiSoHTlqAkF05K4Ta6xXNWFzlwaIl9PL9mqrktvTjqVt5uKUhfR4NJc8Txg6
         MV7YYVZ1i/AjvqW6yreGcQZsRXcawh66c0M1243+j9/36uUy0bySIC6xjL6hNi3a3XnF
         btW1Z7mWlXEqxgf8qrKFgj1We534wdjEaaQFJAXlSCLky3CEwqApM4AgCFbdILWYqM4v
         Mth2KgWDnV3+rUyjsnAec0XymVYjPVjYcWg+MTUomsotSrrg/PF7SzINKsqHuRmazkPQ
         R2Jg==
X-Gm-Message-State: APzg51CW63Mos57wTMx6d4u4MKhy/orUr4mzon/Qx4ljibVjob27dlgz
        YytGDcO9V+RJchHpCeIcrFQwpShx36dszYtu08kuxg==
X-Google-Smtp-Source: ANB0VdZDcw696vHWoduFM0DnddAsvS/JaGndDL9sNES+f939GjTizpDaQPr4RicA0DxBnUV1pHykApqsnmQwgPDA8R8=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr26509727jab.87.1536148795904;
 Wed, 05 Sep 2018 04:59:55 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Sep 2018 13:59:44 +0200
Message-ID: <CACRpkdaD3aQQ6Kn6S-CCGOH2DsX5WUNBB0Jwq9P0k=O0E08MiQ@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v4.19 take one
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some GPIO fixes. The ACPI stuff is probably the most
annoying for users that get fixed this time.

Details in the signed tag.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.19-2

for you to fetch changes up to d49b48f088c323dbacae44dfbe56d9c985c8a2a1:

  gpio: Fix crash due to registration race (2018-08-31 11:30:45 +0200)

----------------------------------------------------------------
GPIO fixes for the v4.19 cycle:

- Atomic contexts, cansleep* calls and such fastpath/slopwpath
  things.

- Defer ACPI event handler registration to late_initcall()
  so IRQs do not fire in our face before other drivers have
  a chance to register handlers.

- Race condition if a consumer requests a GPIO after
  gpiochip_add_data_with_key() but before of_gpiochip_add()

- Probe errorpath in the dwapb driver.

----------------------------------------------------------------
Alexey Khoroshilov (1):
      gpio: dwapb: Fix error handling in dwapb_gpio_probe()

Andy Shevchenko (1):
      gpiolib: acpi: Switch to cansleep version of GPIO library call

Hans de Goede (1):
      gpiolib-acpi: Register GpioInt ACPI event handlers from a late_initcall

Michael Hennerich (1):
      gpio: adp5588: Fix sleep-in-atomic-context bug

Vincent Whitchurch (1):
      gpio: Fix crash due to registration race

 drivers/gpio/gpio-adp5588.c | 24 ++++++++++---
 drivers/gpio/gpio-dwapb.c   |  1 +
 drivers/gpio/gpiolib-acpi.c | 86 ++++++++++++++++++++++++++-------------------
 drivers/gpio/gpiolib-of.c   |  1 +
 4 files changed, 72 insertions(+), 40 deletions(-)
