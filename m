Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AA5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF47D20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF47D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeLJEtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:49:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeLJEtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:49:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91C9C3082AF3;
        Mon, 10 Dec 2018 04:49:21 +0000 (UTC)
Received: from sky.random (ovpn-120-40.rdu2.redhat.com [10.10.120.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D89EB608F2;
        Mon, 10 Dec 2018 04:49:16 +0000 (UTC)
Date:   Sun, 9 Dec 2018 23:49:16 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181210044916.GC24097@redhat.com>
References: <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
 <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
 <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 10 Dec 2018 04:49:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Dec 09, 2018 at 04:29:13PM -0800, David Rientjes wrote:
> [..] on this platform, at least, hugepages are 
> preferred on the same socket but there isn't a significant benefit from 
> getting a cross socket hugepage over small page. [..]

You didn't release the proprietary software that depends on
__GFP_THISNODE behavior and that you're afraid is getting a
regression.

Could you at least release with an open source license the benchmark
software that you must have used to do the above measurement to
understand why it gives such a weird result on remote THP?

On skylake and on the threadripper I can't confirm that there isn't a
significant benefit from cross socket hugepage over cross socket small
page.

Skylake Xeon(R) Gold 5115:

# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 20 21 22 23 24 25 26 27 28 29
node 0 size: 15602 MB
node 0 free: 14077 MB
node 1 cpus: 10 11 12 13 14 15 16 17 18 19 30 31 32 33 34 35 36 37 38 39
node 1 size: 16099 MB
node 1 free: 15949 MB
node distances:
node   0   1
  0:  10  21
  1:  21  10
# numactl -m 0 -C 0 ./numa-thp-bench
random writes MADV_HUGEPAGE 10109753 usec
random writes MADV_NOHUGEPAGE 13682041 usec
random writes MADV_NOHUGEPAGE 13704208 usec
random writes MADV_HUGEPAGE 10120405 usec
# numactl -m 0 -C 10 ./numa-thp-bench
random writes MADV_HUGEPAGE 15393923 usec
random writes MADV_NOHUGEPAGE 19644793 usec
random writes MADV_NOHUGEPAGE 19671287 usec
random writes MADV_HUGEPAGE 15495281 usec
# grep Xeon /proc/cpuinfo |head -1
model name      : Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz

local 4k -> local 2m: +35%
local 4k -> remote 2m: -11% 
remote 4k -> remote 2m: +26%

threadripper 1950x:

# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 16 17 18 19 20 21 22 23
node 0 size: 15982 MB
node 0 free: 14422 MB
node 1 cpus: 8 9 10 11 12 13 14 15 24 25 26 27 28 29 30 31
node 1 size: 16124 MB
node 1 free: 5357 MB
node distances:
node   0   1
  0:  10  16
  1:  16  10
# numactl -m 0 -C 0 /tmp/numa-thp-bench
random writes MADV_HUGEPAGE 12902667 usec
random writes MADV_NOHUGEPAGE 17543070 usec
random writes MADV_NOHUGEPAGE 17568858 usec
random writes MADV_HUGEPAGE 12896588 usec
# numactl -m 0 -C 8 /tmp/numa-thp-bench
random writes MADV_HUGEPAGE 19663515 usec
random writes MADV_NOHUGEPAGE 27819864 usec
random writes MADV_NOHUGEPAGE 27844066 usec
random writes MADV_HUGEPAGE 19662706 usec
# grep Threadripper /proc/cpuinfo |head -1
model name      : AMD Ryzen Threadripper 1950X 16-Core Processor

local 4k -> local 2m: +35%
local 4k -> remote 2m: -10% 
remote 4k -> remote 2m: +41%

Or if you prefer reversed in terms of compute time (negative
percentage is better in this case):

local 4k -> local 2m: -26%
local 4k -> remote 2m: +12%
remote 4k -> remote 2m: -29%

It's true that local 4k is generally a win vs remote THP when the
workload is memory bound also for the threadripper, the threadripper
seems even more favorable to remote THP than skylake Xeon is.

The above is the host bare metal result. Now let's try guest mode on
the threadripper. The last two lines seems more reliable (the first
two lines also needs to fault in the guest RAM because the guest
was fresh booted).

guest backed by local 2M pages:

random writes MADV_HUGEPAGE 16025855 usec
random writes MADV_NOHUGEPAGE 21903002 usec
random writes MADV_NOHUGEPAGE 19762767 usec
random writes MADV_HUGEPAGE 15189231 usec

guest backed by remote 2M pages:

random writes MADV_HUGEPAGE 25434251 usec
random writes MADV_NOHUGEPAGE 32404119 usec
random writes MADV_NOHUGEPAGE 31455592 usec
random writes MADV_HUGEPAGE 22248304 usec

guest backed by local 4k pages:

random writes MADV_HUGEPAGE 28945251 usec
random writes MADV_NOHUGEPAGE 32217690 usec
random writes MADV_NOHUGEPAGE 30664731 usec
random writes MADV_HUGEPAGE 22981082 usec

guest backed by remote 4k pages:

random writes MADV_HUGEPAGE 43772939 usec
random writes MADV_NOHUGEPAGE 52745664 usec
random writes MADV_NOHUGEPAGE 51632065 usec
random writes MADV_HUGEPAGE 40263194 usec

I haven't yet tried the guest mode on the skylake nor
haswell/broadwell. I can do that too but I don't expect a significant
difference.

On a threadripper guest, the remote 2m is practically identical to
local 4k. So shutting down compaction to try to generate local 4k
memory looks a sure loss.

Even if we ignore the guest mode results completely, if we don't make
assumption on the workload to be able to fit in the node, if I use
MADV_HUGEPAGE I think I'd prefer the risk of a -10% slowdown if the
THP page ends up in a remote node, than not getting the +41% THP
speedup on remote memory if the pagetable ends up being remote or the
4k page itself ends up being remote over time.

The cons left from your latest patch, is that you eventually also lose
the +35% speedup when compaction is clogged by COMPACT_SKIPPED, which
for a guest mode computation translates in losing the +59% speedup of
having host local THP (when guest uses 4k pages). khugepaged will
correct that by unclogging compaction but it may take hours. The idea
was to have MADV_HUGEPAGE provide THP without having to wait for
khugepaged to catch up with it.

Thanks,
Andrea

=====
/*
 *  numa-thp-bench.c
 *
 *  Copyright (C) 2018 Red Hat, Inc.
 *
 *  This work is licensed under the terms of the GNU GPL, version 2.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/time.h>

#define HPAGE_PMD_SIZE (2*1024*1024)
#define SIZE (2048UL*1024*1024-HPAGE_PMD_SIZE)
#if SIZE >= RAND_MAX
#error "SIZE >= RAND_MAX"
#endif
#define RATIO 5

int main()
{
	char * p;
	struct timeval before, after;
	unsigned long i;

	if (posix_memalign((void **) &p, HPAGE_PMD_SIZE, SIZE))
		perror("posix_memalign"), exit(1);
	if (madvise(p, SIZE, MADV_HUGEPAGE))
		perror("madvise"), exit(1);
	memset(p, 0, SIZE);
	srand(100);
	if (gettimeofday(&before, NULL))
		perror("gettimeofday"), exit(1);
	for (i = 0; i < SIZE / RATIO; i++)
		p[rand() % SIZE] = 0;
	if (gettimeofday(&after, NULL))
		perror("gettimeofday"), exit(1);
	printf("random writes MADV_HUGEPAGE %lu usec\n",
	       (after.tv_sec-before.tv_sec)*1000000UL +
	       after.tv_usec-before.tv_usec);
	munmap(p, SIZE);

	if (posix_memalign((void **) &p, HPAGE_PMD_SIZE, SIZE))
		perror("posix_memalign"), exit(1);
	if (madvise(p, SIZE, MADV_NOHUGEPAGE))
		perror("madvise"), exit(1);
	memset(p, 0, SIZE);
	srand(100);
	if (gettimeofday(&before, NULL))
		perror("gettimeofday"), exit(1);
	for (i = 0; i < SIZE / RATIO; i++)
		p[rand() % SIZE] = 0;
	if (gettimeofday(&after, NULL))
		perror("gettimeofday"), exit(1);
	printf("random writes MADV_NOHUGEPAGE %lu usec\n",
	       (after.tv_sec-before.tv_sec)*1000000UL +
	       after.tv_usec-before.tv_usec);
	munmap(p, SIZE);

	if (posix_memalign((void **) &p, HPAGE_PMD_SIZE, SIZE))
		perror("posix_memalign"), exit(1);
	if (madvise(p, SIZE, MADV_NOHUGEPAGE))
		perror("madvise"), exit(1);
	memset(p, 0, SIZE);
	srand(100);
	if (gettimeofday(&before, NULL))
		perror("gettimeofday"), exit(1);
	for (i = 0; i < SIZE / RATIO; i++)
		p[rand() % SIZE] = 0;
	if (gettimeofday(&after, NULL))
		perror("gettimeofday"), exit(1);
	printf("random writes MADV_NOHUGEPAGE %lu usec\n",
	       (after.tv_sec-before.tv_sec)*1000000UL +
	       after.tv_usec-before.tv_usec);
	munmap(p, SIZE);

	if (posix_memalign((void **) &p, HPAGE_PMD_SIZE, SIZE))
		perror("posix_memalign"), exit(1);
	if (madvise(p, SIZE, MADV_HUGEPAGE))
		perror("madvise"), exit(1);
	memset(p, 0, SIZE);
	srand(100);
	if (gettimeofday(&before, NULL))
		perror("gettimeofday"), exit(1);
	for (i = 0; i < SIZE / RATIO; i++)
		p[rand() % SIZE] = 0;
	if (gettimeofday(&after, NULL))
		perror("gettimeofday"), exit(1);
	printf("random writes MADV_HUGEPAGE %lu usec\n",
	       (after.tv_sec-before.tv_sec)*1000000UL +
	       after.tv_usec-before.tv_usec);
	munmap(p, SIZE);

	return 0;
}
