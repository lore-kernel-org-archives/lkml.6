Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF3BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E221783
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545607568;
	bh=vEwUBRXYeFDT5BTYdkZf3Q9sxL9swg6u6mI4fiLpxMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tn6aezsUakxFUSTaueKSkPFZU2+OvIHk4GxAOaihM1xMDoSuG0EKXVlScg986FenN
	 AvShRfO3M4/AM/sNeJqogqdx44URasW5Lg225T8fg6XuiuYgtTlIDoViSYGMThJyI2
	 aKOYhAsso96jbZrpjy3kXGfltQn2SxSAJlt0crvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeLWXZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:25:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeLWXZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:25:40 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.82.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E027B218A3;
        Sun, 23 Dec 2018 23:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545607539;
        bh=vEwUBRXYeFDT5BTYdkZf3Q9sxL9swg6u6mI4fiLpxMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRsxSXd7+1KTnTl2/L5Do6vF9vtoF79cdAVk6VEJzwbBglSWChuTG64giSoNRbiFE
         IIV9PTKLc4UwAnmt5tsWRz6xiuGlCIfJJyl9zGrnuo48b8yFo7RDQ8zJKbyTNTy6Tn
         PiXr63UasHmXvhLD8SNHfoTRXdz3WTbZlpXR7VcA=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 07/11] drivers: thermal: int3406_thermal: Make PCI dependency explicit
Date:   Sun, 23 Dec 2018 23:25:16 +0000
Message-Id: <20181223232521.11320-8-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need CONFIG_PCI to be set in order to be able to use this driver.

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

