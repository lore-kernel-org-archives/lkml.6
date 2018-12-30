Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49FEC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EAC21019
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199779;
	bh=J1DQuM2S5fz8iZUdLyez2iBKoXNdJkY6Zek4cIDgazI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TRzTmQWMqr/VL7APv0YvIqyNGr/pvzxCwwDGDm6o0ggupF6dSS04RRDFz4IFzkTRO
	 umKYYC5LfKWRoIAQ/hr4fA56NO/FkN0TeZZn3t71IWTD+Yw2wMhVhw+dWGQpldNjQI
	 wnQz5f92cTJkYh2AyqMtUYUNETzqVG9Mfd9ztjow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeL3T4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeL3T4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:17 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050EF2070D;
        Sun, 30 Dec 2018 19:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199776;
        bh=J1DQuM2S5fz8iZUdLyez2iBKoXNdJkY6Zek4cIDgazI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PErKFpkPL0VRDTbEqWsiUrDp2/izswofSFJnOjiltrdP/ZobFn5/ci3OfITF0OGmU
         o5xaJw696z7HszyI5dJm+ImtLqh7OY4iWxSEGH2dCIeTlrpRz5LHhAHgEdc6jt9RW2
         D6pWZ5lepFjqs3g5N+LoZu0878yH00tl0SpiTPUc=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 02/11] ata: pata_acpi: Make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:03 +0000
Message-Id: <20181230195612.6657-3-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATA_ACPI is a PCI device driver but the PCI dependency has not been
explicitly called out.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4ca7a6b4eaae..8218db17ebdb 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1091,7 +1091,7 @@ comment "Generic fallback / legacy drivers"
 
 config PATA_ACPI
 	tristate "ACPI firmware driver for PATA"
-	depends on ATA_ACPI && ATA_BMDMA
+	depends on ATA_ACPI && ATA_BMDMA && PCI
 	help
 	  This option enables an ACPI method driver which drives
 	  motherboard PATA controller interfaces through the ACPI
-- 
2.19.0

