Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA49C468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C765208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI6utc2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C765208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbeGLLLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43099 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeGLLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so23869594lfc.10;
        Thu, 12 Jul 2018 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1joOf1Qp6ILXU0f3GS/58/2P8n2RfW9rnFOUgdECijs=;
        b=VI6utc2F/TKnyr7Jzd47FsFPkdo4++eQRxJuZnKmtgNhNeMF7QsE3DBEilqTVLqZxc
         4aOpITev284Gy3r9OIUY9bBJPoOO3ss0cOTS++RuUKDgjyOFROvc0kojgvqEQ9CiQn1y
         n433R5k680QniPz6wto9cK2V50U6aSsUCrR6XCjTA/EZurYLajPONzSB04R3q/Nu7yTb
         sNojdv/GdpyDiU0oa7235JAseJyzDsZgws8wFU5CPF0rfUibsYhVYmW/DEvUYdgt+byr
         YLHq5V9GVzGXYia8Hwt6QPorgxqq3tEcKoXtVE83Ks1K7w/2dKMPw6XLdGBHy+YDxNK1
         X6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1joOf1Qp6ILXU0f3GS/58/2P8n2RfW9rnFOUgdECijs=;
        b=A9MMMFKLLHYplQVdksH3vziDiKZb9uCtlw222Pc56dmwJymXWV4oXZmxJ6X+y7Etsr
         l+8zSdXyPCAHvBlfc/7xPMzt3D/VB7jGzI2ViSXv91nwoJY1u38o7O9eMuJbhqOSMXCk
         tEFb8iBz0PceiIc2wphATA7s+K8Wq4iSaUvZTEtiOfcTJCR6yFiwW16aogSrwaXJstyS
         TiRM0uCbQeUfwV7gW9Xx5ctEcV4V3RM6k6djLkDzPCpXn+8ycivTtvwh4H8yyyYow/N/
         raNs3UzaXYcNLzvWcNneggseEbbkTmbTGz3QGZx6VrVOWU0JBjwZc2aEH1GNNK1kFLPy
         KMGA==
X-Gm-Message-State: AOUpUlEJ3OSMVEGcNYWbfh5OkwYESRzJrNLqlOCls5rmIvwCUTMrOgFP
        O8x3wggiUuj4qEqpA+44wZaEkcoY
X-Google-Smtp-Source: AAOMgpcM/lb+c/P4IMgKpMAcm41ecL+JrdWrCdm2dLdjebYGAc5SAFTCUSyC5kdOnbBFVllG/LKlfQ==
X-Received: by 2002:a19:9cca:: with SMTP id f193-v6mr1457084lfe.60.1531393346384;
        Thu, 12 Jul 2018 04:02:26 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id p23-v6sm3338490ljh.79.2018.07.12.04.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 04:02:25 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, viro@ZenIV.linux.org.uk,
        davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [V9fs-developer] [PATCH] p9_parse_header() validate PDU length
Date:   Thu, 12 Jul 2018 13:02:11 +0200
Message-Id: <20180712110211.25535-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds checks to the p9_parse_header() function to
verify that the length found within the header coincides with the actual
length of the PDU. Furthermore, it checks that the length stays within the
acceptable range. To do this the patch brings the actual length of the PDU
from the different transport layers (rdma and virtio). For TCP (trans_fd.c)
the length is not know before, so we get it from the header but we check it
anyway that it's within the valid range.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com
---
 net/9p/client.c       | 26 ++++++++++++++++----------
 net/9p/trans_fd.c     | 17 ++++++-----------
 net/9p/trans_rdma.c   |  2 +-
 net/9p/trans_virtio.c |  6 ++++--
 4 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 18c5271910dc..119de44f49e9 100644
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
@@ -498,6 +489,21 @@ p9_parse_header(struct p9_fcall *pdu, int32_t *size, int8_t *type, int16_t *tag,
 	if (size)
 		*size = r_size;
 
+	if (pdu->size != r_size) {
+		err = -EINVAL;
+		goto rewind_and_exit;
+	}
+	if (pdu->size >= pdu->capacity || pdu->size < 7) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "requested packet size too big or too small: %d\n",
+			 pdu->size);
+		return -EIO;
+	}
+	pdu->id = r_type;
+	pdu->tag = r_tag;
+
+	p9_debug(P9_DEBUG_9P, "<<< size=%d type: %d tag: %d\n",
+		 pdu->size, pdu->id, pdu->tag);
 
 rewind_and_exit:
 	if (rewind)
@@ -1575,7 +1581,7 @@ p9_client_read(struct p9_fid *fid, u64 offset, struct iov_iter *to, int *err)
 		int count = iov_iter_count(to);
 		int rsize, non_zc = 0;
 		char *dataptr;
-			
+
 		rsize = fid->iounit;
 		if (!rsize || rsize > clnt->msize-P9_IOHDRSZ)
 			rsize = clnt->msize - P9_IOHDRSZ;
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 588bf88c3305..bf459ee0feab 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -323,22 +323,16 @@ static void p9_read_work(struct work_struct *work)
 	/* header read in */
 	if ((!m->req) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new header\n");
-
-		err = p9_parse_header(&m->rc, NULL, NULL, NULL, 0);
+		/* Header size */
+		m->rc.size = 7;
+		m->rc.capacity = m->client->msize;
+		err = p9_parse_header(&m->rc, &m->rc.size, NULL, NULL, 0);
 		if (err) {
 			p9_debug(P9_DEBUG_ERROR,
 				 "error parsing header: %d\n", err);
 			goto error;
 		}
 
-		if (m->rc.size >= m->client->msize) {
-			p9_debug(P9_DEBUG_ERROR,
-				 "requested packet size too big: %d\n",
-				 m->rc.size);
-			err = -EIO;
-			goto error;
-		}
-
 		p9_debug(P9_DEBUG_TRANS,
 			 "mux %p pkt: size: %d bytes tag: %d\n",
 			 m, m->rc.size, m->rc.tag);
@@ -360,7 +354,7 @@ static void p9_read_work(struct work_struct *work)
 			goto error;
 		}
 		m->rc.sdata = (char *)m->req->rc + sizeof(struct p9_fcall);
-		memcpy(m->rc.sdata, m->tmp_buf, m->rc.capacity);
+		memcpy(m->rc.sdata, m->tmp_buf, 7);
 		m->rc.capacity = m->rc.size;
 	}
 
@@ -369,6 +363,7 @@ static void p9_read_work(struct work_struct *work)
 	 */
 	if ((m->req) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
+		m->req->rc->size = m->rc.offset;
 		spin_lock(&m->client->lock);
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 3d414acb7015..002badbcc9c0 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -319,7 +319,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	if (wc->status != IB_WC_SUCCESS)
 		goto err_out;
-
+	c->rc->size = wc->byte_len;
 	err = p9_parse_header(c->rc, NULL, NULL, &tag, 1);
 	if (err)
 		goto err_out;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 05006cbb3361..6d515f7ebfaf 100644
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
 
@@ -446,7 +448,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		out += pack_sg_list_p(chan->sg, out, VIRTQUEUE_NUM,
 				      out_pages, out_nr_pages, offs, outlen);
 	}
-		
+
 	/*
 	 * Take care of in data
 	 * For example TREAD have 11.
-- 
2.11.0

