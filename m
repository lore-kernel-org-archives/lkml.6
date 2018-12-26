Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2CA20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DAZBWvl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeLZCGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:06:19 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:60858 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLZCGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:06:19 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id B5C20BC2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:06:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S3Xio8TZQkX4 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:06:17 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 816736D8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:06:17 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id c73so17488863itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/fpCi95qFg44joQlzuevxKAki1Vqp2cc45ZOsT4lpxw=;
        b=DAZBWvl8um8Ri6NoqtWoTZsCX01x+rJNJhbFXKZHwWe2i1KiiErebnHTW7Y6ieFU6h
         +tSmNHq7lp+sFOLb1/mO+bvP5E/hJLhkbj+HHQAK7uRNNZwvPZCgQeSgcyRetsbS2whj
         +38nEnndpgD5EqmEj1soaLGvlPfr8f64pB1vot4hL/tw1wojIj8gBDF59tmUwDIkxeDw
         u3/vI1sbffMpF2ksT6iCEg49tE6jWHv6U31mPYlJPmJSfw7rC1PavTIwZ7kyIXusWuOU
         7xNGcslNB8DK5Ur3cSl9Y+RSZ0647XWYqlUQWb+XCm8z9jTKBmUnCMdWPHrRlvyLYr0r
         GyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/fpCi95qFg44joQlzuevxKAki1Vqp2cc45ZOsT4lpxw=;
        b=rjsmr6OSxPZ1YBUhh+wCE4MVTI/HsV4yJ+myyKZh/oYkgwj3xOPNZSmagYVheM7KFZ
         TVSxZHonJmsMXo456ZogfWxmuwkAI/zLBqg4rho5q+DP1VEXGX3oFYEryVnsuFiV9OX1
         0MQODVURzdhGqmaIlTds1CEUQfCpE/EsLDT21Fh3xj+MVKWQ4fRBMGBBjxMmgVbQiNUv
         RdMiL8jeYSQ4t0UymvMdGZEMpAGaJDY/snhwVnBveBKS5pGZByiuzqidUAK4yk/A1rXK
         lY/LqKAjrBWgx1v9SX8lQ0N/JQ6382bKTRS3CqBVcWudwZb3Zie2j8//HdH7xq+LHUzg
         XYTg==
X-Gm-Message-State: AA+aEWZYkaBOC0BpiKMGQLsqla6tmTJspmdiRdvbxY5VQxPAdYGiFMDM
        LS/wqkumm/K+qH+r8PUeK+ZDNHsAyufLegTPbZ4x1M/esOs+12j2i5O6u1QV5YSPiPjJ5FeaovP
        oE0jhW/RrKtywVcE+aTCNMuA1CkZo
X-Received: by 2002:a02:8a1c:: with SMTP id j28mr11989280jak.49.1545789977153;
        Tue, 25 Dec 2018 18:06:17 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UN6OYy5W5zE7a/kBbv9d7OnKjpjjV3cjkpOVGD7gwEAHs5gW1MwN43KHOvaaN8W00T0m9DUw==
X-Received: by 2002:a02:8a1c:: with SMTP id j28mr11989270jak.49.1545789976918;
        Tue, 25 Dec 2018 18:06:16 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 137sm13116019itm.21.2018.12.25.18.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:06:16 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: fix a missing check of nla_put
Date:   Tue, 25 Dec 2018 20:05:48 -0600
Message-Id: <20181226020549.71446-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_put() may fail. The fix adds a check for its return value, and
returns -EMSGSIZE if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/infiniband/core/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 0dce94e3c495..32d033ebaa5b 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -178,7 +178,8 @@ static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,
 	/* Construct the family header first */
 	header = skb_put(skb, NLMSG_ALIGN(sizeof(*header)));
 	header->ifindex = dev_addr->bound_dev_if;
-	nla_put(skb, attrtype, size, daddr);
+	if (nla_put(skb, attrtype, size, daddr))
+		return -EMSGSIZE;
 
 	/* Repair the nlmsg header length */
 	nlmsg_end(skb, nlh);
-- 
2.17.2 (Apple Git-113)

