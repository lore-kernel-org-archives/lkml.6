Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF9FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049DB21473
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jimiDign"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049DB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbeHHSRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:17:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38168 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbeHHSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:17:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so1292641pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D4k5d6W8Xw0GrL+UWrfLJZPlaaPQOpGEgYYYKrDbb6A=;
        b=jimiDignnuzkWomWqzpI89WAxjanomST1c8DKr1Rxxp+Rlmx6gIKjqdmECH/GIEN5A
         YWRiXJdyyvM0OeLosSb8Ws0iWLzwu3HxrFVma08fUkNn6TBiZuKoPST3ANUfvXWpWSZW
         ORernSIYaEFaFSG7l7GljDx9OdLjRBMcxJ9A2AuPna3tu1R/PveRYY8wG85s83ogIH5P
         jHo7rwgxbJHUiOlJq0Qp/whKiUrUzfioEhNwZHEU/6vSB4spIh9ZwXKB+rNdRrxYcWBy
         YTyws3kbz8s7MrMFWYAn8hulF+GALikMQBQgBV6AW1qI4Z3n11LNVcTA32rBDDpBJeOl
         FY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D4k5d6W8Xw0GrL+UWrfLJZPlaaPQOpGEgYYYKrDbb6A=;
        b=ZF8dtnQUKox6uLmSYfi7IihNw5A6OcS0B0hRM8Gj66HJGjoO1wIRxGVrHU3t+q+S/w
         NEWj6SYASasqblvzKOxDCwagz7MmEKkYQZo9xkrH5c671vUSHSpD3AtfFQ5cV80Enwvl
         3onjfexz/6WWxmi6yMsJIiy0tTSMtZH8iuSMP7STypXXdyjG562Mctn/zCmjXYH5qCRf
         Ahb+LoZSmOhxVOqAXavoAHo7TWY1PBcMWwp/ErGJKMOJIVf7RcUDY1PohbarNx82VK8W
         708umfr5qCcDtbHKANpZAl4k5fEBxZwY+7CpH3+ft1qw20Q8vdjnLl9ybUKU94nCPYFB
         C1TA==
X-Gm-Message-State: AOUpUlHTi9SVjL46stct2Dx5A5ucUYbuFHlmfNhKxUjQYcX20eMbbz2U
        b3F1XWraoMn5gmEx0NiWkFUK+mep+jHLzRVFBFBqjQ==
X-Google-Smtp-Source: AA+uWPwq1toOxttvE55JmPZxLA+ydwTcJlsHVj98N34zSG6nRx0oSz2fpG4Z42+/9lXMP3G1/IDK9+p9EE5Hl9rLbhY=
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr3199108pgp.334.1533743821748;
 Wed, 08 Aug 2018 08:57:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 8 Aug 2018 08:56:41
 -0700 (PDT)
In-Reply-To: <bcbcb69b-5d46-4e3d-852a-73e1345586e8@googlegroups.com>
References: <000000000000c242e90570aa0062@google.com> <CA+55aFyEZR=v2GySzWWF3uh9ZB53CFFv460Wzg4n8DGze8GFfw@mail.gmail.com>
 <CACT4Y+bOJx+SnkMqzDDUTU1iztQ7DpMBG7Z-oV5wArRaSEzh+Q@mail.gmail.com>
 <CA+55aFz1GVHUGiX1SE_5C-e9LdXdx3pBB10zwga1LOy6axk5Ww@mail.gmail.com>
 <CACT4Y+bvGNmjP+3z3uzm=SvnngkbtEx-JeT6iVWg4gwYvoKyLQ@mail.gmail.com> <bcbcb69b-5d46-4e3d-852a-73e1345586e8@googlegroups.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Aug 2018 17:56:41 +0200
Message-ID: <CACT4Y+aHEqv+-4YbNWAHX53U+54T+fzMyVxjWB_iF1EDZBZXjQ@mail.gmail.com>
Subject: Re: general protection fault in in_aton
To:     randy.dunlap@gmail.com
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        tomas <tomasbortoli@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 12:43 AM,  <randy.dunlap@gmail.com> wrote:
>
>
> On Wednesday, July 11, 2018 at 9:48:02 AM UTC-7, Dmitry Vyukov wrote:
>>
>> On Tue, Jul 10, 2018 at 10:15 PM, Linus Torvalds
>> <torv...@linux-foundation.org> wrote:
>> > On Tue, Jul 10, 2018 at 12:57 PM Dmitry Vyukov <dvy...@google.com>
>> > wrote:
>> >>
>> >> Is it really hard to get fault address? I know that userspace
>> >> generally receives fault address in siginfo.
>> >
>> > For an actual page fault it's trivial.
>> >
>> > However, for invalid addresses (aka "non-canonical"), you don't even
>> > get a page fault, you get a GP like in this case. And then the actual
>> > address is not available.
>>
>>
>> I see. Then I don't have any great ideas. Running without KASAN would
>> result in more, much more cryptic crashes.
>>
>> FWIW for these "GPF could be caused by NULL-ptr deref" I first just
>> assume that it's in fact a NULL deref. And in this case it all pretty
>> quickly forms a consistent picture that it's indeed just a missing a
>> NULL pointer check. That dffffc0000000000 in a register also a good
>> hint.
>
>
> The second mount syscall in loop() has a pointer parameter of 0 (null):
>       syscall(__NR_mount, 0, 0x200000c0, 0x20000340, 0, 0x20000180);
> and that NULL is passed from do_mount() to do_new_mount() to
> vfs_kern_mount()
> on to mount_fs() to v9fs_mount() to v9fs_session_init() to
> p9_client_create() to
> rdma_create_trans() and then to in_aton().  Are all of those valid up until
> the
> call to in_aton()?

Hi Randy,

+kernel mailing lists again

Please keep kernel lists and developers and CC, there are no kernel
developers on syzkaller-bugs@ list.

This is almost the same as "general protection fault in
p9_fd_create_unix" just for rdma:
https://syzkaller.appspot.com/bug?extid=1a262da37d3bead15c39
Yes, this function needs to check for NULL.

Tomas, I think it makes sense to include rdma into your "9p: fix NULL
pointer dereferences" patch.
