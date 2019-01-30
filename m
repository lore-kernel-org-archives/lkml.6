Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA63C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7809420870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548838963;
	bh=qpyPna99WYyUFMeih5kVLxmmC5xeXgQ5XqYOddQchxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHCfvgXYcDKGqXUZa4PrVPU3c6sp2iWhLgbbt9r3KbyZwEygx53pg4ZBl93+eQOwM
	 TQYEY28PjQ4CIGlKJ9xvivsEBLTLpHbG6qmRwQ52Au5jHlHRR/HIfpg+6QhA4jlKXl
	 bMP4hOYVf+l6ax1Dfh19NhN35fH0aLNyZ0UHFmM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfA3JCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:02:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39825 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3JCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:02:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so16792952lfh.6;
        Wed, 30 Jan 2019 01:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f/hmv/BD3dVn/TN64uCAc70GpQAfJ94e2TwTQxaVaFA=;
        b=QmilTJ/4BT4LeT/rZflSDgAIlsUOtr1IMtYfSXyLPN/qbs9fwzdTByCNzXii1tZaoy
         mFCh8T0cOIDSyKJTRZLAp3cxpEIRQ6rm0PkxikdSlNmCZ4eaTVaUm8v5a/iOl5OxGUgc
         4wLfIB0eONpFvHc5BUf3SKKEa4yw+rgWzDzOpzW1U1ZWtZXMqsBlmR4bFT5YlTXVTzaS
         6imPCIjJQvHoNX7YgA8JLrN5kGa3dAq8Xzhq4f947xTTZew2yMFregMheFMxp7ZMA1FF
         jfIOMjEkPfIuG3TOuPO8eNaA9tt+5uTpR4d9l7HP9EIvcyk3B/OP8nQ0vXCAQZloMH+9
         LshA==
X-Gm-Message-State: AJcUukcA/So6WOohFEkd9vsOnrwJMqUlQtQb3hotjuOUOSNSauS/jSiv
        5Z0y0zk+i9z0MZg1ycQFmCKC/UnX
X-Google-Smtp-Source: ALg8bN6Gcu3ae0kZblaZ84Y+q70CMfn7OBnz7D/hd1Ij/6BsMhYFuZGfCuIQvrEV2vzFnOgivfu3QQ==
X-Received: by 2002:a19:ef15:: with SMTP id n21mr23184744lfh.21.1548838958525;
        Wed, 30 Jan 2019 01:02:38 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 6sm196636lfa.27.2019.01.30.01.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:02:37 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gollQ-0000u1-FI; Wed, 30 Jan 2019 10:02:32 +0100
Date:   Wed, 30 Jan 2019 10:02:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Subject: Re: [PATCH] arm: dts: gta04: add gps support
Message-ID: <20190130090232.GL3691@localhost>
References: <20190125194310.11170-1-andreas@kemnade.info>
 <20190128075356.GJ3691@localhost>
 <20190128163025.7daa385b@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128163025.7daa385b@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:44:29PM +0100, Andreas Kemnade wrote:
> On Mon, 28 Jan 2019 08:53:56 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Fri, Jan 25, 2019 at 08:43:10PM +0100, Andreas Kemnade wrote:
> > > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > > which one is mounted so use the compatibility entry for w2sg0004
> > > for all which will work for both.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > w2sg0004 bindings (together with the corresponding support is in
> > > https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next)
> > >  arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)

> > > +	gps: gps {  
> > 
> > The node should be named "gnss" as per the binding.
> > 
> > > +		compatible = "wi2wi,w2sg0004";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&gps_pins>;
> > > +		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> > > +		lna-supply = <&vsim>;  
> > 
> > Also, the vcc-supply is a required property.
> > 
> well, it is not require in the driver and it has different behavior
> (on even when not opened if on-off is there) than the lna-supply used
> here. So maybe fix the binding documentation?

The device-tree describes hardware, and how a particular driver happens
to implement a binding is not relevant.

That said, there is a bit of an on-going, shall we say philosophical,
debate about this. The regulator maintainer takes a firm position that
all mandatory physical supplies should be represented in firmware
	
	https://lore.kernel.org/lkml/20181123133126.GF2089@sirena.org.uk/T/#u
	https://lore.kernel.org/lkml/20180409102244.GB11532@sirena.org.uk/T/#u

while Rob appears to take a slightly different stance on fixed
regulators while admitting that this an issue which has not yet been
fully resolved:

	https://lore.kernel.org/lkml/20180425171123.xhyoay3nu463btoq@rob-hp-laptop/T/#u

Since this is a new binding, and the hardware requires the vcc supply
and this is reflected in the binding, I think you should add a fixed
regulator. At least until you hear otherwise. ;)

Johan
