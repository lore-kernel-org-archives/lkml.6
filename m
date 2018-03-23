Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803614-2-7266370105181297526
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803613; b=a9n7MjeiQ7o/Gkj9ISh/SRCdG6TBePnJaQh7IgFr0Y9DCpt
    rUT45s/CYhkKkyV21E2F4HQ89xraDAnZFFFh9/pgXCwPXMoUKwKnEOe7VgwAYQGP
    kJtwI5I3KDjiCuVxf0UqAwAtq233CXAAjkDyVU019fqRAkhegn0eqH0l29WRkaMu
    F1+1tWMFAO/SGm1U9qQTFYXHvBxTRaQPwuMkox3VJNnf71UB14FSV41/rQshPMh9
    23v4tQaTwB7Q/obMtMNDE2E/bwLWYTDDBo4xYKN7wMg8Ob+CPearH80LdX31r4fs
    FTjRKn1eLjBXnOd0aP/natc/JWTQLODp21nG+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803613; bh=lcXRRJ89fyzYvEgmpIYK2x73J3
    rBiPxS5q4CV2EjPNY=; b=u/E7fp+Fn6TQhsB/g3f4nMu258EBuCGLXnCG9Q8YQP
    nqH5rYl1HyKj8Jj+xdmweWx7iowRz/jaR3BMIEUncZT2ySHP/KcM25y6Bx+p+1+B
    25oQMigWAC6nCp3VGmGKjVEkfcJMtTO9tdE436HcVW3QYOFV8KkhtOaQ+eh16i6o
    89DUzIHZJf89YPlxznQKTFrcpLG/YFTJbU7WtsAbpPkrclM6t11lAdSL/ODNacG6
    l3vjVH86HWFQqlEF9QEQ9b/IarBVneoDNKqXicj4rg2Q+n3nk4VMNe0XEjf7ZREN
    LY9WR0QTb7h1GH4iMEg0CESMM9D2gDEiNfjX4ROTYRQg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932744AbeCWKKi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbeCWKKg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hillf.zj@alibaba-inc.com>,
        Michal Hocko <mhocko@suse.com>, Jia He <hejianet@gmail.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 126/177] mm: fix check for reclaimable pages in PF_MEMALLOC reclaim throttling
Date: Fri, 23 Mar 2018 10:54:14 +0100
Message-Id: <20180323094210.796866037@linuxfoundation.org>
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

From: Johannes Weiner <hannes@cmpxchg.org>


[ Upstream commit d450abd81b081d45adb12f303a07dd44b15eb1bc ]

PF_MEMALLOC direct reclaimers get throttled on a node when the sum of
all free pages in each zone fall below half the min watermark.  During
the summation, we want to exclude zones that don't have reclaimables.
Checking the same pgdat over and over again doesn't make sense.

Fixes: 599d0c954f91 ("mm, vmscan: move LRU lists to node")
Link: http://lkml.kernel.org/r/20170228214007.5621-3-hannes@cmpxchg.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Jia He <hejianet@gmail.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2841,8 +2841,10 @@ static bool allow_direct_reclaim(pg_data
 
 	for (i = 0; i <= ZONE_NORMAL; i++) {
 		zone = &pgdat->node_zones[i];
-		if (!managed_zone(zone) ||
-		    pgdat_reclaimable_pages(pgdat) == 0)
+		if (!managed_zone(zone))
+			continue;
+
+		if (!zone_reclaimable_pages(zone))
 			continue;
 
 		pfmemalloc_reserve += min_wmark_pages(zone);
