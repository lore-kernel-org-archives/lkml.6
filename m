Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653343-2-604871928805913488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES rocaen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653342; b=B8FiGYFmQk8Yp9yCD2sqBrIctrRXTEvW0/O4ts+npr/z2A4XOt
    eOWtv05fmd3AFsipUfrkZu8Unybs7a/tcQqAX5AvfglabsIeLpg5IcjMEmHLjL4y
    aEddfaqQhYDZ4dBeL6fSJsyylsbjso/mjCcy8USVR+RYDqSYgjPn3qJcTibyichI
    aI3M2+S/cI5Tv3ZorDvi2PdNqhCDT9D8Fnm68XiiWse1RnLa/Ve5xUEuVCOwI8hg
    0ARTkhJjatbMSSxc5We6lB8T1Qq0fujAe0OfiZBdJTqcfjDm6LwgfZv7KUl9TLAx
    rxFH3NMradEJIwZTrQCa+Qzs077BohGifNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653342; bh=3RbXImS1r6WIAtVprAuawiq2h73p5o
    0PBkOH8H9hR+w=; b=BmTPB7GO8ic67wgFsX1yzeXOhlHFpdgJ8NLe9s6UEp9xoP
    Dpv0zvRlaQ/XnD8gMmOc7AHCHaPK7laoH8Pm8YyoBQ84tX21nBR0nwC+fyaKeLeP
    vDpebe78eu+JwV+MqgLVyS532zMexqhL7GnaO+nutiFZO6EfWYceaxSf2/TqhdwS
    ZxtuLStJ0nf7Ha25j/4tW83PsviitTsT+FSPFZWVFLataBzNUrmrFU9RKC6KwnBa
    W9vdgNtzW6JAlU4QyV8PSjfILNhirWhQbqY3KSPIPBvAjKzvKqYgu22cxOGhFZOr
    DyWDpfH1ubYpkbt7bA6GumrYkyNyZ//rRl8WUS9w==
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
X-CM-Envelope: MS4wfDuiqb7LW95DOUgbn9m7N+oT5Ltucu/UyvspPflaSeK2mUXAWmfcuGkcO9wJJ/6p+kMzWJU1rgJOQMSeH9sKzhRLPKap3ZNolTddeTcYS+2d6tA2ib5K
    LrHfDgAaPggW7SkGu30GHeWDswwBi6baP5h4y43+Y1RdekVjt5SfeFaLHHtXr96GCvVFQZk/63SgYUU9LAzwKmeNR4h37BuKfYsLqyBc1CG9bDqLsY3mYqAk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=bApgsWkRLwE-Uj2t-CUA:9
    a=LUMGzchDz-R3-M8a:21 a=acjLYnslKIp3HyPR:21 a=QEXdDO2ut3YA:10
    a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeDYKs7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:48:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53388 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeDYKon (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:44:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 176/183] netfilter: compat: prepare xt_compat_init_offsets to return errors
Date: Wed, 25 Apr 2018 12:36:36 +0200
Message-Id: <20180425103249.577242442@linuxfoundation.org>
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

commit 9782a11efc072faaf91d4aa60e9d23553f918029 upstream.

should have no impact, function still always returns 0.
This patch is only to ease review.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/x_tables.h |    2 +-
 net/bridge/netfilter/ebtables.c    |   10 ++++++++--
 net/ipv4/netfilter/arp_tables.c    |   10 +++++++---
 net/ipv4/netfilter/ip_tables.c     |    8 ++++++--
 net/ipv6/netfilter/ip6_tables.c    |   10 +++++++---
 net/netfilter/x_tables.c           |    4 +++-
 6 files changed, 32 insertions(+), 12 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -508,7 +508,7 @@ void xt_compat_unlock(u_int8_t af);
 
 int xt_compat_add_offset(u_int8_t af, unsigned int offset, int delta);
 void xt_compat_flush_offsets(u_int8_t af);
