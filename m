Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1745794-1524514988-2-11484861939923711375
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
    1524514987; b=c9oselvGnhuHK+8GV1Gr5OiYbwuDjHvpaBHUgTJERjpioWZWtA
    iSDccV7l+3MjqcEYtaWLoy9yuKE7L1stdRJ/e23ieUh5cXG9AphHVFLzTwxrWS35
    GUaHCnb6p5jdzI42QGH2JBJoSRr07bBYqv5Uhzt8H3aO0V5myrvAb8gHdqavvO7r
    TZWg6z8t72lcisXYc0lm5OSXkPnJrAS+j5TWUL8y/JeOa6sqI99zVXXaZu3lRlB4
    5nsMpkiDpk1vBHZQwJBKilLXB/7IVAA7MclXe2vK7P2a9GZJ9ArfZpMRgxHN681M
    vODsUa8nG2iRVkcdh2zt6gJpO1A0yLz52A5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524514987;
    bh=xRgu+fXPqJQwoi0CBF0PycENreytttIoW2UXrqPSyc0=; b=mIJKPTEZGZkP
    GkqGV3RjAn6ipnXXd3YWco40Lu17YWUIX97hxT0yT+hUQzjk8qxQNsur5v9pn9PW
    sCOAqOoHwpvkpp9DGZLHTGdxRmJkECxOv+g4zhZst4D/xapZ4YOLFXXzEGA85zEF
    IYihkkKJEnx1FneWHc5lnPLh7A10BR9dAe2nKTtPUHF5ZR+346I8U+XCJfY/7Civ
    WTpWT7zw9zXl7pj1k3Cflv+wOiqPAXC2Ws2CuKe/kBQPRWtmSEgUF1dC2JXNuzdV
    TuZ9T3rcn/1PPnapgaM3nkrwmaVnv6xkOOBJthQu6rrvNUzqlGMJ7Kt3IYE2+yrF
    C2zzvZsWeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGJRlfHlBDqOIexj4koJNgJrQmRiVUNxHHpnw9b0Rkk3/BhqAEUm17OVDdWkpQL7nWIfOBsZ6w3XF9ZVshnUz9DJ58GfSxIpeMyiZdT7FBqxVn8ofBtc
    vgdK7OhhQgkAJaeNSh9N5bPyD0vLn6Z9zVvWJZBJ6O29ns5X8JBYw9WUqdLbd1CWyKGkcUp447+f2lMdLV8qeP8f2Ge0t8eiqW3Kpu6UWT5EhdULh8UWIz+4
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=mxXUtGV5dC8A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=zPsT8Xl8QZxS8If0ZRwA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932461AbeDWUWy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 16:22:54 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:36583 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932445AbeDWUWw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 16:22:52 -0400
Subject: Re: [PATCH 4.14 000/164] 4.14.36-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180422135135.400265110@linuxfoundation.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <112e25ac-b0f8-9c6a-ddce-aacc58958439@kernel.org>
Date: Mon, 23 Apr 2018 14:22:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/22/2018 07:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.36 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:51:05 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.36-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted fine. I am seeing the same lock issue I saw on 4.16-4-rc1


new mount options do not match the existing superblock, will be ignored

================================
WARNING: inconsistent lock state
4.14.36-rc1+ #34 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/6/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (fs_reclaim){?.+.}, at: [<ffffffff81463b65>] fs_reclaim_acquire.part.77+0x5/0x30
{HARDIRQ-ON-W} state was registered at:
  lock_acquire+0x138/0x3a0
  fs_reclaim_acquire.part.77+0x29/0x30
  __alloc_pages_nodemask+0x24e/0x550
  alloc_page_interleave+0x14/0xf0
  kmalloc_order+0x1f/0x60
  kmalloc_order_trace+0x1d/0x140
  smp_store_boot_cpu_info+0x1e1/0x26d
  native_smp_prepare_cpus+0xe6/0x7ce
  kernel_init_freeable+0x276/0x499
  kernel_init+0xf/0x120
  ret_from_fork+0x3a/0x50
