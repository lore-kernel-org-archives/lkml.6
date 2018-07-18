Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54899ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DD520852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="QrFLLWS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DD520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGRJvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 05:51:50 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:49142 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeGRJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 05:51:49 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 5F20D25BE0C;
        Wed, 18 Jul 2018 19:14:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1531905291; bh=EmpRczOHPT+zYUNOn7qLIVM7xx2Y1K39KarvOzDsWgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrFLLWS59xLsY3XogPsnFirVDqr0Ec437cR/kOPMG73CtlippJMnxamJfbaafQ1pD
         jzIoGJ/QCdiylh9Nm44jIh4nNDq5QxKJj74Ysg5YLiEC8VXzkyInQlXSqyWNajZYvw
         dcAK8kCuyilaIN8KWke7uHOmClzDl6JSKXu8hS/M=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 56CB99402E7; Wed, 18 Jul 2018 11:14:49 +0200 (CEST)
Date:   Wed, 18 Jul 2018 11:14:49 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
Message-ID: <20180718091448.fw2y7ea6sk2osi3g@verge.net.au>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
 <20180717120737.bipotpki3yhn6klf@verge.net.au>
 <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
 <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
 <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
 <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:57:27PM +0000, Phil Edworthy wrote:
> Hi Andy,
> 
> On 17 July 2018 15:47, Andy Shevchenko wrote:
> > On Tue, 2018-07-17 at 14:40 +0000, Phil Edworthy wrote:
> > > On 17 July 2018 15:19, Andy Shevchenko wrote:
> > > > On Tue, 2018-07-17 at 12:42 +0000, Phil Edworthy wrote:
> > > >
> > > > > > While your point sounds valid (don't remember how clk_get() is
> > > > > > implemented), NULL is also OK to have.
> > > > >
> > > > > Ok as in there is no bus clock, right?
> > > > > So it should be:
> > > > >  if (!IS_ERR_OR_NULL (dev->busclk))
> > > >
> > > > Nope, NULL is no error case for optional clock.
> > >
> > > I must be missing something here...
> > 
> > See how clk_prepare_enable() is implemented.
> Ok, if busclk is NULL the code can safely call clk_prepare_enable()
>
> > > I agree that NULL for an optional clock is not an error. However, the
> > > code above is now:
> > > +	if (prepare) {
> > > +		/* Optional bus clock */
> > 
> > > +		if (!IS_ERR_OR_NULL(dev->busclk)) {
> > 
> > Check for NULL is redundant.
> > 
> > > +			ret = clk_prepare_enable(dev->busclk);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +
> > >  		return clk_prepare_enable(dev->clk);
> > > +	}
> > >
> > > So, if you have a valid busclk, it gets enabled, otherwise it is left
> > > alone.
> > 
> So the code as sent in the original email is correct (aside from Geert's
> comments about EPROBE_DEFER handling).
> 
> Maybe I need some coffee :\
> Thanks
> Phil

My point is that errors should be treated as errors.

In i2c_dw_prepare_clk() the following appears:

        if (IS_ERR(dev->clk))
                return PTR_ERR(dev->clk);

So dev->clk being an error value is treated as an error that
is passed up to the caller.

But in your patch (and the snippet below) dev->busclk is treated
as the optional clock not being present. Even if the error stored
nothing to do with the clock not being present - f.e.  ENOMEM or
as Geert mentioned elsewhere, EPROBE_DEFER.

Assuming the absense of the optional clock is indicated by ENOENT,
in my view correct code would include something like:

	...

	if (IS_ERR(dev->clk))
		return PTR_ERR(dev->clk);

	if (IS_ERR(dev->buslck) && PTR_ERR(dev->busclk) != -ENOENT)
		return PTR_ERR(dev->busclk);

	...


