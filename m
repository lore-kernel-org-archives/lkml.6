Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754920AbeEHMgz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:36:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36274 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754123AbeEHMgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:36:53 -0400
X-Google-Smtp-Source: AB8JxZopPaxUMIkOO0ARypsRQh8YNPYGlze+gVa/EGW7aysuTdgmAE4XFJvG5Udgy+yPYtLXg2PZGCfDjC+VczC8zN4=
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 8 May 2018 14:36:51 +0200
Message-ID: <CACRpkdY27sJ_kFg95ORKXBLrpzv3Yo-oc+c4tULJXvC-YP18mg@mail.gmail.com>
Subject: [GIT PULL] GPIO fixes for v4.17 take one
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48CbFpH012018

Hi Linus,

sorry for lagging behind on sending the first batch of GPIO fixes for
this cycle. Just too busy conferencing and the weather was too nice.

Here it is anyway: some real important polishing on the error path
facing userspace (tagged for stable as well) and some normal
driver fixes.

Please pull it in!

Yours,
Linus Walleij


The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.17-2

for you to fetch changes up to e026646c178d8292de563fbecc247bada059c282:

  gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop
(2018-04-30 10:48:08 +0200)

----------------------------------------------------------------
GPIO fixes for v4.17:

- Fix proper IRQ unmasking in the Aspeed driver.

- Do not free unrequested descriptors on the errorpath when
  creating line handles from the userspace chardev
  requested GPIO lines.

- Also fix the errorpath in the linehandle creation function.

- Fix the get/set multiple GPIO lines for a few of the
  funky industrial GPIO cards on the ISA bus.

----------------------------------------------------------------
Govert Overgaauw (1):
      gpio: fix aspeed_gpio unmask irq

Timur Tabi (1):
      gpioib: do not free unrequested descriptors

Uwe Kleine-König (1):
      gpio: fix error path in lineevent_create

William Breathitt Gray (3):
      gpio: pci-idio-16: Fix port memory offset for get_multiple callback
      gpio: pcie-idio-24: Fix port memory offset for
get_multiple/set_multiple callbacks
      gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop

 drivers/gpio/gpio-aspeed.c       |  2 +-
 drivers/gpio/gpio-pci-idio-16.c  |  8 ++++----
 drivers/gpio/gpio-pcie-idio-24.c | 22 +++++++++++-----------
 drivers/gpio/gpiolib.c           |  7 ++++---
 4 files changed, 20 insertions(+), 19 deletions(-)
