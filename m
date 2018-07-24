Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472F5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E45220875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E45220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbeGXKDE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:03:04 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42999 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388136AbeGXKDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:03:04 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 7F2959F71F;
        Tue, 24 Jul 2018 08:57:32 +0000 (UTC)
Date:   Tue, 24 Jul 2018 16:57:25 +0800
In-Reply-To: <20180724085639.2cebno52qfxrzmdw@flea>
References: <20180724011551.49603-1-icenowy@aosc.io> <20180724011551.49603-3-icenowy@aosc.io> <20180724085639.2cebno52qfxrzmdw@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/3] arm64: allwinner: dts: h6: add pinmux for MMC1
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <6F2D0379-C4D1-49AA-B089-7FFE27258E79@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月24日 GMT+08:00 下午4:56:39, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Tue, Jul 24, 2018 at 09:15:50AM +0800, Icenowy Zheng wrote:
>> The MMC1 controller on H6, in the reference design and most third
>party
>> design, is used to connect SDIO Wi-Fi.
>> 
>> Add pinmux for it.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> index cfa5fffcf62b..ba1a3a3e2149 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -134,6 +134,14 @@
>>  				bias-pull-up;
>>  			};
>>  
>> +			mmc1_pins: mmc1-pins {
>> +				pins = "PG0", "PG1", "PG2", "PG3",
>> +				       "PG4", "PG5";
>> +				function = "mmc1";
>> +				drive-strength = <30>;
>> +				bias-pull-up;
>> +			};
>> +
>
>Is that the sole muxing option for MMC1? If so, it should be added to
>the mmc1 node.

Oh... yes, it is.

Will do in v2.

>
>Maxime
