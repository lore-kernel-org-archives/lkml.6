Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350ABC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4A120827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IiR8pH+C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CyGIEtm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4A120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbeKFRyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:54:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbeKFRyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:54:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB23B6049C; Tue,  6 Nov 2018 08:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541493015;
        bh=9HM5lR8Q7jn90QPLfAVJSXixLbiqqyzrXnH35bRZzvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IiR8pH+Cs0bLL3xHW+Iqbou1wxBzUypsXOJX/oWlre0uUol1qlJwpfoRM4diTqL4n
         XsLj+V5nroo8GWkWwt45rebGYtoQq3dfc339QEi8YmqPIGPpq0WozN0+5qGEYcDV+z
         kBOr7iNHmBBCN1akFgxgEyzLmjZeeLeJvNR6Q2/M=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6C5EE6049C;
        Tue,  6 Nov 2018 08:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541493014;
        bh=9HM5lR8Q7jn90QPLfAVJSXixLbiqqyzrXnH35bRZzvA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CyGIEtm1kadRPDHOMd2YT4W1EN4hfQ/vqmXN7FTyXIll5+6drYQth2SjoSN0cTCM5
         cweB62GjSismRAj8cBStDcn0BBzGpuRU4ppE5l5HB5zivf/se85i/zo5xYh0P07tVr
         3eMtRG1AzbshwG+5NrfgSBJwYuSaS6UrDWmr1F/8=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 06 Nov 2018 14:00:14 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     keescook@chromium.org, minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, julia.lawall@lip6.fr
Subject: Re: [PATCH v1 0/4]mm: convert totalram_pages, totalhigh_pages and
 managed pages to atomic
In-Reply-To: <63d9f48c-e39f-d345-0fb6-2f04afe769a2@yandex-team.ru>
References: <1540551662-26458-1-git-send-email-arunks@codeaurora.org>
 <9b210d4cc9925caf291412d7d45f16d7@codeaurora.org>
 <63d9f48c-e39f-d345-0fb6-2f04afe769a2@yandex-team.ru>
Message-ID: <08a61c003eed0280fd82f6200debcbca@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-06 13:47, Konstantin Khlebnikov wrote:
> On 06.11.2018 8:38, Arun KS wrote:
>> Any comments?
> 
> Looks good.
> Except unclear motivation behind this change.
> This should be in comment of one of patch.

totalram_pages, zone->managed_pages and totalhigh_pages are sometimes 
modified outside managed_page_count_lock. Hence convert these variable 
to atomic to avoid readers potentially seeing a store tear.

Will update the comment.

Regards,
Arun

> 
> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
>> 
>> Regards,
>> Arun
>> 
>> On 2018-10-26 16:30, Arun KS wrote:
>>> This series convert totalram_pages, totalhigh_pages and
>>> zone->managed_pages to atomic variables.
>>> 
>>> The patch was comiple tested on x86(x86_64_defconfig & 
>>> i386_defconfig)
>>> on tip of linux-mmotm. And memory hotplug tested on arm64, but on an
>>> older version of kernel.
>>> 
>>> Arun KS (4):
>>>   mm: Fix multiple evaluvations of totalram_pages and managed_pages
>>>   mm: Convert zone->managed_pages to atomic variable
>>>   mm: convert totalram_pages and totalhigh_pages variables to atomic
>>>   mm: Remove managed_page_count spinlock
>>> 
>>>  arch/csky/mm/init.c                           |  4 +-
>>>  arch/powerpc/platforms/pseries/cmm.c          | 10 ++--
>>>  arch/s390/mm/init.c                           |  2 +-
>>>  arch/um/kernel/mem.c                          |  3 +-
>>>  arch/x86/kernel/cpu/microcode/core.c          |  5 +-
>>>  drivers/char/agp/backend.c                    |  4 +-
>>>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
>>>  drivers/gpu/drm/i915/i915_gem.c               |  2 +-
>>>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  4 +-
>>>  drivers/hv/hv_balloon.c                       | 19 +++----
>>>  drivers/md/dm-bufio.c                         |  2 +-
>>>  drivers/md/dm-crypt.c                         |  2 +-
>>>  drivers/md/dm-integrity.c                     |  2 +-
>>>  drivers/md/dm-stats.c                         |  2 +-
>>>  drivers/media/platform/mtk-vpu/mtk_vpu.c      |  2 +-
>>>  drivers/misc/vmw_balloon.c                    |  2 +-
>>>  drivers/parisc/ccio-dma.c                     |  4 +-
>>>  drivers/parisc/sba_iommu.c                    |  4 +-
>>>  drivers/staging/android/ion/ion_system_heap.c |  2 +-
>>>  drivers/xen/xen-selfballoon.c                 |  6 +--
>>>  fs/ceph/super.h                               |  2 +-
>>>  fs/file_table.c                               |  7 +--
>>>  fs/fuse/inode.c                               |  2 +-
>>>  fs/nfs/write.c                                |  2 +-
>>>  fs/nfsd/nfscache.c                            |  2 +-
>>>  fs/ntfs/malloc.h                              |  2 +-
>>>  fs/proc/base.c                                |  2 +-
>>>  include/linux/highmem.h                       | 28 ++++++++++-
>>>  include/linux/mm.h                            | 27 +++++++++-
>>>  include/linux/mmzone.h                        | 15 +++---
>>>  include/linux/swap.h                          |  1 -
>>>  kernel/fork.c                                 |  5 +-
>>>  kernel/kexec_core.c                           |  5 +-
>>>  kernel/power/snapshot.c                       |  2 +-
>>>  lib/show_mem.c                                |  2 +-
>>>  mm/highmem.c                                  |  4 +-
>>>  mm/huge_memory.c                              |  2 +-
>>>  mm/kasan/quarantine.c                         |  2 +-
>>>  mm/memblock.c                                 |  6 +--
>>>  mm/memory_hotplug.c                           |  4 +-
>>>  mm/mm_init.c                                  |  2 +-
>>>  mm/oom_kill.c                                 |  2 +-
>>>  mm/page_alloc.c                               | 71 
>>> +++++++++++++--------------
>>>  mm/shmem.c                                    |  7 +--
>>>  mm/slab.c                                     |  2 +-
>>>  mm/swap.c                                     |  2 +-
>>>  mm/util.c                                     |  2 +-
>>>  mm/vmalloc.c                                  |  4 +-
>>>  mm/vmstat.c                                   |  4 +-
>>>  mm/workingset.c                               |  2 +-
>>>  mm/zswap.c                                    |  4 +-
>>>  net/dccp/proto.c                              |  7 +--
>>>  net/decnet/dn_route.c                         |  2 +-
>>>  net/ipv4/tcp_metrics.c                        |  2 +-
>>>  net/netfilter/nf_conntrack_core.c             |  7 +--
>>>  net/netfilter/xt_hashlimit.c                  |  5 +-
>>>  net/sctp/protocol.c                           |  7 +--
>>>  security/integrity/ima/ima_kexec.c            |  2 +-
>>>  58 files changed, 195 insertions(+), 144 deletions(-)
