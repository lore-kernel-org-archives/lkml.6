Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEB1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621CA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621CA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbeHAVjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:39:46 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.233]:17798 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbeHAVjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:39:46 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id E1D6DE0C7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 14:52:23 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id kxA9fnyFxkBj6kxANf70m5; Wed, 01 Aug 2018 14:52:23 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=37648 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fkxA8-004CEP-IG; Wed, 01 Aug 2018 14:52:00 -0500
Date:   Wed, 1 Aug 2018 14:51:59 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 05/11] ASoC: wm8960: Mark expected switch fall-through
Message-ID: <b473ea056634ccb9316146590c7ed4d9efc14368.1533151956.git.gustavo@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533151956.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.61.218
X-Source-L: No
X-Exim-ID: 1fkxA8-004CEP-IG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:37648
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 44
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115041 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm8960.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index c30f5aa..8dc1f3d 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -839,6 +839,7 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 			iface |= 0x000c;
 			break;
 		}
+		/* fall through */
 	default:
 		dev_err(component->dev, "unsupported width %d\n",
 			params_width(params));
-- 
2.7.4

