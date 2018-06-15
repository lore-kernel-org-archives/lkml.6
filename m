Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F3F7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1610208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0UmO/sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1610208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755940AbeFOJch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:32:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46270 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755645AbeFOJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:32:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so4607142pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=791lWx9WuligOApTeSk8sUZpQR6eN7a4aZ/8qmtuzxk=;
        b=L0UmO/sfoakJvp4GsBRV3W7sdcGYDgc0BvVaYmOFnavz1tJ8DugJ6/b9peWpMdYnZh
         tceE4TeHgKLREBkCmvYwtC72ukm7SqJwh979Bi1eNhnDu4N5sLFftfaqMvqxr4ipJ4MU
         BzqAgIHHJNR84j3spbfbMbScE9eTgb0hAHNe4jk+lMlkzktNBGLYHIr1z3COYmizVrGD
         TqXU9bCzX5nDrY1JuJku8rL8u3X5ENTNOD88BqhDP0TwB2udfqqEPdhoH80Y+pkzrs3K
         hWr7ht3P9EZi97I+2NWbYGEtyEI8DJhxNB6LCg81JyVWv5KDhu3LAQpYUMhWNX1IyEFg
         caMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=791lWx9WuligOApTeSk8sUZpQR6eN7a4aZ/8qmtuzxk=;
        b=SCy/XWBA3RoquuzR5X9KXavqSMhzt936ufYi9o86Gko4fB2g1pArJ3ekYI4PIFKao7
         HWE5bhUcorrGaYYWUuQzFQqrApQ+T+piyxd6gbq73tz9jbbzSnygm5NC9Apc3PiWtvWI
         SFRfK5J/Ok8DYmDMpPi3xjponGwDmYcUbhqyXObTHb47S6S+P9ehEQEzgAqo1TIodI2i
         q9Wdess08zQpRRHosjy9lRwS1t5pilNc7wCRzd+SypfpBL+ipvfJBTD5QNZkuHABzVAr
         Z1jeQvdllRV4TdaclbGWKb3lMbmeutvmc3263l9ODE20/9UFbr06SMJgdKFGCssJh+RY
         WCPw==
X-Gm-Message-State: APt69E2Hc+dmHRagRP14Re7Lbg8B0dMk+he6gbMK+LpLJEZDWnwnQXk4
        lbWbjrI7ElD1/rt5EKGixIgLwEy2RuUZIRDOr/bH6Q==
X-Google-Smtp-Source: ADUXVKIgtAuk+NVfzeLuE3wzEUfrxjltUCU6szQ8Q+LhntZRmo1e3WoHKBF1sWgIhLaStGC2t7VU0/hnvMyHIUD0k5c=
X-Received: by 2002:a63:721c:: with SMTP id n28-v6mr882273pgc.96.1529055153932;
 Fri, 15 Jun 2018 02:32:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Fri, 15 Jun 2018 02:32:13
 -0700 (PDT)
In-Reply-To: <20180611133345.GE5020@thunk.org>
References: <20180522123107.GC3751@bfoster.bfoster> <20180522222620.GW23861@dastard>
 <20180522225208.GB658@sol.localdomain> <20180523074425.GM14384@magnolia>
 <20180523162015.GA3684@sol.localdomain> <a52266f9-0096-b28c-c01c-046ababcfe3a@sandeen.net>
 <20180523234114.GA3434@thunk.org> <CACT4Y+YEpThQj=63F8CSHeWSZxbWJ1cTDB7ZvM8OYR921uXT2g@mail.gmail.com>
 <20180526202436.GC4613@thunk.org> <CACT4Y+YK9LzYuVSruimbgxSAoCt_UYbHwzhvDGCqZ7FuQLcUUA@mail.gmail.com>
 <20180611133345.GE5020@thunk.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 15 Jun 2018 11:32:13 +0200
Message-ID: <CACT4Y+bxcHSCsYR5uGFbvaJvRAkoA3-z3=B_1DQ+rvks4Q5KpQ@mail.gmail.com>
Subject: Re: Bugs involving maliciously crafted file system
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
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

On Mon, Jun 11, 2018 at 3:33 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Jun 11, 2018 at 03:07:24PM +0200, Dmitry Vyukov wrote:
>>
>> These can't be weaponized to execute code, but if a BUG_ON is
>> triggerable over a network, or from VM guest, then it's likely more
>> critical than a local code execution. That's why I am saying that
>> automated evaluation is infeasible.
>
> I can't imagine situations where a BUG_ON would be more critical than
> local code execution.  You can leverage local code execution to ah
> remote privilege escalation attack; and local code execution can (with
> less effort) be translated to a system crash.  Hence, local code
> execution is always more critical than a BUG_ON.


Well, if one could bring all of Google servers remotely, lots of
people would consider this as more critical as _anything_ local.


>> Anyway, bug type (UAF, BUG, task hung) is available in the bug title
>> on dashboard and on mailing lists, so you can just search/sort bugs on
>> the dashboard. What other interface you want on top of this?
>
> I also want to be able to search and filter based on subsystem, and
> whether or not there is a reproducer.  Sometimes you can't even figure
> out the subsytem from the limited string shown on the dashboard,
> because the original string didn't include the subsystem to begin
> with, or the the subsytem name was truncated and not included on the
> dashboard.

How is this problem solved in kernel development for all other bug reports?

>> On a related note, perhaps kernel community needs to finally start
>> using bugzilla for real, like with priorities, assignees, up-to-date
>> statuses, no stale bugs, etc. All of this is available in bug tracking
>> systems for decades...
>
> I do use bugzilla and in fact if syzbot would automatically file a
> bugzilla.kernel.org report for things that are in the ext4 subsystem,
> that would be really helpful.
>
> As far as no stale bugs, etc., many companies (including Google)
> aren't capable of doing that with their own internal bug tracking
> systems, because management doesn't give them enough time to track and
> fix all stale bugs.  You seem to be assuming/demanding things of the
> kernel community that are at least partially constrained by resource
> availability --- and since you've used constrained resources as a
> reason why Syzbot can't be extended as we've requested to reduce
> developer toil and leverage our available resources, it would perhaps
> be respectful if you also accepted that resource constraints also
> exist in other areas, such as how much we can keep a fully groomed bug
> tracking system.

I mentioned this only because you asked for this.
Whatever tracking system and style we go with, bug states need to
maintained and bugs need to be nursed. If we extend syzbot dashboard
with more traditional bug tracking system capabilities, but then
nobody cares to maintain order, it also won't be useful and nobody
will be able to easily select the current tasks to work on.
So that's a prerequisite for what you are asking for.

Well, you use bugzilla, but somebody else uses something else. This
fragmentation is kernel development practices does not allow to build
further automation on top. We can't do a personal solution for each
developer. For now the greatest common divisor seems to be freeform
emails on mailing lists...

A good example is "I submitted 7 kernel bugs to bugzilla, but nobody
answered me" email thread from today:
https://groups.google.com/forum/#!topic/syzkaller/OnbMQbbE4gQ
