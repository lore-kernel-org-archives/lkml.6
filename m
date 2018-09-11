Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F99C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D1920865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZuNmPTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D1920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeIKXmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:53 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45591 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKXmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:31 -0400
Received: by mail-yb1-f193.google.com with SMTP id h22-v6so9713332ybg.12;
        Tue, 11 Sep 2018 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r2kxmE2i/F4zOX3cOoXMsnwx5/PIHFb0myqGCKQDXp8=;
        b=tZuNmPTwD++oiilT/SKFfVULg1rxGXW6srQaCTr04qW0cVciRTV5lzHvQurnUDbR9S
         llwwaZ1SwqS6vKH/uRmSlH+ITvlRmRVjgvIK57VjYCvS8b5HS4M/6ez7ixHpkvVuoQ5y
         CJjmws4EfPwseBRRXBGqXFU3FnbcBww8pTN+3YvfM2aeItvfjYt2aq6QyLGrL5IuoKa7
         666KDlW9aPbob9Pg6IqOb++VDEbZAcpdbLU4j/bHtqmN67tU9kfKhaicyqjPmD5Dzmq3
         w86C42pzxSPdb3S26HRTyORjWXRc46Wd87zC33NFnnJ7zNoRl0yJrvedYk9PloZQ0/0g
         ygxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r2kxmE2i/F4zOX3cOoXMsnwx5/PIHFb0myqGCKQDXp8=;
        b=gtHQiS5ndzO1CoQom9M4PQ5wvzQMDRwn5VFK7EgKZvHcK5R6CMZuFrLDG0UjLWk6nO
         3FX5QtAOqRyZ+YBF0iGaxgo3rOJUFP+OshlAnSNZH+KDrG81ULAZY14oAl46j679BYEO
         5Qj3jJoqx/o89z1amF6BnM+VE+EGDDTk308GyIyJMPjpcnscGPLM61oMKEqZ9Cw4Hf44
         GMvCnPH3srdUmtihA5dpjNsUY7Drneyz3cZtqh2fOmruRC3oLoEi9YVNCrd290YXFpAJ
         2hXSfoagZBweOTs3jAZqkCzfd+7p4MLABNpcYKVLHz1tSWmOy/m1yGtaV6/m/BFz3AfJ
         jfZA==
X-Gm-Message-State: APzg51DLLtlmOrYFXyaAVxo6d3jykN0uXXWJ66QtqKMRmvkmHZq0OmYE
        mpazT0mfZtHUaD/db51iYAM=
X-Google-Smtp-Source: ANB0VdaHkU2p3IGJxzGy2ULStRpRbMdsR8aZ+E6JzrwiU55GQp3d4BSD6ysNPvAJlnHL5DNbUSQtHg==
X-Received: by 2002:a25:ea51:: with SMTP id o17-v6mr1341956ybe.172.1536691314982;
        Tue, 11 Sep 2018 11:41:54 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:53 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: [PATCH 10/12] blkcg: cleanup and make blk_get_rl use blkg_lookup_create
Date:   Tue, 11 Sep 2018 14:41:35 -0400
Message-Id: <20180911184137.35897-11-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180911184137.35897-1-dennisszhou@gmail.com>
References: <20180911184137.35897-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

blk_get_rl is responsible for identifying which request_list a request
should be allocated to. Try get logic was added earlier, but
semantically the logic was not changed.

This patch makes better use of the bio already having a reference to the
blkg in the hot path. The cold path uses a better fallback of
blkg_lookup_create rather than just blkg_lookup and then falling back to
the q->root_rl. If lookup_create fails with anything but -ENODEV, it
falls back to q->root_rl.

A clarifying comment is added to explain why q->root_rl is used rather
than the root blkg's rl.

Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 2951ea3541b1..d2f7f1b00fcf 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -586,28 +586,36 @@ static inline struct request_list *blk_get_rl(struct request_queue *q,
 
 	rcu_read_lock();
 
-	blkcg = bio_blkcg(bio);
-	if (!blkcg)
-		blkcg = css_to_blkcg(blkcg_css());
+	if (bio && bio->bi_blkg) {
+		blkcg = bio->bi_blkg->blkcg;
+		if (blkcg == &blkcg_root)
+			goto rl_use_root;
+
+		blkg_get(bio->bi_blkg);
+		rcu_read_unlock();
+		return &bio->bi_blkg->rl;
+	}
 
-	/* bypass blkg lookup and use @q->root_rl directly for root */
+	blkcg = css_to_blkcg(blkcg_css());
 	if (blkcg == &blkcg_root)
-		goto root_rl;
+		goto rl_use_root;
 
-	/*
-	 * Try to use blkg->rl.  blkg lookup may fail under memory pressure
-	 * or if either the blkcg or queue is going away.  Fall back to
-	 * root_rl in such cases.
-	 */
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg))
-		goto root_rl;
+		blkg = __blkg_lookup_create(blkcg, q);
 
 	if (!blkg_try_get(blkg))
-		goto root_rl;
+		goto rl_use_root;
+
 	rcu_read_unlock();
 	return &blkg->rl;
-root_rl:
+
+	/*
+	 * Each blkg has its own request_list, however, the root blkcg
+	 * uses the request_queue's root_rl.  This is to avoid most
+	 * overhead for the root blkcg.
+	 */
+rl_use_root:
 	rcu_read_unlock();
 	return &q->root_rl;
 }
-- 
2.17.1

