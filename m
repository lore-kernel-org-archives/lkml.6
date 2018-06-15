Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1F028C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C7220896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pK/J6jY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C7220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965596AbeFOJyj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:54:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43646 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936122AbeFOJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:54:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so4632081pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=45/UnM8lIuSyXCa+PE/uuGGrvls94/CcqU4fZ9QWB/A=;
        b=pK/J6jY+PY2b/4e3IcJVV9QGuDqqWCHuSp2zVW1+M3WWLzmHrmNUMU/1qyIz7rpZBh
         QiHBqos194XTNIsRveZIUb91NB17TFpu5L33L3da5ThAcXt4FPH62jc27Q/abf0KdLy5
         ljcAmER22DkG0PGvRhZZreJ7axsXnmhNMTnJgTdIOwHjYb3QEK9ZZ+YhQ648L5Lsps8z
         N1dY41NZ/Q63c0p+fJX4SoBBdtkrCS7n693yR4bG/0H+nbnDGCXbOGgbU5+N7fGC2JY0
         4eqFJX24T6aowAmFPn4ygWUQjWggu6aNTlbp8EDoY52efMNSAPAannKVIuZGmltmcqiJ
         pEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=45/UnM8lIuSyXCa+PE/uuGGrvls94/CcqU4fZ9QWB/A=;
        b=dmp4i+olwPanjw7Beu/TeX8FtewA7JLWv1gQWo6mG5sneH0OFK8ta2Vbe5IXm8KePm
         20uISgl9YBm9JG00s54j3kuAq/TmpN9NA42K6VhaEE/u/7IUYb6BP7eEncAS0pZ6Bu9y
         Mq0THn3wIE5M5WnXoRKunu+l5Wu4fKb/moPKWKHI+FdjZTChChlzc79xYn/HWvbmMYAT
         MI1K0arGCRAFl+ZxOyZy0aZH208kT5f6GAqR9om42nwBrzhJEoeaq54mjubwVJfYP4ty
         N9vTbOgp2UNHb0nD5Pr8FR4NWaXIDB2L3J4Lzql+7W+Pbp87bGPaNHO+dC7bVD0Ua8Sm
         Bfag==
X-Gm-Message-State: APt69E2E7zweu1tUpYKVEwiV6r+VslO63N7sdePWN3WD/xqnhdVoMqd9
        ahUuGCGVKHyyqU8uG1Dqugpt6fZfEKlB9LAByHLQ7g==
X-Google-Smtp-Source: ADUXVKL8VhlH7iBEpfRFwYj/NpSaLHe1HviAGrScKra2rHvYE8ioiLi3gFV+kdf/GBOlqgwM5yPF5MlA6jx3b2ehAPs=
X-Received: by 2002:a65:4bcd:: with SMTP id p13-v6mr952622pgr.114.1529056477240;
 Fri, 15 Jun 2018 02:54:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Fri, 15 Jun 2018 02:54:16
 -0700 (PDT)
In-Reply-To: <20180611012250.GD5020@thunk.org>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
 <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
 <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
 <20180610015107.GC5020@thunk.org> <CACT4Y+Z-+5XhmyVcLjEf6531GKC-b+JL9kes-vjWF5PXJNvqrw@mail.gmail.com>
 <20180611012250.GD5020@thunk.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 15 Jun 2018 11:54:16 +0200
Message-ID: <CACT4Y+adoSOyhLNuWF7ZCS-e7SxZu89O1VLXV5NZjg_c6U3B-w@mail.gmail.com>
Subject: Re: what trees/branches to test on syzbot
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 3:22 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Sun, Jun 10, 2018 at 08:11:05AM +0200, Dmitry Vyukov wrote:
>>
>> The set of trees where a crash happened is visible on dashboard, so
>> one can see if it's only linux-next or whole set of trees. Potentially
>> syzbot can act differently depending on this predicate, but I don't
>> see what should be the difference.  However, this does not fully save
>> from falsely assessing bugs as linux-next-only just because they
>> happened few times and only on linux-next so far.
>
> So how about this, only report something as being a linux-next
> regression if (a) there is a reproducer, and (b) the reproducer does
> not trigger any kind of crash on mainline?
>
>> There is also a problem with rebasing of linux-next: reported commit
>> hashes do not make sense and we can forget about bisection.
>
> If there is a valid reproducer, bisection should simply be a matter ofu
> running and if we know the reproducer doesn't trigger on mainline,
> then the bisection should only require no more than 8-10 VM runs.  For
> Linux-next, this would be *super* valuable.  Reporting the commit ID
> and the one-line commit summary will be enough for most maintainers,
> since even if they are using a rewinding head, so long as the
> bisection can be done quickly enough (e.g., within a few days), it
> will still be in their git repository.
>
> And if you have a reproducer, then once it's identified as a
> linux-next reproducer with a guilty commit, that can be confirmed by
> either (a) seeing if you can revert the commit and if it makes the
> problem go away, or (b) figure out which subsystem git tree the commit
> was introduced via, and then verify that the reproducer triggers on
> the tip of the subsystem git tree.
>
> All of this will require development effort, so I suspect it's not
> something we'll see from syzbot tomorrow --- but it's not
> *impossible*.
>
> I think though that sending e-mail about a linux-next syzbot crash if
> there is a reproducer and the reproducer doesn't trigger a crash on
> mainline should be really simple to implement, and it would add huge
> value without spamming the subsystem maintainers.


But if this also happens on upstream, then we want to report it
twofold. So this predicate can be reduced to "report crashes that
happen only on linux-next iff they have reproducers", right?
We will probably also need something that will auto-invalidate old
bugs that were never reported.

Re backwards bisection (when bug is introduced), we can actually test
linux-next-history instead of linux-next, right?
But forward bisection (when bug is fixed) unfortunately won't work
because these commits are not connected to HEAD. And forward bisection
is very important, otherwise who will bring order to all these
hundreds of open bugs?
https://syzkaller.appspot.com/
