Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177A1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EAF20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EAF20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJIFff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:35:35 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.79]:41918 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbeJIFff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:35:35 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id DFF951C1BD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 17:21:39 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9duEg09FY8YaU9duFgS37w; Mon, 08 Oct 2018 17:21:39 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:53278 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g9duD-0026cK-Vw; Mon, 08 Oct 2018 17:21:38 -0500
Date:   Tue, 9 Oct 2018 00:21:36 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: phy: Update SERDES_MAX to be SERDES_MAX + 1
Message-ID: <3a1a95a4832af33dcd1842b0298d257bbcf1f5ab.1539036280.git.gustavo@embeddedor.com>
References: <cover.1539036280.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539036280.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g9duD-0026cK-Vw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net (embeddedor) [92.93.206.174]:53278
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
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
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

