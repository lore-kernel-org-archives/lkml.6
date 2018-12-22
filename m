Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A95C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EDA21934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437705;
	bh=8lgHAuHPTHwNDrSv9VHMLihBQU0og9heay5nyX/6j64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mw+s1T0fFqcsKly0aPwpkQQWkQ/XvadqVvnPzGOEcRUg1r/tBDJ73c+lPwMjGvIRq
	 cCjp39LZYdbr3wscAyZprizbgKISj7LJdPtJJpkXrB2wA26v1ZL0vV+pReXFFouD39
	 oUDKmihxgOCilsQMIsIEjSl2pED5pl2bxuoS+Eb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392249AbeLVAPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390874AbeLVAPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:01 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653332192C;
        Sat, 22 Dec 2018 00:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437700;
        bh=8lgHAuHPTHwNDrSv9VHMLihBQU0og9heay5nyX/6j64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOINaB9SjQts0rQnoDCD8LjavDu4nB8rW8uJ/gqkpi7mdI7Dq4Re2IdWJGkm4GB8e
         csmYQcANr0tBr4WobPCNe8aGTyVMcSr8klnJCz3qIa5g+QaljMHoPn9Zlrb85Kj2dX
         uslTX77Sa3NQE78yEBV2WlnNECDaZs4X+LChlt9I=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 02/11] ata: make PCI dependency explicit for PATA_ACPI
Date:   Sat, 22 Dec 2018 00:14:43 +0000
Message-Id: <20181222001452.7474-3-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATA_ACPI is a PCI device driver but the PCI dependency has not been
explicitly called out.

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

