Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132EC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F7C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F7C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeJMD54 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:57:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59177 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeJMD5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:57:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EBE6E20379; Fri, 12 Oct 2018 22:23:39 +0200 (CEST)
Received: from localhost (LFbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id B3FE420379;
        Fri, 12 Oct 2018 22:23:29 +0200 (CEST)
Date:   Fri, 12 Oct 2018 22:23:30 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] arm64: dts: allwinner: new board - Emlid Neutis N5
Message-ID: <20181012202330.tdwedsof2bsnxkxn@flea>
References: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <b47c5458-683e-3e96-0bbe-f9db84579c77@suse.de>
 <20181012133914.GA32670@imagebutcher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181012133914.GA32670@imagebutcher>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 04:39:14PM +0300, Aleksandr Aleksandrov wrote:
> Hi Andreas,
> 
> Thanks for your feedback!
> 
> > > + *
> > > + * Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "sun50i-h5-emlid-neutis-n5.dtsi"
> > > +
> > > +/ {
> > > +	model = "Emlid Neutis N5 Developer board";
> > > +	compatible = "emlid,neutis-n5-devboard",
> > > +		     "emlid,neutis-n5",
> > 
> > You are lacking bindings definitions for these new identifiers. The
> > vendor prefix should be patch 1/3, the SoM/board compatibles 2/3 and
> > this .dts[i] patch 3/3, so that only vendor prefixes and compatibles
> > that are defined and don't result in checkpatch.pl warnings get used.
> 
> Patch 2/3:
> 
> commit 46dcb8632b36644cb20e6b35ede12ff0088a60eb
> Author: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> Date:   Fri Oct 12 16:22:28 2018 +0300
> 
>     dt-bindings: arm: sunxi: emlid,neutis-n5(-devboard)
>     
>     sunxi: add new compatibles for Emlid Neutis Dev board and SoM module
>     
>     Signed-off-by: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> index e4beec3..a907e52 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.txt
> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> @@ -19,3 +19,5 @@ using one of the following compatible strings:
>    allwinner,sun9i-a80
>    allwinner,sun50i-a64
>    nextthing,gr8
> +  emlid,neutis-n5
> +  emlid,neutis-n5-devboard
> 
> Is this right place for the neutis compatibles?

No, those are for SoCs compatible. I'm not sure we ever created a
board compatible files.

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
