Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159697-2-9699348645771582534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159693; b=eNxqZ1buSzia7sbz+lo3S8d27CkwL+mkABl183LJj6nXglqqf9
    +2kdHDCK445UuuBZW0UNKZTsu3yguK1PH9noXy5w3YprsW5IzMFJKuERj3hsUwl9
    1Scb9SJZlIZDarMAr5frzeAOadtfAL3thEHRERlTGirJ6R/Lak2mYAO1iggizmQH
    eqqZ4W53b2HTdI84lCMZC1vJsQaiUlCvcVp9djjfTzqxqfbSQHHLKHqRVgDNt9vi
    P9h7ohEj+DMjnLF/9ol4a9xqlU89+ks+4v7nt7pLySgXBn8QDuYSR4EiZOZKyDhO
    REERwtPIBw9wx9rmfRDijRE3T1psuQP3NmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527159693; bh=0fw1mPOsXc8FEmFtkeddvdX4m8iR/8
    bNR5ELH3PIhf0=; b=bF9ytxQ6GD0EZ8Kc6xA8L0F+YxtGAz2hWn+WZQilAY1r+L
    o1HMBnS6X1enSMhLqZLIDcEdZDcq3twIMjOBPlZDxxHHo8f86biKrXxEaWdfAIX0
    wuYVlbRtFCzbO60LjhPfAgkJeY/6uSD4jS51SXGevoZNOXt0Z8TUSdWd4VW5gY1U
    iARN3ylR2+zXhiClgwG8TERkTGiS0UYehfM19pX2h/12HoZ5FQg5OhUHO/S4RCsa
    pRMX2dOw3cUuMJFauhPYEhN+aeB4YqtsGCE67TG23miluU/g2tLVZKV18Oqr+i4W
    966tZ/lQNljy/Vt4n3d+9ThidbeA71eD6vrZTeiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFKh+9PEmZ+Th1IDs6tXSH+O5cpU5lfbUlsJyXkiutQ7rqXjTcSVh8coAZ9FRveqkh1yavQBUz/TSC+1PiSbVWgturqElvdn8slPoAhDXNjV9zhdls8b
    5H85ywmxQNhVxGHcvdoA8prZ+RZ8LFgPzLq3pCCbeTWH7EFsLSzLqfnrMltDxudjUVV24IaKCUWn/g8Gk6K0uWPJ1bwCkYiCJKFKYxNYymAnaCtxHc4JFAjs
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=07d9gI8wAAAA:8
    a=VwQbUJbxAAAA:8 a=c7s9rzn1BL-BijeSB3gA:9 a=x8gzFH9gYPwA:10
    a=e2CUPOnPG4QKp8I52DXD:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030298AbeEXLBT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:01:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:36185 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967917AbeEXLA0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 May 2018 07:00:26 -0400
From: Vlastimil Babka <vbabka@suse.cz>
To: linux-mm@kvack.org
Cc: Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH 0/5] kmalloc-reclaimable caches
Date: Thu, 24 May 2018 13:00:06 +0200
Message-Id: <20180524110011.1940-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.17.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

as discussed at LSF/MM [1] here's a RFC patchset that introduces
kmalloc-reclaimable caches (more details in the first patch) and uses them
for SLAB freelists and dcache external names. The latter allows us to
repurpose the NR_INDIRECTLY_RECLAIMABLE_BYTES counter later in the series.

This is how /proc/slabinfo looks like after booting in virtme:

...
kmalloc-reclaimable-4194304      0      0 4194304    1 1024 : tunables    1    1    0 : slabdata      0      0      0
...
kmalloc-reclaimable-96     17     64    128   32    1 : tunables  120   60    8 : slabdata      2      2      0
kmalloc-reclaimable-64     50    128     64   64    1 : tunables  120   60    8 : slabdata      2      2      6
kmalloc-reclaimable-32      0      0     32  124    1 : tunables  120   60    8 : slabdata      0      0      0
kmalloc-4194304        0      0 4194304    1 1024 : tunables    1    1    0 : slabdata      0      0      0
...
kmalloc-64          2888   2944     64   64    1 : tunables  120   60    8 : slabdata     46     46    454
kmalloc-32          4325   4712     32  124    1 : tunables  120   60    8 : slabdata     38     38    563
kmalloc-128         1178   1216    128   32    1 : tunables  120   60    8 : slabdata     38     38    114
...

/proc/vmstat with new/renamed nr_reclaimable counter (patch 4):

...
nr_slab_reclaimable 2817
nr_slab_unreclaimable 1781
...
nr_reclaimable 2817
...

/proc/meminfo with exposed nr_reclaimable counter (patch 5):

...
AnonPages:          8624 kB
Mapped:             3340 kB
Shmem:               564 kB
Reclaimable:       11272 kB
Slab:              18368 kB
SReclaimable:      11272 kB
SUnreclaim:         7096 kB
KernelStack:        1168 kB
PageTables:          448 kB
...

Now for the issues a.k.a. why RFC:

- I haven't find any other obvious users for reclaimable kmalloc (yet)
- the name of caches kmalloc-reclaimable-X is rather long
- the vmstat/meminfo counter name is rather general and might suggest it also
  includes reclaimable page caches, which it doesn't

Suggestions welcome for all three points. For the last one, we might also keep
the counter separate from nr_slab_reclaimable, not superset. I did a superset
as IIRC somebody suggested that in the older threads or at LSF.

Thanks,
Vlastimil


[1] https://lwn.net/Articles/753154/

Vlastimil Babka (5):
  mm, slab/slub: introduce kmalloc-reclaimable caches
  mm, slab: allocate off-slab freelists as reclaimable when appropriate
  dcache: allocate external names from reclaimable kmalloc caches
  mm: rename and change semantics of nr_indirectly_reclaimable_bytes
  mm, proc: add NR_RECLAIMABLE to /proc/meminfo

 drivers/base/node.c                         |  2 +
 drivers/staging/android/ion/ion_page_pool.c |  4 +-
 fs/dcache.c                                 | 40 ++++-----------
 fs/proc/meminfo.c                           |  3 +-
 include/linux/mmzone.h                      |  2 +-
 include/linux/slab.h                        | 17 +++++--
 mm/page_alloc.c                             | 15 ++----
 mm/slab.c                                   | 23 ++++++---
 mm/slab_common.c                            | 56 ++++++++++++++-------
 mm/slub.c                                   | 12 ++---
 mm/util.c                                   | 16 ++----
 mm/vmstat.c                                 |  6 +--
 12 files changed, 99 insertions(+), 97 deletions(-)

-- 
2.17.0

