Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521485084-2-2831932385981902993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521485084; b=mubC4sORf5Ge9C1vk2f8LkxYb7vLeSrMpEtOHxjIa1fWxGC
    Z/2bkEyHcs/zTySpeM1tgs4AbZt7YQYYV28AbodCs+nrNjr4PUim4LVBX9aWsUGJ
    wZHwC2Mp9f6Lz4tS1rVzKgoXwD0TqiegddpT/oa6G0UllgwBeTaIA0SVbp1Fv+l9
    PKfMRZtcbDMQysFKHDc/iAVdz3helkG2FQXGrSpUf2xfaNBhDzosDiBFK07rAH7c
    QuGXuIXMY1HtoGJK5CshWCVr8IBU2086oMtIpSbQiZkRoU69fc7NbJSKODinnO3x
    tsjdkjP/YMzDZM3p+RLVqqERfU80JKsH7aW9pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521485084; bh=/cLK1tyYVf1LDWUVYlcdBvpXj6
    IzuUfetMWRM8O2ftE=; b=PfxQzWr9bcKAvF/DLbVdI9VURC180I/BnJ9JBe517C
    W1EzE7THdvlA0UMh+oSlSwGfxJXIkacyVTZjk41763qmaQOjYBO79jWHh8Fp4gVI
    vkhZAMSWfqdCaRNzqHnX9So7SO9+kZhEbpxdLWkwTORI7Y9/d5wWsU6jjT3Jwtq/
    qyKQf8HdRzjNYBgvsvFUt8xoUAtxl5xJPPL0qViu6ph6w/lczar5/G5Re9thcCaJ
    d/AjmyDXuqJZdEVEmiIA8YaQHXbWayVIVRHBqygI0QI1F0eXfF23CV5RaNjjBQyn
    m0RScgGpleOQZwWSOsHsjJq9TWkrCUDnHQht+5P1srUA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeefjeehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeefjeehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935145AbeCSScR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:32:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53860 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970264AbeCSScL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:32:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gratian Crisan <gratian.crisan@ni.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4.15 09/52] x86/mm: Fix vmalloc_fault to use pXd_large
Date: Mon, 19 Mar 2018 19:08:07 +0100
Message-Id: <20180319180735.579401608@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit 18a955219bf7d9008ce480d4451b6b8bf4483a22 upstream.

Gratian Crisan reported that vmalloc_fault() crashes when CONFIG_HUGETLBFS
is not set since the function inadvertently uses pXn_huge(), which always
return 0 in this case.  ioremap() does not depend on CONFIG_HUGETLBFS.

Fix vmalloc_fault() to call pXd_large() instead.

Fixes: f4eafd8bcd52 ("x86/mm: Fix vmalloc_fault() to handle large pages properly")
Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20180313170347.3829-2-toshi.kani@hpe.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/fault.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -330,7 +330,7 @@ static noinline int vmalloc_fault(unsign
 	if (!pmd_k)
 		return -1;
 
-	if (pmd_huge(*pmd_k))
+	if (pmd_large(*pmd_k))
 		return 0;
 
 	pte_k = pte_offset_kernel(pmd_k, address);
@@ -475,7 +475,7 @@ static noinline int vmalloc_fault(unsign
 	if (pud_none(*pud) || pud_pfn(*pud) != pud_pfn(*pud_ref))
 		BUG();
 
-	if (pud_huge(*pud))
+	if (pud_large(*pud))
 		return 0;
 
 	pmd = pmd_offset(pud, address);
@@ -486,7 +486,7 @@ static noinline int vmalloc_fault(unsign
 	if (pmd_none(*pmd) || pmd_pfn(*pmd) != pmd_pfn(*pmd_ref))
 		BUG();
 
-	if (pmd_huge(*pmd))
+	if (pmd_large(*pmd))
 		return 0;
 
 	pte_ref = pte_offset_kernel(pmd_ref, address);
