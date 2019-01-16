Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2BDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665BE20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394356AbfAPQtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:49:53 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57534 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388272AbfAPQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:49:51 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x0GGIxUE013485;
        Wed, 16 Jan 2019 18:18:59 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id B429962DA4; Wed, 16 Jan 2019 18:48:56 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Cc:     linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 0/2] iio: adc: npcm: add NPCM ADC driver
Date:   Wed, 16 Jan 2019 18:48:53 +0200
Message-Id: <20190116164855.200357-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds Analog-to-Digital Converter (ADC) support 
for the Nuvoton NPCM Baseboard Management Controller (BMC).

The NPCM ADC is a 10-bit converter for eight channel inputs.

The NPCM ADC driver tested on NPCM750 evaluation board.

Addressed comments from:.
 - Jonathan Cameron: https://lore.kernel.org/patchwork/patch/1030483/

Changes since version 2:
 - Return error if clock have not found in the device tree ADC node.
 - Modify regulator order for avoid mixing devm and non-devm path.
 - Modify probe and remove function to have relative ordering.
 				  
Changes since version 1:
 - Add NPCM prefix.
 - Remove unnecessary parameter initialization.
 - Modify read function to avoid racy condition.
 - Reading the reference voltage when needed.
 - Modify dt-binding documentation according Jonathan comments.

Tomer Maimon (2):
  dt-binding: iio: add NPCM ADC documentation
  iio: adc: add NPCM ADC driver

 .../bindings/iio/adc/nuvoton,npcm-adc.txt          |  35 +++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/npcm_adc.c                         | 335 +++++++++++++++++++++
 4 files changed, 381 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-adc.txt
 create mode 100644 drivers/iio/adc/npcm_adc.c

-- 
2.14.1

