Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7B21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7ub41lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfACVPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:15:48 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38705 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfACVPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:15:48 -0500
Received: by mail-yb1-f195.google.com with SMTP id x9so4991003ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 13:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyBYLPw2/2zwS3YTuZCUVEH+kVTNfgI6zETlsjimHIo=;
        b=C7ub41lg7LwquGwKceXYsYj3WSgI0y/V036FnJNUxnMUfDHnSZAIgYp/CRQVC7nyVK
         oGRJJlwAZP/Ah4ETJmE6824jo8RN3xTYEnq+b+sut2Y8xJOKR93s1DvnD08IBiZF77Pm
         0MRJnf5NJg4D0oPybduDEfjFDvyt7rLJoPeckqk/7V17Aw8JhxgN7AfkOdOLBV85DR1L
         UO+EMWJqOeZA80bwt75HbPBGDBBpL/oiqJe1wHUqI4pjH7FV1tBovf/bWmbq6q7CjLsL
         u1+cAZLSmB2sT+z+261AQMH3Sw+ErEfqoVTL3v164HorcRw0xPDXhYGkL4g3gOW/07+F
         RM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyBYLPw2/2zwS3YTuZCUVEH+kVTNfgI6zETlsjimHIo=;
        b=MDAvtCkGlJZsDnh7yG2wArxepQFHufVlZZeM/Dy3VVZKHp7SOZbW8QhFBS+nMt08Oc
         /OxDNyn9QthZuQsX7Cm092QF3OOyFaIG0G7Rr8KDwon16bz2etKSbdRvm3QC7rOtjPJT
         RqPw/YkALgKxtLGDu9ZHIiz2iexbpismbQlM2Pz89rfuCI+u+43ZAxNIgVTczwTzxwRT
         W1tTyjBeVUO3EBJykkxe9dM2Wr36zxqF9o+f+K9MTyqkEDbIe6xMTMxQUuloypJws5uW
         KYWUxHN+9ugUghdfUdUpfx2wkubFWo1ZM4+nTTNWxCD2BYxZU56y09u87iz5BXlKl1cA
         FEtQ==
X-Gm-Message-State: AJcUukdSlAQS/vyCY3bhrKp5neAc7uVAMe3OYGSL/yv6tLSUlJooY2IX
        o7WV0lQ94318VaLjsXtSr1rxyfjdRC0=
X-Google-Smtp-Source: ALg8bN78/2lZTPLHcwu+oVz9O4BcNmv6267FIrwI0xFPzUCziXkhpsIfOO/62Z/h8fciSSzGZYisOg==
X-Received: by 2002:a25:4255:: with SMTP id p82mr34003550yba.46.1546550146447;
        Thu, 03 Jan 2019 13:15:46 -0800 (PST)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id n16sm23278760ywn.31.2019.01.03.13.15.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 13:15:45 -0800 (PST)
Received: by mail-yw1-f43.google.com with SMTP id t13so13760534ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 13:15:44 -0800 (PST)
X-Received: by 2002:a81:9184:: with SMTP id i126mr50104769ywg.371.1546550144403;
 Thu, 03 Jan 2019 13:15:44 -0800 (PST)
MIME-Version: 1.0
References: <000000000000513fb7057e8d7013@google.com> <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
 <20190103210743.6518841e@redhat.com>
In-Reply-To: <20190103210743.6518841e@redhat.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 3 Jan 2019 15:15:06 -0600
X-Gmail-Original-Message-ID: <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
Message-ID: <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 2:07 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Thu, 3 Jan 2019 12:01:29 -0800
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> > On 01/03/2019 05:07 AM, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    195303136f19 Merge tag 'kconfig-v4.21-2' of git://git.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12245d8f400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5e7dc790609552d7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com
> > >
> > > protocol 88fb is buggy, dev hsr_slave_1
> > > protocol 88fb is buggy, dev hsr_slave_0
> > > protocol 88fb is buggy, dev hsr_slave_1
> > > FAT-fs (loop0): invalid media value (0x00)
> > > FAT-fs (loop0): Can't find a valid FAT filesystem
> > > Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: udp4_lib_lookup2+0x7ea/0x7f0 net/ipv4/udp.c:455
> > > CPU: 1 PID: 17960 Comm: syz-executor2 Not tainted 4.20.0+ #176
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > > Kernel Offset: disabled
> > > Rebooting in 86400 seconds..
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> >
> > Maybe commit 11789039da536fea96c98a40c2b441decf2e7323
> > Author: Stefano Brivio <sbrivio@redhat.com>
> > Date:   Tue Dec 18 00:13:17 2018 +0100
> >
> >     fou: Prevent unbounded recursion in GUE error handler
> >
> > Forgot to deal with IPv6 ?
>
> Damn, yes. :( Thanks both for pointing that out, patch coming.
>
> Still, I can't be sure this is the same issue.

syzbot generated stack traces with

[  183.517380]  udpv6_err+0x46/0x60
[  183.520739]  ? __udp6_lib_err+0x1890/0x1890
[  183.525054]  gue6_err_proto_handler+0x199/0x280

so it is quite likely
