Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28172C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10AB2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544592267;
	bh=NxWMulNp5HIF+g+00rhyYaHLbNqHyNqOwy7XO+a4zT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fs1Oi9BrVLeTtYv6AZwzOkxAQbKUJebjASIIP8NCJnErFkpeTpBzRPPgKStS9GRId
	 oXOA4RGiEW4cc6ZCf7bs6jJBD2UeUXkcbL/uonevEYVQQZgR4/6pz0935OfF6erZ+G
	 D0z4GsBC+6vJVBTp1xNQRNVVZlw1DotGbOKF09Yw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10AB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLLFYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeLLFYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:24:21 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.78.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7772086D;
        Wed, 12 Dec 2018 05:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544592261;
        bh=NxWMulNp5HIF+g+00rhyYaHLbNqHyNqOwy7XO+a4zT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6ZvAuGWoiL7+eOLCggLuwH3MAV/sDWVan5tFFk28fwVwLiCLqWTecCUkCVTKe5Xl
         CO1o4wcRnVtyK1G2UfvZXe/GDeRqz1Wzx54Zr4c5cxf6QI29WseNyxzlQeQbkhRL1l
         SA/x25OuC+MNxfpMJDH2yS8pgvusEef1tdGFPmQI=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        devel@acpica.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/4] ACPI / OSL: Remove PCI bits from ACPICA when CONFIG_PCI is unset
Date:   Wed, 12 Dec 2018 05:23:59 +0000
Message-Id: <20181212052359.31808-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181212052359.31808-1-okaya@kernel.org>
References: <20181212052359.31808-1-okaya@kernel.org>
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
 drivers/acpi/acpica/Makefile | 2 +-
 drivers/acpi/osl.c           | 9 +++++++++
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
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7b1e58f93f37..8b8eb17df3f2 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1837,3 +1837,12 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state,
 					       reg_a_value, reg_b_value);
 	return status;
 }
+
+#ifndef CONFIG_PCI
+acpi_status acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
+		      acpi_handle root_pci_device, acpi_handle pci_region)
+{
+	return AE_SUPPORT;
+}
+#endif
+
-- 
2.19.0

