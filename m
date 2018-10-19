Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B2ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EF920869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EF920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeJSRYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:24:53 -0400
Received: from gateway30.websitewelcome.com ([192.185.179.30]:45537 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726970AbeJSRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:24:53 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6F191560A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 04:19:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id DQw8gnCZqtz4jDQwLguNWi; Fri, 19 Oct 2018 04:19:37 -0500
X-Authority-Reason: nr=8
Received: from lfbn-1-466-13.w86-245.abo.wanadoo.fr ([86.245.173.13]:50434 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gDQw7-000n6J-8H; Fri, 19 Oct 2018 04:19:15 -0500
Date:   Fri, 19 Oct 2018 11:19:13 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: Update SERDES_MAX to be SERDES_MAX
 + 1
Message-ID: <5ae446d31ba33cb005d181b376ee650ab2f783e2.1539940387.git.gustavo@embeddedor.com>
References: <cover.1539940387.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539940387.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 86.245.173.13
X-Source-L: No
X-Exim-ID: 1gDQw7-000n6J-8H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lfbn-1-466-13.w86-245.abo.wanadoo.fr (embeddedor) [86.245.173.13]:50434
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
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
Changes in v3:
 - Post the patch to netdev.

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

