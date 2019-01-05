Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42104C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E769218E0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546682822;
	bh=Efw2OfdMaI4OlXDoBZtn3U3Zp109luskemhVZDJgOQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTakFmbcI2UNVQse63IJj1tjqsADItRjop5TEGmkboQgGLyxwP3/XKFvOI4fBLGuk
	 EhSbQFLUzicqXYOvbMgMH53nMPFEcJd23xDXi7GnigpuD5KlEwsMLbFsXtXvFEW6lz
	 myjGeasPMDB/mAr82+wtFehp9YHUKyi8lhoCUYhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfAEKHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfAEKGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:06:14 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.211.55.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F392070C;
        Sat,  5 Jan 2019 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546682773;
        bh=Efw2OfdMaI4OlXDoBZtn3U3Zp109luskemhVZDJgOQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXbOh1WFgKS506Pe47TYD1ON3PkLm0SQ0R1q6XXMIvBWoxvfR84dTlYDQfL11r3ki
         2hMBk81KYlIb3g1/FYP3GCdzHPoOu72VZpwm0c3hPzN4T+O7a046mRF+sgXEKePKsE
         y4grhBeMaah/prhPgH6SYb1922vq0g7jN/AON8ck=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 04/11] platform/x86: intel_ips: make PCI dependency explicit
Date:   Sat,  5 Jan 2019 10:05:59 +0000
Message-Id: <20190105100606.6673-5-okaya@kernel.org>
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
specified directly. Ipss driver is a PCI device driver but this has
not been mentioned anywhere in Kconfig.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e3b62c2ee8d1..b36ea14b41ad 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1009,7 +1009,7 @@ config INTEL_MFLD_THERMAL
 
 config INTEL_IPS
 	tristate "Intel Intelligent Power Sharing"
-	depends on ACPI
+	depends on ACPI && PCI
 	---help---
 	  Intel Calpella platforms support dynamic power sharing between the
 	  CPU and GPU, maximizing performance in a given TDP.  This driver,
-- 
2.19.0

