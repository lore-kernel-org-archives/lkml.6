Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbeEVRdn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:33:43 -0400
Received: from gateway36.websitewelcome.com ([192.185.192.36]:34876 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751272AbeEVRdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:33:39 -0400
X-Authority-Reason: nr=8
Date: Tue, 22 May 2018 12:09:22 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Devin Heitmueller <dheitmueller@kernellabs.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] au8522: remove duplicate code
Message-ID: <20180522170922.GA30834@embeddedor.com>
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
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fLAn1-003JSO-5q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.46.223]:37896
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code has been there for nine years now, and it has been
working "good enough" since then [1].

Remove duplicate code by getting rid of the if-else statement.

[1] https://marc.info/?l=linux-kernel&m=152693550225081&w=2

Cc: Devin Heitmueller <dheitmueller@kernellabs.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/dvb-frontends/au8522_decoder.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/media/dvb-frontends/au8522_decoder.c b/drivers/media/dvb-frontends/au8522_decoder.c
index 343dc92..f285096 100644
--- a/drivers/media/dvb-frontends/au8522_decoder.c
+++ b/drivers/media/dvb-frontends/au8522_decoder.c
@@ -280,14 +280,12 @@ static void setup_decoder_defaults(struct au8522_state *state, bool is_svideo)
 			AU8522_TOREGAAGC_REG0E5H_CVBS);
 	au8522_writereg(state, AU8522_REG016H, AU8522_REG016H_CVBS);
 
-	if (is_svideo) {
-		/* Despite what the table says, for the HVR-950q we still need
-		   to be in CVBS mode for the S-Video input (reason unknown). */
-		/* filter_coef_type = 3; */
-		filter_coef_type = 5;
-	} else {
-		filter_coef_type = 5;
-	}
+	/*
+	 * Despite what the table says, for the HVR-950q we still need
+	 * to be in CVBS mode for the S-Video input (reason unknown).
+	 */
+	/* filter_coef_type = 3; */
+	filter_coef_type = 5;
 
 	/* Load the Video Decoder Filter Coefficients */
 	for (i = 0; i < NUM_FILTER_COEF; i++) {
-- 
2.7.4
