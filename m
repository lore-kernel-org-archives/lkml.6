Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeDHOEG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 10:04:06 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:59563 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751601AbeDHOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 10:04:04 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arm@kernel.org, linux@armlinux.org.uk, avifishman70@gmail.com,
        brendanhiggins@google.com, venture@google.com, yuenn@google.com,
        joel@jms.id.au
Cc: arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/1] arm: npcm: enable L2 cache in NPCM7xx architecture
Date: Sun,  8 Apr 2018 17:03:16 +0300
Message-Id: <1523196197-2072-1-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch Enable ARM L2 cache module in Nuvoton NPCM7xx BMC
by adding L2 cache parameters into NPCM7xx DT machine start structure.

At patch V7 arm: npcm: add basic support for Nuvoton BMCs we got comments
regarding the flags use in L2 cache module.
- https://www.spinics.net/lists/arm-kernel/msg613212.html

After checking again the L2 cache use in the NPCM7xx,
the only L2 cache flag we need to set is L2C_AUX_CTRL_SHARED_OVERRIDE 
and it is done in the device tree:
https://patchwork.kernel.org/patch/10063497/

L2 cache flag mask allowed all the flag option.

Tomer Maimon (1):
  arm: npcm: enable L2 cache in NPCM7xx architecture

 arch/arm/mach-npcm/npcm7xx.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.14.1
