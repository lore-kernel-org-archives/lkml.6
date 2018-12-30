Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1623C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3BE21738
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199797;
	bh=g7Cwm2qbUlpfAxKHbvhYrTKgy7SVTRnRoBnM0VWotF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+6oLSrroQb7hd7uoDEbncHvkUiKyXktaSsHCgHi3W/JUCF3A1rqG6Ncq95bfQcZo
	 4tNlmg91wfl27YRzz14W8xcdxidJtKLCmCnk1sKCqSF0ASYm7NreCYJcOx7zNPWQpa
	 fip4ypFi+JLWYRyKoyn1SkMov4iUKSLmSSBwahRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeL3T4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbeL3T4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:35 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0042173C;
        Sun, 30 Dec 2018 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199794;
        bh=g7Cwm2qbUlpfAxKHbvhYrTKgy7SVTRnRoBnM0VWotF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yEdmMhZb2Z57jO/yA0kFGKnHqTRIk6HafyDa+J7qKtfgD9XDY9ccKDabKL78/FxfD
         mTpJCC7ZtSzHsHRvBE7bvBl3L2S6kh0pw65vwJbp1DqZXuX6u4nKyPAisoSS1Wswvp
         O6dKMZpu0HqB2xlyF8pWyHaBlqR2XLdX1sxzLWAs=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 11/11] drivers: thermal: int340x_thermal: Make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:12 +0000
Message-Id: <20181230195612.6657-12-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOSF_CORE depends on PCI. This was never mentioned.

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

