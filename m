Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658B8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284F62147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284F62147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeGLMD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:03:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57958 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeGLMD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:03:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 13DAD20741; Thu, 12 Jul 2018 13:54:43 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id BD355206A6;
        Thu, 12 Jul 2018 13:54:42 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 01/18] net: mvpp2: fix include guards in mvpp2_prs.h
Date:   Thu, 12 Jul 2018 13:54:10 +0200
Message-Id: <20180712115427.27375-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include guards should be put before #includes. This doesn't fix any bug,
but prevent future compilation issues when adding new files in the mvpp2
driver

The Header Parser init function needs the platform_device definition,
and with the fixed include guards we need to add the missing include.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
index a7c8d0818432..64a64666257c 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
@@ -9,14 +9,15 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
+#ifndef _MVPP2_PRS_H_
+#define _MVPP2_PRS_H_
+
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/platform_device.h>
 
 #include "mvpp2.h"
 
-#ifndef _MVPP2_PRS_H_
-#define _MVPP2_PRS_H_
-
 /* Parser constants */
 #define MVPP2_PRS_TCAM_SRAM_SIZE	256
 #define MVPP2_PRS_TCAM_WORDS		6
-- 
2.11.0

