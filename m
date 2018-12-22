Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F31EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57924205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500986;
	bh=uWpdUph26N2R3BgMWLopvVOqN+RIm7jqq5akbbBXXF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3mW9o4ahDaSd4IkTvLh+f+BpkmN9/aPPjS77gIeuAsnvPmTTG2wQp2pwv51JpNSS
	 3WV0l1o0JfkwVqUa9gvbR5zKi6c27QPvRnSgmu5/+/Zcdv4zfs43PtoL162xY1tPLG
	 rV2/72l/haq7WwBy4kdUniMGpm3ldJ0/pI7loHYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392809AbeLVRtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:49:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388219AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.76.9.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EB23219FB;
        Sat, 22 Dec 2018 09:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545469662;
        bh=uWpdUph26N2R3BgMWLopvVOqN+RIm7jqq5akbbBXXF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUrdlxmAm92LR73/DSOaWaveOWMtwFiDunKfwVVRgd8vASadz/tt6oETmC7AMrFCG
         XLe5cw9nTQWnzS6zoBPOM3CKdFbFLH387y0NVxlRitZGXFC+O9FgLirTMmo7RTxFUF
         bNZ6lMEtx1da8URC0zD1QFEc5ePfDoyHiBo4KuC8=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 09/11] mmc: add PCI dependency into IOSF_MBI
Date:   Sat, 22 Dec 2018 09:07:18 +0000
Message-Id: <20181222090720.19234-10-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222090720.19234-1-okaya@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
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

