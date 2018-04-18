Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDRMxJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:53:09 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36721 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753917AbeDRMxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:53:07 -0400
X-Google-Smtp-Source: AIpwx49MKsLbe+qKxCNzRs3R5/55+tQE/M34ubV+YRFSIDv6+JT/7JicZNdPKAj3Idq954BuouLUAA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/2] Fix port memory offsets for IDIO series drivers
Date: Wed, 18 Apr 2018 08:52:39 -0400
Message-Id: <cover.1524000042.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO PCI-IDIO-16 and PCIE-IDIO-24 drivers utilize the ioread8 and
iowrite8 functions to interact with their devices' respective I/O
registers. To simplify the get_multiple/set_multiple callbacks, a local
array 'ports' is used to hold the memory address offsets of the
respective device I/O registers.

Currently the get_multiple callback in the GPIO PCI-IDIO-16 driver, and
the get_multiple/set_multiple callbacks in the GPIO PCIE-IDIO-24 driver,
incorrectly pass the memory address of the local 'ports' array elements
to the respective ioread8/iowrite8 functions when they should instead
pass the necessary device I/O register memory offset. This patch fixes
this error by supplying the correct intended memory addresses to these
functions.

William Breathitt Gray (2):
  gpio: pci-idio-16: Fix port memory offset for get_multiple callback
  gpio: pcie-idio-24: Fix port memory offset for
    get_multiple/set_multiple callbacks

 drivers/gpio/gpio-pci-idio-16.c  |  8 ++++----
 drivers/gpio/gpio-pcie-idio-24.c | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.16.2
