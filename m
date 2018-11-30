Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07592C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CFA2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="msZOa6/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CFA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeK3WN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:13:59 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53072 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeK3WN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uOiN9MPB6iVNWvNXV6KDBzuuE1bjGxDpYd42lwminN8=; b=msZOa6/Q5pOX2EOwznkvvnHnR
        A20/gy//c4Q766EJzTW1GV7+Rh3b0LvQMQf/yogdZwQn84///LNe/PZ3ZZRS0OgEGe9YytZWhXBiI
        bYf9HKDe+6czICbRuiku1p9393Ro2n/8xk0ndUQr416OzkaiYwMWniXQ2kWydVU1EY62s=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:41092)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gSgbM-0007y7-Ou; Fri, 30 Nov 2018 11:04:52 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gSgbI-0005Q6-BF; Fri, 30 Nov 2018 11:04:48 +0000
Date:   Fri, 30 Nov 2018 11:04:46 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Message-ID: <20181130110446.GE30658@n2100.armlinux.org.uk>
References: <20181120141445.21378-1-phil.edworthy@renesas.com>
 <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
 <TY1PR01MB1769161656941346A08F9F8AF5D30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1769161656941346A08F9F8AF5D30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:25:37AM +0000, Phil Edworthy wrote:
> Hi Stephen,
> 
> On 30 November 2018 09:09 Stephen Boyd wrote:
> > Quoting Phil Edworthy (2018-11-20 06:14:45)
> > > This adds clk_get_optional() and devm_clk_get_optional() functions to
> > > get optional clocks.
> > > They behave the same as (devm_)clk_get except where there is no clock
> > > producer. In this case, instead of returning -ENOENT, the function
> > > returns NULL. This makes error checking simpler and allows
> > > clk_prepare_enable, etc to be called on the returned reference without
> > > additional checks.
> > 
> > Ok. I guess that works by virtue of how -ENOENT is returned by various
> > functions that are called deeper in the clk_get() path? I'm cautiously
> > optimistic. So cautious, we should probably add a comment to these optional
> > functions that indicate they rely on the functions they call to return -ENOENT
> > under the various conditions that make a clk optional.
> Yes, it does indeed rely on how clk_get() is implemented.
> Specifically, that if __of_clk_get_by_name() returns -EINVAL, the error is
> superseded by clk_get_sys() returning -ENOENT.
> As you say, a comment may help here.

Each time the question of the optional clk_get() stuff comes up, we go
around the same discussions time and time again.  So far, each time
has ended up flopping.

Yes, clk_get() can only ever return -ENOENT if it falls back to the
non-DT methods, because it assumes that the clk tables are complete
(it can do nothing else.)

I don't think it needs a comment because it's obvious from the code
and also from the implementation point of view.

> > > +static inline struct clk *clk_get_optional(struct device *dev, const
> > > +char *id)
> > 
> > Any kernel doc for this function?
> I took my cue from the surrounding functions, let me know if I have to add it.

I don't see you need to - this is an internal function by way of the
"static inline" you have before it.  It's not an API function.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
