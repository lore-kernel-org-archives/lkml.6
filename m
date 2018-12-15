Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42499C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3A6208C1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544835812;
	bh=1GRqsbYVwLz59qJD38TH6xczEZFBWO9wSJvd2hbyTvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SRuExr+QTOfHPp+B657tNmQjXC/8lruOZyy2qYAq76vxbkrIQTTYbTl1f+diDzEBu
	 WPbEpqLl4DaLzQdA9TjgeFZ4RFLIHtNwpxxsKtb83ziSA+/G6GSbuI5XDbjyYnW7SI
	 eMBl62hQZf75ExK3KDwxbhih8dP21KjzSdQzKJzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbeLOBDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 20:03:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729959AbeLOBDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 20:03:15 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.30.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD340208CB;
        Sat, 15 Dec 2018 01:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544835795;
        bh=1GRqsbYVwLz59qJD38TH6xczEZFBWO9wSJvd2hbyTvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7njIuchjJb8KNuuMNOfAx+jxHgLaPUZOUnb/Y3KnJ3EY6bl25C3Fh/snlJSgWASS
         M5eeX4pHr2Nhbxar2RXejm4IcpQLhuPQwYNY/l10uKiS9l+oPKbqWuasKcmYKUKVM6
         hHD/0UgdtcqpbGGitoqfho6S9hu7yNhHakWxmbz8=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 5/6] arm64: select ACPI PCI code only both features are enabled
Date:   Sat, 15 Dec 2018 01:02:46 +0000
Message-Id: <20181215010247.26101-6-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181215010247.26101-1-okaya@kernel.org>
References: <20181215010247.26101-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI and PCI are no longer coupled to each other. Specify requirements
for both when pulling in code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..bcb6262044d8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,7 +5,7 @@ config ARM64
 	select ACPI_GTDT if ACPI
 	select ACPI_IORT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
-	select ACPI_MCFG if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
@@ -163,7 +163,7 @@ config ARM64
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
-	select PCI_ECAM if ACPI
+	select PCI_ECAM if (ACPI && PCI)
 	select POWER_RESET
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
-- 
2.19.0

