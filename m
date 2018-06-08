Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KR+jIAT6GlsqdAAAmS7hNA
	; Fri, 08 Jun 2018 21:49:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 60437607E4; Fri,  8 Jun 2018 21:49:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBn2BgdT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 85E07601D2;
	Fri,  8 Jun 2018 21:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85E07601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeFHVtw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:49:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46749 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752974AbeFHVtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:49:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so8985870pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Hjozd42Y6BkBsBG0IRgBlBGWgfxuUNnid2BGXcR+KY=;
        b=CBn2BgdTDAOraONKY+DiyNXeXstRoTV3q2MFbPjSaHcOVLdLQrcOBGTyyaj+ZJkzHD
         wJVlFro+FUVRKQgWaSgKQur34HjVtnhNge0OzhNm59jC/KUHOXxrTzoRXfSm/95+JjZL
         mKI6GfBQAQlzRixbLzoP2Y5byKW3+8xG1L1y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Hjozd42Y6BkBsBG0IRgBlBGWgfxuUNnid2BGXcR+KY=;
        b=NC0RTtiBfU3fJYNVJHg7jkcrxClUM7LkmiRmYHRXhvgxAkEii4GPRyuBtHsqCZ09LB
         okLpBw5Ocsd51tpoZVyDBSVdPKdImZQsko+U9IyCOjBuwFAbxiD5oNQ32XBVr3rWe34k
         +LFl7fTxDaM0F0InoZipleLof7JTy/YrX/N3O7PFTUj8qDLDgBy7ePIVUc6OsxT0PcTc
         0wtomfYDKGV/gbDZRMek/Fpl7MX4EOleb+zmprNvOEoYKPNURI5GEQgsrOWI9MSwr6Ez
         bYUDXb222O+JEMnWel1ZyeNQr+dVSTE/aMXiETYdlj+UNCf2rNBhPBfiZYBwp3y2qP7H
         Xs/A==
X-Gm-Message-State: APt69E0ASMJszLSRklPFYkk8NRgYQKh0XWbsFPFkczVmVmoKJYTrW5Qh
        AbFlJTxfHPfi0IqcpL9vp99L1Q==
X-Google-Smtp-Source: ADUXVKKXE1jl7VTG7WPwPBOQ27EhSQWyD4f05WwOnA8FQCNruWjyEJEQys0pDNhFcDnxzPAmR61eYA==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr8249902plt.288.1528494590351;
        Fri, 08 Jun 2018 14:49:50 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q68-v6sm101989460pfb.182.2018.06.08.14.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 14:49:49 -0700 (PDT)
