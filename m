Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB9CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925EA218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546452693;
	bh=QfyRUBwFAspB6gbxthZq15JkY/m5LPs4XHdcBSGWXWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2f8D+JWsPEIex2Oq6p65oxevV4oAlmSisUtGz0y505zCQ8QI1mjpvNODCwMZ03F+M
	 SORXW2v4JOKiexjwnSwAB6LtidloSGbzDRq0R2HqPsZHtnSpATM0fbn3we7CW22GKR
	 4L0hF1bfzAiJ7MrhMIpht5keV7hDSdywH86/PJMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfABSLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:11:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfABSKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:10:47 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [137.117.71.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFDD3218FF;
        Wed,  2 Jan 2019 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546452646;
        bh=QfyRUBwFAspB6gbxthZq15JkY/m5LPs4XHdcBSGWXWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3TphT65WYb/bLDmb5fcnAnv5bShyTnW2MZc18ZomcB9HD0v7xkxmOch89RWNBQUL
         APsD+3TnmUNCMKMqGWIzIlP55slCO0/AkQkFJfq+dy7Y2/AfmDw6FVtJ+8P7G69Lv7
         drypPEMPVektwbsZXinvfpEj5Wv4ajheMqgLRzA8=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 05/11] platform/x86: intel_pmc: Make PCI dependency explicit
Date:   Wed,  2 Jan 2019 18:10:32 +0000
Message-Id: <20190102181038.4418-6-okaya@kernel.org>
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
specified directly. Code relies on PCI for execution. Specify this
in the Kconfig.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b36ea14b41ad..7afb96cb1cd6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1174,7 +1174,7 @@ config INTEL_SMARTCONNECT
 
 config INTEL_PMC_IPC
 	tristate "Intel PMC IPC Driver"
-	depends on ACPI
+	depends on ACPI && PCI
 	---help---
 	This driver provides support for PMC control on some Intel platforms.
 	The PMC is an ARC processor which defines IPC commands for communication
-- 
2.19.0

