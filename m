Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB8C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9DE204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9DE204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeKBUck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:32:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:32:40 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MRnXY-1g88X32I4w-00THDc; Fri, 02 Nov 2018 12:24:59 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MRnXY-1g88X32I4w-00THDc; Fri, 02 Nov 2018 12:24:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
Date:   Fri,  2 Nov 2018 12:24:08 +0100
Message-Id: <20181102112456.780127-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:T80YnorbcQmUCUVvOwTXqWgrMAg7L9NqE6kXrUEsq+B/vtI+lNc
 /0u4xWCI0CcGxoSz3Vg9AOL6tJwP4hdu6sD5glr91H9ZiCSCLEBq1bD4NF7IkIxgDqxY60W
 t+m0LuaxxC8ccQcH+mk66dJDbsKlDXTwUiGZBYW51dc0Zwi3ex5rRtYA1L0CG4LFG35A1BA
 5RJ7AYhrruBfRRH6uWEOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ES2BeJGS/3g=:XF7xhICaacYvmwM3sTBSHg
 I6rHV18XN8DC67EHfN2QHkOiNAc1angFCudLTJmtMzYaoueA7h4Z8jPfDf6mff6uknc2GeFO7
 bNk27pdtagJlPloYvCx1c73J/Gx0+vjHOMp1G5Cc0cFjjaXhOllQZh6NReHAXPtKk4C1WWYdA
 GIsnIlFNtSgLUlpilJgaS7GqB42DJRNr63GvJsNOESs8aR+97zKLNUpev0x/DbGXnAL9C8Sxn
 oYfZET6yOpV2KxIlaO4xqoFRntHuWvwViBMCBzhMi8LYBX+oxRmAUXxhprw93vdCSb74rhAi3
 T0kZO0kLKCig9kWftUB1IhZrq8uWJ6f417xeqlouRDvb/KJGM8a/ykhZ/5O3S889kyKCuKk5t
 2fojkenuGAfaEhQj7xH2qIvE+hAmE6DlnO3PbVyfZvFUGUpH49IsPCCkvOfUYcLveWYfpxeze
 Bb5ktAxikFGLSJ3FS2mfOJHbQ6AoBh5LgQlT2bCwwJAJMXeNV6vsuWuoDK5a8IE5CHbqt/qnw
 Kgli3QVEIH6o5BJU+RiOzK/MSfP13qgf5VXJge6Sp78ZuE7Vll/RpyFg0PDd2XeI6DP5MxUq4
 BWjyAEaogmkVuflAvYHIlT8lDs2VkAZqTQMYlobnZwvMo5SibIWJ/YP9bvv6WE0XPLiRY28Ze
 xckTymZeIALBqFM/PdkogY+h15FrD+J5aeS3dZz8cX30hpjKGrlcVio7vxl09jruvPUis4EUz
 UD1rCYhmxc+c2EcwZ0aEleu92HcZ7Tne9bvBMP634geZUVEQ1ZtSlaGrGEpIM2+vC+8L7BtrS
 xP32Guk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skylake sound support is written to work both with or without
CONFIG_SND_SOC_HDAC_HDA, and uses an #ifdef to decide whether it should
link against that. However, this fails with SND_SOC_ALL_CODECS=m or
SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m when the Skylake support itself
is built-in, with this link error:

sound/soc/intel/skylake/skl.o: In function `skl_probe':
skl.c:(.text+0x56c): undefined reference to `snd_soc_hdac_hda_get_ops'

Using an explicit 'select' here simplifies the logic and prevents
it from happening, at the cost of always including the compile
time dependency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/Kconfig       | 1 +
 sound/soc/intel/skylake/skl.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0caa1f4eb94d..c21ce7624af1 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -109,6 +109,7 @@ config SND_SOC_INTEL_SKYLAKE
 	depends on PCI && ACPI
 	select SND_HDA_EXT_CORE
 	select SND_HDA_DSP_LOADER
+	select SND_SOC_HDAC_HDA
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
 	select SND_SOC_ACPI_INTEL_MATCH
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 29225623b4b4..1069ee265ce5 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -870,9 +870,7 @@ static int skl_create(struct pci_dev *pci,
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
 
-#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
 	ext_ops = snd_soc_hdac_hda_get_ops();
-#endif
 	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, ext_ops);
 	bus->use_posbuf = 1;
 	skl->pci = pci;
-- 
2.18.0

