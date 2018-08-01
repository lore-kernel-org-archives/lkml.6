Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DBDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F11620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F11620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbeHAViG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:38:06 -0400
Received: from gateway20.websitewelcome.com ([192.185.55.25]:26102 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387562AbeHAViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:38:05 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id D48D0400DDB12
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 14:50:42 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id kx8XftrgjBcCXkx8jfVVjE; Wed, 01 Aug 2018 14:50:42 -0500
X-Authority-Reason: nr=8
Received: from [189.250.61.218] (port=37636 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fkx8X-004BPo-0V; Wed, 01 Aug 2018 14:50:21 -0500
Date:   Wed, 1 Aug 2018 14:50:20 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 03/11] ASoC: rt5677: Mark expected switch fall-through
Message-ID: <e23dbec89964bff8832d5ff4ae5a50fd1a6c185f.1533151956.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fkx8X-004BPo-0V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.61.218]:37636
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 30
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1271174 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/rt5677.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 8a0181a..922becf 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4417,6 +4417,7 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		break;
 	case 25:
 		slot_width_25 = 0x8080;
+		/* fall through */
 	case 24:
 		val |= (2 << 8);
 		break;
-- 
2.7.4

