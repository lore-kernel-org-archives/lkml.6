Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03023C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07A32083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="dpE+BZgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07A32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLHRS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:18:58 -0500
Received: from imap.thunk.org ([74.207.234.97]:36754 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeLHRS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aH/AvSf8r/c7dKKkqXP5mLVEihcY3xlRZqAipPm0QN0=; b=dpE+BZgPptgGzX6pJoqdPUQ98u
        Fmpy6vTXVnEpW5ij0UNqf555Pzd4BukgnD78mQDMOZmKTCeZuNm73wJ3mqBCfLVm6BVMlmF26DNlo
        cY7nnKQ1DUxWtUDowIE7eHqyKj87UIHLLdhpVoJwShmeiZCxUkTNYX/386nSIZnF5unw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gVgFj-0001YB-3s; Sat, 08 Dec 2018 17:18:55 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4E0B97A0332; Sat,  8 Dec 2018 12:18:53 -0500 (EST)
Date:   Sat, 8 Dec 2018 12:18:53 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Laura Abbott <labbott@redhat.com>, stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Process for severe early stable bugs?
Message-ID: <20181208171853.GA20708@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>, stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c04ea7b1-23f3-f1e0-4f31-07b62abdee24@redhat.com>
 <20181208115629.GA3288@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208115629.GA3288@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 12:56:29PM +0100, Greg KH wrote:
> A nice step forward would have been if someone could have at least
> _told_ the stable maintainer (i.e. me) that there was such a serious bug
> out there.  That didn't happen here and I only found out about it
> accidentally by happening to talk to a developer who was on the bugzilla
> thread at a totally random meeting last Wednesday.
> 
> There was also not an email thread that I could find once I found out
> about the issue.  By that time the bug was fixed and all I could do was
> wait for it to hit Linus's tree (and even then, I had to wait for the
> fix to the fix...)  If I had known about it earlier, I would have
> reverted the change that caused this.

So to be fair, the window between when we *know* what was the change
that required reverting and the fix actually being available was very
narrow.  For most of the 3-4 weeks when we were trying to track it
down --- and the bug had been present in Linus's tree since
4.19-rc1(!) --- we had no idea exactly how big the problem was.

If you want to know about these sorts of things early --- at the
moment the moment I and others at $WORK have been trying to track down
a problem on a 4.14.x kernel which has symptoms that look ***eerily***
similar to Bugzilla #201685.  There was another bug causing mysterious
file system corruptions that may also be related that was noticed on
an Ubuntu 4.13.x kernel which forced another team to fall back to a
4.4 kernel.  Both of these have caused file system corruptions that
resulted in customer visible disruptions.  Ming Lei has now said that
there is a theoretical bug which he now believes might be present in
blk-mq starting in 4.11.

To make life even more annoying, starting in 4.14.63, disabling blk-mq
is no longer even an *option* for virtio-scsi thanks to commit
b5b6e8c8d3b4 ("scsi: virtio_scsi: fix IO hang caused by automatic irq
vector affinity"), which was backported to 4.14 as of 70b522f163bbb32.
We might try reverting that commit and then disabling blk-mq to see if
it makes the problem go away.  But the problem happens very rarely ---
maybe once a week across a population of 2500 or so VM's, so it would
take a long time before we could be certain that any change would fix
it in absence of a detailed root cause analysis or a clean repro that
can be run in a test environment.

So now you know --- but it's not clear it's going to be helpful.
Commit b5b6e8c8d3b4 was fixing another bug, so reverting it isn't
necessarily the right thing, especially since we can't yet prove it's
the cause of the problem.  It was "interesting" that we forced
virtio-scsi to use blk-mq in the middle of a LTS kernel series,
though.

> I would start by looking at how we at least notify people of major
> issues like this.  Yes it was complex and originally blamed on both
> btrfs and ext4 changes, and it was dependant on using a brand-new
> .config file which no kernel developers use (and it seems no distro uses
> either, which protected Fedora and others at the least!)

Ubuntu's bleeding edge kernel uses the config, so that's where we got
a lot of reports of bug #201685 initially.  At first it wasn't even
obvious whether it was a kernel<->userspace versioning issue (ala the
dm userspace gotcha a month or two ago).  And I never even heard that
btrfs was being blamed.  That was probably on a different thread that
I didn't see?  I wish I had, since at for the first 2-3 weeks all of
the reports I saw were from ext4 users, and because it was so easy to
have false negative and false positives reports, one user bisected it
to a change in the middle of the RCU pull in 4.19-rc1, and another
claimed that after reverting all ext4 changes between 4.18 and 4.19,
the problem went away.  Both conclusions, ultimately, were false of
course.

So before we have root cause, and a clean reproduction that
*developers* could actually use, if you had seen the early reports,
would you have wanted to revert the RCU pull for the 4.19 merge
window?  Or the ext4 pull?  Unfortunately, there are no easy solutions
here.

> There will always be bugs and exceptions and personally I think that the
> rarity of this one was such that it is a rare event and adding the
> requirement that I have to maintain more than one set of stable trees
> for longer isn't going to happen (yeah, I know you said you didn't
> expect that, but I know others mentioned it to me...) 
> 
> So I don't know what to say here other than please tell me about major
> issues like this and don't rely on me getting lucky and hearing about it
> on my own.

Well, now you know about one of the issues that I'm trying to debug.
It's not at all clear how actionable that information happens to be,
though.  I didn't bug you about it for that reason.

						- Ted

P.S.  The fact that Jens is planning on ripping out the legacy block
I/O path in 4.21, and force everyone to use blk-mq, is not filling me
with a lot of joy and gladness.  I understand why he's doing it;
maintaining two code paths is not easy.  But apparently there was
another discard bug recently that would have been found if blktests
were being run more frequently by developers, so I'm not feeling very
trusting of the block layer at the moment, especially invariably
people always blame the file system code first.

P.P.S.  Sorry if it sounds like I'm grumpy; it's probably because I am.

P.P.P.S.  If I were king, I'd be asking for a huge number of kunit
tests for block-mq to be developed, and then running them under a
Thread Sanitizer.
