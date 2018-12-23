Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DA6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B36218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545607553;
	bh=uWpdUph26N2R3BgMWLopvVOqN+RIm7jqq5akbbBXXF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IYWZ3qKsHC4lFJjEadugG/5n8y9ksNh4Aaib/GnnxFBCR/la+1Bnc078ChgYobyLG
	 P4oGrx4KydvZGgNkHWpj7JVflm7zNYlicB/TX/sgoSH7qMQBPt4zh5LyaV581RwW4P
	 jgoGurwVRmmpB2dcMC5igWrG88foGGJLDc6h2ogg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeLWXZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbeLWXZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:25:47 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.82.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 694B7218A3;
        Sun, 23 Dec 2018 23:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545607546;
        bh=uWpdUph26N2R3BgMWLopvVOqN+RIm7jqq5akbbBXXF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAqJGjt+M0/H2x/lBYCvLm77S//0i9ZGJ7Of+JupY1s8plUurtzxGbo7gt2f9QIuk
         3XJCqjg9APoQtaGOIjmBHZWfkKbkA84SYLuckohL6mHrD5wvmV0E2Mrrg3EJEVdaRn
         XqRLpW2CRzRd1VnQY3nzIrcR+8uqDe1yjlBo836c=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
Date:   Sun, 23 Dec 2018 23:25:18 +0000
Message-Id: <20181223232521.11320-10-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select IOSF_MBI only when PCI is set.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e26b8145efb3..4c5f037b246d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -117,7 +117,7 @@ config MMC_RICOH_MMC
 config MMC_SDHCI_ACPI
 	tristate "SDHCI support for ACPI enumerated SDHCI controllers"
 	depends on MMC_SDHCI && ACPI
-	select IOSF_MBI if X86
+	select IOSF_MBI if (X86 && PCI)
 	help
 	  This selects support for ACPI enumerated SDHCI controllers,
 	  identified by ACPI Compatibility ID PNP0D40 or specific
-- 
2.19.0

