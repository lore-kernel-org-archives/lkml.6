Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2D9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFFA2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gnWYGq6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfB0NNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:13:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33880 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfB0NNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:13:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id d15so8029242plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CaQsr6S9Iz106Nqji5Are9jsxwbVtuMbgR/Sm3jS8CA=;
        b=gnWYGq6gf72+e1wdzzrxFgUoV7PWAjcC3EhOqXsMutnS8jl5kFBQlRFBLaZsyiRMcb
         xf1+6r1XO4rAY5+COebkuNaPJjXBQWHENeY6C20jdJs6K693NzG9tCp7gCUd6oPnbcTZ
         /cm4HdhpEUI/Wmb5XeHqCyLXxf75X65cr8hxGOuTZVMBttghY/84HPgGgBeN131WsMSl
         QO2rFAOPb+KxYgzgvXb2V1VRL9VoZKD7I04XoCR90oQahwrNsBX9/2Ydv1qDrcVoSJuL
         7eNilTqoXFGd33pyqTMEUwRp29t/aisfEdjZafYcUTxi8WrT5Q61+1LkezOfaNhBJbYk
         jNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CaQsr6S9Iz106Nqji5Are9jsxwbVtuMbgR/Sm3jS8CA=;
        b=LsIY8XbZ3aln7kmVnXMTxX3ydq83M6gqpKCpb+tyezfoYYs5OGLNuD1KyupFWBpyTU
         dJfj5qOcKUVb2dRMCspV11AMNzO4dflgmo6aL+wNhCQ/dMCoTKkLPsEBf6ZFzL9i/h1G
         2q39aynV5Q6ImFUFW+r1sPciAKmIGP4lHUgaatMNhDWIbZT+Dm2GF/eqR9evq4uiFQb+
         MfW/S0mE7DdiRTE//xqy3Hd1234NhW0+oTll+ukEZEVvJ6Qi6g7ktrqYaTbudtvr1nD7
         lfSPek8mJGvVN1CtBz4WQaTjwnY530L4nxadWmJShm9IF/vxFhzp7t/c24mb3DKhi8Hx
         QtCw==
X-Gm-Message-State: AHQUAubv7Yq4APl3Og1SNL7i+60GDafUHPb06ZQq+vKOiM1KaStxaq03
        e0lmqm7WyTHKOeaJmvzHQgV6pg==
X-Google-Smtp-Source: AHgI3IZ3f/a0X/hWi2LuYbqyvzAXfhiXmxaatdLeG6Q1ozO+6GW3igKxX6HtO5xkKSgbHEkTn8EsUQ==
X-Received: by 2002:a17:902:7688:: with SMTP id m8mr2064297pll.248.1551273202619;
        Wed, 27 Feb 2019 05:13:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d23sm21909650pfn.180.2019.02.27.05.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 05:13:21 -0800 (PST)
Subject: Re: kernel BUG at include/linux/mm.h:LINE! (3)
To:     Eric Biggers <ebiggers@kernel.org>,
        syzbot <syzbot+a5b71df98b247d973f8c@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000b8bcea0582d9e992@google.com>
 <20190227061143.GA680@sol.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <10ff57b7-5f61-a447-e9af-e883b418f12d@kernel.dk>
