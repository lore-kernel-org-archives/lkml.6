Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C075EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB25206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="cghMDtcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB25206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exceet.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeIZNV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:21:58 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.131]:17876 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeIZNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1537945826;
        s=strato-dkim-0002; d=as-electronics.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=dXdoWPqv5ahD/gCdBkavYRQD+SE6vwS0G6UvzmSpo04=;
        b=cghMDtcnJsMQlYVbns3OuUPKLtcU9YCqDRPVOsMPAcV3B8bb+AAjyRIir1DcZWxSpm
        TVPlgQcMuwMHriU6m1WFhKLHi03ThM4HyflZW7yD4SgUUOjT96hamggiPP2+1Zx+Pltu
        pmaC62cVTtcZnThkYiXA7Q89OYdhVIusv+8UdwFpihGKMNT3WhZPHPDxT0zAOThGhuMh
        v50xjUNShp4bFKyYmgPPGG8UvMrOV+VOM78wRl4g8/mtgXnaQMhCSfQ/MCI6i5Vr4Hzp
        retp2YAQRq9vOrXYwR5qTf9QKZNSbj7O02H5bUT35be16vPIPXT0ntZcwiUBje+obaoX
        EY7Q==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx2zAOrX/r2ZbrrxoyOl37jyAS87PCEdNZ1JosR9A8+EnwdTNhIEa3LxU1dwv15qr4="
X-RZG-CLASS-ID: mo05
Received: from [IPv6:2001:16b8:24d1:c900:7e56:f2b:35d9:ddc0]
        by smtp.strato.de (RZmta 44.2 AUTH)
        with ESMTPSA id L0a112u8Q7AH3e2
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 26 Sep 2018 09:10:17 +0200 (CEST)
Subject: Re: [PATCH] arm64: dts: rockchip: Enable SPI NOR flash on Rock64
To:     Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20180926045357.20722-1-wens@csie.org>
From:   Frieder Schrempf <frieder.schrempf@exceet.de>
Message-ID: <7ecb43c3-1693-005b-b547-03ca361bd843@exceet.de>
Date:   Wed, 26 Sep 2018 09:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926045357.20722-1-wens@csie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2018 06:53, Chen-Yu Tsai wrote:
> The Pine64 Rock64 board comes with a GigaDevice GD25Q128CSIG
> or GD25Q127CSIG chip, which is a 128 Mbit SPI NOR flash chip
> that supports the JEDEC read-ID command.
> 
> This patch enables the SPI controller and adds a device node
> for the flash chip using the generic "jedec,spi-nor" comaptible.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> This was working on linux-next 20180910, but now fails on linux-next
> 20180925, with the following error messages:
> 
>      m25p80 spi0.0: error -22 reading 9f
>      m25p80: probe of spi0.0 failed with error -2
> 
> Reverting the spi/for-next branch makes it work again:
> 
>      m25p80 spi0.0: gd25q128 (16384 Kbytes)
> 
> Not sure what's up.

The reason is probably an issue that was introduced here: [1], and it 
was fixed here: [2].

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/spi?id=380583227c0c7f52383b0cd5c0e2de93ed31d553
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/spi?id=4c53f98555fdbf1cc291cab8ffa5e1507a4f25d9

> 
> ---
>   arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 9ee4f57557f3..2170cf63845e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -290,6 +290,18 @@
>   	};
>   };
>   
> +&spi0 {
> +	status = "okay";
> +
> +	spiflash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +
> +		/* maximum speed for Rockchip SPI */
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
>   &tsadc {
>   	rockchip,hw-tshut-mode = <0>;
>   	rockchip,hw-tshut-polarity = <0>;
> 
