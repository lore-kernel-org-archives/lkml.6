Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7716DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2719C21475
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ms+1o4a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2719C21475
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbeGQOtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:49:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33543 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbeGQOtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:49:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so586616pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+QIIoXD/9osUKmbpCk3PkmGF5qPJc1keXQ5lMXgo0/0=;
        b=Ms+1o4a2HepD7IdhwwWSngfNTct3rWBCJYiabcNDiRQ+wKh14d0p4OylujZ5MH9Uo3
         YanVeu7xBlGGR71BOdITfcSX1dOCxgkI/wuxYxsKo3CNoip/Z5QhNoubqIlcHHK+mKB/
         9FBdOHn4r3SJ6HKx7/gz/MWfhHh+6ulEqQwvUjBJIdOkzCXECPnUgUbBUjHDbBVZxAEu
         h0i8G/VjA8JIKB//jZ1McpPMMzEKS05G+KfzCXyt0H23Ot8Vet5d8DrN8rypyojj9BPi
         EBocMUYTsqsmVGNFzhFgg868/3qmWNjvEN7dPn5o04rWglj+HoaKd6pmpHqAEK55rM4f
         K/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+QIIoXD/9osUKmbpCk3PkmGF5qPJc1keXQ5lMXgo0/0=;
        b=ImSDKB+7Qs4x14JWuzFcyMzhhusn22bY7+GKq01SWP2mJPiNlgBgT5/rDoedlEAYgH
         B0lMVJ0EWUfIF0Awap9CljOV9OotDnXWaLqwLl6kFp5z/YSO1LUSfxaf8LnvIL75vx21
         jJK4MoMUvmB2BJFHIquPlzIiJbWzo7NZOYYBv+QjHH6HOHRXq354gHOjrsbvWvztImOw
         q5ZCEgDFMeJjJ4L6heZjsdWJDXzHL7/APOmLhGtm6qJ44Wtmox2KcQk6bG4iwy6FjLaM
         GD4Jas9xQYxaGU4N1s/dzPx9ObaE9pNhEefvu/kHJCOdLyXV2/HtpV0fLNflK31BcoYS
         oZGg==
X-Gm-Message-State: AOUpUlGSWaru+XFlRooXylbdjVUqyx5nED/ETQP5w1gPM4zVW8SjHfFB
        1kPUVaZwgSSiT+n9XKbNKFgp8SyqrtZzP/gdiHm3XA==
X-Google-Smtp-Source: AAOMgpcDidP2uxPq8X27a7ArmcWtyCHz24ie7LprAsPkmwqm/DAP1GFbz68L1476lg9FUi/Pl/9V4PQkItneg/WSJwg=
X-Received: by 2002:a62:3f44:: with SMTP id m65-v6mr464437pfa.98.1531836985707;
 Tue, 17 Jul 2018 07:16:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 17 Jul 2018 07:16:05
 -0700 (PDT)
In-Reply-To: <c7860eae-cb7b-07fc-ff8b-b0bbaf04bdfa@virtuozzo.com>
References: <000000000000d8cc39057131bbcd@google.com> <c7860eae-cb7b-07fc-ff8b-b0bbaf04bdfa@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Jul 2018 16:16:05 +0200
Message-ID: <CACT4Y+bQrCJDyzyzYv26U9asWZFhEHv-NVa1noO-8Y3u8+=JjA@mail.gmail.com>
Subject: Re: general protection fault in list_lru_count_one
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     syzbot <syzbot+50d322b3e0b15a4a8d55@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longman@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 3:20 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 17.07.2018 16:15, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    483d835c8189 Add linux-next specific files for 20180713
>
> 483d835c8189 contains register_shrinker() in sget_fc(). It's fixed by 72589a599d79
> and 2c028928aa4c, which came in next-20180716.

Thanks. Let's tell syzbot about it:

#syz fix: fs/super.c: fix double prealloc_shrinker() in sget_fc()


