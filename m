Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530E6218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9704N+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfAWVeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:34:03 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38063 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfAWVeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:34:02 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so2906321ede.5;
        Wed, 23 Jan 2019 13:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqNmfCLdxg8dZkPJvM8nDDSKgrdUES18R7NP6odmBO4=;
        b=i9704N+BIX7XWOwkz7DJbr8MulRqdsY2otMP+UDGwF8JMjgWC06ppGtMFWfiLJBM4q
         zogHFkU3VcH2KHMdsyZwcEjKM2uTX0zZxFxWL0/O4zW9ZCvZcbGGUKWTJbDLrK9Ay/uM
         FIoQPYYdYiQzYG4TgTVaG346+vKY+wkKNHFq1hYV4lGTmPpjWM7I/NJYI0xcC3ReQn2X
         gPoep9CvHz2mwbrrJvci1zIZ3fneUK5VLyOIpIn/653mNkhqJefX6wiS01FVoFQyLlmM
         0x7hkwazZoyc4nQJK7C3lODcRqvKgYhUA+3BNQPZoFS49BFEfqmlQf9/vFW8omo+WSul
         Gv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqNmfCLdxg8dZkPJvM8nDDSKgrdUES18R7NP6odmBO4=;
        b=AGY+1tdsMEVATRgi8dsBkHKkmMFJds+LL2RFDFN5z2sqCj++vd3owRPIGOzld0y2qb
         SlJZcXvHpNFlGasylFKDFkF2vSnfRL1wFOBFMK09FjZJDkQEjN6O+WdVBOBaDRlATOxl
         hciwpbXKEAVhO1ecLX+6fuWO6jkZYDEoXhWazM7YrYpgu6YnnESVLBy+HubkKglZS8KQ
         IIOb2aYrTNOnw2Bn4aa4+SBAks6UrMycmODo5BdSSRTbABg3rwzORFej9MryQvVhgfcW
         gaG3HYVAW/SC2LAvVOaW0H4x4t102m408qwJsW9OglKHfcdC8v498ojwCGOj4nnlCpZn
         kEHg==
X-Gm-Message-State: AJcUukfSKLl319lCyCPc2pKZti1FtDThWYvyAi35Eq2uiRk6YVGod5+S
        kRlr4nwI76v5Zw//MriM4njpheMPP674UsZuQK8=
X-Google-Smtp-Source: ALg8bN61nxmSyzBiuh/TaJrug9gDitfTdfRp4JP8VPpFgqYcB8Pf1JvM0YzWHVWYrqZaQ3DiK2tyAmSp/nUXPbTOAqg=
X-Received: by 2002:a50:ac81:: with SMTP id x1mr4228663edc.71.1548279240564;
 Wed, 23 Jan 2019 13:34:00 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamsix7hdT7d3qvZ1mVEFJ+OV-pxCX4Xzc4gWFA4_7YKRQw@mail.gmail.com>
In-Reply-To: <CAEAjamsix7hdT7d3qvZ1mVEFJ+OV-pxCX4Xzc4gWFA4_7YKRQw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 23 Jan 2019 16:33:24 -0500
Message-ID: <CAF=yD-KcnV=89eE1Y2Cx4nXUrazHP7MsuirMZKAKfq1n62b=fw@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in net/ipv4/ip_output.c
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 2:25 PM Kyungtae Kim <kt0755@gmail.com> wrote:
>
> I'm reporting a bug in linux-5.0-rc2: "UBSAN: Undefined behaviour in
> net/ipv4/ip_output.c"
>
> kernel config: https://kt0755.github.io/etc/config-5.0-rc2
> repro: https://kt0755.github.io/etc/repro.b6a11.c

Thanks for the report.

That reproducer does not seem to exercise system call sendmsg. Did you
mean to share another? Perhaps one that users SO_SNDBUFFORCE or
sysctl_wmem_max.

When constructing a reproducer, I did easily trigger an UBSAN warning
when setting SO_SNDBUFFORCE to INT_MAX - 1, so I can imagine that this
one can trigger, as well. As long as sk_sndbuf can be set to any
integer value, we'll have to be careful with any such multiplication.

> Integer overflow happened in __ip_append_data() when 2 * sk->sk_sndbuf
> (at line 1004)
> is larger than the boundary of the destination (i.e., int).
> Some sanity check code right before it would help.
>
> =========================================
> UBSAN: Undefined behaviour in net/ipv4/ip_output.c:1004:11
> signed integer overflow:
> 1282607372 * 2 cannot be represented in type 'int'
> CPU: 0 PID: 8465 Comm: syz-executor4 Not tainted 5.0.0-rc2 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xb1/0x118 lib/dump_stack.c:113
>  ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
>  handle_overflow+0x1cf/0x21a lib/ubsan.c:190
>  __ubsan_handle_mul_overflow+0x2a/0x35 lib/ubsan.c:214
>  __ip_append_data+0x30ed/0x3350 net/ipv4/ip_output.c:1004
>  ip_append_data.part.18+0xf3/0x170 net/ipv4/ip_output.c:1220
>  ip_append_data+0x63/0x80 net/ipv4/ip_output.c:1209
>  raw_sendmsg+0xd99/0x2b60 net/ipv4/raw.c:670
>  inet_sendmsg+0xfc/0x620 net/ipv4/af_inet.c:798
>  sock_sendmsg_nosec net/socket.c:621 [inline]
>  sock_sendmsg+0xdd/0x130 net/socket.c:631
>  ___sys_sendmsg+0x7b3/0x950 net/socket.c:2116
>  __sys_sendmsg+0xfc/0x1d0 net/socket.c:2154
>  __do_sys_sendmsg net/socket.c:2163 [inline]
>  __se_sys_sendmsg net/socket.c:2161 [inline]
>  __x64_sys_sendmsg+0x83/0xc0 net/socket.c:2161
>  do_syscall_64+0xbe/0x4f0 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4497b9
> Code: e8 8c 9f 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 0f 83 9b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f0d0100bc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f0d0100c6cc RCX: 00000000004497b9
> RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000013
> RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000000089a0 R14: 00000000006f1a40 R15: 00007f0d0100c700
> =========================================
>
> Thanks,
> Kyungtae