Date: Fri, 8 Jun 2018 15:49:46 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org, Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 10/20] dts: juno: Update coresight bindings for hw port
Message-ID: <20180608214946.GI30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-11-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-11-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:21PM +0100, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for hw ports.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V1:
>   - Add support Juno for r1 & r2.
> ---

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  arch/arm64/boot/dts/arm/juno-base.dtsi    | 82 ++++++++++++++++++++++---------
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 26 +++++++---
>  arch/arm64/boot/dts/arm/juno.dts          |  5 +-
>  3 files changed, 81 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index eb749c5..33b41ba 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -122,15 +122,18 @@
>  			port@0 {
>  				reg = <0>;
>  				etf0_in_port: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&main_funnel_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			/* output port */
>  			port@1 {
> -				reg = <0>;
> +				reg = <1>;
>  				etf0_out_port: endpoint {
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  		};
> @@ -145,8 +148,9 @@
>  		power-domains = <&scpi_devpd 0>;
>  		port {
>  			tpiu_in_port: endpoint {
> -				slave-mode;
> +				direction = <0>;
>  				remote-endpoint = <&replicator_out_port0>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -168,23 +172,27 @@
>  				reg = <0>;
>  				main_funnel_out_port: endpoint {
>  					remote-endpoint = <&etf0_in_port>;
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  
>  			/* input ports */
>  			port@1 {
> -				reg = <0>;
> +				reg = <1>;
>  				main_funnel_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster0_funnel_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			port@2 {
> -				reg = <1>;
> +				reg = <2>;
>  				main_funnel_in_port1: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_funnel_out_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  		};
> @@ -200,8 +208,9 @@
>  		power-domains = <&scpi_devpd 0>;
>  		port {
>  			etr_in_port: endpoint {
> -				slave-mode;
> +				direction = <0>;
>  				remote-endpoint = <&replicator_out_port1>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -217,6 +226,8 @@
>  		power-domains = <&scpi_devpd 0>;
>  		port {
>  			stm_out_port: endpoint {
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -240,6 +251,8 @@
>  		port {
>  			cluster0_etm0_out_port: endpoint {
>  				remote-endpoint = <&cluster0_funnel_in_port0>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -259,22 +272,26 @@
>  				reg = <0>;
>  				cluster0_funnel_out_port: endpoint {
>  					remote-endpoint = <&main_funnel_in_port0>;
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  
>  			port@1 {
> -				reg = <0>;
> +				reg = <1>;
>  				cluster0_funnel_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster0_etm0_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			port@2 {
> -				reg = <1>;
> +				reg = <2>;
>  				cluster0_funnel_in_port1: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster0_etm1_out_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  		};
> @@ -299,6 +316,8 @@
>  		port {
>  			cluster0_etm1_out_port: endpoint {
>  				remote-endpoint = <&cluster0_funnel_in_port1>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -322,6 +341,8 @@
>  		port {
>  			cluster1_etm0_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port0>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -341,36 +362,42 @@
>  				reg = <0>;
>  				cluster1_funnel_out_port: endpoint {
>  					remote-endpoint = <&main_funnel_in_port1>;
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  
>  			port@1 {
> -				reg = <0>;
> +				reg = <1>;
>  				cluster1_funnel_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_etm0_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			port@2 {
> -				reg = <1>;
> +				reg = <2>;
>  				cluster1_funnel_in_port1: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_etm1_out_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  			port@3 {
> -				reg = <2>;
> +				reg = <3>;
>  				cluster1_funnel_in_port2: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_etm2_out_port>;
> +					coresight,hwid = <2>;
>  				};
>  			};
>  			port@4 {
> -				reg = <3>;
> +				reg = <4>;
>  				cluster1_funnel_in_port3: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&cluster1_etm3_out_port>;
> +					coresight,hwid = <3>;
>  				};
>  			};
>  		};
> @@ -395,6 +422,8 @@
>  		port {
>  			cluster1_etm1_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port1>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -418,6 +447,8 @@
>  		port {
>  			cluster1_etm2_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port2>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -441,6 +472,8 @@
>  		port {
>  			cluster1_etm3_out_port: endpoint {
>  				remote-endpoint = <&cluster1_funnel_in_port3>;
> +				coresight,hwid = <0>;
> +				direction = <1>;
>  			};
>  		};
>  	};
> @@ -462,6 +495,8 @@
>  				reg = <0>;
>  				replicator_out_port0: endpoint {
>  					remote-endpoint = <&tpiu_in_port>;
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  				};
>  			};
>  
> @@ -469,14 +504,17 @@
>  				reg = <1>;
>  				replicator_out_port1: endpoint {
>  					remote-endpoint = <&etr_in_port>;
> +					coresight,hwid = <1>;
> +					direction = <1>;
>  				};
>  			};
>  
>  			/* replicator input port */
>  			port@2 {
> -				reg = <0>;
> +				reg = <2>;
>  				replicator_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> index 0c43fb3..146a5d9 100644
> --- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> @@ -15,15 +15,18 @@
>  			port@0 {
>  				reg = <0>;
>  				csys1_funnel_out_port: endpoint {
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  					remote-endpoint = <&etf1_in_port>;
>  				};
>  			};
>  
>  			/* input port */
>  			port@1 {
> -				reg = <0>;
> +				reg = <1>;
>  				csys1_funnel_in_port0: endpoint {
> -					slave-mode;
> +					coresight,hwid = <0>;
> +					direction = <0>;
>  				};
>  			};
>  
> @@ -45,15 +48,18 @@
>  			port@0 {
>  				reg = <0>;
>  				etf1_in_port: endpoint {
> -					slave-mode;
> +					direction = <0>;
> +					coresight,hwid = <0>;
>  					remote-endpoint = <&csys1_funnel_out_port>;
>  				};
>  			};
>  
>  			/* output port */
>  			port@1 {
> -				reg = <0>;
> +				reg = <1>;
>  				etf1_out_port: endpoint {
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  					remote-endpoint = <&csys2_funnel_in_port1>;
>  				};
>  			};
> @@ -75,23 +81,27 @@
>  			port@0 {
>  				reg = <0>;
>  				csys2_funnel_out_port: endpoint {
> +					coresight,hwid = <0>;
> +					direction = <1>;
>  					remote-endpoint = <&replicator_in_port0>;
>  				};
>  			};
>  
>  			/* input ports */
>  			port@1 {
> -				reg = <0>;
> +				reg = <1>;
>  				csys2_funnel_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
> +					coresight,hwid = <0>;
>  					remote-endpoint = <&etf0_out_port>;
>  				};
>  			};
>  
>  			port@2 {
> -				reg = <1>;
> +				reg = <2>;
>  				csys2_funnel_in_port1: endpoint {
> -					slave-mode;
> +					direction = <0>;
> +					coresight,hwid = <1>;
>  					remote-endpoint = <&etf1_out_port>;
>  				};
>  			};
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index c9236c4..27b8036 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -260,10 +260,11 @@
>  &main_funnel {
>  	ports {
>  		port@3 {
> -			reg = <2>;
> +			reg = <3>;
>  			main_funnel_in_port2: endpoint {
> -				slave-mode;
> +				direction = <0>;
>  				remote-endpoint = <&stm_out_port>;
> +				coresight,hwid = <2>;
>  			};
>  		};
>  	};
> -- 
> 2.7.4
> 
