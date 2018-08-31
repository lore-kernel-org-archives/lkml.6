Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713B9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A9220837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9lVJJjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A9220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHaPBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:01:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51030 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:01:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so4811284wmc.0;
        Fri, 31 Aug 2018 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SBHx9PW6jhqq6hqNuWf3Y2GoTEAsmPKYUx01XQ8gpls=;
        b=u9lVJJjW7bPr46W3or9ECgp9NC/tTsxcrV99YjwqyqRZ/BaWusu2WuWV4J1T4ZP5nw
         ReTDbAykXWWTUgGidY7YFbrrxfAvc88hEOTVmHVVd4KS9MIxAozdS7u2RErgkppnPqht
         vEI1nmr0tyH4/XTo4veQCI89VOKdjhaaz+r1ZPeMLBZyIxdF5xC7icARS87ps+LakLCH
         6gw1jyL6H/iJkh8GVIRL1soeroeFH3GEbrGsNt8aRA6zvzoQrvUve4qU2pxxYaDFSlGR
         A/YcrPqCdG/9I0Bvbgkae1PpY/dUBLQDsx38BIEIAPK92Y4flybdomTphz9xd1bbgiiI
         6U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SBHx9PW6jhqq6hqNuWf3Y2GoTEAsmPKYUx01XQ8gpls=;
        b=EzAghm3WNaYjaZEH/1u6ytZh5hvLGwFuRuJmjF80X7ILM0GHFcIScwlzBU64jCH/Zi
         xSBc1khYCSWbkOW7PgitXPFbq/0FMyCrso9xnJFxiuxlijo37hAcKe70xv1ZvjMPanK5
         Pvr+M9fmt8H1kgArthYI6Ud7cJJYojW4cLPJNKkOZ+D0AhXocm6FrtarSGMJB7xiWIpG
         5pgCf28YAN+ou70P1s1VcdfN0bLiFWQ9Wad7WkisQqF+HpIJ5liZppXEv9p0zEK+3Gdh
         vvCgX9k8tLUTnqk1RBzPyKIpymwgpGk9IQq1cQd8Or5L0cvu4WDySPi0q2TFjrz3NKTo
         Wt4Q==
X-Gm-Message-State: APzg51DZvFFG8YQ34W/+mJqQGgqLZ0DBbh8nP5a5fAcKMUBswTcHfQTX
        j88VpjrZys9bYy5Ka+FKTss=
X-Google-Smtp-Source: ANB0VdZ3CGDCxorYORlI9uJSqnIEYbczv4y9fLqeMXUgIilNKG98YyWnkMfbW+u/Qgn6nKj+zYlgZQ==
X-Received: by 2002:a1c:1d0:: with SMTP id 199-v6mr4531520wmb.2.1535712855527;
        Fri, 31 Aug 2018 03:54:15 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id n5-v6sm3093280wmh.1.2018.08.31.03.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 03:54:14 -0700 (PDT)
Date:   Fri, 31 Aug 2018 12:54:12 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     maxime.ripard@bootlin.com
Cc:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Message-ID: <20180831105412.GD16301@Red>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com>
 <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red>
 <20180831102021.idz42sfgldihpkrp@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831102021.idz42sfgldihpkrp@flea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:20:21PM +0200, maxime.ripard@bootlin.com wrote:
> On Fri, Aug 31, 2018 at 09:56:31AM +0200, Corentin Labbe wrote:
> > On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > > R40 have a sata controller which is the same as A20.
> > > > This patch adds a DT node for it.
> > > > 
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > index 852c2ccc3268..d6b5820da850 100644
> > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > @@ -550,6 +550,29 @@
> > > >  			#size-cells = <0>;
> > > >  		};
> > > >  
> > > > +		ahci: sata@1c18000 {
> > > > +			compatible = "allwinner,sun8i-r40-ahci";
> > > > +			reg = <0x01c18000 0x1000>;
> > > > +			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > > +			resets = <&ccu RST_BUS_SATA>;
> > > > +			resets-name = "ahci";
> > > > +			#address-cells = <1>;
> > > > +			#size-cells = <0>;
> > > > +			status = "disabled";
> > > > +
> > > > +			sata_port: sata-port@0 {
> > > > +				reg = <0>;
> > > > +				phys = <&sata_phy>;
> > > > +			};
> > > > +		};
> > > > +
> > > > +		sata_phy: sata-phy@1c180c0  {
> > > > +			compatible = "allwinner,sun8i-r40-sata-phy";
> > > > +			reg = <0x1c180c0 0x200>;
> > > 
> > > Overlapping devices in the DTS is not ok.
> > > 
> > 
> > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000
> > phy@e900a0)
> >
> > But since it is not a good justification, it seems that regmap is my
> > only solution ?
> 
> I'm not even sure why you are moving the phy out of its original node
> (and driver).
> 

For using the phy-supply already handled by the code.
The other choice is to add another xxx-supply to ahci_platform.
Or to use hackily port_regulator for this regulator.
