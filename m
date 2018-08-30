Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9640C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C62C20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="S9syPAPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C62C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeH3Ule (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:41:34 -0400
Received: from vps.xff.cz ([195.181.215.36]:35644 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbeH3Ule (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1535647114; bh=K4NhqDx3LpGTI8xLetxC1QVSbl52xpR96Gka9aLuwLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9syPAPWJJBIIlovkgJMOIAhJc1m8obULnQRykIysH2jzrzLAAHVaAkHhN4Hs7R/n
         hQ4arSLvIXO5YpfUDFjdy7/Z+pq5WyG2giM77FFJrzKuz2MfArAoqh3pnecjKrapcH
         RIpYIzPz9PHeWfWGKdO2R+ANNEDkRqPyIHVmDJkQ=
Date:   Thu, 30 Aug 2018 18:38:33 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP
 tables and CPUfreq
Message-ID: <20180830163833.v7zvmaz2vsxvzhur@core>
Mail-Followup-To: Philipp Rossak <embed3d@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de, broonie@kernel.org,
        arnaud.pouliquen@st.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-31-embed3d@gmail.com>
If-You-Cant-Reach-Me-Try: <https://megous.com/mail-form>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
> Since we have now thermal trotteling enabeled we can now add the full
> range of the OPP table.

I'm not sure we can. I have a tablet with A83T SoC and it gets unstable
at these frequencies even with thermal throttling on mainline kernel. (Though
I have my own THS driver, but I doubt a different driver will change much.)

There might be some other issue left in the cpufreq code. I'll let others
test this on a better cooled boards though.

Did you/someone test this?

regards,
  o.

> The operating points were found in Allwinner BSP and fex files.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 78aa448e869f..ddcf404f9c80 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -250,6 +250,22 @@
>  			opp-microvolt = <840000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <920000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1800000000 { /* BOOT FREQ */
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <1080000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
>  	};
>  
>  	cpu1_opp_table: opp_table1 {
> @@ -303,6 +319,22 @@
>  			opp-microvolt = <840000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <920000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1800000000 { /* BOOT FREQ */
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <1080000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
>  	};
>  
>  	soc {
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
