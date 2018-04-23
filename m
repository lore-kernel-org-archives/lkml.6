Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1727310-1524514068-2-4981747943343539171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524514066; b=QOj2y7JbjuzQ6oeepo6twv6XzI5GlLqbg9AICn0Gd9A5z+jhOV
    Kz12SvXnQqQpNO2EmCBsznP+IvudN2ct5drli+zfzfw9fbk6+20UyH3i5UEPIsnq
    riE0bYrwYek4OdzvDzD4deNfLZGsu082xP58D0GAeufe5gqDXvzSJYeJi6N9uTnf
    7mujJCV27R5UMoMp5FcMSwLmOrI0b2/CDlF6bdynllbwv6tRFUNihHuJ+5swBFoD
    PultCgKPz3mxIW6J8qRNUJdTwUxq2nH3Kc32uN7xUcJCkK47V5vrDWa2eHp9ZGeW
    ZxLihPNH80h+OrYI0h6ruwd6r8lKP/h7Gc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524514066;
    bh=fCTCS0f/mFk+BY6NZdAmaxEJoY+D0dLhZF1566FK1MA=; b=UyYW829287eK
    J0u9itFj/GvaFumAPKSdmeGlHMXHYK+6msfjzgftRT9NTFPNsIhOqxcYEV3zsxRI
    8fZDMJGt2m52joHABh5FnPXcYlUmk4IxOWkCT3e3nY0Ma+kJtm3gyBeoinD+trQY
    uXNVeniATdzytBxyoWgjSAANa2uNlbCwPGojHQmwwOsUThAoAA+UwudCJLgEbT9q
    MxeXNfULiF3+SgRSmrEGbL1jWmohZP1vIr4Xhmb+MmKXCAX9eRu90vQHnTb9rDDO
    EuwQ4qJV7FYN/Qg80qu/VhqxNKxOYkpdbCHWW2nD94xiHFZW+fICV0eiipouElDQ
    /HU5nDg6Xg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKcQTyn78P8BAvCDclGUXGzO0d0CEeFHDoDiRGAqr2CodlGkaFDfJBVT4iDV5iwebFoHyNAIx+mLi/4VTZZyHZcxLFwZ30N1R6VHhGiuqiq4vySqyDiv
    jgJpHNslLVB/U0K8B8wcWcp8A8Wbl4jLeb7YPTJhd14WjrjxSmRewVgj1jLU2wL+EkXwOkbiSXjzfm9BCZ+L19pA/qHkFej3gMFir5sRy1Qb7LfwHtAH+vcT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xRDiy12qv0EA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=1lsRJu5aB5dK9IT-JfgA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeDWUHn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 16:07:43 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:34254 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbeDWUHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 16:07:43 -0400
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180423180312.GA27081@kroah.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <4527fda9-f123-f8b7-8294-991a0a66af16@kernel.org>
Date: Mon, 23 Apr 2018 14:07:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423180312.GA27081@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/23/2018 12:03 PM, Greg Kroah-Hartman wrote:
> On Sun, Apr 22, 2018 at 03:50:20PM +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.16.4 release.
>> There are 196 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.4-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
>> and the diffstat can be found below.
> 
> There is a -rc3 out now, to fix some issues reported with -rc1 and -rc2
> (I forgot to announce -rc2, sorry.):
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.4-rc3.gz
> 
> 
> 

I just tried rc1 - will try rc3. Has the lock problem seen already: ( I will
try rc3 and if I setill see the problem, will start bisect)

================================
WARNING: inconsistent lock state
4.16.4-rc1+ #4 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/3/0 [HC1[1]:SC1[1]:HE0:SE0] takes:
 (fs_reclaim){?.+.}, at: [<        (ptrval)>] fs_reclaim_acquire.part.76+0x5/0x30
{HARDIRQ-ON-W} state was registered at:
  fs_reclaim_acquire.part.76+0x29/0x30
  kmem_cache_alloc_node_trace+0x39/0x2a0
  alloc_worker+0x2d/0xa0
  create_worker+0xa0/0x2b0
  workqueue_init+0x315/0x39a
  kernel_init_freeable+0x153/0x312
  kernel_init+0xf/0x120
  ret_from_fork+0x3a/0x50
irq event stamp: 164931
hardirqs last  enabled at (164930): [<        (ptrval)>] __do_softirq+0xe1/0x560
hardirqs last disabled at (164931): [<        (ptrval)>] interrupt_entry+0xbd/0xf0
softirqs last  enabled at (164928): [<        (ptrval)>] irq_enter+0x75/0x80
softirqs last disabled at (164929): [<        (ptrval)>] irq_exit+0x104/0x110

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(fs_reclaim);
  <Interrupt>
    lock(fs_reclaim);

 *** DEADLOCK ***

