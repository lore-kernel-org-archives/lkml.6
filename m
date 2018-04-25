Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584447-1524656113-2-3521895233497892894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524656112; b=V61LToEfqEhHqFssm8t0eq3gPprB2W2Mx5AMH1OYV4XBJsh0Rq
    yphAD0HtfDcV1HCXrQIIiSaCy3Qp+er0U2dStSkjElUhB0EkR7P/daubO+Viu6N4
    +Dczuy681dQKDbs/rxuHyyTk6+voGTkCj09QIBa2UtzIJEt75Jz2wPdehpVKgaOX
    401MPBT6u2INt/yVWtssmVZ0skMuAIwU6/jzV+96vH/MjRsxcj+UuoG5ESyxLyXp
    hhjVTgeXMko3N6lUquwl3E+hCjv6FQJIYSIqQYhTv8ciWw2dKJXPr+DSC7tTFAHC
    rdO7y6IL6DsF1EdvT13c+ICgSJhiVKJOmOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656112; bh=RwEeyDBFRjvarR9Z3Z6kwLaTwjPkbk
    U4bByK72YNzew=; b=BZ5YiZJIGZtcrqKojxMcTBR2nw92wYYRfU8tHhEqD8GgD1
    aWKxMrs3O17km7FFbv674MqBXqsygvIGsTCKNwwmVzgt0cePH/v4/eGRAufC+l3y
    ZxdstFYrj0zK+xOpaAc9sbnwZjed/UjZS8QNGry5eqpCuw7ywFdFfs6QUxorrBvE
    U0h1Vrfjo1sF2SjHo/pG2Hv5XLXQVncqHZuyXgMV9hWAPB7impMlrS23wrhOe1sA
    BUXDHYVcH8s5ChKKMckwRTgmJ6+aIdJnGfmZcsgzpTfkuLYAli0CwhKPIJ40u9Kt
    vpEzDRV6GtmjCR+XCc6/B0scC+11lJViEvtYgx0A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVDdsL3PqQoZA/P9cYsOtrlVsT0B6uGV1FdOndbCgpG6UW0OE6fFsjX0XR1oYvPFlexXVAcJbzssvZ9OyrX9E5599uS36K2F/bcE5HrmUqS0v9iVBiT
    bnofI5kybNxQa9F6NUVoL3j9Uy6BRwh8mfygdqHz++xO28fhp7dfomTYVRXgoeDRoxS4nuVI8h2swBJ1+RybEc7CDw0GXO1g58udsebaIhHIeEnqjZ2MohYM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=ZqW6OwneuF5TVGLeTZkA:9 a=QEXdDO2ut3YA:10
    a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDYLfJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:35:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeDYKeQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.16 18/26] netfilter: x_tables: cap allocations at 512 mbyte
Date: Wed, 25 Apr 2018 12:33:27 +0200
Message-Id: <20180425103315.583243065@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit 19926968ea86a286aa6fbea16ee3f2e7442f10f0 upstream.

Arbitrary limit, however, this still allows huge rulesets
(> 1 million rules).  This helps with automated fuzzer as it prevents
oom-killer invocation.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -40,6 +40,7 @@ MODULE_AUTHOR("Harald Welte <laforge@net
 MODULE_DESCRIPTION("{ip,ip6,arp,eb}_tables backend module");
 
 #define XT_PCPU_BLOCK_SIZE 4096
+#define XT_MAX_TABLE_SIZE	(512 * 1024 * 1024)
 
 struct compat_delta {
 	unsigned int offset; /* offset in kernel */
@@ -1029,7 +1030,7 @@ struct xt_table_info *xt_alloc_table_inf
 	struct xt_table_info *info = NULL;
 	size_t sz = sizeof(*info) + size;
 
-	if (sz < sizeof(*info))
+	if (sz < sizeof(*info) || sz >= XT_MAX_TABLE_SIZE)
 		return NULL;
 
 	/* __GFP_NORETRY is not fully supported by kvmalloc but it should
