Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324BFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1D221726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EoyA6lUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeLZCML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:12:11 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:59982 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLZCMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:12:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 1613CB0B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T7jIQjZrf0G9 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:12:08 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id D817893D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:12:08 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id u2so17808319iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yCzFoK1iiIRKLfANragzU6dURuTC3d2vdcMV+tmecXc=;
        b=EoyA6lUPfFrG31KgmHniuKQsp4hLAXwDpSFCP5nzAE/qIaP2r8RimB77JASE9BeBFB
         PdSkKoYEGoKIKy7JB27zQkLmRqtYwy5tNjromb7DZDEMo/8t46Rw2mTCIs+3FjgMRK14
         LlcHPeUPCtZIiviABUrUtIXf1UMP05Rh3iu+EFAbObP4MAf4plFtEXypqLrOtFJirq0s
         3JxFWbVLGUpTqtJbY9/xptt9RKO/f9BFtOLRs+RlKw5fgAOJuJKkEQg9uWvOJNGB+zyr
         MFa8Z1Xdnj7P4ECkpg+topWnfJIKq9ACapxDOweB50SWMrUgUplozi6L9Enj9YVSVVww
         e30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yCzFoK1iiIRKLfANragzU6dURuTC3d2vdcMV+tmecXc=;
        b=fFAkGLSj/UCrAIDt/UwTcWt7IUYlI5uwGhybb+ba33+Y6TB1Ks6CiIlTEu5PBGVHDf
         HblJ0Xao8rPaekAKfZ2cdU/jyxhuFHlfG0w/zxVwHNDYxvqoRpQZ1GWr2HW2W7Rs2GvG
         0VsIoIIEkOed6yxd5uWD+Zzx/w5oxZMuZ9M8H6mDIdNx5HTccvQTlkSZhSenW6e4uKN+
         +W29dkV8C8nAc0xJcIwNWzNOaNTvZrwCsySuNdhNuzrFEJNhZmvAaZu6TwJvbACo41gs
         kdjv8o6s0tO6kHfjxsfSFbQB6fX6bMmz1XZ65oj5LplwCjgCAjPmJGK2fT6VYsZcUdXB
         FpMg==
X-Gm-Message-State: AJcUukdSzkXLI2g4sYTITRDlJAZYKZwFBioT/XDIjy3p2+7MJ/ECQ2lz
        8f2UUdja17WEZesVVw6zNXgI33ju5FPEd6JG5AARfDrVFLmfdG/Ljt5xfc31WqCblMb85retqmn
        bpwb8n/cMkKtcoqxU+5K+IJbYNl4Q
X-Received: by 2002:a02:1106:: with SMTP id 6mr3949715jaf.122.1545790328517;
        Tue, 25 Dec 2018 18:12:08 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5pq5pEAop9PnGtlNyQS6/ED5bVOheccLYkcSoMjL1ysm1BM9sV7TwXo+3mY0xCWAuVGRaoeQ==
X-Received: by 2002:a02:1106:: with SMTP id 6mr3949708jaf.122.1545790328276;
        Tue, 25 Dec 2018 18:12:08 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id x18sm4374671ion.0.2018.12.25.18.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:12:07 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Alex Estrin <alex.estrin@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: add checks for the status of nla_put
Date:   Tue, 25 Dec 2018 20:11:39 -0600
Message-Id: <20181226021141.71538-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix inserts multiple checks for nla_put, and issues warnings if it
fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/infiniband/core/sa_query.c | 39 ++++++++++++++++++------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index be5ba5e15496..0e5d7a6dde36 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -775,28 +775,37 @@ static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
 	/* Now build the attributes */
 	if (comp_mask & IB_SA_PATH_REC_SERVICE_ID) {
 		val64 = be64_to_cpu(sa_rec->service_id);
-		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SERVICE_ID,
-			sizeof(val64), &val64);
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SERVICE_ID,
+			sizeof(val64), &val64))
+			pr_warn("nla_put failed\n");
+	}
+	if (comp_mask & IB_SA_PATH_REC_DGID) {
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_DGID,
+			sizeof(sa_rec->dgid), &sa_rec->dgid))
+			pr_warn("nla_put failed\n");
+	}
+	if (comp_mask & IB_SA_PATH_REC_SGID) {
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SGID,
+			sizeof(sa_rec->sgid), &sa_rec->sgid))
+			pr_warn("nla_put failed\n");
+	}
+	if (comp_mask & IB_SA_PATH_REC_TRAFFIC_CLASS) {
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_TCLASS,
+			sizeof(sa_rec->traffic_class), &sa_rec->traffic_class))
+			pr_warn("nla_put failed\n");
 	}
-	if (comp_mask & IB_SA_PATH_REC_DGID)
-		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_DGID,
-			sizeof(sa_rec->dgid), &sa_rec->dgid);
-	if (comp_mask & IB_SA_PATH_REC_SGID)
-		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SGID,
-			sizeof(sa_rec->sgid), &sa_rec->sgid);
-	if (comp_mask & IB_SA_PATH_REC_TRAFFIC_CLASS)
-		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_TCLASS,
-			sizeof(sa_rec->traffic_class), &sa_rec->traffic_class);
 
 	if (comp_mask & IB_SA_PATH_REC_PKEY) {
 		val16 = be16_to_cpu(sa_rec->pkey);
-		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_PKEY,
-			sizeof(val16), &val16);
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_PKEY,
+			sizeof(val16), &val16))
+			pr_warn("nla_put failed\n");
 	}
 	if (comp_mask & IB_SA_PATH_REC_QOS_CLASS) {
 		val16 = be16_to_cpu(sa_rec->qos_class);
-		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_QOS_CLASS,
-			sizeof(val16), &val16);
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_QOS_CLASS,
+			sizeof(val16), &val16))
+			pr_warn("nla_put failed\n");
 	}
 }
 
-- 
2.17.2 (Apple Git-113)

