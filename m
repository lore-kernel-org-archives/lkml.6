Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C4AC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C0C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfAUMha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:37:30 -0500
Received: from mail-a05.ithnet.com ([217.64.83.100]:34966 "EHLO
        mail-a05.ithnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfAUMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:37:29 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2019 07:37:29 EST
Received: (qmail 11876 invoked by uid 0); 21 Jan 2019 12:30:47 -0000
Received: from skraw@ithnet.com by mail-a05 
 (Processed in 2.635684 secs); 21 Jan 2019 12:30:47 -0000
X-Virus-Status: No
X-ExecutableContent: No
Received: from unknown (HELO ithnet.com) (217.64.64.14)
  by mail-a05.ithnet.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 21 Jan 2019 12:30:45 -0000
X-Sender-Authentication: SMTP AUTH verified <skraw@ithnet.com>
Date:   Mon, 21 Jan 2019 13:30:44 +0100
From:   Stephan von Krawczynski <skraw@ithnet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rene Schickbauer <cavac@cavac.at>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Hutter, Tony" <hutter2@llnl.gov>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190121133044.28b6194b@ithnet.com>
In-Reply-To: <20190115134221.GB30742@kroah.com>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
        <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
        <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
        <20190109165235.GA8151@kroah.com>
        <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
        <20190110131132.GC20217@kroah.com>
        <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
        <20190110180752.f4cnunadzzkev24m@linutronix.de>
        <20190110182413.GA6932@kroah.com>
        <46a97264-9586-ef67-73a0-9af1c4d34f25@cavac.at>
        <20190115134221.GB30742@kroah.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 14:42:21 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Tue, Jan 15, 2019 at 02:01:48PM +0100, Rene Schickbauer wrote:
> > To be frank, your argument, which boils down to "GPL is the only correct
> > open source license", makes me ashamed to have been advocating people
> > switching to Linux. This is exactly the kind of argument that made me
> > switch away from closed source operating systems like Windows, only then
> > it was Steve Ballmer using it against open source.  
> 
> What?
> 
> No, my argument is, "If you want to interact directly with Linux kernel
> code in kernel-space, then you have to abide by it's license, which is
> GPLv2".  That's it.  If you wish to use open source code by another
> license, wonderful, I'm not telling you what you can, and can not do,
> but please, do not violate the license of the code I contributed under
> GPLv2.
> 
> ZFS could be the best filesystem ever to grace this planet, that's
> fantastic, but given that the creators of that code placed it under a
> license that was specifically designed to not be compatible with Linux
> to prevent it from ever being used on Linux, well, you can see why I
> really don't care about it.  Why would I?
> 
> Those copyright owners (well license owner at this point in time) could
> fix this all tomorrow if they wanted to.  But they do not, so _THEY_ are
> the people you should be upset at.  Not at the Linux kernel developers
> who are giving you a kernel on which to use on your systems, for free,
> under the GPLv2.  Our position has always been very clear and upfront.
> And really, so has the ZFS license creators.  So why is anyone upset
> about all of this?  Nothing new has changed here with the license of
> anything.
> 
> best of luck!
> 
> greg k-h

Hi Greg,

I'd say this is in fact more a moral question than a technical or legal issue.
The true background is the simple question what the project (i.e. linux) is in
fact all about, is it about helping people with lower skills or is it about
ruling people. A company (more or less every company) is more about ruling,
its aim is to move people into buying and using its products. Me (and quite
surely Rene at least) think that the linux _community_ is more about helping
others and hopefully less about legal and technical ruling.
So your argument "go to the company XYZ and blame them" isn't really
targetting in the right direction - as long as you see linux still as a
community thing and not as a cash-cow company-alike. Maybe it would be a lot
better to think about why there are people using ZFS and not some GPLed fs
instead. Me too being a ZFS user I can tell you the simple fact that there is
no GPL fs with equal features and stability (eh BTRFS). In fact quite some of
us would probably use HAMMER2 (thanks Matt) instead if sure that it equals ZFS
in terms of stability, still not BTRFS. So all you promote currently is the fs
deficit linux actually still has (and had for years, or say decades). I doubt
that this is/was helping the linux community a lot...
Sure maintainers have to rule sometimes, but it only makes sense if you are
able to present a working equal alternative. If you have none (and in this case
you have no alternative to offer) you will only push people away from the
community and that's probably not the right path for a community maintainer.
-- 
Only my 2ct,
Stephan
