Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3911CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2FC2156F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2FC2156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbeHBWeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:34:09 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.196]:42044 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731781AbeHBWeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:34:09 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 9B9F1ED46
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 15:41:22 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lKPSf4ZNiPvAdlKPSf6qA1; Thu, 02 Aug 2018 15:41:22 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=47396 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1flKPS-002ckz-25; Thu, 02 Aug 2018 15:41:22 -0500
Date:   Thu, 2 Aug 2018 15:41:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/4] ALSA: opti92x: mark expected switch fall-throughs
Message-ID: <a1aff0d9df70429d2b414435764f2092263ffee9.1533242152.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1flKPS-002ckz-25
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:47396
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1165394 ("Missing break in switch")
Addresses-Coverity-ID: 1167851 ("Missing break in switch")
Addresses-Coverity-ID: 402015 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/opti9xx/opti92x-ad1848.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 505cd81..ac0ab6e 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -261,6 +261,7 @@ static unsigned char snd_opti9xx_read(struct snd_opti9xx *chip,
 			retval = inb(chip->mc_base + 9);
 			break;
 		}
+		/* Fall through */
 
 	case OPTi9XX_HW_82C928:
 	case OPTi9XX_HW_82C929:
@@ -303,6 +304,7 @@ static void snd_opti9xx_write(struct snd_opti9xx *chip, unsigned char reg,
 			outb(value, chip->mc_base + 9);
 			break;
 		}
+		/* Fall through */
 
 	case OPTi9XX_HW_82C928:
 	case OPTi9XX_HW_82C929:
@@ -350,6 +352,7 @@ static int snd_opti9xx_configure(struct snd_opti9xx *chip,
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(4), 0xf0, 0xfc);
 		/* enable wave audio */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(6), 0x02, 0x02);
+		/* Fall through */
 
 	case OPTi9XX_HW_82C925:
 		/* enable WSS mode */
-- 
2.7.4

