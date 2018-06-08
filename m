Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id u2xVMrDqGVsYHgAAmS7hNA
	; Fri, 08 Jun 2018 02:32:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B1BEC6089E; Fri,  8 Jun 2018 02:32:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 28EC360290;
	Fri,  8 Jun 2018 02:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28EC360290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeFHCcO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 22:32:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61003 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbeFHCcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 22:32:12 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w582VIoF021014;
        Fri, 8 Jun 2018 11:31:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Fri, 08 Jun 2018 11:31:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w582VIWu021010;
        Fri, 8 Jun 2018 11:31:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w582VIRn021009;
        Fri, 8 Jun 2018 11:31:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201806080231.w582VIRn021009@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: general protection fault in =?ISO-2022-JP?B?d2Jfd29ya2ZuICgyKQ==?=
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Date: Fri, 08 Jun 2018 11:31:18 +0900
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp> <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
In-Reply-To: <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Tue, Jun 5, 2018 at 3:45 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > Dmitry, can you assign VM resources for a git tree for this bug? This bug wants to fight
> > against https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches ...
> 
> Hi Tetsuo,
> 
> Most of the reasons for not doing it still stand. A syzkaller instance
> will produce not just this bug, it will produce hundreds of different
> bugs. Then the question is: what to do with these bugs? Report all to
> mailing lists?

Is it possible to add linux-next.git tree as a target for fuzzing? If yes,
we can try debug patches easily, in addition to find bugs earlier than now.

> I think the solution here is just to run syzkaller instance locally.
> It's just a program anybody can run it on any kernel with any custom
> patches. Moreover for local instance it's also possible to limit set
> of tested syscalls to increase probability of hitting this bug and at
> the same time filter out most of other bugs.

If this bug is reproducible with VM resources individual developer can afford...

Since my Linux development environment is VMware guests on a Windows PC, I can't
run VM instance which needs KVM acceleration. Also, due to security policy, I can't
utilize external VM resources available on the Internet, as well as I can't use ssh
and git protocols. Speak of this bug, even with a lot of VM instances, syzbot can
reproduce this bug only once or twice per a day. Thus, the question for me boils
down to, whether I can reproduce this bug using one VMware guest instance with 4GB
of memory. Effectively, I don't have access to environments for running syzkaller
instance...

> 
> Do we have any idea about the guilty subsystem? You mentioned
> bdi_unregister, why? What would be the set of syscalls to concentrate
> on?
> I will do a custom run when I get around to it, if nobody else beats me to it.

Because bdi_unregister() does "bdi->dev = NULL;" which wb_workfn() is hitting
NULL pointer dereference.
