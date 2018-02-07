Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3793448-1518002902-2-12613554624597109330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518002901; b=DkvCRC3tO77jwsxDKoHGk1A+jWq/xbSK5EuL5I6ZuUt8kuT
    kGHcQ99wFvikyC3v+g/mCSPaw4ABtXCmlhDeSuwcV0jHLcFkv4fzI8mWeFMpNhHM
    4iHoHnyCIQxQnZFy0aUBxl1odXg7Uu4bEH8x84ccRu+59l+OeTCi5Hs7Q9FhjVhI
    5GDDtngEIHXYWaE+1ZW6iRyufRyU/o5IiO+7Y8u7xoIA62+WxKLU+8eN12qB2Jx9
    iEYLJ+SmWXh9uaAaZwbUCY3GR39+ChJo2nTXDzfD0QtZCN1g9tUSffHcnX/lIyo0
    6UrjUyjRQfvTcnI3eYo0bElewg0cRbIq9HYaSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518002901; bh=UV65DnECRtHkm9BD2ZSFTXduqH
    AKMcUvZdG1bEcwprg=; b=VUJ61GZSbCxiCOOWlbZAmmQuzn7XQxFX4zYTirNOF5
    F4676bTR0q5dM4HAoowfEjKRiIriCfRblavGtXEOS7c0b/Jre+0vkdNlXpbnq+/F
    QxJbCiFIg/EnyPp6LfP8YCgQv0mdRhMadIHuXU296m0eIegawOmZ85sZc7nbDG2h
    ngnf+dTLz1r3v+BqoUxw4AHFZ11mX/3JDI9ADGe3FX3y5jKKIGI7poRxWLeSOpgI
    7+66ba0X1CPZmAqv6tN2ckqFk09JOFHtQhPOqjlh/WZsoZuWdwPNxKRqf67mWo3e
    d7w+5J5mtao5uYjfMuj41ZWyTAF2YVaCaUbCzoeuv4ow==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeBGL2S (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 06:28:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753794AbeBGL2R (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Feb 2018 06:28:17 -0500
Date: Wed, 7 Feb 2018 19:28:08 +0800
From: Baoquan He <bhe@redhat.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Mike Galbraith <efault@gmx.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
Message-ID: <20180207112808.GA30270@localhost.localdomain>
References: <20171222084623.668990192@linuxfoundation.org>
 <20171222084625.007160464@linuxfoundation.org>
 <1515302062.6507.18.camel@gmx.de>
 <20180108160444.2ol4fvgqbxnjmlpg@gmail.com>
 <20180108174653.7muglyihpngxp5tl@black.fi.intel.com>
 <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
 <1515469448.6766.12.camel@gmx.de>
 <d71ba136-71ba-333a-f99b-b8283e2dc545@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d71ba136-71ba-333a-f99b-b8283e2dc545@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/07/18 at 05:25pm, Dou Liyang wrote:
> Hi All,
> 
> I met the makedumpfile failed in the upstream kernel which contained
> this patch. Did I missed something else?

readmem: Can't convert a virtual address(ffff88007ffd7000) to physical

Should not related to this patch. Otherwise your code can't get to that
step. From message, ffff88007ffd7000 is the end of the last mem region,
seems a code bug. You are testing 5-level on makedumpfile, right?

The patches I posted to descrease the memmory cost on mem map allocation
has code bug, Fengguang's test robot sent a mail to me, I have updated
patches, try to write a good patch log. You might also need check the
5-level patches you posted to makedumpfile upstream.

> 
> In fedora27 host:
> 
> [douly@localhost code]$ ./makedumpfile -d 31 --message-level 31 -x
> vmlinux_4.15+ vmcore_4.15+_from_cp_command vmcore_4.15+
> 
> sadump: does not have partition header
> sadump: read dump device as unknown format
> sadump: unknown format
> LOAD (0)
>   phys_start : 1000000
>   phys_end   : 2a86000
>   virt_start : ffffffff81000000
>   virt_end   : ffffffff82a86000
> LOAD (1)
>   phys_start : 1000
>   phys_end   : 9fc00
>   virt_start : ffff880000001000
>   virt_end   : ffff88000009fc00
> LOAD (2)
>   phys_start : 100000
>   phys_end   : 13000000
>   virt_start : ffff880000100000
>   virt_end   : ffff880013000000
> LOAD (3)
>   phys_start : 33000000
>   phys_end   : 7ffd7000
>   virt_start : ffff880033000000
>   virt_end   : ffff88007ffd7000
> Linux kdump
> page_size    : 4096
> 
> max_mapnr    : 7ffd7
> 
> Buffer size for the cyclic mode: 131061
> The kernel version is not supported.
> The makedumpfile operation may be incomplete.
> 
> num of NODEs : 1
> 
> 
> Memory type  : SPARSEMEM_EX
> 
> mem_map (0)
>   mem_map    : ffff88007ff26000
>   pfn_start  : 0
>   pfn_end    : 8000
> mem_map (1)
>   mem_map    : 0
>   pfn_start  : 8000
>   pfn_end    : 10000
> mem_map (2)
>   mem_map    : 0
>   pfn_start  : 10000
>   pfn_end    : 18000
> mem_map (3)
>   mem_map    : 0
>   pfn_start  : 18000
>   pfn_end    : 20000
> mem_map (4)
>   mem_map    : 0
>   pfn_start  : 20000
>   pfn_end    : 28000
> mem_map (5)
>   mem_map    : 0
>   pfn_start  : 28000
>   pfn_end    : 30000
> mem_map (6)
>   mem_map    : 0
>   pfn_start  : 30000
>   pfn_end    : 38000
> mem_map (7)
>   mem_map    : 0
>   pfn_start  : 38000
>   pfn_end    : 40000
> mem_map (8)
>   mem_map    : 0
>   pfn_start  : 40000
>   pfn_end    : 48000
> mem_map (9)
>   mem_map    : 0
>   pfn_start  : 48000
>   pfn_end    : 50000
> mem_map (10)
>   mem_map    : 0
>   pfn_start  : 50000
>   pfn_end    : 58000
> mem_map (11)
>   mem_map    : 0
>   pfn_start  : 58000
>   pfn_end    : 60000
> mem_map (12)
>   mem_map    : 0
>   pfn_start  : 60000
>   pfn_end    : 68000
> mem_map (13)
>   mem_map    : 0
>   pfn_start  : 68000
>   pfn_end    : 70000
> mem_map (14)
>   mem_map    : 0
>   pfn_start  : 70000
>   pfn_end    : 78000
> mem_map (15)
>   mem_map    : 0
>   pfn_start  : 78000
>   pfn_end    : 7ffd7
> mmap() is available on the kernel.
> Checking for memory holes                         : [100.0 %] |         STEP
> [Checking for memory holes  ] : 0.000060 seconds
> __vtop4_x86_64: Can't get a valid pte.
> readmem: Can't convert a virtual address(ffff88007ffd7000) to physical
> address.
> readmem: type_addr: 0, addr:ffff88007ffd7000, size:32768
> __exclude_unnecessary_pages: Can't read the buffer of struct page.
> create_2nd_bitmap: Can't exclude unnecessary pages.
> Checking for memory holes                         : [100.0 %] \         STEP
> [Checking for memory holes  ] : 0.000010 seconds
> Checking for memory holes                         : [100.0 %] -         STEP
> [Checking for memory holes  ] : 0.000004 seconds
> __vtop4_x86_64: Can't get a valid pte.
> readmem: Can't convert a virtual address(ffff88007ffd7000) to physical
> address.
> readmem: type_addr: 0, addr:ffff88007ffd7000, size:32768
> __exclude_unnecessary_pages: Can't read the buffer of struct page.
> create_2nd_bitmap: Can't exclude unnecessary pages.
> 
> Thanks,
> 	dou
> At 01/09/2018 11:44 AM, Mike Galbraith wrote:
> > On Tue, 2018-01-09 at 03:13 +0300, Kirill A. Shutemov wrote:
> > > 
> > > Mike, could you test this? (On top of the rest of the fixes.)
> > 
> > homer:..crash/2018-01-09-04:25 # ll
> > total 1863604
> > -rw------- 1 root root      66255 Jan  9 04:25 dmesg.txt
> > -rw-r--r-- 1 root root        182 Jan  9 04:25 README.txt
> > -rw-r--r-- 1 root root    2818240 Jan  9 04:25 System.map-4.15.0.gb2cd1df-master
> > -rw------- 1 root root 1832914928 Jan  9 04:25 vmcore
> > -rw-r--r-- 1 root root   72514993 Jan  9 04:25 vmlinux-4.15.0.gb2cd1df-master.gz
> > 
> > Yup, all better.
> > 
> > > Sorry for the mess.
> > 
> > (why, developers not installing shiny new bugs is a whole lot worse:)
> > 
> > >  From 100fd567754f1457be94732046aefca204c842d2 Mon Sep 17 00:00:00 2001
> > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > Date: Tue, 9 Jan 2018 02:55:47 +0300
> > > Subject: [PATCH] kdump: Write a correct address of mem_section into vmcoreinfo
> > > 
> > > Depending on configuration mem_section can now be an array or a pointer
> > > to an array allocated dynamically. In most cases, we can continue to refer
> > > to it as 'mem_section' regardless of what it is.
> > > 
> > > But there's one exception: '&mem_section' means "address of the array" if
> > > mem_section is an array, but if mem_section is a pointer, it would mean
> > > "address of the pointer".
> > > 
> > > We've stepped onto this in kdump code. VMCOREINFO_SYMBOL(mem_section)
> > > writes down address of pointer into vmcoreinfo, not array as we wanted.
> > > 
> > > Let's introduce VMCOREINFO_ARRAY() that would handle the situation
> > > correctly for both cases.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")
> > > ---
> > >   include/linux/crash_core.h | 2 ++
> > >   kernel/crash_core.c        | 2 +-
> > >   2 files changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > > index 06097ef30449..83ae04950269 100644
> > > --- a/include/linux/crash_core.h
> > > +++ b/include/linux/crash_core.h
> > > @@ -42,6 +42,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> > >   	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
> > >   #define VMCOREINFO_SYMBOL(name) \
> > >   	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
> > > +#define VMCOREINFO_ARRAY(name) \
> > > +	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)name)
> > >   #define VMCOREINFO_SIZE(name) \
> > >   	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
> > >   			      (unsigned long)sizeof(name))
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index b3663896278e..d4122a837477 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -410,7 +410,7 @@ static int __init crash_save_vmcoreinfo_init(void)
> > >   	VMCOREINFO_SYMBOL(contig_page_data);
> > >   #endif
> > >   #ifdef CONFIG_SPARSEMEM
> > > -	VMCOREINFO_SYMBOL(mem_section);
> > > +	VMCOREINFO_ARRAY(mem_section);
> > >   	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> > >   	VMCOREINFO_STRUCT_SIZE(mem_section);
> > >   	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > 
> > 
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
