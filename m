Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6CCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31442252B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvcuDaf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31442252B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeGBSsb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:48:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38463 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753211AbeGBSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:48:23 -0400
Received: by mail-pl0-f65.google.com with SMTP id d10-v6so8348010plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ApyVzDF7O6chDrfLDxW3wgLn3V0ofQ7bv86jGjf58/4=;
        b=PvcuDaf6EOACi0rftdu5FUbFMBJExNqCrRTsLXQ9oIIRwgt7Rcd1P4WM1T0ghLJD/4
         q6Uj+1daUYmA6t/0W/0qLHNZl1H9EtW2TFU2axARGnx0xElP8pLzXXD9D0tgN0Y8BPNu
         qyV+3Ox8PdRuuYX+hXeH1/6gYeMq+UHpm3szM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ApyVzDF7O6chDrfLDxW3wgLn3V0ofQ7bv86jGjf58/4=;
        b=PTUjcut+PnzyP2CEkB/PHhAET6JUARDejavvvUtmmIy5LywEhkMw796SjVtfiCmcRG
         euAkhQYBnw++PWEeZ2cksbNZcchRYYDRSKJPzDRys++5ylmfJ3fzuZG0MfteMFekpziv
         SQmz/lulvcxyQUkaOmQOsX2KODt+zWjqvY6n6okLUB9cMgS+/nZ0HEdo/64ZJtcM9R7u
         nISkDbBJpFSWp7HoshhLlCzxe2V2J4v3rbZHF7eB4G1VYIho1kqY+pH4ecixuH0GQx6F
         hoVZMUb4xXHWOEXM0H2Y1hs9Qa3uUgPq76oXnY2B6XFntG+QTuUPofQ8WgtpCSN7hTYT
         2SBg==
X-Gm-Message-State: APt69E2jfzuFJyNTxzZ7lLJCQMlegpN/7XJXxzSgmbfBdnsYeC9bDqAt
        MdmiPHY6Eh4vVVXAaZo7KWw5qQ==
X-Google-Smtp-Source: ADUXVKJGZSJTuF7rJsP4yCeF7mydCSnewYLIleYCPWHA2J7T/lZDeGujyYkDZIqwnD2K5hpk9Gq90A==
X-Received: by 2002:a17:902:7688:: with SMTP id m8-v6mr26649607pll.54.1530557302790;
        Mon, 02 Jul 2018 11:48:22 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t5-v6sm25606005pfh.32.2018.07.02.11.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 11:48:22 -0700 (PDT)
Date:   Mon, 2 Jul 2018 11:50:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
Message-ID: <20180702185052.GB2050@tuxbook-pro>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Jul 05:44 PDT 2018, Amit Kucheria wrote:

> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb..edf8505 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,22 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		tsens0: tsens@c222000 {
> +			compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> +			reg = <0xc263000 0x1ff>, /* TM */
> +			      <0xc222000 0x1ff>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: tsens@c223000 {
> +			compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> +			reg = <0xc265000 0x1ff>, /* TM */
> +			      <0xc223000 0x1ff>; /* SROT */
> +			#qcom,sensors = <8>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0xc440000 0x1100>,
> -- 
> 2.7.4
> 
