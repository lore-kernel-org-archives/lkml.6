Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B58C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC62421738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd6vVfbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbfBTBZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:25:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBTBZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:25:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so11062629pfh.10;
        Tue, 19 Feb 2019 17:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEwip4j4w2S9Pw1Utw7P2JUHXEBzmbGnOfjHwE7lweg=;
        b=Yd6vVfbO1O7iPmf7D+O52Dcx5QjeSWlr/vx6BXhQ3wFLtDZR/ioV1DkKy6z71/leiC
         dT/2Ug7wun6nP23IFxC77B8GuUg34gAr5yT1PWjrPW0yZ/pQxCh3+vnHtjzR92MmtgFL
         6binJUPKVCBgWMNlg7ZOemLuUexhLg5n2mbLCyLGVXzIdmtdJyPG2H/6Rkh0h5m2HcaK
         jsnHTzQApAAjJZkTmIfHP+n1u1bLvdeRMzjJ/z8zf85EFOFkFBhLhoZESk05wAXHfwmd
         nFgxVeGe6K2h6qzPC8C0Iu7LSnxfNhc7ndXhR25ejAoomMiUII4Ji73iSDeQLBo2q9ns
         rLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEwip4j4w2S9Pw1Utw7P2JUHXEBzmbGnOfjHwE7lweg=;
        b=PXuc/lTEuEVBMcOYiSbVTS/pSTsWgAd+HkP6vAru+w6vKhmCV5bnjI03zyVRBBF/Iq
         IEspgp+m6+Vcb4oKWvFCJMbU5x4YZKJiYeHj56nR/i0UUT5PBwbtYH/oI696JufIOxs2
         7Mg5uR81JGZvlQzGplXEw01ngj5q6DCMOj+QXfKdtGOiZJiE+bH5wcBJT3ojU7AHULnj
         J/79+JqitvxxVTPjo2AbFe8LJVvQrA8ov+oaYjq52gHU4T5HtSwwXC89yhYhSGf05du1
         MGfQBMXg937DtM+/+nwI1YQY9uldR1RFO3PHfduov03dcEQgsaUsfTAuoqQnpbu/6kt4
         NzkQ==
X-Gm-Message-State: AHQUAuatX4rMbePRzmpRnOI125d/qFnhOycS2gHGbSIw8Wg6GjoIxopy
        piCqSmgQoUNYFu1/YRyyUok=
X-Google-Smtp-Source: AHgI3IaA/3ZCQ197zjhqkAF84zAPcoirh9YB820q8R9magUP42cMW1fyN4hwiMM6f0eif3bWLu3s1w==
X-Received: by 2002:a63:fb42:: with SMTP id w2mr26968835pgj.408.1550625901862;
        Tue, 19 Feb 2019 17:25:01 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id 11sm22172168pfh.131.2019.02.19.17.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:25:01 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:24:57 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 04/12] arm64: dts: msm8996: thermal: Add temperature
 sensors near major peripherals
Message-ID: <20190220012456.GG2811@localhost.localdomain>
References: <cover.1550493113.git.amit.kucheria@linaro.org>
 <51feb49578f6e412eb5e80012dc63eab5532342b.1550493113.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51feb49578f6e412eb5e80012dc63eab5532342b.1550493113.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 06:05:18PM +0530, Amit Kucheria wrote:
> msm8996 has a total of 21 temperature sensors. Populate DT with
> information about them.
> 
> There are 2 sensors on each of the cpus - one on the top, the other
> below (we only expose one on the top in DT for now). For the GPU, we
> expose both, the one on the top and the one below.
> 
> Depending on the version of the silicon, sensor 2 is either placed near
> the L3 cache or the venus video decoder. It would've been nice to be
> able to be version-specific but we don't have DTs that differentiate the
> two versions of silicon yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 98 +++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index ae6e9f0778f0..8e36a39e1386 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -237,6 +237,104 @@
>  				};
>  			};
>  		};
> +
> +		gpu-thermal-top {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 6>;
> +
> +			trips {
> +				gpu1_alert0: trip-point@0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";

What is the cooling map for this?

> +				};
> +
> +				gpu1_crit: gpu_crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu-thermal-bottom {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 7>;
> +
> +			trips {
> +				gpu2_alert0: trip-point@0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu2_crit: gpu_crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		m4m-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 1>;
> +		};
> +
> +		l3_or_venus-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 2>;
> +		};
> +
> +		cluster0-l2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 7>;
> +		};
> +
> +		cluster1-l2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 12>;
> +		};
> +
> +		camera-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 1>;
> +		};
> +
> +		q6-dsp-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 2>;
> +		};
> +
> +		mem-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 3>;
> +		};
> +
> +		modemtx-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens1 4>;
> +		};
>  	};
>  
>  	timer {
> -- 
> 2.17.1
> 
