Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0241C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750B9213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ug0k8+Hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750B9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJHXXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:23:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41603 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHXXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:23:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id x31-v6so3368027edd.8;
        Mon, 08 Oct 2018 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yBkSMFIKQ4AjVNmMUzSE1LxxjNokt3Qz8qtT938+9g=;
        b=ug0k8+Hc9/IdzQIa2WG4wIPuhsLMwtMR/r0NfPUbEH2nHeyv71uVyjpV/KiGCwEbb3
         MVCL5LNiY1s8hCNdVqwTG/v1qdzw1Y3eT19+MPth5cRSx/fG55t45lgxC024olT+/Oqv
         TKztJFaQ48G1SLQZKyd/nVEMjifSS4fdse388UjLvFzigXjhKJz1ZDf8Lx3fhOtEalys
         KFONgs0dtaAj+N7isZwrfPhlw+ygiSUkeQStgGa7R/sUJOCqfEA6cHk075zEkr2vNeoV
         /SRkguJ0j6KVkHtA1uzdr1AFCR4xOK8D1SZwzL6S4DT3wh4/vgqaZ3TmmGxfFySJZRi3
         /XQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yBkSMFIKQ4AjVNmMUzSE1LxxjNokt3Qz8qtT938+9g=;
        b=qGAs5SjareVa+cO7QSYIEUAD+Pk49Xmk1X6FzeZNwvl5Gonvbnmm6mUkWGjcEh8ZDN
         jMmLdt/zTkKoDc5gB4pxnwTKqdKXNIG5M4depJbBnLUFswlzvEkeirjbQWS4IdbDA8OU
         zfQEuCA0Ho3+XcJPVq3rb/XtP/CJx3qSThnwAvz3Jw36iQjC2pUT8XbWSkER62MCNZ+s
         23nOS52SKwClFW5Oro7O8yYRRtQzi4YChz3n2KhU95gERrPqHffNy+PKZSNlAgR/qD0g
         CZnHjuipd236/GV2ZVuSH0YOFH98GfefrKZSKTb6al2tw5B/p5Eghj/dMmKJpgWuPEhK
         3/oQ==
X-Gm-Message-State: ABuFfoiMRwIZMcWHhYGTxR8ZY6os0WHzh+F9Lsh8UxiIpPEFiAV1P49W
        PbhdJwytqxEqNEf7xBjPmxMFyCNmWidI/Gsre8M=
X-Google-Smtp-Source: ACcGV624SbThifqGs1Xk+8fR7xTIbf+SLxTUj5PUesVVLcf+MiC9o2f0ovzuoU4lxRb+KBi0xytbUhC88YNxaPsgj28=
X-Received: by 2002:a50:8ba2:: with SMTP id m31-v6mr31365272edm.260.1539015063684;
 Mon, 08 Oct 2018 09:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009d47b2057782bab4@google.com>
In-Reply-To: <0000000000009d47b2057782bab4@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 8 Oct 2018 12:10:27 -0400
Message-ID: <CAF=yD-+7NxN37Ez=3WXG0+2i6j30uSV8u9D7oJXEhp+SxzYCpA@mail.gmail.com>
Subject: Re: general protection fault in __handle_mm_fault
To:     syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 6:27 PM syzbot
<syzbot+1577fbe983d20fe2e88f@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    25bcda3e8b9f Add linux-next specific files for 20181004
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=130e3bf1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=603d7f9140c3368a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1577fbe983d20fe2e88f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127e88d6400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cdb67e400000

> RIP: 0010:copy_user_enhanced_fast_string+0xe/0x20
> arch/x86/lib/copy_user_64.S:180
> Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 1f 00 c3 0f 1f
> 80 00 00 00 00 0f 1f 00 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3> a4 31 c0 0f
> 1f 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 83
> RSP: 0018:ffff8801bbe675b8 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000007a50 RCX: 0000000000001b40
> RDX: 0000000000007a50 RSI: 0000000020077000 RDI: ffff8801ce615f10
> RBP: ffff8801bbe675f0 R08: ffffed0039cc2f4a R09: ffffed0039cc2f4a
> R10: ffffed0039cc2f49 R11: ffff8801ce617a4f R12: 0000000020078b40
> R13: 00000000200710f0 R14: ffff8801ce610000 R15: 00007ffffffff000
>   _copy_from_iter_full+0x263/0xc20 lib/iov_iter.c:724
>   copy_from_iter_full include/linux/uio.h:124 [inline]
>   skb_do_copy_data_nocache include/net/sock.h:1951 [inline]
>   skb_copy_to_page_nocache include/net/sock.h:1977 [inline]
>   tcp_sendmsg_locked+0x159e/0x3f90 net/ipv4/tcp.c:1338

This started on next-20181004. It still happens as of next-20181008.

It does not trigger on next 20181003. It does not occur if
CONFIG_DEBUG_KOBJECT is disabled.
