Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C534C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CCF20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="FCRGR28B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CCF20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeKTTZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:25:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43292 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKTTZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:25:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so667683plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F7Cn+yUvzsMmUvVW2tGPJbwi30GarRxxp9NTez4ElnE=;
        b=FCRGR28BVgmQMqrhQmTmco3qkHx0HLOkLMeY4jJ7GNhRBqIr1bUhqx6WwOcM+c4G7L
         wUGWu9hnYscNtD3jvLPW362OOpUgRws470O+3AD+17eRJgcctPnxkoXkY1qoALiH8t34
         uqeTf7lMrRPfXjBuxsshlFrabXEowbeasdsdP3v0Lcsd5X1AaoBKAOSHKnoNmA9bHX/P
         C676AjWaNdKhYhU7b7e5Mk0R8n15ilOAdbDuVvtEPprbu1YPPqbuV2V4njR0AP3N1jCn
         lyaTyu1qbT0CfBYaFmUqwnFmpW+WP9cUCLbfOh/9bY7GVdr6c2zKuO4M4tu2w4Sk1w6Z
         TIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F7Cn+yUvzsMmUvVW2tGPJbwi30GarRxxp9NTez4ElnE=;
        b=gIca4hMetOpDfDoo9BYZ2IvofVT5xee7bmrDgTLnu3FDC0ZXhTuaXKYDDFdOr1Bxe7
         dPZubMUnq5dXwfBDzQqk2/3T88H6oOwSr4Z2tNtbGkCL1GO80Hxfq66UByj5+9hGi+jO
         KUlMIXY5iRKYJqsWe3CiYQJIJ79kF1p0iBL5rcia0IupWexhr05G00gXc+ps437KVaZy
         wlKh1rgC/lLJL2Yy07Eeqpo+AdcG826u9V8IWOCjODjLIQ4pSqdWLERRMc1XDyZJlOQy
         sEXkP37euj1fitGkpH4xHqn1cNHxhcBrnOBCl3k2lr4Vr57LYt1c2UcYQ34RzkXS6uVz
         PJ1w==
X-Gm-Message-State: AA+aEWalRG3pne47RVrThwNE7zMMw9y7saKijErB5vkfMp0duEHOs1D1
        6ZDzpZoQLok2XTpE3cuxHH0NTQ==
X-Google-Smtp-Source: AFSGD/VBwZUZtrr1hWd8NEfSMCin8gpjiFRhGd4A4yC10Q7u14muiVtuOYOsgKUrNtRX/SW4clcIEw==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr1401841pll.54.1542704274412;
        Tue, 20 Nov 2018 00:57:54 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id g2sm1344822pfi.95.2018.11.20.00.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 00:57:53 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 73D46302653; Tue, 20 Nov 2018 11:57:49 +0300 (+03)
Date:   Tue, 20 Nov 2018 11:57:49 +0300
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
Message-ID: <20181120085749.lj7dzk52633oq42s@kshutemo-mobl1>
References: <20181115055443.GF18977@shao2-debian>
 <d9371abc-60f6-ce37-529f-d097464a1412@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9371abc-60f6-ce37-529f-d097464a1412@linux.alibaba.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:56:04AM -0800, Yang Shi wrote:
> 
> > a8dda165ec  vfree: add debug might_sleep()
> > dd2283f260  mm: mmap: zap pages with read mmap_sem in munmap
> > 5929a1f0ff  Merge tag 'riscv-for-linus-4.20-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux
> > 0bc80e3cb0  Add linux-next specific files for 20181114
> > +-----------------------------------------------------+------------+------------+------------+---------------+
> > |                                                     | a8dda165ec | dd2283f260 | 5929a1f0ff | next-20181114 |
> > +-----------------------------------------------------+------------+------------+------------+---------------+
> > | boot_successes                                      | 314        | 178        | 190        | 168           |
> > | boot_failures                                       | 393        | 27         | 21         | 40            |
> > | WARNING:held_lock_freed                             | 383        | 23         | 17         | 39            |
> > | is_freeing_memory#-#,with_a_lock_still_held_there   | 383        | 23         | 17         | 39            |
> > | BUG:unable_to_handle_kernel                         | 5          | 2          | 4          | 1             |
> > | Oops:#[##]                                          | 9          | 3          | 4          | 1             |
> > | EIP:debug_check_no_locks_freed                      | 9          | 3          | 4          | 1             |
> > | Kernel_panic-not_syncing:Fatal_exception            | 9          | 3          | 4          | 1             |
> > | Mem-Info                                            | 4          | 1          |            |               |
> > | invoked_oom-killer:gfp_mask=0x                      | 1          | 1          |            |               |
> > | WARNING:at_kernel/locking/lockdep.c:#lock_downgrade | 0          | 6          | 4          | 7             |
> > | EIP:lock_downgrade                                  | 0          | 6          | 4          | 7             |
> > +-----------------------------------------------------+------------+------------+------------+---------------+
> > 
> > [   96.288009] random: get_random_u32 called from arch_rnd+0x3c/0x70 with crng_init=0
> > [   96.359626] input_id (331) used greatest stack depth: 6360 bytes left
> > [   96.749228] grep (358) used greatest stack depth: 6336 bytes left
> > [   96.921470] network.sh (341) used greatest stack depth: 6212 bytes left
> > [   97.262340]
> > [   97.262587] =========================
> > [   97.263072] WARNING: held lock freed!
> > [   97.263536] 4.19.0-06969-gdd2283f #1 Not tainted
> > [   97.264110] -------------------------
> > [   97.264575] udevd/198 is freeing memory 9c16c930-9c16c99b, with a lock still held there!
> > [   97.265542] (ptrval) (&anon_vma->rwsem){....}, at: unlink_anon_vmas+0x14e/0x420
> > [   97.266450] 1 lock held by udevd/198:
> > [   97.266924]  #0: (ptrval) (&mm->mmap_sem){....}, at: __do_munmap+0x531/0x730
> 
> I have not figured out what this is caused by. But, the below warning looks
> more confusing. This might be caused by the below one.

I *think* we need to understand more about what detached VMAs mean for
rmap. The anon_vma for these VMAs still reachable for the rmap and
therefore VMA too. I don't quite grasp what is implications of this, but
it doesn't look good.

I'll look into this more when I get some free cycles.

It's better to disable the optimization for now (by ignoring 'downgrade'
in __do_munmap()). Before it hits release.

-- 
 Kirill A. Shutemov
