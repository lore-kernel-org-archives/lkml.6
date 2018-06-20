Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34780C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6E920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6E920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754786AbeFTS2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:28:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52842 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754633AbeFTS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:28:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so1067218wmb.2;
        Wed, 20 Jun 2018 11:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wvpzYC9zpVeHZ0zO7pN3zZKy6foGSmi6UryrzQI98yk=;
        b=CsoNVmB1HVX9KZ2wdu2kEc/3Ko+TejiG1EBdZwD/6S8MKgxrymb0ASSJE45INnxjBL
         NFjc0v5fvKbhSkc2LeD61AmWrIPX6P0wy0ykVDtFe8x/z8EivzmD+ZWSFpxueq1Np3bd
         iqv9vT/UhZmjSZowhxa3fzF3IdQSWfMzPQ3qiOyXH/x5Py2YxEHhrasXwgfC/OtK0a9y
         m0BeNezKBj4cOJ1IebsmsSJ67vOWMRD3lvjZrTCt725sCOVsHJIcNkyKas7uLmlAR7HL
         6SiKhQLC8a5S5ibReU4zzTcIPV2TVjSL39onF+CaNjA2k9sKgXYLSZoaCB7WQctELPUI
         +8aw==
X-Gm-Message-State: APt69E1Mv0G9J+TvIcm4/Xf5ocZDXw0IAWsFBUPumASIqvrBDMFd2hrH
        qYV0lUSbev+YPopxN8Ez4Ps=
X-Google-Smtp-Source: ADUXVKK4Dt+UPNkWGCDdbF5YwnfkcDjll9BjSngQJPszvrBO8mmlykiWzJOgFUA9DMOqQW9O/wP9fQ==
X-Received: by 2002:a50:f310:: with SMTP id p16-v6mr19132204edm.183.1529519326832;
        Wed, 20 Jun 2018 11:28:46 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id d13-v6sm2032869edb.18.2018.06.20.11.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:28:45 -0700 (PDT)
Date:   Wed, 20 Jun 2018 20:28:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: exynos: add OF graph between USB-PHY
 and MUIC
Message-ID: <20180620182844.5nmlj5djbjgwy3wn@kozik-lap>
References: <20180515121239.18192-1-a.hajda@samsung.com>
 <CGME20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe@eucas1p1.samsung.com>
 <20180515121239.18192-3-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180515121239.18192-3-a.hajda@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 02:12:39PM +0200, Andrzej Hajda wrote:
> OF graph describes USB data lanes between USB-PHY and respective MUIC.
> Since graph is present and DWC driver can use it to get extcon, obsolete
> extcon property can be removed.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  .../dts/exynos/exynos5433-tm2-common.dtsi     | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

dtc W=1 now complains with:
===
Warning (graph_child_address):
/soc/hsi2c@14d90000/max77843@66/max77843-muic/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
===

Do you plan to add more ports soon?

Best regards,
Krzysztof

> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index 03453b822093..042e5894a138 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -868,6 +868,18 @@
>  					};
>  				};
>  			};
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					muic_to_usb: endpoint {
> +						remote-endpoint = <&usb_to_muic>;
> +					};
> +				};
> +			};
>  		};
>  
>  		regulators {
> @@ -1287,12 +1299,17 @@
>  
>  &usbdrd_dwc3 {
>  	dr_mode = "otg";
> -	extcon = <&muic>;
>  };
>  
>  &usbdrd30_phy {
>  	vbus-supply = <&safeout1_reg>;
>  	status = "okay";
> +
> +	port {
> +		usb_to_muic: endpoint {
> +			remote-endpoint = <&muic_to_usb>;
> +		};
> +	};
>  };
>  
>  &xxti {
> -- 
> 2.17.0
> 
