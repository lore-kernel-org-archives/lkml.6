Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0A1C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC5820671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYXck+RW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DC5820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJWUhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:37:00 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:50982 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:37:00 -0400
Received: by mail-it1-f176.google.com with SMTP id k206-v6so1619127ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7ZP6uHZJ/F6v0hE+9XCHZPml+qtTSgB2HLcg17zVahg=;
        b=bYXck+RWATCT2/+6/TlCC6NLCX66f+w/6hec1xtErVfsfYOEaxRX2HeG7wPYkDb6Zm
         iEhqYR/Et9gNvj2qm1bQwttLLVA0y+DT6oxapdcng7HAjDyGJNoH4D6kqRh7RIq2c1xf
         j85m/Dz9Hj9/GK13crb8X+qRoHIobuaqi5lno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7ZP6uHZJ/F6v0hE+9XCHZPml+qtTSgB2HLcg17zVahg=;
        b=b0XH3mYwZF8QIx0NtSEKQAS7asaHIrSY1dAQSdTZ/FWwL91LbMg4d5RsyFbMuV2myF
         91qS7mznfNm8vFDIXcmGE0dFbI9kdWKwfmo03P0BYbGlomZJDws9+WxPXtTx3VXVnW2T
         pRm2+Fwtcrm5e+cxDbSDqrNTV6ubrPtvVd7s0wASokjPc9VxHzTfYoxHhPnSgfK30ZIj
         x0Ah34E4dKN4G4MmeUx5KxC8U2egqByS6kqN+WRQXWIWZJB0ycA0N6hIm5Y+m9DmFINj
         KK83j7FrDYgxabJxg3tmiKn/lsuprzcUSIAJlrA5i93eGFYj1ANBbjNkZcoBh34QMmDN
         dvCA==
X-Gm-Message-State: ABuFfohj6D6jx7o7kplDoyqQ3wX9NzWNXf2LuBPPZfvWrPNrd6RXKueP
        FxebC/A6e+KfX2DlSK3VFkVSJVF4EgUoY0XjhwZoZQ==
X-Google-Smtp-Source: ACcGV613ekwxS4mhn0o/HuC7QnP7m4OeKwydKvSLqjXfVQnh8Shx77WNWCyBz5C12IIom9s555nFiMlqPNrb5hAoegI=
X-Received: by 2002:a24:6b4d:: with SMTP id v74-v6mr11671977itc.26.1540296825542;
 Tue, 23 Oct 2018 05:13:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 05:13:05
 -0700 (PDT)
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Oct 2018 14:13:05 +0200
Message-ID: <CAPDyKFrxJNM9TShLJhYm6L+Pp7F77u8FQ3Lk2WmatAma772btA@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 October 2018 at 10:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So I've obviously started pulling stuff for the merge window, and one
> of the things I noticed with Greg doing it for the last few weeks was
> that he has this habit (or automation) to send Ack emails when he
> pulls.
>
> In fact, I reacted to them not being there when he sent himself his
> fake pull messages. Because he didn't then send himself an ack for
> having pulled it ;(
>
> And I actually went into this saying "I'll try to do the same".
>
> But after having actually started doing the pulls, I notice how it
> doesn't work well with my traditional workflow, and so I haven't been
> doing it after all.
>
> In particular, the issue is that after each pull, I do a build test
> before the pull is really "final", and while that build test is
> ongoing (which takes anything from a few minutes to over an hour when
> I'm on the road and using my laptop), I go on and look at the *next*
> pull (or one of the other pending ones).
>
> So by the time the build test has finished, the original pull request
> is already long gone - archived and done - and I have moved on.
>
> End result: answering the pull request is somewhat inconvenient to my
> flow, which is why I haven't done it.
>
> In contrast, this email is written "after the fact", just scripting
> "who did I pull for and then push out" by just looking at the git
> tree. Which sucks, because it means that I don't actually answer the
> original email at all, and thus lose any cc's for other people or
> mailing lists.  That would literally be done better by simple
> automation.
>
> So I've got a few options:
>
>  - just don't do it
>
>  - acking the pull request before it's validated and finalized.
>
>  - starting the reply when doing the pull, leaving the email open in a
> separate window, going on to the next pull request, and then when
> build tests are done and I'll start the next one, finish off the old
> pending email.
>
> and obviously that first option is the easiest one. I'm not sure what
> Greg did, and during the later rc's it probably doesn't matter,
> because there likely simply aren't any overlapping operations.
>
> Because yes, the second option likely works fine in most cases, but my
> pull might not actually be final *if* something goes bad (where  bad
> might be just "oops, my tests showed a semantic conflict, I'll need to
> fix up my merge" to "I'm going to have to look more closely at that
> warning" to "uhhuh, I'm going to just undo the pull entirely because
> it ended up being broken").
>
> The third option would work reliably, and not have the "oh, my pull is
> only tentatively done" issue. It just adds an annoying back-and-forth
> switch to my workflow.
>
> So I'm mainly pinging people I've already pulled to see how much
> people actually _care_. Yes, the ack is nice, but do people care
> enough that I should try to make that workflow change? Traditionally,
> you can see that I've pulled from just seeing the end result when it
> actually hits the public tree (which is yet another step removed from
> the steps above - I do build tests between every pull, but I generally
> tend to push out the end result in batches, usually a couple of times
> a day).
>
> Comments?

Welcome back!

I have no strong opinions, in regards to the acks.

Your current approach, with no ack at all, just means that I have to
do "git remote update" a few times, which I probably would have done
anyways. So, to me, feel free to pick whatever option that makes the
life easiest for you.

Kind regards
Uffe
