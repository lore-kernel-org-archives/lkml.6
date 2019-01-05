Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAAAC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8C82087F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DNxITTcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfAERJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:09:39 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:32946 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfAERJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:09:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id F041BBA5
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 17:09:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I6WgNFTmvf6R for <linux-kernel@vger.kernel.org>;
        Sat,  5 Jan 2019 11:09:37 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id BF0B2B6E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 11:09:37 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id x82so4120728ita.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z1Lw+AEHgfW2sgDyU2Kme78FbwP0PqcVS06gS4s9las=;
        b=DNxITTcx2BBUtVr/17KuLM+ivfOxqi5RNAQAV6pbzHh4Q0rdqNBL0eaTzVhhA/VbDd
         tl44M3mEprVdFeCfkN+EKeuwWH6PfRl6Yvj59EkV7bTg7dJbSk77Qw8twN1Gu0rxMICG
         f+BaXSFJ/M9A4Z7eEoXg+a/o5qVQYXJc5vQ1ppVw86iLRHW7H9/lI0eqIxcSA0NeLRKd
         q5BKvycUku91DjiRKESBB90sDtqW2CYNXnezzjXvQuj9sibBhUlIrMes1jZUC1aA+D1e
         x3gkQA9cSDrP7rE3JwWfptnSl/JjXeC29iRG48DZYnQ2WUHhbkaeImyvC4IQaYipkjsE
         TEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z1Lw+AEHgfW2sgDyU2Kme78FbwP0PqcVS06gS4s9las=;
        b=FPNty54luH7RZoNggUeqdTonCpBkAA+/TzC1rfqPXikBa217svAhZA6UoX11fZtbI6
         3ymTTSoLN6mTK31cBxMMyS804kgU3uTpFAIMRBC8SqwJiNaQwl6VekI0YZkZSS+UFTix
         +/eGVEs3CFK2Kkq+SGt4Klt/cMEUKXjxlH3r/bv2rdjniEPa+14aAHwy5BD2i4dyY/SL
         bPDEmM4+q0tZd3r9CkH76TQGU+jpgfqUqKBxr01DJuXPnKYEXJmL5csOsU5E9mXlzNcB
         MFGQv6ZVKkJfzXrs+ZDU+/LxKrDQi2gJc5MWbQUKWrSECSEaNwK1XWXIUjRb7ZZTzWz5
         AzQw==
X-Gm-Message-State: AA+aEWbtjPzcQdrLXoeXnAyxTBIMz4CGHBET68VFNGfwgmjOw2wNu2yr
        wx8crVtnuDVg8R7EfDlYOTG7v21vUYz8deeTbEdw/57BSLGscujV9cFSf7j4GqLDR6DFKmrvwae
        8fOZzpS9HsUEOKAm/0OaVXsTJOkwj
X-Received: by 2002:a02:a791:: with SMTP id e17mr39938841jaj.104.1546708176970;
        Sat, 05 Jan 2019 09:09:36 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WO8jShMvgXCqFFkkq/IUhKO7hcWA1SjZyGVBhF4amjtxWq8oKkoxO1F+fK202FYceSmY4X7w==
X-Received: by 2002:a02:a791:: with SMTP id e17mr39938815jaj.104.1546708176701;
        Sat, 05 Jan 2019 09:09:36 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id o16sm2154972ito.19.2019.01.05.09.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 09:09:36 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2]RDMA: add checks for the status of nla_put in ib_nl_send_msg
Date:   Sat,  5 Jan 2019 11:09:26 -0600
Message-Id: <20190105170928.4086-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix inserts multiple checks for nla_put, and changes the return type of
ib_nl_set_path_rec_attrs() from void to int

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/infiniband/core/sa_query.c | 56 ++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 97e6d7b69abf..5d81158381d5 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -747,8 +747,9 @@ static inline int ib_sa_query_cancelled(struct ib_sa_query *query)
 	return (query->flags & IB_SA_CANCEL);
 }
 
-static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
-				     struct ib_sa_query *query)
+static int ib_nl_set_path_rec_attrs(struct sk_buff *skb,
+				     struct ib_sa_query *query,
+				     struct nlmsghdr *nlh)
 {
 	struct sa_path_rec *sa_rec = query->mad_buf->context[1];
 	struct ib_sa_mad *mad = query->mad_buf->mad;
@@ -775,29 +776,45 @@ static void ib_nl_set_path_rec_attrs(struct sk_buff *skb,
 	/* Now build the attributes */
 	if (comp_mask & IB_SA_PATH_REC_SERVICE_ID) {
 		val64 = be64_to_cpu(sa_rec->service_id);
-		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SERVICE_ID,
-			sizeof(val64), &val64);
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SERVICE_ID,
+				sizeof(val64), &val64))
+			goto nla_put_failure;
+	}
+	if (comp_mask & IB_SA_PATH_REC_DGID) {
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_DGID,
+				sizeof(sa_rec->dgid), &sa_rec->dgid))
+			goto nla_put_failure;
+	}
+	if (comp_mask & IB_SA_PATH_REC_SGID) {
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_SGID,
+				sizeof(sa_rec->sgid), &sa_rec->sgid))
+			goto nla_put_failure;
+	}
+	if (comp_mask & IB_SA_PATH_REC_TRAFFIC_CLASS) {
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_TCLASS,
+				sizeof(sa_rec->traffic_class),
+				&sa_rec->traffic_class))
+			goto nla_put_failure;
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
+				sizeof(val16), &val16))
+			goto nla_put_failure;
 	}
+
 	if (comp_mask & IB_SA_PATH_REC_QOS_CLASS) {
 		val16 = be16_to_cpu(sa_rec->qos_class);
-		nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_QOS_CLASS,
-			sizeof(val16), &val16);
+		if (nla_put(skb, RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_QOS_CLASS,
+				sizeof(val16), &val16))
+			goto nla_put_failure;
 	}
+	return 0;
+
+nla_put_failure:
+	nlmsg_cancel(skb, nlh);
+	return -EMSGSIZE;
 }
 
 static int ib_nl_get_path_rec_attrs_len(ib_sa_comp_mask comp_mask)
@@ -856,7 +873,10 @@ static int ib_nl_send_msg(struct ib_sa_query *query, gfp_t gfp_mask)
 	}
 
 	/* Add attributes */
-	ib_nl_set_path_rec_attrs(skb, query);
+	if (ib_nl_set_path_rec_attrs(skb, query, nlh)) {
+		nlmsg_free(skb);
+		return -EMSGSIZE;
+	}
 
 	/* Repair the nlmsg header length */
 	nlmsg_end(skb, nlh);
-- 
2.17.1

