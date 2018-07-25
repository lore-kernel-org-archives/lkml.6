Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D1C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74160208DE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jajsW5b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74160208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeGYT5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:57:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32929 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbeGYT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:57:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so8366169wrp.0;
        Wed, 25 Jul 2018 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T5on02oejJgAKkwqDGZmdwYsozVcjUviW1FXxOLK0w4=;
        b=jajsW5b6ZApaNYd0kPCV7I5UL3BT9Dwpb9ULa5oF0+xiJclpxic14b90EG5ADfgSEa
         2wsZ1KWSfgHRiysrAUbkVNYvQmmjqyoHtzLJfqRMdZeya6xQngemwdNBQdxTqm6QY1TK
         bR1wmLwHSkLHOsKxkQ5FbW5irLX2gCpaVQJtjvNqd6jOkj1V3g3J0R/6k/iLRxKq6KRJ
         XfcHpRmZ2qWF4bQN72JSdW8PUYTZbB9QC/W9JzGAnVX5rRIY6nfRNo/n2FqkpAuxpZBN
         P3tcTZDpPwoz7nsQ6L9n7pzahIVpfPBkk3sz8dXlWAzKMd38qvbpfxS4KRIr35gw9WSA
         69iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T5on02oejJgAKkwqDGZmdwYsozVcjUviW1FXxOLK0w4=;
        b=Zd+viwIiyn2ixNZwqOB1eI/2O4qg9JqXup97of/OtrfEEOcqHd6LkC5LJ+cwbH60Ut
         Js5sE+MquoEkaj7CYpMD0W2GBgeUQQwwY9/EkFSg0kPISGLyb9+F+LMWUzwvFpYkfuUL
         XuPg9agJwDize+endv5B8j17dLtFSjyWN8hr+7FFKFKzDSznAnVWF7DvbzrbwZ6AQfLj
         0qHrSM1NZELuAZlKVrwYQmc0njrVq5aiVyCjyMuYBgYP6R6ZBjpupsIGCGKcMcxSY2P9
         cBrrOvnRZVl2vkbGb908HezsV9jHvsEhFHsn8vVB6xNvKRGmNc4/1rP/AT53OBnwBxoP
         lI+Q==
X-Gm-Message-State: AOUpUlEhx4DuU/CJzbbUudf2zLwxZNNmY6l8YdHFqBdHnP4mnmrgJ3dx
        unJsK9EH5rgSZzZK7UrvGrAhPGrySHQ=
X-Google-Smtp-Source: AAOMgpeCpDD+g52dbqckP+g/MdDHpW97vVxh4QyBF1Hr6CgeCsNXw222ptNaZxfn+BSR8H93pooc5A==
X-Received: by 2002:adf:e642:: with SMTP id b2-v6mr16458235wrn.254.1532544247447;
        Wed, 25 Jul 2018 11:44:07 -0700 (PDT)
Received: from euri.wifirst.net (eth-west-pareq2-46-193-2-21.wb.wifirst.net. [46.193.2.21])
        by smtp.googlemail.com with ESMTPSA id d15-v6sm333946wmb.0.2018.07.25.11.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 11:44:06 -0700 (PDT)
From:   Varsha Rao <rvarsha016@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] drivers: infiniband: core: Remove extra parentheses
Date:   Wed, 25 Jul 2018 20:43:56 +0200
Message-Id: <20180725184356.3754-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses to fix the clang warning of extraneous
parentheses.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index bff10ab141b0..c200a2e748f0 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4010,7 +4010,7 @@ static void cma_set_mgid(struct rdma_id_private *id_priv,
 		memcpy(mgid, &sin6->sin6_addr, sizeof *mgid);
 	} else if (addr->sa_family == AF_IB) {
 		memcpy(mgid, &((struct sockaddr_ib *) addr)->sib_addr, sizeof *mgid);
-	} else if ((addr->sa_family == AF_INET6)) {
+	} else if (addr->sa_family == AF_INET6) {
 		ipv6_ib_mc_map(&sin6->sin6_addr, dev_addr->broadcast, mc_map);
 		if (id_priv->id.ps == RDMA_PS_UDP)
 			mc_map[7] = 0x01;	/* Use RDMA CM signature */
-- 
2.17.0

