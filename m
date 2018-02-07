Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3994007-1518007531-2-10560984288340269501
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
    t=1518007530; b=T+XEYrA9LJy2JdtmgMMeETKJs1exe4+HOp/oCZ7ub+jE+iG
    grf3i424PVeJwxkoansyTnkrGK+6iC1iTQWmKSP62z5BLeyFEqfU3f99mRX3XjfP
    VuqQ15FNZ2/5QIe72TKfwwbLKXzA6cBRIJ9pSqCq24kJK/FHNrPxVhHNb6CgoreK
    e7RGRrkBiA9nD9dsQEGRf2ri/AmH3ok/DtIrIrRY0w9Pv7+BDOJBa/7XYKKvVGTE
    sD7sCk9d4OiUgIJLhiSUMHB67fK7mhN9xLhQrX6jXtLt/YowmwMzIZIv0mds9nyW
    4SHzIvvqV1dNQ536p7bao/s+7mWx9hGMiFlng8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518007530; bh=VYbtQMppLJwKrLXxslHYawdJfg
    n+mM7vGq/+XtN6nH8=; b=uiMD1A6A60QiKtVcqnIv/v/vFFYJt2ZhshMpPiGFGb
    kr1dYV6GcNukVNphFmMW+SoGrACQGjYZsaagM2xXwTBhu+vXcei39tzpH7pBSKYO
    GIqstpi0dbWDnp7dL7bu9Ghc9YJrde52C/rICJGB5ix7cAZnlg9/3S4Cfu7A5FAb
    eK/tyYP0WpQUshrpSx6W5a2VJvSVJI7slhuD7X6Y7DO57DBN2pdYCUmvQcpVZD4Y
    XcCae2pki8AvvP5tfKpHnTeXoYY9M+sdIGzBRI3i9wyFbfsGJyPGYgjyqWSTjbA9
    MaO20YG2Oesxw5CP42M++S6lvzYm/mHQ6L+uIhYEnXUA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753835AbeBGMp1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 07:45:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753763AbeBGMp0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Feb 2018 07:45:26 -0500
Date: Wed, 7 Feb 2018 20:45:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Mike Galbraith <efault@gmx.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org,
        Vivek Goyal <vgoyal@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: Re: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
Message-ID: <20180207124519.GD30270@localhost.localdomain>
References: <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
 <1515469448.6766.12.camel@gmx.de>
 <d71ba136-71ba-333a-f99b-b8283e2dc545@cn.fujitsu.com>
 <20180207104111.sljc62bgkggmtio4@node.shutemov.name>
 <1518000336.29698.1.camel@gmx.de>
 <cd7e23ce-60a3-08ad-eb5d-21bb91df5937@cn.fujitsu.com>
 <20180207120827.GB30270@localhost.localdomain>
 <2945e12f-caab-b7e7-77e0-bd3971e784be@cn.fujitsu.com>
 <20180207122724.GC30270@localhost.localdomain>
 <0a2d5abe-3081-a784-dd85-70d34a0f60cc@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a2d5abe-3081-a784-dd85-70d34a0f60cc@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/07/18 at 08:34pm, Dou Liyang wrote:
> 
> 
> At 02/07/2018 08:27 PM, Baoquan He wrote:
> > On 02/07/18 at 08:17pm, Dou Liyang wrote:
> > > Hi Baoquan,
> > > 
> > > At 02/07/2018 08:08 PM, Baoquan He wrote:
> > > > On 02/07/18 at 08:00pm, Dou Liyang wrote:
> > > > > Hi Kirill,Mike
> > > > > 
> > > > > At 02/07/2018 06:45 PM, Mike Galbraith wrote:
> > > > > > On Wed, 2018-02-07 at 13:41 +0300, Kirill A. Shutemov wrote:
> > > > > > > On Wed, Feb 07, 2018 at 05:25:05PM +0800, Dou Liyang wrote:
> > > > > > > > Hi All,
> > > > > > > > 
> > > > > > > > I met the makedumpfile failed in the upstream kernel which contained
> > > > > > > > this patch. Did I missed something else?
> > > > > > > 
> > > > > > > None I'm aware of.
> > > > > > > 
> > > > > > > Is there a reason to suspect that the issue is related to the bug this patch
> > > > > > > fixed?
> > > > > > 
> > > > > 
> > > > > I did a contrastive test by my colleagues Indoh's suggestion.

OK, I may get the reason. kaslr is enabled, right? You can try to
disable kaslr and try them again. Because phys_base and kaslr_offset are
got from vmlinux, while these are generated at compiling time. Just a
guess.

