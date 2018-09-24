Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D80ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B02208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwNOMVqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B02208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIYBcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:32:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36663 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIYBcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:32:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so20873803wrt.3;
        Mon, 24 Sep 2018 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpVP9CV2Ulj13zucBn7aflc9vshmpIRkVbgFa2jD/Mg=;
        b=KwNOMVqx8mygsEvSM+JJYMu2Oz+PzW/xntWE14YE1Wsirr96UZFpC3+/nyhRmaWYqW
         h02m21eoFlFhcoenfTio3UwWDWNABaD6Z+OmnYCv9KRdXyguvZ1LOAeLX1N/nOXJQ4wm
         mLBdCcr+3Z1GCD20vsfpoyoAXQtE+V3PatK+WFsdbQPOp/uxt0JWTSJs1mvaKT4BRc/G
         k417BKVgXSixuM5XY4lV11teybO3QakUCY9sOZUakt7z+TgFsmSQoMuBI3lYM0zcNF+M
         eiBJT6ZeylKAb6PrB4FQnOS0tK7WoUY8KYMW12aNOFKSMYnChFjWuUs0KJmwWoqdNGmM
         IKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpVP9CV2Ulj13zucBn7aflc9vshmpIRkVbgFa2jD/Mg=;
        b=jRlnUDa36wvyAhhO+TrZZV8LVO42CpRySqfUx4JR9ryD+sYd3z/4nPeL2FH/+FufkJ
         HXNghe+lkeBphhi1BZUn8c6y0My+A4jakP/cs4yoholztfORWVlpN4VINmphmPmPkvVg
         cr1YoqwtXWN7qum/gbGENAxEAfoxctv12HaIiqm7E5YP8KAoUa3t+Q0IH+nZYOOgX7CQ
         87h/k6tsogZod5r8+GW1SFwIh6fENOkwdPofeNd+YvL7E0/EFpe3dyqYAsgtsL/it2gu
         Le5oK/HTpNmi/UckIVlbb/0k+2xmnBVw5y1p/jaXRP2DtRAH9EeabM2Q0qGo4fzyiaUk
         OvOQ==
X-Gm-Message-State: ABuFfogUqUfPky+wPDs5bzKUZVdfDo5iKPnNqkfcMdYByRPwzaDrFwbG
        Q0Pmhdc6TQ8kxiThFQwlvWA=
X-Google-Smtp-Source: ACcGV616Upttf9gFFLoMN6KZd5keOpIOTiwGzxYMrmuCKIwA12XCGlTmWCOMZmIOtSzEsQYvbEmcmw==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr221433wra.110.1537817348490;
        Mon, 24 Sep 2018 12:29:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id p11-v6sm120595wrd.74.2018.09.24.12.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:29:07 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] iw_cxgb4: Use proper enumerated type in c4iw_bar2_addrs
Date:   Mon, 24 Sep 2018 12:29:03 -0700
Message-Id: <20180924192903.16796-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/infiniband/hw/cxgb4/qp.c:287:8: warning: implicit conversion
from enumeration type 'enum t4_bar2_qtype' to different enumeration type
'enum cxgb4_bar2_qtype' [-Wenum-conversion]
                                                 T4_BAR2_QTYPE_EGRESS,
                                                 ^~~~~~~~~~~~~~~~~~~~

c4iw_bar2_addrs expects a value from enum cxgb4_bar2_qtype so use the
corresponding values from that type so Clang is satisfied without
changing the meaning of the code.

T4_BAR2_QTYPE_EGRESS = CXGB4_BAR2_QTYPE_EGRESS = 0
T4_BAR2_QTYPE_INGRESS = CXGB4_BAR2_QTYPE_INGRESS = 1

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/infiniband/hw/cxgb4/cq.c | 2 +-
 drivers/infiniband/hw/cxgb4/qp.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 6d3042794094..1fd8798d91a7 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -161,7 +161,7 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 	cq->gts = rdev->lldi.gts_reg;
 	cq->rdev = rdev;
 
-	cq->bar2_va = c4iw_bar2_addrs(rdev, cq->cqid, T4_BAR2_QTYPE_INGRESS,
+	cq->bar2_va = c4iw_bar2_addrs(rdev, cq->cqid, CXGB4_BAR2_QTYPE_INGRESS,
 				      &cq->bar2_qid,
 				      user ? &cq->bar2_pa : NULL);
 	if (user && !cq->bar2_pa) {
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 347fe18b1a41..a9e3a11bea54 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -279,12 +279,13 @@ static int create_qp(struct c4iw_rdev *rdev, struct t4_wq *wq,
 
 	wq->db = rdev->lldi.db_reg;
 
-	wq->sq.bar2_va = c4iw_bar2_addrs(rdev, wq->sq.qid, T4_BAR2_QTYPE_EGRESS,
+	wq->sq.bar2_va = c4iw_bar2_addrs(rdev, wq->sq.qid,
+					 CXGB4_BAR2_QTYPE_EGRESS,
 					 &wq->sq.bar2_qid,
 					 user ? &wq->sq.bar2_pa : NULL);
 	if (need_rq)
 		wq->rq.bar2_va = c4iw_bar2_addrs(rdev, wq->rq.qid,
-						 T4_BAR2_QTYPE_EGRESS,
+						 CXGB4_BAR2_QTYPE_EGRESS,
 						 &wq->rq.bar2_qid,
 						 user ? &wq->rq.bar2_pa : NULL);
 
@@ -2572,7 +2573,7 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
 	memset(wq->queue, 0, wq->memsize);
 	pci_unmap_addr_set(wq, mapping, wq->dma_addr);
 
-	wq->bar2_va = c4iw_bar2_addrs(rdev, wq->qid, T4_BAR2_QTYPE_EGRESS,
+	wq->bar2_va = c4iw_bar2_addrs(rdev, wq->qid, CXGB4_BAR2_QTYPE_EGRESS,
 				      &wq->bar2_qid,
 			user ? &wq->bar2_pa : NULL);
 
-- 
2.19.0

