Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD8CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6506C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="elb4NcL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6506C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeJXE01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:26:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40651 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXE01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:26:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id t22-v6so2577086lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGQhajEsHPuvoFP1ey0+yL7w0mb71sxXCB56avEz+oI=;
        b=elb4NcL6aiOSuIaZYFBPqdECqhxzjV382A8X1Ed9EflrzUhaKbmdNJKBOoaM0PzjA4
         Gzd8gMXz5vNcQr4D6G9DXHAhFr/9SCvVoMugJCfXcRvZ0vNg5QvyfMk/QcsMzwlzWzmy
         ZCIUaQlp19qt1Ax2uD+or3OyTnIVOlGjT29jaSVTDhI+b/LjSVSTo14BmzcGTr+LlWNX
         golCTRGcQRdeuyHYPpA8KSmcY/7+61vTDijtxwt9S8KiOVsHdB71WJYndejA8l5GBlZm
         PJ3+yXXqztpD3z/vByj/E4k9qN1Oh9a6DHkGfY2IWIvCoAchPbq0BnjuvaqbGnpdJoNT
         e2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGQhajEsHPuvoFP1ey0+yL7w0mb71sxXCB56avEz+oI=;
        b=ARJPMHbZ1Ix3zojxmMqUQNZ5/uM2RKHGrp+vaLVAXmmIs3fyrpaoyVEjfGmnVZ95db
         44/6plFH/F4RqHZU/0sP1iQitiiLCO/ZeLWIr5wKDcKn7aHhOM1KlvmNu2ZX0nob2nyh
         5o/HkAmzkFg0O8YBSD7oc1EHPgnFDeqX6NvKH33DYz0T7O5zmjEe+ZLL5MocbteOxWBJ
         nn2sy80cHAUE/jKIWhDXvfpk7wvKhVDTb0xD/7eXelonLRLeeuWsoRhUDr8mNw0y0FXm
         nD9OzyxFvCXj2kQ78n/6VdYBENm9HFTP88+vHxEDMJXOoibPIxrRivzzFZQgC2DhC+QZ
         bT7w==
X-Gm-Message-State: ABuFfoiyzclvNyi7cBun+JLDdmFywevHpsbGhqOInWl2GI43kwEmCw7L
        wtMvGNzgiv14d9bsrbX1GTS04ZD2VJlVgD9UAjocuQ==
X-Google-Smtp-Source: ACcGV63Hwj4bTW9nzi/08C3FDi3RvQS0A665yKJUM7lF/X+sONuec98Fx45qDwIiUJAbgFaCdga76nYa1zh/a3nfilQ=
X-Received: by 2002:a2e:f02:: with SMTP id 2-v6mr33388339ljp.134.1540324892022;
 Tue, 23 Oct 2018 13:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 23 Oct 2018 21:01:19 +0100
Message-ID: <CAOesGMjUUxUFZGAwh_uvOyvNxUJZNE__omLjSLzy3_BXtu_3kQ@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>, hch@lst.de,
        Guenter Roeck <linux@roeck-us.net>, jacek.anaszewski@gmail.com,
        Jens Axboe <axboe@kernel.dk>,
        LinusW <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 9:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
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

It's funny, because the first time I saw a reply from Greg on a pull
request, I thought I had done something wrong -- I've been so used to
only getting replies when there's something not right with it.

Like others, I'm used to polling for material showing up, and either
way is fine with me.

For pull requests we do, we normally reply (since it makes it easier
to see what pull requests have been handled when you share them). In
my case, I write the reply immediately, but I use msmtp-queue and mutt
to do it, and don't send the queue until I'm done with the current
batch of pull requests, so I sometimes go back and revoke a message
before it has gone out. It doesn't work for web-gmail use cases.

> Because yes, the second option likely works fine in most cases, but my
> pull might not actually be final *if* something goes bad (where  bad
> might be just "oops, my tests showed a semantic conflict, I'll need to
> fix up my merge" to "I'm going to have to look more closely at that
> warning" to "uhhuh, I'm going to just undo the pull entirely because
> it ended up being broken").

1 + the last follow-up would be fine with me. I doubt anyone will just
delete their material within minutes of getting the initial reply.



-Olof
