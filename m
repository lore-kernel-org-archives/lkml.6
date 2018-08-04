Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF4C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E4E21829
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E4E21829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeHDX5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:57:02 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.39]:20596 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728882AbeHDX5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:57:01 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 7BAA6888B8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 16:54:55 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m4VjfUaJKPvAdm4VjfWTKm; Sat, 04 Aug 2018 16:54:55 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=33810 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fm4Vi-002mQQ-QN; Sat, 04 Aug 2018 16:54:54 -0500
Date:   Sat, 4 Aug 2018 16:54:54 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     patches@opensource.cirrus.com
Subject: [PATCH 10/12] ASoC: wm5100-tables: use true and false for boolean
 values
Message-ID: <e20258db8af8bb40ef98efc2e21756222c1df39c.1533418275.git.gustavo@embeddedor.com>
References: <cover.1533418275.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533418275.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1fm4Vi-002mQQ-QN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:33810
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 80
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm5100-tables.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm5100-tables.c b/sound/soc/codecs/wm5100-tables.c
index e239f4b..9e987cf 100644
--- a/sound/soc/codecs/wm5100-tables.c
+++ b/sound/soc/codecs/wm5100-tables.c
@@ -30,7 +30,7 @@ bool wm5100_volatile_register(struct device *dev, unsigned int reg)
 	case WM5100_OUTPUT_STATUS_2:
 	case WM5100_INPUT_ENABLES_STATUS:
 	case WM5100_MIC_DETECT_3:
-		return 1;
+		return true;
 	default:
 		if ((reg >= WM5100_DSP1_PM_0 && reg <= WM5100_DSP1_PM_1535) ||
 		    (reg >= WM5100_DSP1_ZM_0 && reg <= WM5100_DSP1_ZM_2047) ||
@@ -41,9 +41,9 @@ bool wm5100_volatile_register(struct device *dev, unsigned int reg)
 		    (reg >= WM5100_DSP3_PM_0 && reg <= WM5100_DSP3_PM_1535) ||
 		    (reg >= WM5100_DSP3_ZM_0 && reg <= WM5100_DSP3_ZM_2047) ||
 		    (reg >= WM5100_DSP3_DM_0 && reg <= WM5100_DSP3_DM_511))
-			return 1;
+			return true;
 		else
-			return 0;
+			return false;
 	}
 }
 
@@ -798,7 +798,7 @@ bool wm5100_readable_register(struct device *dev, unsigned int reg)
 	case WM5100_DSP3_CONTROL_28:
 	case WM5100_DSP3_CONTROL_29:
 	case WM5100_DSP3_CONTROL_30:
-		return 1;
+		return true;
 	default:
 		if ((reg >= WM5100_DSP1_PM_0 && reg <= WM5100_DSP1_PM_1535) ||
 		    (reg >= WM5100_DSP1_ZM_0 && reg <= WM5100_DSP1_ZM_2047) ||
@@ -809,9 +809,9 @@ bool wm5100_readable_register(struct device *dev, unsigned int reg)
 		    (reg >= WM5100_DSP3_PM_0 && reg <= WM5100_DSP3_PM_1535) ||
 		    (reg >= WM5100_DSP3_ZM_0 && reg <= WM5100_DSP3_ZM_2047) ||
 		    (reg >= WM5100_DSP3_DM_0 && reg <= WM5100_DSP3_DM_511))
-			return 1;
+			return true;
 		else
-			return 0;
+			return false;
 	}
 }
 
-- 
2.7.4

