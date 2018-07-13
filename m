Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37476ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50EE2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50EE2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbeGMCkt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:40:49 -0400
Received: from hermes.aosc.io ([199.195.250.187]:49961 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387762AbeGMCkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:40:49 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id EFB00559EE;
        Fri, 13 Jul 2018 02:28:20 +0000 (UTC)
Date:   Fri, 13 Jul 2018 10:28:08 +0800
In-Reply-To: <20180712145306.ootqt7dfh3nxsamy@flea>
References: <20180711132233.42301-1-icenowy@aosc.io> <20180711132233.42301-2-icenowy@aosc.io> <20180711150532.6gzm7krouriddreh@flea> <8F6CDF5C-2AC1-43EC-858A-5C6345CF279A@aosc.io> <20180712064601.m3bdd46wzac5fpgh@flea> <A7CA2831-7117-415C-BC59-3FB4AE425598@aosc.io> <20180712145306.ootqt7dfh3nxsamy@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output on Banana Pi M2 Zero
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <82CD0BCE-9DE4-45D7-8DF4-FCCFBC70BECF@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月12日 GMT+08:00 下午10:53:06, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Thu, Jul 12, 2018 at 03:09:55PM +0800, Icenowy Zheng wrote:
>> 于 2018年7月12日 GMT+08:00 下午2:46:01, Maxime Ripard
><maxime.ripard@bootlin.com> 写到:
>> >On Wed, Jul 11, 2018 at 11:15:50PM +0800, Icenowy Zheng wrote:
>> >> 
>> >> 
>> >> 于 2018年7月11日 GMT+08:00 下午11:05:32, Maxime Ripard
>> ><maxime.ripard@bootlin.com> 写到:
>> >> >Hi,
>> >> >
>> >> >On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
>> >> >> Banana Pi M2 Zero board has a miniHDMI port connected to the
>HDMI
>> >> >> controller of Allwinner H3 SoC.
>> >> >> 
>> >> >> Enable the HDMI output in Banana Pi M2 Zero device tree.
>> >> >> 
>> >> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >> >> ---
>> >> >>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25
>> >> >+++++++++++++++++++
>> >> >>  1 file changed, 25 insertions(+)
>> >> >> 
>> >> >> diff --git
>a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> >b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> >> index 7d01f9322658..eb61dcf32797 100644
>> >> >> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> >> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> >> >> @@ -26,6 +26,17 @@
>> >> >>  		stdout-path = "serial0:115200n8";
>> >> >>  	};
>> >> >>  
>> >> >> +	hdmi-connector {
>> >> >> +		compatible = "hdmi-connector";
>> >> >> +		type = "c";
>> >> >
>> >> >This is not one of the connector type declared in DRM, how is it
>> >> >exposed to the userspace?
>> >> 
>> >> So just use "A" here (because of single link)?
>> >
>> >If the connector type is C, it should be C, and DRM / driver
>adjusted
>> >to handle it.
>> 
>> Okay I won't change this property, if there's any further revisions.
>> 
>> For DRM driver, I think it can be an independent patchset.
>
>Not really, since it's going to break userspace as soon as you merge
>that other patchset.

Should we bother the DRM maintainer to ask for any advice?

>
>Maxime
>
>-- 
>Maxime Ripard, Bootlin (formerly Free Electrons)
>Embedded Linux and Kernel engineering
>https://bootlin.com
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
