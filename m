Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 11F5DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1F5208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="zVvl+uM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1F5208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935988AbeFMV2L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:28:11 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:44245 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935432AbeFMV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6lNxYpl6KNQp/5vMYhyVN6YsYP2C+8KwNWPOr2A1Ts8=; b=zVvl+uM/it24rEVoKKtaqcLZuu
        vA1vKQuqKSc/41Y91D/aM5d+JFK1942fzZIrFTYcD3a9pkdXTMBOcfuHF8rSagGtwwSQwIvHtXXXx
        IVcIwVg1BXCrOijbfeVpdYR+zB7ZeKNy68bvzLBSs97VGLIaGfK92PMmHL6U4mwgTlybt9753KFYV
        z7SpFLQ3/ilbTQ18NZaApwokM7sQuuthadu8z82LrPBrkp5Bt4ND3Fx4QMeHtsohO08bfo570z5oa
        b8iaBD5+Ffm1ZucZWZO8iCQCBLlpyHWk6SlGHWdixce7jBpi9cLhBCVWNDDrVz0Wg19dGDWNRQ4jN
        OrvqoCeg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59792 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fTDJJ-00B1Om-3b; Wed, 13 Jun 2018 21:28:09 +0000
Date:   Wed, 13 Jun 2018 14:28:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Hogan <jhogan@kernel.org>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] nds32: Fix build error caused by incomplete
 configuration flag rename
Message-ID: <20180613212808.GA10054@roeck-us.net>
References: <1528919032-4874-1-git-send-email-linux@roeck-us.net>
 <20180613210611.GA16086@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613210611.GA16086@jamesdev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:06:13PM +0100, James Hogan wrote:
> Thanks Guenter,
> 
> On Wed, Jun 13, 2018 at 12:43:52PM -0700, Guenter Roeck wrote:
> > GENERIC_ASHLDI3, GENERIC_ASHRDI3, and GENERIC_LSHRDI3 were renamed to
> > GENERIC_LIB_ASHLDI3, GENERIC_LIB_ASHRDI3, and GENERIC_LIB_LSHRDI3
> > without making the matching changes in arch/nds32.
> 
> Well, thats a little misleading. The commit in question was applied
> based on 4.17-rc2 a month *before* commit aeaa7af744fa ("nds32: lib: To
> use generic lib instead of libgcc to prevent the symbol undefined
> issue.") raced and overtook it and was merged in time for final 4.17, so
> technically it was only when the two recently came together in merge
> commit 763f96944c95 ("Merge tag 'mips_4.18' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux") that it was a
> problem.
> 
> Incidentally, is anybody building linux-next for nds32? (I could have
> asked Linus to fix this up in the merge commit had I known).
> 

Yes, me, and I had mentioned the failure a while ago in some e-mail exchange
talking about testing on -next. I did not have time to bisect, though.
Also, I rarely report problems in -next anymore after some less than friendly
reactions. One always risks something like "You should have checked branch <x>
of repository <y> before bugging me with this report", which is especially
annoying if the branch in question is not pulled into -next. People can always
check http://kerneltests.org/builders if they are interested in the status
of various branches.

> > Fixes: e3d5980568f ("lib: Rename compiler intrinsic selects to GENERIC_LIB_*")
> 
> Perhaps this would be more accurate?:
> Fixes: 763f96944c95 ("Merge tag 'mips_4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux")
> 
> > -	select GENERIC_ASHLDI3
> > -	select GENERIC_ASHRDI3
> > -	select GENERIC_LSHRDI3
> > +	select GENERIC_LIB_ASHLDI3
> > +	select GENERIC_LIB_ASHRDI3
> > +	select GENERIC_LIB_LSHRDI3
> >  	select GENERIC_CMPDI2
> >  	select GENERIC_MULDI3
> >  	select GENERIC_UCMPDI2
> 
> These 3 were renamed also.
> 

Good point. Maybe someone else can take it from here to find a more
politically correct wording of the patch description ?

Thanks,
Guenter
