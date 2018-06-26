Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30ECC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0EF26C05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="E1T2U/6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0EF26C05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965882AbeFZOQU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:16:20 -0400
Received: from imap.thunk.org ([74.207.234.97]:56094 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934518AbeFZOQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0MimxU6a2WqxYotoDIoEUejNWn1sOiQpiebz0bEb4bY=; b=E1T2U/6INTcpvEzVVo1cq8X8Su
        Vvlc0ddRLbC1CLaYDWKcm3MfYrWzo2MX99LWQqzL3BMBP1mbjm454toIwwTl1+xWm+URabe5yZ+8z
        fhHB/mq/cnupm34Stmd7uCY/pcBr2j+SpkmOrtdbfELjuvEXMSyi3O2GBAGsrIjTR7cE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fXolH-00086Q-Ov; Tue, 26 Jun 2018 14:16:03 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A8C047A4480; Tue, 26 Jun 2018 10:16:02 -0400 (EDT)
Date:   Tue, 26 Jun 2018 10:16:02 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: what trees/branches to test on syzbot
Message-ID: <20180626141602.GA17788@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com>
 <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
 <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
 <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
 <b9aa57f5-9204-dc97-bfd6-d53ed2e0ae12@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9aa57f5-9204-dc97-bfd6-d53ed2e0ae12@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:54:53PM +0900, Tetsuo Handa wrote:
> I hope we can accept NOW either "reviving linux-next.git" or "allowing debug printk()
> patches for linux.git". For example, "INFO: task hung in __sb_start_write" got 900
> crashes in 81 days but still unable to find a reproducer. Dmitry tried to reproduce
> locally with debug printk() patches but not yet successful. I think that testing with
> http://lkml.kernel.org/r/f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp
> on linux.git or linux-next.git is the only realistic way for debugging this bug.
> More we postpone revival of the linux-next, more syzbot reports we will get...

Here's a proposal for adding linux-next back:

*) Subsystems or maintainers need to have a way to opt out of getting
   spammed with Syzkaller reports that have no reproducer.  More often
   than not, they are not actionable, and just annoy the maintainers,
   with the net result that they tune out all Syzkaller reports as
   noise.

*) Email reports for failures on linux-next that correspond to known
   failures on mainline should be suppressed.  Another way of doing
   this would be to only report a problem found by a specific
   reproducer to the mailing list unless the recipient has agreed to
   be spammed by Syskaller noise.

And please please please, Syzkaller needs to figure out how to do
bisection runs once you have a reproducer.

						- Ted
