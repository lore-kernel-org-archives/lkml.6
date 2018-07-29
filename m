Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A3FA3734
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD50F20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD50F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeG2Kqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 06:46:46 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:51500 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726022AbeG2Kqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 06:46:45 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w6T8j6eO010350;
        Sun, 29 Jul 2018 11:45:06 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 339F363129; Sun, 29 Jul 2018 12:15:05 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     tali.perry1@gmail.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        venture@google.com, yuenn@google.com, brendanhiggins@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, arnd@arndb.de, wsa@the-dreams.de,
        andriy.shevchenko@linux.intel.com, pierre-yves.mordret@st.com,
        cedric.madianga@gmail.com, baolin.wang@spreadtrum.com,
        jarkko.nikula@linux.intel.com, hdegoede@redhat.com,
        rmk+kernel@armlinux.org.uk, ard.biesheuvel@linaro.org,
        thor.thayer@linux.intel.com, geert@linux-m68k.org,
        heikki.krogerus@linux.intel.com, tglx@linutronix.de
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] i2c: npcm7xx: new driver for I2C controller
Date:   Sun, 29 Jul 2018 12:14:47 +0300
Message-Id: <20180729091449.385951-1-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuvoton NPCM7XX I2C Controller
NPCM7xx includes 16 I2C contollers. THis driver operates the controller.
This module also includes a slave mode, which will be submitted later on.

Any feedback would be appreciated.  


Signed-off-by: Tali Perry <tali.perry1@gmail.com>


---
Tali Perry (2):
  dt-binding: i2c: npcm7xx: add binding for i2c controller
  i2c: npcm7xx: add i2c controller master mode only

 .../devicetree/bindings/i2c/i2c-npcm7xx.txt        |   27 +
 MAINTAINERS                                        |    9 +
 drivers/i2c/busses/Kconfig                         |   11 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-npcm7xx.c                   | 2574 ++++++++++++++++++++
 5 files changed, 2622 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
 create mode 100644 drivers/i2c/busses/i2c-npcm7xx.c

-- 
2.14.1

