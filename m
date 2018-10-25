Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD54C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E862084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="e4t2mLvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E862084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJZH5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:57:48 -0400
Received: from one.firstfloor.org ([193.170.194.197]:50388 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeJZH5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:57:47 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id D91748694A; Fri, 26 Oct 2018 01:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1540509789;
        bh=CT/sfYz+aMJoeKYHD0ypGGWZ7PUxADl0WxlXFriw/1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4t2mLvFWlJn+zUVGJ27zWFTiBLpz5s6garsUo9mo8etLp72loRFPP85Zg+AcNpuB
         OZojuND2a12G0NgjNf41C0eECoZR07n5xUFBfu5pOVgbuL7uDRRhOgMpI5PSM9lLCG
         XpkzixBqyNqN9eUzb/veB6GXgX3g5WK7RjmcW1I4=
Date:   Thu, 25 Oct 2018 16:23:09 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>,
        peterz@infradead.org, x86@kernel.org, eranian@google.com,
        kan.liang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
Message-ID: <20181025232309.6bbxedhkf2ffndsw@two.firstfloor.org>
References: <20181010162608.23899-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1810171151010.6000@nanos.tec.linutronix.de>
 <20181019234743.GA27951@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1810201017070.1651@nanos.tec.linutronix.de>
 <20181020143857.GC27951@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1810210954440.1651@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810210954440.1651@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 12:20:47PM +0200, Thomas Gleixner wrote:
> Andi,
> 
> On Sat, 20 Oct 2018, Andi Kleen wrote:
> > On Sat, Oct 20, 2018 at 10:19:37AM +0200, Thomas Gleixner wrote:
> > > On Fri, 19 Oct 2018, Andi Kleen wrote:
> > > There is no point to return the pointer because it's not a compound
> > > structure. If you want to provide the possibility to use the index then
> > > return the index and an error code if it does not match.
> > 
> > It will be useful with the driver_data pointer, which you short sightedly
> > forced me to remove, and likely will need to be readded at some point
> > anyways if this gets more widely used.
> 
> It's good and established practice not to add functionality on a 'might be
> used' basis. If you'd provide at least one or two patches which demonstrate
> how that is useful then that would be convincing.
> 
> >  At least with the pointer not all callers will need to be changed then.
> 
> It doesn't need to be changed at all, when done correctly.

Thanks.

I opted for the simpler method of returning a boolean now.

-Andi
