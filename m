Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4350C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D12208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TOdnLZlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D12208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeIYMLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:11:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34262 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYMLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:11:54 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8P64Z32080492;
        Tue, 25 Sep 2018 01:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537855475;
        bh=zRaoDRJ6vx+RmcKmsgkNFV2hs1MrM1UpTi7QKAZDSF8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TOdnLZlVNvt0LM/O2f/Hb1DMhs5AbuonAGCk9awnUBf1C+TCDSIl52yKThuKSMuIj
         M/MwutMCULhq7Me6FJRbD+dwM6Ufwf1EPy053ejDtScdShdU80OqajkG2SMPynQ3qX
         7GisxQQWaJ0N50qnZy9BacSwW9tfkilfm3Yln0rk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P64ZEe026445;
        Tue, 25 Sep 2018 01:04:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 01:04:34 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 01:04:34 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P64WU8012457;
        Tue, 25 Sep 2018 01:04:33 -0500
Subject: Re: [PATCH] ARM: dts: da850-lego-ev3: slow down A/DC as much as
 possible
To:     David Lechner <david@lechnology.com>
CC:     Kevin Hilman <khilman@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180924013146.18121-1-david@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a6e9c7ce-8fc8-0ee2-2d3a-24c33b67bdcc@ti.com>
Date:   Tue, 25 Sep 2018 11:34:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924013146.18121-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Monday 24 September 2018 07:01 AM, David Lechner wrote:
> Due to the electrical design of the A/DC circuits on LEGO MINDSTORMS EV3,
> if we are reading analog values as fast as possible (i.e. using DMA to
> service the SPI) the A/DC chip will read incorrect values - as much as
> 0.1V off when the SPI is running at 10MHz. (This has to do with the
> capacitor charge time when channels are muxed in the A/DC.)

So you believe this is an issue with the board design rather than the
limitation of the ADC chip itself? Because if its the later, the fix
should be in the driver instead.

> 
> This patch slows down the SPI as much as possible (if CPU is at 456MHz,
> SPI runs at 1/2 of that, so 228MHz and has a max prescalar of 256, so
> we could get ~891kHz, but we're just rounding it to 1MHz). We also use
> the max allowable value for WDELAY to slow things down even more.
> 
> These changes reduce the error of the analog values to about 5mV, which
> is tolerable.
> 
> Commits a3762b13a596 ("spi: spi-davinci: Add support for SPI_CS_WORD")
> and e2540da86ef8 ("iio: adc: ti-ads7950: use SPI_CS_WORD to reduce
> CPU usage") introduce changes that allow DMA transfers to be used, so
> this slow down is needed now.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> FYI, this patch doesn't strictly depend on the other two mentioned. In fact, it
> would better if it got merged before them, but the consequences are minimal, so
> it doesn't seem worth it to me to try coordinating merges here.
> 
> Both of these patches mentioned have been picked up in the respective
> subsystems.

Is this needed for the -rc cycle or can wait for v4.20?

Thanks,
Sekhar

> 
>  arch/arm/boot/dts/da850-lego-ev3.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
> index c4729d0e6c19..66fcadf0ba91 100644
> --- a/arch/arm/boot/dts/da850-lego-ev3.dts
> +++ b/arch/arm/boot/dts/da850-lego-ev3.dts
> @@ -352,7 +352,8 @@
>  		compatible = "ti,ads7957";
>  		reg = <3>;
>  		#io-channel-cells = <1>;
> -		spi-max-frequency = <10000000>;
> +		spi-max-frequency = <1000000>;
> +		ti,spi-wdelay = <63>;
>  		vref-supply = <&adc_ref>;
>  	};
>  };
> -- 
> 2.17.1
> 

