Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66902C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3044720827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3044720827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbeKGULx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:11:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52819 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeKGULx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:11:53 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 462A9224DE; Wed,  7 Nov 2018 11:42:04 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id D3B5C224CD;
        Wed,  7 Nov 2018 11:41:53 +0100 (CET)
Date:   Wed, 7 Nov 2018 11:41:53 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Rob Herring <rob.herring@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kirill@shutemov.name, Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>, jacek.anaszewski@gmail.com,
        axboe@kernel.dk, Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181107114153.187fbc25@bbrezillon>
In-Reply-To: <87zhutdrt7.fsf@concordia.ellerman.id.au>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
        <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
        <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
        <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1>
        <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
        <20181023200408.GA13179@chatter.qube.local>
        <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
        <CABGGiszsw=QXPwTe3mf26BG=Pxig6zGcXXJfRA+w0Pawrm5qpQ@mail.gmail.com>
        <20181026211504.GG27137@sirena.org.uk>
        <87zhutdrt7.fsf@concordia.ellerman.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On Thu, 01 Nov 2018 21:18:28 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Mark Brown <broonie@kernel.org> writes:
> 
> > On Fri, Oct 26, 2018 at 12:36:14PM -0500, Rob Herring wrote:  
> >> On Thu, Oct 25, 2018 at 9:14 AM Linus Torvalds
> >> <torvalds@linux-foundation.org> wrote:  
> >  
> >> > Are there other situations where you might want to track something
> >> > _outside_ of a pull request? Maybe. I can't really think of a lot of
> >> > them, though. Patches etc don't have commit ID's to track, but it  
> >
> > patchwork gives them IDs and lets you do lookups using them, that's what
> > I'm doing.  You can get the ID from a git commit by piping the output of
> > git show into parser.py from the patchwork source, it works a lot of the
> > time but things like editing the commit message will break it (this is a
> > theme with my scripting around the mail stuff...).
> >  
> >> submissions. For example, with Greg and Mark B you can expect an
> >> automated replies. Mark's reply gets threaded with the original, but
> >> Greg's do not. For networking, you may or may not get a manual reply,  
> >
> > Mine *mostly* gets threaded, it's relying on being able to talk to
> > patchwork to figure out the message ID at the minute so if the patchwork
> > lookup fails for whatever reason it'll just use on what's in the commit
> > for the CC list and not thread.  That isn't ideal, especially when I'm
> > travelling and my network connection isn't the best, I keep meaning to
> > try to figure out a better way which would probably be based on git
> > notes as discussed earlier.  
> 
> Yeah I use git notes for this.
> 
> When I apply a patch I record the patchwork id in a git note, I have a
> custom hacked pwclient that does it automatically. I also download the
> full mbox from patchwork and stash it in .git/patchwork/<patch id>.
> 
> Then I have everything I need to generate a properly threaded reply to
> the original mail.
> 
> The git notes work well, if you add the following to your .git/config:
> 
> [notes]
> 	rewriteRef = refs/notes/*
> 	displayRef = refs/notes/*
> 
> Then all notes are copied when you rewrite a commit (rebase), and also
> displayed by eg. git show.
> 
> Every now and then if you do extensive rebasing/splitting you get
> commits with the wrong or no patchwork ids. But that's pretty rare and
> not that hard to fixup when it happens.
> 
> There's a slightly sanitised version of some of my scripts here:
>   https://github.com/mpe/patchwork-scripts

I had pretty much the same workflow to automatically update the patch
status in patchwork when I push things to the MTD tree, but I was
lacking the part sending notifications (this was done manually).

With your scripts this is now addressed, thanks a lot for sharing
them!

Boris
