Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B3CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14A02098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14A02098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934218AbeGDJPJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:15:09 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:34960 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932548AbeGDJPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:15:05 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w649ESbZ017180;
        Wed, 4 Jul 2018 12:14:28 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5EAD36307B; Wed,  4 Jul 2018 12:14:28 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arnd.de,
        gregkh@linuxfoundation.org, avifishman70@gmail.com,
        yuenn@google.com, brendanhiggins@google.com, venture@google.com,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] misc: Add NPCM7xx LPC BPC driver support
Date:   Wed,  4 Jul 2018 12:14:25 +0300
Message-Id: <20180704091427.409971-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds BIOS Post code (BPC) support for the
Nuvoton NPCM7xx Baseboard Management Controller (BMC).

Nuvoton BMC NPCM7xx BIOS Post Code (BPC) monitoring two
configurable I/O addresses written by the host on the
Low Pin Count (LPC) bus, the capure data stored in 128-word FIFO.

NPCM7xx BPC can support capture double words.

I have created new folder (bmc) in the documentation/devicetree/binding
for BMC miscellaneous modules that are not represented in the
binding folder.

The NPCM7xx BPC driver tested on NPCM750 evaluation board.

Tomer Maimon (2):
  dt-binding: bmc: Add NPCM7xx LPC BPC documentation
  misc: npcm7xx: add NPCM7xx LPC BPC driver

 .../devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt    |  26 ++
 drivers/misc/Kconfig                               |   8 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/npcm7xx-lpc-bpc.c                     | 348 +++++++++++++++++++++
 4 files changed, 383 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bmc/npcm7xx-lpc-bpc.txt
 create mode 100644 drivers/misc/npcm7xx-lpc-bpc.c

-- 
2.14.1

