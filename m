Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F068DC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F8820823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hnej8vEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F8820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJ3VDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:03:19 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54454 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3VDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:03:19 -0400
Received: by mail-it1-f193.google.com with SMTP id d6so7780894itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=xFfT7HF7lK9pN+swTOjWcemWyiuMBszcfLc52d8Irzs=;
        b=Hnej8vEwSh41/BRqSW2lTdM0jDJtknlQkWBwt1aoNHIkyqTFMPC12Z8AceLgpIrxFl
         m4e14LG8jnWKQE9clXbBmk/dfuElc17W/r4hWtAbUv94+boS6y0EtM7UZzen3ktYfY8F
         2kSeRuANrUveEWA6p2ClVbE+FFGaBQ9syfHuOAEOF+qhLwh4/iEMDnF8oUTh6T/qAZcE
         j0y/Al6vSEXMD/n8nhAlXY1A6YKZAOI/As1uvgHNo6lFeQQbn8RdBwPG75uEgYnG53RM
         syU3ZFnDgYBvVJauJgVyamLjEz39cist3edvgYSTSjHCwn/aEoJdDq/mZM5H5G4ByR2W
         heow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=xFfT7HF7lK9pN+swTOjWcemWyiuMBszcfLc52d8Irzs=;
        b=BR7QixLG/lFDFjJAn1nNP46BsKw9sX+dKxpJ4J0dqkOYQdM/POhU+3rEPwyUel6vP3
         RtJd7cKwPwKJYUwliUWFoX7PjUCM6eg8s5c0q+xORZUpAZ5DVrWh5Ha2mwDL4+rfj8gd
         uhQbpUOaRvjWPH7pFuf5W7JsoEyxraYqWmwp9lQCkwCCpPMqMKOWUXdZuw9L3s3kF6iU
         AK5oPnFgOISqm7coWE+3ttVGarQZ8K9JbmMRvM/1HuEicDiUkN8qQYweckq/UiCNPIJM
         f9wfk1pPLUYpMOOI3Jct3r6AKTcm/m99oPHeOt54+McDPysAKWDu9QK/7jLVtHuNcP5T
         iXKw==
X-Gm-Message-State: AGRZ1gKYet4m0w8WAw9xI0cc2bbqEcKfxoIYkofTRYQgMxAyUWg7xokN
        B/URUKO1XJT84jTw0qI7wtFpXOqyPtZReKz1aGmmcw==
X-Google-Smtp-Source: AJdET5dwasKBqIzBNhvBfRMdy5tj8FOPPekRm6/mwzj4vmcoIMRp90pNtFuJlxMNhvx/Ad5bCc9fVRGuL646zfWHKcs=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr1106587ite.12.1540901405159;
 Tue, 30 Oct 2018 05:10:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 05:09:44
 -0700 (PDT)
In-Reply-To: <20181016155341.GF8983@thunk.org>
References: <0000000000002753c60577b9f707@google.com> <CACT4Y+bdR3ch9q_FCND4YmqjunYBVbEk3n167DT0r0GqzVKL-g@mail.gmail.com>
 <20181009013425.GB3369@thunk.org> <CACT4Y+a08tYAgXKEiTO+A-RDrSNk-RdhDxvGCM6bAbk5bckH6A@mail.gmail.com>
 <20181015180821.GE8983@thunk.org> <CACT4Y+bs72L4GKF7K6zHHqDGfURymzUke7UT6CKtakLWu+f94g@mail.gmail.com>
 <20181016155341.GF8983@thunk.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 30 Oct 2018 13:09:44 +0100
Message-ID: <CACT4Y+Zoa7mzVGKqRERgg_knN6fDYzEO_SS7TxLZhtEmesqBsw@mail.gmail.com>
Subject: Re: WARNING in ext4_invalidatepage
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:53 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, Oct 16, 2018 at 04:02:07PM +0200, Dmitry Vyukov wrote:
>> I am not sure how exactly this should be classified. To significant
>> degree these "$FOO" discriminations are informational and only really
>> affect the data format passed in.
>
> The problem is that putting something which is simply and plainly
> *wrong* is going to be actively misleading.  You *have* to know what
> ioctl you are trying to be trying to execute because some of them
> require input data structures that you have to fill in, or that it
> requires a file descriptor as opposed to an integer or a pointer to a
> struct.  I assume you're not just picking ioctl numbers purely at
> random, right?
>
> So I assume you had a table that said, this ioctl, 0x6611 takes a file
> descriptor, and has thus-and-so-a-name.  If that name is wrong, I'd
> say it's pretty clearly a bug, right?

We have such table and it is correct. But it is legal and fine and
actually useful in context of testing to take an ioctl that takes a
pointer to one structure and give it pointer to another structure, or
plain int or just anything else. $FOO states what data layout is used
and actual cmd number and fd type what command is executed.

> (I'll again gently point out that a tiny amount of work in making
> syzkaller a tiny bit more developer toil would make it much more
> effective, since all of this extra developer toil --- now I know I
> can't even trust the $FOO discriminators to be right --- makes
> syzkaller less scalable by pursuading developers that it's not
> worthwhile to pay attention...)

Ted, I appreciate your suggestions. And the new table-structured email
format that you proposed is great.
But there are reasons for the current syzkaller program format. It's
not just there is a typo in some table that we need to fix. The $FOO
part encodes data layout and treatment of argument values (e.g. if
0xab actually takes a byte or a word, and what's it alignment). It's
not something that can be restored from anything else. So if we lose
this information, the program will useless and confusing in other
ways. For example, consider an ioctl accepts a struct with 2 byte
fields; but we actually executed it passing a struct with 2 int
fields. Now if you look at {0x1, 0x2} you will assume that these are
the byte values, but in reality it's 0x1 int which covered both 1-byte
arguments.
Also consider that ioctl cmd is actually meaningless in itself, and
it's generally not possible to statically know what exactly ioctl will
be executed. The crucial piece is fd type. I guess it boils down to
the halting problem to statically prove what fd type we will have in a
random program. Even worse, we can have a race on fd type, so it's
non-deterministic and even not detectable dynamically. Taking this
into account any attempts to preserve matching $FOO and cmd number are
pointless.
