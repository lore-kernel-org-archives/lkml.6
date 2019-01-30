Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79762C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A81220870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAtmkMEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfA3JJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:09:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41668 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730403AbfA3JJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:09:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so20017278ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ztZLgLJu+Vu2LBQ/fKZsbWM1IGOjTG+sdTP7/8iOnZk=;
        b=gAtmkMEvqp4t6pQLXgA/jrPTuyqlzEmLr3hpJxIaCeN10CBh+IuUEqsO53jEMCE18d
         Y2NXHEYdtuWRZhY1cdpeaq5VxF04+0PwtTkuDQ62pjxzIVGenU1EAojylJdnpS5iJBVF
         KMKeaSO+GMX+zxO4yEubtKJogeFf8awMzQMe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ztZLgLJu+Vu2LBQ/fKZsbWM1IGOjTG+sdTP7/8iOnZk=;
        b=KIHd1hy/852+rUjM4cR1LOrAcnKZlgbCKon++X3oHaLy/uHhbvuPcCdDNnVup2Km4c
         Ow1JvnUZjcjn/3Tg0ZtRmGZt9OtPLv3/FSMshEE9O3dOBEUvciSPU1G6viZPsmGWDADG
         uzwNpAkHmZital99DIAxboltW7nqU9sJ7LviAJi6MQ7EPq3a1Rcf4QfFkPkt5/bea2MH
         zHnD6nFZ2IKlWKhS687k1CtEwzYzxy8VYcPmBf76B0WLRdXHg0RKYYQos1J+e4Ip+zKq
         mq68B8McAaDN3gW4tBViCoH9O+InoTBImNhYYkV93GFOSYqxoxbiYk2unLpSokr8lcTD
         HuMA==
X-Gm-Message-State: AJcUukf73sVP1Oz5aJWuPbffrWknmlB7gQCU6uMffFwW+SWy2h1WYVpw
        oA+GlBB0+EbYgOBKN/vjn9RFQ8f8+e3uk7Lw3Q5oIrDY/1U=
X-Google-Smtp-Source: ALg8bN6h/LLDvuhbJG2nDLyWu0pcsMpIGQ433tA+fHKG/0S/7DN+G/v6U2VeJxkxuXn/PJlIDc1YXda29L9NIRSRF54=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr24799456ljc.97.1548839348326;
 Wed, 30 Jan 2019 01:09:08 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Jan 2019 10:08:56 +0100
Message-ID: <CACRpkdZWGrinXV5oF0c5aggi51TKTR5GsL1nO3gA+6RMO7U3bg@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for the v5.0 series, take two
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a bunch of GPIO fixes for the v5.0 series. I was helped out
by Bartosz in collecting these fixes, for which I am very grateful,
the biggest achievement in GPIO right now is work distribution.

There is one serious core fix (timestamping) and a bunch of driver
fixes.

Please pull it in! Details in the signed tag.

Yours,
Linus Walleij

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.0-3

for you to fetch changes up to 7ae710f9f8b2cf95297e7bbfe1c09789a7dc43d4:

  gpio: vf610: Mask all GPIO interrupts (2019-01-28 15:28:43 +0100)

----------------------------------------------------------------
GPIO fixes for the v5.0 series:
- Fix timestamps on nested IRQs
- Handle IRQs properly in multiple instances of PCF857x
- Use the right data register and IRQ type setting in the
  Spreadtrum GPIO driver
- Let the value argument work properly when setting direction
  in the Altera GPIO driver
- Mask interrupts properly in the vf610 driver

----------------------------------------------------------------
Andrew Lunn (1):
      gpio: vf610: Mask all GPIO interrupts

Axel Lin (1):
      gpio: altera-a10sr: Set proper output level for direction_output

Bartosz Golaszewski (1):
      gpiolib: fix line event timestamps for nested irqs

Linus Walleij (1):
      Merge tag 'gpio-5.0-rc4-fixes-for-linus' of
git://git.kernel.org/.../brgl/linux into fixes

Neo Hou (2):
      gpio: sprd: Fix the incorrect data register
      gpio: sprd: Fix incorrect irq type setting for the async EIC

Roger Quadros (1):
      gpio: pcf857x: Fix interrupts on multiple instances

 drivers/gpio/gpio-altera-a10sr.c |  4 +++-
 drivers/gpio/gpio-eic-sprd.c     | 14 +++++++++++++-
 drivers/gpio/gpio-pcf857x.c      | 26 ++++++++++++--------------
 drivers/gpio/gpio-vf610.c        |  5 +++++
 drivers/gpio/gpiolib.c           |  9 ++++++++-
 5 files changed, 41 insertions(+), 17 deletions(-)
