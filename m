Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D6F21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv3+c5Vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D6F21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbeKOAk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:40:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43026 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeKOAk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:40:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id f4so1135071edq.10;
        Wed, 14 Nov 2018 06:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aRycQnRTj5fx30HcYW7/LCD+gglklYsd+8/wDXTcQDU=;
        b=dv3+c5VihQ0mgn/5l4Gd9/Vrf9XvV9y4u/yiNFkacpvCvZXr0PzEdSNeckiHGwM4WG
         NoowFmYfki/k/R1PF8ikpi5uAaPgZ2w/urakM0u+PqC/L+n+GfeIdq1JPHj7fE/GhzvJ
         dco6QbCrcRyxA7nLNrcv6LbUiZhwlDvJ+1nUYi1q+p/Rwax4Fm3AzM+nkjKWTk8x8+M+
         0P5jTGwYSdlLjZYh6RbvHuuNUDc7447Y6miazOq7CoBFREUdGPSn2oxST/kGe4v61FtP
         mudqNR0+VjPJvQlGUEKPm6xfGA30oum20OXTq9ORnGc+idbbccd04TTrOAKyfsJG4Gbc
         X2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aRycQnRTj5fx30HcYW7/LCD+gglklYsd+8/wDXTcQDU=;
        b=TqNbfam67l9Nl7ELV9GnXt4adMpfOm79Vaab46/+bbZ5VWWTuoaXQfztiZja4xOxip
         4cV5GwfrL1AT4DOzDlxOG08mL045PFohPOYZU7oWHfg3I7F2rlJaYqXiM4uJXSFQBy6b
         xfCq2DoOWyhuV3Mi6WtiDTbwmrkuqC3eTmB0ZQk4ovc7BCT8NvyJPBrhR61bcIvN7AKA
         Kkk+LdufJKc9q67TgQLX2zi6nBQKh64ZU1+uMPvSylmJZogguageeIIGgwjPH6XdFNSQ
         IIxPCOK09dzICdfum0UVsHVbcNcwJTii6iQPgOopHnW4h+WouDtgB++Py16IAI0t9WKw
         t/Hw==
X-Gm-Message-State: AGRZ1gILfpHcDor3NG9ageiL50jIMa4UKuCVRlhdsX03DghJvb0Kr6X+
        3Eiemmm3I2rcACo/VvjeK5EH4Tpd
X-Google-Smtp-Source: AJdET5freQL1Mp0SojqUR69vBthwIJoUxM66T+qaacuv1ASVTJvlOzogGpa8Qxg3T5eQGsRbzQ4B3g==
X-Received: by 2002:a50:ee1a:: with SMTP id g26mr1222792eds.266.1542206246929;
        Wed, 14 Nov 2018 06:37:26 -0800 (PST)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id c30sm1421696edc.70.2018.11.14.06.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 06:37:26 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gMwIH-0004kd-6A; Wed, 14 Nov 2018 15:37:25 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] arm64: dts: meson: add libretech aml-s805x-ac board
References: <20181114101925.10526-3-jbrunet@baylibre.com>
        <20181114103855.14571-1-jbrunet@baylibre.com>
Date:   Wed, 14 Nov 2018 15:37:25 +0100
In-Reply-To: <20181114103855.14571-1-jbrunet@baylibre.com> (Jerome Brunet's
        message of "Wed, 14 Nov 2018 11:38:55 +0100")
Message-ID: <87a7mbvi6y.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jerome" == Jerome Brunet <jbrunet@baylibre.com> writes:

 > From: Neil Armstrong <narmstrong@baylibre.com>
 > Add Libretech aml-s805x-ac board (aka 'La Frite') support

 > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
 > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
 > ---

..

 > +#include "meson-gxl-s905x.dtsi"
 > +
 > +/ {
 > +	compatible = "libretech,aml-s805x-ac", "amlogic,s805x",
 > +		     "amlogic,meson-gxl";
 > +	model = "Libre Computer Board AML-S805X-AC";

No mention of 'La Frite'?

 > +	memory@0 {
 > +		device_type = "memory";
 > +		reg = <0x0 0x0 0x0 0x20000000>;
 > +	};

Maybe add a comment that there's 1GB variants as well?

> +
 > +	vcck: regulator-vcck {
 > +		compatible = "regulator-fixed";
 > +		regulator-name = "VCCK";
 > +		regulator-min-microvolt = <3300000>;
 > +		regulator-max-microvolt = <3300000>;
 > +		vin-supply = <&dc_5v>;
 > +
 > +		/*
 > +		 * This is controlled by GPIOAO_9 we reserve this but
 > +		 * claiming it as done bellow reset the board anyway

s/bellow/below/

 > +&spifc {
 > +	status = "okay";
 > +	pinctrl-0 = <&nor_pins>;
 > +	pinctrl-names = "default";
 > +
 > +	w25q32: spi-flash@0 {
 > +		#address-cells = <1>;
 > +		#size-cells = <1>;
 > +		compatible = "jedec,spi-nor";
 > +		reg = <0>;
 > +		spi-max-frequency = <3000000>;

Is this 3MHz a limitation of the flash, board layout or SPI controller?

-- 
Bye, Peter Korsgaard
