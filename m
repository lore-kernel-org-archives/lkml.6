Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id r3i+LRbBHFt9cwAAmS7hNA
	; Sun, 10 Jun 2018 06:11:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7C4FD60795; Sun, 10 Jun 2018 06:11:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVdmi0hA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B32A6605A5;
	Sun, 10 Jun 2018 06:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B32A6605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbeFJGL2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:11:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35359 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeFJGL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:11:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so2112152plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=RJUqumIEOBUZ7LddMIceNZhfhKF/uwHTxvdNtEZlW6c=;
        b=tVdmi0hAMF3WJi0/XrNCVibKCM3XzZBVOBuP1pJ+FH1yuWAmlRF35esLAGZ39cDdlr
         PEiyOE10QUxg/3jBVRBTUMzwNi58ycR+3BII+hJWWvOryKEm+wV7VU7sXBnFzzRKCzE7
         Y1TsyhK0QEgIYcvXzWJmA25R0Y4Q2YgpLzS6gVa6ggSUSRlaZb46GJEGM52MYQjzODFF
         Sa6b6ezVY8iOoK15pTAx8S40hZmh1V4GBtvDg0jaQbTRyWTjSy7Fg4Tl6N1xjNM65WBH
         soinphpOwk5APThjqO83SLIOsbF1npaLmkXPWw/Fl1+2cWq3STc6C5JRS82X2cjpWT0h
         485w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=RJUqumIEOBUZ7LddMIceNZhfhKF/uwHTxvdNtEZlW6c=;
        b=NafPK8TTlpCZaYUilKDzFM5NC8jvpbnRHpi6X6gmtMHJy8GCP34/xf1dwY9BHKfw/5
         NVmmjJFh9rCyRDLKE6buiMMGeGn0xJ/EUejrkGwPidvEVcDMqPFAJ/JNXqwsiA1eF9Ld
         jQHysZFrHl3yAuivgjqvCU23t+ACkqlAZFvrK7XJw7Z4Rt5tAQeAf3MVumyNDLOQ269L
         DuE8wSwdMrbmbaImzSL87n1+1jGcM4GhvErFrGL8Uimus/qxvftbHHhn2zFWHZVOaxaM
         bvspt385bcMCjWOTUNG1O5IKgDvcQGMaSi6xP1sHGsKrzs1pkdS5VmrAYUCdjCX7qWTX
         w3vg==
X-Gm-Message-State: APt69E2c2HariaxnqF+JuUqHY26EvddEFwZfou7OP8KyRG5Tk7wl+fqY
        4ixvlXqqiIQ5byDP8eT3dVfTtdb9qjEvQHcW1cy/Gg==
X-Google-Smtp-Source: ADUXVKKSRvhYMfKgLABZJm8oMQ/EFBEJWolMOd8GkDpcDimIMnLIKB0w36k+15OQjKUOXl4P79a+n9MW8momWTC+5CE=
X-Received: by 2002:a17:902:bb81:: with SMTP id m1-v6mr13393811pls.117.1528611085769;
 Sat, 09 Jun 2018 23:11:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Sat, 9 Jun 2018 23:11:05
 -0700 (PDT)
In-Reply-To: <20180610015107.GC5020@thunk.org>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
 <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
 <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com> <20180610015107.GC5020@thunk.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 10 Jun 2018 08:11:05 +0200
Message-ID: <CACT4Y+Z-+5XhmyVcLjEf6531GKC-b+JL9kes-vjWF5PXJNvqrw@mail.gmail.com>
Subject: Re: what trees/branches to test on syzbot
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Sun, Jun 10, 2018 at 3:51 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Sat, Jun 09, 2018 at 03:17:21PM -0700, Linus Torvalds wrote:
>> I think it would be lovely to get linux-next back eventually, but it
>> sounds like it's just too noisy right now, and yes, we should have a
>> baseline for the standard tree first.
>>
>> But once there's a "this is known for the baseline", I think adding
>> linux-next back in and then maybe even have linux-next simply just
>> kick out trees that cause problems would be a good idea.
>>
>> Right now linux-next only kicks things out based on build issues (or
>> extreme merge issues), afaik. But it *would* be good to also have
>> things like syzbot do quality control on linux-next.
>
> Syzbot is always getting improved to find new classes of problems.  So
> the only way to get a baseline would be to use an older version of
> syzbot for linux-next, and to have it suppress sending e-mails about
> failures that are duplicates that were already found via the mainline
> tree.
>
> Then periodically, once version N has run for M weeks, and has spewed
> some large number of new failures to LKML, then you could promote
> version N to be run against linux-next, and so hopefully the only
> thing it would report against linux-next are regressions, and not
> duplicates of new bugs also being found via the latest and greatest
> version of syzbot being run against the mainline kernel.

The set of trees where a crash happened is visible on dashboard, so
one can see if it's only linux-next or whole set of trees. Potentially
syzbot can act differently depending on this predicate, but I don't
see what should be the difference. However, this does not fully save
from falsely assessing bugs as linux-next-only just because they
happened few times and only on linux-next so far. But using an older
syzkaller revision won't save from this fully either, because (1) some
bugs take long time to find, and (2) a bug can be hidden by another
known bug, so when the second bug is fixed the first one suddenly pops
up, but it's not a new bug (and the chances are that the second one
will be fixed on linux-next first, so the first bug will look like
linux-next-only).
I think re removing commits from linux-next, one of the main signals
can be: were there recent changes related to the bug. Looking at new
bugs being reported, frequently it's quite obvious (e.g.
"use-after-free in foo" and a recent "make foo faster").
But in general, if we go with linux-next, maintainers and developers
need to agree to deal with this additional aspect during bug triage.

There is also a problem with rebasing of linux-next: reported commit
hashes do not make sense and we can forget about bisection.

On a related note, recently Greg suggested to onboard more subsystem
-next trees (currently we test only net-next and bpf-next), so I tried
to formulate requirements for these trees:

https://github.com/google/syzkaller/issues/592
 - not rebased (commit hashes work, bisection works)
 - maintained in a reasonably good shape (no tons of assorted crashes)
 - reasonably active (makes sense to test)
 - merge upstream periodically (bugs are getting fixed)
 - with maintainers who are willing to cooperate and fix bugs

Any volunteers?

Thanks
