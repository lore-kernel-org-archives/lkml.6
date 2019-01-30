Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8B3C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE47F20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548823364;
	bh=dFKhf1Iy2qfLvkhk/VEIKzKEStqnXvTd8n6sTgNlKkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kSVnbLjPa1mnY6tcy80neETcrVzX5HPfdErj/Zyw1yjkKe1HkBbC4ixxLPG4Ghy7/
	 Ylc/5/eKPjOiODY32ooIhAQa1LhJVj5XqBqwX8xrcWKqZsRSAp+I5r1Rorj+X3fdMI
	 6Vn9bYb0jD01STxG6ZYQffItbyQQhBqnqabp3yhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfA3Emn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfA3Emm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:42:42 -0500
Received: from localhost (unknown [122.178.236.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F41F620821;
        Wed, 30 Jan 2019 04:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548823361;
        bh=dFKhf1Iy2qfLvkhk/VEIKzKEStqnXvTd8n6sTgNlKkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMGz2pDI3OE9eqnnJ51C2XANu2SZBY9S8JoUrJL8pVfoU7F12cBD7+aTXvE1tFqpn
         FrfF7AD4RPGID27ybimMdE3nmiD0pFWatUr27U1QacdkBBj5Fb3QUNTaVlWVbn63TO
         M5ivieCTON6TZQnpB5UxVgj8/aAJ6uqPydVPvkNU=
Date:   Wed, 30 Jan 2019 10:11:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     sboyd@kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        arnd@arndb.de, horms+renesas@verge.net.au, heiko@sntech.de,
        sibis@codeaurora.org, enric.balletbo@collabora.com,
        jagan@amarulasolutions.com, olof@lixom.net,
        niklas.cassel@linaro.org, georgi.djakov@linaro.org,
        amit.kucheria@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        khasim.mohammed@linaro.org
Subject: Re: [PATCH v2 10/14] arm64: dts: qcom: qcs404: Add OPP table
Message-ID: <20190130044112.GE4635@vkoul-mobl>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548700381-22376-11-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 19:32, Jorge Ramirez-Ortiz wrote:
> Add a CPU OPP table to qcs404
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 9b5c165..4594fea7 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -62,6 +62,21 @@
>  		};
>  	};
>  
> +	cpu_opp_table: cpu_opp_table {

This should be:
        cpu_opp_table: cpu-opp-table

IIRC node names are not supposed to have _ and tags not supposed to have
-, please compile with W=12 to trigger these warnings :)

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-1094400000 {
> +			opp-hz = /bits/ 64 <1094400000>;
> +		};
> +		opp-1248000000 {
> +			opp-hz = /bits/ 64 <1248000000>;
> +		};
> +		opp-1401600000 {
> +			opp-hz = /bits/ 64 <1401600000>;
> +		};
> +	};
> +
>  	firmware {
>  		scm: scm {
>  			compatible = "qcom,scm-qcs404", "qcom,scm";
> -- 
> 2.7.4

-- 
~Vinod
