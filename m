Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45268ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43242089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="fuloSWb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43242089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeGOPOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:14:17 -0400
Received: from imap.thunk.org ([74.207.234.97]:43722 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeGOPOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SlrSaFcn6ivCHRBrovvMBUwub6+OWVH3aikMVpzYNlI=; b=fuloSWb9dW2AstFfxKqAvXxMcG
        qZKxKMSKdMIccB2sKn+aB9alQhsAkUiBm2YlQAQs9kIwES08LArftQb/nAf/lpIPq7udSjx+uW3Xn
        zbvbS/XP6mbY8Qem8DUg7bVBA1DYfJFp3LyO17gYEjrUS4j0D+wQNC3hNTHEqdby43R8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1feiMM-0006NT-UA; Sun, 15 Jul 2018 14:50:51 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7776A7A63EE; Sun, 15 Jul 2018 10:50:47 -0400 (EDT)
Date:   Sun, 15 Jul 2018 10:50:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Willy Tarreau <w@1wt.eu>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Message-ID: <20180715145047.GA6179@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>,
        Willy Tarreau <w@1wt.eu>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org>
 <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org>
 <20180501220228.GD7397@sasha-vm>
 <20180502043017.GA11938@1wt.eu>
 <20180502194139.GA18390@sasha-vm>
 <20180502200229.GA12729@1wt.eu>
 <20180714173812.xhfwtcijlxebmn2k@devuan>
 <20180715085403.GA21992@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715085403.GA21992@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 10:54:03AM +0200, Greg KH wrote:
> Pavel, I "love" how you fail to point out that you are responding to a 2
> month old thread :(

And apologies for releasing some ancient messages that were caught in
the ksummit-discuss's moderation queue.  I hadn't been paying
attention to the fact that there had been some messages caught there,
and I figured it might be some people on the ksummit-discuss list who
might have missed the context of that old thread.

That being said, it *was* beaten to death two months ago, so people
who are replying might want to keep that in mind.  :-)

> And as always, you have a choice:
> 	- if you don't like stable kernels, don't run them.

And if you don't like stable kernels, you can pay $$$ to an enterprise
distro kernel.  Although you might find they aren't that much better
at the whole fixing bugs versus introducing regressions tradeoff.
Indeed, because there are crazy people who insist on using 3.18
kernels *and* getting support for the latest hardware, you may find
that it's somewhat worse; not to mention not necessarily being able to
get all of the fixes for the cache-related security problems getting
found...

						- Ted
