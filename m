Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jW5qBSZ0Hlv+DwAAmS7hNA
	; Mon, 11 Jun 2018 13:07:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CC7F060792; Mon, 11 Jun 2018 13:07:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QThYfcQB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 275B860385;
	Mon, 11 Jun 2018 13:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 275B860385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeFKNHr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:07:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38015 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKNHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:07:46 -0400
Received: by mail-pf0-f195.google.com with SMTP id b74-v6so10217110pfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=wIycF8z6zw1FeUZmUxR4mFRfX6eiuz/5aeE1HYMh2rc=;
        b=QThYfcQBOKf/aSyRtPjaObO/aGDNpVWHxrVcWdlTmVj1INF+TOybznT6QcumwvyWx0
         mzmfRzX2dCUw/hrINFY8pI2hcdBd6IFJT5F/hq3gA3JQhklLC2rWTTLKhJzbTO0Vsm9T
         1cRIdsmzSCPm5tr+Sj07IwtLR88zz+NKcBNF1iTEwHSxjTsJi+OFtFT3j1UOKJIGwTeZ
         LnPmZdIfBKqW5zjbYAlfixAmvSoV9ac65Ef2eTLuEWqX1rWGeSiAhU1SDPaAALVyYw8x
         KGzapfayubWJwxhVJUk2TKTAVkWwDw5WkR+giSbHy52M166PVH1yuof8mXW+na4IFnmH
         Or0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=wIycF8z6zw1FeUZmUxR4mFRfX6eiuz/5aeE1HYMh2rc=;
        b=treohhE1ZgUC0VdSEgQNbRiGwVFV+fQyflLvponp6DkvbED0pbIkxamvg5NDT/xSCp
         jmES5LlS+O6LhwkUJCdmv0F+E5B9yJxLHMinKZGQeOUn8RfxZW5ERwNwbNcW0g+t1/41
         rv/EFiIAxEejxMrLmLgwspFTZ/WIVTl+Ga1mnZr5G9YrEv9TtGi9+w65zsBAw+yEyarM
         JiCNx6mrypCoEZ+UBD5tJbbxkmeCEfDwu5R0YybHqMR36LbCS6bBXkor/LWsl7MjIGbB
         gySHga+roO+5yJK2xD8MS+1d+z8r4negRra3p//LJs3PlDQUwmzU/To9ro+U9q0DCJJK
         D5VQ==
X-Gm-Message-State: APt69E1aHDwsEfmDOKZB7gm6jlf143wC1so/N9zAfwvYnO8PPP8HShsk
        xpAhzvY3Ro+VhMIVCAolH2zK+M0VSPeDbEUqhsb3vw==
X-Google-Smtp-Source: ADUXVKLWI8YqlN9e9j34p9rTcqiFiu73CZ4ujqsCvUsNHXfyjxALz9J92xLKQGW+UcqMajutPUxjgdBY8k58WpntVLQ=
X-Received: by 2002:a62:9652:: with SMTP id c79-v6mr17717210pfe.114.1528722465068;
 Mon, 11 Jun 2018 06:07:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 11 Jun 2018 06:07:24
 -0700 (PDT)
In-Reply-To: <20180526202436.GC4613@thunk.org>
References: <000000000000457b2d056cbb0044@google.com> <20180522123107.GC3751@bfoster.bfoster>
 <20180522222620.GW23861@dastard> <20180522225208.GB658@sol.localdomain>
 <20180523074425.GM14384@magnolia> <20180523162015.GA3684@sol.localdomain>
 <a52266f9-0096-b28c-c01c-046ababcfe3a@sandeen.net> <20180523234114.GA3434@thunk.org>
 <CACT4Y+YEpThQj=63F8CSHeWSZxbWJ1cTDB7ZvM8OYR921uXT2g@mail.gmail.com> <20180526202436.GC4613@thunk.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 15:07:24 +0200
Message-ID: <CACT4Y+YK9LzYuVSruimbgxSAoCt_UYbHwzhvDGCqZ7FuQLcUUA@mail.gmail.com>
Subject: Re: Bugs involving maliciously crafted file system
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Eric Biggers <ebiggers3@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 10:24 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Sat, May 26, 2018 at 07:12:49PM +0200, Dmitry Vyukov wrote:
>>
>> I don't see that "some kind of machine learning or expert system
>> evaluation" is feasible. At least not in short/mid-term. There are
>> innocently-looking bugs that actually turn out to be very bad, and
>> there are badly looking at first glance bugs that actually not that
>> bad for some complex reasons. Full security assessment is a complex
>> task and I think stays "human expert area" for now. One can get some
>> coarse estimation by searching for "use-after-free" and
>> "out-of-bounds" on the dashboard.
>
> If the kernel intentionally triggers a BUG_ON or a panic (as in file
> systems configured with 'tune2fs -e panic') it's pretty obvious that
> those errors can't be weaponized to execute code chosen by the
> attacker.  Would you agree with that?
>
> The same should be true for "blocked for more than 120 seconds";
> again, I claim that those sorts of errors are by definition less
> serious than buffer overruns.
>
> So there is at least some kind of automated evaluation that can be
> done, even if the general case problem is really hard.

These can't be weaponized to execute code, but if a BUG_ON is
triggerable over a network, or from VM guest, then it's likely more
critical than a local code execution. That's why I am saying that
automated evaluation is infeasible.

Anyway, bug type (UAF, BUG, task hung) is available in the bug title
on dashboard and on mailing lists, so you can just search/sort bugs on
the dashboard. What other interface you want on top of this?



>> > Or maybe it would be useful if there was a way where maintainers could
>> > be able to annotate bugs with priority and severity levels, and maybe
>> > make comments that can be viewed from the Syzbot dashboard UI.
>>
>> This looks more realistic. +Tetsuo proposed something similar:
>> https://github.com/google/syzkaller/issues/608
>>
>> I think to make it useful we need to settle on some small set of
>> well-defined tags for bugs that we can show on the dashboard.
>> Arbitrary detailed free-form comments can be left on the mailing list
>> threads that are always referenced from the dashboard.
>>
>> What tags would you use today for existing bugs? One would be
>> "security-critical", right?
>
> For me, it's not about tags.  Things missing from the
> https://syzkaller.appspot.com/ front page are:
>
> * Whether or not a repro is available

This was always available in the Repro column.

> * Which subsystems the bug has been tentatively assigned
> * A maintainer assigned priority and severity level

Let's call this tags collectively (unless you have a better name). P0
or subsystem:ext4 can also be tags.
So  you mean: (1) priority levels (P0, P1, P2), (2) severity levels
(S0, S1, S2) and subsystem, right?

On a related note, perhaps kernel community needs to finally start
using bugzilla for real, like with priorities, assignees, up-to-date
statuses, no stale bugs, etc. All of this is available in bug tracking
systems for decades...
