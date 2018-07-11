Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E5D208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E5D208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbeGKPVx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:21:53 -0400
Received: from hermes.aosc.io ([199.195.250.187]:35007 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeGKPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:21:53 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id DCC0562CDF;
        Wed, 11 Jul 2018 15:16:53 +0000 (UTC)
Date:   Wed, 11 Jul 2018 23:15:50 +0800
In-Reply-To: <20180711150532.6gzm7krouriddreh@flea>
References: <20180711132233.42301-1-icenowy@aosc.io> <20180711132233.42301-2-icenowy@aosc.io> <20180711150532.6gzm7krouriddreh@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH 1/2] ARM: sun8i: h3: enable HDMI output on Banana Pi M2 Zero
To:     maxime.ripard@bootlin.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <8F6CDF5C-2AC1-43EC-858A-5C6345CF279A@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月11日 GMT+08:00 下午11:05:32, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>Hi,
>
>On Wed, Jul 11, 2018 at 09:22:32PM +0800, Icenowy Zheng wrote:
>> Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
>> controller of Allwinner H3 SoC.
>> 
>> Enable the HDMI output in Banana Pi M2 Zero device tree.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 25
>+++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> index 7d01f9322658..eb61dcf32797 100644
>> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
>> @@ -26,6 +26,17 @@
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +		type = "c";
>
>This is not one of the connector type declared in DRM, how is it
>exposed to the userspace?

So just use "A" here (because of single link)?

>
>Maxime
