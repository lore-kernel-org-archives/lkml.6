Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11711C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D266821783
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545607555;
	bh=BRTTGU/aLmoIg6hWo8Na7f6KbnM4xsqKDC/qFi6J1uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xks2FoZBADEYm6+i48QkGva9S2gFg4lZn+A+x19ICcnQ2wHSKvWVjc8H3uAcJLVTn
	 WOK2ERkppJ5c+B0niyCkze52959jBtY76IsCXdkc+CznUckhxOS2YDGEM/AtF0c6L9
	 U2MfHIfiSBmirjeuZPRB2I4wXJYSlKwcH8kJuOi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeLWXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:25:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbeLWXZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:25:54 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.82.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE54F21783;
        Sun, 23 Dec 2018 23:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545607553;
        bh=BRTTGU/aLmoIg6hWo8Na7f6KbnM4xsqKDC/qFi6J1uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UidwKgu0g3ajWEWspumLywVUUM+173Q5bT4l+x2zRIRlDZSB/+2hpp5WOj0nWu58x
         Kyhahmy0KUp3pMtOkW8UVKyhDcDkS4x9P5oGqB7xmSW0Y/FqgBbBX5JDqu2gnVVr7H
         mAitic/+5YWn+xOpOELuVAVzZE4GbmT8GQHCNBu4=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 11/11] drivers: thermal: int340x_thermal: Make PCI dependency explicit
Date:   Sun, 23 Dec 2018 23:25:20 +0000
Message-Id: <20181223232521.11320-12-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
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

