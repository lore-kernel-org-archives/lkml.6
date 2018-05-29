Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2721200-1527628847-2-4739199760181562799
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527628846; b=MWfIn4AqWzqYPqfo0jSOGyG7dPglRMs3HY0HfkoUqehUkVvnKw
    lCAJoYz8Um5iITSbQ7PEbnai0FuJzCtf/Lr2h1ckX8Ck81o08zlbaQ350y6pLnbC
    rYxa4PqB9CzSaFZ9M+imTQYYUgNSgg7DMAZRVItBCDDQH0Cw6HuQG+y17tibAFGq
    4I4QDBubZ5SBa7VX4GTb+VF+C7KRQbJG0egEMTy5Xf3uSC8FMDZ+4V4iB2VKyVUO
    c0oUQxD5Wqux4y1UG3OP4vnTEmVpMwRhM1eWaE6BXMfMAZYxTXhGFIXWNVHzHoXx
    4rTkjSONxK4UOgMGt0VnPz3MuYGO5WiT1Hnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527628846; bh=
    YoBw5GF3e0Sa6FZi+R+K2rLhH6olkJq2QtsBvAhm3vI=; b=UG1ywrmx+QKOsElW
    y6MBoZGaYOu/PDwpousUekozjZQ8G9/CLNQjrpv7ofcDTNHwLw+Gva7zo8j9xoq7
    PamHg/0/yI+8t7w/Bil2/T69TKc/4LryQaVRZquv/mzIXMtuoAcRwqJvkDzG9S+L
    ebKOBBzfzuxnWK+i9701HGw3Txp1DJUBYZtQ7qVAm+GlKOXQbsql1GGxFqSbfHyo
    gFr+GFyG20658XvEH/CC0rk/wrwmbpbfUhuwP9bqpSJO43e3YrgXpHQ7vwkQsEVT
    v7K92MNQSK2/trOm2fwgemmLmbbRiNCjxpCyoAkqTX8K9R97JomJkrGmMUrQmS3g
    xLVqog==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=toxicpanda-com.20150623.gappssmtp.com
    header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=omOPJFyn
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=nQBWA3AP;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=toxicpanda.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=toxicpanda-com.20150623.gappssmtp.com
      header.i=@toxicpanda-com.20150623.gappssmtp.com header.b=omOPJFyn
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=toxicpanda.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=nQBWA3AP;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=toxicpanda.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJo9eGxwIT5ABSPW1F+2bfKKz9b3I1RcEnfAs2/33njQeGhWiPmRxuHity1vsCge2GDZLtIIlssZhK3W+w9Bs2/geEq7SuSMQwaIr8fx/hAp8ccQMoQV
    MjHFNMIW8NSLEAzvy7ivDTr+zXusc4vnOu1rzpa5xTHD+Bh7367SoPEiPY3r7IiOmIHCvri/YDfDpn9isaR1TWpyh4+GrclVeWZbs/EKRJdIB5qFyeRblJ2P
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=TDT2eNGE4QqOT16Oyr8A:9 a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967178AbeE2VUb (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 17:20:31 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:40897 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967134AbeE2VRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 17:17:34 -0400
X-Google-Smtp-Source: ADUXVKIzZtMMap8dpfHtEIQTVbqk+wdBmxYUW3sg4z6PPmqcoPDiRBhwFNfmDXpIjRphvjBohU+2AA==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 04/13] blk: introduce REQ_SWAP
Date: Tue, 29 May 2018 17:17:15 -0400
Message-Id: <20180529211724.4531-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529211724.4531-1-josef@toxicpanda.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

Just like REQ_META, it's important to know the IO coming down is swap
in order to guard against potential IO priority inversion issues with
cgroups.  Add REQ_SWAP and use it for all swap IO, and add it to our
bio_issue_as_root_blkg helper.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 include/linux/blk-cgroup.h | 2 +-
 include/linux/blk_types.h  | 3 ++-
 mm/page_io.c               | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index b41292726c0f..a8f9ba8f33a4 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -254,7 +254,7 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
  */
 static inline bool bio_issue_as_root_blkg(struct bio *bio)
 {
-	return (bio->bi_opf & REQ_META);
+	return (bio->bi_opf & (REQ_META | REQ_SWAP)) != 0;
 }
 
 /**
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ff181df8c195..4f7ba397d37d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -327,7 +327,7 @@ enum req_flag_bits {
 
 	/* for driver use */
 	__REQ_DRV,
-
+	__REQ_SWAP,		/* swapping request. */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -349,6 +349,7 @@ enum req_flag_bits {
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
+#define REQ_SWAP		(1ULL << __REQ_SWAP)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
diff --git a/mm/page_io.c b/mm/page_io.c
index b41cf9644585..a552cb37e220 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -338,7 +338,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		ret = -ENOMEM;
 		goto out;
 	}
-	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.14.3
