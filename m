Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52913C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1711021774
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1711021774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeHCS3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:29:55 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.212]:39188 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727433AbeHCS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:29:55 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id F19B9400DECAD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 11:32:53 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ld0XfEhLVPvAdld0XfGoWn; Fri, 03 Aug 2018 11:32:53 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=51080 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fld0X-003FqW-7f; Fri, 03 Aug 2018 11:32:53 -0500
Date:   Fri, 3 Aug 2018 11:32:52 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 5/7] ASoC: omap-mcpdm: Mark expected switch fall-throughs
Message-ID: <720fbf880f4edfb57379278056f45fc639775ad3.1533312229.git.gustavo@embeddedor.com>
References: <cover.1533312229.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533312229.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.50.82
X-Source-L: No
X-Exim-ID: 1fld0X-003FqW-7f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:51080
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 56
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1369526 ("Missing break in switch")
Addresses-Coverity-ID: 1369529 ("Missing break in switch")
Addresses-Coverity-ID: 1451415 ("Missing break in switch")
Addresses-Coverity-ID: 115103 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/omap/omap-mcpdm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 0e97360..4c1be36 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -310,15 +310,19 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 			/* up to 3 channels for capture */
 			return -EINVAL;
 		link_mask |= 1 << 4;
+		/* fall through */
 	case 4:
 		if (stream == SNDRV_PCM_STREAM_CAPTURE)
 			/* up to 3 channels for capture */
 			return -EINVAL;
 		link_mask |= 1 << 3;
+		/* fall through */
 	case 3:
 		link_mask |= 1 << 2;
+		/* fall through */
 	case 2:
 		link_mask |= 1 << 1;
+		/* fall through */
 	case 1:
 		link_mask |= 1 << 0;
 		break;
-- 
2.7.4

