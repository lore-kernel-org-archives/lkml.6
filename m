Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73361C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CB92082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="KczURCAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CB92082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIDVMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:12:22 -0400
Received: from mail.blih.net ([212.83.177.182]:57667 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDVMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:12:21 -0400
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id f311de5b;
        Tue, 4 Sep 2018 18:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=uSJ6UYRJXet2HMO71h9xlEAjfi0=; b=KczURCACHBttCOn8muVF/h14Pz/w
        k4z85/n2Fpu1jmclRZci3k0S4nQX0YoJZqAK9TS/2eYgyNjWXzqV2FhL0jqir4Q+
        9F39mVHuIdPGhQ+LEdhpQREFlc8o0QvkA6LyFf7op4JuCKd++MoDj5JgLd0CGRJz
        IAiKlLDPgHOPyyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=B1YVLF8JEW37MxokHzXqY0wYqeKO3LvrBDKlzjtNcS/Sx+xGK9P9y+KC
        YUr+KGxxzY49bXWAmwKJIqIh34XFjSw7vYhN7f5GAPodhEzK3ZBqfQWy/MQ2C+CF
        eOxV+giP5UrDaAx9IWueDzF0Q5y9UCft7UXKnHD0qputbKNmijM=
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id b1c04b4f
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Tue, 4 Sep 2018 18:46:23 +0200 (CEST)
Date:   Tue, 4 Sep 2018 18:46:23 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
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
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
Message-Id: <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
In-Reply-To: <20180830154518.29507-28-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-28-embed3d@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Philipp,

On Thu, 30 Aug 2018 17:45:15 +0200
Philipp Rossak <embed3d@gmail.com> wrote:

> The H3 SID is supported by the kernel so we can add a NVMEM Data cell,
> that contains the calibration data.
> 
> On the H3 the eFuses are located at the offset 0x200. The thermal data
> itself has an offset of 0x34 from the eFuse base. So we end on an offset
> of 0x234.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 1866aec69ec1..0fc447f0c02a 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -106,8 +106,15 @@
>  
>  	soc {
>  		sid: eeprom@1c14000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
>  			compatible = "allwinner,sun8i-h3-sid";
>  			reg = <0x01c14000 0x400>;
> +
> +			/* Data cells */
> +			thermal_calibration: calib@234 {
> +				reg = <0x234 0x8>;
> +			};

 You are declaring 8 bytes of calibration data but to my knowledge it's
only 2 bytes per sensor, so 2 bytes for H3.
 Am I missing something ?

 Thanks,
>  		};
>  	};
>  
> @@ -227,4 +234,6 @@
>  &ths {
>  	compatible = "allwinner,sun8i-h3-ths";
>  	#thermal-sensor-cells = <0>;
> +	nvmem-cells = <&thermal_calibration>;
> +	nvmem-cell-names = "calibration";
>  };
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
