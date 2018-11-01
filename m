Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58DEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5E620657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5E620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeKBGuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:50:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54767 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeKBGuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:50:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3C3CC807F4; Thu,  1 Nov 2018 22:45:27 +0100 (CET)
Date:   Thu, 1 Nov 2018 22:45:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 4.4 50/92] mm: filemap: avoid unnecessary calls to
 lock_page when waiting for IO to complete during a read
Message-ID: <20181101214528.GA1552@xo-6d-61-c0.localdomain>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524093204.290399449@linuxfoundation.org>
 <20180524105011.jkmjrmoyqtogtgnn@quack2.suse.cz>
 <20180524110546.GA16171@kroah.com>
 <CANsGZ6bsz-J9XB_O5+B+mmRV2CGaJ8e+Aa=N3WnE7YNARWsAnw@mail.gmail.com>
 <20180524112841.GA17626@kroah.com>
 <CANsGZ6anzAW3dcEQqgfRGxnk+n4ih_PpKOCGdcHv_SF86x2-0g@mail.gmail.com>
 <20180524190611.GD31019@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524190611.GD31019@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I've no wish to be disputatious, but it does seem that the definition of
> > > > "stable" has changed, and not necessarily for the better, if it's now a
> > > > home for small gains: I thought we left those to upstream.
> > 
> > > This is in the SLES kernel for a reason, and again, it's in the section
> > > that says "this should be pushed to stable".  So if it's good enough for
> > > the SLES kernel, why isn't it good enough for all users of this kernel
> > > tree?
> > 
> > > If you all think it should be dropped in both places, that's fine with
> > > me :)
> > 
> > I think they are perfectly fine in SLES: folding in good work is a part of
> > what distros are about.
> 
> And it's also what stable is for.  We have had backports of performance
> improvements in the past, along with lots of other things over the
> years.  This is a performance improvement.  A tiny one, yes, but getting
> rid of a lock is a good thing, and I picked it up as part of my review
> of what a distro decided was worth adding for their users, as that's a
> huge signal that might be of value to others.
> 
> > But I cannot find anything in stable-kernel-rules.rst that would admit them
> > - perhaps that's just out of date?
> 
> Nope, that's the list I use to say "no" to.  You can't describe
> everything in that file, it's a judgement call.

Well, it would be good if the documentation matched reality, because other people
use the documentation to decide, too.

For example, documentation says bug has to be fixed in mainline, but in actual practice
you try to have exactly the same patch.

										Pavel
