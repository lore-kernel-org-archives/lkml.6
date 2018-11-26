Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0801C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8438F20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8438F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeK0FxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:53:12 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38058 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeK0FxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:53:12 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so13356289otl.5;
        Mon, 26 Nov 2018 10:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OHAqKU/xxg3FeYiiVbSd2EbcaryKQDQE75l/EJIdqYg=;
        b=EOXZbr7RJLktNL+B8nZQwe7vOanfORcnl6v8EXg6P4YVdtDcw2gqdZ/QWKYwB+SVB0
         AggZbU/KZBW4E8dX66FyBlSIwpg086/iruLX18sLb/uKLO9IkzOSw6QyEB9yMLSiVoEg
         LgIT3o6QQ5iu3D1EzU4JIAk6AMPh8teCw3gYcKYD94mhybWi8anwMzfqg/YnDpn1b/fY
         Qjcw72x82KGNpSJIrhq2Yy/CQHMTcrpJ8nbemZ6QMRUj/tTNHB3HylC6+lETtw+o316J
         Eyp7QT7FCZ+XoKQXeSjvGjYM9lzLnht/yKikG1nvXZNVHcIvhO2pGhgyUWL6o5z9eNDI
         l6EQ==
X-Gm-Message-State: AA+aEWbjIwbre90TfN9UV5QwyqDZ4QWAU3uiBuF5FQL0jMoWNZ16Uv5H
        /liQc0YiQk260G9jeHcF4Q==
X-Google-Smtp-Source: AFSGD/VZnXwO22xlOpjnoc8Z+GBEcl2UovppjAFTOUsESRKAL3QwUou6CIXFqJkJXprp5ewuqnrfxA==
X-Received: by 2002:a9d:6297:: with SMTP id x23mr13894465otk.63.1543258690407;
        Mon, 26 Nov 2018 10:58:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c22sm1442861otr.31.2018.11.26.10.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 10:58:09 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:58:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Taniya Das <tdas@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        evgreen@google.com
Subject: Re: [PATCH v10 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
Message-ID: <20181126185808.GA32621@bogus>
References: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
 <1542796967-5949-2-git-send-email-tdas@codeaurora.org>
 <20181121180236.GS22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121180236.GS22824@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:02:36AM -0800, Matthias Kaehlcke wrote:
> On Wed, Nov 21, 2018 at 04:12:46PM +0530, Taniya Das wrote:
> > Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> > SoCs. This is required for managing the cpu frequency transitions which are
> > controlled by the hardware engine.
> > 
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> >  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++++++++++
> >  1 file changed, 172 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > new file mode 100644
> > index 0000000..90e396b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> > @@ -0,0 +1,172 @@
> > +Qualcomm Technologies, Inc. CPUFREQ Bindings
> > +
> > +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> > +SoCs to manage frequency in hardware. It is capable of controlling frequency
> > +for multiple clusters.
> > +
> > +Properties:
> > +- compatible
> > +	Usage:		required
> > +	Value type:	<string>
> > +	Definition:	must be "qcom,cpufreq-hw".
> > +
> > +- clocks
> > +	Usage:		required
> > +	Value type:	<phandle> From common clock binding.
> > +	Definition:	clock handle for XO clock and GPLL0 clock.
> > +
> > +- clock-names
> > +	Usage:		required
> > +	Value type:	<string> From common clock binding.
> > +	Definition:	must be "xo", "cpu_clk".
> > +
> > +- reg
> > +	Usage:		required
> > +	Value type:	<prop-encoded-array>
> > +	Definition:	Addresses and sizes for the memory of the HW bases in
> > +			each frequency domain.
> > +- reg-names
> > +	Usage:		Optional
> > +	Value type:	<string>
> > +	Definition:	Frequency domain name i.e.
> > +			"freq-domain0", "freq-domain1".
> > +
> > +- freq-domain-cells:
> > +	Usage:		required.
> > +	Definition:	Number of cells in a freqency domain specifier.
> > +
> > +* Property qcom,freq-domain
> > +Devices supporting freq-domain must set their "qcom,freq-domain" property with
> > +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
> > +
> > +
> > +Example:
> > +
> > +Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
> > +DCVS state together.
> > +
> > +/ {
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		CPU0: cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo385";
> > +			reg = <0x0 0x0>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&L2_0>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;
> > +			L2_0: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +				L3_0: l3-cache {
> > +				      compatible = "cache";
> > +				};
> > +			};
> > +		};
> > +
> > +		CPU1: cpu@100 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo385";
> > +			reg = <0x0 0x100>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&L2_100>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;
> > +			L2_100: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +			};
> > +		};
> > +
> > +		CPU2: cpu@200 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo385";
> > +			reg = <0x0 0x200>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&L2_200>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;
> > +			L2_200: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +			};
> > +		};
> > +
> > +		CPU3: cpu@300 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo385";
> > +			reg = <0x0 0x300>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&L2_300>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;
> > +			L2_300: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +			};
> > +		};
> > +
> > +		CPU4: cpu@400 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo385";
> > +			reg = <0x0 0x400>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&L2_400>;
> > +			qcom,freq-domain = <&cpufreq_hw 1>;
> > +			L2_400: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +			};
> > +		};
> > +
> > +		CPU5: cpu@500 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo385";
> > +			reg = <0x0 0x500>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&L2_500>;
> > +			qcom,freq-domain = <&cpufreq_hw 1>;
> > +			L2_500: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +			};
> > +		};
> > +
> > +		CPU6: cpu@600 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo385";
> > +			reg = <0x0 0x600>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&L2_600>;
> > +			qcom,freq-domain = <&cpufreq_hw 1>;
> > +			L2_600: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +			};
> > +		};
> > +
> > +		CPU7: cpu@700 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo385";
> > +			reg = <0x0 0x700>;
> > +			enable-method = "psci";
> > +			next-level-cache = <&L2_700>;
> > +			qcom,freq-domain = <&cpufreq_hw 1>;
> > +			L2_700: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +			};
> > +		};
> > +	};
> > +
> > + soc {
> > +	cpufreq_hw: cpufreq@17d43000 {
> > +		compatible = "qcom,cpufreq-hw";
> > +		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> > +		reg-names = "freq-domain0", "freq-domain1";
> > +
> > +		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> > +		clock-names = "xo", "gcc_cpuss_gpll0_clk_src";
> 
> I don't have/find the document with the clock configuration of this
> IP block, but the 'clock-names' sound more like aliases for the actual
> clocks specified in the 'clocks' property (especially
> 'gcc_cpuss_gpll0_clk_src') than input signals from the IP POV, which
> I'd expect to have more generic names.

Also, this doesn't match the documented value above.

Rob

