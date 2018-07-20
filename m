Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D8FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B068620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8FitExC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B068620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeGTOQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:16:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39275 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbeGTOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:16:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id a134-v6so1807342lfe.6;
        Fri, 20 Jul 2018 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k8XIvvLyAABzUp2LyIk88Y5yrKyYx/KgnzhQ7AveH5g=;
        b=Y8FitExC7F5iZif23xx3LdSe0TuupubDZFtPMBqzXgG7I0jMt2SjlaebYLUBntTGNU
         q7WQ247bpzrV18qcLSV/EZpO7VyT1BENHheyM1jiINmsuHE75P1pV6IS5DdxsMPemOiJ
         uy0Q1QFs9dteIslCIbH1MbgH4L4tLkNI83xSLzgRv3ICUqaxD3TSUAcGMjSrnETqETE/
         OYTVflgfPuKOG3vovE9KxGb/Ij5D4Q49X69635dR4d3AVr5FUlAhuole0SqHIYkp+Zhm
         C8DSJmpQO3czVNJ0gunuZauLIY5AXNqDxvyNVEm9N8/q6auyVWUwzKN81tFP8/A9xhL8
         fw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k8XIvvLyAABzUp2LyIk88Y5yrKyYx/KgnzhQ7AveH5g=;
        b=uefAjZlYI1XNSMT0CfWcGksl0y19xOIJz5SjpXXeiX4gNYWo45jIJ9jfgHqohh0tco
         MHBL0Pr3XCkOqukwpxHFkcX7BuJ69m/9mrVwOFXERGdwi7POFf4vvj7vSJFJEoYzG3Qk
         CYi30zZ71URtM+DNvNo4DefGlWmzB33ZLU+CW/lhYMPtGkrNiyoD7JndkJu47cpKMykp
         f8D3gASkDbgXDZIDH/v/AwEVLSleGvSns1z8pfRz2tT2dNffg4jmc2S4ewuFvgOADgtp
         aNAi5CQSRZw7RnY9JZ/BR3oMVCTGsQ7jdlNCPNXMUUgrqmStGZ6rAPSYbs+RrPFcLKhy
         GZKw==
X-Gm-Message-State: AOUpUlEpQc3OWrSg3vi0mFifoN9p0jXE3Js4lpfuH+JE3jpNHtxzHKYV
        dyhl+O3Dlk+UMKfgSGorrvM=
X-Google-Smtp-Source: AAOMgpe3e5K3/27QwS52QnI1/RUsZsbVUH7TvWsm6D6Iwnqk8VQfoT00a2VLQ+k8TUnVDPnW5I9hlg==
X-Received: by 2002:a19:cf95:: with SMTP id f143-v6mr1497258lfg.101.1532093301082;
        Fri, 20 Jul 2018 06:28:21 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id g28-v6sm299029lfh.92.2018.07.20.06.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 06:28:20 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     jiangyiwen@huawei.com, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] net/9p/trans_fd.c: fix double list_del() and race in access
Date:   Fri, 20 Jul 2018 15:28:01 +0200
Message-Id: <20180720132801.22749-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses list_del_init() instead of list_del() to eliminate "req_list". This to prevent double list_del()'s calls to the same list from provoking a GPF. Furthermore, this patch fixes an access to "req_list" that was made without getting the relative lock.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
---

 net/9p/trans_fd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index a64b01c56e30..131bb1f059e6 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -223,7 +223,9 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 
 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
 		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
-		list_del(&req->req_list);
+		spin_lock_irqsave(&m->client->lock, flags);
+		list_del_init(&req->req_list);
+		spin_unlock_irqrestore(&m->client->lock, flags);
 		if (!req->t_err)
 			req->t_err = err;
 		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
@@ -369,7 +371,7 @@ static void p9_read_work(struct work_struct *work)
 		spin_lock(&m->client->lock);
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
-		list_del(&m->req->req_list);
+		list_del_init(&m->req->req_list);
 		spin_unlock(&m->client->lock);
 		p9_client_cb(m->client, m->req, status);
 		m->rc.sdata = NULL;
@@ -684,7 +686,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
 	spin_lock(&client->lock);
 
 	if (req->status == REQ_STATUS_UNSENT) {
-		list_del(&req->req_list);
+		list_del_init(&req->req_list);
 		req->status = REQ_STATUS_FLSHD;
 		ret = 0;
 	}
@@ -701,7 +703,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 	 * remove it from the list.
 	 */
 	spin_lock(&client->lock);
-	list_del(&req->req_list);
+	list_del_init(&req->req_list);
 	spin_unlock(&client->lock);
 
 	return 0;
-- 
2.11.0

