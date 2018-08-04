Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E4C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 19:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDC4217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 19:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="T/22jwqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDC4217CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeHDVjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 17:39:47 -0400
Received: from imap.thunk.org ([74.207.234.97]:37762 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbeHDVjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 17:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6MCOIu8MrzxB5SFwERmgaFIs98/2D549kY2wye9tBfs=; b=T/22jwqQIcaSkm2OJv5TxCmxkc
        wDnPu9jAQgs/rOw9RYerJXDj64WAQVgjRXiCRQeuABBuYqStaZxDneNS3HS0IC8/QX9UijVn+jM6U
        cBql0ZQveTOZYzpou/PQSKGe1SM/GWUQvJX7QvZ75di2PqhNt7TcfG02JaFC4KXPEmiI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fm2N8-0001WE-O0; Sat, 04 Aug 2018 19:37:54 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D53587A64C9; Sat,  4 Aug 2018 15:37:53 -0400 (EDT)
Date:   Sat, 4 Aug 2018 15:37:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
Subject: Re: LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180804193753.GC4461@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mike Snitzer <snitzer@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
References: <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com>
 <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
 <20180803185431.GB3258@redhat.com>
 <CA+55aFwDEY7B6OMh5xL2wc8BRj1KkzBHggNowAjbsWfma6H5Zg@mail.gmail.com>
 <20180803193037.GA4581@redhat.com>
 <20180804052033.GA4461@thunk.org>
 <102c2d75-f768-a649-52c3-bac6f0ca738d@redhat.com>
 <20180804162205.GB4461@thunk.org>
 <20180804181845.GA10499@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804181845.GA10499@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 02:18:47PM -0400, Mike Snitzer wrote:
> > Fair enough.  I don't think I would consider that makes dm-snapshot a
> > "steaming pile".  For me, protection against data loss is Job One.
> 
> What's your point Ted?  Do you have _any_ intention of actually using
> anything DM or is this just a way for you to continue to snipe at it?

My point is that putting down dm-snapshot by calling it a "steaming
pile" because it can't perform well on workloads that weren't a
requirement when it was first designed is neither accurate nor fair.
And steering users away from it by badmouthing to a technology which
ever so often, requires enterprise support to recover, is something
that *I* at least would classify as "marginal".

Maybe it's just that file system developers have higher standards.  I
know that Dave Chinner at LSF/MM commented that using some of the
things he has been developing for XFS subvolume support might be
interesting precisely because it could provide some of the facilities
currently provided by thin provisioning (perhaps not all of them; I'm
not sure how well his virtual block remapping layer would handle
hundreds of snapshots) but with file system tools which have a lot
more seasoning and where people have spent a lot of effort on data
recovery tools.

In any case, I do use DM quite a lot.  I use LVM2 and dm-snapshot (and
it's been working just *fine* for my use cases).  I've wanted to use
dm-thin, but have been put off by it being labeled as experimental and
by some of the comments about how robust its recovery tools are.  If
there was documentation about how an advanced user/developer could use
low level tools to do manual repair of a thin pool when the automated
procedures didn't work, without having to pay $$$ to some company for
"enterprise support", I'd be a lot more willing to give it a try.

Sorry, I just care a *lot* about data robustness.

> Maybe read your email from earlier today before repeating yourself:
> https://lkml.org/lkml/2018/8/4/366

Apologies.  I'm currently staying at an Assisted Living facility
keeping an eye on my Dad this week, and the internet at the senior
living center has been.... marginal.  As a result I've been reading my
e-mail in batches, and so I hadn't seen the e-mail you had posted
earlier before I had sent my reply.

					- Ted
