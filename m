Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF0AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A4420875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elo8++oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A4420875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbeGWNUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:20:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42351 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbeGWNUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:20:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so357429ljc.9;
        Mon, 23 Jul 2018 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hv32lahhaRqGCgdud2Rs8jGB7WzXUbmwdFisszOca0M=;
        b=Elo8++oj3KacK1tHDAwDHSIeL9K1YiGlyUndptjuEgeZFdpa2xxKuyQNI95HyaoVSS
         PzNQFtlZdIAVM5ixsQQpQYJ5Lli6CrVoM7z8fgVEOgojx/mzyk3CPQsckGhNISamJZkE
         q8G55X3oQbIR4COdArquxk3a3Yp+1+QL/27IWZAK1cLvqVNG9FCP5DTNFvDWUqu3p0oo
         tCxpn2AF/GuTtcNxdnY97+Z8CH7Dd1zYX4O3FiKXH5Ux8jvHJpbuFjR+fDFb/1dx/3mt
         PTqIqVeTTw3ZJ0xn+7s19lRIihwzw7P8vxxmGD3xISxPtBT/ZRZh/zIXhEjdYXJinDD+
         Fx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hv32lahhaRqGCgdud2Rs8jGB7WzXUbmwdFisszOca0M=;
        b=a8tqjO2zk5iBn9oN6lz9EH2FzQmwbwPc0FvPtInEnh0TI0k0L7T+uw8SSUimIaqISm
         dSMrCqxUP7+RvLXpVpMALnHHgq2oHNRlFl9mwF9eQKhAUdzEFyOQuo+ERKj4CofLTYVu
         tySxMbTzgPchL1dHqop72b9JYRNmTtYHFexkZ7CtJ/rbmYo2xES0hO90IliQcuve+ZAJ
         DEaxh60K1lpJj07e0bBqhe/k5hgie3j+XIWhjQ8pRB4j1v2rKR5jiecw4rGkLYMDj44Z
         WrEyPjxZg6SqWfV9af3Ob1iQOSx+GYAIOS4L1Bln+HOPL7hRnkk2Qx0sbznnoNSiSThf
         nIaw==
X-Gm-Message-State: AOUpUlFotZyCc/ASzeU8RydSEd6eyS1pvy/BqRqutAuUlj3Ry8M07w+W
        n7f0Lp/xFoyXTNHCfYqzBQ4=
X-Google-Smtp-Source: AAOMgpcENSq91pcjhawmEbZ6Wzv3uhPFyG5kXFNvqNA7pW2YCZmmE7xZkitIcGAFM3Eu6ZOyCXobgA==
X-Received: by 2002:a2e:9448:: with SMTP id o8-v6mr8635385ljh.34.1532348366641;
        Mon, 23 Jul 2018 05:19:26 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id w12-v6sm1824757lji.63.2018.07.23.05.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 05:19:25 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, jiangyiwen@huawei.com, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] net/p9/trans_fd.c: fix double list_del()
Date:   Mon, 23 Jul 2018 14:19:02 +0200
Message-Id: <20180723121902.20201-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A double list_del(&req->req_list) is possible in p9_fd_cancel() as
shown by Syzbot. To prevent it we have to ensure that we have the
client->lock when deleting the list. Furthermore, we have to update
the status of the request before releasing the lock, to prevent the
race.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
---
 net/9p/trans_fd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index a64b01c56e30..370c6c69a05c 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -199,15 +199,14 @@ static void p9_mux_poll_stop(struct p9_conn *m)
 static void p9_conn_cancel(struct p9_conn *m, int err)
 {
 	struct p9_req_t *req, *rtmp;
-	unsigned long flags;
 	LIST_HEAD(cancel_list);
 
 	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);
 
-	spin_lock_irqsave(&m->client->lock, flags);
+	spin_lock(&m->client->lock);
 
 	if (m->err) {
-		spin_unlock_irqrestore(&m->client->lock, flags);
+		spin_unlock(&m->client->lock);
 		return;
 	}
 
@@ -219,7 +218,6 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
 	}
-	spin_unlock_irqrestore(&m->client->lock, flags);
 
 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
 		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
@@ -228,6 +226,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 			req->t_err = err;
 		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
 	}
+	spin_unlock(&m->client->lock);
 }
 
 static __poll_t
@@ -370,12 +369,12 @@ static void p9_read_work(struct work_struct *work)
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
 		list_del(&m->req->req_list);
-		spin_unlock(&m->client->lock);
 		p9_client_cb(m->client, m->req, status);
 		m->rc.sdata = NULL;
 		m->rc.offset = 0;
 		m->rc.capacity = 0;
 		m->req = NULL;
+		spin_unlock(&m->client->lock);
 	}
 
 end_clear:
-- 
2.11.0

