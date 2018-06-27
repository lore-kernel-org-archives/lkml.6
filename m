Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F3C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB1125D17
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="h0p9MBWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB1125D17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965421AbeF0TJw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:09:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37105 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932723AbeF0TJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:09:47 -0400
Received: by mail-qt0-f195.google.com with SMTP id a18-v6so2629395qtj.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=;
        b=h0p9MBWWflX+NVWtEfoZfY7S1LnJxDMjCaSJl1g5Ple0W6kJAuc80sXc1mtLe1nWyn
         WvW0YYxtckVIhpEYLo0FpDKH7PkbHvQUXjNHT+A0rf+WxeOTunmZ/Iz2BNiEW4G3iUTx
         8AUORA9FqYGZurTQRLhkIcXxIpNSkh4V8/CjdPlefrg0WcNiBVagzx5HR5Ig5mlg4vug
         Dd9rN3PN4cnKRPEfLQJoAy3ErrjWiw+8fcOIHftLfON494FRZ6z3w7pvoiOTJaIiTkOP
         mMbFSypkaTOyH2Dp8zq21H1xkgQz6vmVccUntywRrLDcvXPvS38PflxQquZQGTaJrSkP
         gOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkdJSYLh9LN7Ss8j0Rn9mX3g9Rqhn9vecXPFB0z5w9o=;
        b=JKMZBsA46GmGTKv8EksLDha0QUggczeKVcdXGdWwWdhaxMmKD2+yUafR01osJt8a9y
         cNMrL98LWH71p4U58VDVuv/DDRKTb/YI0tlMp920rTNYwHag0w/y55xmJBKYnj5YeDZW
         QoKMqAHC9Dw6yMd42ViusMRX43O5ws4Y3cc+V2kV1h/CkyxraApKrWYa0KIrS/wLzW2I
         Gt4wmIj0ukl6N6ZpQ7j67dhTVyDuhqd2EG/BuAwRyJwLvpwnn+D+FN1l7gS06/ATdz2W
         P+O7kl728akyVSuLs5cFjj/gunSwQIfZ7PGSz0sRVcBzPdtpX/MNNR54C7YmInBsTCQi
         kIaA==
X-Gm-Message-State: APt69E1NdXquW+XXceGPDlXU2qHMx0Nt6ggmddBBh4lbQbZtZZMdDnu+
        imGElPx/A3RyYouINBEvESniLv0N0NU=
X-Google-Smtp-Source: AAOMgpce1ju3hn1h6dl5bVpWVwjsr3WvLRmI3AFl+VcOfagaPsZtljDQhBWRSwt/vfXbCZ5K2W4IAg==
X-Received: by 2002:a0c:83e5:: with SMTP id k92-v6mr6597335qva.88.1530126586802;
        Wed, 27 Jun 2018 12:09:46 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t65-v6sm1478792qkg.18.2018.06.27.12.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:09:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, kernel-team@fb.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>
Subject: [PATCH 02/14] block: introduce bio_issue_as_root_blkg
Date:   Wed, 27 Jun 2018 15:09:28 -0400
Message-Id: <20180627190940.4696-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180627190940.4696-1-josef@toxicpanda.com>
References: <20180627190940.4696-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

Instead of forcing all file systems to get the right context on their
bio's, simply check for REQ_META to see if we need to issue as the root
blkg.  We don't want to force all bio's to have the root blkg associated
with them if REQ_META is set, as some controllers (blk-iolatency) need
to know who the originating cgroup is so it can backcharge them for the
work they are doing.  This helper will make sure that the controllers do
the proper thing wrt the IO priority and backcharging.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/blk-cgroup.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd7de3c..69aa71dc0c04 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -238,6 +238,22 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return css_to_blkcg(task_css(current, io_cgrp_id));
 }
 
+/**
+ * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
+ * @return: true if this bio needs to be submitted with the root blkg context.
+ *
+ * In order to avoid priority inversions we sometimes need to issue a bio as if
+ * it were attached to the root blkg, and then backcharge to the actual owning
+ * blkg.  The idea is we do bio_blkcg() to look up the actual context for the
+ * bio and attach the appropriate blkg to the bio.  Then we call this helper and
+ * if it is true run with the root blkg for that queue and then do any
+ * backcharging to the originating cgroup once the io is complete.
+ */
+static inline bool bio_issue_as_root_blkg(struct bio *bio)
+{
+	return (bio->bi_opf & REQ_META);
+}
+
 /**
  * blkcg_parent - get the parent of a blkcg
  * @blkcg: blkcg of interest
-- 
2.14.3

