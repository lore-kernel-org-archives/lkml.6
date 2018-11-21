Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1788206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1788206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeKVIdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:33:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:39355 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731600AbeKVIdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 03:33:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 13:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,262,1539673200"; 
   d="scan'208";a="88244060"
Received: from uoffert-mobl1.ger.corp.intel.com (HELO mara.localdomain) ([10.252.30.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Nov 2018 13:56:54 -0800
Received: from sailus by mara.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1gPaUN-0000Ld-DA; Wed, 21 Nov 2018 23:56:51 +0200
Date:   Wed, 21 Nov 2018 23:56:50 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: media: Add Allwinner A10 CSI binding
Message-ID: <20181121215650.urefxctd245os6t5@mara.localdomain>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <60494dd4245ab01473d074dc5cd46198a2181614.1542097288.git-series.maxime.ripard@bootlin.com>
 <20181113083855.s5jxrb32ru3myu3t@kekkonen.localdomain>
 <20181115190424.gpuekifrjli5mu77@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115190424.gpuekifrjli5mu77@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Nov 15, 2018 at 08:04:24PM +0100, Maxime Ripard wrote:
> Hi Sakari,
> 
> On Tue, Nov 13, 2018 at 10:38:55AM +0200, Sakari Ailus wrote:
> > > +  - allwinner,has-isp: Whether the CSI controller has an ISP
> > > +                       associated to it or not
> > 
> > Is the ISP a part of the same device? It sounds like that this is actually
> > a different device if it contains an ISP as well, and that should be
> > apparent from the compatible string. What do you think?
> 
> I guess we can see it as both. It seems to be the exact same register
> set, except for the fact that the first instance has that ISP in
> addition, and several channels, as you pointed out in your other mail.

I'm simply referring to existing practices as far as I know them. If it's a
different device, it should have a different compatible string, not a
vendor-specific property to tell it's somehow different.

Many SoCs also separate the DMA and the CSI-2 receivers, and thus they have
separate drivers. I don't know about your case, but the ISP requiring a
different clock is a hint.

> 
> What these channels are is not exactly clear. It looks like it's
> related to the BT656 interface where you could interleave channel
> bytes over the bus. I haven't really looked into it, and it doesn't
> look like we have any code (or hardware) able to do that though.
> 
> > > +
> > > +If allwinner,has-isp is set, an additional "isp" clock is needed,
> > > +being a phandle to the clock driving the ISP.
> > > +
> > > +The CSI node should contain one 'port' child node with one child
> > > +'endpoint' node, according to the bindings defined in
> > > +Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > > +endpoint's bus type must be parallel or BT656.
> > > +
> > > +Endpoint node properties for CSI
> > > +---------------------------------
> > > +
> > > +- remote-endpoint	: (required) a phandle to the bus receiver's endpoint
> > > +			   node
> > 
> > Rob's opinion has been (AFAIU) that this is not needed as it's already a
> > part of the graph bindings. Unless you want to say that it's required, that
> > is --- the graph bindings document it as optional.
> 
> Ok, I'll remove it.
> 
> > > +- bus-width:		: (required) must be 8
> > 
> > If this is the only value the hardware supports, I don't see why you should
> > specify it here.
> 
> Ditto :)
> 
> > > +- pclk-sample		: (optional) (default: sample on falling edge)
> > > +- hsync-active		: (only required for parallel)
> > > +- vsync-active		: (only required for parallel)
> > > +
> > > +Example:
> > > +
> > > +csi0: csi@1c09000 {
> > > +	compatible = "allwinner,sun7i-a20-csi",
> > > +		     "allwinner,sun4i-a10-csi";
> > > +	reg = <0x01c09000 0x1000>;
> > > +	interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > > +	clocks = <&ccu CLK_AHB_CSI0>, <&ccu CLK_CSI0>,
> > > +		 <&ccu CLK_CSI_SCLK>, <&ccu CLK_DRAM_CSI0>;
> > > +	clock-names = "ahb", "mod", "isp", "ram";
> > > +	resets = <&ccu RST_CSI0>;
> > > +	allwinner,csi-channels = <4>;
> > > +	allwinner,has-isp;
> > > +	
> > > +	port {
> > > +		csi_from_ov5640: endpoint {
> > > +                        remote-endpoint = <&ov5640_to_csi>;
> > > +                        bus-width = <8>;
> > > +                        data-shift = <2>;
> > 
> > data-shift needs to be documented above if it's relevant for the device.
> 
> It's not really related to the CSI device in that case but the sensor,
> so I'll just leave it out.

Hmm. data-shift should only be relevant for the receiver, shoudn't it?

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
