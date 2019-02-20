Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0396C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA582146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7axKEUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbfBTIDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:03:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36008 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:03:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so19993612ljk.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nUbxUx1gRsly3arN/LWcT1tuQQt3S+LGMmXq+6VcpRU=;
        b=D7axKEUl51C/mr+vwgE5bLIU4LbrO6gYBKLMoJ0rgYK9m+KISUKCsOI9F1jg0w01Jh
         j9twRcEWjuTdJJyoTcI6Q+LOOd2AHN7jhi3q/jR0PjSBLfcbtdHLVJdhqnCGlHo0oIP7
         6hDWbvlalASxAK9UKTq6xow4wVpWhSKHOmoq1jK8aHlYw/ScTNsvxjTqVd/YEny9imrY
         hkPX5PEqLszJsoz/AUfdbgGx1ZJa1fNJZWzES14BTPOahUXNXsYBWO3GqV5u8T+EyuMl
         EtZDz7GyTJyg2m+oZcADzCJgUeUn7vuHmUST/IgXNasPtc+1ws09QtrW/vy+zSVnQ4H8
         Q77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nUbxUx1gRsly3arN/LWcT1tuQQt3S+LGMmXq+6VcpRU=;
        b=W85pH4ZcU26juXzuGu9bfT9s1XCeWtlK42Khd0X33Uvd6ujFN5G9Cm1nrwUYumwmQY
         T4LFCyhp8qlLaP1JoHun46OnNncWyPrjSfPtiT0g3mjCmcNejGNz/OcFzvVsoRysXCC0
         W3z9OImw4zvPbOJZe9pmtxrkrBBWjvVb4rQXCyIv+/0rH+871RPcwqUOz+bGPiRqlOhx
         ixzHGJ27Fc+SxeLgmvr3a4PMq85JD5X47wSyc+eL16RUGvH9qk03+erR+z2o++5pnrH/
         Q+vQGKTncKVygvidCjD3GFsaJzkEOIbOEGjkkBU6W+yVSGbtPRaeMqN7ckSogxUffdd0
         6lZw==
X-Gm-Message-State: AHQUAuba+jg2VvZTX5elLOWa81JKXq6YN4yVhaPcZHCQCexfIUvgtsvp
        fuWbDHwReXN7Fsj97fMm7apRnquaRKzQICcbHiRNlw==
X-Google-Smtp-Source: AHgI3IZd3WX2Hz5YYI7n4hWWcF1WqMiCKZd5AutkY9Fsjvz2lrlOou4/99b42OMdR3Oisvgq0Q9fgVVBspaTUaXKn+c=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr19546972ljb.126.1550649813924;
 Wed, 20 Feb 2019 00:03:33 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 09:03:22 +0100
Message-ID: <CACRpkdYq5tVpFNC7sjdSATOMKCOeMxrjKK-pP6HNzgHt2bbVgQ@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for the v5.0 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some final polish for GPIO for v5.0.

Both patches are also tagged for stable.

Please pull them in!

Yours,
Linus Walleij


The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5=
:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v5.0-4

for you to fetch changes up to af14b2c98adb85e9517390bb88309338b9075350:

  gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2
(2019-02-14 10:06:03 +0100)

----------------------------------------------------------------
Two GPIO fixes for the v5.0 series:
- Per-instance irqchip on the MT7621
- Avoid direction setting using pin control on MMP2

----------------------------------------------------------------
Lubomir Rintel (1):
      gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2

Ren=C3=A9 van Dorst (1):
      gpio: MT7621: use a per instance irq_chip structure

 drivers/gpio/gpio-mt7621.c | 20 ++++++++++----------
 drivers/gpio/gpio-pxa.c    |  1 +
 2 files changed, 11 insertions(+), 10 deletions(-)
