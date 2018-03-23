Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803598-2-7397566780218055220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803597; b=qvb8fL71ta8UXEbjv1RsnkLoVXK+jvcvuq0mK3EkH9CFBqn
    4XFCw0P/8WwWSxChnFHDfDbCTj1b9mc5H6Mu6obKQVkIxob308GPTGFmarXuVtXW
    v4t+m0DDCG+eUsVJsCdNc9NLHafJ1n8q3MCnGiiXRiYIsf4f9D1WUviUzNUAnwKe
    VLzb85PdZM2CCaNb1Yw5eOdwJN1f+DEh2p57C97OO4NTmh+46j3Qws/iJp+GgpeT
    CsXJvSX6Sg0kEuZfuhlhxOSPe2ydUbvb9awfdjK6lhqVk90SS3CXJYczPXGkp80H
    sJgrtdahIRm68GbyQ7xxoEDYQzL/e+/VXwjh4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803597; bh=0azNUqRf2ff2ZjSndgEj6ViFEs
    vKXe17t8d8w1iGa0o=; b=gHb0B7877g1ArEYqZFoJptRNkC54faOBZWJLqVY5Dw
    pxGFwOyxCBdBd5TNqur8OlnZ45Eu/MYAypHLjnr85/LmbvbHPxk/NrtaNCyD2e2a
    3yiTiUrQr0WfDKv1K6BtdqDP3BBwMOPiiTPap1SVxAUmr/3gbuoyOZEKIf/i2fKZ
    F6rHCuuVQPNdwONvuVeHnq3nHo0l5XGnkNMQVwKJzHfrR3RqyXc2wtjB3w+9CR50
    hqou8+RMkD64D4yGp7nCN6cRoHSpnL6fdQYg9++PODEl+zKOZs9aCHh/Gc1wIx0x
    HTLr/Kh+SeEf7MICdRT6e84Bc46OnhpufC+pLgQeVZ8A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755084AbeCWLNH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:13:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932746AbeCWKKj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 127/177] mm, vmstat: suppress pcp stats for unpopulated zones in zoneinfo
Date: Fri, 23 Mar 2018 10:54:15 +0100
Message-Id: <20180323094210.836282381@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rientjes <rientjes@google.com>


[ Upstream commit 7dfb8bf3b9caef4049bee51d2c22e1c3a311d483 ]

After "mm, vmstat: print non-populated zones in zoneinfo",
/proc/zoneinfo will show unpopulated zones.

The per-cpu pageset statistics are not relevant for unpopulated zones
and can be potentially lengthy, so supress them when they are not
interesting.

Also moves lowmem reserve protection information above pcp stats since
it is relevant for all zones per vm.lowmem_reserve_ratio.

Link: http://lkml.kernel.org/r/alpine.DEB.2.10.1703061400500.46428@chino.kir.corp.google.com
Signed-off-by: David Rientjes <rientjes@google.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmstat.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1387,18 +1387,24 @@ static void zoneinfo_show_print(struct s
 		   zone->present_pages,
 		   zone->managed_pages);
 
-	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		seq_printf(m, "\n      %-12s %lu", vmstat_text[i],
-				zone_page_state(zone, i));
-
 	seq_printf(m,
 		   "\n        protection: (%ld",
 		   zone->lowmem_reserve[0]);
 	for (i = 1; i < ARRAY_SIZE(zone->lowmem_reserve); i++)
 		seq_printf(m, ", %ld", zone->lowmem_reserve[i]);
-	seq_printf(m,
-		   ")"
-		   "\n  pagesets");
+	seq_putc(m, ')');
+
+	/* If unpopulated, no other information is useful */
+	if (!populated_zone(zone)) {
+		seq_putc(m, '\n');
+		return;
+	}
+
+	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
+		seq_printf(m, "\n      %-12s %lu", vmstat_text[i],
+				zone_page_state(zone, i));
+
+	seq_printf(m, "\n  pagesets");
 	for_each_online_cpu(i) {
 		struct per_cpu_pageset *pageset;
 
