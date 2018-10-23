Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C308AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8023C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XKk1plg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8023C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeJWREQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:04:16 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40706 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeJWREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:04:16 -0400
Received: by mail-lf1-f43.google.com with SMTP id n3-v6so464490lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/5nbo3ztJFbSmLXxGKJjJFnj9gVsjciemeUXMkXwpSY=;
        b=XKk1plg05iq0p7lhYAud2qMQoTAdbjS5nonUyTnIwhQ4PLH2vESlcPrrxILJ7L0U2c
         zSOp4lYQ/m0wobSPWhVXxaznDWKgBDB8DqD9jIp09UatpJTTg8+ogkvYlQTrM2cLbe78
         qWa0EY9wZvRnKIvheVdR+mVHQ29LY0bxFXQoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/5nbo3ztJFbSmLXxGKJjJFnj9gVsjciemeUXMkXwpSY=;
        b=LmeD1jvpbwF/Ovjb/rF0lR2fnBA6ShG/sitR2iFmg6vB/9Xql9NB16NZ6LxG9nx387
         hwYYtC4dGWcrDl0FeWQqvwAvkxDBWPSC8Z5AsgqF2GHydLsGJbzK/lzkHLZxW6OyGSBR
         hqh2m3HEj3j5lk/CwzPvTnartX0NsksizwqZ74txmWpO80DnD1r7aHzGNMVhM3Kg+O/r
         lVhxb1J8ANDN2ZFBdmin3TV/LuOXQSqWdO1gW9aBRwvti3PpSBDITtAibu2dUEPHSSs0
         0lE9hUnafm4gt66sTXOvJsmwOlaMMZdGdnv822+I1iyhQ6F85t/3SpIPx75VxpXZqL8D
         vPTQ==
X-Gm-Message-State: ABuFfoihi7Q7fC1rWWUn4qvG+zRhouYKWG0jxKwPQR2nbSbQXnsU0Y5e
        grWLKlHIJrdKGvqy7WbH75PrbgWYIjkUhwDW
X-Google-Smtp-Source: ACcGV6266XRKUuq6zP4oyv1SILG6Vvmn+WSc+bCSz1DoOoU4fTuHWD8aA8oQ///Xm0pXABSGhce3nQ==
X-Received: by 2002:a19:1941:: with SMTP id 62-v6mr10289929lfz.99.1540284110133;
        Tue, 23 Oct 2018 01:41:50 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o74-v6sm132139lfe.30.2018.10.23.01.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 01:41:49 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id x3-v6so531107lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:41:49 -0700 (PDT)
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr11375614ljj.80.1540284108687;
 Tue, 23 Oct 2018 01:41:48 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 09:41:32 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
Message-ID: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
Subject: Git pull ack emails..
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I've obviously started pulling stuff for the merge window, and one
of the things I noticed with Greg doing it for the last few weeks was
that he has this habit (or automation) to send Ack emails when he
pulls.

In fact, I reacted to them not being there when he sent himself his
fake pull messages. Because he didn't then send himself an ack for
having pulled it ;(

And I actually went into this saying "I'll try to do the same".

But after having actually started doing the pulls, I notice how it
doesn't work well with my traditional workflow, and so I haven't been
doing it after all.

In particular, the issue is that after each pull, I do a build test
before the pull is really "final", and while that build test is
ongoing (which takes anything from a few minutes to over an hour when
I'm on the road and using my laptop), I go on and look at the *next*
pull (or one of the other pending ones).

So by the time the build test has finished, the original pull request
is already long gone - archived and done - and I have moved on.

End result: answering the pull request is somewhat inconvenient to my
flow, which is why I haven't done it.

In contrast, this email is written "after the fact", just scripting
"who did I pull for and then push out" by just looking at the git
tree. Which sucks, because it means that I don't actually answer the
original email at all, and thus lose any cc's for other people or
mailing lists.  That would literally be done better by simple
automation.

So I've got a few options:

 - just don't do it

 - acking the pull request before it's validated and finalized.

 - starting the reply when doing the pull, leaving the email open in a
separate window, going on to the next pull request, and then when
build tests are done and I'll start the next one, finish off the old
pending email.

and obviously that first option is the easiest one. I'm not sure what
Greg did, and during the later rc's it probably doesn't matter,
because there likely simply aren't any overlapping operations.

Because yes, the second option likely works fine in most cases, but my
pull might not actually be final *if* something goes bad (where  bad
might be just "oops, my tests showed a semantic conflict, I'll need to
fix up my merge" to "I'm going to have to look more closely at that
warning" to "uhhuh, I'm going to just undo the pull entirely because
it ended up being broken").

The third option would work reliably, and not have the "oh, my pull is
only tentatively done" issue. It just adds an annoying back-and-forth
switch to my workflow.

So I'm mainly pinging people I've already pulled to see how much
people actually _care_. Yes, the ack is nice, but do people care
enough that I should try to make that workflow change? Traditionally,
you can see that I've pulled from just seeing the end result when it
actually hits the public tree (which is yet another step removed from
the steps above - I do build tests between every pull, but I generally
tend to push out the end result in batches, usually a couple of times
a day).

Comments?

                 Linus
