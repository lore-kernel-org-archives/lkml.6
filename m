Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1022C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F60C24241
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8gUpoAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F60C24241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeGDTT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:19:57 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42671 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbeGDTTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:19:55 -0400
Received: by mail-pl0-f65.google.com with SMTP id y8-v6so156395plr.9;
        Wed, 04 Jul 2018 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DhIwi68ugcDLxcHeMnMYX1VUBitc32G/Beu9H7QtQlI=;
        b=S8gUpoAqxIOoQNGItSBsBG/gQUILp2wfSr8D4FLP1AI9JN+kams2BntlXNKFHtjEah
         ydTkO6yiDQd713RW6uSyHyiYKXdlyV3mtUwXXOhEHs8vqeICMKyBpRtahCTAFJHztqcB
         q81AJADrdRD7i2w4BdGcavmLawKlrZa1ercUXLRQRLMx1j6ZqwPweMPGmrpyPd483zxn
         zJV8HnpEmN+xbDfdtcguv7QYdcgIx/UVlkgeQ7005VAvJ6COQcFKxiVn787zMkDSxW89
         8ZWDD3OJF1VoaGNBc8I71MBc+qznrDAHrc+kMWD5mxrG+zFN1GrmHcwyXBeRDCTyDq0o
         5T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhIwi68ugcDLxcHeMnMYX1VUBitc32G/Beu9H7QtQlI=;
        b=rMef4slw4xSXIUIGIG9exUmZWG+cJpmGmWPucLBt4esxOURfdmucH/BylmELwa4zYv
         JSooMyqr6rEeYFBecwlIbUc+XSXIhx0SsQo/x30J4TC5/eDJiCrK5oImJuReGMrvLa6x
         2xkdqsEcqPbPmP8ZBBJSXoLKUonp1INHlk6D4VzarNoGmfha4txz/4VepJ0vENN1F21Z
         kEn5rdYIjOuZSh8tofTpv4pUon2sJT5ym6wgeJtCEIehnge1VcElJ0/pGi9G2pZShvje
         lstfEyL4aOiTElmw/WyYsW4vO2ktQNg2qrMIJXx2fkUg0EkvgP0jqjXJXBT7ve8370yC
         b8Jg==
X-Gm-Message-State: APt69E18m6KB61V3Uz0YmB90aTbW4CQU2kZE7AYKeG/+EzYQY17OzJUH
        VJuJZcOWGeyfaAnCgodCPkU=
X-Google-Smtp-Source: AAOMgpeiIYNbCqcz8L9e21HOPEFm4E+ValBiVt89gt64U+wl6sk9sdQs7e1L2t2goDSjaraT4Z4S7w==
X-Received: by 2002:a17:902:2927:: with SMTP id g36-v6mr3190271plb.303.1530731994685;
        Wed, 04 Jul 2018 12:19:54 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id k13-v6sm14191152pfg.130.2018.07.04.12.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 12:19:53 -0700 (PDT)
Date:   Wed, 4 Jul 2018 12:19:51 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     syzbot <syzbot+6111d5bfd5605f7520cb@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in kernel_sock_shutdown
Message-ID: <20180704191951.GA725@sol.localdomain>
References: <001a11458fb4c130d50565e41374@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a11458fb4c130d50565e41374@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 08:59:01AM -0800, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> af3e79d29555b97dd096e2f8e36a0f50213808a8 (Tue Feb 20 18:05:02 2018 +0000)
> Merge tag 'leds_for-4.16-rc3' of
> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
> 
> So far this crash happened 15 times on
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/master,
> net-next.
> C reproducer is attached.
> syzkaller reproducer is attached.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6111d5bfd5605f7520cb@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> audit: type=1400 audit(1519334784.255:7): avc:  denied  { map } for
> pid=4107 comm="syzkaller141165" path="/root/syzkaller141165324" dev="sda1"
> ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 4107 Comm: syzkaller141165 Not tainted 4.16.0-rc2+ #324
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:kernel_sock_shutdown+0x29/0x70 net/socket.c:3250
> RSP: 0018:ffff8801c905fcc8 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff846006f4
> RDX: 0000000000000005 RSI: 0000000000000002 RDI: 0000000000000028
> RBP: ffff8801c905fce0 R08: 0000000000000000 R09: 1ffff1003920bf15
> R10: ffff8801c905f870 R11: 0000000000000001 R12: ffff8801c90267d2
> R13: 0000000000000002 R14: 0000000000000000 R15: ffff8801c905fd58
> FS:  00000000006e6880(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc70e02f000 CR3: 00000001ca694005 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  smc_shutdown+0x3ed/0x540 net/smc/af_smc.c:1268
>  SYSC_shutdown net/socket.c:1901 [inline]
>  SyS_shutdown+0x137/0x290 net/socket.c:1892
>  do_syscall_64+0x280/0x940 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x43fcb9
> RSP: 002b:00007ffde8479798 EFLAGS: 00000217 ORIG_RAX: 0000000000000030
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fcb9
> RDX: 000000000043fcb9 RSI: 0000000000000002 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004015e0
> R13: 0000000000401670 R14: 0000000000000000 R15: 0000000000000000
> Code: 66 90 55 48 89 e5 41 55 41 54 53 48 89 fb 41 89 f5 e8 dc 04 11 fd 48
> 8d 7b 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75
> 32 4c 8b 63 28 48 b8 00 00 00 00 00 fc ff df 49
> RIP: kernel_sock_shutdown+0x29/0x70 net/socket.c:3250 RSP: ffff8801c905fcc8
> ---[ end trace 187d9b346b4a5aff ]---
> Kernel panic - not syncing: Fatal exception
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title

This was fixed by commit 1255fcb2a655f0:

#syz fix: net/smc: fix shutdown in state SMC_LISTEN

This also had been reported here: https://bugzilla.kernel.org/show_bug.cgi?id=199429

- Eric
