Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC04B219D6
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9YfPaYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391422AbeLVR3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:29:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34730 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733256AbeLVR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:29:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so7236445ede.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HcTJq9S4pekiX261QyleJ3Opovebfy8X7OPB+LNbWNI=;
        b=E9YfPaYj/eRUXvtG3GqS9T9fOBlsbHBRkcYk1Wum819hTSeN9q4yEldPFvezWJl2WH
         a4Ijh0BsA2wteu8Y7TZYemAKhjYJy4R/oV1daafw/krlEis6kD02BmxwVPD0MkJcNvIE
         GVhRF1yJkDNI9cpjSpH3K7fNVY8fMmy4S+hBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HcTJq9S4pekiX261QyleJ3Opovebfy8X7OPB+LNbWNI=;
        b=BrbGHDorqWBhuwiLqpvR6eQl6f3w0lLbpwgZjs7BS99pPUQG7zUKlZPBac4VRBOUbL
         lScg/0AbOVnWizvoMeAN33YibID4lQ5Lc6rNjJuA9PR8kuK80wQo+2gPYtK4vnaXpovF
         pwT+pz9y2rfcQo5clacAsJskfSQOl7uwa5IStVqX3cYgBFu3zSoZNa4Xs6zHK5/Mg1Gh
         73nx2AZGs+yic5MzEhtMB9UQ9K5yzMNEV1s40gsSHnoviCPZv4isz7wbYXv0AWpav5NB
         MOfj7CadTM47nHP3TN0jweW7twS1ZNmsDxjP4e3k8O8JPSYtg6XCAi0ErBjAzfR/7UQi
         VH7A==
X-Gm-Message-State: AA+aEWZevcJOQGg89QCDpIxF4sTLiwug47Dg6nCPgPNv6QEVO0BkyEN5
        9YaOiD+XZaU1LPT77MpE6+ZoCQ==
X-Google-Smtp-Source: AFSGD/XadCoQIT1rvY78sKakkC003b315+MCWIqfPgWfQwpxW3aHv4hVw7+5b+++N7duuqwSzSjJBw==
X-Received: by 2002:a17:906:1001:: with SMTP id 1-v6mr4228223ejm.91.1545475611211;
        Sat, 22 Dec 2018 02:46:51 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([95.179.158.15])
        by smtp.gmail.com with ESMTPSA id k24-v6sm3883038eja.60.2018.12.22.02.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 02:46:50 -0800 (PST)
Date:   Sat, 22 Dec 2018 18:46:42 +0800
From:   leo.yan@linaro.org
To:     Wanglai Shi <shiwanglai@hisilicon.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <xuwei5@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH] dts: arm64: add CoreSight trace support for hi3660
Message-ID: <20181222104642.GB9950@leoy-ThinkPad-X240s>
References: <1544522749-54071-1-git-send-email-shiwanglai@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544522749-54071-1-git-send-email-shiwanglai@hisilicon.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wanglai,

[ + CoreSight mailing list ]

On Tue, Dec 11, 2018 at 06:05:49PM +0800, Wanglai Shi wrote:
> This patch adds devicetree entries for the CoreSight trace
>  components on hi3660.
> 
> Signed-off-by: Wanglai Shi <shiwanglai@hisilicon.com>
> ---
>  .../arm64/boot/dts/hisilicon/hi3660-coresight.dtsi | 428 +++++++++++++++++++++
>  1 file changed, 428 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi

This patch doesn't work on Hikey960 due CoreSight related dt binding
has not been really included by dts file.

> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> new file mode 100644
> index 0000000..95c79e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi
> @@ -0,0 +1,428 @@
> +/*
> + * dtsi for Hisilicon Hi3660 Coresight
> + *
> + * Copyright (C) 2016-2017 Hisilicon Ltd.

s/2017/2018

> + *
> + * Author: Wanglai Shi <shiwanglai@hisilicon.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + */
> +/ {
> +	amba {

s/amba/soc

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "arm,amba-bus";
> +		ranges;

If under 'soc' node, because 'soc' has defined its address/size cells
length, thus you don't need to define these properties repeatly.

> +
> +		/* A53 cluster internal coresight */
> +		etm@0,ecc40000 {

s/etm@0,ecc40000/etm@ecc40000

> +			compatible = "arm,coresight-etm4x","arm,primecell";

Add extra space between two compatible strings:
                        compatible = "arm,coresight-etm4x", "arm,primecell";

Please apply this rule for all below compatible string bindings.

> +			reg = <0 0xecc40000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu0>;
> +			port {
> +				etm0_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port0>;
> +				};
> +			};

Since Suzuki introduced CoreSight DT bindings for "out-ports" and
"in-ports", so it's suggested to use more explict way to bind hardware
port with specifying direction:

			out-ports {
			        port {
					etm0_out: endpoint {
			                        remote-endpoint =
							<&funnel0_in_port0>;
			                };
			        };
			};

> +		};
> +
> +		etm@1,ecd40000 {

Remove '1,'

> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xecd40000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu1>;
> +			port {

Suggest for adding 'out-ports'.

> +				etm1_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port1>;
> +				};
> +			};
> +		};
> +
> +		etm@2,ece40000 {

Remove '2,'

> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xece40000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu2>;
> +			port {

Suggest for adding 'out-ports'.

> +				etm2_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port2>;
> +				};
> +			};
> +		};
> +
> +		etm@3,ecf40000 {

Remove '3,'

> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xecf40000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu3>;
> +			port {

Suggest for adding 'out-ports'.

> +				etm3_out_port: endpoint {
> +					remote-endpoint = <&funnel0_in_port3>;
> +				};
> +			};
> +		};
> +
> +		funnel0:funnel@0,ec801000 {

funnel0: funnel@ec801000

> +			compatible = "arm,coresight-funnel","arm,primecell";
> +			reg = <0 0xec801000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* funnel output port */
> +				port@0 {
> +					reg = <0>;
> +					funnel0_out_port: endpoint {
> +						remote-endpoint =
> +							<&etf0_in_port>;
> +					};
> +				};

Suggest for below format:

			out-ports {
				port {
					reg = <0>;
					clusster0_funnel_out_port: endpoint {
						remote-endpoint =
							<&etf0_in_port>;
					};
				};
			};

> +
> +				/* funnel input ports */
> +				port@1 {

Suggest for adding 'in-ports'.

BTW, please keep the consistence between node name and registers;
e.g. port@0 should be consistent with 'reg = <0>;' and port@1 for
'reg = <1>;' ...

So this should be port@0

> +					reg = <0>;
> +					funnel0_in_port0: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm0_out_port>;
> +					};
> +				};
> +
> +				port@2 {

s/port@2/port@1

> +					reg = <1>;
> +					funnel0_in_port1: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm1_out_port>;
> +					};
> +				};
> +
> +				port@3 {

s/port@3/port@2

> +					reg = <2>;
> +					funnel0_in_port2: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm2_out_port>;
> +					};
> +				};
> +
> +				port@4 {

s/port@4/port@3

> +					reg = <3>;
> +					funnel0_in_port3: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm3_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf0:etf@0,ec802000 {

etf0: etf@ec802000

> +			compatible = "arm,coresight-tmc","arm,primecell";
> +			reg = <0 0xec802000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {

Same with upper suggestions: add 'in-ports' and 'out-ports'.

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				/* input port */
> +				port@0 {
> +					reg = <0>;
> +					etf0_in_port: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&funnel0_out_port>;
> +					};
> +				};
> +
> +				/* output port */
> +				port@1 {

s/port@1/port@0

> +					reg = <0>;
> +					etf0_out_port: endpoint {
> +						remote-endpoint =
> +							<&funnel2_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* A73 cluster internal coresight */
> +		etm@4,ed440000 {

Same suggestion with CA53 cluster bindings for etm.

> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xed440000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu4>;
> +			port {
> +				etm4_out_port: endpoint {
> +				remote-endpoint = <&funnel1_in_port0>;
> +				};
> +			};
> +		};
> +
> +		etm@5,ed540000 {
> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xed540000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu5>;
> +			port {
> +				etm5_out_port: endpoint {
> +				remote-endpoint = <&funnel1_in_port1>;
> +				};
> +			};
> +		};
> +
> +		etm@6,ed640000 {
> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xed640000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu6>;
> +			port {
> +				etm6_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port2>;
> +				};
> +			};
> +		};
> +
> +		etm@7,ed740000 {
> +			compatible = "arm,coresight-etm4x","arm,primecell";
> +			reg = <0 0xed740000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu7>;
> +			port {
> +				etm7_out_port: endpoint {
> +					remote-endpoint = <&funnel1_in_port3>;
> +				};
> +			};
> +		};
> +
> +		funnel1:funnel@1,ed001000 {

Same suggestion for funnel0.

> +			compatible = "arm,coresight-funnel","arm,primecell";
> +			reg = <0 0xed001000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* funnel output port */
> +				port@0 {
> +					reg = <0>;
> +					funnel1_out_port: endpoint {
> +						remote-endpoint =
> +							<&etf1_in_port>;
> +					};
> +				};
> +
> +				/* funnel input ports */
> +				port@1 {
> +					reg = <0>;
> +					funnel1_in_port0: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm4_out_port>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <1>;
> +					funnel1_in_port1: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm5_out_port>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <2>;
> +					funnel1_in_port2: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm6_out_port>;
> +					};
> +				};
> +
> +				port@4 {
> +					reg = <3>;
> +					funnel1_in_port3: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etm7_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf1:etf@1,ed002000 {

Same suggestion for etf0.

> +			compatible = "arm,coresight-tmc","arm,primecell";
> +			reg = <0 0xed002000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				/* input port */
> +				port@0 {
> +					reg = <0>;
> +					etf1_in_port: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&funnel1_out_port>;
> +					};
> +				};
> +
> +				/* output port */
> +				port@1 {
> +					reg = <0>;
> +					etf1_out_port: endpoint {
> +						remote-endpoint =
> +							<&funnel2_in_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		/* Top coresight config */
> +		funnel@2,ec031000 {


> +			compatible = "arm,coresight-funnel","arm,primecell";
> +			reg = <0 0xec031000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* funnel output port */
> +				port@0 {
> +					reg = <0>;
> +					funnel2_out_port: endpoint {
> +						remote-endpoint =
> +							<&etf2_in_port>;
> +					};
> +				};
> +
> +				/* funnel input ports */
> +				port@1 {
> +					reg = <0>;
> +					funnel2_in_port0: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etf0_out_port>;
> +					};
> +				};

I think this funnel should have two input ports: one is for etf0 and
another is for connection etf1, but here it misses for etf1.

Do I miss anything for this?

> +			};
> +		};
> +
> +		etf@2,ec036000 {

Same suggestion for etf0/1.

> +			compatible = "arm,coresight-tmc","arm,primecell";
> +			reg = <0 0xec036000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				/* input port */
> +				port@0 {
> +					reg = <0>;
> +					etf2_in_port: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&funnel2_out_port>;
> +					};
> +				};
> +
> +				/* output port */
> +				port@1 {
> +					reg = <0>;
> +					etf2_out_port: endpoint {
> +						remote-endpoint =
> +							<&replicator0_in_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		replicator {
> +			compatible = "arm,coresight-replicator";

Replicator doesn't have clock?

> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* etr out port  */
> +				port@0 {
> +					reg = <0>;
> +					replicator0_out_port0: endpoint {
> +						remote-endpoint =
> +							<&etr_in_port>;
> +					};
> +				};
> +				/* TPIU out port  */
> +				port@1 {
> +					reg = <1>;
> +					replicator0_out_port1: endpoint {
> +						remote-endpoint =
> +							<&tpiu_in_port>;
> +					};
> +				};
> +				/* input port  */
> +				port@2 {
> +					reg = <0>;
> +					replicator0_in_port: endpoint {
> +						slave-mode;
> +						remote-endpoint =
> +							<&etf2_out_port>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etr@0,ec033000 {
> +			compatible = "arm,coresight-tmc","arm,primecell";
> +			reg = <0 0xec033000 0 0x1000>;
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;

Usually etr doesn't need to set address-cells and size-cell anymore.

> +
> +				/* etr input port  */
> +				port@0 {
> +					reg = <0>;


> +					etr_in_port: endpoint {
> +						slave-mode;

From Documentation/devicetree/bindings/arm/coresight.txt, I cannot see
there have 'slave-mode' property.

> +						remote-endpoint =
> +						<&replicator0_out_port0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tpiu@ec032000 {
> +			compatible = "arm,coresight-tpiu", "arm,primecell";
> +			reg = <0 0xec032000 0 0x1000>;
> +
> +			clocks = <&pclk>;
> +			clock-names = "apb_pclk";
> +			port {
> +				tpiu_in_port: endpoint {
> +					slave-mode;
> +					remote-endpoint =
> +						<&replicator0_out_port1>;
> +				};
> +			};
> +		};
> +	};

I don't see CPU debug module DT binding, could you add them as well?
You could use the single one patch to contain CPU debug module or use
one dedicated patch, both will be okay for me.

Thanks,
Leo Yan

> +};
> -- 
> 2.7.4
> 
