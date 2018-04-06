Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDFBbl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:31:41 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:52121 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeDFBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:31:39 -0400
X-Google-Smtp-Source: AIpwx4/mJchMdkvwgckD/c3cMamWCBe9mGdiOszQTNLqox6bD8n70pocWvGDLlB+wtSSQUJqP0dqMk0dh8kt3TW3ELQ=
MIME-Version: 1.0
In-Reply-To: <20180406011147.GD12349@sirena.org.uk>
References: <s5hwoxmdpmu.wl-tiwai@suse.de> <CA+55aFxuowsvQyq0+xeq=ganTHqw2uZ6kkZ8DBk0k01cJHUzjA@mail.gmail.com>
 <20180405190441.GC12349@sirena.org.uk> <CA+55aFw3B=2NjM2dapxFRU=GYtMJ+Mm=MBVDEp8PNqp9LGz_7Q@mail.gmail.com>
 <20180406011147.GD12349@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 18:31:37 -0700
X-Google-Sender-Auth: hriAZ_0Gk2FQ8KBPuq9aqFKzhic
Message-ID: <CA+55aFwZ=GeDXh2Q5LnFD6Kor=e2+ZNChKX=5Mf3Oebw06J9QA@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.17-rc1
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 6:11 PM, Mark Brown <broonie@kernel.org> wrote:
>
>>  (3) if you are done and ready with a branch, and it's time to just
>> say "the development on this branch is all done, now I will ask
>> upstream to pull it, and I'll merge this into my upstream branch"
>
>>      THIS IS NEVER AUTOMATED!
>
>>      Sure, you might script it ("I have 35+ branches that I will send
>> out, I use a script to merge them all together"), but the act of
>> running that script is not something daily, it's something like "I am
>> now ready to ask Takashi to take this", so you do it before you do the
>> pull request to upstream.
>
> Hrm, OK.  This I find unclear in that if you're saying it's OK to script
> the merge of lots of branches I'm having trouble seeing the distinction
> between that and the test merges you're talking about.

The distinction is in intent and timing - and resulting history.

The "merge for release" happens once - when you are ready to send it
out. The end result is a single merge that brings in the changes to
the code, and a history that is legible and understandable.

So if you have 50 branches with new code, and they all have the
changes you were working on, maybe there's a lot of merges (not
necessarily 50 of them, since you use octopus merges, but easily ten).

But the merges they are are the *only* thing that brings in the new
code, and when you look at history, the code development within one
topic branch is nice and linear and there aren't odd other merges in
the middle.

That makes it a *lot* easier to follow a certain strand of development
(namely the strand of your topic branch). There aren't five other
random merges that pull in the changes part-way through.

So the "merge for release" is something that has been THOUGHT about.
Maybe there was scripting simply because there were lots of branches,
but it was all ready and intentional, and none of it should have been
merged in some half-way ready state. By definition, the branches you
merged were *ready*.

Otherwise you shouldn't have been merging them for an upstream pull
request at all!

See?

In contrast, the "merge for testing" happens at random times and
happens multiple times. There is no *thought* behind the merge that
brings in the code, it's literally just "I'm testing everything I
have". It's not necessarily just scripted in the sense of "I have 50
branches", but it is scripted and automated in a much bigger sense -
you don't even care if things are ready, you just want to run build
tests and maybe boot tests on whatever you happen to have at the time.

See how completely different such a merge is?

So what I'm trying to explain is that upstream does not want to see
those "whatever you happen to have at the time" merges. They are
*WRONG*. They actively make it harder to see the history of the code.

         Linus
