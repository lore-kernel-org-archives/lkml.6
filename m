Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8703CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5F20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="x5KvS7Jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB5F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeHaBja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:39:30 -0400
Received: from imap.thunk.org ([74.207.234.97]:35132 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbeHaBja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
        Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=K7oWBuRmTcJZZ3nbH8W1e5wGtLf2LqsZuqpPKxXorbg=; b=x5KvS7JrtIpDKFDLHZM+WznixG
        ma40n9JYPyw2fVjcKu5KqW92w300TaPXr9P3vL9kOkQ2uZ+E0LA703rJiuWdWiKknaxNclqKv95P6
        v3vuHqKV9YZqL/kpGl+AWyri72Tu39WpvTesws1Mz0ZNGaf7zKoZVwOxUQBRbYxZyZ8I=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fvUb1-0008Bu-NI; Thu, 30 Aug 2018 21:35:19 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 523BB7A4BB9; Thu, 30 Aug 2018 17:35:17 -0400 (EDT)
Date:   Thu, 30 Aug 2018 17:35:17 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Maintainer / Kernel Summit 2018 planning kick-off
Message-ID: <20180830213517.GA19110@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Feel free to forward this to other Linux kernel mailing lists as
  appropriate -- Ted ]

This year, the Maintainer and Kernel Summit will be in Vancouver,
B.C., November 12th -- 15th.  The Maintainer's summit will be held on
Monday, November 12th, in Vancouver, immediately before the Linux
Plumber's Conference (LPC) November 13th -- 15th.

For the past few years, before 2017, we've scheduled mostly management
and development process issues on the first day.  We then opened up
the second day of the Kernel Summit to all attendees of the conference
with which the Kernel Summit has been colocated, and called it the
"Open Technical Day".  This is something that just made sense in order
to assure that all of the necessary people needed to discuss a
particular technical issue could be in the room.

Starting last year in Prague, we took the next logical step, and split
the Kernel Summit in two.  The "Maintainer's Summit" is an
invite-only, half-day event, where the primary focus will be process
issues of Linux Kernel Development.  It will be limited to 30 invitees
and a handful of sponsored attendees.  This makes it smaller than the
first few kernel summits (which were limited to around 50 attendees).

The "Kernel Summit" is now organized as a track which is run in
parallel with the other tracks at the Linux Plumber's Conference, and
is open to all registered attendees of Plumbers.  Much as how we
organized the Kernel Summit "open technical day" in 2016 in Santa Fe,
the Kernel Summit schedule will be synchronized with the other tracks
at the Plumber's Conference, and it will be open to all registered
Plumber's attendees.

Linus has suggested the following ten people as the core of the people
he would like invited to the Maintainer's Summit, which was calculated
from statistics from his git tree.

	David Miller
	Dave Airlie
	Greg KH
	Arnd Bergmann
	Ingo Molnar
	Mauro Carvalho Chehab
	Takashi Iwai
	Thomas Gleixner
	Andrew Morton
	Olof Johansson

As we did last year, there will be a mini-program committee that will
be pick enough names to bring the total number of 30 for the
Maintainer's Summit.  That program committee will consist of Arnd
Bergmann, Thomas Gleixner, Greg KH, Paul McKenney, and Ted Ts'o.

We will use the rest of names on the list generated by Linus's script
as a starting point of people to be considered.  People who suggest
topics that should be discussed on the Maintainer's summit will also
be added to the list.  To make topic suggestions for the Maintainer's
Summit, please send e-mail to the ksummit-discuss list with a subject
prefix of [MAINTAINERS SUMMIT].


The other job of the program committee will be to organize the program
for the Kernel Summit.  The goal of the Kernel Summit track will be to
provide a forum to discuss specific technical issues that would be
easier to resolve in person than over e-mail.  The program committee
will also consider "information sharing" topics if they are clearly of
interest to the wider development community (i.e., advanced training
in topics that would be useful to kernel developers).

To suggest a topic for the Kernel Summit, please tag your e-mail with
[TECH TOPIC].  As before, please use a separate e-mail for each topic,
and send the topic suggestions to:

	ksummit-discuss@lists.linuxfoundation.org

People who submit topic suggestions before September 21st and which
are accepted, will be given a free admission to the Linux Plumbers
Conference.

We will reserving roughly half the Kernel Summit slots for last-minute
discussions that will be scheduled during the week of Plumber's, in an
"unconference style".  This was extremely popular in Santa Fe and in
Prague, since it allowed ideas that came up in hallway discussions,
and in Plumber's Miniconference, to be given scheduled, dedicated
times for that discussion.


If you were not subscribed on to the kernel-discuss mailing list from
last year (or if you had removed yourself after the kernel summit),
you can subscribe to the discuss list using mailman:

   https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
