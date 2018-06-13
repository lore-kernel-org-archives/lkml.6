Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 32C82C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0E9208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYQJPmLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0E9208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935688AbeFMVzL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935070AbeFMVzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:55:09 -0400
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40186208CD;
        Wed, 13 Jun 2018 21:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528926909;
        bh=T89aret5oSgKs/VIi8EJY+xaxyvYgMCTk9OTYZyOBww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYQJPmLkaKUgjjXYq8eVaxgBSWouJD1HtqDPzDxgTU2gbVCpwarDcOGKLo62YsUUz
         gh1cMZjyEuqrxoivUWPByt9hfXhcq8HPSzZkVLOz3eoLphQ6yk8b5rfxRzGvpUi7Ek
         718ibIsiwKR/pQR5qfc6mj300zp6a4thcep0Kgyo=
Date:   Wed, 13 Jun 2018 22:55:05 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] nds32: Fix build error caused by incomplete
 configuration flag rename
Message-ID: <20180613215504.GB16086@jamesdev>
References: <1528919032-4874-1-git-send-email-linux@roeck-us.net>
 <20180613210611.GA16086@jamesdev>
 <20180613212808.GA10054@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613212808.GA10054@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:28:08PM -0700, Guenter Roeck wrote:
> On Wed, Jun 13, 2018 at 10:06:13PM +0100, James Hogan wrote:
> > Thanks Guenter,
> > 
> > On Wed, Jun 13, 2018 at 12:43:52PM -0700, Guenter Roeck wrote:
> > > GENERIC_ASHLDI3, GENERIC_ASHRDI3, and GENERIC_LSHRDI3 were renamed to
> > > GENERIC_LIB_ASHLDI3, GENERIC_LIB_ASHRDI3, and GENERIC_LIB_LSHRDI3
> > > without making the matching changes in arch/nds32.
> > 
> > Well, thats a little misleading. The commit in question was applied
> > based on 4.17-rc2 a month *before* commit aeaa7af744fa ("nds32: lib: To
> > use generic lib instead of libgcc to prevent the symbol undefined
> > issue.") raced and overtook it and was merged in time for final 4.17, so
> > technically it was only when the two recently came together in merge
> > commit 763f96944c95 ("Merge tag 'mips_4.18' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux") that it was a
> > problem.
> > 
> > Incidentally, is anybody building linux-next for nds32? (I could have
> > asked Linus to fix this up in the merge commit had I known).
> > 
> 
> Yes, me, and I had mentioned the failure a while ago in some e-mail exchange
> talking about testing on -next. I did not have time to bisect, though.

My appologies if I was cc'd and missed it.

> Also, I rarely report problems in -next anymore after some less than friendly
> reactions. One always risks something like "You should have checked branch <x>
> of repository <y> before bugging me with this report", which is especially
> annoying if the branch in question is not pulled into -next. People can always

Thats a pity, but fair enough!

> check http://kerneltests.org/builders if they are interested in the status
> of various branches.

Thanks for the link. For the record i'm always interested in -next
issues you might become aware of related to patches I've applied (which
is hard to tell at a glance on the webpage in this case unfortunately).

> 
> > > Fixes: e3d5980568f ("lib: Rename compiler intrinsic selects to GENERIC_LIB_*")
> > 
> > Perhaps this would be more accurate?:
> > Fixes: 763f96944c95 ("Merge tag 'mips_4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux")
> > 
> > > -	select GENERIC_ASHLDI3
> > > -	select GENERIC_ASHRDI3
> > > -	select GENERIC_LSHRDI3
> > > +	select GENERIC_LIB_ASHLDI3
> > > +	select GENERIC_LIB_ASHRDI3
> > > +	select GENERIC_LIB_LSHRDI3
> > >  	select GENERIC_CMPDI2
> > >  	select GENERIC_MULDI3
> > >  	select GENERIC_UCMPDI2
> > 
> > These 3 were renamed also.
> > 
> 
> Good point. Maybe someone else can take it from here to find a more
> politically correct wording of the patch description ?

happy to tomorrow if rds32 folk don't want to.

Thanks again,
James
