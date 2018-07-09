Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306A5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99DA20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ivSn4YbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99DA20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeGIWHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:07:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45022 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeGIWHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:07:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so1536128pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=251MKHFIg8gvnGzNL1OWN9Vz36YYRLhQHV5ECZsbPHg=;
        b=ivSn4YbZ7C8cuVl8YKOPC9rfx3q/1V60JmpsQy8kH6Q9YqG6/Ipnn8XImVo8vOqqGw
         uo23LtrFBRzIx8+2hOaETrfKo6klqwTnDTUfu7/4yrwk7HoCytE4T0+fhMSARM4GgLC2
         5rlLDN/gP6daszJnDUlkZ4TI/i2tMJFOJVB1VmdLBBHrk6XBwXdWISGyNyErNA2T0Qu5
         LE5pSl/kMmA6oTBJzgXMYNyNjeSYMWDMoKYCR57MeXz+P/lUgasyjEugvH/Y4AbSIfvJ
         j4eYGD50wU+S4Y3it5v7hSLm1rSYi9fxC05rnbsEtug+zl0HMmu/0dPvUIgGcJf2iOQM
         iEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=251MKHFIg8gvnGzNL1OWN9Vz36YYRLhQHV5ECZsbPHg=;
        b=MEBhojAstWFJnp81/Em5uKG8KTcZ8NQ3whwC4LQYgMVpT5aXIC/nVmfRMx5o57NJBX
         +CT3WrY5uCOHm6ezIlt7xJoY0PK9MwFxZ0vK7YnGUP7poQpHDlltiI8+2Zc6Sf207rUr
         MVWNqDKI2vwnILU4KqD+fgCTbHx+AMxvm0Rm58MF9eNP4EOUEkT62DNkkHcWxI/XdxNJ
         G58LqgUjf5wV0cx4oV2ZcIKxO32NtOTugIuSpjwLvx1TNOhK8fvpUIRs6dYdrmRFOHZl
         akdPrc3YtACNQ3F+aUxRBXnCkuz3x4Q86dhxdzgkSIfGJ/PBp8CflQDuneuMo/ONl3c8
         TrzQ==
X-Gm-Message-State: APt69E1hBXNqvM835fxiJwwOD8OAT8lSBTCeM1DK9w6ExfkRk0GVwt7T
        7FE5udVM7CImf7CcjTKPshtEBg==
X-Google-Smtp-Source: AAOMgpdXHPyxDxwqbsdbv8a3E1LeUhykQII+gr21KgO93h6yVEsUwknKd1l/EUuYscy1Pgtjs88kmg==
X-Received: by 2002:a65:5907:: with SMTP id f7-v6mr19833870pgu.83.1531174037093;
        Mon, 09 Jul 2018 15:07:17 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id d132-v6sm30194096pga.10.2018.07.09.15.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 15:07:16 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id BF4F630003F; Tue, 10 Jul 2018 01:07:11 +0300 (+03)
Date:   Tue, 10 Jul 2018 01:07:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        ldufour@linux.vnet.ibm.com, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>, ying.huang@intel.com
Subject: Re: kernel BUG at mm/memory.c:LINE!
Message-ID: <20180709220711.2zz75g4mo4p76bbx@kshutemo-mobl1>
References: <0000000000004a7da505708a9915@google.com>
 <20180709101558.63vkwppwcgzcv3dg@kshutemo-mobl1>
 <CACT4Y+a=8NOg+h6fBzpmVHiZ-vNUiG7SW4QgQvK3vD=KBqQ3_Q@mail.gmail.com>
 <CACT4Y+baBmOHwH6rUL3DjKhGk-JjBAvKOmnq65_4z6b96ohrBQ@mail.gmail.com>
 <20180709142155.jlgytrhdmkyvowzh@kshutemo-mobl1>
 <20180709152508.smwg252x57pnfkoq@kshutemo-mobl1>
 <CACT4Y+YM=M0b_VVNyBNq6Qa25veRzw-WhxXkovS9Kmu23LPVVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YM=M0b_VVNyBNq6Qa25veRzw-WhxXkovS9Kmu23LPVVA@mail.gmail.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 07:23:15PM +0200, Dmitry Vyukov wrote:
> On Mon, Jul 9, 2018 at 5:25 PM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > On Mon, Jul 09, 2018 at 05:21:55PM +0300, Kirill A. Shutemov wrote:
> >> > This also happened only once so far:
> >> > https://syzkaller.appspot.com/bug?extid=3f84280d52be9b7083cc
> >> > and I can't reproduce it rerunning this program. So it's either a very
> >> > subtle race, or fd in the middle of netlink address magically matched
> >> > some fd once, or something else...
> >>
> >> Okay, I've got it reproduced. See below.
> >>
> >> The problem is that kcov doesn't set vm_ops for the VMA and it makes
> >> kernel think that the VMA is anonymous.
> >>
> >> It's not necessary the way it was triggered by syzkaller. I just found
> >> that kcov's ->mmap doesn't set vm_ops. There can more such cases.
> >> vma_is_anonymous() is what we need to fix.
> >>
> >> ( Although, I found logic around mmaping the file second time questinable
> >>   at best. It seems broken to me. )
> >>
> >> It is known that vma_is_anonymous() can produce false-positives. It tried
> >> to fix it once[1], but it back-fired[2].
> >>
> >> I'll look at this again.
> >
> > Below is a patch that seems work. But it definately requires more testing.
> >
> > Dmitry, could you give it a try in syzkaller?
> 
> Trying.
> 
> Not sure what you expect from this. Either way it will be hundreds of
> crashes before vs hundreds of crashes after ;)
> 
> But one that started popping up is this, looks like it's somewhere
> around the code your patch touches:
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 6711 Comm: syz-executor3 Not tainted 4.18.0-rc4+ #43
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> RIP: 0010:__get_vma_policy+0x61/0x160 mm/mempolicy.c:1620

Right, my bad. Here's fixup.

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d508c7844681..12b2b3c7f51e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -597,6 +597,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	memset(&pseudo_vma, 0, sizeof(struct vm_area_struct));
 	pseudo_vma.vm_flags = (VM_HUGETLB | VM_MAYSHARE | VM_SHARED);
 	pseudo_vma.vm_file = file;
+	pseudo_vma.vm_ops = &anon_vm_ops;

 	for (index = start; index < end; index++) {
 		/*
-- 
 Kirill A. Shutemov