no locks held by swapper/3/0.

stack backtrace:
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.16.4-rc1+ #4
Hardware name: System76, Inc. Wild Dog Performance/H87-PLUS, BIOS 0705 12/05/2013
Call Trace:
 <IRQ>
 dump_stack+0x67/0x98
 print_usage_bug+0x24c/0x266
 mark_lock+0x6c1/0x7a0
 ? check_usage_backwards+0x230/0x230
 __lock_acquire+0x1237/0x1e20
 ? debug_check_no_locks_freed+0x190/0x190
 ? debug_check_no_locks_freed+0x190/0x190
 ? memzero_explicit+0xa/0x10
 ? extract_buf+0x1b1/0x220
 ? trace_event_raw_event_xfer_secondary_pool+0x1b0/0x1b0
 ? _raw_spin_unlock_irqrestore+0x3e/0x50
 ? match_held_lock+0x1b/0x210
 ? lock_acquire+0xcd/0x220
 lock_acquire+0xcd/0x220
 ? fs_reclaim_acquire.part.76+0x5/0x30
 ? lock_acquire+0xcd/0x220
 fs_reclaim_acquire.part.76+0x29/0x30
 ? fs_reclaim_acquire.part.76+0x5/0x30
 __kmalloc+0x51/0x2e0
 ? crng_reseed+0x229/0x440
 crng_reseed+0x229/0x440
 ? init_std_data+0x1c0/0x1c0
 ? add_interrupt_randomness+0x27d/0x340
 credit_entropy_bits+0x3b7/0x3d0
 add_interrupt_randomness+0x27d/0x340
 ? extract_entropy.constprop.41+0x1b0/0x1b0
 ? rcu_read_lock_sched_held+0x7c/0x80
 ? __handle_irq_event_percpu+0xf9/0x3c0
 handle_irq_event_percpu+0x8b/0xe0
 ? __handle_irq_event_percpu+0x3c0/0x3c0
 ? lock_acquire+0xcd/0x220
 ? handle_edge_irq+0x28/0x2c0
 ? do_raw_spin_unlock+0x91/0x120
 handle_irq_event+0x5a/0x90
 handle_edge_irq+0xef/0x2c0
 handle_irq+0x32/0x40
 do_IRQ+0x60/0x130
 common_interrupt+0xf/0xf
RIP: 0010:__do_softirq+0xe7/0x560
RSP: 0018:ffff8803cfec7f58 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
RAX: 00000000ffffffff RBX: ffff8803cd6b26c0 RCX: ffffffff8112890c
RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8803cd6b2f24
RBP: ffff8803cd6b2ef4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000202
 ? common_interrupt+0xa/0xf
 ? trace_hardirqs_on_caller+0x18c/0x280
 ? __do_softirq+0xe1/0x560
 irq_exit+0x104/0x110
 smp_apic_timer_interrupt+0xb8/0x300
 apic_timer_interrupt+0xf/0x20
 </IRQ>
RIP: 0010:cpuidle_enter_state+0xc4/0x430
RSP: 0018:ffff8803cd6c7d90 EFLAGS: 00000212 ORIG_RAX: ffffffffffffff12
RAX: 0000000000000000 RBX: ffffe8ffffcca660 RCX: ffffffff8112890c
RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff8803cd6b2f24
RBP: 0000000000011c2f R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: ffffffff82d17658 R14: ffffffff82d17640 R15: ffffffff82d17680
 ? trace_hardirqs_on_caller+0x18c/0x280
 do_idle+0x1a9/0x1f0
 cpu_startup_entry+0xc2/0xd0
 ? cpu_in_idle+0x20/0x20
 ? _raw_spin_unlock_irqrestore+0x32/0x50
 ? trace_hardirqs_on_caller+0x18c/0x280
 start_secondary+0x282/0x2f0
 ? set_cpu_sibling_map+0x840/0x840
 secondary_startup_64+0xa5/0xb0
random: crng init done
device: '0:44': device_add
PM: Adding info for No Bus:0:44
device: 'lo': device_add
PM: Adding info for No Bus:lo
r8169 0000:03:00.0 eth0: link up
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
device: 'lxcbr0': device_add
PM: Adding info for No Bus:lxcbr0
IPv6: ADDRCONF(NETDEV_UP): lxcbr0: link is not ready
PM: Removing info for No Bus:lxcbr0

thanks,
-- Shuah
