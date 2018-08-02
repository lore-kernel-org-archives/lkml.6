Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4053C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFA621571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFA621571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbeHBWfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:35:19 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.147]:17549 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726662AbeHBWfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:35:19 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id E82DA400C9A9C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 15:42:31 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lKQ1fqlCrbXuJlKQLfGe40; Thu, 02 Aug 2018 15:42:31 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=47398 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1flKQ0-002d10-Cj; Thu, 02 Aug 2018 15:41:56 -0500
Date:   Thu, 2 Aug 2018 15:41:55 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 3/4] ALSA: opti9xx: mark expected switch fall-throughs
Message-ID: <3355bbbbecd3a8041635d5d125aa9111c17beed9.1533242152.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1flKQ0-002d10-Cj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:47398
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 402016 ("Missing break in switch")
Addresses-Coverity-ID: 1056542 ("Missing break in switch")
Addresses-Coverity-ID: 1339579 ("Missing break in switch")
Addresses-Coverity-ID: 1369526 ("Missing break in switch")
Addresses-Coverity-ID: 1369529 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/isa/opti9xx/miro.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 8894c7c..c6136c6 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -176,10 +176,13 @@ static int aci_busy_wait(struct snd_miro_aci *aci)
 			switch (timeout-ACI_MINTIME) {
 			case 0 ... 9:
 				out /= 10;
+				/* fall through */
 			case 10 ... 19:
 				out /= 10;
+				/* fall through */
 			case 20 ... 30:
 				out /= 10;
+				/* fall through */
 			default:
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				schedule_timeout(out);
@@ -834,6 +837,7 @@ static unsigned char snd_miro_read(struct snd_miro *chip,
 			retval = inb(chip->mc_base + 9);
 			break;
 		}
+		/* fall through */
 
 	case OPTi9XX_HW_82C929:
 		retval = inb(chip->mc_base + reg);
@@ -863,6 +867,7 @@ static void snd_miro_write(struct snd_miro *chip, unsigned char reg,
 			outb(value, chip->mc_base + 9);
 			break;
 		}
+		/* fall through */
 
 	case OPTi9XX_HW_82C929:
 		outb(value, chip->mc_base + reg);
-- 
2.7.4

