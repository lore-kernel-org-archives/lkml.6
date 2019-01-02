Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD3CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B3D2190B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546452658;
	bh=PlRf4+ydDiXQInkwuFAODtXveIuCOKnltL5q7XimqyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VbqhGciVRkxMxEkbTeKosqA9q3BYM6GJNDPYPfIVtMZA/vi5aZYA+C45q4vo7YOsQ
	 jZtYQKUWB/hqnZxsCi639d79gbJlv70Nr2RbYKo7acsqCoDjcxY5khtl0oNa1Z+Ret
	 5iBM95S1NIu0Aa5TVtvxlZ2vZn2QWq6mzxl1tdPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfABSK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfABSK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:10:56 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [137.117.71.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EE5F218E2;
        Wed,  2 Jan 2019 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546452656;
        bh=PlRf4+ydDiXQInkwuFAODtXveIuCOKnltL5q7XimqyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqK2ro0BFMTg3bGglacaNvuubFj4V2KMUQyAQVNS+3IiPZAuco94jN0GYE0pTA0xQ
         ugIkBzd6PDhmNIZGQiX5p0bNcTgXIyca+NQd6AYiVb8SS1SFh858NnCvuj3Ro/GLbd
         QRgatISb9dFTnDqUuZPFEFtzy9HD0U/xDciZgMxA=
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
Subject: [PATCH v5 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date:   Wed,  2 Jan 2019 18:10:35 +0000
Message-Id: <20190102181038.4418-9-okaya@kernel.org>
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
specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
IOSF_MBI driver.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
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

