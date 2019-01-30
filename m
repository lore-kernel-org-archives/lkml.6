Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FF3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA2E2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4MUaZgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbfA3Sh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:37:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36745 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733116AbfA3Sh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:37:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so218002plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5t2Lu8+xnHIQWc7Xjvdy/YrGVPGoQ6pY0Q+Amwq12Ug=;
        b=O4MUaZgNUHC4ej5X1kRTRRbXWq5jILqI7V4hE+YxVNkPx4+nnXNmHMswwX8awuTssk
         LdWFCM5PIViplCsWC3jNxPs6POfbA1WQTtcol5ZM+i34MQipHWLNeSRuI9ENd1GCo5yC
         FNCE49sPtnOI+nY3WTJ3sTk5G9yI8WV8qmRUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5t2Lu8+xnHIQWc7Xjvdy/YrGVPGoQ6pY0Q+Amwq12Ug=;
        b=apfFeH5dLSVA2DdbX8h8Yw1kABWXxP5BAoreVBf65uQWZ7b+JWxc9EhpZZVtiSaNrt
         n9uu20sZsFpQugAl7zTtU3Zl+H9KqMKOWSW7WIfqVVuiTgXVW9P4DH0b544UVa+ntNeV
         B8IJOHLRibBbehuw2TqrhL3daSkbFzwSv5IQPuZONgrLtZNL0Gey/VxPJLCF+9yl6DGx
         87u+VJ0eWfP4a3+QBJIuP7EZE1KGKznL4P8I91aJjKHff54K7p2pGFe+pLEidHRHGymv
         bLZbwmvnvPdov8OWyw/mpAN0HiMrJ9TjlMK41onTnj6RLafdDF3wVm7G3vJzX6B2fQa2
         prTQ==
X-Gm-Message-State: AJcUukciuqe6sVJg12nKmKxxHxBKX7FaszxSvsPEQxb5zUXGFAi8SK68
        PSf5SWb/N/VFT9+3+O0x7YRUFg==
X-Google-Smtp-Source: ALg8bN6owR/hag/H4p9bVUkAwARpx8ERnQk+RFZjrlSEk7amY/pjt6L2qoSA/dRmP32XvHN8ja+FPA==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr31381416plq.77.1548873447206;
        Wed, 30 Jan 2019 10:37:27 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s79sm3177203pgs.50.2019.01.30.10.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 10:37:26 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:37:23 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv5 1/7] arm64: dts: qcom: sdm845: Add Coresight support
Message-ID: <20190130183723.GA19234@xps15>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <60ebf1617f0285c89e921bf3839cba6906d493c9.1548419933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ebf1617f0285c89e921bf3839cba6906d493c9.1548419933.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 12:43:58AM +0530, Sai Prakash Ranjan wrote:
> Add coresight components found on Qualcomm SDM845 SoC.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> ---
> Depends on AOSS QMP side channel patches and AMBA bus pclk change
> by Bjorn Andersson [1][2].
> Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
> and size cells for soc") [3].
> 
> [1] https://lore.kernel.org/lkml/20190106080915.4493-1-bjorn.andersson@linaro.org/
> [2] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
> [3] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/

This patch still doesn't compile for me.  In the above [1] is a cover letter and
[2] is a patch that is part of [1] - what do you want me to do?  Add all the
patches in [1]?  And how do those related to the dependencies you've listed in
the cover letter?

I can't continue reviewing your work until you provide me with a tree based on
coresight-next [3] with all the depencendies to get this set applied and
compiled.

Mathieu

