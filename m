Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE6C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B1121470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B1121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJMBIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:08:40 -0400
Received: from foss.arm.com ([217.140.101.70]:55456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeJMBIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:08:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1DDCF;
        Fri, 12 Oct 2018 10:35:05 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE3CA3F5D3;
        Fri, 12 Oct 2018 10:35:02 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:35:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 8/8] arm64: dtsi: sdm845: Add cpu power domain
 support
Message-ID: <20181012173500.GB23170@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-9-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539206455-29342-9-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 02:50:55AM +0530, Raju P.L.S.S.S.N wrote:
> Add cpu power domain support
> 
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index d3662a8..aadaa20 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -96,6 +96,7 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			power-domains = <&cpu_pd>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -111,6 +112,7 @@
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_100>;
> +			power-domains = <&cpu_pd>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -123,6 +125,7 @@
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_200>;
> +			power-domains = <&cpu_pd>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -135,6 +138,7 @@
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_300>;
> +			power-domains = <&cpu_pd>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -147,6 +151,7 @@
>  			reg = <0x0 0x400>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_400>;
> +			power-domains = <&cpu_pd>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -159,6 +164,7 @@
>  			reg = <0x0 0x500>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_500>;
> +			power-domains = <&cpu_pd>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -171,6 +177,7 @@
>  			reg = <0x0 0x600>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_600>;
> +			power-domains = <&cpu_pd>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -183,6 +190,7 @@
>  			reg = <0x0 0x700>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_700>;
> +			power-domains = <&cpu_pd>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -1170,6 +1178,11 @@
>  					  <WAKE_TCS    3>,
>  					  <CONTROL_TCS 1>;
>  
> +			cpu_pd: power-domain-controller {
> +				compatible = "qcom,cpu-pm-domain";
> +				#power-domain-cells = <0>;
> +			};
> +

After all the discussions, I see this power domain actually influence
not just CPUs but other devices. So this should be top most power domain
in the system with lots of devices or their power domains pointing to it.
Why is this just pointing to cpus ?

--
Regards,
Sudeep
