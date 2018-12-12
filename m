Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C3FC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4E520870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544635198;
	bh=2QQMOUZlNsKsy/dGrd7PrT/v3LUklYUweqAGijngjqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdZ2LWF2pETn+z8SEMn7ZfDKtFvVwfk1Eqgvlu/qnmGTYaI6xOr6MGVxHdPIWhJ4b
	 LSVtGLBBrKwbpf9YLdseHIn3svUPbIuLmWrV9RYndaMxz/4v14EZAx/5hdWhHWz0zF
	 psxSkwmdRQFlVcBvDVf/Fqj8FTbMZynVHRLdXNfI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4E520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeLLRT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbeLLRTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:19:53 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.121.85.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D002086D;
        Wed, 12 Dec 2018 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544635192;
        bh=2QQMOUZlNsKsy/dGrd7PrT/v3LUklYUweqAGijngjqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0xTX3PLDXJFCLzojxE8ntSudwpMJIGhdDA1rKM6xJrt53ZM7g38IwIA7LUPbi9ib
         YBcBNoZt+W53pWE8+AF8bKce3LsPlMpLW8K9w+OsqofaLTYlwxzPsZeCtmiB1BLX44
         tHOrcziNqFMx8L5pUPZ9Rf3Z4rSBaSVnnLwFwkjw=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        devel@acpica.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is unset
Date:   Wed, 12 Dec 2018 17:19:40 +0000
Message-Id: <20181212171941.7437-6-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181212171941.7437-1-okaya@kernel.org>
References: <20181212171941.7437-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we allow CONFIG_PCI to be unset, remove useless code from ACPICA
too.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/acpica/Makefile  | 2 +-
 drivers/acpi/acpica/achware.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index b14621da5413..59700433a96e 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -77,13 +77,13 @@ acpi-y +=		\
 	hwacpi.o	\
 	hwesleep.o	\
 	hwgpe.o		\
-	hwpci.o		\
 	hwregs.o	\
 	hwsleep.o	\
 	hwvalid.o	\
 	hwxface.o	\
 	hwxfsleep.o
 
+acpi-$(CONFIG_PCI) += hwpci.o
 acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
 acpi-y +=		\
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 43ce67a9da1f..1c827184fe64 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 /*
  * hwpci - PCI configuration support
  */
+#ifdef CONFIG_PCI
 acpi_status
 acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		      acpi_handle root_pci_device, acpi_handle pci_region);
+#else
+static inline acpi_status
+acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id, acpi_handle root_pci_device,
+		      acpi_handle pci_region)
+{
+	return AE_SUPPORT;
+}
+#endif
 
 #endif				/* __ACHWARE_H__ */
-- 
2.19.0

