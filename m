Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9652DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37926215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37926215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeI0VuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:50:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46758 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0VuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:50:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id q4-v6so2925141otf.13;
        Thu, 27 Sep 2018 08:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sEzEYe+WIgrDmM1Ui/n8s718ktGbPY3f9Sj3iQDNlGQ=;
        b=aJxFh0iPxrVVWwy/dW4vCi2X4lMq46pZPb4yeoTNTPs0+d6unrjMdUh7et3PCnPdhp
         qQt6MR0Qi5UL++5xkIJ2CJAOueOfvnGq6k7EVjtXL47CyJmZkwlttoXyOObnd9bY3gR1
         LnXYViS/CGfTc27TqAh1NpOZgDUHEHYxPqohZU+DUhSlBZrT2vNphwIIK/SBWVdSg6LO
         7AWVuw+vquqBZ429w6u38hzzvagXiNSD0koN9tcnrn6vwmIpf72B5YOZoKikcjxhlVha
         C8a/aTgrxEPKaQPK6G2umyxNNpIIZLghKJUxT8SU/ZRu3N5we0UHXSsjPpioFgmnvld7
         Tp7g==
X-Gm-Message-State: ABuFfoiHbwCTwmEcUV3d1JMqIPtjLgGq4IGBrJ2DQb01ugm8cJ0/ehnx
        r5pq+7Rn7vPNNDPJtJMnhL78BIxGcg==
X-Google-Smtp-Source: ACcGV630dsIefDF1Gz8Ufx8G8nAUB5OjP1TJB0CzGauEfbUVHuOqjkNgYLZJl58Zs0siGSsmO7uqJA==
X-Received: by 2002:a9d:1caa:: with SMTP id l42-v6mr7552658ota.324.1538062288136;
        Thu, 27 Sep 2018 08:31:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r18-v6sm828983otc.24.2018.09.27.08.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:31:27 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:31:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
Subject: Re: [PATCH v8 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20180927153126.GA17218@bogus>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537698793-15285-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 04:03:12PM +0530, Taniya Das wrote:
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 169 +++++++++++++++++++++
>  1 file changed, 169 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..c06941c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,169 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +	Usage:		required
> +	Value type:	<string>
> +	Definition:	must be "qcom,cpufreq-hw".
> +
> +- clocks
> +	Usage:		required
> +	Value type:	<phandle> From common clock binding.
> +	Definition:	clock handle for XO clock and GPLL0 clock.
> +
> +- clock-names
> +	Usage:		required
> +	Value type:	<string> From common clock binding.
> +	Definition:	must be "xo", "cpu_clk".
> +
> +- reg
> +	Usage:		required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Addresses and sizes for the memory of the HW bases in
> +			each frequency domain.
> +- reg-names
> +	Usage:		Optional
> +	Value type:	<string>
> +	Definition:	Frequency domain name i.e.
> +			"freq-domain0", "freq-domain1".
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
> +
> +
> +Example:
> +
> +Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
> +DCVS state together.
> +
> +/ {
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +				L3_0: l3-cache {
> +				      compatible = "cache";
> +				};
> +			};
> +		};
> +
> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_100>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_100: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_200>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_200: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_300>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			L2_300: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x400>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_400>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_400: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x500>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_500>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_500: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x600>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_600>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_600: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo385";
> +			reg = <0x0 0x700>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_700>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
> +			L2_700: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +	};
> +
> + soc {
> +	cpufreq_hw: qcom,cpufreq-hw {

Should have a unit-address and node names should be generic. We don't 
really have one for this, but let's go with 'cpufreq', so:

cpufreq@17d43000

> +		compatible = "qcom,cpufreq-hw";
> +		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +		reg-names = "freq-domain0", "freq-domain1";
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +		clock-names = "xo", "cpu_clk";
> +
> +		#freq-domains-cells = <1>

Not documented, but I don't think you need this if it is always 1 and 
because this is not a common binding.

Rob
