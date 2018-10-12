Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41158C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F054F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F054F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeJLXNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:13:21 -0400
Received: from gateway31.websitewelcome.com ([192.185.144.91]:48241 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728900AbeJLXNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:13:21 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 7EE694BDB0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:40:18 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id AzY2gB4L5RPojAzY2gSlJF; Fri, 12 Oct 2018 10:40:18 -0500
X-Authority-Reason: nr=8
Received: from lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr ([80.15.51.183]:37046 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gAzY1-003Xh3-RI; Fri, 12 Oct 2018 10:40:18 -0500
Date:   Fri, 12 Oct 2018 17:40:15 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] firewire: core-topology: mark expected switch fall-through
Message-ID: <20181012154015.GA23367@embeddedor.com>
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
X-Source-IP: 80.15.51.183
X-Source-L: No
X-Exim-ID: 1gAzY1-003Xh3-RI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr (embeddedor) [80.15.51.183]:37046
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 741234 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/firewire/core-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 7db234d..82c67e9 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -67,6 +67,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
 		switch (port_type) {
 		case SELFID_PORT_CHILD:
 			(*child_port_count)++;
+			/* fall through */
 		case SELFID_PORT_PARENT:
 		case SELFID_PORT_NCONN:
 			(*total_port_count)++;
-- 
2.7.4

