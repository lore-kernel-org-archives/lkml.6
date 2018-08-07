Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1576AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE49E216FE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE49E216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbeHGMxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:53:50 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:51969 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726951AbeHGMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:53:50 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w77A8eB1002102;
        Tue, 7 Aug 2018 13:08:41 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id F36CB62EDE; Tue,  7 Aug 2018 13:38:39 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     sboyd@kernel.org, brendanhiggins@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        weiyongjunl@huawei.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, raltherr@google.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v2 0/2] i2c: npcm7xx: new driver for I2C controller
Date:   Tue,  7 Aug 2018 13:38:12 +0300
Message-Id: <20180807103814.29586-1-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuvoton NPCM7XX I2C Controller
NPCM7xx includes 16 I2C contollers. THis driver operates the controller.
This module also includes a slave mode, which will be submitted later on.

Any feedback would be appreciated.  

v2 -> v1:
	- run check patch in strict mode.
	- use linux crc.
	- define regs in constant offset without base.
	- remove debug prints.
	- no declerations for local functions.
	
v1: initial version

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

---
Tali Perry (2):
  dt-binding: i2c: npcm7xx: add binding for i2c controller
  i2c: npcm7xx: add i2c controller master mode only

 .../devicetree/bindings/i2c/i2c-npcm7xx.txt        |   27 +
 MAINTAINERS                                        |    8 +
 drivers/i2c/busses/Kconfig                         |   11 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-npcm7xx.c                   | 2017 ++++++++++++++++++++
 5 files changed, 2064 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
 create mode 100644 drivers/i2c/busses/i2c-npcm7xx.c

-- 
2.14.1

