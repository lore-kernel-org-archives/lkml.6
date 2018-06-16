Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC9C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEAC208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmY+RDB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEAC208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbeFPPgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:36:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39544 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754147AbeFPPgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:36:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id r11-v6so6201903pfl.6;
        Sat, 16 Jun 2018 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R1oJtjgSkJUMerLIs+M/Lw0lDomuX9qAKC8bDSIIP7w=;
        b=YmY+RDB7QIgqUd7SslRAR8ltwamNXc5Nyv3kI0MIeag/guOc2GzhWP674l7cPh5OBG
         YK/9IEKRcKsEwGFw6a3YCVbNVKmWQniUinRpw3AmLzaUfY6xPr+1VvlCrOoPnin/rtCR
         1QEwGNO/6zDUJQqLzFNLogCySlwJyo4Rrvl5TDSN0aLA3CvZNm/kOENPnoiKDALxQLHf
         P6mVshuz4WG8tTuby2mOpjgfZ3N+KEHJ5ixktOvo9p9C/Y6msqDDYYbw6Gl125VTsAX2
         yUtyIk1FMxIvl5lFN5AzNxNr5Dj/0h2pqg3Yk1LLr0YRCPL17CI4zdPE0U8G9zLHHqIM
         Hh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R1oJtjgSkJUMerLIs+M/Lw0lDomuX9qAKC8bDSIIP7w=;
        b=ZQsyLD/ijWXAojiTOVs97LPbF9HiLpYotk1fTtvbKfvNi3AdSo9yttkrLjKHvPuIkb
         HHeQClbPvD+GlCmrC2Wvzz0xPormpMvR0CSJuOxj4ABKr91W85irOWcb2um6ZIzl0uSh
         xPmDpm9cVqMItbnnwtQbrj9RcQQchQNY1J6HUfkAdZ0HRLODf8LFgWOhR+iekr2Tjf//
         UBuhpdM0tg4qZ1RsTA9AJHIMG4/6XLRMFpOHGnfqc1NSqM1EXinTeX0+z6yvHx3CYb7L
         yfSCjC7rhv6nyxfZ3F2H38AsdYN0bIukzz0BzGxqQB3nfbOFapHXwhVvSD7YuOPRIvcs
         kr9g==
X-Gm-Message-State: APt69E3Ugavh4lksgLXlLaT06C60hmPSIi6FgxGS7yc6ieYYpmQ7Lj7y
        /+/Fm0S+S/Y83ow7ODoFx2Y=
X-Google-Smtp-Source: ADUXVKLVStB29dGD4e0YKXi8ayhYDAU5KvLyf7h1E4riWyGj5HT1PcZKhtDhK3+GN/77TaOapOe1zA==
X-Received: by 2002:a62:90db:: with SMTP id q88-v6mr6779982pfk.186.1529163370826;
        Sat, 16 Jun 2018 08:36:10 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id h124-v6sm25414204pfc.100.2018.06.16.08.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 08:36:10 -0700 (PDT)
Date:   Sat, 16 Jun 2018 08:36:08 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     syzbot <syzbot+264bca3a6e8d645550d3@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: slab-out-of-bounds Write in vmac_final
Message-ID: <20180616153608.GA684@sol.localdomain>
References: <000000000000f7b199056ebfc5ef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f7b199056ebfc5ef@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 03:27:02AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    8efcf34a2639 Merge tag 'armsoc-late' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b9503f800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3de185e943e1d12f
> dashboard link: https://syzkaller.appspot.com/bug?extid=264bca3a6e8d645550d3
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=158bc21f800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12506eaf800000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+264bca3a6e8d645550d3@syzkaller.appspotmail.com
> 
> ==================================================================
> kasan: CONFIG_KASAN_INLINE enabled
> BUG: KASAN: slab-out-of-bounds in memset include/linux/string.h:330 [inline]
> BUG: KASAN: slab-out-of-bounds in vmac_final+0x161/0x26a0 crypto/vmac.c:611
> Write of size 18446744073709551516 at addr ffff8801ac760f0c by task
> syz-executor345/4580
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> 
> CPU: 1 PID: 4580 Comm: syz-executor345 Not tainted 4.17.0+ #98
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
>  memset+0x23/0x40 mm/kasan/kasan.c:285
>  memset include/linux/string.h:330 [inline]
>  vmac_final+0x161/0x26a0 crypto/vmac.c:611
>  crypto_shash_final+0x104/0x260 crypto/shash.c:152
>  shash_async_final+0x35/0x40 crypto/shash.c:252
>  crypto_ahash_op+0xcf/0x180 crypto/ahash.c:362
>  crypto_ahash_final+0x57/0x70 crypto/ahash.c:367
>  hash_sendmsg+0x750/0xac0 crypto/algif_hash.c:126
>  sock_sendmsg_nosec net/socket.c:645 [inline]
>  sock_sendmsg+0xd5/0x120 net/socket.c:655
>  ___sys_sendmsg+0x805/0x940 net/socket.c:2161

I have a fix for this almost ready to send out, but I need to do a bit more
testing.  I'll send it out soon.  (The bug is that the VMAC template doesn't
separate per-request state from per-tfm state.)

Eric
