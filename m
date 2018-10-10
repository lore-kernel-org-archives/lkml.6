Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC2EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A082087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="k4GDWgrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A082087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJJVZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:25:02 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38784 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeJJVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:25:01 -0400
Received: by mail-yw1-f66.google.com with SMTP id d126-v6so2197209ywa.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hHSi2pwfH584jpoiYp3UiOhBqufzdjrZ+8fAT/p/Rng=;
        b=k4GDWgrQxk8ThiBoQJftcn8rAvBnFPNPq6r39sSkXvMgShaxfO6TGz52RA8oScXaU5
         eGJUfhRByEmV3hil6B5yQcduoaPtx0PwuwudLRNwZT+YemM5qrndKUb4gVANwCrzF4l/
         FwzUNJ3nGp/y+ubQN6XOQ+hsuIWEkB4zsIkq5L8BNMWIjv2ITLopotxR3S9xbcj+iyAI
         nwUWMGgUtbD1NhWozqAcODD27T17MMVyf6VXU/UNGDjbG6JriIOCoBAAQgjNX7JjmXy2
         foJyttJgQBDBQaWajMrr9YXl2pLFxV84LOX+Jpoamfk2uTJSyXb0jOzSjVbajGRywlw+
         tXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hHSi2pwfH584jpoiYp3UiOhBqufzdjrZ+8fAT/p/Rng=;
        b=XNjfzpvFJ3JTXCxEC0w/ETdEAa8GvepE5FD6BPUYk3h3gaKYtLiBMqSFnh8lRYck6f
         g5RyzPgM2cEx1Ktqz9XJfChqunY/dcvLZfqTCl8CVdpb48zYzzA6pk25c/FCl+gMYNKW
         vya7IWP5CtvNkGw54fQ/nJCWA7rEYQ/r5n9F8Z/HYsjpMYtqRUdWEnWFkPe0lS53pgh1
         M0xW+tGFIDy4SJQn7PZEOJJrATjdDaFJd8US4FwGbkE03vjF3LSnS4jCAXl+rjbaA6Nj
         qjb6fnXm7bmMJZ5jhmu8J/bPPB2tr6d6wSK62Xry9tW7EMm1pzFs6VIZNgY3+iKI20Vz
         cMbg==
X-Gm-Message-State: ABuFfoi/iGWi66Uc/z1rIRDfg3QKf3uDE/VRjTRkpkUUIiepkcGKh5u7
        +RFSjU4r4AQIxAcfmD1s0e/27g==
X-Google-Smtp-Source: ACcGV60ilCUpDyOWFw9GUiCPl+PGx9ZM7kHBksFm01p9hDBzXoBwisbgxyW9CooWhVXlGC2Ch/v+zw==
X-Received: by 2002:a81:560a:: with SMTP id k10-v6mr18044450ywb.80.1539180162027;
        Wed, 10 Oct 2018 07:02:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:4a04])
        by smtp.gmail.com with ESMTPSA id w207-v6sm40167509yww.95.2018.10.10.07.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 07:02:40 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:02:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/4] mm: workingset: add vmstat counter for shadow nodes
Message-ID: <20181010140239.GA2527@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
 <20181009184732.762-4-hannes@cmpxchg.org>
 <20181009150401.c72cde05338c1ec80a4b8701@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009150401.c72cde05338c1ec80a4b8701@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:04:01PM -0700, Andrew Morton wrote:
> On Tue,  9 Oct 2018 14:47:32 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Make it easier to catch bugs in the shadow node shrinker by adding a
> > counter for the shadow nodes in circulation.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  include/linux/mmzone.h |  1 +
> >  mm/vmstat.c            |  1 +
> >  mm/workingset.c        | 12 ++++++++++--
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 4179e67add3d..d82e80d82aa6 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -161,6 +161,7 @@ enum node_stat_item {
> >  	NR_SLAB_UNRECLAIMABLE,
> >  	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
> >  	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
> > +	WORKINGSET_NODES,
> 
> Documentation/admin-guide/cgroup-v2.rst, please.  And please check for
> any other missing items while in there?

The new counter isn't being added to the per-cgroup memory.stat,
actually, it just shows in /proc/vmstat.

It seemed a bit too low-level for the cgroup interface, and the other
stats in there are in bytes, which isn't straight-forward to calculate
with sl*b packing.

Not that I'm against adding a cgroup breakdown in general, but the
global counter was enough to see if things were working right or not,
so I'd cross that bridge when somebody needs it per cgroup.

But I checked cgroup-v2.rst anyway: all the exported items are
documented. Only the reclaim vs. refault stats were in different
orders: the doc has the refault stats first, the interface leads with
the reclaim stats. The refault stats go better with the page fault
stats, and are probably of more interest (since they have higher
impact on performance) than the LRU shuffling, so maybe this?

---
Subject: [PATCH] mm: memcontrol: fix memory.stat item ordering

The refault stats go better with the page fault stats, and are of
higher interest than the stats on LRU operations. In fact they used to
be grouped together; when the LRU operation stats were added later on,
they were wedged in between.

Move them back together. Documentation/admin-guide/cgroup-v2.rst
already lists them in the right order.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 81b47d0b14d7..ed15f233d31d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5575,6 +5575,13 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	seq_printf(m, "pgfault %lu\n", acc.events[PGFAULT]);
 	seq_printf(m, "pgmajfault %lu\n", acc.events[PGMAJFAULT]);
 
+	seq_printf(m, "workingset_refault %lu\n",
+		   acc.stat[WORKINGSET_REFAULT]);
+	seq_printf(m, "workingset_activate %lu\n",
+		   acc.stat[WORKINGSET_ACTIVATE]);
+	seq_printf(m, "workingset_nodereclaim %lu\n",
+		   acc.stat[WORKINGSET_NODERECLAIM]);
+
 	seq_printf(m, "pgrefill %lu\n", acc.events[PGREFILL]);
 	seq_printf(m, "pgscan %lu\n", acc.events[PGSCAN_KSWAPD] +
 		   acc.events[PGSCAN_DIRECT]);
@@ -5585,13 +5592,6 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	seq_printf(m, "pglazyfree %lu\n", acc.events[PGLAZYFREE]);
 	seq_printf(m, "pglazyfreed %lu\n", acc.events[PGLAZYFREED]);
 
-	seq_printf(m, "workingset_refault %lu\n",
-		   acc.stat[WORKINGSET_REFAULT]);
-	seq_printf(m, "workingset_activate %lu\n",
-		   acc.stat[WORKINGSET_ACTIVATE]);
-	seq_printf(m, "workingset_nodereclaim %lu\n",
-		   acc.stat[WORKINGSET_NODERECLAIM]);
-
 	return 0;
 }
 