[3]. https://git.linaro.org/kernel/coresight.git/log/?h=next

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 434 +++++++++++++++++++++++++++
>  1 file changed, 434 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3bcb0a..e49f71d00854 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1348,6 +1348,440 @@
>  			};
>  		};
>  
> +		stm@6002000 {
> +			compatible = "arm,coresight-stm", "arm,primecell";
> +			reg = <0 0x06002000 0 0x1000>,
> +			      <0 0x16280000 0 0x180000>;
> +			reg-names = "stm-base", "stm-stimulus-base";
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					stm_out: endpoint {
> +						remote-endpoint =
> +						  <&funnel0_in7>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6041000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x06041000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					funnel0_out: endpoint {
> +						remote-endpoint =
> +						  <&merge_funnel_in0>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@7 {
> +					reg = <7>;
> +					funnel0_in7: endpoint {
> +						remote-endpoint = <&stm_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6043000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x06043000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					funnel2_out: endpoint {
> +						remote-endpoint =
> +						  <&merge_funnel_in2>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@5 {
> +					reg = <5>;
> +					funnel2_in5: endpoint {
> +						remote-endpoint =
> +						  <&apss_merge_funnel_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6045000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x06045000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					merge_funnel_out: endpoint {
> +						remote-endpoint = <&etf_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					merge_funnel_in0: endpoint {
> +						remote-endpoint =
> +						  <&funnel0_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					merge_funnel_in2: endpoint {
> +						remote-endpoint =
> +						  <&funnel2_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		replicator@6046000 {
> +			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> +			reg = <0 0x06046000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					replicator_out: endpoint {
> +						remote-endpoint = <&etr_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port {
> +					replicator_in: endpoint {
> +						remote-endpoint = <&etf_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etf@6047000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x06047000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etf_out: endpoint {
> +						remote-endpoint =
> +						  <&replicator_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@1 {
> +					reg = <1>;
> +					etf_in: endpoint {
> +						remote-endpoint =
> +						  <&merge_funnel_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etr@6048000 {
> +			compatible = "arm,coresight-tmc", "arm,primecell";
> +			reg = <0 0x06048000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +			arm,scatter-gather;
> +
> +			in-ports {
> +				port {
> +					etr_in: endpoint {
> +						remote-endpoint =
> +						  <&replicator_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7040000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07040000 0 0x1000>;
> +
> +			cpu = <&CPU0>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm0_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7140000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07140000 0 0x1000>;
> +
> +			cpu = <&CPU1>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm1_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7240000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07240000 0 0x1000>;
> +
> +			cpu = <&CPU2>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm2_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in2>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7340000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07340000 0 0x1000>;
> +
> +			cpu = <&CPU3>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in3>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7440000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07440000 0 0x1000>;
> +
> +			cpu = <&CPU4>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm4_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in4>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7540000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07540000 0 0x1000>;
> +
> +			cpu = <&CPU5>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in5>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7640000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07640000 0 0x1000>;
> +
> +			cpu = <&CPU6>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in6>;
> +					};
> +				};
> +			};
> +		};
> +
> +		etm@7740000 {
> +			compatible = "arm,coresight-etm4x", "arm,primecell";
> +			reg = <0 0x07740000 0 0x1000>;
> +
> +			cpu = <&CPU7>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_in7>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@7800000 { /* APSS Funnel */
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x07800000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					apss_funnel_out: endpoint {
> +						remote-endpoint =
> +						  <&apss_merge_funnel_in>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					apss_funnel_in0: endpoint {
> +						remote-endpoint =
> +						  <&etm0_out>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					apss_funnel_in1: endpoint {
> +						remote-endpoint =
> +						  <&etm1_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					apss_funnel_in2: endpoint {
> +						remote-endpoint =
> +						  <&etm2_out>;
> +					};
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					apss_funnel_in3: endpoint {
> +						remote-endpoint =
> +						  <&etm3_out>;
> +					};
> +				};
> +
> +				port@4 {
> +					reg = <4>;
> +					apss_funnel_in4: endpoint {
> +						remote-endpoint =
> +						  <&etm4_out>;
> +					};
> +				};
> +
> +				port@5 {
> +					reg = <5>;
> +					apss_funnel_in5: endpoint {
> +						remote-endpoint =
> +						  <&etm5_out>;
> +					};
> +				};
> +
> +				port@6 {
> +					reg = <6>;
> +					apss_funnel_in6: endpoint {
> +						remote-endpoint =
> +						  <&etm6_out>;
> +					};
> +				};
> +
> +				port@7 {
> +					reg = <7>;
> +					apss_funnel_in7: endpoint {
> +						remote-endpoint =
> +						  <&etm7_out>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@7810000 {
> +			compatible = "arm,coresight-funnel", "arm,primecell";
> +			reg = <0 0x07810000 0 0x1000>;
> +
> +			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
> +
> +			out-ports {
> +				port {
> +					apss_merge_funnel_out: endpoint {
> +						remote-endpoint =
> +						  <&funnel2_in5>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				port {
> +					apss_merge_funnel_in: endpoint {
> +						remote-endpoint =
> +						  <&apss_funnel_out>;
> +					};
> +				};
> +			};
> +		};
> +
>  		usb_1_hsphy: phy@88e2000 {
>  			compatible = "qcom,sdm845-qusb2-phy";
>  			reg = <0x88e2000 0x400>;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
