Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3073020869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545259646;
	bh=aWcTjwG0M0tXcVpMeguGc6UKXBvRw4dLHpCOPViDcAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxKtHgHgWeSDqz/BhynCUuWqt2TUbfxA54c8KxXJu/5z5xSj96DCDRccFxAl/g9BT
	 JSp73QJyQaAsN09p/eX8bB6CQukW+gX3f7UE8+jOedgFuTPxDR396gCmMfojrKbeP8
	 fFnfoBA4ktnS0F5N3feH19gaIjqFjUgU3VBAlAqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeLSWrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbeLSWrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:47:16 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.90.192.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C98E221479;
        Wed, 19 Dec 2018 22:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545259636;
        bh=aWcTjwG0M0tXcVpMeguGc6UKXBvRw4dLHpCOPViDcAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvQe8XKjEsT201dhdEfgct9enBXbQ1sWufAFpNaoj3hzLDJ7fhqq7wfEK8CgqJjPZ
         XlInm+6aAGrxLcZf//UCWWpK3wSoDVTfg/WlwElR+/hfEITw0ul/IirWHa2Fr97mVP
         hx0nzFBqRcYRJC+BZHAyRN7ygQTQhApjbC5y9ktU=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 7/7] ACPI: Make PCI slot detection driver depend on PCI
Date:   Wed, 19 Dec 2018 22:46:59 +0000
Message-Id: <20181219224659.4802-8-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
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

