Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E895C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ECB2156F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37ECB2156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbeHBWeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:34:04 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.123]:31760 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726662AbeHBWeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:34:03 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id B31491DEE40
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 15:41:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lKOlfqhScbXuJlKP7fGaMF; Thu, 02 Aug 2018 15:41:16 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=47394 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1flKOk-002cSm-IF; Thu, 02 Aug 2018 15:40:38 -0500
Date:   Thu, 2 Aug 2018 15:40:37 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 1/4] ALSA: galaxy: Mark expected switch fall-throughs
Message-ID: <a7d1e7067504056852483ee5d91f8788322d3c10.1533242152.git.gustavo@embeddedor.com>
References: <cover.1533242152.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533242152.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1flKOk-002cSm-IF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:47394
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1468367 ("Missing break in switch")
Addresses-Coverity-ID: 115037 ("Missing break in switch")
Addresses-Coverity-ID: 115038 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/galaxy/galaxy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index b9994cc..af9eea4 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -260,6 +260,7 @@ static int snd_galaxy_match(struct device *dev, unsigned int n)
 		break;
 	case 2:
 		irq[n] = 9;
+		/* Fall through */
 	case 9:
 		wss_config[n] |= WSS_CONFIG_IRQ_9;
 		break;
@@ -304,6 +305,7 @@ static int snd_galaxy_match(struct device *dev, unsigned int n)
 	case 1:
 		if (dma1[n] == 0)
 			break;
+		/* Fall through */
 	default:
 		dev_err(dev, "invalid capture DMA %d\n", dma2[n]);
 		return 0;
@@ -333,6 +335,7 @@ static int snd_galaxy_match(struct device *dev, unsigned int n)
 		break;
 	case 2:
 		mpu_irq[n] = 9;
+		/* Fall through */
 	case 9:
 		config[n] |= GALAXY_CONFIG_MPUIRQ_2;
 		break;
-- 
2.7.4

