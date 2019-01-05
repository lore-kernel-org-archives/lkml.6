Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52AEC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22E12070C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546682782;
	bh=1P1Ok7Wt3v1Gh0Pm2L2prZg8TyCNC8JxTkx+Azdl/Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WVzFnwGW7FMIVAyYOMg1mFTcDJL+GoPrAJdVCobbGugmaW/k525Hf8oXH19/aOB6Z
	 08csZwuLMC+UMoBvmCMxV4qvUwTnIibY6kHc6JuGZUON0QVPbHoEKtVV5txJ3twPas
	 APYul6op+DiUsAs2x5dycFkK1/QL+rQ44RH278tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfAEKGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfAEKGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:06:20 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.211.55.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9BA2070C;
        Sat,  5 Jan 2019 10:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546682779;
        bh=1P1Ok7Wt3v1Gh0Pm2L2prZg8TyCNC8JxTkx+Azdl/Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4FW5bNJb8MSRQ2R5rMjtXiYcpk/D5qKM97S9l/0E+cOih8YrRQZj8Qsr9zTDIC7q
         Veijhx08nminv9IKoh+ylUUOa8Kr3o31XiAK6d4PeeZLZV7uoIWWt4DIZIGcxW/Heh
         +cjFpxRfbtQng9ePcxxjaaOe7UynKAsW5h9JKfGc=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 07/11] drivers: thermal: int3406_thermal: Make PCI dependency explicit
Date:   Sat,  5 Jan 2019 10:06:02 +0000
Message-Id: <20190105100606.6673-8-okaya@kernel.org>
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

