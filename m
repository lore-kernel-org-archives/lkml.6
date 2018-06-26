Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86359C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3301E26CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBbAlpAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3301E26CAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbeFZOzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:55:04 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33871 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeFZOzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:55:02 -0400
Received: by mail-yw0-f196.google.com with SMTP id n187-v6so2710330ywd.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bs/j42+OhRDfsQgJDi9Z6UXb1FdRBFWdCjxEX4egii8=;
        b=XBbAlpAtbMfd0dmygwp2pVH83BITmmnMvNgAuYXz3dSFL7kulo0A1/6V598boqX6iC
         dlNcjhnT2mNagw2BIirgnJrD/BHFRtcTN12jXyBmNSyTCevjMop8VUCM3mFsE5GHMdpY
         +xMft5aATHaWE4YJlAMh6A3IjEbE+d1S9HOzjNC+sPzRN72/Jn08JgNFvuFKrWlHRYrT
         wX/OlWj0gNOzaVdZgoGPTu9z7I8EL5oj0XI9XskPOTAJny1Bc8y31DdiCAR5+kd4LBcd
         daG0+L0VCGnqHa5gnLyJa5Xqx2Y4oJA7uMT9HJI7upxQ/UVMJPl/SggkrufIbInV1hxN
         sxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bs/j42+OhRDfsQgJDi9Z6UXb1FdRBFWdCjxEX4egii8=;
        b=YVkXsnWqXNRJbiAURTYDrWBHo7FaIUsnL8KYhjFE+QBnQqijg3xmdpXZReU6M08JGK
         v2+cHh01F7z29wks3+xSoEMIj71NURnkKaFoReahKb6nBYR3gZzCopY3GrYZ71oAEf5n
         tGh3RYOVc8/SSsEwi3Yu/4eN/24+082MAPmBiafDnY//ZYqJb5Dp+N81kj1aQX7qMOCY
         gWqpj9c5+YI3QFeb49kbMO7Sqi0cVsTEFFBmNYzIh0+yCpyKaGFAe6urZSBjAV+qsWdk
         rWrwh9JVyUWKajvTzKVvhTb6p7O70mFPRUjpdFYkmPXe7hcDSSRTtm3XcbM+BJvXTEuR
         il3Q==
X-Gm-Message-State: APt69E0stZ23YVIsDHhssM30i93FjBxuxKfj9gaSN5HcqpBr6wYZdoLm
        vhHe0whjLgvvF06MizaFDPg11qUGGryFXaQQhnLYFg==
X-Google-Smtp-Source: AAOMgpdhB8jaIpqCNKFbY/d5dangPPqbmGsu9k0FEBHADP/OWW/gmr3ioSY2A036ljw+U/EydduSkfMY4YBia+kKNNU=
X-Received: by 2002:a81:7d0b:: with SMTP id y11-v6mr835846ywc.371.1530024901644;
 Tue, 26 Jun 2018 07:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com> <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
 <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
 <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
 <b9aa57f5-9204-dc97-bfd6-d53ed2e0ae12@i-love.sakura.ne.jp>
 <20180626141602.GA17788@thunk.org> <CACT4Y+YH3Z1q9aVTUgTbTPfDp2ao-z=YAjzBGU5HsjGJ-utgeg@mail.gmail.com>
In-Reply-To: <CACT4Y+YH3Z1q9aVTUgTbTPfDp2ao-z=YAjzBGU5HsjGJ-utgeg@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 26 Jun 2018 07:54:50 -0700
Message-ID: <CABXOdTe1HCy78w+G4LuN8S7Ad5kvUxwHsiP2a=8aW-jEvpjdug@mail.gmail.com>
Subject: Re: what trees/branches to test on syzbot
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        penguin-kernel@i-love.sakura.ne.jp,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        kbuild test robot <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:38 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Jun 26, 2018 at 4:16 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > On Tue, Jun 26, 2018 at 07:54:53PM +0900, Tetsuo Handa wrote:
> >> I hope we can accept NOW either "reviving linux-next.git" or "allowing debug printk()
> >> patches for linux.git". For example, "INFO: task hung in __sb_start_write" got 900
> >> crashes in 81 days but still unable to find a reproducer. Dmitry tried to reproduce
> >> locally with debug printk() patches but not yet successful. I think that testing with
> >> http://lkml.kernel.org/r/f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp
> >> on linux.git or linux-next.git is the only realistic way for debugging this bug.
> >> More we postpone revival of the linux-next, more syzbot reports we will get...
> >
> > Here's a proposal for adding linux-next back:
> >
> > *) Subsystems or maintainers need to have a way to opt out of getting
> >    spammed with Syzkaller reports that have no reproducer.  More often
> >    than not, they are not actionable, and just annoy the maintainers,
> >    with the net result that they tune out all Syzkaller reports as
> >    noise.
>
> False. You can count yourself. 2/3 are actionable and fixed.
>

Problem is that some if not many of the other 1/3 will be considered
noise, and even some of the 2/3 will be considered noise because they
have already been fixed by the time they are reported. Same problem as
with, say, stable tree merges: People don't see the thousands of bug
fixes inherited with such merges, but they do see the two or three
regressions. Plus, of course, one can not prove that the thousands of
bug fixes did any good because the fixed bugs are not observable
anymore. The only remedy is to try to reduce regressions down to zero
(or, of course, stop using/merging stable releases).

The same applies here: People won't see the good, they only see the
noise. This is pretty much the reason why I all but stopped reporting
build/boot failures on -next. You would have to reduce the noise
almost down to zero for people to stop complaining, and you would have
to be _really_ sure that the problem was not already fixed or reported
elsewhere.

Guenter

> This also makes the following point ungrounded.
>
> > *) Email reports for failures on linux-next that correspond to known
> >    failures on mainline should be suppressed.  Another way of doing
> >    this would be to only report a problem found by a specific
> >    reproducer to the mailing list unless the recipient has agreed to
> >    be spammed by Syskaller noise.
> >
> > And please please please, Syzkaller needs to figure out how to do
> > bisection runs once you have a reproducer.
> >
> >                                                 - Ted
