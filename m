Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A212086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YbRLJotT";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YbRLJotT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A212086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJPQnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:43:10 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:36995 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbeJPQnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:43:10 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id C4F6721791;
        Tue, 16 Oct 2018 11:53:44 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ZxjR3eIYjD-ril4DhOI;
        Tue, 16 Oct 2018 11:53:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1539680024; bh=4hAh7JEoaIX8K3feQAchPgL9Ih9RzxYXRxnhAu/DNKw=;
        h=Subject:From:To:Date:Message-ID;
        b=YbRLJotTyDpM+GMChONwGz1v9Sx2AiwGQ4nmnrYbZsSJ0LZN2fzrk9cS1jIvxxrXQ
         z21xukjqlkoBLxObfPGQUU39w77drXjPKqEviIU/IXhkhnJ/Kz9F0N25Y4ksOH/WU8
         thg4MshbQ9auWDEzS9G6bycYi6dJ7kA15g7Ffc5s=
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b010:d005::1:29])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id AfYdSvkeAI-riWaLQ6Q;
        Tue, 16 Oct 2018 11:53:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1539680024; bh=4hAh7JEoaIX8K3feQAchPgL9Ih9RzxYXRxnhAu/DNKw=;
        h=Subject:From:To:Date:Message-ID;
        b=YbRLJotTyDpM+GMChONwGz1v9Sx2AiwGQ4nmnrYbZsSJ0LZN2fzrk9cS1jIvxxrXQ
         z21xukjqlkoBLxObfPGQUU39w77drXjPKqEviIU/IXhkhnJ/Kz9F0N25Y4ksOH/WU8
         thg4MshbQ9auWDEzS9G6bycYi6dJ7kA15g7Ffc5s=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] block: fix comments about choosing request list
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Date:   Tue, 16 Oct 2018 11:53:41 +0300
Message-ID: <153968002141.396220.12979757828960821275.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request list is determined by blk_get_rl() and without queue_lock.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/blk-cgroup.h |    8 ++++----
 include/linux/blkdev.h     |    9 +++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6d766a19f2bb..dbff5a25f810 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -520,10 +520,10 @@ static inline void blkg_put(struct blkcg_gq *blkg)
  * @q: request_queue of interest
  * @bio: bio which will be attached to the allocated request (may be %NULL)
  *
- * The caller wants to allocate a request from @q to use for @bio.  Find
- * the request_list to use and obtain a reference on it.  Should be called
- * under queue_lock.  This function is guaranteed to return non-%NULL
- * request_list.
+ * The caller wants to allocate a request from @q to use for @bio.
+ * Find the request_list to use and obtain a reference on it.
+ *
+ * This function is guaranteed to return non-%NULL request_list.
  */
 static inline struct request_list *blk_get_rl(struct request_queue *q,
 					      struct bio *bio)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6980014357d4..b5fec0bc72f2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -444,10 +444,11 @@ struct request_queue {
 	struct rq_qos		*rq_qos;
 
 	/*
-	 * If blkcg is not used, @q->root_rl serves all requests.  If blkcg
-	 * is used, root blkg allocates from @q->root_rl and all other
-	 * blkgs from their own blkg->rl.  Which one to use should be
-	 * determined using bio_request_list().
+	 * If blkcg is not used, @q->root_rl serves all requests.
+	 * If blkcg is used, root blkg allocates from @q->root_rl and
+	 * all other blkgs from their own blkg->rl.
+	 *
+	 * Which one to use should be determined using blk_get_rl().
 	 */
 	struct request_list	root_rl;
 