-void xt_compat_init_offsets(u_int8_t af, unsigned int number);
+int xt_compat_init_offsets(u8 af, unsigned int number);
 int xt_compat_calc_jump(u_int8_t af, unsigned int offset);
 
 int xt_compat_match_offset(const struct xt_match *match);
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1819,10 +1819,14 @@ static int compat_table_info(const struc
 {
 	unsigned int size = info->entries_size;
 	const void *entries = info->entries;
+	int ret;
 
 	newinfo->entries_size = size;
 
-	xt_compat_init_offsets(NFPROTO_BRIDGE, info->nentries);
+	ret = xt_compat_init_offsets(NFPROTO_BRIDGE, info->nentries);
+	if (ret)
+		return ret;
+
 	return EBT_ENTRY_ITERATE(entries, size, compat_calc_entry, info,
 							entries, newinfo);
 }
@@ -2257,7 +2261,9 @@ static int compat_do_replace(struct net
 
 	xt_compat_lock(NFPROTO_BRIDGE);
 
-	xt_compat_init_offsets(NFPROTO_BRIDGE, tmp.nentries);
+	ret = xt_compat_init_offsets(NFPROTO_BRIDGE, tmp.nentries);
+	if (ret < 0)
+		goto out_unlock;
 	ret = compat_copy_entries(entries_tmp, tmp.entries_size, &state);
 	if (ret < 0)
 		goto out_unlock;
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -768,7 +768,9 @@ static int compat_table_info(const struc
 	memcpy(newinfo, info, offsetof(struct xt_table_info, entries));
 	newinfo->initial_entries = 0;
 	loc_cpu_entry = info->entries;
-	xt_compat_init_offsets(NFPROTO_ARP, info->number);
+	ret = xt_compat_init_offsets(NFPROTO_ARP, info->number);
+	if (ret)
+		return ret;
 	xt_entry_foreach(iter, loc_cpu_entry, info->size) {
 		ret = compat_calc_entry(iter, info, loc_cpu_entry, newinfo);
 		if (ret != 0)
@@ -1157,7 +1159,7 @@ static int translate_compat_table(struct
 	struct compat_arpt_entry *iter0;
 	struct arpt_replace repl;
 	unsigned int size;
-	int ret = 0;
+	int ret;
 
 	info = *pinfo;
 	entry0 = *pentry0;
@@ -1166,7 +1168,9 @@ static int translate_compat_table(struct
 
 	j = 0;
 	xt_compat_lock(NFPROTO_ARP);
-	xt_compat_init_offsets(NFPROTO_ARP, compatr->num_entries);
+	ret = xt_compat_init_offsets(NFPROTO_ARP, compatr->num_entries);
+	if (ret)
+		goto out_unlock;
 	/* Walk through entries, checking offsets. */
 	xt_entry_foreach(iter0, entry0, compatr->size) {
 		ret = check_compat_entry_size_and_hooks(iter0, info, &size,
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -931,7 +931,9 @@ static int compat_table_info(const struc
 	memcpy(newinfo, info, offsetof(struct xt_table_info, entries));
 	newinfo->initial_entries = 0;
 	loc_cpu_entry = info->entries;
-	xt_compat_init_offsets(AF_INET, info->number);
+	ret = xt_compat_init_offsets(AF_INET, info->number);
+	if (ret)
+		return ret;
 	xt_entry_foreach(iter, loc_cpu_entry, info->size) {
 		ret = compat_calc_entry(iter, info, loc_cpu_entry, newinfo);
 		if (ret != 0)
@@ -1407,7 +1409,9 @@ translate_compat_table(struct net *net,
 
 	j = 0;
 	xt_compat_lock(AF_INET);
-	xt_compat_init_offsets(AF_INET, compatr->num_entries);
+	ret = xt_compat_init_offsets(AF_INET, compatr->num_entries);
+	if (ret)
+		goto out_unlock;
 	/* Walk through entries, checking offsets. */
 	xt_entry_foreach(iter0, entry0, compatr->size) {
 		ret = check_compat_entry_size_and_hooks(iter0, info, &size,
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -949,7 +949,9 @@ static int compat_table_info(const struc
 	memcpy(newinfo, info, offsetof(struct xt_table_info, entries));
 	newinfo->initial_entries = 0;
 	loc_cpu_entry = info->entries;
-	xt_compat_init_offsets(AF_INET6, info->number);
+	ret = xt_compat_init_offsets(AF_INET6, info->number);
+	if (ret)
+		return ret;
 	xt_entry_foreach(iter, loc_cpu_entry, info->size) {
 		ret = compat_calc_entry(iter, info, loc_cpu_entry, newinfo);
 		if (ret != 0)
@@ -1415,7 +1417,7 @@ translate_compat_table(struct net *net,
 	struct compat_ip6t_entry *iter0;
 	struct ip6t_replace repl;
 	unsigned int size;
-	int ret = 0;
+	int ret;
 
 	info = *pinfo;
 	entry0 = *pentry0;
@@ -1424,7 +1426,9 @@ translate_compat_table(struct net *net,
 
 	j = 0;
 	xt_compat_lock(AF_INET6);
-	xt_compat_init_offsets(AF_INET6, compatr->num_entries);
+	ret = xt_compat_init_offsets(AF_INET6, compatr->num_entries);
+	if (ret)
+		goto out_unlock;
 	/* Walk through entries, checking offsets. */
 	xt_entry_foreach(iter0, entry0, compatr->size) {
 		ret = check_compat_entry_size_and_hooks(iter0, info, &size,
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -605,10 +605,12 @@ int xt_compat_calc_jump(u_int8_t af, uns
 }
 EXPORT_SYMBOL_GPL(xt_compat_calc_jump);
 
-void xt_compat_init_offsets(u_int8_t af, unsigned int number)
+int xt_compat_init_offsets(u8 af, unsigned int number)
 {
 	xt[af].number = number;
 	xt[af].cur = 0;
+
+	return 0;
 }
 EXPORT_SYMBOL(xt_compat_init_offsets);
 
