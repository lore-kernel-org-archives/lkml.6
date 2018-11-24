Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C694C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A9620865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3jfoGXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A9620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeKYEJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 23:09:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43490 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYEJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 23:09:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id f4so12511331edq.10;
        Sat, 24 Nov 2018 09:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yxJ1FEF1VkyZypHsW/pLv5gAAgZ8QcaOz5xRC5xtlU=;
        b=I3jfoGXEHZlnJCUPTg65wtIz+8bgcZOwrukipXkJaCjUJQsUcwEkGYvNl/P2BAxxCk
         z7ifmsqMRNLGCLeOOMGnr1izLdLTdPmgZ20+3uhSx1N8upvkwQoZZE3MropfTRtA0Z/Q
         66YeslrjsbGf8uBgUwpbDTOLrD3v2udlRirsQ7puyLkhilCeKb6eOo1wnx6+8ymInECB
         b8WxIIxS/8Ht7bkOs104unIypSGQK6uBPk8wIRItOXx1LjyW4Rk4EzrYsCci0jY8tHkw
         P+IZt6JVcRHqrSb/0/D52fBhJDotxEj0SX3+S/EnTetiwqYxP0Y549L1RCHeASUmIbwu
         hqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yxJ1FEF1VkyZypHsW/pLv5gAAgZ8QcaOz5xRC5xtlU=;
        b=lmjq6ZnoH/v4o2e/jqUgg7/hRdqh8f6/sXOan9TvzJs2SZf9pNm9CP3+2X0bhLfKkd
         48OKnnH14L+/gS24nyNm8TrXLDSJqL3Ug0/NrVMzQs/cZUE2ZOdy0nTtGPfWv41tZfN5
         /ohro3sSk7OzCceFZwIxYsw+7NJq1T8Ep5iYc9BK7APQBAJOW3Sg10xm7MHuBn31rXpv
         KOxErYUOm4GRLrO7KaFaNHsXzgh+u+nSHUtfGz8Gtz8NrE+Umypm3wVocD3OIPO5ZHvx
         5htegYKKkhbWRoDu5UdXstYjy7uL/uVM8lMJdZ0pyjYm8fw/D8GC3KBYov7EQDUfIoEa
         y/1Q==
X-Gm-Message-State: AA+aEWbauO1it49prMdtRWxoGZSIulBf9MfriidE92Z4Rr5MSwjkd1wR
        uLRu/dYTGj+7anFK8IzDZUtm29KXNFtIuk2FUpc=
X-Google-Smtp-Source: AFSGD/UGnzJ5ZgcArIzzYD0OrNd9djgboR8nlu4raZXc3J90fTftBNOGfA6wy0fX3n+EDrsuKRLEDwtBkRG/GsViFkw=
X-Received: by 2002:a50:ae8f:: with SMTP id e15mr17621641edd.250.1543080058809;
 Sat, 24 Nov 2018 09:20:58 -0800 (PST)
MIME-Version: 1.0
References: <00000000000085abf7057b44ad08@google.com>
In-Reply-To: <00000000000085abf7057b44ad08@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 12:20:22 -0500
Message-ID: <CAF=yD-K0HwAbSK93b1aU0xjyepzoaiP2_qZ3L1nyEJAsbZqi-Q@mail.gmail.com>
Subject: Re: invalid opcode in ip_do_fragment
To:     syzbot+865704dc4f7ff5d1a04b@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 2:11 AM syzbot
<syzbot+865704dc4f7ff5d1a04b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    92b419289cee Merge tag 'riscv-for-linus-4.20-rc4' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12243093400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
> dashboard link: https://syzkaller.appspot.com/bug?extid=865704dc4f7ff5d1a04b
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+865704dc4f7ff5d1a04b@syzkaller.appspotmail.com
>
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 21078 Comm: syz-executor1 Not tainted 4.20.0-rc3+ #344
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:ip_do_fragment+0x2447/0x2ad0 net/ipv4/ip_output.c:776
> Code: ff 48 89 cf e8 2a 36 23 fb e9 dc ea ff ff 48 89 df e8 5d 36 23 fb e9
> 02 e7 ff ff e8 b3 36 23 fb e9 97 e6 ff ff e8 29 e7 df fa <0f> 0b 4c 89 f7
> e8 ff 35 23 fb e9 2f e6 ff ff 4c 89 e7 e8 f2 35 23
> RSP: 0018:ffff88818232e7b8 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff8881d3af0800 RCX: ffffc9000c0db000
> RDX: 0000000000040000 RSI: ffffffff869fa3c7 RDI: 0000000000000005
> RBP: ffff88818232e990 R08: ffff88816ba06580 R09: ffffed10342f86ca
> R10: ffffed10342f86cc R11: ffff8881a17c3663 R12: ffff8881d3af08c4
> R13: 00000000fffffff2 R14: ffff8881d3af08d0 R15: dffffc0000000000
> FS:  00007fa003fcd700(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004ccd10 CR3: 0000000199f89000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   ip_fragment.constprop.50+0x179/0x240 net/ipv4/ip_output.c:549
>   ip_finish_output+0x6b4/0xfa0 net/ipv4/ip_output.c:315
>   NF_HOOK_COND include/linux/netfilter.h:278 [inline]
>   ip_output+0x21d/0x8d0 net/ipv4/ip_output.c:405
>   dst_output include/net/dst.h:444 [inline]
>   ip_local_out+0xc5/0x1b0 net/ipv4/ip_output.c:124
>   iptunnel_xmit+0x63b/0x9c0 net/ipv4/ip_tunnel_core.c:91
>   ip_tunnel_xmit+0x15b8/0x3c04 net/ipv4/ip_tunnel.c:787
>   __gre_xmit+0x5e1/0x980 net/ipv4/ip_gre.c:451
>   ipgre_xmit+0x3e7/0xba0 net/ipv4/ip_gre.c:705
>   __netdev_start_xmit include/linux/netdevice.h:4356 [inline]
>   netdev_start_xmit include/linux/netdevice.h:4365 [inline]
>   xmit_one net/core/dev.c:3252 [inline]
>   dev_hard_start_xmit+0x295/0xc80 net/core/dev.c:3268
>   __dev_queue_xmit+0x2f71/0x3ad0 net/core/dev.c:3838
>   dev_queue_xmit+0x17/0x20 net/core/dev.c:3871
>   __bpf_tx_skb net/core/filter.c:2017 [inline]
>   __bpf_redirect_common net/core/filter.c:2055 [inline]
>   __bpf_redirect+0x5cf/0xb20 net/core/filter.c:2062
>   ____bpf_clone_redirect net/core/filter.c:2095 [inline]
>   bpf_clone_redirect+0x2f6/0x490 net/core/filter.c:2067
>   bpf_prog_bebbfe2050753572+0x7dd/0x1000

The syzbot dashboard has a longer trace, when looking at the log. This
includes a bpf program and probably bpf_prog_test_run.

ip_output.c +776 is a BUG at this commit

                /*
                 *      Copy a block of the IP datagram.
                 */
                if (skb_copy_bits(skb, ptr, skb_transport_header(skb2), len))
                        BUG();

Perhaps the BPF program managed to modify the packet in a way that
changed its length.

Either way, a bad packet in the egress path seems like a recoverable
bug that probably should not result in BUG().
