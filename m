Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5ACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF557206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="oRVyB/+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF557206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIDWOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:14:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42510 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDWOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:14:23 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so4956816qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 10:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LWKBJkJU6zXK2xmBBvNCDKn0/qb9HGTU9YIdahN8L7c=;
        b=oRVyB/+jCfaNIlqQ0XZRPLudhkay0tTIrQ3n6zaYG9QiqTkbccI93pgKPhZtUR/J6r
         Sw3BfOLzPn7tyKXonDLXs3wfftb1/PyKu88Pebh3CuHzr3O0NrXltF5mleKZ5lsFiygS
         b9rqMoTzjNLqKo1y9edAEHVMSfIqh0HD2r/QeRz35NOwkN7uizm6MRsLbkZxfrl+tvMK
         NnzPNrcTcndigcOhqiKXlBx9/gmx06Ik9w+E2Y402o3eGB7VTYC5rEapHewyboXTxcGx
         4wF0wDiaVRup1PF7TjZkB/W2pzYqcToK68D8uXykP0wJqCTM0OHT/18xUlsaQMbZXd22
         1ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LWKBJkJU6zXK2xmBBvNCDKn0/qb9HGTU9YIdahN8L7c=;
        b=coGHXAKnQnEXYEnmp/xRydlBMTGWyTZgl+kD0zdKl3EfpzusqHEPUqqIoEY/EJTcl7
         VPJSii6CbrMIC93d1VeGt4fepUPm+YaCkrg1fNfdM9o1WZrfFsGOhdXJ1XYlUYCmj6H9
         hbpj672tULw4DRAqRbKy0nKsBtBuEpl60Ok+O/uv29gldk230VbvwSq7wfQkvCQC5jSh
         nzDNxzCslnvrBVvdUYNwJTfzQbd8/LSWPygKWro7IRVfc9+1mbw3GCxKRDWeB55bY7T/
         6UTTCLK+lr7JJuz0UW0W6cMWrlcXSrPhifzMI/OmPscrLFtN1he7nf1mf9L7uIOnufXx
         rHdQ==
X-Gm-Message-State: APzg51Bqn+GAOy6cAMHDMivh3yAjxxb+h+9fJNdY0QfGJvteL5Rb6SyW
        BjmXkyPK9fheFhYuw9sEUkF6Dw==
X-Google-Smtp-Source: ANB0VdYS9rCcqXEyMACIpG+FZKT3WqkG4QIoaro/6MGUAGsMa6r9EM53G6wkceisbUreSfxt08xLCA==
X-Received: by 2002:a0c:acad:: with SMTP id m42-v6mr29591383qvc.27.1536083293848;
        Tue, 04 Sep 2018 10:48:13 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m9-v6sm14338019qta.55.2018.09.04.10.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 10:48:12 -0700 (PDT)
Date:   Tue, 4 Sep 2018 13:48:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+25dbecbec1e62c6b0dd4@syzkaller.appspotmail.com>,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: divide error in nbd_ioctl
Message-ID: <20180904174810.gp7bd5s3kijhjp5d@destiny>
References: <0000000000006105bf057506ebb9@google.com>
 <dc31a6f0-97c6-9dc0-8676-089e9fd69868@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc31a6f0-97c6-9dc0-8676-089e9fd69868@kernel.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:07:37AM -0600, Jens Axboe wrote:
