Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A69ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B3820852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pktWMPqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B3820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbeGWQqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:46:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32996 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388068AbeGWQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:46:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so956469ljj.0;
        Mon, 23 Jul 2018 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S2vp7wIiLTtVes09q9AhvVh/4crBSVkDyIIaM012ufg=;
        b=pktWMPqkJctUPA7Xl7V2saDPz9eIVEhA9332kwZA5OzcSCpO15CTlWDK+NuiL8HK6C
         oEZ//Tmxv7GCd6W1re2em9CDw7reVXPOof1/zjyieGSZZooyWb03Bo76XSYsr7IallmR
         8ZN/ZNAlQ5UNXa1jEVnjpf/mAKqi70927aLCRl2kMvG6ZNyYRTn7Xfriaj/zKxxOqLQu
         HyHE8WYZiF8YR79tiqcRfwCeKenzWC45gzaolSQzWpj6gc7GcP0r+mNE5d3+t7WUb8Jv
         yoJRvMb+XlpSmY4Tcu5PVxGVzC9SNEdMNCUeltM7yhZKAoeNjEf3Rea4FhdLOpmhHYJj
         SM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S2vp7wIiLTtVes09q9AhvVh/4crBSVkDyIIaM012ufg=;
        b=U2G0r0S1nHGD9y1nQmxPbI4B9Y2BZGAa/PW48YzbipoBLwk7+N+v6wN2FvdDUt/Khp
         jSnc7QI3sCPVzywgB0BXOhMhgsg+fk7AuMsGdjK1YtFJUBGNl+xdAmEa5sUMB6eo/B+o
         IRWxBe5oju9kOIYjNxFi7y+XCNWvu2ORuHhf1BFSkP0eFssqdwkx9cOjFa1DXT/OOil2
         KBNnibYmOZYG6xBGB+S/kcdcS03+UfRh+6JP0ORV/+Z2nDSoi0yk+cVOBkrsBrAIp44F
         auH1amG1jPUTZPcvknb2da6S82/HNyA+R75nc5KxtF8vFt1QfaEhYuLCNjWiBQzgUtnW
         RiXQ==
X-Gm-Message-State: AOUpUlHu7KrhCccHzlGJXLX9vf2VNfucUpbIrPDwoyzxoOXtklLvCSlq
        4/YNzUgpr4n33GA42Y+j2TE=
X-Google-Smtp-Source: AAOMgpfyW/l5EabBqyw5zchpOLXa5gazb1K7vwV0enEw2ToNEL7WA/fQUyRkMCp7xxuVyHUgnxeqiw==
X-Received: by 2002:a2e:4103:: with SMTP id o3-v6mr8993428lja.3.1532360651062;
        Mon, 23 Jul 2018 08:44:11 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id t8-v6sm717345lfd.2.2018.07.23.08.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 08:44:10 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] 9p: validate PDU length
Date:   Mon, 23 Jul 2018 17:44:04 +0200
Message-Id: <20180723154404.2406-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds length check for the PDU size.
The size contained in the header has to match the actual size,
except for TCP (trans_fd.c) where actual length is not known ahead
and the header's length will be checked only against the validity
range.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
---
 net/9p/client.c       | 25 ++++++++++++++++---------
 net/9p/trans_fd.c     |  5 ++++-
 net/9p/trans_rdma.c   |  1 +
 net/9p/trans_virtio.c |  4 +++-
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 18c5271910dc..92240ccf476b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -477,20 +477,11 @@ p9_parse_header(struct p9_fcall *pdu, int32_t *size, int8_t *type, int16_t *tag,
 	int err;
 
 	pdu->offset = 0;
-	if (pdu->size == 0)
-		pdu->size = 7;
 
 	err = p9pdu_readf(pdu, 0, "dbw", &r_size, &r_type, &r_tag);
 	if (err)
 		goto rewind_and_exit;
 
-	pdu->size = r_size;
-	pdu->id = r_type;
-	pdu->tag = r_tag;
-
-	p9_debug(P9_DEBUG_9P, "<<< size=%d type: %d tag: %d\n",
-		 pdu->size, pdu->id, pdu->tag);
-
 	if (type)
 		*type = r_type;
 	if (tag)
@@ -498,6 +489,16 @@ p9_parse_header(struct p9_fcall *pdu, int32_t *size, int8_t *type, int16_t *tag,
 	if (size)
 		*size = r_size;
 
+	if (pdu->size != r_size || r_size < 7) {
+		err = -EINVAL;
+		goto rewind_and_exit;
+	}
+
+	pdu->id = r_type;
+	pdu->tag = r_tag;
+
+	p9_debug(P9_DEBUG_9P, "<<< size=%d type: %d tag: %d\n",
+		pdu->size, pdu->id, pdu->tag);
 
 rewind_and_exit:
 	if (rewind)
@@ -524,6 +525,12 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 	int ecode;
 
 	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
+	if (req->rc->size >= c->msize) {
+		p9_debug(P9_DEBUG_ERROR,
+			"requested packet size too big: %d\n",
+			req->rc->size);
+			return -EIO;
+	}
 	/*
 	 * dump the response from server
 	 * This should be after check errors which poplulate pdu_fcall.
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 588bf88c3305..65533c437b7f 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -324,7 +324,9 @@ static void p9_read_work(struct work_struct *work)
 	if ((!m->req) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new header\n");
 
-		err = p9_parse_header(&m->rc, NULL, NULL, NULL, 0);
+		/* Header size */
+		m->rc.size = 7;
+		err = p9_parse_header(&m->rc, &m->rc.size, NULL, NULL, 0);
 		if (err) {
 			p9_debug(P9_DEBUG_ERROR,
 				 "error parsing header: %d\n", err);
@@ -369,6 +371,7 @@ static void p9_read_work(struct work_struct *work)
 	 */
 	if ((m->req) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
+		m->req->rc->size = m->rc.offset;
 		spin_lock(&m->client->lock);
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 3d414acb7015..2649b2ebf961 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -320,6 +320,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS)
 		goto err_out;
 
+	c->rc->size = wc->byte_len;
 	err = p9_parse_header(c->rc, NULL, NULL, &tag, 1);
 	if (err)
 		goto err_out;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 05006cbb3361..fc6dc9ca86a4 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -159,8 +159,10 @@ static void req_done(struct virtqueue *vq)
 		spin_unlock_irqrestore(&chan->lock, flags);
 		/* Wakeup if anyone waiting for VirtIO ring space. */
 		wake_up(chan->vc_wq);
-		if (len)
+		if (len) {
+			req->rc->size = len;
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
+		}
 	}
 }
 
-- 
2.11.0

