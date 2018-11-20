Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0E9C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A99E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="H2liqdzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A99E206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeKUALg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:11:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43654 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeKUALf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:11:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so918359pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qNlLN6omP98M6QXm5YO91mgRpJP0OcPpOSSHRl4lCMs=;
        b=H2liqdzd2z35/PY+0LyQV8W39Hm5WAMSQz0+uN69PvWh1R8hcagheYodGg/+8QOx80
         Ukk0bf0xf/CX9blvRiN4xbkQ9zDcZPT5lDsnQ9g5iqmG0HZoHg5Qf/KLi+7/yNQIaqLn
         SbdTA60FyZnmCC1FEl8HsSSU/9uO0l3yydvQnw3fInhwf3LGRqK1VD1YIA0SUihRKdvw
         5Y+y3Od1p8nV2fXcOKvLB6OS6KrdC7FdJ1q2XQKwOvrA8k2g0Ci9a/Gy24tmz/gaoOiS
         RTpekeaLj2cwlrfLCooO6Ly7+lpULOPICXOeyMlXOwJKHySPW9wAssWJZyh24dYKay/o
         Hlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qNlLN6omP98M6QXm5YO91mgRpJP0OcPpOSSHRl4lCMs=;
        b=SRgLBOb49LWODcyCt6WfPSGzjhWk5IUGMoRhM57/HVpOPrGQZJqSBkilLDoQEUGcN0
         8m+lPmouLr0nEId59mHGmRvTBlvO1W/hBm2Cj7NwKrEUfb7E3+DSvD/MoMbqb1AJaCkn
         5z+QuHNhyYNgN5OuCvSGrjv6xZRVvrlGHIAH6QS4qu8iTZ+vm+8fs1VDhDEjpJMi5Ygi
         r6SAQ5SU5S9Xs1xlvcG6Fm3cd/0Ot4/Xv3z3gpR3z8yXDEoI2nOD3i1GpZnAnZZzHbJj
         MNQ/BuIuhCkygGE5OvBi8CjSIickgLh0UuYZkJr2V9dR77QRI4ua7/VoVNPt0WvFCp3C
         +LrA==
X-Gm-Message-State: AA+aEWaBpr3GBYJevjQbZt2C32/y/uJeMD/zvCCzE6lvdE6Ye6H8RW9T
        4M0LLlhAfZBSo4Pn3W2+nyO5+g==
X-Google-Smtp-Source: AFSGD/Xw2ntaEwa9vIzjDGrSAO6veZUH0o30Kx1iBWlyaDTVEKNlEjbnNFo4L+TyJfi980aqu+kQHQ==
X-Received: by 2002:a63:4b25:: with SMTP id y37mr640448pga.181.1542721342041;
        Tue, 20 Nov 2018 05:42:22 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id n13-v6sm64340403pfk.19.2018.11.20.05.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:42:20 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E0D1E302653; Tue, 20 Nov 2018 16:42:16 +0300 (+03)
Date:   Tue, 20 Nov 2018 16:42:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] dd2283f260 [ 97.263072]
 WARNING:at_kernel/locking/lockdep.c:#lock_downgrade
Message-ID: <20181120134216.s5derazwpay5gkfk@kshutemo-mobl1>
References: <20181115055443.GF18977@shao2-debian>
 <d9371abc-60f6-ce37-529f-d097464a1412@linux.alibaba.com>
 <20181120085749.lj7dzk52633oq42s@kshutemo-mobl1>
 <9dec33d0-f408-8428-b004-fa63fc2e9091@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dec33d0-f408-8428-b004-fa63fc2e9091@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:10:51PM +0800, Yang Shi wrote:
> 
> 
> On 11/20/18 4:57 PM, Kirill A. Shutemov wrote:
> > On Fri, Nov 16, 2018 at 08:56:04AM -0800, Yang Shi wrote:
> > > > a8dda165ec  vfree: add debug might_sleep()
> > > > dd2283f260  mm: mmap: zap pages with read mmap_sem in munmap
> > > > 5929a1f0ff  Merge tag 'riscv-for-linus-4.20-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux
> > > > 0bc80e3cb0  Add linux-next specific files for 20181114
> > > > +-----------------------------------------------------+------------+------------+------------+---------------+
> > > > |                                                     | a8dda165ec | dd2283f260 | 5929a1f0ff | next-20181114 |
> > > > +-----------------------------------------------------+------------+------------+------------+---------------+
> > > > | boot_successes                                      | 314        | 178        | 190        | 168           |
> > > > | boot_failures                                       | 393        | 27         | 21         | 40            |
> > > > | WARNING:held_lock_freed                             | 383        | 23         | 17         | 39            |
> > > > | is_freeing_memory#-#,with_a_lock_still_held_there   | 383        | 23         | 17         | 39            |
> > > > | BUG:unable_to_handle_kernel                         | 5          | 2          | 4          | 1             |
> > > > | Oops:#[##]                                          | 9          | 3          | 4          | 1             |
> > > > | EIP:debug_check_no_locks_freed                      | 9          | 3          | 4          | 1             |
> > > > | Kernel_panic-not_syncing:Fatal_exception            | 9          | 3          | 4          | 1             |
> > > > | Mem-Info                                            | 4          | 1          |            |               |
> > > > | invoked_oom-killer:gfp_mask=0x                      | 1          | 1          |            |               |
> > > > | WARNING:at_kernel/locking/lockdep.c:#lock_downgrade | 0          | 6          | 4          | 7             |
> > > > | EIP:lock_downgrade                                  | 0          | 6          | 4          | 7             |
> > > > +-----------------------------------------------------+------------+------------+------------+---------------+
> > > > 
> > > > [   96.288009] random: get_random_u32 called from arch_rnd+0x3c/0x70 with crng_init=0
> > > > [   96.359626] input_id (331) used greatest stack depth: 6360 bytes left
> > > > [   96.749228] grep (358) used greatest stack depth: 6336 bytes left
> > > > [   96.921470] network.sh (341) used greatest stack depth: 6212 bytes left
> > > > [   97.262340]
> > > > [   97.262587] =========================
> > > > [   97.263072] WARNING: held lock freed!
> > > > [   97.263536] 4.19.0-06969-gdd2283f #1 Not tainted
> > > > [   97.264110] -------------------------
> > > > [   97.264575] udevd/198 is freeing memory 9c16c930-9c16c99b, with a lock still held there!
> > > > [   97.265542] (ptrval) (&anon_vma->rwsem){....}, at: unlink_anon_vmas+0x14e/0x420
> > > > [   97.266450] 1 lock held by udevd/198:
> > > > [   97.266924]  #0: (ptrval) (&mm->mmap_sem){....}, at: __do_munmap+0x531/0x730
> > > I have not figured out what this is caused by. But, the below warning looks
> > > more confusing. This might be caused by the below one.
> > I *think* we need to understand more about what detached VMAs mean for
> > rmap. The anon_vma for these VMAs still reachable for the rmap and
> > therefore VMA too. I don't quite grasp what is implications of this, but
> > it doesn't look good.
> 
> I'm supposed before accessing anon_vma, VMA need to be found by find_vma()
> first, right? But, finding VMA need hold mmap_sem, once detach VMAs is
> called, others should not be able to find the VMAs anymore. So, the anon_vma
> should not be reachable except the munmap caller.

No. anon_vma can be reached from page->mapping. The page can be reached
during physcal memory scan or if the page is shared (across fork()). None
of these accesses require mmap_sem.

-- 
 Kirill A. Shutemov
