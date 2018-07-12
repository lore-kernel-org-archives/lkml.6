Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423B0213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423B0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbeGLPDB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:03:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34201 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732305AbeGLPDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:03:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6BA8F2072B; Thu, 12 Jul 2018 16:53:06 +0200 (CEST)
Received: from localhost (LFbn-1-2035-163.w90-76.abo.wanadoo.fr [90.76.104.163])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3C23520618;
        Thu, 12 Jul 2018 16:53:06 +0200 (CEST)
Date:   Thu, 12 Jul 2018 16:53:06 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output
 on Banana Pi M2 Zero
Message-ID: <20180712145306.ootqt7dfh3nxsamy@flea>
References: <20180711132233.42301-1-icenowy@aosc.io>
 <20180711132233.42301-2-icenowy@aosc.io>
 <20180711150532.6gzm7krouriddreh@flea>
 <8F6CDF5C-2AC1-43EC-858A-5C6345CF279A@aosc.io>
 <20180712064601.m3bdd46wzac5fpgh@flea>
 <A7CA2831-7117-415C-BC59-3FB4AE425598@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <A7CA2831-7117-415C-BC59-3FB4AE425598@aosc.io>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 03:09:55PM +0800, Icenowy Zheng wrote:
> 于 2018年7月12日 GMT+08:00 下午2:46:01, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
> >On Wed, Jul 11, 2018 at 11:15:50PM +0800, Icenowy Zheng wrote:
> >> 
> >> 
> >> 于 2018年7月11日 GMT+08:00 下午11:05:32, Maxime Ripard
> ><maxime.ripard@bootlin.com> 写到:
> >> >Hi,
> >> >
> >> >On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
> >> >> Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
> >> >> controller of Allwinner H3 SoC.
> >> >> 
> >> >> Enable the HDMI output in Banana Pi M2 Zero device tree.
> >> >> 
> >> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> >> ---
> >> >>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25
> >> >+++++++++++++++++++
> >> >>  1 file changed, 25 insertions(+)
> >> >> 
> >> >> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> >b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> >> index 7d01f9322658..eb61dcf32797 100644
> >> >> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> >> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> >> @@ -26,6 +26,17 @@
> >> >>  		stdout-path = "serial0:115200n8";
> >> >>  	};
> >> >>  
> >> >> +	hdmi-connector {
> >> >> +		compatible = "hdmi-connector";
> >> >> +		type = "c";
> >> >
> >> >This is not one of the connector type declared in DRM, how is it
> >> >exposed to the userspace?
> >> 
> >> So just use "A" here (because of single link)?
> >
> >If the connector type is C, it should be C, and DRM / driver adjusted
> >to handle it.
> 
> Okay I won't change this property, if there's any further revisions.
> 
> For DRM driver, I think it can be an independent patchset.

Not really, since it's going to break userspace as soon as you merge
that other patchset.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
