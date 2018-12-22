Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DE9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8975F21927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437725;
	bh=DaAzHAai168wXP+15NGa1LCxICl+yYOaLMUe34V9F5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KOK1E9krsmI4we5qapK/uhlt73GAg2UdIZdn1ShCF77/YTvdyUeOgJ6VwbrU2HKFJ
	 f7TQTHcaR65WpM/DVXyu50PWJ8VjzbhvmR09GvuqPtHPActXWEshtsJhI/457ISqF5
	 d47l1nVjaJKecFAhDvSIBdkZNcujo5T8QJCNDeog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404771AbeLVAPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404751AbeLVAPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:19 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04FCE21970;
        Sat, 22 Dec 2018 00:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437718;
        bh=DaAzHAai168wXP+15NGa1LCxICl+yYOaLMUe34V9F5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEJrZddYkCMW7yMJa5iqTxb0AM9fjnKDFCwGPvoR6LoHBoEgB2jV2K78ooOBJwM9J
         yBOE0XSmHFzLauS8yjWFvr3iMnNXpiNuqY39fPKUMUTp1K0Zz3jXuPhTd8SlihyIhZ
         MQKnXFoCVJV7r041Ah/jLwYNmU1hhgx6O6OagjAs=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 11/11] drivers: thermal: Make PCI dependency explicit
Date:   Sat, 22 Dec 2018 00:14:52 +0000
Message-Id: <20181222001452.7474-12-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOSF_CORE depends on PCI. This was never mentioned.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index 0582bd12a239..0ca908d12750 100644
--- a/drivers/thermal/intel/int340x_thermal/Kconfig
+++ b/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -4,7 +4,7 @@
 
 config INT340X_THERMAL
 	tristate "ACPI INT340X thermal drivers"
-	depends on X86 && ACPI
+	depends on X86 && ACPI && PCI
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
-- 
2.19.0

