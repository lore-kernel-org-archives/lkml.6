Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeBENDR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:03:17 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42649 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeBENDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:03:10 -0500
X-Google-Smtp-Source: AH8x226c8SIJsJckLhlI7SNy7ytnRXE7AaTKyfuawnsyXfCHliTJw/BZTZS9DX0ta9VMOTYm07kDbA==
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v4.16-rc1
Date: Mon,  5 Feb 2018 14:03:05 +0100
Message-Id: <20180205130305.25069-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.16-rc1

for you to fetch changes up to bccaa3f917c90917a758020dfbdd9027290a7c4e:

  pwm: meson: Add clock source configuration for Meson-AXG (2017-12-05 09:51:36 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.16-rc1

The Meson PWM controller driver gains support for the AXG series and a
minor bug is fixed for the STMPE driver.

To round things off, the class is now set for PWM channels exported via
sysfs which allows non-root access, provided that the system has been
configured accordingly.

----------------------------------------------------------------
Axel Lin (1):
      pwm: stmpe: Fix wrong register offset for hwpwm=2 case

Gottfried Haider (1):
      pwm: Set class for exported channels in sysfs

Jian Hu (2):
      dt-bindings: pwm: Update bindings for the Meson-AXG
      pwm: meson: Add clock source configuration for Meson-AXG

 .../devicetree/bindings/pwm/pwm-meson.txt          |  2 ++
 drivers/pwm/pwm-meson.c                            | 26 ++++++++++++++++++++++
 drivers/pwm/pwm-stmpe.c                            |  2 +-
 drivers/pwm/sysfs.c                                |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)
