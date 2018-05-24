Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162900-2-316654017337995701
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162900; b=Tr5cx8lpfXb+/aiBSz0sApwKMtsjzBuOuU5k7whaGpeNnNrDBY
    O3AI2Ud1jCELGKV1jHilLsjulC8TEpAfYX6Y9M1zRBbutzpIMLvv84ca5M9vSrAy
    Lzuhq4DwGWqFm6GEokA88WducH87jdFGx2hhSNAcLVwZ9md+ocJPmI4AY4/IlS0R
    Xnd6Whpf+cjD5tjEXTrWyi1UPz8enSQtP2RNOhwWmUN1gus4qMNIdcGjcuKVKzjJ
    wpu18SnLoBg1tCGb4wqbnDvJ8T/JpjJJUisJOzurEeSjOVlZQ0gl0ejPbqFB7g7+
    FJwe/aBVIuhk0s07sHPhPwP2nH4zY5wQEirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162900; bh=TGCnyIIuavAb9ps5nojjjwJXrHgjAM
    eEOMq0kHyZe34=; b=cMe8TiXg7BaqViBaFj0SXJfqAL2mNqqSmcltPijivpQM8J
    vpYS3h04vfiXTLhK6Iys9m4bunsFeir0EK9kYCuW6kMZgzx5HGWm+m4doadKVuML
    UujNXUhPoTKmEHvoOofd7IYqinE56lF6PiXz6xl8XdP5Wxda1WSE2K0GKFHvq9dq
    CRpBDjlujfPHZYx8o0pNt+tMQ+0ZrN9rRqI6P0D2N5yR94/0RXLhiynCPbIGVrwU
    8ZDe651dVaiIHHJnkdVrpJavgbIXKYzxYRlN9t1u43Vc5nEm7s3CwKBvWyY9RqeY
    CbJz7SghEWWJ3LKh6maXsAjgS2MwVdo/0DIv+e4w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=b4uQkTV1 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=b4uQkTV1 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfB0/o+y2CVC2CJV7QrVWf/F6rhGL22uRaZwa39djqgQ33p6dSLsAmTQZ2FFC5HnfP0qnULek/AWVg4kdwyywa7IbDTjgNWYJd5t0VjN4UjXDY6KKTlKV
    /EwruzswFnFcJpP4UJFsJG80bc2yVlNkbCO+Z6T4/hMdyGcWN9h+9phqmSbTMcxyYRMyxKMumq/FvqQGefG2TquGV9mkKq8FBc/sLT/KyBbwnjbXisJEoYAo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=R_Myd5XaAAAA:8 a=1XWaLZrsAAAA:8 a=Z4Rwk6OoAAAA:8 a=ag1SF4gXAAAA:8
    a=FkEWdtnFNRhKQWAVMtIA:9 a=VGF_GfgXcI1qHwxY:21 a=TwB-6zxXnvLQiK8B:21
    a=QEXdDO2ut3YA:10 a=L2g4Dz8VuBQ37YGmWQah:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966512AbeEXLyo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966621AbeEXJqQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH 4.4 49/92] mm: filemap: remove redundant code in do_read_cache_page
Date: Thu, 24 May 2018 11:38:26 +0200
Message-Id: <20180524093204.194122705@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@techsingularity.net>

commit 32b635298ff4e991d8d8f64dc23782b02eec29c3 upstream.

do_read_cache_page and __read_cache_page duplicate page filler code when
filling the page for the first time.  This patch simply removes the
duplicate logic.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/filemap.c |   43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2215,7 +2215,7 @@ static struct page *wait_on_page_read(st
 	return page;
 }
 
-static struct page *__read_cache_page(struct address_space *mapping,
+static struct page *do_read_cache_page(struct address_space *mapping,
 				pgoff_t index,
 				int (*filler)(void *, struct page *),
 				void *data,
@@ -2237,31 +2237,19 @@ repeat:
 			/* Presumably ENOMEM for radix tree node */
 			return ERR_PTR(err);
 		}
+
+filler:
 		err = filler(data, page);
 		if (err < 0) {
 			page_cache_release(page);
-			page = ERR_PTR(err);
-		} else {
-			page = wait_on_page_read(page);
+			return ERR_PTR(err);
 		}
-	}
-	return page;
-}
-
-static struct page *do_read_cache_page(struct address_space *mapping,
-				pgoff_t index,
-				int (*filler)(void *, struct page *),
-				void *data,
-				gfp_t gfp)
 
-{
-	struct page *page;
-	int err;
-
-retry:
-	page = __read_cache_page(mapping, index, filler, data, gfp);
-	if (IS_ERR(page))
-		return page;
+		page = wait_on_page_read(page);
+		if (IS_ERR(page))
+			return page;
+		goto out;
+	}
 	if (PageUptodate(page))
 		goto out;
 
@@ -2269,21 +2257,14 @@ retry:
 	if (!page->mapping) {
 		unlock_page(page);
 		page_cache_release(page);
-		goto retry;
+		goto repeat;
 	}
 	if (PageUptodate(page)) {
 		unlock_page(page);
 		goto out;
 	}
-	err = filler(data, page);
-	if (err < 0) {
-		page_cache_release(page);
-		return ERR_PTR(err);
-	} else {
-		page = wait_on_page_read(page);
-		if (IS_ERR(page))
-			return page;
-	}
+	goto filler;
+
 out:
 	mark_page_accessed(page);
 	return page;
