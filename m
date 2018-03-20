Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-143482-1521511550-2-7701381239446947006
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
    t=1521511550; b=borkiUzJszPrJANhv0gSMMYBOcBQ/WHU16QHuK9xdYanRz9
    VXfCGW2xxhAFFM/M4IxKOMFTonL2QRbGwgsJLfGAgKCjdbfqMbLgdjpmx+Odu5Xo
    DSCrPGMnkcUcqQVrrauodxvGs/q74bisiixb9ELnjwELBR+bBVyJbKBUamwUZRqx
    aln28Sxwb1E8mKRUp+UGeFsy5Fmj7DaLjB9blewTg2mMHsyNIXixI1RohNeAMh79
    Y8P5FglIpwAh7NVFdVaZhVuqKvunnDQd4Tw/xcK20Fo8sZSxWmB+kfgHE0XBWhxC
    A0QfI6UDyw8cH85XPqkNCtLqAu6B8qdtmzDIE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521511550; bh=+C6flAU2MCDi3cZ34E9/mlM6vlYqTieUExkEmDn3OuE=; b=k
    9WXVCLu5GYFCJFwBil7TyrxQFWIgaoFKj5FjPICaEgJtofHazSVuRBEVG61K4lgP
    9GOwD5gSeZIXIipIKJVS2MYYFdQJe1wgJW0ieV491exlnz/cJwaPeEPwRL+8isv4
    +4PVokKzNMc0fkQ5Ay1MToBEWX3FlWMr3/c6M31/YFIklYMXhS1UOYBOtabp4kYh
    APaVY5F3gAzmNrSfhyBh+byChMzFZaDB3S0gmeO4/4u7PAPf/81vkmXZTPeiUATk
    /YWwq6dDsYznEUFf6+EDQOPt1eCfR4ejrwfaprd/n47D/uLMz4h3mukefVKOsnO3
    h4Np0nr+x2ZFS27RDVs6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgfgshhpjeesthekredttddtjeenucfhrhhomhepjhhglhhishhsvgesrhgvughhrghtrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpieeirddukeejrddvfeefrdejfeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvddvfeenucevlhhushhtvghrufhiiigvpedt
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudeggdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhggtgfgshhpjeesthekredttddtjeenucfhrhhomhepjhhglhhishhsvgesrhgvughhrghtrdgtohhmnecukfhppedvtdelrddufedvrddukedtrdeijedpieeirddukeejrddvfeefrdejfeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeefvddvfeenucevlhhushhtvghrufhiiigvpedt
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeCTCFX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 22:05:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752087AbeCTCAp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 22:00:45 -0400
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
Date: Mon, 19 Mar 2018 22:00:27 -0400
Message-Id: <20180320020038.3360-6-jglisse@redhat.com>
In-Reply-To: <20180320020038.3360-1-jglisse@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
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
index 667944630dc9..f5631e1a7319 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -312,7 +312,8 @@ static int hmm_pfns_bad(unsigned long addr,
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
