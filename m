Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92D5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A6B2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E53wG019"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A6B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeH1OtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:49:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44769 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeH1OtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:49:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so560206plb.11;
        Tue, 28 Aug 2018 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTck22z5Fb2QfzdSq16kU7wq0iTR4gwoypzlJecOfhs=;
        b=E53wG019bO8SmDPDcRw3FM4nHWMnyL9wVxTrtZaXBmNiXmPCmZARMfkJdfFPrx0hYA
         TuOPg/6dQREYWHCfPw5GRuPZE4yn30txo/+fHzLDhmba0/2+/l5iqU1Fn8bAhyiMDfW1
         yhBbbPhsHa1AOB2WeiJSM09RTvWH6s109PJ0oJ2yA3rryF4n9urlXPWRCbsjseaWeCCj
         eFu9kPOqRxBPxZpq24iaSI/uzKxZqIGcgb9Gk5rRVEvfRIMVPDErQVrJAexgbF9zexC/
         au4HQeNnLb7giGaA+jtZGThWlorGDQ107xQxBc0Ux4dhg9/dUIxsW2XDY3ivfnJMyQGh
         tLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTck22z5Fb2QfzdSq16kU7wq0iTR4gwoypzlJecOfhs=;
        b=tQ69LIZjxXnHcVzeC5fDr2Yb7gwZYlLcIvcjl7rTvvYeQqmaAi+fUbBwFmTOl0pRBu
         TOLeRRLdFwC5N64kqYkzhBnNZfd7MnDY6xxZZoLoLeinpFBJd+g35D47Oa1idhk2qXtX
         eZ8ss3vg/i02OjUEVslQw0CHNQd97RQT7igSHZQ7tm28xoHQkfySnYxeosbfjLD4EbwJ
         wjK6lkghvUL1mILtxFYIMVve08aZldiCw5gNoeNi372KpAFIS1mjZClGjI/TrIuLZ3pe
         eeoM62sYmnee7qDkXdnI1yKXu8GAw38JDEmT9p60KX8zzBLxUmmP9mWbzJrrprl9NmaM
         QT6Q==
X-Gm-Message-State: APzg51AuMicxz9a9MTpOCI4QZSUxKxeZLTcvEklQ/49fmAaE/2upJrjD
        BIc3bBMfdQlKbxsb3lPn2VTv/7xz
X-Google-Smtp-Source: ANB0VdZAYKDP9ZcV6w59zWmtvex+5jgLTyjlHEP26FcYlGaitIUXALvkc7+gS+Fk9cyT/NufxL+BIA==
X-Received: by 2002:a17:902:8ec7:: with SMTP id x7-v6mr1032791plo.336.1535453878066;
        Tue, 28 Aug 2018 03:57:58 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id n22-v6sm2946798pfj.68.2018.08.28.03.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 03:57:57 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        Aleksey Makarov <amakarov@marvell.com>
Subject: [PATCH 06/15] soc: octeontx2: Convert mbox msg id check to a macro
Date:   Tue, 28 Aug 2018 16:27:09 +0530
Message-Id: <1535453838-12154-7-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
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

