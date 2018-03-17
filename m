Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeCQPtt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 11:49:49 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37560 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbeCQPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 11:49:46 -0400
X-Google-Smtp-Source: AG47ELtSZNV+Yop/bBax2o7fnSkLZ3SxftJ23VHR2tXpRzS5z69cVZ2OWvMQgcMTGlol5ONxY1YpfA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 0/8] Implement get_multiple for ACCES and PC/104 drivers
Date: Sat, 17 Mar 2018 11:49:39 -0400
Message-Id: <cover.1521301345.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
  - Add missing bitmap.h header includes
  - Fix typographical error in symbol name for word_mask
  - Remove const qualifier for ports array

This patchset implements get_multiple callbacks for the PC104 GPIO
drivers as well as the PCI-IDIO-16 and PCIe-IDIO-24 GPIO drivers. These
devices all acquire the multiple input lines with a single read, so
utilizing the get_multiple callback can provide improvement for those
users who regularly access multiple input lines.

While developing this patchset I noticed many of these devices make use
of Intel 8255 compatible interfaces for their I/O. I may write a generic
8255 GPIO driver in the future to reduce some of the redundant code I
see pop among the drivers for these devices.

William Breathitt Gray (8):
  iio: stx104: Implement get_multiple callback
  gpio: 104-idio-16: Implement get_multiple callback
  gpio: pci-idio-16: Implement get_multiple callback
  gpio: pcie-idio-24: Implement get_multiple/set_multiple callbacks
  gpio: 104-dio-48e: Implement get_multiple callback
  gpio: 104-idi-48: Implement get_multiple callback
  gpio: gpio-mm: Implement get_multiple callback
  gpio: ws16c48: Implement get_multiple callback

 drivers/gpio/gpio-104-dio-48e.c  |  47 ++++++++++++++++
 drivers/gpio/gpio-104-idi-48.c   |  47 ++++++++++++++++
 drivers/gpio/gpio-104-idio-16.c  |  15 +++++
 drivers/gpio/gpio-gpio-mm.c      |  47 ++++++++++++++++
 drivers/gpio/gpio-pci-idio-16.c  |  50 +++++++++++++++++
 drivers/gpio/gpio-pcie-idio-24.c | 117 +++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-ws16c48.c      |  47 ++++++++++++++++
 drivers/iio/adc/stx104.c         |  11 ++++
 8 files changed, 381 insertions(+)

-- 
2.16.2