> On 9/4/18 1:51 AM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    217c3e019675 disable stringop truncation warnings for now
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13665da6400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
> > dashboard link: https://syzkaller.appspot.com/bug?extid=25dbecbec1e62c6b0dd4
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e910a400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169dfe0a400000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+25dbecbec1e62c6b0dd4@syzkaller.appspotmail.com
> > 
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > divide error: 0000 [#1] SMP KASAN
> > CPU: 0 PID: 4667 Comm: syz-executor024 Not tainted 4.19.0-rc1+ #216
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > Google 01/01/2011
> > RIP: 0010:div_s64_rem include/linux/math64.h:41 [inline]
> > RIP: 0010:div_s64 include/linux/math64.h:139 [inline]
> > RIP: 0010:__nbd_ioctl drivers/block/nbd.c:1242 [inline]
> > RIP: 0010:nbd_ioctl+0x53c/0xcf0 drivers/block/nbd.c:1303
> > Code: ea 03 80 3c 02 00 0f 85 1c 07 00 00 48 8b b5 c0 fe ff ff 48 63 8d b8  
> > fe ff ff 48 8b 86 c8 00 00 00 48 8d be c0 00 00 00 48 99 <48> f7 f9 48 ba  
> > 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c
> > RSP: 0018:ffff8801c90bf828 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffff8801ccb23c00 RDI: ffff8801ccb23cc0
> > RBP: ffff8801c90bf9a0 R08: ffff8801bc502640 R09: ffffed003a62d01d
> > R10: ffff8801c90bf818 R11: ffff8801d31680ef R12: ffff8801d3168000
> > R13: 00000000ffffffe7 R14: ffff8801d31680e0 R15: ffff8801d5730840
> > FS:  00000000015b2880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000043e560 CR3: 00000001b8034000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   __blkdev_driver_ioctl block/ioctl.c:303 [inline]
> >   blkdev_ioctl+0x9cd/0x2030 block/ioctl.c:601
> >   block_ioctl+0xee/0x130 fs/block_dev.c:1883
> >   vfs_ioctl fs/ioctl.c:46 [inline]
> >   file_ioctl fs/ioctl.c:501 [inline]
> >   do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
> >   ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
> >   __do_sys_ioctl fs/ioctl.c:709 [inline]
> >   __se_sys_ioctl fs/ioctl.c:707 [inline]
> >   __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
> >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x443d29
> > Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
> > ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007ffe343644d8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443d29
> > RDX: 0000000000000000 RSI: 000000000000ab01 RDI: 0000000000000003
> > RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
> > R10: 000000000000000f R11: 0000000000000213 R12: 0000000000401a30
> > R13: 0000000000401ac0 R14: 0000000000000000 R15: 0000000000000000
> > Modules linked in:
> > Dumping ftrace buffer:
> >     (ftrace buffer empty)
> > ---[ end trace 25c60c4714d4e2ee ]---
> > RIP: 0010:div_s64_rem include/linux/math64.h:41 [inline]
> > RIP: 0010:div_s64 include/linux/math64.h:139 [inline]
> > RIP: 0010:__nbd_ioctl drivers/block/nbd.c:1242 [inline]
> > RIP: 0010:nbd_ioctl+0x53c/0xcf0 drivers/block/nbd.c:1303
> > Code: ea 03 80 3c 02 00 0f 85 1c 07 00 00 48 8b b5 c0 fe ff ff 48 63 8d b8  
> > fe ff ff 48 8b 86 c8 00 00 00 48 8d be c0 00 00 00 48 99 <48> f7 f9 48 ba  
> > 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c
> > RSP: 0018:ffff8801c90bf828 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: ffff8801ccb23c00 RDI: ffff8801ccb23cc0
> > RBP: ffff8801c90bf9a0 R08: ffff8801bc502640 R09: ffffed003a62d01d
> > R10: ffff8801c90bf818 R11: ffff8801d31680ef R12: ffff8801d3168000
> > R13: 00000000ffffffe7 R14: ffff8801d31680e0 R15: ffff8801d5730840
> > FS:  00000000015b2880(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000000043e560 CR3: 00000001b8034000 CR4: 00000000001406f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> Looks like NBD_SET_BLKSIZE is happy to just take whatever value.
> We should ensure that it's a power of 2, not zero, and bigger
> or equal than 512, but smaller or equal to PAGE_SIZE. Something
> like this?
> 
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 3863c00372bb..14a51254c3db 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1239,6 +1239,9 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  	case NBD_SET_SOCK:
>  		return nbd_add_socket(nbd, arg, false);
>  	case NBD_SET_BLKSIZE:
> +		if (!arg || !is_power_of_2(arg) || arg < 512 ||
> +		    arg > PAGE_SIZE)
> +			return -EINVAL;
>  		nbd_size_set(nbd, arg,
>  			     div_s64(config->bytesize, arg));
>  		return 0;

Thanks Jens, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
