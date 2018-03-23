Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804241-2-3977121642164247601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804241; b=cVKouQOPY6nxrGs5X1uSOIH97X9h8cGQKvJIjkkPKGPglTZ
    04eD7fgRwxjbwQ5TBHyrpKbwzHKwmriDGr/IdfMBJP4c25oo3Y1eXa/5bmb4WOTx
    CYtBg8khdnEGOhVqs4sNPBMgZUmrcASdR4g8n8d+Svw/5Ub7Rn/bM2H/tE2QFtZM
    S5+lReRPq5+ZnPDQrrd2O9n2Mh0bpZiRPDUQPE0ihs2MVKwjUdoHoJMytsEAupMu
    ZU7fbB/6hmSkwEKJfnx0i+iK7rNYq9o9nXwULPNxX8KIUfc3LJB7f/7544tPo1+w
    1AekKHFlfk9fsVcfDeCwULqHyNQrzXgpNSyQAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804241; bh=6/NbvEXgfHtIJGUSqHRit+P1Xk
    nySUgUNCOXrtMnyHQ=; b=jrCvjKMLI+fXgYKbjAWUCQMYo4nzO1cJQEI1OF8rbX
    4LJ7OFxCXjkvcjZBx1xV8E2mhHIwfqPWrbdlRLuhBNNaoTLkm2ov2ZShU6IUkpXR
    Z2Uq54OKaM6JUgMwME/V0E4YnQsZZKgAYfawM1QvgJZK0an4iVh8XA7yY7kfL6U7
    sbwsPCFNl8LnLAQHRrvBOPRnHE7oN3eN+xa969pYb0LX93QOOcJ3CVLKLDS1gDAe
    4Wd/5qcOzh7notOMhX+56NtbAmaw94KPmkboGts90IYqWv+iHYTp+Ndjm/jPkjq/
    Qi+cQXg5iQ0xeokdJs3JXTTqss1chJvnqETi7kCJyzmg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755407AbeCWKHy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755403AbeCWKHx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 085/177] mtip32xx: use runtime tag to initialize command header
Date: Fri, 23 Mar 2018 10:53:33 +0100
Message-Id: <20180323094209.046257243@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit a4e84aae8139aca9fbfbced1f45c51ca81b57488 ]

mtip32xx supposes that 'request_idx' passed to .init_request()
is tag of the request, and use that as request's tag to initialize
command header.

After MQ IO scheduler is in, request tag assigned isn't same with
the request index anymore, so cause strange hardware failure on
mtip32xx, even whole system panic is triggered.

This patch fixes the issue by initializing command header via
request's real tag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/mtip32xx/mtip32xx.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -169,6 +169,25 @@ static bool mtip_check_surprise_removal(
 	return false; /* device present */
 }
 
+/* we have to use runtime tag to setup command header */
+static void mtip_init_cmd_header(struct request *rq)
+{
+	struct driver_data *dd = rq->q->queuedata;
+	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
+
+	/* Point the command headers at the command tables. */
+	cmd->command_header = dd->port->command_list +
+				(sizeof(struct mtip_cmd_hdr) * rq->tag);
+	cmd->command_header_dma = dd->port->command_list_dma +
+				(sizeof(struct mtip_cmd_hdr) * rq->tag);
+
+	if (host_cap_64)
+		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
+
+	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
+}
+
 static struct mtip_cmd *mtip_get_int_command(struct driver_data *dd)
 {
 	struct request *rq;
@@ -180,6 +199,9 @@ static struct mtip_cmd *mtip_get_int_com
 	if (IS_ERR(rq))
 		return NULL;
 
+	/* Internal cmd isn't submitted via .queue_rq */
+	mtip_init_cmd_header(rq);
+
 	return blk_mq_rq_to_pdu(rq);
 }
 
@@ -3811,6 +3833,8 @@ static int mtip_queue_rq(struct blk_mq_h
 	struct request *rq = bd->rq;
 	int ret;
 
+	mtip_init_cmd_header(rq);
+
 	if (unlikely(mtip_check_unal_depth(hctx, rq)))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
@@ -3842,7 +3866,6 @@ static int mtip_init_cmd(void *data, str
 {
 	struct driver_data *dd = data;
 	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
-	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
 
 	/*
 	 * For flush requests, request_idx starts at the end of the
@@ -3859,17 +3882,6 @@ static int mtip_init_cmd(void *data, str
 
 	memset(cmd->command, 0, CMD_DMA_ALLOC_SZ);
 
-	/* Point the command headers at the command tables. */
-	cmd->command_header = dd->port->command_list +
-				(sizeof(struct mtip_cmd_hdr) * request_idx);
-	cmd->command_header_dma = dd->port->command_list_dma +
-				(sizeof(struct mtip_cmd_hdr) * request_idx);
-
-	if (host_cap_64)
-		cmd->command_header->ctbau = __force_bit2int cpu_to_le32((cmd->command_dma >> 16) >> 16);
-
-	cmd->command_header->ctba = __force_bit2int cpu_to_le32(cmd->command_dma & 0xFFFFFFFF);
-
 	sg_init_table(cmd->sg, MTIP_MAX_SG);
 	return 0;
 }
