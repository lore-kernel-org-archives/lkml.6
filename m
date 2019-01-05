Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DD5C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCB521874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546682773;
	bh=CIZPvz2pxw0T1ievRoUSgQlu2J4eAlsxbA5VjoOo5p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VxiBepWH03sFvITGcDX6HHaGldXMq7j6KkJHszR3b6CZtTvj19VDc6VwHAusJT/vY
	 GlH7e6rPEcIQswlKHnBrnTltAusL6aRG8/GKQtjx1y7TVWhSCQyp7RvtrCohmgMDQo
	 k5NNZuHvAwCA1ygS0T1j8Xw4mr5ccGW4P7EOV5gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfAEKGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfAEKGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:06:11 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.211.55.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D178B2070C;
        Sat,  5 Jan 2019 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546682771;
        bh=CIZPvz2pxw0T1ievRoUSgQlu2J4eAlsxbA5VjoOo5p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x7HfB4ULMUF+2OSRWU6bd80mdfZSh4DcMyJl0P/twLJZsRVE89M/JS6ZV2B/+3Qdf
         fO3haYQxBYwlOU+EyF0QPylpGZ0aNAsdIPe/NZcAlgetFNW6pOQLu1kQtwxo/rP0w5
         FuyiFYFsvvOsneUiOEy2JUHArYv9/l80lZxX/+Lw=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 02/11] ata: pata_acpi: Make PCI dependency explicit
Date:   Sat,  5 Jan 2019 10:05:57 +0000
Message-Id: <20190105100606.6673-3-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190105100606.6673-1-okaya@kernel.org>
References: <20190105100606.6673-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. PATA_ACPI is a PCI device driver but the PCI
dependency has not been explicitly called out.

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

