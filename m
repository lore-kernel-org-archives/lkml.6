Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C47AC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65FA20779
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="KzuvBbua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65FA20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeI0DX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:23:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39615 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeI0DX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:23:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id c25-v6so493216qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L4OEsFz3WUjgEGzu73gT/wwAqaCABq/L1QMv8mr7jYM=;
        b=KzuvBbuaLur8lPktdpvFa9kCRzdghPnke7Nb7qsvyTs/r/mFVoWLTwlp7SbvK6dod8
         h27MFYZuD9ST4VbzRwOEKAPER5XjWL9YfkQPGPGFFKJJ6eZmg02p6dUFJwEGkOo0Rp/o
         2s+oI3lPekVrwV9EYh0RZoBwGzue0DgWZSj+x5BHKmtXeppLEZBHNBbQx5h4xFeThEDS
         Wmq33Kk99E24OGVVW9Sd2miTsmwdg2muGlBP6bfTZMxpMudzwt1BTKmf3v+h4Wh1UIML
         UqAzfJT2d+TRIzWYbwEfQxFoEoEYoAlW1oHwwHLIcspURIeynYfIPaJNnSCLoD45CrDD
         LZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L4OEsFz3WUjgEGzu73gT/wwAqaCABq/L1QMv8mr7jYM=;
        b=I5XYPKeli7vzsEfVCZSbuakqB+n4TyXDqETU18QAwgeBIRM9mrAy9WsmVoYGq5lES9
         3xTzzBXOViT5Kufr5OfUC0dk/EQUZOs6h82iRd0j3RuKIzam1Xa+uNzAKz48VD5j4kIK
         id3XvVCH+0vtspz+kOvYJFP+E6yddGYtSxzRwo3ybAnagoq0yYuB4AGxg3tGueBOoIY+
         t4nrQmf3uMImord1aUb2nr5/vWGrcno4h84QwJVobaqJFX/c1lyRv95dZtLPHku4doOe
         AM10iecR/rDlTa83VoZFkpd5boSVMBIbNAsFj1MYLi4gYVuwnR9qaZhpprBw6tTc5L0q
         NOlQ==
X-Gm-Message-State: ABuFfoiz/WCSbDNz5VA64BCQJlcDRRfMa93MHA0GgQgSaoenOtq3U+YH
        bIDbsz+TtIq8Ht5jtZ9+GgPoPw==
X-Google-Smtp-Source: ACcGV634tXLL0I1iexAP2WhHj2bvmdrFTXsl3OPvRmlNb/A+m920mCwkcsQS0SkprH9fcqZ0jS0BqQ==
X-Received: by 2002:a0c:f906:: with SMTP id v6-v6mr5822169qvn.86.1537996146591;
        Wed, 26 Sep 2018 14:09:06 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n25-v6sm87327qkl.8.2018.09.26.14.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:09:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, riel@redhat.com, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Cc:     Johannes Weiner <jweiner@fb.com>
Subject: [PATCH 4/9] mm: drop mmap_sem for swap read IO submission
Date:   Wed, 26 Sep 2018 17:08:51 -0400
Message-Id: <20180926210856.7895-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180926210856.7895-1-josef@toxicpanda.com>
References: <20180926210856.7895-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <jweiner@fb.com>

We don't need to hold the mmap_sem while we're doing the IO, simply drop
it and retry appropriately.

Signed-off-by: Johannes Weiner <jweiner@fb.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/page_io.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index aafd19ec1db4..bf21b56a964e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -365,6 +365,20 @@ int swap_readpage(struct page *page, bool synchronous)
 		goto out;
 	}
 
+	/*
+	 * XXX:
+	 *
+	 * Propagate mm->mmap_sem into this function. Then:
+	 *
+	 * get_file(sis->swap_file)
+	 * up_read(mm->mmap_sem)
+	 * submit io request
+	 * fput
+	 *
+	 * After mmap_sem is dropped, sis is no longer valid. Go
+	 * through swap_file->blah->bdev.
+	 */
+
 	if (sis->flags & SWP_FILE) {
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
-- 
2.14.3

