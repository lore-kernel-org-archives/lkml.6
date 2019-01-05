Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC431C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B726218E0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546682793;
	bh=y0zaYuwHFiord5xn//ilPDiJ3f6NYfpX7zlwnEDJrPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PyFpCurd/slCOBXbVJbebbhUdgIXphFoR0Coevyhup6AO+ob0gAdR9Zo+/uqSjlH/
	 SL2qZ2BpW5o2R7NuBtMhlDb22mzVJLdthWNvHctPYkcbUg/N5g0ATn8Cq4ejDOpes4
	 f/mr6+fD0OcEQdt2sZUCBlZsBsPHPO5BeSmS0nos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbfAEKGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfAEKGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:06:30 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.211.55.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814D5218EA;
        Sat,  5 Jan 2019 10:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546682789;
        bh=y0zaYuwHFiord5xn//ilPDiJ3f6NYfpX7zlwnEDJrPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O75gFjIi55z7MOtxwdAFUk8v2YkmYack+ItYIikHmT4uAKINynOOMU/fmhG8+g7VH
         R380Brp7Tu1T6P+Bt5k7DCJpKzkgJSsP28mCpiofLgAfGml8QerKALOoaxfLQ1OZ17
         scfU+YX8Ki8+UlOzbdh+VSQ8NwPp771cmHm8TPN4=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 11/11] drivers: thermal: int340x_thermal: Make PCI dependency explicit
Date:   Sat,  5 Jan 2019 10:06:06 +0000
Message-Id: <20190105100606.6673-12-okaya@kernel.org>
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
specified directly. IOSF_CORE depends on PCI. For this reason, add a
direct dependency on CONFIG_PCI.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig b/drivers/thermal/intel/int340x_thermal/Kconfig
index fba1976d5f8d..2acddf8fb314 100644
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