irq event stamp: 79104
hardirqs last  enabled at (79101): [<ffffffff823c362a>] cpuidle_enter_state+0xfa/0x820
hardirqs last disabled at (79102): [<ffffffff82a0093f>] common_interrupt+0x7f/0x84
softirqs last  enabled at (79104): [<ffffffff8111c88b>] irq_enter+0xbb/0xd0
softirqs last disabled at (79103): [<ffffffff8111c870>] irq_enter+0xa0/0xd0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(fs_reclaim);
  <Interrupt>
    lock(fs_reclaim);

 *** DEADLOCK ***

no locks held by swapper/6/0.

stack backtrace:
CPU: 6 PID: 0 Comm: swapper/6 Not tainted 4.14.36-rc1+ #34
Hardware name: System76, Inc. Wild Dog Performance/H87-PLUS, BIOS 0705 12/05/2013
Call Trace:
 <IRQ>
 dump_stack+0x67/0x91
 print_usage_bug+0x33c/0x35e
 mark_lock+0xba6/0xf30
 ? check_usage_backwards+0x2c0/0x2c0
 __lock_acquire+0x2049/0x4130
 ? __lock_acquire+0x8bf/0x4130
 ? extract_buf+0x1dc/0x2e0
 ? debug_check_no_locks_freed+0x2a0/0x2a0
 ? debug_check_no_locks_freed+0x2a0/0x2a0
 ? save_trace+0x250/0x250
 ? trace_event_raw_event_xfer_secondary_pool+0x2b0/0x2b0
 ? __wake_up_common+0x4a0/0x4a0
 ? lock_acquire+0x138/0x3a0
 lock_acquire+0x138/0x3a0
 ? fs_reclaim_acquire.part.77+0x5/0x30
 ? lock_acquire+0x3a0/0x3a0
 ? crng_reseed+0x3c6/0x670
 fs_reclaim_acquire.part.77+0x29/0x30
 ? fs_reclaim_acquire.part.77+0x5/0x30
 __kmalloc+0x4b/0x2a0
 crng_reseed+0x3c6/0x670
 ? init_std_data+0x270/0x270
 ? add_interrupt_randomness+0x363/0x5c0
 credit_entropy_bits+0x5a2/0x710
 ? __mix_pool_bytes+0x14d/0x1e0
 add_interrupt_randomness+0x363/0x5c0
 ? extract_entropy.constprop.41+0x260/0x260
 ? rcu_read_lock_sched_held+0xdc/0x110
 handle_irq_event_percpu+0x9a/0x120
 ? __handle_irq_event_percpu+0x640/0x640
 ? lock_acquire+0x138/0x3a0
 ? handle_edge_irq+0x30/0x750
 handle_irq_event+0xa7/0x140
 handle_edge_irq+0x1d4/0x750
 handle_irq+0x44/0x60
 do_IRQ+0x76/0x190
 common_interrupt+0x84/0x84
 </IRQ>
RIP: 0010:cpuidle_enter_state+0xfe/0x820
RSP: 0018:ffff8803cd6f7e20 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff9d
RAX: 0000000000000007 RBX: ffffe8ffffd89b80 RCX: 000000032a46c809
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8803cd6e2f2c
RBP: 0000000000000002 R08: ffff8803cfda9ca4 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000000032a46c809
R13: 0000000000000002 R14: 0000000000000000 R15: 000000032a447e26
 do_idle+0x211/0x2a0
 cpu_startup_entry+0x19/0x20
 start_secondary+0x331/0x420
 ? set_cpu_sibling_map+0x1530/0x1530
 secondary_startup_64+0xa5/0xb0
kauditd_printk_skb: 94 callbacks suppressed

thanks,
-- Shuah