Date:   Wed, 27 Feb 2019 06:13:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227061143.GA680@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 11:11 PM, Eric Biggers wrote:
> On Tue, Feb 26, 2019 at 10:02:04PM -0800, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    8e7f81e2ebc4 Add linux-next specific files for 20190226
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10381714c00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2fa10211b8a4a56e
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a5b71df98b247d973f8c
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eda192c00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164831e0c00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+a5b71df98b247d973f8c@syzkaller.appspotmail.com
>>
>> page:ffffea00025c3ac0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
>> flags: 0x1fffc0000000000()
>> raw: 01fffc0000000000 ffffea00024bf988 ffffea00021dd448 0000000000000000
>> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
>> ------------[ cut here ]------------
>> kernel BUG at include/linux/mm.h:579!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 7779 Comm: syz-executor379 Not tainted 5.0.0-rc8-next-20190226
>> #43
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
>> RIP: 0010:put_page include/linux/mm.h:1025 [inline]
>> RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
>> Code: bd ff 4c 89 e7 e8 90 43 db ff e8 bb 29 bd ff 5b 41 5c 41 5d 5d c3 e8
>> af 29 bd ff 48 c7 c6 20 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 99 29 bd
>> ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
>> RSP: 0018:ffff8880a503f920 EFLAGS: 00010293
>> RAX: ffff88808d2ec6c0 RBX: ffffea00025c3af4 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff81982852 RDI: ffffea00025c3af8
>> RBP: ffff8880a503f938 R08: 000000000000003e R09: ffffed1015d05011
>> R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea00025c3ac0
>> R13: 0000000000000000 R14: ffff88809b6e8a40 R15: ffff8880952c4000
>> FS:  00000000016a0880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020f50f90 CR3: 0000000097b89000 CR4: 00000000001406f0
>> Call Trace:
>>  pipe_buf_release include/linux/pipe_fs_i.h:129 [inline]
>>  iter_file_splice_write+0x7d1/0xbe0 fs/splice.c:759
>>  do_splice_from fs/splice.c:847 [inline]
>>  direct_splice_actor+0x126/0x1a0 fs/splice.c:1019
>>  splice_direct_to_actor+0x369/0x970 fs/splice.c:974
>>  do_splice_direct+0x1da/0x2a0 fs/splice.c:1062
>>  do_sendfile+0x597/0xd00 fs/read_write.c:1442
>>  __do_sys_sendfile64 fs/read_write.c:1503 [inline]
>>  __se_sys_sendfile64 fs/read_write.c:1489 [inline]
>>  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1489
>>  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x443d29
>> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007fffc1e47c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
>> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443d29
>> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
>> RBP: 00000000006ce018 R08: 00000000004002e0 R09: 00000000004002e0
>> R10: 0000000102000300 R11: 0000000000000246 R12: 0000000000401a30
>> R13: 0000000000401ac0 R14: 0000000000000000 R15: 0000000000000000
>> Modules linked in:
>> ---[ end trace 9daff95e0e1a45ff ]---
>> RIP: 0010:put_page_testzero include/linux/mm.h:579 [inline]
>> RIP: 0010:put_page include/linux/mm.h:1025 [inline]
>> RIP: 0010:generic_pipe_buf_release+0x120/0x160 fs/pipe.c:224
>> Code: bd ff 4c 89 e7 e8 90 43 db ff e8 bb 29 bd ff 5b 41 5c 41 5d 5d c3 e8
>> af 29 bd ff 48 c7 c6 20 98 75 87 4c 89 e7 e8 c0 db e4 ff <0f> 0b e8 99 29 bd
>> ff 4d 8d 65 ff e9 3d ff ff ff 48 89 df e8 e8 f8
>> RSP: 0018:ffff8880a503f920 EFLAGS: 00010293
>> RAX: ffff88808d2ec6c0 RBX: ffffea00025c3af4 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff81982852 RDI: ffffea00025c3af8
>> RBP: ffff8880a503f938 R08: 000000000000003e R09: ffffed1015d05011
>> R10: ffffed1015d05010 R11: ffff8880ae828087 R12: ffffea00025c3ac0
>> R13: 0000000000000000 R14: ffff88809b6e8a40 R15: ffff8880952c4000
>> FS:  00000000016a0880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020f50f90 CR3: 0000000097b89000 CR4: 00000000001406f0
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>>
> 
> This is the same bug I already reported here and Jens is working on:
> https://marc.info/?l=linux-api&m=155115288114046&w=2
> I'll mark this fixed once the fix is folded in and in linux-next.

It should already be, I folded in the fix about 24h ago.

-- 
Jens Axboe