> > > > > 
> > > > > Revert your two commits:
> > > > > 
> > > > > commit 83e3c48729d9ebb7af5a31a504f3fd6aff0348c4
> > > > > Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > Date:   Fri Sep 29 17:08:16 2017 +0300
> > > > > 
> > > > > commit 629a359bdb0e0652a8227b4ff3125431995fec6e
> > > > > Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > Date:   Tue Nov 7 11:33:37 2017 +0300
> > > > > 
> > > > > ...and keep others unchanged, the makedumpfile works well.
> > > > > 
> > > > > > Still works fine for me with .today.  Box is only 16GB desktop box though.
> > > > > > 
> > > > > Btw, In the upstream kernel which contained this patch, I did two tests:
> > > > > 
> > > > >    1) use the makedumpfile as core_collector in /etc/kdump.conf, then
> > > > > trigger the process of kdump by echo 1 >/proc/sysrq-trigger, the
> > > > > makedumpfile works well and I can get the vmcore file.
> > > > > 
> > > > >        ......It is OK
> > > > > 
> > > > >    2) use cp as core_collector, do the same operation to get the vmcore file.
> > > > > then use makedumpfile to do like above:
> > > > > 
> > > > >       [douly@localhost code]$ ./makedumpfile -d 31 --message-level 31 -x
> > > > > vmlinux_4.15+ vmcore_4.15+_from_cp_command vmcore_4.15+
> > > > 
> > > > Oh, then please ignore my previous comment. Adding '-D' can give more
> > > > debugging message.
> > > 
> > > I added '-D', Just like before, no more debugging message:
> > > 
> > > BTW, I use crash to analyze the vmcore file created by 'cp' command.
> > > 
> > >     ./crash ../makedumpfile/code/vmcore_4.15+_from_cp_command
> > > ../makedumpfile/code/vmlinux_4.15+
> > > 
> > > the crash works well, It's so interesting.
> > > 
> > > Thanks,
> > > 	dou.
> > > 
> > > The debugging message with '-D':
> > 
> > And what's the debugging printing when trigger crash by sysrq?
> > 
> 
> kdump: dump target is /dev/vda2
> kdump: saving to /sysroot//var/crash/127.0.0.1-2018-02-07-07:31:56/
> [    2.751352] EXT4-fs (vda2): re-mounted. Opts: data=ordered
> kdump: saving vmcore-dmesg.txt
> kdump: saving vmcore-dmesg.txt complete
> kdump: saving vmcore
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
> 
> num of NODEs : 1
> 
> 
> Memory type  : SPARSEMEM_EX
> 
> mem_map (0)
>   mem_map    : ffffea0000000000
>   pfn_start  : 0
>   pfn_end    : 8000
> mem_map (1)
>   mem_map    : ffffea0000200000
>   pfn_start  : 8000
>   pfn_end    : 10000
> mem_map (2)
>   mem_map    : ffffea0000400000
>   pfn_start  : 10000
>   pfn_end    : 18000
> mem_map (3)
>   mem_map    : ffffea0000600000
>   pfn_start  : 18000
>   pfn_end    : 20000
> mem_map (4)
>   mem_map    : ffffea0000800000
>   pfn_start  : 20000
>   pfn_end    : 28000
> mem_map (5)
>   mem_map    : ffffea0000a00000
>   pfn_start  : 28000
>   pfn_end    : 30000
> mem_map (6)
>   mem_map    : ffffea0000c00000
>   pfn_start  : 30000
>   pfn_end    : 38000
> mem_map (7)
>   mem_map    : ffffea0000e00000
>   pfn_start  : 38000
>   pfn_end    : 40000
> mem_map (8)
>   mem_map    : ffffea0001000000
>   pfn_start  : 40000
>   pfn_end    : 48000
> mem_map (9)
>   mem_map    : ffffea0001200000
>   pfn_start  : 48000
>   pfn_end    : 50000
> mem_map (10)
>   mem_map    : ffffea0001400000
>   pfn_start  : 50000
>   pfn_end    : 58000
> mem_map (11)
>   mem_map    : ffffea0001600000
>   pfn_start  : 58000
>   pfn_end    : 60000
> mem_map (12)
>   mem_map    : ffffea0001800000
>   pfn_start  : 60000
>   pfn_end    : 68000
> mem_map (13)
>   mem_map    : ffffea0001a00000
>   pfn_start  : 68000
>   pfn_end    : 70000
> mem_map (14)
>   mem_map    : ffffea0001c00000
>   pfn_start  : 70000
>   pfn_end    : 78000
> mem_map (15)
>   mem_map    : ffffea0001e00000
>   pfn_start  : 78000
>   pfn_end    : 7ffd7
> mmap() is available on the kernel.
> Copying data                                      : [100.0 %] -  eta: 0s
> Writing erase info...
> offset_eraseinfo: 9567fb0, size_eraseinfo: 0
> kdump: saving vmcore complete
> 
> Thanks,
> 	dou
> 
> > > 
> > > [douly@localhost code]$ ./makedumpfile -D -d 31 --message-level 31 -x
> > > vmlinux_4.15+  vmcore_4.15+_from_cp_command vmcore_4.15+
> > > sadump: does not have partition header
> > > sadump: read dump device as unknown format
> > > sadump: unknown format
> > > LOAD (0)
> > >    phys_start : 1000000
> > >    phys_end   : 2a86000
> > >    virt_start : ffffffff81000000
> > >    virt_end   : ffffffff82a86000
> > > LOAD (1)
> > >    phys_start : 1000
> > >    phys_end   : 9fc00
> > >    virt_start : ffff880000001000
> > >    virt_end   : ffff88000009fc00
> > > LOAD (2)
> > >    phys_start : 100000
> > >    phys_end   : 13000000
> > >    virt_start : ffff880000100000
> > >    virt_end   : ffff880013000000
> > > LOAD (3)
> > >    phys_start : 33000000
> > >    phys_end   : 7ffd7000
> > >    virt_start : ffff880033000000
> > >    virt_end   : ffff88007ffd7000
> > > Linux kdump
> > > page_size    : 4096
> > > 
> > > max_mapnr    : 7ffd7
> > > 
> > > Buffer size for the cyclic mode: 131061
> > > The kernel version is not supported.
> > > The makedumpfile operation may be incomplete.
> > > 
> > > num of NODEs : 1
> > > 
> > > 
> > > Memory type  : SPARSEMEM_EX
> > > 
> > > mem_map (0)
> > >    mem_map    : ffff88007ff26000
> > >    pfn_start  : 0
> > >    pfn_end    : 8000
> > > mem_map (1)
> > >    mem_map    : 0
> > >    pfn_start  : 8000
> > >    pfn_end    : 10000
> > > mem_map (2)
> > >    mem_map    : 0
> > >    pfn_start  : 10000
> > >    pfn_end    : 18000
> > > mem_map (3)
> > >    mem_map    : 0
> > >    pfn_start  : 18000
> > >    pfn_end    : 20000
> > > mem_map (4)
> > >    mem_map    : 0
> > >    pfn_start  : 20000
> > >    pfn_end    : 28000
> > > mem_map (5)
> > >    mem_map    : 0
> > >    pfn_start  : 28000
> > >    pfn_end    : 30000
> > > mem_map (6)
> > >    mem_map    : 0
> > >    pfn_start  : 30000
> > >    pfn_end    : 38000
> > > mem_map (7)
> > >    mem_map    : 0
> > >    pfn_start  : 38000
> > >    pfn_end    : 40000
> > > mem_map (8)
> > >    mem_map    : 0
> > >    pfn_start  : 40000
> > >    pfn_end    : 48000
> > > mem_map (9)
> > >    mem_map    : 0
> > >    pfn_start  : 48000
> > >    pfn_end    : 50000
> > > mem_map (10)
> > >    mem_map    : 0
> > >    pfn_start  : 50000
> > >    pfn_end    : 58000
> > > mem_map (11)
> > >    mem_map    : 0
> > >    pfn_start  : 58000
> > >    pfn_end    : 60000
> > > mem_map (12)
> > >    mem_map    : 0
> > >    pfn_start  : 60000
> > >    pfn_end    : 68000
> > > mem_map (13)
> > >    mem_map    : 0
> > >    pfn_start  : 68000
> > >    pfn_end    : 70000
> > > mem_map (14)
> > >    mem_map    : 0
> > >    pfn_start  : 70000
> > >    pfn_end    : 78000
> > > mem_map (15)
> > >    mem_map    : 0
> > >    pfn_start  : 78000
> > >    pfn_end    : 7ffd7
> > > mmap() is available on the kernel.
> > > Checking for memory holes                         : [100.0 %] |         STEP
> > > [Checking for memory holes  ] : 0.000014 seconds
> > > __vtop4_x86_64: Can't get a valid pte.
> > > readmem: Can't convert a virtual address(ffff88007ffd7000) to physical
> > > address.
> > > readmem: type_addr: 0, addr:ffff88007ffd7000, size:32768
> > > __exclude_unnecessary_pages: Can't read the buffer of struct page.
> > > create_2nd_bitmap: Can't exclude unnecessary pages.
> > > Checking for memory holes                         : [100.0 %] \         STEP
> > > [Checking for memory holes  ] : 0.000006 seconds
> > > Checking for memory holes                         : [100.0 %] -         STEP
> > > [Checking for memory holes  ] : 0.000004 seconds
> > > __vtop4_x86_64: Can't get a valid pte.
> > > readmem: Can't convert a virtual address(ffff88007ffd7000) to physical
> > > address.
> > > readmem: type_addr: 0, addr:ffff88007ffd7000, size:32768
> > > __exclude_unnecessary_pages: Can't read the buffer of struct page.
> > > create_2nd_bitmap: Can't exclude unnecessary pages.
> > > 
> > > makedumpfile Failed.
> > > 
> > > > 
> > > > > 
> > > > >       ......It causes makedumpfile failed.
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > 	dou.
> > > > > 
> > > > > > 	-Mike
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > > 
> > > 
> > > 
> > 
> > 
> > 
> 
> 
