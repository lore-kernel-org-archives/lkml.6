Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584447-1524656086-2-4527963852197935576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524656086; b=fPtAHWv4Bb4gnnb1zkgfZZeN25SFGwYTCHGxwfD9IsVSQZy9Kb
    4SW1+MMyefBaxqhA+dkgf3Kxn5p9nHP07mpK+xe32VZ6MwYaDASBMQOSH1AOl9N/
    EmvWT8EOLylKPULhevVX0Zm3HyJTWEqg78/AGQsjbveGvMW7V6C7QF5z9x3tMSt6
    z9jimJuI59IWot3lwiDy29sl1rLjNR4rqTnSesWhBc5srx+DE/xF30tnDv9T2rDt
    UUqjP3H4/gllLgKR0E9QCpphVQ2C/foP+IZJBYHUUEr9byN/PklSVvvOHa2rVwP/
    nL4bkvxysw731H6VVCbPVhrNvx8mewdsOy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656086; bh=TqZZ/+l+If203eUtv4WVbu/aOIwWie
    H8owalSMc1GSQ=; b=UIp9AzLFI0emmedfDkwUvcEeaiMI4wQGQZCRiU9hKMgNLw
    0w1jzLz1BvyoedNCxxRwVixNcb1JiyuVQJf94b7Z+yskkjpty1HB5eATHZacgA76
    ZTzqRRQIr/Rd06cQvAAg8EgsJNhmqxpgyzEYjA5eCmyxjZI9TKTTYXBVttbPT3H/
    FJGlyDDb9A/SaXdF+w54cwDk4VT/gfywda+pJxcN5dz7DHv3qlkxdwm3aj5t8Swx
    FAVKxzK0jRfmu81EUBRWgljVTek7tfchYXQItfOgyciAGXrqEwCzFF2wrRLp70OC
    RF1CokPWbwITP/1rrf5tSeLb/BIuYlR2UfMyrVyQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGVTPepdgPMuCOGsKV6AJDQZnxa2KFSZ/3A8qn6KG0sdIteDXKFVUaDFhZ/LVeGxaULj3+j5DhjCTbSMsLA3drNQVK577uQhus/0TEoqc0104JYzCq+x
    wTTw/07qUHcuCDXkUebXbp4VtyhB+Iz7HJS8ErU7bdZSQkb4X9LvZvVv9tl+mS6+zURASxLzg98hqT9B0KQIM2k9pdpIgtJudBceBQBsYUabJweFPtwAkhD/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=opiuTsU8bNTI46wjHzIA:9
    a=376bI0Sr2msuPZ3v:21 a=AuTmWXbFeLBt3YYR:21 a=QEXdDO2ut3YA:10
    a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDYKeW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:34:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbeDYKeT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.16 19/26] netfilter: x_tables: add counters allocation wrapper
Date: Wed, 25 Apr 2018 12:33:28 +0200
Message-Id: <20180425103315.615148947@linuxfoundation.org>
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

commit c84ca954ac9fa67a6ce27f91f01e4451c74fd8f6 upstream.

allows to have size checks in a single spot.
This is supposed to reduce oom situations when fuzz-testing xtables.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/x_tables.h |    1 +
 net/ipv4/netfilter/arp_tables.c    |    2 +-
 net/ipv4/netfilter/ip_tables.c     |    2 +-
 net/ipv6/netfilter/ip6_tables.c    |    2 +-
 net/netfilter/x_tables.c           |   15 +++++++++++++++
 5 files changed, 19 insertions(+), 3 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -301,6 +301,7 @@ int xt_data_to_user(void __user *dst, co
 
 void *xt_copy_counters_from_user(const void __user *user, unsigned int len,
 				 struct xt_counters_info *info, bool compat);
+struct xt_counters *xt_counters_alloc(unsigned int counters);
 
 struct xt_table *xt_register_table(struct net *net,
 				   const struct xt_table *table,
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -895,7 +895,7 @@ static int __do_replace(struct net *net,
 	struct arpt_entry *iter;
 
 	ret = 0;
-	counters = vzalloc(num_counters * sizeof(struct xt_counters));
+	counters = xt_counters_alloc(num_counters);
 	if (!counters) {
 		ret = -ENOMEM;
 		goto out;
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1057,7 +1057,7 @@ __do_replace(struct net *net, const char
 	struct ipt_entry *iter;
 
 	ret = 0;
-	counters = vzalloc(num_counters * sizeof(struct xt_counters));
+	counters = xt_counters_alloc(num_counters);
 	if (!counters) {
 		ret = -ENOMEM;
 		goto out;
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1075,7 +1075,7 @@ __do_replace(struct net *net, const char
 	struct ip6t_entry *iter;
 
 	ret = 0;
-	counters = vzalloc(num_counters * sizeof(struct xt_counters));
+	counters = xt_counters_alloc(num_counters);
 	if (!counters) {
 		ret = -ENOMEM;
 		goto out;
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1199,6 +1199,21 @@ static int xt_jumpstack_alloc(struct xt_
 	return 0;
 }
 
+struct xt_counters *xt_counters_alloc(unsigned int counters)
+{
+	struct xt_counters *mem;
+
+	if (counters == 0 || counters > INT_MAX / sizeof(*mem))
+		return NULL;
+
+	counters *= sizeof(*mem);
+	if (counters > XT_MAX_TABLE_SIZE)
+		return NULL;
+
+	return vzalloc(counters);
+}
+EXPORT_SYMBOL(xt_counters_alloc);
+
 struct xt_table_info *
 xt_replace_table(struct xt_table *table,
 	      unsigned int num_counters,
