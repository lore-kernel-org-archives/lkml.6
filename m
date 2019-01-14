Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B623C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D48205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mh0NpHKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfANWBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:01:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43507 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfANWBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:01:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so243238pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0uNm3/KE9zU5eRRsW127BOpJbJx8eoSOd0/7kP4DHoI=;
        b=Mh0NpHKjRA01BqbYdHc1iEvmIZ2EgIAPZMoiZZAitWhUtnN+x+nQvYaa8aeF+e1ReQ
         j1djWWyDFlERHpzis6dRxbiNCVzR5iD+s/zsj6MgmO2uwCSbYGGiGHRLBn5Dim6T5iWv
         mDTyFwWBXCkt4LEvHlPsb02oanGejUmXdd6d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0uNm3/KE9zU5eRRsW127BOpJbJx8eoSOd0/7kP4DHoI=;
        b=WeJmbchpK0q8FpqennKlAQYO0rSOEMRlbi9kfuy7dgBSkizcKf3wxFpEEsxtjUZ7GX
         xR+RjzEqLJLgalmneOkPeKQaqM/sbh3t6DZwWOkYUqBR9pMl6mYX+Iiw0LiqtXluOdlR
         xtaTBf0sOnxb6DxUOZVjyC6reS6FcSkbbLOqrJqObuaelV5fnl4XEhAAygoKrSSYs+mx
         KGu+t6Os+gbTZsKu5cslkS0u0Na/TsoRjw6coKBGcTMccXtAuMSAZZyhm9CWGylA6sAb
         TpG6bET1EDAAPzcHDi+tKxbgHrTb8drluo4j7Vd1PmvwJ25DRqJnDjCN4pOR2HSkBJFT
         kRSQ==
X-Gm-Message-State: AJcUukdyvZ0jV9uFDm1MEBPsEuQyAkt50dbaISH/ROCPPz6rxBqKeLMV
        3/PuwlrCYmI9PpGPj9B8d+Aa7A==
X-Google-Smtp-Source: ALg8bN6Kz4i0FkHCz5rR9MWR7MCLbQSKSNlFK3xx3GhdDNwc5ZDflJ6qzmW7+gzSBbm3NijmSzlRJw==
X-Received: by 2002:a65:6645:: with SMTP id z5mr598242pgv.351.1547503263309;
        Mon, 14 Jan 2019 14:01:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v9sm2082053pfe.49.2019.01.14.14.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 14:01:02 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:01:01 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190114220101.GN261387@google.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <7f94696460848a6bcfe5aee5ffda7fe556240736.1547458732.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f94696460848a6bcfe5aee5ffda7fe556240736.1547458732.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:51:10PM +0530, Amit Kucheria wrote:
> Since all cpus in the big and little clusters, respectively, are in the
> same frequency domain, use all of them for mitigation in the
> cooling-map. We end up with two cooling devices - one each for the big
> and little clusters.
> 
> At the lower trip points we restrict ourselves to throttling only a few
> OPPs. At higher trip temperatures, allow ourselves to be throttled to
> any extent.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 177 ++++++++++++++++++++++++---
>  1 file changed, 161 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index fb7da678b116..7973e88bdf94 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>
> ...
>
> @@ -1719,18 +1728,35 @@
>  			thermal-sensors = <&tsens0 1>;
>  
>  			trips {
> -				cpu_alert0: trip0 {
> +				cpu0_alert0: trip-point@0 {

Thanks for adapting the trip point names and labels in anticipation of
further additions!

Seems you aren't overly convinced about the 'target/threshold'
terminology used by some other arm64 platforms ;-)

>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};

I realized that we still have the potential problem of a name change
in the trip point node name if a 'threshold' node for IPA is added,
since this node will have a lower temperature than 95°. If this is
something to be concerned about it might be worth to add that extra
trip point already to avoid headaches or funky trip point enumeration,
even if we know that the value might not be the final one.

(I'm aware that we are also changing the node names and labels right
now, it seems less problematic at this point since the SDM845 thermal
zones are a fairly recent addition)

> -				cpu_crit0: trip1 {
> +				cpu0_crit: cpu_crit@0 {

nit: does the @0 add any value here? IIUC there can be only one
critical trip point, hence there will never be a cpu_crit@1 or
higher.

>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> +							 <&CPU1 THERMAL_NO_LIMIT 4>,
> +							 <&CPU2 THERMAL_NO_LIMIT 4>,
> +							 <&CPU3 THERMAL_NO_LIMIT 4>;
> +				};

Out of curiosity: how did you determing the max cooling state of 4?

Cheers

Matthias
