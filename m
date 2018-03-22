Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754913AbeCVM7k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:59:40 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40964 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754878AbeCVM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:59:34 -0400
X-Google-Smtp-Source: AG47ELuVUpaxHrgsuQ/x27N6SA4SJY1tTjNA3OVrHabP3HhtjfF05cYkhtmYFQ+7pW4+VZVmZW8B8Q==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 0/7] Implement get_multiple for ACCES and PC/104 drivers
Date: Thu, 22 Mar 2018 08:59:18 -0400
Message-Id: <cover.1521723192.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
  - Remove STX104 patch as it has been picked up through the IIO tree
  - Utilize GENMASK for 104-IDIO-16 patch to avoid long literal bitmasks
  - Fix off-by-one errors for port_mask initializations
  - Add end comma to ports arrays initializations for consistency

This patchset implements get_multiple callbacks for the PC104 GPIO
drivers as well as the PCI-IDIO-16 and PCIe-IDIO-24 GPIO drivers. These
devices all acquire the multiple input lines with a single read, so
utilizing the get_multiple callback can provide improvement for those
users who regularly access multiple input lines.

While developing this patchset I noticed many of these devices make use
of Intel 8255 compatible interfaces for their I/O. I may write a generic
8255 GPIO driver in the future to reduce some of the redundant code I
see pop among the drivers for these devices.

William Breathitt Gray (7):
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
 7 files changed, 370 insertions(+)

-- 
2.16.2
