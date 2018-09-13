Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7421C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1A4204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1A4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIMXyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:54:46 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.102]:13914 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727231AbeIMXyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:54:46 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 8B74170A4F8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 13:44:02 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0WaigspWcSjJA0WaqgUuO1; Thu, 13 Sep 2018 13:44:02 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.25] (port=50518 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g0Wai-001kRP-9M; Thu, 13 Sep 2018 13:43:48 -0500
Date:   Thu, 13 Sep 2018 13:43:47 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: atiixp: fix fall-through annotations
Message-ID: <20180913184347.GA32356@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.25
X-Source-L: No
X-Exim-ID: 1g0Wai-001kRP-9M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.25]:50518
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/atiixp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index a1e4944..1a41f8c 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -903,15 +903,15 @@ static int snd_atiixp_playback_prepare(struct snd_pcm_substream *substream)
 	case 8:
 		data |= ATI_REG_OUT_DMA_SLOT_BIT(10) |
 			ATI_REG_OUT_DMA_SLOT_BIT(11);
-		/* fallthru */
+		/* fall through */
 	case 6:
 		data |= ATI_REG_OUT_DMA_SLOT_BIT(7) |
 			ATI_REG_OUT_DMA_SLOT_BIT(8);
-		/* fallthru */
+		/* fall through */
 	case 4:
 		data |= ATI_REG_OUT_DMA_SLOT_BIT(6) |
 			ATI_REG_OUT_DMA_SLOT_BIT(9);
-		/* fallthru */
+		/* fall through */
 	default:
 		data |= ATI_REG_OUT_DMA_SLOT_BIT(3) |
 			ATI_REG_OUT_DMA_SLOT_BIT(4);
-- 
2.7.4

