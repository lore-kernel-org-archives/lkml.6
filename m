Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C056DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837C0218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545607547;
	bh=6gWjlof5B9sduGHpbO8R2RraaChXnfwbIp6+FUVT6xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vNVAttFYqVvhbMjO0X+1mo5BxtBIwsx4724/ZEnqedlQ5MYQwwE3y/YN0SzmyU3OQ
	 7FSlav5AKWPcQgVRrf2b+kCMBUflAsnjCfT7NS1lSscxI/EiplLV6Wa2g3+UfXrd7L
	 zg5gPl1gnSjnnZSOJQz60FHk1toc7mepJRZv6amA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeLWXZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:25:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbeLWXZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:25:41 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.82.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BFF0218AD;
        Sun, 23 Dec 2018 23:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545607541;
        bh=6gWjlof5B9sduGHpbO8R2RraaChXnfwbIp6+FUVT6xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTdxEsreqfc9lGQRhT3ALrMOToxxMNAv/B5mwdwx6KY9D0fMSSpKdFlDMgTPuxFEc
         cgtQALcsUWqvLAA9Z8ugtMILUFUj0YOeQaVUXxF66M2dlQb/Ewud3MYgQVcUOIwk8M
         bepDqFVx3ErdrykKVZGE38Muq6EmgEyfkcX9ZSEs=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:INTEL ASoC DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date:   Sun, 23 Dec 2018 23:25:17 +0000
Message-Id: <20181223232521.11320-9-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181223232521.11320-1-okaya@kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
CONFIG_PCI set but this is not specified anywhere.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2fd1b61e8331..b0764b2fe001 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
 config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
 	default ACPI
-	depends on X86 && ACPI
+	depends on X86 && ACPI && PCI
 	select SND_SST_IPC_ACPI
 	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SOC_ACPI_INTEL_MATCH
-- 
2.19.0

