Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBADECDE47
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D032086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPCu/eVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D032086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeJ0BiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:38:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44928 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbeJ0BiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:38:06 -0400
Received: by mail-io1-f67.google.com with SMTP id c6-v6so1122770iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wSXtAawvihxmBBWG9V+ixp5iLPsNQxELbPvdWyFd9H0=;
        b=pPCu/eVtBvaLh0BalSnPnEPEX26FIuIFe/5ZJ5VTwBUP1CSjLwbIpDJd2WXZsz6TGJ
         QXjk8TPBvCrhwmcSrAGCgSfkidUu45mAFogVDkATZDdKnH2ObmQjk5GlHCQL6QDiHWRK
         o03C6cLqgjd92KVAzYZQnyg7HUNK1v9uO/9eiQ1TJ4GQ8gp1uB4/8grJnP9XFz1Nv1DW
         YferAw57k+r44ynadT+lSJywBSyt+xrhOVUdRsMh0qONzOiHKl06I/MGHHgyFqB7wTVE
         EfAHiMIP1Z6BqSRLu3GlMVQ3Wjm0ZYQP0pAch3B1fbGO8i/NeKtAzpHIyz9I7cAFtV8x
         BkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wSXtAawvihxmBBWG9V+ixp5iLPsNQxELbPvdWyFd9H0=;
        b=i4ZSNxgbIhCjbZxkagLCPTNQFmWJK8agxI2Hr8/MWCRD2ZgbIneIB9Up1GxpcOZa0G
         t/phn0CKsUtPWIlb6ObXubqOU2YA+nAJmIuwl9y0gLIU/90GkFwBkyzjtvDxjLjnw7g4
         aCyvCyIL1ywpHfrgfRVAcKyNNCgbznAB/bf+YB9ZuzEtY2GfefpGLuJ7/5CxERKVEcf6
         cUu4dinewBhQ6dv6Qpnn7fDUwzAljefC4qy0ucjNIQccJbrTTTh7Nv+7KVLUG1spTWeH
         FAbcmvGyJWtRKaIuZ3wnQBafniHHqhFdTnmQWIR/13PAtu7lRBvTmebtGv2fYs5RHxB2
         q8Fw==
X-Gm-Message-State: AGRZ1gJBxWGWZfZolu5+zx2Kk5g/UKj7AhJZ0/+TAkPrR/amLzf7zZl+
        jR6bB62Y2DlMCCRMoBC/DgwrGmxNSHWBSSjrL5o4FDxh1A==
X-Google-Smtp-Source: AJdET5c8AWcMlbFQ83MK+Ng2FZxrpR2vKSKBZ1JFOpkWLY7YuxO8WauVhmg9FMMfTq1fyOiVewr6N7BS7BJQK50XizY=
X-Received: by 2002:a6b:db08:: with SMTP id t8-v6mr2727428ioc.132.1540573218850;
 Fri, 26 Oct 2018 10:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181023164302.20436-1-guro@fb.com> <20181026085735.GZ18839@dhcp22.suse.cz>
 <20181026155652.GA7647@tower.DHCP.thefacebook.com>
In-Reply-To: <20181026155652.GA7647@tower.DHCP.thefacebook.com>
From:   Spock <dairinin@gmail.com>
Date:   Fri, 26 Oct 2018 20:00:07 +0300
Message-ID: <CADa=ObqajeQkJA6cR_LXDLT8hrZcFY7kHFxSTFuX=Fg8GkQv1w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
To:     guro@fb.com
Cc:     mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com, riel@surriel.com,
        rdunlap@infradead.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 26 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 18:57, Roman Gushc=
hin <guro@fb.com>:
>
> On Fri, Oct 26, 2018 at 10:57:35AM +0200, Michal Hocko wrote:
> > Spock doesn't seem to be cced here - fixed now
> >
> > On Tue 23-10-18 16:43:29, Roman Gushchin wrote:
> > > Spock reported that the commit 172b06c32b94 ("mm: slowly shrink slabs
> > > with a relatively small number of objects") leads to a regression on
> > > his setup: periodically the majority of the pagecache is evicted
> > > without an obvious reason, while before the change the amount of free
> > > memory was balancing around the watermark.
> > >
> > > The reason behind is that the mentioned above change created some
> > > minimal background pressure on the inode cache. The problem is that
> > > if an inode is considered to be reclaimed, all belonging pagecache
> > > page are stripped, no matter how many of them are there. So, if a hug=
e
> > > multi-gigabyte file is cached in the memory, and the goal is to
> > > reclaim only few slab objects (unused inodes), we still can eventuall=
y
> > > evict all gigabytes of the pagecache at once.
> > >
> > > The workload described by Spock has few large non-mapped files in the
> > > pagecache, so it's especially noticeable.
> > >
> > > To solve the problem let's postpone the reclaim of inodes, which have
> > > more than 1 attached page. Let's wait until the pagecache pages will
> > > be evicted naturally by scanning the corresponding LRU lists, and onl=
y
> > > then reclaim the inode structure.
> >
> > Has this actually fixed/worked around the issue?
>
> Spock wrote this earlier to me directly. I believe I can quote it here:
>
> "Patch applied, looks good so far. System behaves like it was with
> pre-4.18.15 kernels.
> Also tried to add some user-level tests to the geneic background activity=
, like
> - stat'ing a bunch of files
> - streamed read several large files at once on ext4 and XFS
> - random reads on the whole collection with a read size of 16K
>
> I will be monitoring while fragmentation stacks up and report back if
> something bad happens."
>
> Spock, please let me know if you have any new results.
>
> Thanks!

Hello,

I'd say the patch fixed the problem, at least with my workload

MemTotal:        8164968 kB
MemFree:          135852 kB
MemAvailable:    6406088 kB
Buffers:           11988 kB
Cached:          6414124 kB
SwapCached:            0 kB
Active:          1491952 kB
Inactive:        5989576 kB
Active(anon):     542512 kB
Inactive(anon):   523780 kB
Active(file):     949440 kB
Inactive(file):  5465796 kB
Unevictable:        8872 kB
Mlocked:            8872 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:               128 kB
Writeback:             0 kB
AnonPages:       1064232 kB
Mapped:            32348 kB
Shmem:              3952 kB
Slab:             205108 kB
SReclaimable:     148792 kB
SUnreclaim:        56316 kB
KernelStack:        3984 kB
PageTables:        11100 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     8276784 kB
Committed_AS:    1944792 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
AnonHugePages:      6144 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
DirectMap4k:      271872 kB
DirectMap2M:     8116224 kB
