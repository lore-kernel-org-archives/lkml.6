Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4063355-1521766732-2-6041251574702620467
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
    t=1521766731; b=mFCAhf5MPy4D+7YhpohHVKvtfwnRnNmR7XiHe2xDtdZ+dVl
    mpFC72+tglgavd1H4kTOnUUimldhxm7D5nThc1nbxKwuGuUeyTUjr7H8jFvYKztJ
    6FR+HjlxMznyryUaDlomUykqcUi1zxl2SNx7g955kkS1uU4Vb3pYSfwpKZMD4JWc
    b7pmoJRX48yI+owK69JfzfOb9RrYZPFZ0Z18qWQ92bvIWP5Tme57iKTpOlZwkmRX
    o1a7aLau5aM3Xuz3Q9Z9k9B95HgZrMtT1gC5YWtXBBnibbvfnWUogqquGxZ16FvA
    yhBjRKxt3w4FWs4Du+BQSqOxlASmG58f/uhP0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521766731; bh=jhYUFLxw9XK74VFlCSDBMeuILaOyPAqV+6TRJ4he3/0=; b=K
    DGe1PvH1dQ9NuTLFUylP+Yhp0hP5DNYVu/xVBMsMy7XeR1dFE8+13+L2WQaOOaMx
    Cb8Vh1HRF0x0TovRHD25jf21Rh+1aXJiWmgNpASqaPAFJC3PUsDAKosYixA0G9vl
    ystkInP9LUJ8W8cOG7e4gyO8fqq/WFUHzaHQ8qHpPtj32UxNM/LcZdX960wnLohn
    Gs0rvjNySuvolGGIRzwl07vSPNYkPVnn7h5x06p3JHgnqVYWlpNTKWIRolpFrRF/
    gB7R1eeJnLRrDqorBdq637U158xh86hc0wqVw8XOR+CVziw8cV9X8JDXvavn/Qq/
    GAxGEW5j2WrZ3V8uiC5vQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCWA6W (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 20:58:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751812AbeCWAzw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Mar 2018 20:55:52 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        stable@vger.kernel.org, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 05/15] mm/hmm: hmm_pfns_bad() was accessing wrong struct
Date: Thu, 22 Mar 2018 20:55:17 -0400
Message-Id: <20180323005527.758-6-jglisse@redhat.com>
In-Reply-To: <20180323005527.758-1-jglisse@redhat.com>
References: <20180323005527.758-1-jglisse@redhat.com>
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
index 2d00769e8985..812a66997627 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -336,7 +336,8 @@ static int hmm_pfns_bad(unsigned long addr,
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
