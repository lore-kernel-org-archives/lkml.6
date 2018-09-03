Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7623BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119A220645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G43DOKV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119A220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeICUYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:24:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37501 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbeICUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:24:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so852750ljk.4;
        Mon, 03 Sep 2018 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2CeYnZkPWqSRcb9crdzsMKcPrVArD7nVmCVyTDpQdWQ=;
        b=G43DOKV8/thwollLzOTyUlf4CrNCtNPKFUAQ9wxtzOpPRUb2NFAwnp3HnfqqIxLonQ
         CBo3fHg9EFK7PMpUv1jYMGciWR2snj9FodoJs+Z8FCEc+dluCcQOKHOVaeVnu1S/OnVL
         t9MBBZAWaqQBeywHQrdEmBubVNGVLrMZ+yGuYh4TCeQlJoCQPTHsXBVtF8ahq2uYuPBZ
         K36Zza7lneWIntDaq86zEUceZ7jKALIhQOPKBVk4FFl8CoynDf3AUIk/rElOVu9Ns2/T
         T8isklEWpLSZIhKftWMNq+Y2TE8nBOfu+yXRiLjtI5xaCnoxS5/0V194piAOr2210WZd
         59Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2CeYnZkPWqSRcb9crdzsMKcPrVArD7nVmCVyTDpQdWQ=;
        b=eHVbEbxPEfxWAsAHgTT2TM2dLilg0Mzy9HT/o+vPiFIINXxrUe9OitTquy5+B7pTvO
         J6b3eP67hK10lMImOro4Lq4R2Xo3YUbk1SBnuFrOGU241/dJtL978N11a3AyjPSUVPYq
         nP2Mwfegj1lNdDk51mhs/aYrrtsVNZpgYM20zBWn4Z5SCzFGy/1ApBgLZqE3zAgsI7GR
         hNA6/J+nJUxmBliWzIKn1w6Ur8n7jEVOWQ8cE3QEOLv1P0fxqI3dMFpbMhwc4/Gtl2Rz
         dEViETpgVAwTX3+m97+LizEVEsnaE/uJv16Qx03c4PExWe2oz0xO+2WfsYqwn2MDEi4d
         LxUA==
X-Gm-Message-State: APzg51A/4e9qddSqZfObtxtxH35aQVfo3Qw9E7ojoMQQNJ7Fd4y+AgxQ
        PsU9aACVKVYZBTYZ8We+nO8MOkpyn/B02A==
X-Google-Smtp-Source: ANB0VdatQnjhUYRYvMkrLxa0TdwxuvATAgEz91sgGixynmqYbKo3lg8mjtxdwHuG5NdeGngaiZe3dA==
X-Received: by 2002:a2e:2c0d:: with SMTP id s13-v6mr17671532ljs.106.1535990607803;
        Mon, 03 Sep 2018 09:03:27 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id z189-v6sm3551115lfa.14.2018.09.03.09.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 09:03:26 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     asmadeus@codewreck.org
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] 9p: Rename req to rreq
Date:   Mon,  3 Sep 2018 18:03:21 +0200
Message-Id: <20180903160321.2181-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In struct p9_conn, rename req to rreq as it is used by the read routine.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Suggested-by: Jun Piao <piaojun@huawei.com>
---
 net/9p/trans_fd.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 686e24e355d0..743c8bf571f6 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -131,7 +131,7 @@ struct p9_conn {
 	int err;
 	struct list_head req_list;
 	struct list_head unsent_req_list;
-	struct p9_req_t *req;
+	struct p9_req_t *rreq;
 	struct p9_req_t *wreq;
 	char tmp_buf[7];
 	struct p9_fcall rc;
@@ -323,7 +323,7 @@ static void p9_read_work(struct work_struct *work)
 	m->rc.offset += err;
 
 	/* header read in */
-	if ((!m->req) && (m->rc.offset == m->rc.capacity)) {
+	if ((!m->rreq) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new header\n");
 
 		/* Header size */
@@ -347,23 +347,23 @@ static void p9_read_work(struct work_struct *work)
 			 "mux %p pkt: size: %d bytes tag: %d\n",
 			 m, m->rc.size, m->rc.tag);
 
-		m->req = p9_tag_lookup(m->client, m->rc.tag);
-		if (!m->req || (m->req->status != REQ_STATUS_SENT)) {
+		m->rreq = p9_tag_lookup(m->client, m->rc.tag);
+		if (!m->rreq || (m->rreq->status != REQ_STATUS_SENT)) {
 			p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n",
 				 m->rc.tag);
 			err = -EIO;
 			goto error;
 		}
 
-		if (m->req->rc.sdata == NULL) {
+		if (m->rreq->rc.sdata == NULL) {
 			p9_debug(P9_DEBUG_ERROR,
 				 "No recv fcall for tag %d (req %p), disconnecting!\n",
-				 m->rc.tag, m->req);
-			m->req = NULL;
+				 m->rc.tag, m->rreq);
+			m->rreq = NULL;
 			err = -EIO;
 			goto error;
 		}
-		m->rc.sdata = m->req->rc.sdata;
+		m->rc.sdata = m->rreq->rc.sdata;
 		memcpy(m->rc.sdata, m->tmp_buf, m->rc.capacity);
 		m->rc.capacity = m->rc.size;
 	}
@@ -371,21 +371,21 @@ static void p9_read_work(struct work_struct *work)
 	/* packet is read in
 	 * not an else because some packets (like clunk) have no payload
 	 */
-	if ((m->req) && (m->rc.offset == m->rc.capacity)) {
+	if ((m->rreq) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
-		m->req->rc.size = m->rc.offset;
+		m->rreq->rc.size = m->rc.offset;
 		spin_lock(&m->client->lock);
-		if (m->req->status != REQ_STATUS_ERROR)
+		if (m->rreq->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
-		list_del(&m->req->req_list);
+		list_del(&m->rreq->req_list);
 		/* update req->status while holding client->lock  */
-		p9_client_cb(m->client, m->req, status);
+		p9_client_cb(m->client, m->rreq, status);
 		spin_unlock(&m->client->lock);
 		m->rc.sdata = NULL;
 		m->rc.offset = 0;
 		m->rc.capacity = 0;
-		p9_req_put(m->req);
-		m->req = NULL;
+		p9_req_put(m->rreq);
+		m->rreq = NULL;
 	}
 
 end_clear:
-- 
2.11.0

