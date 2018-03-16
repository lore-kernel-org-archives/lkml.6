Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3747066-1521227767-2-6167041577821785125
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521227767; b=wKixEM4I6hrjiRUtIYBHVRpRsc0rnGWPzSQfTVf/xoUCrdS
    aWX3ppax0bRKd6GIkzTVakHQgMLy6lSiJmYLvbP5s8VTEFGHNFO/LoWRu1rXLuiZ
    2ZuaY6Jna9UoxnkBS+eBNYwmyxTFs7hNE8C9xDeWF5DfeML/vdAaTgVjRYfxVCB2
    FhsOmVBO6sbvhv3RzB5eyv4oSNCk+EefO6rH1WGM8rIJHZSgI5cSB16OZjJu+aDy
    BmV+lsanOOG/H6AESdugNl0XvXJItlR2FN7C+PX661+yszcZHiZz2gFgNXEZFC1t
    q8QbCy+UByQ27FoIpt8qTK702AhS7ahIzGnfYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521227767; bh=/zqR+mJc+jz3eDzEtpvHsxMLqMfP2lu2ZtBjwdZjulA=; b=a
    zeufWnjWylDDAK/X6VSCvRsOFP2jCRO/MHOKSomxyGpE+/n4R7dIolI1EqdehdSW
    g4OqGnyXnU5i/1jB+4brm8W2JWu76PF7YUGQPrdpnjheEjZD4bTgWF+XFSEYVwG4
    /Nv6l5//5QpBRVkGw4nARiSvJPvdxsthxPhwMooxee5dJNRzv8uYl+mBLMjLzS3I
    rINfG9JlOUryLpLgkkEVnphIOpBGvWiD08+FZTbDrpoAb4whUtjNDMLk276M/vCk
    DheRxEfBM7OUuGcXpcqbnjApZKXITo9Vze9Pl1O4+7EdDdfQ5EwSnJ/YX/ZGyV9C
    Gh45YwaXXLtJaOg5Xug2g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeCPTQE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 15:16:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752563AbeCPTOV (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Mar 2018 15:14:21 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        stable@vger.kernel.org, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 04/14] mm/hmm: hmm_pfns_bad() was accessing wrong struct
Date: Fri, 16 Mar 2018 15:14:09 -0400
Message-Id: <20180316191414.3223-5-jglisse@redhat.com>
In-Reply-To: <20180316191414.3223-1-jglisse@redhat.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

The private field of mm_walk struct point to an hmm_vma_walk struct and
not to the hmm_range struct desired. Fix to get proper struct pointer.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: stable@vger.kernel.org
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/hmm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 6088fa6ed137..64d9e7dae712 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -293,7 +293,8 @@ static int hmm_pfns_bad(unsigned long addr,
 			unsigned long end,
 			struct mm_walk *walk)
 {
-	struct hmm_range *range = walk->private;
+	struct hmm_vma_walk *hmm_vma_walk = walk->private;
+	struct hmm_range *range = hmm_vma_walk->range;
 	hmm_pfn_t *pfns = range->pfns;
 	unsigned long i;
 
-- 
2.14.3
