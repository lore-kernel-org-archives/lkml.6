Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446C8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072D420875
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072D420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933356AbeGJM46 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:56:58 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:35218 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754260AbeGJM44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:56:56 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w6ACu5kO025317;
        Tue, 10 Jul 2018 15:56:08 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 8B47E62ED5; Tue, 10 Jul 2018 15:56:05 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] pinctrl: nuvoton: add driver for NPCM7xx
Date:   Tue, 10 Jul 2018 15:56:02 +0300
Message-Id: <20180710125604.14458-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds pinmux and GPIO controller for the Nuvoton
NPCM750/730/715/705 Baseboard Management Controller (BMC).

The Nuvoton BMC NPCM750/730/715/705 Pinmux functions accessible
only for pin groups and pinconf parameters available only for 
individual pins.

The Nuvoton BMC NPCM750/730/715/705 has eight identical GPIO 
modules, each module has 32 GPIO ports.

Most of the GPIO ports are multiplexed with other system functions.

The NPCM7xx pinctrl and GPIO driver tested on NPCM750 evaluation board.

Tomer Maimon (2):
  dt-binding: pinctrl: Add NPCM7xx pinctrl and GPIO documentation
  pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver

 .../bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt   |  216 ++
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/nuvoton/Kconfig                    |   13 +
 drivers/pinctrl/nuvoton/Makefile                   |    4 +
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          | 2086 ++++++++++++++++++++
 6 files changed, 2321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt
 create mode 100644 drivers/pinctrl/nuvoton/Kconfig
 create mode 100644 drivers/pinctrl/nuvoton/Makefile
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c

-- 
2.14.1

