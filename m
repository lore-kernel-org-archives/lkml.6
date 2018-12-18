Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2335FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A372145D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545101814;
	bh=aWcTjwG0M0tXcVpMeguGc6UKXBvRw4dLHpCOPViDcAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cixgjPaJwFRd5kzikANS+SkYwwZnzJi7iKK7b/8pStHEW4kNnOtGPkr5rZnc+GbKN
	 NOElxU5Lha9thCBG27FcyD5G/Q6BRZk+xTTVJ/4HsW0hTG1zYWbJ7fb+8YFsqEh4UN
	 FoVrpYkI3QZ3L5AUggdKY+GTPWgoGzMSZGtI2f58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeLRC4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbeLRC4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:56:21 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.210.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8966C21841;
        Tue, 18 Dec 2018 02:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545101781;
        bh=aWcTjwG0M0tXcVpMeguGc6UKXBvRw4dLHpCOPViDcAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmEY8DyrIwiD3aRd/ycaLJh+CqVIvsSIuyJ3bVUJyG9bmFzGO7R2C+E/OX99Huf7T
         DkeEw4u5mzOKdcnJeZvVj3DVLa5h6DIJW3KO+otQp/4mn8KEFICTfilAzR1xHhzU0a
         L8S0XG8oMbH1JctFtwfOBHAT6SzZ3wMmGw1kTW7A=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 7/7] ACPI: Make PCI slot detection driver depend on PCI
Date:   Tue, 18 Dec 2018 02:56:06 +0000
Message-Id: <20181218025606.32668-8-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181218025606.32668-1-okaya@kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this is ACPI PCI slot detection driver for PCI, it doesn't make sense
to compile this without PCI support in place.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a0abcb3bd673..8b6ff80a69cd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -369,7 +369,7 @@ config ACPI_DEBUG
 
 config ACPI_PCI_SLOT
 	bool "PCI slot detection driver"
-	depends on SYSFS
+	depends on SYSFS && PCI
 	help
 	  This driver creates entries in /sys/bus/pci/slots/ for all PCI
 	  slots in the system.  This can help correlate PCI bus addresses,
-- 
2.19.0

