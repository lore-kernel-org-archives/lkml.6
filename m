Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA3FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6662086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="f+wJB4yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6662086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbeKPDRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:17:04 -0500
Received: from imap.thunk.org ([74.207.234.97]:34682 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388226AbeKPDRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nMm5oMwzElE+fncBIkPCqc1Qtobl9QyWYml8NKUd62w=; b=f+wJB4yfi0sXpNkCHTTMbBklnu
        9C1c5TbdC/qHujrI9fM1Tf/ZDIPPh1Audfi5AJrZge9OUJZZXyXcoiM6+bvv/DoOe2/iJlAsRKnv3
        H7P4FWsBExfEwP/6petMYYxOyTK80q+9eKFjQ8WE19YmjWiv3h6NITCRTKIopNOmZwvI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gNL7h-0004tG-3w; Thu, 15 Nov 2018 17:08:09 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 83F027A47B7; Thu, 15 Nov 2018 12:08:07 -0500 (EST)
Date:   Thu, 15 Nov 2018 12:08:07 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
Message-ID: <20181115170807.GB20617@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Daniel Colascione <dancol@google.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
        Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
References: <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <20181113193859.GJ3505@e103592.cambridge.arm.com>
 <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
 <CAKOZuesta_V=doXsVLc2E6WCQvywdur3F+u2pFKaPN+CEQd+ZQ@mail.gmail.com>
 <alpine.DEB.2.21.1811141741000.16571@digraph.polyomino.org.uk>
 <CAKOZuetCGCfNdJ2QM0phu3_3Q29f5Yeh=NHiM_A9MhHsCjK48A@mail.gmail.com>
 <alpine.DEB.2.21.1811141840140.16571@digraph.polyomino.org.uk>
 <20181115053026.GA20617@thunk.org>
 <alpine.DEB.2.21.1811151628490.27351@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811151628490.27351@digraph.polyomino.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 04:29:43PM +0000, Joseph Myers wrote:
> On Thu, 15 Nov 2018, Theodore Y. Ts'o wrote:
> 
> > That's great.  But is it or is it not true (either de jure or de
> > facto) that "a single active glibc developer" can block a system call
> > from being supported by glibc by objecting?  And if not, under what is
> > the process by resolving a conflict?
> 
> We use a consensus-building process as described at 
> <https://sourceware.org/glibc/wiki/Consensus>.

So can a single glibc developer can block Consensus?

I've chaired IETF working groups, where the standard was "Rough
Consensus and Running Code".  Strict Consensus very easily ends up
leading to the Librem Veto which did not serve the Polish-Lithuanian
Commonwealth well in the 17th-18th centuries....

							- Ted
