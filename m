Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeC2EbZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:31:25 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:32904 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751215AbeC2EbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:31:24 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] mfd: axp20x: driver cleanup
Date: Thu, 29 Mar 2018 12:31:12 +0800
Message-Id: <20180329043115.7132-1-wens@csie.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Here are some cleanup patches for the axp20x mfd driver.

Patch 1 const-ifies all the struct mfd_cell and struct resource
instances found throughout the driver. Not sure why they weren't
set to const before.

Patch 2 replaces all the openly declared interrupt resources with
nice to read one-line DEFINE_RES_IRQ macros.

Patch 3 corrects the prefix for four of the AXP806 interrupt enums.
"POK" was incorrectly expanded to "PWROK".

These are all simple cleanups. No functionality is changed.

Regards
ChenYu

Chen-Yu Tsai (3):
  mfd: axp20x: Const-ify struct mfd_cell and struct resource
  mfd: axp20x: Use DEFINE_RES_IRQ to declare resources for mfd_cells
  mfd: axp20x: Correct AXP806 POK interrupt prefix

 drivers/mfd/axp20x.c       | 239 +++++++++++----------------------------------
 include/linux/mfd/axp20x.h |  10 +-
 2 files changed, 61 insertions(+), 188 deletions(-)

-- 
2.16.3
