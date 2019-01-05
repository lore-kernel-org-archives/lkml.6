Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44981C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131EA218E0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546682787;
	bh=ukM4kfMvFRtOSCw2mDY00rt02BB6x55i8kMYPSKvLU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ki/oR347+Am9KkI0NfMxNOU6FY0/S6euAG1jZ+Y/9rCHJaRnquq1WzYji+GyANne/
	 Y0xCwJowlixEEyaaRPKYegI93v0z53C1zjDd3rge6tVdfHkYQfohOCcTNMWfZxI/Ks
	 lUxstmh/Pes6Vz92i1pG3S6hpRayfnPQ5V+7sGn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfAEKG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfAEKGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:06:21 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [104.211.55.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F50213F2;
        Sat,  5 Jan 2019 10:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546682780;
        bh=ukM4kfMvFRtOSCw2mDY00rt02BB6x55i8kMYPSKvLU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UI5ttoS/EjGlerqrgVQvMiPxM8c5MK6OeY3wog9LpsekUGPu6I6EPWYKRVJQgpRBK
         ih7iG5kNbBzEOrE9kFY3RKPjtruYPZafyF5J7TrC5jguL1r1WoAju0v1jR2+uJCOYG
         ZjvQI1qP/hzdhd1ghGINa3aXv2qjm6kC5YZSf7LQ=
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
Subject: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date:   Sat,  5 Jan 2019 10:06:03 +0000
Message-Id: <20190105100606.6673-9-okaya@kernel.org>
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
specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
IOSF_MBI driver.

Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 sound/soc/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 99a62ba409df..bd9fd2035c55 100644
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

