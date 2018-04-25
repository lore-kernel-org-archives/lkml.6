Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653359-2-16541936914741148834
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
    1524653358; b=JBGWsNqV2Qsvwtm1OnQVCuE5EQXO0fyYqe7SVGduKUnZ+xpLt5
    gSaxhVIRwAEL5XF8Zr3tFGgXeqh0aPQmGX7LaB9rNZlG6F017/6yz9gzTw1k/Tu7
    oXEGpHTrEocdXlinwPesGwvuHmuwDSaCd45T1BA16Jp9aFHXc6o0STWbpsa9Wtfl
    1/ijg20QeVi2smXdfmbou0fLP8zJOpcBChkY6mEzWBYH8leCYArN2Zr/c6DljUYF
    IuV0q/tPEjR92zDzRqcCuTF0bXQ3yxaInhxtR92Sk566UCjuqgVA9Yu9Mtert+T8
    UonpNFRmgml9zyvaZkkWM/K+XpeaNxKRxV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653358; bh=E+zpVQE+wGnCAmhxSb7tut8yoB6cV1
    rmJoqUSTgglb0=; b=b8aYn5PDQ4kqml6F7tz9RVa6WqhWTPEOXB+uIuIrnhEh33
    B5eKFVrBF6yZGjKwOQNcKDdmFHq36VQVbkV6P+XOlUVRlsA/5TdHyngyOxBKvtVM
    mk9ylu4DJEvd1mk2KmCPvEIQCXKYJ9nDvVZpBZCiNI751Q2h0K7PXcYtTmBGL7N3
    Q9IuKmxq9w75sg1Xtlv+zaSNV/zgm8BEJCQRWJo9PH4C2eKkF28a1XRrLS1FokO1
    vyaqBocAmrEX60geEU5+UquAuQ86S8Lpxlr/jhnxLKjvtCvDAyC2A3tgc3AtpFEH
    qrz1mrHXsYdHhOTItE1e7LPXzT4NuCz4GtlnRKgg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJAc0ymlKzHGzne5LCKW9NZVe7JB2ZoTvisVjDwHb68eB9b3QwfsmKxokMDviaxa6aTUEv/m21IiBtOzgqzgXgorJZeOBG6VFWrwoCG/pWczYc0t7oLX
    8RfR2Hgpouewr8IxqayDZGIuqwu0pfU2mEfDlvq+OmdBfsXnCcOCNZmpj9uGDjmVKIL8IziuRzNs+r8xKuzIz2LsdONigJWim0/6quVGSLVvXpOf+8VYOLIm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=g8IONWpHNKe7ITfAz3cA:9
    a=cKwNT-n140krnw2H:21 a=AuTmWXbFeLBt3YYR:21 a=QEXdDO2ut3YA:10
    a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754418AbeDYKon (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:44:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754416AbeDYKok (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:44:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 175/183] netfilter: x_tables: add counters allocation wrapper
Date: Wed, 25 Apr 2018 12:36:35 +0200
Message-Id: <20180425103249.541249009@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -883,7 +883,7 @@ static int __do_replace(struct net *net,
 	struct arpt_entry *iter;
 
 	ret = 0;
-	counters = vzalloc(num_counters * sizeof(struct xt_counters));
+	counters = xt_counters_alloc(num_counters);
 	if (!counters) {
 		ret = -ENOMEM;
 		goto out;
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1044,7 +1044,7 @@ __do_replace(struct net *net, const char
 	struct ipt_entry *iter;
 
 	ret = 0;
-	counters = vzalloc(num_counters * sizeof(struct xt_counters));
+	counters = xt_counters_alloc(num_counters);
 	if (!counters) {
 		ret = -ENOMEM;
 		goto out;
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1063,7 +1063,7 @@ __do_replace(struct net *net, const char
 	struct ip6t_entry *iter;
 
 	ret = 0;
-	counters = vzalloc(num_counters * sizeof(struct xt_counters));
+	counters = xt_counters_alloc(num_counters);
 	if (!counters) {
 		ret = -ENOMEM;
 		goto out;
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1187,6 +1187,21 @@ static int xt_jumpstack_alloc(struct xt_
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
