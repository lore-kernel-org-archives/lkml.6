Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9151AC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9E72184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545607531;
	bh=8lgHAuHPTHwNDrSv9VHMLihBQU0og9heay5nyX/6j64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NY99IbnHSp/Ajqs8MDOnPfCj6zwAzjUtzOPEKsy9jUL2gd5YMqhB6K/GjOx1zvJKv
	 oX3h97yilBhop/tTjEBZif0aNaMrxeneaJI3NE8325NVgyVdu3S30YGGzSfY7N2ETY
	 JRYiTFjkYURiJ8ollra5aH7dr4s5/3z1aWCgwPQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeLWXZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbeLWXZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:25:29 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.82.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066A821783;
        Sun, 23 Dec 2018 23:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545607528;
        bh=8lgHAuHPTHwNDrSv9VHMLihBQU0og9heay5nyX/6j64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcKWVNOQ+zyoeL5NK0sMplY2WCqvKRJRezXQF1I+F7b+fHS4BdgWRgMeUQ4NIFqri
         nVS5j26xI/bLRGrZscmOVRlPNYmwtz7ll5I44Ty96MySJyWzEGHM6P1278ZYwfRgYX
         6flsS6RkM7i7Iz65tUB6qAIUAhX8vFwXXo2RjoXk=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 02/11] ata: make PCI dependency explicit for PATA_ACPI
Date:   Sun, 23 Dec 2018 23:25:11 +0000
Message-Id: <20181223232521.11320-3-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
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

