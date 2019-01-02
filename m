Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25729C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF6B21901
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546452668;
	bh=y0zaYuwHFiord5xn//ilPDiJ3f6NYfpX7zlwnEDJrPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ysZ26dETjG0uomashNgCS5FGcYL+VSI7N5G5EV8KSnSNjkbrJR2ovfMb6SrPa7TZS
	 +h8dox85BNL19RN+gesjRmbPligcjtC+wclY57z0t2gNT1eizHWPJkBnbcZwBFXWUa
	 I2iYuT0EM0Zv6ZfUtuDspdGCTBI1xa+EuNHmW+mY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfABSLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfABSLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:11:04 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [137.117.71.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295E621900;
        Wed,  2 Jan 2019 18:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546452663;
        bh=y0zaYuwHFiord5xn//ilPDiJ3f6NYfpX7zlwnEDJrPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U77lDLxhEUOa9QFew7xOmPOYADUvU2e8s9IFKGoqZlVcdCVgRlsZv1u/3/DldpOXT
         auRLdA+e1PrGI/qlvRTgYhAZfdgd8sXc5qjqNfQ8ZlvhlvAZx0JLDtHkRV1Tr4WGLP
         xi8BmEi1u7WxX17wl3CvjVA3jbr7UMnuUhWP5c5k=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 11/11] drivers: thermal: int340x_thermal: Make PCI dependency explicit
Date:   Wed,  2 Jan 2019 18:10:38 +0000
Message-Id: <20190102181038.4418-12-okaya@kernel.org>
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

