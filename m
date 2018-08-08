Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748A6C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2652D208B9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gACIb7mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2652D208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeHHVTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:19:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34152 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHHVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:19:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so1597284pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nh7pAW00BDoO8puO5mMd6HOzAj+IsnADYNAdnVcvido=;
        b=gACIb7mwxG9IsOmijYX9MoaV+QaFOFBv3My/VwCcKwi/HMZMCPUlHweDzB/bGzG4Yf
         D8tdrRxCz4uVWpWwhbrCBCOsUAccm04zEZos2HuA4KLelq3IZyedzd+GrkexXWFG32WM
         jgLuCea/pV+tpohYiB7EjtAflEBNHlV9Pzux6Wi4ScIZIiBAcEQZr4QIO4xmrPuMHJaC
         NRwxLE8MkSeEtAZpUK3IbFOlaiJN+vkXIHMLFWFWkRzphwQAINZZy1zw1LtJZZpFs8+7
         m8PmDtw4lKl/Nshz+8nhhZ+kCx8nGYnHixjqkM5G8tQtby06OaCpEfj9dWLurwWwTEyH
         ANhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nh7pAW00BDoO8puO5mMd6HOzAj+IsnADYNAdnVcvido=;
        b=VN2wSaP5zxtqbuKAuLTJgg93XFd0WFJvVgrla1fJGzEVaBjNwPEFWZQy1wqjUiV4kS
         zTCQ1MSnlM1EYzJOSsfPhKeWMQ4uEfJx+LBdCBAmaU4dYIHXKkkEV3VJx9QHyMEH0ePj
         sAVDyrbtCa6yw1HYven8K+awzq1wXFUaymiLbMrVPg/hk+wO5U2ZATxymRIO0mlXe/U9
         vyPBAxx8eI8pdoCE9H/knB6r1FOL/GjGPgnS7Pli4YM752tHykJixLLd7VsNLRMgNH9E
         wQgqSrqTDJ6MzqfLeVDFQW+x6pq7MmUZ4jvc+Ry17br4kUJngnCPdfEX21+HrOG+1bD1
         wjdw==
X-Gm-Message-State: AOUpUlHrD6vgry/CaDAn18e8GZgsikTN7uacJMhBSXCP236fXL8gIesr
        ACUn+EOSc24uB9Pp93Ta+i8TOga1gawi769FOk+u3Q==
X-Google-Smtp-Source: AA+uWPw04BVPakGnKV2MI3m3ayf59Lb97BoGZprLC+PgqIxlIqB+UyBptAoh4jINM4To37VqEgjlG0CEQd+Vydf00gs=
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr3730225pgp.334.1533754713405;
 Wed, 08 Aug 2018 11:58:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 8 Aug 2018 11:58:12
 -0700 (PDT)
In-Reply-To: <CAAHj5qiQNOfD2c_xHw4sqQOGR3BNvYGncdg2fdgogcFz9u5peA@mail.gmail.com>
References: <000000000000c242e90570aa0062@google.com> <CA+55aFyEZR=v2GySzWWF3uh9ZB53CFFv460Wzg4n8DGze8GFfw@mail.gmail.com>
 <CACT4Y+bOJx+SnkMqzDDUTU1iztQ7DpMBG7Z-oV5wArRaSEzh+Q@mail.gmail.com>
 <CA+55aFz1GVHUGiX1SE_5C-e9LdXdx3pBB10zwga1LOy6axk5Ww@mail.gmail.com>
 <CACT4Y+bvGNmjP+3z3uzm=SvnngkbtEx-JeT6iVWg4gwYvoKyLQ@mail.gmail.com>
 <bcbcb69b-5d46-4e3d-852a-73e1345586e8@googlegroups.com> <CACT4Y+aHEqv+-4YbNWAHX53U+54T+fzMyVxjWB_iF1EDZBZXjQ@mail.gmail.com>
 <CAAHj5qiQNOfD2c_xHw4sqQOGR3BNvYGncdg2fdgogcFz9u5peA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Aug 2018 20:58:12 +0200
Message-ID: <CACT4Y+a2uLxm=iSt7FX_N7PBDunZ+fr=kxPMKeW+JLCjWSynkA@mail.gmail.com>
Subject: Re: general protection fault in in_aton
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     randy.dunlap@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 8:36 PM, Tomas Bortoli <tomasbortoli@gmail.com> wrote:
> Hi Dmitry,
>
> This patch has already rdma in:
>
> https://lkml.org/lkml/2018/7/27/484
>
> Sorry I forgot to flag the v2.

Ah, great!

Then let's mark this bug as a dup of that one:

#syz dup: general protection fault in p9_fd_create_unix


> 2018-08-08 17:56 GMT+02:00 Dmitry Vyukov <dvyukov@google.com>:
>>
>> On Wed, Aug 8, 2018 at 12:43 AM,  <randy.dunlap@gmail.com> wrote:
>> >
>> >
>> > On Wednesday, July 11, 2018 at 9:48:02 AM UTC-7, Dmitry Vyukov wrote:
>> >>
>> >> On Tue, Jul 10, 2018 at 10:15 PM, Linus Torvalds
>> >> <torv...@linux-foundation.org> wrote:
>> >> > On Tue, Jul 10, 2018 at 12:57 PM Dmitry Vyukov <dvy...@google.com>
>> >> > wrote:
>> >> >>
>> >> >> Is it really hard to get fault address? I know that userspace
>> >> >> generally receives fault address in siginfo.
>> >> >
>> >> > For an actual page fault it's trivial.
>> >> >
>> >> > However, for invalid addresses (aka "non-canonical"), you don't even
>> >> > get a page fault, you get a GP like in this case. And then the actual
>> >> > address is not available.
>> >>
>> >>
>> >> I see. Then I don't have any great ideas. Running without KASAN would
>> >> result in more, much more cryptic crashes.
>> >>
>> >> FWIW for these "GPF could be caused by NULL-ptr deref" I first just
>> >> assume that it's in fact a NULL deref. And in this case it all pretty
>> >> quickly forms a consistent picture that it's indeed just a missing a
>> >> NULL pointer check. That dffffc0000000000 in a register also a good
>> >> hint.
>> >
>> >
>> > The second mount syscall in loop() has a pointer parameter of 0 (null):
>> >       syscall(__NR_mount, 0, 0x200000c0, 0x20000340, 0, 0x20000180);
>> > and that NULL is passed from do_mount() to do_new_mount() to
>> > vfs_kern_mount()
>> > on to mount_fs() to v9fs_mount() to v9fs_session_init() to
>> > p9_client_create() to
>> > rdma_create_trans() and then to in_aton().  Are all of those valid up
>> > until
>> > the
>> > call to in_aton()?
>>
>> Hi Randy,
>>
>> +kernel mailing lists again
>>
>> Please keep kernel lists and developers and CC, there are no kernel
>> developers on syzkaller-bugs@ list.
>>
>> This is almost the same as "general protection fault in
>> p9_fd_create_unix" just for rdma:
>> https://syzkaller.appspot.com/bug?extid=1a262da37d3bead15c39
>> Yes, this function needs to check for NULL.
>>
>> Tomas, I think it makes sense to include rdma into your "9p: fix NULL
>> pointer dereferences" patch.
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/CAAHj5qiQNOfD2c_xHw4sqQOGR3BNvYGncdg2fdgogcFz9u5peA%40mail.gmail.com.
>
> For more options, visit https://groups.google.com/d/optout.
