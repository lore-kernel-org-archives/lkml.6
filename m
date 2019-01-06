Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E6FC43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 15:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E516B20859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 15:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTW+tCJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfAFPo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 10:44:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37649 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfAFPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 10:44:26 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so7203046iti.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 07:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jt1Op2qUk5ZeAXlGxnugwXC5LTtag5tIshqbzARd1kc=;
        b=lTW+tCJ2i5S6MzinTMSyp/aHgOQJZQxRb3qwxlvEFNq7Fh1o3oxuAXM0R8tebEp4PW
         RqL/nSn2bv6P+aH1G1HA7t4UT/jsg3i+/lmVF9rgeMJtTBU89cCUTuZFduB3/LLME+R5
         dQJiXB+x49zkuVPuicbwuO2cbeLoSE8Avl27ab4XBbfyzQt1AikPfKzI0re4TVXDJgit
         /KZu10fd3FMeY372KnpXZQ1YnDE/EuZ68hkPhnwRuY4Nb5A7BlywJTVUNw+qw10AvgaS
         Arch87ZqL0awCk5kcx41r5jiT+dnB5t9flsulHTZ7uYNRHru1JezDgJjf6MGIOwBYHXi
         DiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jt1Op2qUk5ZeAXlGxnugwXC5LTtag5tIshqbzARd1kc=;
        b=JGvnSC0ABdLkJYOWNiyQ0+FK7VKkpxH3rEWptYTLwFe9bLXnx4cbkM8Icl0RT798YH
         O19jsMM6hHRVmHqUcauvZip9nkHcS9M0T/GJDXQhKGY42Kq+OzcZjWn5jpsPgNkm2h8b
         BBZNmKFp6SRPWYR9HQa6Br5zpalHgD+wvFT5ShLGrbeUXqtZ7QGGqB4yM0p8RSV2lqi7
         BF3uFZCxSG0BOUoyF65qNoRGuu0ukJvmOt0JWeNPJ+u0NQWaOvWBsd+ts70ymzOqaFgt
         WtkmuHuD5TOwn4GnTV6MOsJDSz1iE+HSdo2Y70sroaoMAwU5Iaog2ZI5xx6ls6+M02HN
         AxYA==
X-Gm-Message-State: AJcUukfgi/s1LS5Zn9apVVOuAfacXXAL4qd5PQs0vWsiC2HaSdxQhIlH
        lLi1IAeXj9QaF8jwGFFKDxyJZasuRg0FMViiitCZNg==
X-Google-Smtp-Source: ALg8bN4qW4aH3LNlHDvqE9PZrmRjfkCJd9owY2xcF4nOthC1M8heMo2neE4rb1M2HzD5htTBcmbcJtET0i/MPsRsV6g=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr25771613jaj.82.1546789463911;
 Sun, 06 Jan 2019 07:44:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ae2357057eca1fa5@google.com> <CACT4Y+Y+dph0wyKOLffXMPFPsvbviYzfn1nrJJgOL1ngkQLtVw@mail.gmail.com>
 <40577a65-3947-aec9-3b82-ac71f150e586@I-love.SAKURA.ne.jp>
In-Reply-To: <40577a65-3947-aec9-3b82-ac71f150e586@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 6 Jan 2019 16:44:13 +0100
Message-ID: <CACT4Y+YLi95s04V0gNS1Vg15M0ey2eAQ4j6ADW3E30XfxAekoA@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in check_stack_object
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+05fc3a636f5ee8830a99@syzkaller.appspotmail.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 6, 2019 at 3:37 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/06 22:48, Dmitry Vyukov wrote:
> > On Sun, Jan 6, 2019 at 2:31 PM syzbot
> > <syzbot+05fc3a636f5ee8830a99@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    3fed6ae4b027 ia64: fix compile without swiotlb
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=161ce1d7400000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=05fc3a636f5ee8830a99
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >> userspace arch: i386
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b3769f400000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+05fc3a636f5ee8830a99@syzkaller.appspotmail.com
> >
> > I suspect this is another incarnation of:
> > https://syzkaller.appspot.com/bug?id=4821de869e3d78a255a034bf212a4e009f6125a7
> > Any other ideas?
>
>
>
> >> CPU: 0 PID: -1455013312 Comm:  Not tainted 4.20.0+ #10
>
> "current->pid < 0" suggests that "struct task_struct" was overwritten.
>
> >> #PF error: [normal kernel read fault]
>
> >> Thread overran stack, or stack corrupted
>
> And "struct task_struct" might be overwritten by stack overrun?
>
> The cause of overrun is unknown, but given that
> "fou6: Prevent unbounded recursion in GUE error handler" is not yet
> applied to linux.git tree, this might be a dup of that bug.


#syz dup: kernel panic: stack is corrupted in udp4_lib_lookup2
