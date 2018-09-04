Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C14C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A6520645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blsfUuB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A6520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeIDQU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:20:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46098 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:20:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so1563679pfn.13;
        Tue, 04 Sep 2018 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTck22z5Fb2QfzdSq16kU7wq0iTR4gwoypzlJecOfhs=;
        b=blsfUuB/fKiCPAlfPuopDoVBQ7jUCV35NqynYNtJH2nj5fGgpd/gkpZ6glhljqy3jN
         hHHyWoKAvZrhJAHbJCJe1gUDDaDG9QMI3WKy8y8wK+nMCwuiGAQ6j8W9hta1EAIyG01U
         fFKBlsIQq/Co7oG7AQtMRAYmdbNDa0cpIFQHVp5qJmQpmheJPn4QfeCvkU1tIK1kRkHw
         xyGCiWWdwMT4gmfw400Ddg/grqSzZWarmqVV5RjHa/B94AZIk4CjFGza8eJIC65XYOLY
         HKrj6S33aosY1Dwmv9sS0UmSKeme4QVhaNWT50eX70OQGZSzqV76zurwgGdHJ//9IV0u
         ijXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTck22z5Fb2QfzdSq16kU7wq0iTR4gwoypzlJecOfhs=;
        b=fJ594BS4bnCEwgL9Ti5DmoFvjVK5L1hgZMgZrZHq5DYz1w2XEWtzETk1g9KHq98nBt
         1M7FIAWSumVT/1xdWG+PrRnMQeelwixt7bPwOWw2WdryjvAvIOpKj1aoc+Z6HTg5VJOJ
         Gc+fLV+KE85kEjd8dAXoziU+lWtijDh29/XEUCCMqvcMisIIWdHW7RHG9Cgut8ERHZ4q
         a2aGNPfRRirNG++JxvOOCr9xyUENlmdFkUf/Q3IsPkP0zBEfqbvRujHTVnwyaTod9mbf
         iwwSQwRnvJcU4t5kfOYuCrUyr84F4O8wo2j43XEaJt5zX8Ai51z5cU03hbWQqCbJDyZL
         fGKQ==
X-Gm-Message-State: APzg51CjzKxQ7n2PmDQ3KTdufTVdDKEo7xXcBz3cMl7G2CNs4dc0IFXG
        Al1wFoqiloAzmbhdy+u0snlpng1l
X-Google-Smtp-Source: ANB0VdZozI0CjPwLHGI3vTNU+MqWls4AO9BdZXUTZ7Bx2D/iE4ALgfhiE6bAm1UlR8eJYkB+S6ncrQ==
X-Received: by 2002:a63:5964:: with SMTP id j36-v6mr30731170pgm.222.1536062137144;
        Tue, 04 Sep 2018 04:55:37 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id u184-v6sm29740190pgd.46.2018.09.04.04.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 04:55:36 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net,
        Aleksey Makarov <amakarov@marvell.com>
Subject: [PATCH v2 06/15] soc: octeontx2: Convert mbox msg id check to a macro
Date:   Tue,  4 Sep 2018 17:24:41 +0530
Message-Id: <1536062090-30446-7-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksey Makarov <amakarov@marvell.com>

With 10's of mailbox messages expected to be handled in future,
checking for message id could become a lengthy switch case. Hence
added a macro to auto generate the switch case for each msg id.

Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
---
 drivers/soc/marvell/octeontx2/rvu.c | 44 ++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/marvell/octeontx2/rvu.c b/drivers/soc/marvell/octeontx2/rvu.c
index e795c2f..25f79bf 100644
--- a/drivers/soc/marvell/octeontx2/rvu.c
+++ b/drivers/soc/marvell/octeontx2/rvu.c
@@ -258,6 +258,12 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	return 0;
 }
 
+static int rvu_mbox_handler_READY(struct rvu *rvu, struct msg_req *req,
+				  struct ready_msg_rsp *rsp)
+{
+	return 0;
+}
+
 static int rvu_process_mbox_msg(struct rvu *rvu, int devid,
 				struct mbox_msghdr *req)
 {
@@ -265,13 +271,39 @@ static int rvu_process_mbox_msg(struct rvu *rvu, int devid,
 	if (req->sig != OTX2_MBOX_REQ_SIG)
 		goto bad_message;
 
-	if (req->id == MBOX_MSG_READY)
-		return 0;
-
+	switch (req->id) {
+#define M(_name, _id, _req_type, _rsp_type)				\
+	case _id: {							\
+		struct _rsp_type *rsp;					\
+		int err;						\
+									\
+		rsp = (struct _rsp_type *)otx2_mbox_alloc_msg(		\
+			&rvu->mbox, devid,				\
+			sizeof(struct _rsp_type));			\
+		if (rsp) {						\
+			rsp->hdr.id = _id;				\
+			rsp->hdr.sig = OTX2_MBOX_RSP_SIG;		\
+			rsp->hdr.pcifunc = req->pcifunc;		\
+			rsp->hdr.rc = 0;				\
+		}							\
+									\
+		err = rvu_mbox_handler_ ## _name(rvu,			\
+						 (struct _req_type *)req, \
+						 rsp);			\
+		if (rsp && err)						\
+			rsp->hdr.rc = err;				\
+									\
+		return rsp ? err : -ENOMEM;				\
+	}
+MBOX_MESSAGES
+#undef M
+		break;
 bad_message:
-	otx2_reply_invalid_msg(&rvu->mbox, devid, req->pcifunc,
-			       req->id);
-	return -ENODEV;
+	default:
+		otx2_reply_invalid_msg(&rvu->mbox, devid, req->pcifunc,
+				       req->id);
+		return -ENODEV;
+	}
 }
 
 static void rvu_mbox_handler(struct work_struct *work)
-- 
2.7.4

