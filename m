Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeFEE0c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 00:26:32 -0400
Received: from muru.com ([72.249.23.125]:46052 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbeFEE0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 00:26:30 -0400
Date: Mon, 4 Jun 2018 21:26:27 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, aaro.koskinen@iki.fi
Subject: Re: Common config for N900 and D4
Message-ID: <20180605042627.GB5738@atomide.com>
References: <20180603104839.GA21197@amd>
 <20180603165336.GA26995@amd>
 <20180603210115.GA7438@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603210115.GA7438@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180603 21:03]:
> Hi!
> 
> > > Aaro, I know I have asked before, but if you have common config for
> > > N900 and Droid4, please send me a copy. Yes, it should be somewhere in
> > > my inbox already, but I can't find it and version for v4.17 would be
> > > more useful.
> > > 
> > > While trying to came up with common config, I hit:
> > > 
> > > [    0.000000] L2C-310 erratum 727915 enabled
> > > [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> > > [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
> > 
> > I tried disabling outer cache to get rid of this. That got me further
> > in boot, but not to working system:
> 
> I now have config that works.
> 
> My kernels were probably grossly misconfigured (OMAP4 not enabled on
> droid4)... still I'd expect some kind of panic explaining board is not
> compatible with kernel, not a random oops...

Like "clk-provider not found" error? :) I agree it's not very
descriptive and I think we could easily print something from
after the SoC detection for missing pdata.

Eventually we should just get rid of all ARMv7 Kconfig variants
once most of the hwmod SoC pdata is gone.

Regards,

Tony
