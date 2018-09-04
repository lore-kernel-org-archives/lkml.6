Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F394CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F8420867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0Ng6nIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F8420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeIDUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:55:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38629 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:55:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id u11-v6so1878591plq.5;
        Tue, 04 Sep 2018 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTck22z5Fb2QfzdSq16kU7wq0iTR4gwoypzlJecOfhs=;
        b=b0Ng6nIO6IgWmLAzTRdB3CEx3vlfsyxJGBGCFIqT9nEfYeDTSzAjRv2jiTGok5SZtI
         NHmuEB8YNsCH+8+X2poiFYqK9Braz6qjhj97PtoJH+d5ODAsjSZLdxK1YU5v1yBrYNqC
         GxWFCOWSjKWiLUD9/JrA9DxghqxQCmtBTIXvbV3Z3c8gienzh5VgnkriiZfeiJTERMaY
         qV6ag8/EfhdIv52ZtM1g33rWqGRhd84rkpoxeuVPL+z4ELFYmL1h8h3Pnz7bmSM0119E
         mmJqLTsIvS/VxCt7hZJxPf9iBQ5nyQpu7uAxamlM67Mr18j4pqs1VdEYpKQM2azYh2zE
         AcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rTck22z5Fb2QfzdSq16kU7wq0iTR4gwoypzlJecOfhs=;
        b=qzNhATzhCk9xTcfK1Hz+Lk3LfN6JrQdydQI5Rx4T/H+TGKqBaP64FOFv67hJ3WYMup
         34gLeqQUKUsfFzDalHbezSHg2/+pweV/JcHhC+zORFj+ppx7cUt2g8UZtm06ax8wnbLp
         0Vmzm13k4xlb950/NuCDYlz9d16xUXHzAVH22QYv50ozUI0wtpXWApdhfSETyF5XZPTR
         8+VyvV7cIMxpBx1kVy+Gx8T06Egk4MS9dgPJpBwbaC0VvvQOhucVsPLWbaHrbcE/nVoq
         u+vTAMKIHlbkDATxvmvfzkakQgNEp6iP48u8w47dpj2EH+MndhiUzbEk+WoLzDDhu2J6
         srRw==
X-Gm-Message-State: APzg51DJAs5ez7rY76MttppYwdRc+B5Z/3RaZ7Z79an2dA0OIhozzojg
        BxBuiIsQbiTm5rWD9zIwPulp7fTp
X-Google-Smtp-Source: ANB0VdZ/oKB12m+wx1CaZrxtddjaRvvJasT+K/Awni/n3QId8Zfe+IU9USG6GmTAIwf5ct4wwNJU2w==
X-Received: by 2002:a17:902:402:: with SMTP id 2-v6mr14153919ple.277.1536078557789;
        Tue, 04 Sep 2018 09:29:17 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id j191-v6sm32243827pfc.136.2018.09.04.09.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 09:29:16 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        Aleksey Makarov <amakarov@marvell.com>
Subject: [PATCH v3 06/15] soc: octeontx2: Convert mbox msg id check to a macro
Date:   Tue,  4 Sep 2018 21:58:36 +0530
Message-Id: <1536078525-31534-7-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
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

