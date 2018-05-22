Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEVQuh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:50:37 -0400
Received: from gateway20.websitewelcome.com ([192.185.44.20]:14474 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751291AbeEVQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:50:36 -0400
X-Authority-Reason: nr=8
Date: Tue, 22 May 2018 11:04:59 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] media: dvb-bt8xx: remove duplicate code
Message-ID: <20180522160459.GA26733@embeddedor.com>
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
X-Exim-ID: 1fL9mX-002VBn-Jq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.46.223]:36634
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same code is executed regardless of whether c->frequency < 600000000
or c->frequency < 730000000 is true.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/pci/bt8xx/dvb-bt8xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/pci/bt8xx/dvb-bt8xx.c b/drivers/media/pci/bt8xx/dvb-bt8xx.c
index 5ef6e20..6b2a9e6 100644
--- a/drivers/media/pci/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/pci/bt8xx/dvb-bt8xx.c
@@ -386,10 +386,6 @@ static int advbt771_samsung_tdtc9251dh0_tuner_calc_regs(struct dvb_frontend *fe,
 		bs = 0x02;
 	else if (c->frequency < 470000000)
 		bs = 0x02;
-	else if (c->frequency < 600000000)
-		bs = 0x08;
-	else if (c->frequency < 730000000)
-		bs = 0x08;
 	else
 		bs = 0x08;
 
-- 
2.7.4
