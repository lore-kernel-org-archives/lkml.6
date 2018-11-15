Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB8EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F38223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjIOaYz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F38223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbeKOSg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:36:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40488 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbeKOSg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:36:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so16521612lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o6SjfnH23J9O8Igrs5F2hSC8HGUAb0eNoJfNBzzOvh0=;
        b=EjIOaYz2X0wj2m3lg4daqdw4znyLG680Tab+cHXPH7r9Ap0T/B30xQ18Bck0Cwe9mb
         LEQlGaQzP/Vsny+62KaeQT9UhID2jMGjR9gXujRXkcvU4JtXSpG6idp3Y1PKhp4vpn/q
         hS511N33PpVS70buy3n7cgvK7fLsvCPQUDzhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o6SjfnH23J9O8Igrs5F2hSC8HGUAb0eNoJfNBzzOvh0=;
        b=eer8btD9C8aoE7/mPgIKUOwAgz6f+P005PMCvmHwuYdYvrh6yCaEGbFQ9nCcOU3qGx
         UaZO+Ms8J5u8l8UfC2FShv0kruTk7DogGO2l4dFsQvD5eAmrcDyZOoLSYBENbjjwVJcc
         AmjCAIZcXqGsuS6S6wMzzYdJf/2I0+Td+phPm6ZAIpaAEDvCBeKoXT4maY75uP60Pivo
         mOGUsTxIC7XFHZAnnu+f4fIkPrKQUP71tXUOSaWjOfOtl0NVkJz4T0u1zhUjBLxxn7JC
         ITRmjib1gDSo61ATH9r7PgNAgVqWqO2C93ry5uKyzX+ZHrpJ5FfUGnrJRMB3lhpDSOlw
         3lKQ==
X-Gm-Message-State: AGRZ1gIPRnaAzcWXMCEMQ+1HBUCKSFyK/qOarL4EwMWEREdF3NHxki/1
        gV8RWilU8o9VgaFq7gtTjFqFWYhp61UlqHWXn753wowWbEQ/Ww==
X-Google-Smtp-Source: AJdET5f/TiovzhaPe7BIrotK21ZwZisxkhC5Zbk40ME8UVceYJGU9hWM04ZaN8Ch1/bEX5oi1emIfaEFiukIgOTKr/w=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr457219ljc.66.1542270577252;
 Thu, 15 Nov 2018 00:29:37 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 09:29:25 +0100
Message-ID: <CACRpkdYht47bTGK_LSy9xqXAJ4axdarC0zqRoKpR4zOwjG-qRQ@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some few pin control fixes for v4.20. Just meson
(a very specific hardware) and establishing a git repo for
Intel pin control.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.20-2

for you to fetch changes up to 595b0674ce781e38522097b18718ce3c3bffc1a1:

  MAINTAINERS: Add tree link for Intel pin control driver (2018-11-09
11:36:51 +0100)

----------------------------------------------------------------
Pin control fixes for the v4.20 series:

- A bunch of meson fixes for this (Allwinner) platform.

- Establish a git repo for Intel pin control in MAINTAINERS.

----------------------------------------------------------------
Andy Shevchenko (1):
      MAINTAINERS: Add tree link for Intel pin control driver

Jerome Brunet (5):
      pinctrl: meson: fix pinconf bias disable
      pinctrl: meson: fix gxbb ao pull register bits
      pinctrl: meson: fix gxl ao pull register bits
      pinctrl: meson: fix meson8 ao pull register bits
      pinctrl: meson: fix meson8b ao pull register bits

 MAINTAINERS                                | 1 +
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 2 +-
 drivers/pinctrl/meson/pinctrl-meson.c      | 2 +-
 drivers/pinctrl/meson/pinctrl-meson8.c     | 2 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c    | 2 +-
 6 files changed, 6 insertions(+), 5 deletions(-)
