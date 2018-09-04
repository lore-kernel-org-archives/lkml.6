Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA847C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649912086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cFCAeENf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649912086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIDTdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:33:11 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46725 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIDTdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:33:11 -0400
Received: by mail-io0-f194.google.com with SMTP id y12-v6so3214557ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xyslRucWLfivSpG9P4gXCGG8bahYGHfHyggCkmh/8ME=;
        b=cFCAeENfmEAHuyYPXNUDuTpZk1f13hkaZpR1bfCdLARSVkrgKUNhQMMz+/CJLf6EWk
         Eq+m5/HNdFUImx/3jAZInzbXGHMflcHWPiF9ubkacGkPR3FqXqOeVkaz0Ty0fM/9RXox
         huuZtt5ZF1Kki3JO1AcT8Ji1qNg/180+/UuPfqSPzSGFCqU+13wpmtVp18wD+/FE7Vbv
         gMTU/+SYaOy/UlrhoBBNS4cPlSPJMUcaOqLNY1XOWdd91K7HXZorY3EsY0lY0clIONq2
         2gN+q7IbFzJJDHj1ZRX07tK7UcyWFfr7Z4UpeOFasfcPEIkav1xBclL3rZbyf+/TM6Ia
         /RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xyslRucWLfivSpG9P4gXCGG8bahYGHfHyggCkmh/8ME=;
        b=W4mdbIi1A7FXVRL/L4dzMnxAIhxotiuBG6LhaSiQdoYPwiU8iS3JBBERXbD86YYEX0
         7+4Xt7NlSRdGtJ+Hz7uv6v4IkoBZ3CtFjlXE0HSS5yL7zRTTSgvnMLgkbCb7tRxqpNm/
         2/xwsVFonFiQQcS/OginGd7QWGr4qVPI3GYfuuGFd2l//tnRM1ghGcos1Xw5i77+I32x
         c0bbbpV1jqJv30cQZXPXM9vLzXhxR3er5TCpkLBFXkTCKm4EgjLecTEl52sS6Lb+6TkS
         9y8oRvWrdCc8fRFh/10QG0RGkZsT4uiuTVYKF+b6m/NdtjxDIIZghwajlzLNQBv65QoY
         eArA==
X-Gm-Message-State: APzg51A7uP/YWB7CyEx+vBy2bfU2SrZoHWWf/1DbWhzsZ7lG8tDqLwoG
        bNPfaxIJ+MDp1rwXCq2gVxobIA==
X-Google-Smtp-Source: ANB0VdY9trozM/MXhKAnYRxhkOBv8xMQYwD9TWcrgx/VHgxT1n65cuKeJpuEbN+DHVZ57BS9MvhCdQ==
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr22520474iog.175.1536073660998;
        Tue, 04 Sep 2018 08:07:40 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v3-v6sm7709953iob.70.2018.09.04.08.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 08:07:39 -0700 (PDT)
Subject: Re: divide error in nbd_ioctl
To:     syzbot <syzbot+25dbecbec1e62c6b0dd4@syzkaller.appspotmail.com>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000006105bf057506ebb9@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc31a6f0-97c6-9dc0-8676-089e9fd69868@kernel.dk>
Date:   Tue, 4 Sep 2018 09:07:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0000000000006105bf057506ebb9@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/18 1:51 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    217c3e019675 disable stringop truncation warnings for now
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13665da6400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
> dashboard link: https://syzkaller.appspot.com/bug?extid=25dbecbec1e62c6b0dd4
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e910a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169dfe0a400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+25dbecbec1e62c6b0dd4@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> divide error: 0000 [#1] SMP KASAN
> CPU: 0 PID: 4667 Comm: syz-executor024 Not tainted 4.19.0-rc1+ #216
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> RIP: 0010:div_s64_rem include/linux/math64.h:41 [inline]
> RIP: 0010:div_s64 include/linux/math64.h:139 [inline]
> RIP: 0010:__nbd_ioctl drivers/block/nbd.c:1242 [inline]
> RIP: 0010:nbd_ioctl+0x53c/0xcf0 drivers/block/nbd.c:1303
> Code: ea 03 80 3c 02 00 0f 85 1c 07 00 00 48 8b b5 c0 fe ff ff 48 63 8d b8  
> fe ff ff 48 8b 86 c8 00 00 00 48 8d be c0 00 00 00 48 99 <48> f7 f9 48 ba  
> 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c
> RSP: 0018:ffff8801c90bf828 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8801ccb23c00 RDI: ffff8801ccb23cc0
> RBP: ffff8801c90bf9a0 R08: ffff8801bc502640 R09: ffffed003a62d01d
> R10: ffff8801c90bf818 R11: ffff8801d31680ef R12: ffff8801d3168000
> R13: 00000000ffffffe7 R14: ffff8801d31680e0 R15: ffff8801d5730840
> FS:  00000000015b2880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043e560 CR3: 00000001b8034000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   __blkdev_driver_ioctl block/ioctl.c:303 [inline]
>   blkdev_ioctl+0x9cd/0x2030 block/ioctl.c:601
>   block_ioctl+0xee/0x130 fs/block_dev.c:1883
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   file_ioctl fs/ioctl.c:501 [inline]
>   do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>   ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>   __do_sys_ioctl fs/ioctl.c:709 [inline]
>   __se_sys_ioctl fs/ioctl.c:707 [inline]
>   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x443d29
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
> ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe343644d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443d29
> RDX: 0000000000000000 RSI: 000000000000ab01 RDI: 0000000000000003
> RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
> R10: 000000000000000f R11: 0000000000000213 R12: 0000000000401a30
> R13: 0000000000401ac0 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace 25c60c4714d4e2ee ]---
> RIP: 0010:div_s64_rem include/linux/math64.h:41 [inline]
> RIP: 0010:div_s64 include/linux/math64.h:139 [inline]
> RIP: 0010:__nbd_ioctl drivers/block/nbd.c:1242 [inline]
> RIP: 0010:nbd_ioctl+0x53c/0xcf0 drivers/block/nbd.c:1303
> Code: ea 03 80 3c 02 00 0f 85 1c 07 00 00 48 8b b5 c0 fe ff ff 48 63 8d b8  
> fe ff ff 48 8b 86 c8 00 00 00 48 8d be c0 00 00 00 48 99 <48> f7 f9 48 ba  
> 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c
> RSP: 0018:ffff8801c90bf828 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff8801ccb23c00 RDI: ffff8801ccb23cc0
> RBP: ffff8801c90bf9a0 R08: ffff8801bc502640 R09: ffffed003a62d01d
> R10: ffff8801c90bf818 R11: ffff8801d31680ef R12: ffff8801d3168000
> R13: 00000000ffffffe7 R14: ffff8801d31680e0 R15: ffff8801d5730840
> FS:  00000000015b2880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000043e560 CR3: 00000001b8034000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Looks like NBD_SET_BLKSIZE is happy to just take whatever value.
We should ensure that it's a power of 2, not zero, and bigger
or equal than 512, but smaller or equal to PAGE_SIZE. Something
like this?


diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 3863c00372bb..14a51254c3db 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1239,6 +1239,9 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 	case NBD_SET_SOCK:
 		return nbd_add_socket(nbd, arg, false);
 	case NBD_SET_BLKSIZE:
+		if (!arg || !is_power_of_2(arg) || arg < 512 ||
+		    arg > PAGE_SIZE)
+			return -EINVAL;
 		nbd_size_set(nbd, arg,
 			     div_s64(config->bytesize, arg));
 		return 0;

-- 
Jens Axboe

