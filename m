Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504CFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D975C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="CjAG2xiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D975C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeJZFWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:22:00 -0400
Received: from imap.thunk.org ([74.207.234.97]:58336 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJZFWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vVoSaGpWrucJl55zuX2EOIj/joLeutl2zJYuIw2yUWQ=; b=CjAG2xiZd6JVxyDunMnWooCKvJ
        1zMKWrR2dwsmLJC4+GMlu/8qZeH4jAGDEIy/kFzmWhpquGzhjDXM1sEB4r3RFVnI7r0vJktLvALZv
        2xXkBtWldyYvdO3+yxs0Ue+BcxLeDbhripD47HJFcK/nG6tIH2aixDDq9y/2SMGFRX9A=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gFmXH-0004Cp-NE; Thu, 25 Oct 2018 20:47:19 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B8B4C7A447E; Thu, 25 Oct 2018 16:47:18 -0400 (EDT)
Date:   Thu, 25 Oct 2018 16:47:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     esr@thyrsus.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        visionsofalice@redchan.it,
        linux-kernel <linux-kernel@vger.kernel.org>, rms@gnu.org,
        bruce@perens.com, moglen@columbia.edu, bkuhn@sfconservancy.org,
        editor@lwn.net, NeilBrown <neil@brown.name>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: The linux devs can rescind their license grant.
Message-ID: <20181025204718.GB25649@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>, esr@thyrsus.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        visionsofalice@redchan.it,
        linux-kernel <linux-kernel@vger.kernel.org>, rms@gnu.org,
        bruce@perens.com, moglen@columbia.edu, bkuhn@sfconservancy.org,
        editor@lwn.net, NeilBrown <neil@brown.name>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Mishi Choudhary <mishi@linux.com>,
        linux-kernel-owner@vger.kernel.org
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
 <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
 <20181025081911.GB11343@kroah.com>
 <20181025193901.GD26403@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025193901.GD26403@thyrsus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:39:01PM -0400, Eric S. Raymond wrote:
> 
> Under Jacobsen vs. Katzer (535 f 3d 1373 fed cir 2008) authors of
> GPLed software have a specific right to relief (including injunctive
> relief) against misappropriation of their software. That ruling (which
> was the case of first impression on the binding status of the GPL)
> reputational damage is *specifically* recognized as grounds for relief.

I've read the legal briefs, and I'm pretty sure they don't say what
you are claiming they say.  Yes, I'm not a lawyer --- but that's OK
--- neither are you.

> The anti-CoC dissidents don't have to rescind their license grant to
> cause a great deal of trouble.

The *vast* majority of the "anti-CoC dissidents" who have been
advancing this argument, have, as near as I can tell, little or no
copyright ownership in the kernel.  They are external trolls who are
not members of the kernel development community, to the best of my
belief and knowledge.

In short; they are adding noise to the conversation, and have been
presuming that in fact people are going to be regularly and summarily
ejected from the community.  In short, they are adding FUD, probably
because they have their own agenda.

I would recommend that before people respond such provocation
messages, that they do a quick "git log" and find out whether they
have in fact contributed code to the kernel at all, and if so, how
long ago it was.

Regards,

						- Ted
