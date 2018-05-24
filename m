Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2285987-1527182614-2-2862757521864045844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527182613; b=GX7fGalFw8XpMM+NaBGE8oKDPVE1OCydR+QFhzwwYTONGZ/8xx
    zP9vOS6rLUB2Z7ikHztWJSu1HhkIYd46oJT4KHxnsAVTsyodAB/PH0EbfkwFE0yk
    ffBHm4szMP04THOPQoHdDawZGfFf5fnF8Aba8QXtHyiX1aNsuaEmlOCfhWDGnJsU
    llfpNrfNeV3W8AiV382GBxOqBXwVdfj/xl+BwS3M838ifCMkr57DpTqJnh0m+34w
    ittLLd+BIgHazoup/Ke1TOs4IJKIiG07QQxYlvFxG48aAGxbN/z5wlJcZLc2dYCd
    duDzBCoQZnBhIxBXs3WOiPmtP/Bgg8Ogf9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527182613; bh=CNT08n8hISS1QjGojBTnoyssQljttI
    v0WAGfoAwREWU=; b=E5AQfIZ4qqJykRFnDGakCOl5ZmD5QkZlmXgSPn81Y15cR2
    9pCeHtpE7pv6GS7Npwgphs3UNzanbnQ3Vd8XYLTCyVR6TCmMCx2ZwTHYaWpY8Scy
    D+BeZJnPSL3agDOcmCV8g7L/NzMueyd+BhDbZ2zzBjCj8DmePb7+mb/D+KZ6suqJ
    hYmqR1ncp19ZsHs5Ya/d3iTM3EBK2BtgXNZ7r/heQUh8Nxuk0PtdHU0AK4DsfINO
    KR7tZJXcMongvsr2f0qKgwfwwrsKBdf4IVK1DGehKjL+0FmMWoswLVQEeLCt/PoC
    +Hk4Dxstg7Z4k0W/qYuReMHWiaAB2BPCc7/k/q8w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDN2YkAQGy7eYBGDxqSWKaHQSi76WF3bmJheQ9oS1GuV4sHW6oqVYDE2OmezAFMWmvEhRoc9iqKEhT4BDJR6oMm7PDnElJchegi+bf5TQ7m3ol1OpWow
    lXFl2GrKHRYe2zKyg7gJsJ4lHIE8N4S+v8Q33aG6ic84+EO1tFmVpR5oq29500Xr+zXWRuHfTxQOOA31JR2qULIrZogniBJ63qBFC29VZYhvq/UtTkEZty61
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=WJ0wQqe_a59KIX44F1MA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031393AbeEXRXb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 13:23:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031084AbeEXRXa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 13:23:30 -0400
Date: Thu, 24 May 2018 10:07:00 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: semantics of rhashtable and sysvipc
Message-ID: <20180524170700.wblnybinjzx5rwky@linux-n805>
References: <20180523172500.anfvmjtumww65ief@linux-n805>
 <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 23 May 2018, Linus Torvalds wrote:

>One option is to make rhashtable_alloc() shrink the allocation and try
>again if it fails, and then you *can* do __GFP_NOFAIL eventually.

The below attempts to implements this, along with converting the EINVAL cases
to WARN_ON().

I've refactored bucket_table_alloc() to add a 'retry' param which always
ends up doing GFP_KERNEL|__GFP_NOFAIL for both the tbl as well as
alloc_bucket_spinlocks(). I've arbitrarily shrunk the size in half upon
initial allocation failure. So we default from 64 to 32 buckets, and if
the user is hinting at larger nelems, we simply disregard that and retry
with 32. Similarly, smaller values are also cut in half.

In addition, I think we can also get rid of explicitly passing the gfp flags
to bucket_table_alloc() (we only do GFP_KERNEL or GFP_ATOMIC), and leave it
up to __bucket_table_alloc() by adding a new bucket_table_alloc_noblock() or
something for GFP_ATOMIC.

>
>In fact, it can validly be argued that rhashtable_init() is just buggy
>as-is. The whole *point* olf that function is to size things appropriately,
>and returning -ENOMEM obviously means that it didn't do its job.

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b5766134..e86a396aebcf 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -166,16 +166,21 @@ static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
 	return tbl;
 }
 
-static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
-					       size_t nbuckets,
-					       gfp_t gfp)
+static struct bucket_table *__bucket_table_alloc(struct rhashtable *ht,
+						 size_t nbuckets,
+						 gfp_t gfp, bool retry)
 {
 	struct bucket_table *tbl = NULL;
 	size_t size, max_locks;
 	int i;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
-	if (gfp != GFP_KERNEL)
+	if (retry) {
+		gfp |= __GFP_NOFAIL;
+		tbl = kzalloc(size, gfp);
+	}
+
+	else if (gfp != GFP_KERNEL)
 		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
 	else
 		tbl = kvzalloc(size, gfp);
@@ -211,6 +216,20 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	return tbl;
 }
 
+static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
+					       size_t nbuckets,
+					       gfp_t gfp)
+{
+	return __bucket_table_alloc(ht, nbuckets, gfp, false);
+}
+
+static struct bucket_table *bucket_table_alloc_retry(struct rhashtable *ht,
+						     size_t nbuckets,
+						     gfp_t gfp)
+{
+	return __bucket_table_alloc(ht, nbuckets, gfp, true);
+}
+
 static struct bucket_table *rhashtable_last_table(struct rhashtable *ht,
 						  struct bucket_table *tbl)
 {
@@ -1024,12 +1043,11 @@ int rhashtable_init(struct rhashtable *ht,
 
 	size = HASH_DEFAULT_SIZE;
 
-	if ((!params->key_len && !params->obj_hashfn) ||
-	    (params->obj_hashfn && !params->obj_cmpfn))
-		return -EINVAL;
+	WARN_ON((!params->key_len && !params->obj_hashfn) ||
+		(params->obj_hashfn && !params->obj_cmpfn));
 
-	if (params->nulls_base && params->nulls_base < (1U << RHT_BASE_SHIFT))
-		return -EINVAL;
+	WARN_ON(params->nulls_base &&
+		params->nulls_base < (1U << RHT_BASE_SHIFT));
 
 	memset(ht, 0, sizeof(*ht));
 	mutex_init(&ht->mutex);
@@ -1068,9 +1086,23 @@ int rhashtable_init(struct rhashtable *ht,
 		}
 	}
 
+	/*
+	 * This is api initialization. We need to guarantee the initial
+	 * rhashtable allocation. Upon failure, retry with a smaller size,
+	 * otherwise we exhaust our options with __GFP_NOFAIL.
+	 *
+	 * The size of the table is shrunk to at least half the original
+	 * value. Users that use large nelem_hint values are lowered to 32
+	 * buckets.
+	 */
 	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
-	if (tbl == NULL)
-		return -ENOMEM;
+	if (unlikely(tbl == NULL)) {
+		size = min(size, HASH_DEFAULT_SIZE) / 2;
+
+		tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
+		if (tbl == NULL)
+			tbl = bucket_table_alloc_retry(ht, size, GFP_KERNEL);
+	}
 
 	atomic_set(&ht->nelems, 0);
 
