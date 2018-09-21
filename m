Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB0ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E086320645
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="nYsugQkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E086320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeIVFG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:06:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:34090 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbeIVFG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gWvvWPaXUHpa2blpiIZETeUIbMndprPssLGTBQ4PZsE=; b=nYsugQkMw3MQhwae2oVDJQAXHY
        Awun98UiIX2/SPtzZy74HMH0NC9SFUouXo6lO3OvRt84yaGTb4gFfUScz22o2ps7t3gvXrQgAl3j2
        5vQaLpgbtffJ0H9UgCR40JG2Jj2+MVRqdIAvtpwZEIM031/U2qzoY0gGJai3Tr5XYz0U=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g3UeI-0000s0-K1; Fri, 21 Sep 2018 23:15:46 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DE59A7A01DE; Fri, 21 Sep 2018 19:15:45 -0400 (EDT)
Date:   Fri, 21 Sep 2018 19:15:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "\\0xDynamite" <dreamingforward@gmail.com>
Cc:     "Frank Ch. Eigler" <fche@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Code of Conduct: Let's revamp it.
Message-ID: <20180921231545.GC2966@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "\\0xDynamite" <dreamingforward@gmail.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Rik van Riel <riel@surriel.com>, Edward Cree <ec429@cantab.net>,
        Olof Johansson <olof@lixom.net>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net>
 <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net>
 <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com>
 <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People can decide who they want to respond to, but I'm going to gently
suggest that before people think about responding to a particular
e-mail, that they do a quick check using "git log --author=xyzzy@example.com"
then decide how much someone appears to be a member of the community
before deciding how and whether their thoughts are relevant.

There are a lot of strong feelings on this issue, and allowing people
who aren't members of the Linux kernel development community, to
escalate the rhetoric --- either in the pro- or anti- CoC direction,
and whether on mailing lists, github comment threads, Twitter, or
Reddit --- is not helpful.

For example....

> >* Showing empathy towards other community members
> 
> Your pussy hurts?  Maybe you should have just accepted that your a boy!
> 
> I think Linus is perfectly fine in conduct.   I mean, this bullshit
> pressure comes from corporations and other wierd places (<subtext>all
> seeing eye</subtext>) that want to "help".  

There are people commenting from all sides that are wanting to "help".
But I hope that it is obvious that the above text is *not* *helpful*.
Mark, please stop.

						- Ted
