Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84153C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A51121A8E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 23:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="XlT4xiYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A51121A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeHIB4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:56:31 -0400
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:39942 "EHLO
        elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728134AbeHIB4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:56:30 -0400
X-Greylist: delayed 8375 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2018 21:56:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1533771273; bh=WhjNGMPGi9N8MOvd3dvkqYp/mdDrpC09T8yE
        CnMaRJc=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=XlT4xiYl9f9Fc3anmYWjVUzs0Pq4CoCHlC/ysW61Bgb8lk
        fu3hk0OQK4dv3JJKvzuTe8WJAg/KmLl3GBJZD414AGQoxXL4R8l6VSQO+CEO2mxVXmD
        gxy0zddI2QUH7+Y1PysthsgVduLvbfPY7qHuxkBMtrBpETUp6A9cASOnVus6z61goE6
        ysjU17H9RmUneJgt9TDUD7yy74wegRCcqpmLEVfWs3dVMYPiOriKr01XMLVFNoz4+EV
        LvilqvBmy6mIFlx2MP8YTPCoBnZf/2/GEWyuBpr5iSNMd62BlaNtYhCHTuvZAJZQbOL
        AfJtC2WctzFCfq/uN2SRv0gBkPUA==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=rNirikhvdsULK8gwoTw1Rxwd90cSvGXfqxBPigr0rVEe9eg3XBjQCvGY8mAwVFgVCDHLSXSNqR9ACB902CyjLFW4NI/mBiiSeatVcU83AAFlGNc7AwXcHRYopKN9XDHgXqdWYyQSyQ/poxIFrFpE0lVnOawDUwG5pbkPZDjdSzjISusT1wiQLytwBTC5RWKtCVMDGc0AreX7eW6RNYLfOJ+BUZYPGmevyPHHvA9+0LN4Lk5e77HKMWX0DpLy/vqDlMgSTQtUuYYl3MLF5m/XGV3q8+FnDlYCfYS22ryODjraNQZ2zEjfpkAj+98orlb9dLGWfdoRuBf6lDg/mdbKPQ==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1fnXyJ-0001Nb-Ge; Wed, 08 Aug 2018 19:34:31 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Jeff Layton'" <jlayton@kernel.org>,
        "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'NeilBrown'" <neilb@suse.com>
Cc:     "'Alexander Viro'" <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Martin Wilck'" <mwilck@suse.de>
References: <153369219467.12605.13472423449508444601.stgit@noble>         <20180808195445.GD23873@fieldses.org> <20180808200912.GE23873@fieldses.org>         <20180808212832.GF23873@fieldses.org> <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org>
In-Reply-To: <04ffa27c29d2bff8bd9cb9b6d4ea6b6fd3969b6c.camel@kernel.org>
Subject: RE: [PATCH 0/4] locks: avoid thundering-herd wake-ups
Date:   Wed, 8 Aug 2018 16:34:31 -0700
Message-ID: <01c401d42f70$5c034db0$1409e910$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQGA9keEcMCkmDAsuHSuCoEfEmhAOAG1/rx6AXpKEjkB2puGxgJiY3FdpSGJP4A=
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d247216e1819e787d03f3f0221b7944de350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2018-08-08 at 17:28 -0400, J. Bruce Fields wrote:
> > On Wed, Aug 08, 2018 at 04:09:12PM -0400, J. Bruce Fields wrote:
> > > On Wed, Aug 08, 2018 at 03:54:45PM -0400, J. Bruce Fields wrote:
> > > > On Wed, Aug 08, 2018 at 11:51:07AM +1000, NeilBrown wrote:
> > > > > If you have a many-core machine, and have many threads all
> > > > > wanting to briefly lock a give file (udev is known to do =
this),
> > > > > you can get quite poor performance.
> > > > >
> > > > > When one thread releases a lock, it wakes up all other threads
> > > > > that are waiting (classic thundering-herd) - one will get the
> > > > > lock and the others go to sleep.
> > > > > When you have few cores, this is not very noticeable: by the
> > > > > time the 4th or 5th thread gets enough CPU time to try to =
claim
> > > > > the lock, the earlier threads have claimed it, done what was =
needed, and
> released.
> > > > > With 50+ cores, the contention can easily be measured.
> > > > >
> > > > > This patchset creates a tree of pending lock request in which
> > > > > siblings don't conflict and each lock request does conflict =
with its parent.
> > > > > When a lock is released, only requests which don't conflict =
with
> > > > > each other a woken.
> > > >
> > > > Are you sure you aren't depending on the (incorrect) assumption
> > > > that "X blocks Y" is a transitive relation?
> > > >
> > > > OK I should be able to answer that question myself, my patience
> > > > for code-reading is at a real low this afternoon....
> > >
> > > In other words, is there the possibility of a tree of, say,
> > > exclusive locks with (offset, length) like:
> > >
> > > 	(0, 2) waiting on (1, 2) waiting on (2, 2) waiting on (0, 4)
> > >
> > > and when waking (0, 4) you could wake up (2, 2) but not (0, 2),
> > > leaving a process waiting without there being an actual conflict.
> >
> > After batting it back and forth with Jeff on IRC....  So do I
> > understand right that when we wake a waiter, we leave its own tree =
of
> > waiters intact, and when it wakes if it finds a conflict it just =
adds
> > it lock (with tree of waiters) in to the tree of the conflicting =
lock?
> >
> > If so then yes I think that depends on the transitivity
> > assumption--you're assuming that finding a conflict between the root
> > of the tree and a lock proves that all the other members of the tree
> > also conflict.
> >
> > So maybe this example works.  (All locks are exclusive and written
> > (offset, length), X->Y means X is waiting on Y.)
> >
> > 	process acquires (0,3)
> > 	2nd process requests (1,2), is put to sleep.
> > 	3rd process requests (0,2), is put to sleep.
> >
> > 	The tree of waiters now looks like (0,2)->(1,2)->(0,3)
> >
> > 	(0,3) is unlocked.
> > 	A 4th process races in and locks (2,2).
> > 	The 2nd process wakes up, sees this new conflict, and waits on
> > 	(2,2).  Now the tree looks like (0,2)->(1,2)->(2,2), and (0,2)
> > 	is waiting for no reason.
> >
>=20
> That seems like a legit problem.
>=20
> One possible fix might be to have the waiter on (1,2) walk down the =
entire
> subtree and wake up any waiter that is waiting on a lock that doesn't =
conflict
> with the lock on which it's waiting.
>=20
> So, before the task waiting on 1,2 goes back to sleep to wait on 2,2, =
it could
> walk down its entire fl_blocked subtree and wake up anything waiting =
on a lock
> that doesn't conflict with (2,2).
>=20
> That's potentially an expensive operation, but:
>=20
> a) the task is going back to sleep anyway, so letting it do a little =
extra work
> before that should be no big deal
>=20
> b) it's probably still cheaper than waking up the whole herd

Yea, I think so.

Now here's another question... How does this new logic play with Open =
File Description Locks? Should still be ok since there's a thread =
waiting on each of those.

Frank