>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=169b4770400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=60e5ac2478928314
>> dashboard link: https://syzkaller.appspot.com/bug?extid=50d322b3e0b15a4a8d55
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10faa9a4400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f57794400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+50d322b3e0b15a4a8d55@syzkaller.appspotmail.com
>>
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> IPVS: ftp: loaded support on port[0] = 21
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] SMP KASAN
>> CPU: 0 PID: 4462 Comm: syz-executor763 Not tainted 4.18.0-rc4-next-20180713+ #7
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
>> RIP: 0010:list_lru_from_memcg_idx mm/list_lru.c:56 [inline]
>> RIP: 0010:list_lru_count_one+0x156/0x460 mm/list_lru.c:201
>> Code: 08 3c 03 0f 8e b5 02 00 00 4d 63 bd d8 0a 00 00 e8 7f 35 d2 ff 48 8d 7b 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d8 02 00 00 49 8d 46 c0 4c 8b 6b 50 48 ba 00 00
>> RSP: 0018:ffff8801ac967198 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81aa3a64
>> RDX: 000000000000000a RSI: ffffffff81aa3ad1 RDI: 0000000000000050
>> RBP: ffff8801ac967228 R08: ffff8801af1c6300 R09: 0000000000000000
>> R10: ffffed00359e0088 R11: ffff8801acf00447 R12: 1ffff1003592ce34
>> R13: ffff8801ad6aa080 R14: ffff8801ac967200 R15: 0000000000000000
>> FS:  000000000206b880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000006ce080 CR3: 00000001ae3c1000 CR4: 00000000001406f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  list_lru_shrink_count include/linux/list_lru.h:122 [inline]
>>  super_cache_count+0x153/0x2e0 fs/super.c:146
>>  do_shrink_slab+0x148/0xc50 mm/vmscan.c:458
>>  shrink_slab_memcg mm/vmscan.c:598 [inline]
>>  shrink_slab+0x861/0xa60 mm/vmscan.c:671
>>  shrink_node+0x429/0x16a0 mm/vmscan.c:2735
>>  shrink_zones mm/vmscan.c:2964 [inline]
>>  do_try_to_free_pages+0x3e7/0x1290 mm/vmscan.c:3026
>>  try_to_free_mem_cgroup_pages+0x49d/0xc90 mm/vmscan.c:3324
>>  reclaim_high.constprop.73+0x137/0x1e0 mm/memcontrol.c:2060
>>  mem_cgroup_handle_over_high+0x8d/0x130 mm/memcontrol.c:2085
>>  tracehook_notify_resume include/linux/tracehook.h:195 [inline]
>>  exit_to_usermode_loop+0x287/0x380 arch/x86/entry/common.c:166
>>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x440ec7
>> Code: 1f 40 00 b8 5a 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 6d 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 4d 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007ffe197f4e98 EFLAGS: 00000202 ORIG_RAX: 0000000000000053
>> RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000440ec7
>> RDX: 00007ffe197f4eb3 RSI: 00000000000001ff RDI: 00007ffe197f4eb0
>> RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000003
>> R10: 0000000000000064 R11: 0000000000000202 R12: 0000000000000001
>> R13: 0000000000008fab R14: 0000000000000000 R15: 0000000000000000
>> Modules linked in:
>> Dumping ftrace buffer:
>>    (ftrace buffer empty)
>> ---[ end trace 82052695a1b5b84c ]---
>> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
>> RIP: 0010:list_lru_from_memcg_idx mm/list_lru.c:56 [inline]
>> RIP: 0010:list_lru_count_one+0x156/0x460 mm/list_lru.c:201
>> Code: 08 3c 03 0f 8e b5 02 00 00 4d 63 bd d8 0a 00 00 e8 7f 35 d2 ff 48 8d 7b 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d8 02 00 00 49 8d 46 c0 4c 8b 6b 50 48 ba 00 00
>> RSP: 0018:ffff8801ac967198 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81aa3a64
>> RDX: 000000000000000a RSI: ffffffff81aa3ad1 RDI: 0000000000000050
>> RBP: ffff8801ac967228 R08: ffff8801af1c6300 R09: 0000000000000000
>> R10: ffffed00359e0088 R11: ffff8801acf00447 R12: 1ffff1003592ce34
>> R13: ffff8801ad6aa080 R14: ffff8801ac967200 R15: 0000000000000000
>> FS:  000000000206b880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000006ce080 CR3: 00000001ae3c1000 CR4: 00000000001406f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/c7860eae-cb7b-07fc-ff8b-b0bbaf04bdfa%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
