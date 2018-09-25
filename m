Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC15C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E91320843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="o0uvAc/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E91320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeIZEkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:40:47 -0400
Received: from imap.thunk.org ([74.207.234.97]:47170 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725736AbeIZEkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BJ+VKPWU9gRo959QUFZFDBXCPxV8QYw4ibR8tiiazdw=; b=o0uvAc/4vzqbm9jNMIrJLlubCA
        AUb9UZlAzxHQWCuQ/2uHtD5t6k/4LxFd4x4djD4ecMtxgU5S7RXRlZ4rHnThm5nqVoH4KcZpMkNO1
        3HNib33I6Jkw7sPVH0H5CmJUlpX2mSNUfh4QI8frQuJk2D3Ene4ojA1hpTou4VJjgVUI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g4vr5-00046D-Ao; Tue, 25 Sep 2018 22:30:55 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6671E7A54D5; Tue, 25 Sep 2018 18:30:54 -0400 (EDT)
Date:   Tue, 25 Sep 2018 18:30:54 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: POSIX violation by writeback error
Message-ID: <20180925223054.GH2933@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeff Layton <jlayton@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
References: <CAJDTihx2yaR-_-9Ks1PoFcrKNZgUOoLdN-wRTTMV76Jg_dCLrw@mail.gmail.com>
 <486f6105fd4076c1af67dae7fdfe6826019f7ff4.camel@redhat.com>
 <20180925003044.239531c7@alans-desktop>
 <0662a4c5d2e164d651a6a116d06da380f317100f.camel@redhat.com>
 <20180925154627.GC2933@thunk.org>
 <23cd68a665d27216415dc79367ffc3bee1b60b86.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23cd68a665d27216415dc79367ffc3bee1b60b86.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:41:18PM -0400, Jeff Layton wrote:
> That's all well and good, but still doesn't quite solve the main concern
> with all of this. It's suppose we have this series of events:
> 
> open file r/w
> write 1024 bytes to offset 0
> <background writeback that fails>
> read 1024 bytes from offset 0
> 
> Open, write and read are successful, and there was no fsync or close in
> between them. Will that read reflect the result of the previous write or
> no?

If the background writeback hasn't happened, Posix requires that the
read returns the result of the write.  And the user doesn't know when
or if the background writeback has happened unless the user calls
fsync(2).

Posix in general basically says anything is possible if the system
fails or crashes, or is dropped into molten lava, etc.  Do we say that
Linux is not Posix compliant if a cosmic ray flips a few bits in the
page cache?  Hardly!  The *only* time Posix makes any guarantees is if
fsync(2) returns success.  So the subject line, is in my opinion
incorrect.  The moment we are worrying about storage errors, and the
user hasn't used fsync(2), Posix is no longer relevant for the
purposes of the discussion.

> The answer today is "it depends".

And I think that's fine.  The only way we can make any guarantees is
if we do what Alan suggested, which is to imply that a read on a dirty
page *block* until the the page is successfully written back.  This
would destroy performance.  I know I wouldn't want to use such a
system, and if someone were to propose it, I'd strongly argue for a
switch to turn it *off*, and I suspect most system administators would
turn it off once they saw what it did to system performance.  (As a
thought experiment, think about what it would do to kernel compiles.
It means that before you link the .o files, you would have to block
and wait for them to be written to disk so you could be sure the
writeback would be successful.  **Ugh**.)

Given that many people would turn such a feature off once they saw
what it does to their system performance, applications in general
couldn't rely on it.  which means applications who cared would have to
do what they should have done all along.  If it's precious data use
fsync(2).  If not, most of the time things are *fine* and it's not
worth sacrificing performance for the corner cases unless it really is
ultra-precious data and you are willing to pay the overhead.

					- Ted
