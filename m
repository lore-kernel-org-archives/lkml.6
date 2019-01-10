Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1DDC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35629208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547144993;
	bh=P/Ud3w6lytm1dJiHF0n3F3ulBpQDfj6Q2QXw2tnB8EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n+jGPHk7f02bNfPG+vRFe2lwioiUrcYJd/hROLnZYYj06AG4LcjbChf1N8oIaitzn
	 ggao59VMGgiJcUrMWr7nB4oEqUbelEBefWK41o20Zbal+BjkZQtxWiPBu3ZX/y+gGn
	 0EXS17r1YpHKLOSN4B5mvmS+/XKQFuIPCdtNe4SA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfAJS3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:29:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727684AbfAJS3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:29:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5578B20874;
        Thu, 10 Jan 2019 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547144991;
        bh=P/Ud3w6lytm1dJiHF0n3F3ulBpQDfj6Q2QXw2tnB8EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ykoQ1pKakRYls0c581PAQVONsRcVeFElcVAoSotCubH410tM5iMNvtBEU23Ue85Fn
         BACKKRYTwPv+1toN0r0Apvyzb1+9CrLidiYtvqDE4PbMxb4t8efoQ8atQPEJWRplFe
         1y3oiasrWKfRZDjIukKsw0QpkSNr7M8LL5RrmwvE=
Date:   Thu, 10 Jan 2019 19:29:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Breno Leitao <leitao@debian.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/170] 4.19.14-stable review
Message-ID: <20190110182948.GB7748@kroah.com>
References: <20190107104452.953560660@linuxfoundation.org>
 <20190108230731.GC20519@roeck-us.net>
 <20190109143811.GB29274@kroah.com>
 <20190109194048.GA11505@roeck-us.net>
 <20190110065207.GA17195@kroah.com>
 <20190110131743.GE20217@kroah.com>
 <1547130295@msgid.manchmal.in-ulm.de>
 <1547133048@msgid.manchmal.in-ulm.de>
 <20190110154039.GA26814@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110154039.GA26814@roeck-us.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:40:39AM -0800, Guenter Roeck wrote:
> On Thu, Jan 10, 2019 at 04:15:40PM +0100, Christoph Biedl wrote:
> > Christoph Biedl wrote...
> > 
> > > Sorry for not getting back to you earlier. Building yesterday's
> > > release (v4.19.14) *failed*, bisect led to
> > >
> > > | commit a9935a12768851762089fda8e5a9daaf0231808e (HEAD)
> > > | Author: Breno Leitao <leitao@debian.org>
> > > | Date:   Mon Nov 26 18:12:00 2018 -0200
> > > |
> > > |     powerpc/tm: Unset MSR[TS] if not recheckpointing
> > >
> > > Reverting that commit seems to be sufficient, build passes then.
> > >
> > > Additionally, neither 4.20 nor 5.0-rc1 show this problem. The
> > > | commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.
> > > builds as well, so I'll try to find the missing prerequisite next.
> > 
> > Cherry-picking
> > 
> > | commit 5c784c8414fba11b62e12439f11e109fb5751f38
> > | Author: Breno Leitao <leitao@debian.org>
> > | Date:   Thu Aug 16 14:21:07 2018 -0300
> > |
> > |     powerpc/tm: Remove msr_tm_active()
> > 
> > makes the build pass. Bruno, does this make sense?
> > 
> As I had reported and suggested well before the release.
> According to Greg those responsible for the patch series rejected that.

Ok, Breno and Christoph, what should I do here?  Should I drop this
patch in the tree or add this new one?  Ideally I can fix this soon as I
don't like having broken trees out there...

thanks,

greg k-h
