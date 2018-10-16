Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D9CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5312F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="lkNblePg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5312F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJPXos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:44:48 -0400
Received: from imap.thunk.org ([74.207.234.97]:49258 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeJPXos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7lyAPeRoBMlDxeDCiuP47JCtTdGPmc8m+et3nnv+BSc=; b=lkNblePgSczrWU1KXcgypsP2Ig
        YNVu8TCY4pV4WJcmyQ74YJkH9cNBzvPQrpaL5rZce7ENraKyQicHz4OR1xXToFLWOBl2Vl+AiLSnZ
        VgsAv2gqEtYiU8+Bb+1MILtJKa5vzrYMUQgubh8eQFHCch0Fbd/oi7yy7iD4rkxx3PYI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gCRfC-0005zO-DX; Tue, 16 Oct 2018 15:53:42 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 536CD7A4986; Tue, 16 Oct 2018 11:53:41 -0400 (EDT)
Date:   Tue, 16 Oct 2018 11:53:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in ext4_invalidatepage
Message-ID: <20181016155341.GF8983@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+85da7ac734f7ba432ee4@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000002753c60577b9f707@google.com>
 <CACT4Y+bdR3ch9q_FCND4YmqjunYBVbEk3n167DT0r0GqzVKL-g@mail.gmail.com>
 <20181009013425.GB3369@thunk.org>
 <CACT4Y+a08tYAgXKEiTO+A-RDrSNk-RdhDxvGCM6bAbk5bckH6A@mail.gmail.com>
 <20181015180821.GE8983@thunk.org>
 <CACT4Y+bs72L4GKF7K6zHHqDGfURymzUke7UT6CKtakLWu+f94g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bs72L4GKF7K6zHHqDGfURymzUke7UT6CKtakLWu+f94g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:02:07PM +0200, Dmitry Vyukov wrote:
> I am not sure how exactly this should be classified. To significant
> degree these "$FOO" discriminations are informational and only really
> affect the data format passed in.

The problem is that putting something which is simply and plainly
*wrong* is going to be actively misleading.  You *have* to know what
ioctl you are trying to be trying to execute because some of them
require input data structures that you have to fill in, or that it
requires a file descriptor as opposed to an integer or a pointer to a
struct.  I assume you're not just picking ioctl numbers purely at
random, right?

So I assume you had a table that said, this ioctl, 0x6611 takes a file
descriptor, and has thus-and-so-a-name.  If that name is wrong, I'd
say it's pretty clearly a bug, right?

(I'll again gently point out that a tiny amount of work in making
syzkaller a tiny bit more developer toil would make it much more
effective, since all of this extra developer toil --- now I know I
can't even trust the $FOO discriminators to be right --- makes
syzkaller less scalable by pursuading developers that it's not
worthwhile to pay attention...)

> > The patch I referenced in my previous e-mail protects against
> > additional scenarios where someone might be trying to punch a whole
> > into a file that is being swapped into the bootloader ioctl.  This
> > particular ioctl isn't yet being used by anyone, so it had some other
> > issues as well, such as not interacting well with inline_data-enabled
> > file systems --- not that any bootloader would be small enough that it
> > would fit in an inline_data inode, but we're basically proofing the
> > code against a malicious (or buggy) root-privileged program... such as
> > syzbot.  :-)
> 
> ... or paving the way to opening all of this to non-root users. Why
> not if not bugs? ;)

The intent behind this particular ioctl is used to install a boot
loader.  It will *never* be opened to non-root users.  It doesn't even
make sense to make it available to pseudo-containers-root users.  :-)

							- Ted
