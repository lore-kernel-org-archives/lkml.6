Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A16EC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 03:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384D92082C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 03:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="PykhxD1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384D92082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeJ0MPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 08:15:40 -0400
Received: from imap.thunk.org ([74.207.234.97]:34388 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeJ0MPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 08:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=b/TxJuMdn3viuwjrsHaYqV136V/qHzY/u/OMsL9bjmg=; b=PykhxD1NLPkQ+9bUYbAmXQT70j
        TedClLhVy5JAkpsl9i2EeuvRojFlfWo+yRYtdMa0hWZ0eYUf5Z2GMjgq4X8VDsx658v8f3Aou8zks
        0WMZABCr4fGGbs1wkMTcm1co1ggmKFUptbUg3Na30sIJyQJHQN5UXpAZXe1zvv0aM3uQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gGFOD-0006BC-GJ; Sat, 27 Oct 2018 03:35:53 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 52E917A0147; Fri, 26 Oct 2018 23:35:52 -0400 (EDT)
Date:   Fri, 26 Oct 2018 23:35:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bvanassche@acm.org, Linus Torvalds <torvalds@linux-foundation.org>,
        ooo@electrozaur.com, Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181027033552.GA29237@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>, bvanassche@acm.org,
        Linus Torvalds <torvalds@linux-foundation.org>, ooo@electrozaur.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
References: <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox>
 <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org>
 <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
 <1540589437.66186.124.camel@acm.org>
 <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
 <1540591147.66186.127.camel@acm.org>
 <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 03:07:39PM -0700, Nick Desaulniers wrote:
> > That's not completely correct. The standard approach to check whether or not
> > a driver is still being used is to check its git history. If the number of
> > contributors is low and it was several years ago that a new feature was added
> > or a bug has been fixed it is likely that nobody is using that driver anymore.
> 
> I don't disagree with you, I just don't see how what you state can be
> reconciled with Linus' response in
> https://lkml.org/lkml/2018/10/27/44.  Those two viewpoints seem
> incompatible to me, but maybe there's a nuance I'm missing?

So a couple of observations.  Obviously, drivers, file systems and
architectures *have* been removed.  It can be done; sometimes if it
can be demonstrate that it can't possibly work (for example, due to
bitrot, the kernel would immediately crashed if anyone tried to use
the code in question :-).

In other cases, drivers has been removed through the staging
subsystem, sometimes by adding a "depends on BROKEN" in the Kconfig
file, and seeing if anyone complains --- since removing a "depends on
BROKEN" line in Kconfig is even easier than doing reverting a git
commit (especially if the user downloaded a tarball instead of doing a
git clone).

If you've done your due diligence then the chances that you have to
revert a change which disables and later removes the dead code can be
pushed close to zero.  The question is whether it's worth the effort.

> Nathan and I are just pointing out a small fix to eliminate a small
> warning, deleting all this code does kind of feels like "throwing out
> the baby with the bath water." A nuclear option for what would be a
> small change otherwise.  Maybe it's good to discuss the EOL for
> exofs/osd, but can we please decouple that conversation from the small
> change Nathan and I are proposing?

The second observation I'll make is that if someone is proposing a
cleanup patch, it's unfair to dump on the person proposing the cleanup
patch the (non-trivial) effort to drop a driver/file system/subsystem.

If the maintainer wants to drop a driver/file system, that should be
the maintainer's responsibiltiy; not someone proposing a
cleanup/maintenance patch.

						- Ted
