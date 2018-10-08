Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C4C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55F42145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWU5MzAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55F42145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJIDrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:47:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44538 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJIDrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:47:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so14333498edb.11;
        Mon, 08 Oct 2018 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLYREqCwoOUDRNmHy6re3it3EJQGZ7DS9UEqRUzQpM4=;
        b=CWU5MzAq6QbM6Z+uZzV1OHym0UUjgSKi3Up4w5TEZSwvlZVLnhLJ3tu//4bzYv2/62
         n1RxE3FRmuorfqyj6tL+PdArmsOHTvkwfXkETp70pGkIt+1Ah7sz1+64DGNxFu/0I3rf
         CWuCN8DGroLtAa2cC7lc8oX96ksvOPbiHLNely8ubNZbdOdTwyKe7dWFwpS0oHx9H16R
         4u9fHeh11HVvr7QbH3Jhi9+SfhTtwiQqq+BFTwOHpI1r/96jn+a1NB1DPEw2J/5KHsTs
         XQGlx1wW+BIzSAYekoK6Y9O5LTnORNDkU8VN26rwh+j/MOgBgLqmtIR1p0SXEVfZO6HH
         ueqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLYREqCwoOUDRNmHy6re3it3EJQGZ7DS9UEqRUzQpM4=;
        b=IYXYrzrriFVaJ/yeMeOsvYyaWoAUrP72qRTxkCYwe+aEQ6RfocK3bJopJmQjDu5qIS
         7q/c/Y1X6n7Vbpp12oTFKCJ36Api/3ApR9IAUxVZu1tBbN7/s6bQMKSVjIftAiyLpOTf
         sUp9wcoJ3ftV7r192L2VJzodUtHqZOUBzdlWhBXQQpvOjCw8wLq6wNCXN4Ph1JMOa9QB
         4X+EQmTlb9YojnGUD7F+3JCdk8ZrLmIxnoeREzZ/POCJLoDWWekLF+Tt4qQM24Y+03D+
         mPCtdQcrGj6sPHexFn/HHhQ+xtDeLbZvW45uHM5SDL2Wobll6cKPVTJ4D16jIgjVTQCW
         POKw==
X-Gm-Message-State: ABuFfogeX0M54ccInaaF02+SP4hJWXi01A1PfQlZ+Bf530HDwFehjoGp
        tC6kUxMTjlPXXbuG9rkHgB5mSHHBnGLueakbgvM=
X-Google-Smtp-Source: ACcGV61LrH6L8CpBcxR1LCDbzTNtWMDuIQbAS5a+cb06ZUGvrlf3E7hlxP9s/LV/9+1F0e2xjCBcGyBSeZovQkXAq7g=
X-Received: by 2002:a50:b704:: with SMTP id g4-v6mr31822787ede.139.1539030840996;
 Mon, 08 Oct 2018 13:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009d47b2057782bab4@google.com> <CAF=yD-+7NxN37Ez=3WXG0+2i6j30uSV8u9D7oJXEhp+SxzYCpA@mail.gmail.com>
In-Reply-To: <CAF=yD-+7NxN37Ez=3WXG0+2i6j30uSV8u9D7oJXEhp+SxzYCpA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Oct 2018 16:33:24 -0400
Message-ID: <CAF=yD-+Qh5f9kqmYLY5EyUwNPuyhMpBxz6dh_kfzFZsgE3UijQ@mail.gmail.com>
Subject: Re: general protection fault in __handle_mm_fault
To:     syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 12:10 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Oct 5, 2018 at 6:27 PM syzbot
> <syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    25bcda3e8b9f Add linux-next specific files for 20181004
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=130e3bf1400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=603d7f9140c3368a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1577fbe983d20fe2e88f
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127e88d6400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cdb67e400000
>
> > RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20
> > arch/x86/lib/copy_user_64.S:180
> > Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f
> > 80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f
> > 1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
> > RSP: 0018:ffff8801bbe675b8 EFLAGS: 00010202
> > RAX: 0000000000000000 RBX: 0000000000007a50 RCX: 0000000000001b40
> > RDX: 0000000000007a50 RSI: 0000000020077000 RDI: ffff8801ce615f10
> > RBP: ffff8801bbe675f0 R08: ffffed0039cc2f4a R09: ffffed0039cc2f4a
> > R10: ffffed0039cc2f49 R11: ffff8801ce617a4f R12: 0000000020078b40
> > R13: 00000000200710f0 R14: ffff8801ce610000 R15: 00007ffffffff000
> >   _copy_from_iter_full+0x263/0xc20 lib/iov_iter.c:724
> >   copy_from_iter_full include/linux/uio.h:124 [inline]
> >   skb_do_copy_data_nocache include/net/sock.h:1951 [inline]
> >   skb_copy_to_page_nocache include/net/sock.h:1977 [inline]
> >   tcp_sendmsg_locked+0x159e/0x3f90 net/ipv4/tcp.c:1338
>
> This started on next-20181004. It still happens as of next-20181008.
>
> It does not trigger on next 20181003. It does not occur if
> CONFIG_DEBUG_KOBJECT is disabled.

Bisected to commit e4d0c281a4c9 ("mm/memory.c: recheck page table
entry with page table lock held").

Verified to not trigger on next-20181008 after reverting that commit.
