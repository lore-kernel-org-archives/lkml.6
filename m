Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DBAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6495F21738
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546199794;
	bh=JHtUanecoemgWChIueBVKj6YwGfB11CbL/NxwTpx3hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LsQj75Pw/z+JTecz2yAFxiP1VefYanYI2JBzjJ2rKR7JJ4Cim5pzdcNHUDH4s01k9
	 g8Mst+SSCIbwNcgCYlYKtVkJWMyIVVdn2n0AY88gfVSc2F5R5+ufCbpNNq2TusxY5e
	 9H4DThindA9B1XT2pq3V1QeBFns6iIfp7HYwU1p4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeL3T4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbeL3T4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:56:30 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.85.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E138F20866;
        Sun, 30 Dec 2018 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546199790;
        bh=JHtUanecoemgWChIueBVKj6YwGfB11CbL/NxwTpx3hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFE5ujCS0fez8Y4taJf2E4wdI89gNhoZWaIU7JhT8x9VMYShYUd3KBFWuaK7PtnGS
         8Q9XDL+UhpnKfY0sKtRuxnk9WIS58+KPfFZeXppn0bOvXmAeic7AsbX/pNJb52ke6p
         5zQua5ope8NbIxIEvns0RJ4LugFI78PBOyOxwRnA=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Date:   Sun, 30 Dec 2018 19:56:10 +0000
Message-Id: <20181230195612.6657-10-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181230195612.6657-1-okaya@kernel.org>
References: <20181230195612.6657-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select IOSF_MBI only when PCI and X86 is set.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
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

