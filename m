Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D353C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBAE217D1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBAE217D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeHDX4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:56:17 -0400
Received: from gateway36.websitewelcome.com ([192.185.179.26]:48490 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728882AbeHDX4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:56:17 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 58958400D1628
        for <linux-kernel@vger.kernel.org>; Sat,  4 Aug 2018 15:56:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m4V1fTR9O79N3m4V1fmTZG; Sat, 04 Aug 2018 16:54:11 -0500
X-Authority-Reason: nr=8
Received: from [189.250.50.82] (port=33804 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fm4V0-002mDt-Vs; Sat, 04 Aug 2018 16:54:11 -0500
Date:   Sat, 4 Aug 2018 16:54:10 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 09/12] ASoC: da7213: use true and false for boolean values
Message-ID: <054adeac54eba2831e2433d71f385841034faf52.1533418275.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fm4V0-002mDt-Vs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.50.82]:33804
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 73
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
 sound/soc/codecs/da7213.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 54cb5f2..92d006a 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1140,9 +1140,9 @@ static bool da7213_volatile_register(struct device *dev, unsigned int reg)
 	case DA7213_ALC_OFFSET_AUTO_M_R:
 	case DA7213_ALC_OFFSET_AUTO_U_R:
 	case DA7213_ALC_CIC_OP_LVL_DATA:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.7.4

