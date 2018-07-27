Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2853E2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="twD7y2gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2853E2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbeG0MSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:18:21 -0400
Received: from mail.blih.net ([212.83.177.182]:11604 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbeG0MSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:18:21 -0400
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id 80334dfb;
        Fri, 27 Jul 2018 12:56:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=dv8Bkkr39ul4WAzDhiyv2kba+OY=; b=twD7y2gwwQWOeG5JXowKXKtgqFDl
        G2+8Kapky5k0OIr3yiDKM5p3tx4rDIFbC5BCzVX0He9JYY0azWq816u9hWAzrwxk
        jPBG94gjLP/v+/b+jIYcf+Vn9QPs0ZEMplLFznqLmdHQwsfkwBWG4Kd/yeBfmS1Z
        bM/xyA0alcxVVrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=QlcAtlfFkK0giAOxBT4qSO4JR2dTzbncFmiiIKLIHBjzUaZWeQcApZSf
        7lygmb0Cz/OMAzGLO3Io8o8gLGlpcdiOs7MbmfDEiXIjKUBNqnC00T1XFFb+tvc4
        K7ilhcJRJ++6s085rQ8ou8+jcCRjhvKqpKh+ZUJAfhtHYN/M3G4=
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id cdfa0d4c
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Fri, 27 Jul 2018 12:56:55 +0200 (CEST)
Date:   Fri, 27 Jul 2018 12:56:54 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
        wens@csie.org, robh+dt@kernel.org, srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] arm64: dts: allwinner: h5: Add SID for H5
Message-Id: <20180727125654.ec813df71b492201aea2ca5f@bidouilliste.com>
In-Reply-To: <20180726115409.7hqtvx4rdqcqdjrq@flea>
References: <20180724101522.68165-1-manu@freebsd.org>
        <20180724101522.68165-5-manu@freebsd.org>
        <20180724130004.ynaiabshexrrbvo4@flea>
        <20180724153432.e398bddfe63e51e8dcebfc46@bidouilliste.com>
        <20180724144218.jdvgrcqkz2kmohqx@flea>
        <20180724165501.d8f01bf20c7cc43e7ed7fc62@bidouilliste.com>
        <20180726115409.7hqtvx4rdqcqdjrq@flea>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 13:54:09 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Tue, Jul 24, 2018 at 04:55:01PM +0200, Emmanuel Vadot wrote:
> > On Tue, 24 Jul 2018 16:42:18 +0200
> > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > 
> > > On Tue, Jul 24, 2018 at 03:34:32PM +0200, Emmanuel Vadot wrote:
> > > > On Tue, 24 Jul 2018 15:00:04 +0200
> > > > Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > 
> > > > > On Tue, Jul 24, 2018 at 12:15:22PM +0200, Emmanuel Vadot wrote:
> > > > > > The SID controller on H5 look the same as the one present in the A64.
> > > > > > But in case we find some difference one day at a compatible string
> > > > > > of it's own and a fallback to the A64 one.
> > > > > > 
> > > > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > > index 62d646baac3c..28183bf77164 100644
> > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > > > > @@ -129,3 +129,8 @@
> > > > > >  		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> > > > > >  	compatible = "allwinner,sun50i-h5-pinctrl";
> > > > > >  };
> > > > > > +
> > > > > > +&sid {
> > > > > > +	compatible = "allwinner,sun50i-h5-sid",
> > > > > > +		     "allwinner,sun50i-a64-sid";
> > > > > > +};
> > > > > 
> > > > > This is still a bit pointless, please remove the common node.
> > > > 
> > > >  You mean directly declare sid controller in the SoC dtsi and not
> > > > have a common node in sunxi-h3-h5.dtsi ?
> > > 
> > > Yep
> > 
> >  The reason I've put it in the common file is because I'll send patches
> > for the nvmem-cells needed for thermal, and those are common between
> > the two. Other nvmem-cells are also common (like the chipid and
> > probably other).
> 
> Then we'll see what we can have in common and what not when we'll have
> something in common?

 Will it make more sense that I just send a new series with nvmem-cells
now along with thermal bindings ?

> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
