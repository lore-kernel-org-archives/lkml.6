Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D626C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0FA2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0FA2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeJRXIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:08:02 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.101]:23509 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbeJRXIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:08:02 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 7C6CE6B78B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 10:06:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id D9sXg7vLRBcCXD9sdgOFO4; Thu, 18 Oct 2018 10:06:36 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:56402 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gD9sW-004CH4-Dp; Thu, 18 Oct 2018 10:06:25 -0500
Date:   Thu, 18 Oct 2018 17:06:22 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: Update SERDES_MAX to be SERDES_MAX
 + 1
Message-ID: <320c0fbb88d46a662c3fc037a08a4a66c013385f.1539874459.git.gustavo@embeddedor.com>
References: <cover.1539874459.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539874459.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gD9sW-004CH4-Dp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:56402
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SERDES_MAX is a valid value to index ctrl->phys in
drivers/phy/mscc/phy-ocelot-serdes.c. But, currently,
there is an out-of-bounds bug in the mentioned driver
when reading from ctrl->phys, because the size of
array ctrl->phys is SERDES_MAX.

Partially fix this by updating SERDES_MAX to be SERDES6G_MAX + 1.

Notice that this is the first part of the solution to
the out-of-bounds bug mentioned above. Although this
change is not dependent on any other one.

Suggested-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Add Quentin's Reviewed-by to commit log.
 - Add Rob's Acked-by to commit log.

 include/dt-bindings/phy/phy-ocelot-serdes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/phy/phy-ocelot-serdes.h b/include/dt-bindings/phy/phy-ocelot-serdes.h
index bd28f21..fe70ada 100644
--- a/include/dt-bindings/phy/phy-ocelot-serdes.h
+++ b/include/dt-bindings/phy/phy-ocelot-serdes.h
@@ -7,6 +7,6 @@
 #define SERDES1G_MAX	SERDES1G(5)
 #define SERDES6G(x)	(SERDES1G_MAX + 1 + (x))
 #define SERDES6G_MAX	SERDES6G(2)
-#define SERDES_MAX	SERDES6G_MAX
+#define SERDES_MAX	(SERDES6G_MAX + 1)
 
 #endif
-- 
2.7.4

