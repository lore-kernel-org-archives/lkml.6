Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3732CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078CF21927
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437753;
	bh=7aV7OpnZLfrg3Gx9MB15d+QXAg4/gCtz/zHZSrucN7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvOG6Qv7Clu9X7e7q8I2w5k3R6eczyfYK3tAGSB84H+LAUf4X5NM8zXNWkTsURzrg
	 vNVsj8BXItgPkhJ4KuidW+gVcQnsy4r4ORlYkOaatSm85mplVoK0oAbEfjh/pEki0A
	 ervuihXdl3L+/CLh+iwleH9kR2yal8JrX1auilOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404813AbeLVAPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404726AbeLVAPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:15:10 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.82.132.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 501A021972;
        Sat, 22 Dec 2018 00:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437710;
        bh=7aV7OpnZLfrg3Gx9MB15d+QXAg4/gCtz/zHZSrucN7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lvur1C6Y4ZTZWPMkvf0yhjgz8VmjSzA9YpLzZqL6e7QAAxUgIXHfsW7Kw8x3Zvwi4
         UUmpsQm2gORXEU1wrqbj7MQCEDkfC9Qinqp4zTOFkL2zx5ygFHXcRosZdupaTMqcyT
         NP1EPmhpOy/OKSECXUvGg8/tB8jdv2LUVW6RTzRI=
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
Subject: [PATCH v1 08/11] ASoC: Intel: Make PCI dependency explicit
Date:   Sat, 22 Dec 2018 00:14:49 +0000
Message-Id: <20181222001452.7474-9-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181222001452.7474-1-okaya@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOSF_MBI driver depends on CONFIG_PCI set but this is not specified
anywhere.

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

