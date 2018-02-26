Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbeBZOhR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:37:17 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57341 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753328AbeBZOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:37:06 -0500
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, avifishman70@gmail.com, brendanhiggins@google.com,
        joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 0/2] clocksource: npcm: add NPCM7xx timer driver
Date: Mon, 26 Feb 2018 16:36:07 +0200
Message-Id: <1519655769-25836-1-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed comments from:.
 - Brendan Higgins: https://www.spinics.net/lists/devicetree/msg202331.html

Changes since version 3:
 - Modify prefix to npcm7xx_
 - Modify licensing to SPDX license format

Changes since version 2:
 - The shutdown function called oneshot function that can cause a crash in the system,
   Modify shutdown call to unique shutdown function.
 - Adding support to resume function
 - Using timer-of.c API
 - Modify NPCM750 compatible name.

Changes since version 1:
 - Rename driver name
 - Removing unnecessary dependencies in configuration
 - Adding prefix to the macros
 - No changes to dt-binding documentation since v1
 
Modified driver have been tested on the NPCM750 evaluation board.
 
Tomer Maimon (2):
  dt-binding: timer: document NPCM7xx timer DT bindings
  clocksource: npcm: add NPCM7xx timer driver

 .../bindings/timer/nuvoton,npcm7xx-timer.txt       |  25 +++
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/npcm7xx-timer.c                | 237 +++++++++++++++++++++
 4 files changed, 271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
 create mode 100644 drivers/clocksource/npcm7xx-timer.c

-- 
2.14.1
