Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AEDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7716120834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=chavero.com.mx header.i=@chavero.com.mx header.b="bR9QIgyO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=chavero.com.mx header.i=@chavero.com.mx header.b="jrokaGYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7716120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chavero.com.mx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeJZIHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:07:19 -0400
Received: from salida.aumenta.com.mx ([209.139.208.81]:41587 "EHLO
        salida.aumenta.com.mx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeJZIHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by salida.aumenta.com.mx (Postfix) with ESMTP id 41527C802DA;
        Thu, 25 Oct 2018 17:31:03 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chavero.com.mx;
        s=mail; t=1540510263;
        bh=WAYCqM8on21SxOrGwAwI1gmA+o8MZqnMUAqdUAZLqz8=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=bR9QIgyOF7eDk4FTDEEn2CjN0Pq1zq9ApHH6+goTj7B+nK71AXdsIYNtH1HsRtP8y
         rXvgrFNsyuKTJoTST45SpCpuM+fZzuDfeTSI6tM2PVs4XwHKMbiFAe2Ph+USHciqW4
         CTI7P636Am0WHm/D+C/IcK/kdWIqjw1cDK/UP+JE=
X-Virus-Scanned: amavisd-new at aumenta.com.mx
Received: from salida.aumenta.com.mx ([127.0.0.1])
        by localhost (trefilp.aumenta.com.mx [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ZVdsrSAYqoKf; Thu, 25 Oct 2018 17:31:02 -0600 (MDT)
Received: from airsk8 (unknown [189.154.11.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ichavero@seispistos.com.mx)
        by salida.aumenta.com.mx (Postfix) with ESMTPSA id DDE0AC80032;
        Thu, 25 Oct 2018 17:30:58 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chavero.com.mx;
        s=mail; t=1540510262;
        bh=WAYCqM8on21SxOrGwAwI1gmA+o8MZqnMUAqdUAZLqz8=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=jrokaGYXI5JQ3yBZpY1WGs+WS8hk8H2nqaM3dAJkvQ4QOS54/1beUmr9+9VPQDxY0
         XcPCivSOS7sumLeSliFXRJ6jqzK7LbaAqyeeXA52gnWqpL0IZj2H9IsKllT1N4wpd1
         NXXoTkzO5SFnQk4R9+nK/cTCJoXLCceo271p7Z/Y=
Message-ID: <e563f1e92654584612b5d2ea27e3d5745fbb341e.camel@chavero.com.mx>
Subject: Re: The linux devs can rescind their license grant.
From:   =?ISO-8859-1?Q?Iv=E1n?= Chavero <ichavero@chavero.com.mx>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, esr@thyrsus.com,
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
Date:   Thu, 25 Oct 2018 17:32:33 -0600
In-Reply-To: <20181025204718.GB25649@thunk.org>
References: <20181020134908.GA32218@kroah.com>
         <87y3ar80ac.fsf@notabene.neil.brown.name>
         <c6bf1877-6e29-50ec-ffa8-314ab35ec9ce@redhat.com>
         <185b786a2bd6e8d527dca161dc42e4f1@redchan.it>
         <20181025081911.GB11343@kroah.com> <20181025193901.GD26403@thyrsus.com>
         <20181025204718.GB25649@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El jue, 25-10-2018 a las 16:47 -0400, Theodore Y. Ts'o escribió:
> On Thu, Oct 25, 2018 at 03:39:01PM -0400, Eric S. Raymond wrote:
> > 
> > Under Jacobsen vs. Katzer (535 f 3d 1373 fed cir 2008) authors of
> > GPLed software have a specific right to relief (including
> > injunctive
> > relief) against misappropriation of their software. That ruling
> > (which
> > was the case of first impression on the binding status of the GPL)
> > reputational damage is *specifically* recognized as grounds for
> > relief.
> 
> I've read the legal briefs, and I'm pretty sure they don't say what
> you are claiming they say.  Yes, I'm not a lawyer --- but that's OK
> --- neither are you.
> 
> > The anti-CoC dissidents don't have to rescind their license grant
> > to
> > cause a great deal of trouble.
> 
> The *vast* majority of the "anti-CoC dissidents" who have been
> advancing this argument, have, as near as I can tell, little or no
> copyright ownership in the kernel.  They are external trolls who are
> not members of the kernel development community, to the best of my
> belief and knowledge.

I understand the point, but being an outsider from the kernel
development community, does not mean i should not care about Linux
development and this particular community.

I have been promoting, using, installing, testing and loving Linux for
more than 20 years now. One of the things that got me into it and still
appreciate a lot is the meritocracy: the norm of technical excellence,
the: "it does not matter who you are as long as you contribute good
code". 

This CoC "movement" is part of an anti meritocracy "movement" that
should not be influencing a project that thanks to this meritocracy has
become the most important in the world.

I'll take one of the arguments of the CoC promoters and use it on my
favor: The Linux community has grown more than just a bunch of
developers it has: promoters, users, testers, enthusiast, companies,
foundations, etc... 
I wouldn't like that a negative code of conduct (yes its languaje is
aggresive and charged with negativity, politics and victimization)
compromise the technical aspects of a critical system like the Linux
kernel.

When it comes to coding, Engineers should be above that stuff.

> 
> In short; they are adding noise to the conversation, and have been
> presuming that in fact people are going to be regularly and summarily
> ejected from the community.  In short, they are adding FUD, probably
> because they have their own agenda.

I have one agenda: World Domination :P

> I would recommend that before people respond such provocation
> messages, that they do a quick "git log" and find out whether they
> have in fact contributed code to the kernel at all, and if so, how
> long ago it was.

Just want to clarify that this is not a provocation, just got tired of
being a passive member of this discussion.

You're right the people with more merit in this list should have a more
important voice since it shows the commitment to the development. 

BTW Thanks for the comment, i will start contributing to the extent of
my capacities.

As i say, the reach of Linux is broader than just the development
community. Too bad you can't git log all the servers that people has
installed and maintaining during the years.



> Regards,
> 
> 						- Ted

Cheers,
Ivan

