Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D98EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA096218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546452680;
	bh=1P1Ok7Wt3v1Gh0Pm2L2prZg8TyCNC8JxTkx+Azdl/Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yap+dyYAJyjwGyG9TR8jShNdf/C81YNFAejFIXY1YCs5l+FN/nGwtZtZCONGJK/Y3
	 xqxIJcaJALji7P7nnVgu2bzZZ4pZsGynds/M7n0ZpO1NCbXAQml2SqbEMSbs81s9eb
	 Rppa0PWamX4bXhF2WJU+6vhvTTL/srGnUEm+CkK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfABSK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfABSKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:10:55 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [137.117.71.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1134218D3;
        Wed,  2 Jan 2019 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546452654;
        bh=1P1Ok7Wt3v1Gh0Pm2L2prZg8TyCNC8JxTkx+Azdl/Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqJYN+3Prx9gkqO8jfvN4LJOkGHpv/TSEjt9XinzAk/TLhSedygWEGnK69SRdwuMb
         vdP+jiWC3RJJEnroFheU/U+B3U72SdjeuKmpKzUapvyxVt1VThYpBvpGNHHILRntKE
         UzdFT84DBi7ls997AABFSEBeuW3seOOOVugQbJVU=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 07/11] drivers: thermal: int3406_thermal: Make PCI dependency explicit
Date:   Wed,  2 Jan 2019 18:10:34 +0000
Message-Id: <20190102181038.4418-8-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190102181038.4418-1-okaya@kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
satisfied implicitly through dependencies on CONFIG_ACPI have to be
specified directly. Need CONFIG_PCI to be set in order to be able to use
this driver.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 0582bd12a239..fba1976d5f8d 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -31,7 +31,7 @@ if INT340X_THERMAL
 
 config INT3406_THERMAL
 	tristate "ACPI INT3406 display thermal driver"
-	depends on ACPI_VIDEO
+	depends on ACPI_VIDEO && PCI
 	help
 	  The display thermal device represents the LED/LCD display panel
 	  that may or may not include touch support. The main function of
-- 
2.19.0

