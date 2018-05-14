Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281275-2-15608630891594077591
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES sk.us-asciienro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281274; b=XUnp+uAy+ZSE8BIoTVy+RsU6O+lys1hTOPEcfMJc9fYA/0+edo
    ANrCGSjvS6/pw1n0LGHeoaatSXwx66S7YIU4WAi9Nx7J+mCBC20JY8FfzGALfiiI
    nEdSJQ0BKycabBpKQabH7osQ36dfSI+wCA+4NCXj3HTenq3mSsao9QpgXNmP9Wm5
    t+Uvikw4YAVqOzI9HZ278A3+SecmDaU9ClOjdrho8aMkpnrpMyziy3Pkc85PKG9l
    xqUCPM4qJ10mUM+QH0nzU1c8PhEcQLEAp8oYZNKg5fZszCu0XeQqdMpzp7Wdui0y
    5VYSiRqLb/BN03EmdnpwySSA7e7M5unTS+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281274; bh=oqAeyXRDxEANN8nucxLUoYAdCJPxtm
    wtMJ+vSiSOK5o=; b=BwvwltuufWV7qR5J6m8LktLyOrD0Z89jYWUIXEeWQi7rcH
    md5/3djWH31giiLjdz31aRVK8BnYXRYSn+qkr/iJlbp7mLSkKd48entG3WNQ5MBp
    B5Av9hS7purx22WXwFA4VeI0+gnG+bUbEC6K4K+QHvFSbwZlL9qVHyRPKmwJtAGo
    5GrUpTGXanceRjAYDQU7cE0wdXRmYYEC2JZ/9H7qaeel4EnajpeGW9k8hCrhT7/D
    YrJpyP30NA3Mf91SxpqL3k6jQnhZvFaK01jP1cXRt3SO3+/RVIfslvYtpYeAnrcL
    Z3hwfTawJ4kuqJ4ZxMAp9AbjVkpkozUQnfeNjTMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=EmZmfCrB x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=EmZmfCrB x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP9rWiiicxVajhucpJJ3lqXXnQolIrb3d+2f19xrbwl3fBopPeFUu2D+H54DpTKsfmKD2XDyJsaHC4fvzvUeK+tiUgjFDrIeGKTIB5g85QYPayD0XiUR
    g1SBG8CbmbmNlMq6DkgNsa9YR5nNB40jHA2qzrM81y8xVEZVibt20k9Ouz2Zqo99NsLUCs8nV2I9d6XK8cZvSN7hvc29bo5tbuk2JmByZK7cWybA633uNl2K
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=z6gsHLkEAAAA:8
    a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=0K4TOLIue6-ewoCfQ-cA:9
    a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=d-OLMTCWyvARjPbQ-enb:22 a=nlm17XC03S6CtCLSeiRr:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754231AbeENHA7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754173AbeENHA4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Wool <vitaly.vul@sony.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Oleksiy.Avramchenko@sony.com,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 31/72] z3fold: fix reclaim lock-ups
Date: Mon, 14 May 2018 08:48:48 +0200
Message-Id: <20180514064824.416301035@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Wool <vitalywool@gmail.com>

commit 6098d7e136692f9c6e23ae362c62ec822343e4d5 upstream.

Do not try to optimize in-page object layout while the page is under
reclaim.  This fixes lock-ups on reclaim and improves reclaim
performance at the same time.

[akpm@linux-foundation.org: coding-style fixes]
Link: http://lkml.kernel.org/r/20180430125800.444cae9706489f412ad12621@gmail.com
Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: <Oleksiy.Avramchenko@sony.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/z3fold.c |   42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -144,7 +144,8 @@ enum z3fold_page_flags {
 	PAGE_HEADLESS = 0,
 	MIDDLE_CHUNK_MAPPED,
 	NEEDS_COMPACTING,
-	PAGE_STALE
+	PAGE_STALE,
+	UNDER_RECLAIM
 };
 
 /*****************
@@ -173,6 +174,7 @@ static struct z3fold_header *init_z3fold
 	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	clear_bit(PAGE_STALE, &page->private);
+	clear_bit(UNDER_RECLAIM, &page->private);
 
 	spin_lock_init(&zhdr->page_lock);
 	kref_init(&zhdr->refcount);
@@ -748,6 +750,10 @@ static void z3fold_free(struct z3fold_po
 		atomic64_dec(&pool->pages_nr);
 		return;
 	}
+	if (test_bit(UNDER_RECLAIM, &page->private)) {
+		z3fold_page_unlock(zhdr);
+		return;
+	}
 	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
 		z3fold_page_unlock(zhdr);
 		return;
@@ -832,6 +838,8 @@ static int z3fold_reclaim_page(struct z3
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
+			set_bit(UNDER_RECLAIM, &page->private);
+			break;
 		}
 
 		list_del_init(&page->lru);
@@ -879,25 +887,35 @@ static int z3fold_reclaim_page(struct z3
 				goto next;
 		}
 next:
-		spin_lock(&pool->lock);
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
 			if (ret == 0) {
-				spin_unlock(&pool->lock);
 				free_z3fold_page(page);
 				return 0;
 			}
-		} else if (kref_put(&zhdr->refcount, release_z3fold_page)) {
-			atomic64_dec(&pool->pages_nr);
+			spin_lock(&pool->lock);
+			list_add(&page->lru, &pool->lru);
+			spin_unlock(&pool->lock);
+		} else {
+			z3fold_page_lock(zhdr);
+			clear_bit(UNDER_RECLAIM, &page->private);
+			if (kref_put(&zhdr->refcount,
+					release_z3fold_page_locked)) {
+				atomic64_dec(&pool->pages_nr);
+				return 0;
+			}
+			/*
+			 * if we are here, the page is still not completely
+			 * free. Take the global pool lock then to be able
+			 * to add it back to the lru list
+			 */
+			spin_lock(&pool->lock);
+			list_add(&page->lru, &pool->lru);
 			spin_unlock(&pool->lock);
-			return 0;
+			z3fold_page_unlock(zhdr);
 		}
 
-		/*
-		 * Add to the beginning of LRU.
-		 * Pool lock has to be kept here to ensure the page has
-		 * not already been released
-		 */
-		list_add(&page->lru, &pool->lru);
+		/* We started off locked to we need to lock the pool back */
+		spin_lock(&pool->lock);
 	}
 	spin_unlock(&pool->lock);
 	return -EAGAIN;
