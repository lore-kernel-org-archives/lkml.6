Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B566C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2221020851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X++h4URu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X++h4URu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAQGKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:10:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfAQGKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:10:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0DFD6021A; Thu, 17 Jan 2019 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547705436;
        bh=YEGv0O3JHr4kZdrhresN3JQvaZmIg5SeEazm6WBaeAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X++h4URuk/G6pJofRacZ8CxEcBKYDOHGZwy4f0Mei0saIa0HqNtxahkl1F39lr1u/
         jhW9q8qOrGFuqFuZd6MNpXols4jd+6P7Db5siZx9I0s9zTeSIGvgsyoAsjymyFIsDx
         8MEUij/gEms7lDmC22llQ5rAIOWIVUk61NHUltYc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E67B7601D2;
        Thu, 17 Jan 2019 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547705436;
        bh=YEGv0O3JHr4kZdrhresN3JQvaZmIg5SeEazm6WBaeAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X++h4URuk/G6pJofRacZ8CxEcBKYDOHGZwy4f0Mei0saIa0HqNtxahkl1F39lr1u/
         jhW9q8qOrGFuqFuZd6MNpXols4jd+6P7Db5siZx9I0s9zTeSIGvgsyoAsjymyFIsDx
         8MEUij/gEms7lDmC22llQ5rAIOWIVUk61NHUltYc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jan 2019 11:40:35 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Add WCN3990 BT node
In-Reply-To: <20190117044006.12463-1-bjorn.andersson@linaro.org>
References: <20190117044006.12463-1-bjorn.andersson@linaro.org>
Message-ID: <aebd3bbb4bb3faac2570244af610b43d@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anderson,

On 2019-01-17 10:10, Bjorn Andersson wrote:
> The SDM845 MTP has a WCN3990 Bluetooth chip on UART6, enable this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index af8c6a2445a2..f65d5a674103 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -17,6 +17,7 @@
> 
>  	aliases {
>  		serial0 = &uart9;
> +		hsuart0 = &uart6;
>  	};
> 
>  	chosen {
> @@ -357,6 +358,10 @@
>  	clock-frequency = <400000>;
>  };
> 
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
>  &qupv3_id_1 {
>  	status = "okay";
>  };
> @@ -373,6 +378,20 @@
>  	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
>  };
> 
> +&uart6 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
>  &uart9 {
>  	status = "okay";
>  };
> @@ -470,6 +489,31 @@
>  	};
>  };
> 
> +&qup_uart6_default {
> +	pinmux {
> +		pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +		function = "qup6";
> +	};
> +
> +	ctsrx {
> +		pins = "gpio45", "gpio48";
> +		drive-strength = <2>;
> +		bias-no-pull;
> +	};
> +
> +	rts {
> +		pins = "gpio46";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	tx {
> +		pins = "gpio47";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> +
>  &qup_uart9_default {
>  	pinconf-tx {
>  		pins = "gpio4";


[Bala]:
        GPIO 45 is CTS
        GPIO 46 is RTS
        GPIO 47 is Tx
        GPIO 48 is Rx.

        Tx & RTS are inputs to APPS processor, bias should be disable as 
the source i.e. BT chip will pull them up.
        CTS & RX are outputs from APPS processor, where as CTS is GPIO 
which need to toggled, so the default state should be pull down.
              RX is should be pulled up.
        when TX & RX are pulled high it indicates that the lines are 
ideal i.e. no data.

Above is just my assumption, not sure whether they work on MTP.

-- 
Regards
Balakrishna.
