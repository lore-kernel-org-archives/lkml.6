Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D0BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED2720863
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VcT41kpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfBJK4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 05:56:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36457 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfBJK4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 05:56:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so11345681wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 02:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=7oY8y/5KEU9g0VhG2/ILsB0AuA8IxVBBUO9nvWk0KyM=;
        b=VcT41kpltmh5cgM3qum9dSbkysM0qJsdFOwCRuuKdUShepKgJe8A8QFyc7xeBlu2QM
         I/StkV7SJBB9I8d0J26JJhxt2/g9Nv5Se3SUBDE8i5W6ABe9B+5ry/23TMOGCpA5SxiS
         gAAuGinKXCOhGxzVMfPlEoMfA6si3s/+ZynSkfejcsdyXNP6e9dvRXaK64rsWWWrupjl
         FuuHUjaPIEEjwEzq1S5n9MRVX5Q3bpTHxuxT3JFgFckyMJgV4nA0RCQ2Lku/DFdHYqJ3
         4IRPUhUOVedSZCYYgE5IRMAHZOBlLKogD4B5/rKeHOidihoVFo9sFBI9QalAhdh59P61
         quuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=7oY8y/5KEU9g0VhG2/ILsB0AuA8IxVBBUO9nvWk0KyM=;
        b=hipyH8sn/ZSpGO5OHPZtnZ1bQ38eSOJHKXQiEhffk+dx1ynX0APDlTPOx679d2FaXC
         1AYIMTwEG/MzQz++eVqmmcbfoI6cjrMpeQwcaiW22hEfp7vfukbruuhSupY0+yxcvNv1
         ScVkCT6iPILyB6oamj8iv7ysLR6MSFK5PIFbBnqaZ+CYfhP5e6sm2b5I5ABCqgDVqeIX
         ZjMV+D/zcF/ZIdnYQD48r/IeSMIj4Z+7695c2j1O3WlmmznufjW/eII+AfQ9SxLjbB4i
         kUdbXXG6OUr3LxHNWSQ1uSSDZfhDxfZZeR9r2RoGa52GkWAxz/tjmS28/KV15lHf+qPI
         R39w==
X-Gm-Message-State: AHQUAuYc94aUdoSCW1QvnJV1Bx390X76PVi1liD/oEXDtiUSgCb1FPDI
        N+3XYBokb0Z1BOsRMPJerHsH4g==
X-Google-Smtp-Source: AHgI3Ia1Q1G98suQPYDhp2Vh6c9gUzIZxf6fP47l91UticAb0del3vUR4PibMIt43379ARmIXmSYjQ==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr5954495wmf.32.1549796175600;
        Sun, 10 Feb 2019 02:56:15 -0800 (PST)
Received: from Armstrongs-MacBook-Pro.local (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id q21sm11054636wmc.14.2019.02.10.02.56.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Feb 2019 02:56:15 -0800 (PST)
Message-ID: <5C60034E.5030706@baylibre.com>
Date:   Sun, 10 Feb 2019 11:56:14 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Stijn Tintel <stijn@linux-ipv6.be>, khilman@baylibre.com
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-gxbb-odroidc2: enable I2C bus B
References: <20190209155005.18458-1-stijn@linux-ipv6.be>
In-Reply-To: <20190209155005.18458-1-stijn@linux-ipv6.be>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 09/02/2019 16:50, Stijn Tintel a écrit :
> The ODROID C2 has 2 I2C buses, so enable both of them.

Thanks for the change, but this I2C bus is on the 40-pin header,
until we have a way to add support for HATs/CAPEs/<whatever hooks on the header>
upstream, we prefer not enabling any functions on these pins by default.

You can, if you want add support for most functions, but "disabled" with a
proper description of pins used by these functions.

You can also maintain a set of overlay files like it's done for the
libretech-cc boards https://github.com/libre-computer-project/libretech-overlays/tree/for-4.13.y/overlays
and use them with the Armbian mainline based latest image for example.

Neil

> 
> Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 1cc9dc68ef00..ee666471a580 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -180,6 +180,12 @@
>  	pinctrl-names = "default";
>  };
>  
> +&i2c_B {
> +	status = "okay";
> +	pinctrl-0 = <&i2c_b_pins>;
> +	pinctrl-names = "default";
> +};
> +
>  &ir {
>  	status = "okay";
>  	pinctrl-0 = <&remote_input_ao_pins>;
> 
