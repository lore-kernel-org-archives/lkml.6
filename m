Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DCEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789862075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789862075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeIFV62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:58:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:6020 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeIFV6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:58:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 10:21:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="86599648"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.135]) ([10.54.74.135])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2018 10:21:47 -0700
Subject: Re: KASAN: use-after-free Read in sha512_mb_flusher
To:     Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+94ee41ce442afe333d2e@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        megha.dey@linux.intel.com, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
References: <00000000000091258805737be8b3@google.com>
 <20180821024615.GC706@sol.localdomain>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f3e884fe-1900-99af-c027-353edb7663bb@linux.intel.com>
Date:   Thu, 6 Sep 2018 10:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180821024615.GC706@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 07:46 PM, Eric Biggers wrote:
> On Wed, Aug 15, 2018 at 09:35:03AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    5ed5da74de9e Add linux-next specific files for 20180813
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13fd82c4400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=18edf0289d1b5ab
>> dashboard link: https://syzkaller.appspot.com/bug?extid=94ee41ce442afe333d2e
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+94ee41ce442afe333d2e@syzkaller.appspotmail.com
>>
>> RDX: 00000000200002c0 RSI: 0000000000000005 RDI: 0000000000000004
>> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000f6a R11: 0000000000000246 R12: 0000000000000006
>> R13: 00000000004d3840 R14: 00000000004c85ae R15: 0000000000000003
>> ==================================================================
>> BUG: KASAN: use-after-free in sha512_mb_flusher+0x572/0x610
>> arch/x86/crypto/sha512-mb/sha512_mb.c:940
>> Read of size 8 at addr ffff8801b35669d8 by task kworker/0:2/1879
>>
>> CPU: 0 PID: 1879 Comm: kworker/0:2 Not tainted 4.18.0-next-20180813+ #37
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Workqueue: crypto mcryptd_flusher
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>  sha512_mb_flusher+0x572/0x610 arch/x86/crypto/sha512-mb/sha512_mb.c:940
>>  mcryptd_flusher+0x342/0x4b0 crypto/mcryptd.c:208
>>  process_one_work+0xc73/0x1aa0 kernel/workqueue.c:2153
>>  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
>>  kthread+0x35a/0x420 kernel/kthread.c:246
>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
>>
>> Allocated by task 18983:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>>  __do_kmalloc mm/slab.c:3718 [inline]
>>  __kmalloc+0x14e/0x720 mm/slab.c:3727
>>  kmalloc include/linux/slab.h:518 [inline]
>>  sock_kmalloc+0x156/0x1f0 net/core/sock.c:1983
>>  hash_accept_parent_nokey+0x58/0x2e0 crypto/algif_hash.c:438
>>  hash_accept_parent+0x5b/0x80 crypto/algif_hash.c:465
>>  af_alg_accept+0x127/0x7d0 crypto/af_alg.c:296
>>  alg_accept+0x46/0x60 crypto/af_alg.c:332
>>  __sys_accept4+0x3b2/0x8a0 net/socket.c:1589
>>  __do_sys_accept4 net/socket.c:1624 [inline]
>>  __se_sys_accept4 net/socket.c:1621 [inline]
>>  __x64_sys_accept4+0x97/0xf0 net/socket.c:1621
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Freed by task 18979:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>>  __cache_free mm/slab.c:3498 [inline]
>>  kfree+0xd9/0x210 mm/slab.c:3813
>>  __sock_kfree_s net/core/sock.c:2004 [inline]
>>  sock_kfree_s+0x29/0x60 net/core/sock.c:2010
>>  hash_sock_destruct+0x157/0x1c0 crypto/algif_hash.c:427
>>  __sk_destruct+0x107/0xa60 net/core/sock.c:1560
>>  sk_destruct+0x78/0x90 net/core/sock.c:1595
>>  __sk_free+0xcf/0x300 net/core/sock.c:1606
>>  sk_free+0x42/0x50 net/core/sock.c:1617
>>  sock_put include/net/sock.h:1691 [inline]
>>  af_alg_release+0x6e/0x90 crypto/af_alg.c:126
>>  __sock_release+0xd7/0x250 net/socket.c:580
>>  sock_close+0x19/0x20 net/socket.c:1140
>>  __fput+0x376/0x8a0 fs/file_table.c:279
>>  ____fput+0x15/0x20 fs/file_table.c:312
>>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>>  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
>>  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> The buggy address belongs to the object at ffff8801b3566600
>>  which belongs to the cache kmalloc-2048 of size 2048
>> The buggy address is located 984 bytes inside of
>>  2048-byte region [ffff8801b3566600, ffff8801b3566e00)
>> The buggy address belongs to the page:
>> page:ffffea0006cd5980 count:1 mapcount:0 mapping:ffff8801dac00c40 index:0x0
>> compound_mapcount: 0
>> flags: 0x2fffc0000008100(slab|head)
>> raw: 02fffc0000008100 ffffea0006cf2c08 ffffea000764ef08 ffff8801dac00c40
>> raw: 0000000000000000 ffff8801b3566600 0000000100000003 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff8801b3566880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801b3566900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffff8801b3566980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                                     ^
>>  ffff8801b3566a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801b3566a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>>
>>
> 
> This is probably the same root cause as the other sha512_mb use-after-free
> (https://lkml.org/lkml/2018/8/15/296), see my reply there.
> 
> #syz dup: KASAN: use-after-free Read in sha512_ctx_mgr_resubmit
> 
> - Eric
> 

Yes, I think it is similar to the previous report.  Megha is working to debug
it.

Tim
