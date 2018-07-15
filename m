Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70192ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A066208E1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTlJBHoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A066208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeGOOTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:19:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35206 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeGOOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:19:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so1017440plq.2;
        Sun, 15 Jul 2018 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wOyfkedt0gvLD8l6346fUf7GRGEvi2KDzk5E1w6tDnQ=;
        b=dTlJBHoGEqqzCOW/floRhmpBqmQ9gIIQVbGVEIUIVQzQEWtDxKbF9J17xrDjV8cnNm
         Z1dYd+be5oH9gB7MAIzc1C/9/0SZP8Pix3IA4MpZTXRql68jk0fnrRdKk3A5aNAUB1Ds
         4YEXouNFqh255t0bj67qZ1WauKyhMN+k2TU9OwNoTTjiw3jVM1NkYOruPpDNyX0bPAVF
         V86Y+ba46ehRj4jDtbwGvkYk1QZaDGys3CndoiXCmDkv/6iKnSNyQ4AQGZwA+LHhrlnU
         uDjuUSAn8kGmh9XeXXDW4Ev1h+Y7mR2bnihsKOXGGRzWfe8xTGDW0M5Febj8T+8P7S0T
         7z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wOyfkedt0gvLD8l6346fUf7GRGEvi2KDzk5E1w6tDnQ=;
        b=Y4VBu4BnCmosX/DLgQfDXUIBOLg7t+gI8WbsobdR3XIUVXAzDyxXGcr1X1xKFUK9QA
         o70WaFW5K1lXYF7+R01+gGQngEHYtYN2AedZ2wmaX3PFr7Tv/v+Ya4c1XsJwSzfBP9oQ
         9JfS9u4LqMNo7e8/WMlWgyoML/EEgma4oF9NUl4ww1cWTs165OvFSdL0puS8BhZXUSFq
         l2eYORlmPXd7nj3yK91wu4LbNLovkHIl75/GUsm3vtMURZ+UNeTTxBO2prvOcaPCJrNQ
         1HWAZkpasEe2E5uKg4Z7FYN6ySQLEm9yK7EFV7lhfdH79brKqko5NDVrAmOWCA9fDLLK
         ZitQ==
X-Gm-Message-State: AOUpUlG1mlEwzH8Ws8QsLEE4yecUTWX2KW7oKDGwR4TiLLJ2qtWP7JHe
        ucdodL7LJcXjMgVshmhvXOc=
X-Google-Smtp-Source: AAOMgpcC0/Nv9muumjtTHqw0iGFiSWCDAfqLc/HCIbqwmIZ3OkaO9/zhcga8gkAagHpe0vXSOV2OiQ==
X-Received: by 2002:a17:902:8215:: with SMTP id x21-v6mr8952305pln.175.1531663006077;
        Sun, 15 Jul 2018 06:56:46 -0700 (PDT)
Received: from [10.1.10.12] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id j71-v6sm2370772pgd.23.2018.07.15.06.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 06:56:45 -0700 (PDT)
Subject: Re: general protection fault in smc_ioctl (2)
To:     syzbot <syzbot+35b2c5aa76fd398b9fd4@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, ubraun@linux.ibm.com,
        Stefan Raspl <raspl@linux.ibm.com>
References: <000000000000d62689057109f9b4@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <25bd4bce-5621-e738-d3de-c23ff3db923a@gmail.com>
Date:   Sun, 15 Jul 2018 06:56:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000d62689057109f9b4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/15/2018 06:49 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9cee8c437543 net: mvpp2: mvpp2_cls_flow_get() can be static
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12807b70400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89129667b46496c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=35b2c5aa76fd398b9fd4
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14e9cf0c400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136325d0400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+35b2c5aa76fd398b9fd4@syzkaller.appspotmail.com
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 4516 Comm: syz-executor129 Not tainted 4.18.0-rc3+ #121
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:smc_ioctl+0x846/0xd00 net/smc/af_smc.c:1748
> Code: 48 c1 e9 03 80 3c 11 00 0f 85 29 04 00 00 4d 8b b6 a0 04 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d 7e 20 48 89 f9 48 c1 e9 03 <0f> b6 14 11 84 d2 74 09 80 fa 03 0f 8e 65 03 00 00 48 8d 7b 02 41
> RSP: 0018:ffff8801b258f750 EFLAGS: 00010202
> RAX: ffff8801b258f7c8 RBX: ffff8801b258f788 RCX: 0000000000000004
> RDX: dffffc0000000000 RSI: 1ffff100364b1ef9 RDI: 0000000000000020
> RBP: ffff8801b258f9b0 R08: ffffed00364b1efa R09: ffffed00364b1ef9
> R10: ffffed00364b1ef9 R11: ffff8801b258f7cf R12: 1ffff100364b1eed
> R13: 0000000020000040 R14: 0000000000000000 R15: 1ffff100364b1f11
> FS:  00007fdddb23c700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdddb21ae78 CR3: 00000001b6c9a000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  sock_do_ioctl+0xe4/0x3e0 net/socket.c:969
>  sock_ioctl+0x30d/0x680 net/socket.c:1093
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x445e89
> Code: e8 7c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb 0c fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fdddb23bdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000006dbc3c RCX: 0000000000445e89
> RDX: 0000000020000040 RSI: 0000000000008905 RDI: 000000000000006d
> RBP: 00000000006dbc38 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe54550fbf R14: 00007fdddb23c9c0 R15: 0000000000000004
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 924422afa249de86 ]---
> RIP: 0010:smc_ioctl+0x846/0xd00 net/smc/af_smc.c:1748
> Code: 48 c1 e9 03 80 3c 11 00 0f 85 29 04 00 00 4d 8b b6 a0 04 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d 7e 20 48 89 f9 48 c1 e9 03 <0f> b6 14 11 84 d2 74 09 80 fa 03 0f 8e 65 03 00 00 48 8d 7b 02 41
> RSP: 0018:ffff8801b258f750 EFLAGS: 00010202
> RAX: ffff8801b258f7c8 RBX: ffff8801b258f788 RCX: 0000000000000004
> RDX: dffffc0000000000 RSI: 1ffff100364b1ef9 RDI: 0000000000000020
> RBP: ffff8801b258f9b0 R08: ffffed00364b1efa R09: ffffed00364b1ef9
> R10: ffffed00364b1ef9 R11: ffff8801b258f7cf R12: 1ffff100364b1eed
> R13: 0000000020000040 R14: 0000000000000000 R15: 1ffff100364b1f11
> FS:  00007fdddb23c700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdddb21ae78 CR3: 00000001b6c9a000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches


Probably caused by commit de8474eb9d50fd47b8c73816f34739dec5e96754
("net/smc: urgent data support")


