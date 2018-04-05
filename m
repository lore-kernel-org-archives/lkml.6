Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3788080-1522962270-2-10729169567620196181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522962270; b=u7TGGSTdCZNhOVE05ED166fn5KGUsJOOosHOQdASTm1mMhMpGR
    t7mqs036UVjQlq00GccXtFvjslIeqgUFkofNiMd7RpRbbLWnEJHtXoZNCJSyQJkU
    H2yBDTIAjvjRVbB2QpYn0wYFlgqHV4aDQWMDkDo4DkwcZhEaXqFWxDUFAsx6NxSU
    HrXWCJWsjSCj2FIKSEipgZaBGTEjb22JJ7ra+DxI/PBl7uQpRoNjphPLvOQidouY
    75fili8oDbaf2N68BX/1VSP0NZHUVuRQwpmkSMh1QbQLTaob1NMBSvjsa8rxHBro
    8+8xXLaQ5wboscGnXInyisU14t7xOqIXI82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522962270; bh=EuxCm9v7ni5RAxlnDKA4ylw/WjkdV6
    ZBMUulAyK792M=; b=ArwoO8QRs5NtpYFhWoKivZ9WLLfUiXEnS+UJ8VXK2Cl+K6
    2YB3QRZCK7qDmbp8uxUquCc93yQb8HVGL3q7TVW4SGSNT+AlpGA3lsqM69BbaRrZ
    OwPrwBfvlW+Pf32PalI++a3LxShyNxyqF7r3QnnSjCL/0qvjLPUnXrclu5n9C+IP
    Nw6/5ALAJsiMKqBo5vdlpa08igXnK8WZ9giUDe9F7Tu6nWvjnIsUzHVdUjrgJvna
    djW9XMS4C6aREDtcBFozPgiebtyxtdOuwLBWnPsJEsZdE9EzWgKMREjmm0zhjHsy
    nRIEnray2+2JlErKhOqRZQi9iRye4qFKGjeGX4Cg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNENSl++pw4cv+gaOc+C90rsBwvw/RHwS/4BGqr3iQtFoqwsO0b6yg8V4AGhlpMkcUq6PqeWm6QmcXSa4bDPKl59pVnU0I/HSHycyu9WGLIBpfRz9BuD
    7/WGSQ4qttVsAY5T72uSa5qpbnHwv3tIuR3Wf324VghKjOxr6BdvSNygHT4v97y5ccfQVSop5r9inlZL5RJCbl096se/GJk3XgtUGqSHrCAt7V6GNyBQl5Gj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=07d9gI8wAAAA:8 a=JfrnYn6hAAAA:8
    a=lAgNKBcoAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=q7pWlSb1hhIkdbvT78QA:9
    a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=e2CUPOnPG4QKp8I52DXD:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=drE6d5tx1tjNRBs8zHOc:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDEVE2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 17:04:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDEVDu (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 17:03:50 -0400
Date: Fri, 6 Apr 2018 00:03:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        stable@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/3] mm/gup_benchmark: handle gup failures
Message-ID: <1522962072-182137-3-git-send-email-mst@redhat.com>
References: <1522962072-182137-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522962072-182137-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

__gup_benchmark_ioctl does not handle the case where
get_user_pages_fast fails:

- a negative return code will cause a buffer overrun
- returning with partial success will cause use of
  uninitialized memory.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/gup_benchmark.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 5c8e2ab..d743035 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -23,7 +23,7 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 	struct page **pages;
 
 	nr_pages = gup->size / PAGE_SIZE;
-	pages = kvmalloc(sizeof(void *) * nr_pages, GFP_KERNEL);
+	pages = kvzalloc(sizeof(void *) * nr_pages, GFP_KERNEL);
 	if (!pages)
 		return -ENOMEM;
 
@@ -41,7 +41,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 		}
 
 		nr = get_user_pages_fast(addr, nr, gup->flags & 1, pages + i);
-		i += nr;
+		if (nr > 0)
+			i += nr;
 	}
 	end_time = ktime_get();
 
-- 
MST
