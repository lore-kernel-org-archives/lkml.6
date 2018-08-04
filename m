Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF374C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EE82177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EE82177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbeHDLLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:11:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbeHDLLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:11:32 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 088BFBD1;
        Sat,  4 Aug 2018 09:11:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Adami <andrea.adami@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 101/124] ASoC: pxa: Fix module autoload for platform drivers
Date:   Sat,  4 Aug 2018 11:01:30 +0200
Message-Id: <20180804082706.257130218@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Adami <andrea.adami@gmail.com>

commit e5b7d71aa5b32180adec49a17c752e577c68f740 upstream.

These platform drivers are lacking MODULE_ALIAS so module autoloading
doesn't work. Tested on corgi and poodle with kernel 4.4.

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/pxa/brownstone.c     |    1 +
 sound/soc/pxa/mioa701_wm9713.c |    1 +
 sound/soc/pxa/mmp-pcm.c        |    1 +
 sound/soc/pxa/mmp-sspa.c       |    1 +
 sound/soc/pxa/palm27x.c        |    1 +
 sound/soc/pxa/pxa-ssp.c        |    1 +
 sound/soc/pxa/pxa2xx-ac97.c    |    1 +
 sound/soc/pxa/pxa2xx-pcm.c     |    1 +
 8 files changed, 8 insertions(+)

--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -136,3 +136,4 @@ module_platform_driver(mmp_driver);
 MODULE_AUTHOR("Leo Yan <leoy@marvell.com>");
 MODULE_DESCRIPTION("ALSA SoC Brownstone");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:brownstone-audio");
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -203,3 +203,4 @@ module_platform_driver(mioa701_wm9713_dr
 MODULE_AUTHOR("Robert Jarzmik (rjarzmik@free.fr)");
 MODULE_DESCRIPTION("ALSA SoC WM9713 MIO A701");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mioa701-wm9713");
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -248,3 +248,4 @@ module_platform_driver(mmp_pcm_driver);
 MODULE_AUTHOR("Leo Yan <leoy@marvell.com>");
 MODULE_DESCRIPTION("MMP Soc Audio DMA module");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mmp-pcm-audio");
--- a/sound/soc/pxa/mmp-sspa.c
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -482,3 +482,4 @@ module_platform_driver(asoc_mmp_sspa_dri
 MODULE_AUTHOR("Leo Yan <leoy@marvell.com>");
 MODULE_DESCRIPTION("MMP SSPA SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mmp-sspa-dai");
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -161,3 +161,4 @@ module_platform_driver(palm27x_wm9712_dr
 MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
 MODULE_DESCRIPTION("ALSA SoC Palm T|X, T5 and LifeDrive");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:palm27x-asoc");
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -833,3 +833,4 @@ module_platform_driver(asoc_ssp_driver);
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("PXA SSP/PCM SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pxa-ssp-dai");
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -287,3 +287,4 @@ module_platform_driver(pxa2xx_ac97_drive
 MODULE_AUTHOR("Nicolas Pitre");
 MODULE_DESCRIPTION("AC97 driver for the Intel PXA2xx chip");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pxa2xx-ac97");
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -117,3 +117,4 @@ module_platform_driver(pxa_pcm_driver);
 MODULE_AUTHOR("Nicolas Pitre");
 MODULE_DESCRIPTION("Intel PXA2xx PCM DMA module");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pxa-pcm-audio");


