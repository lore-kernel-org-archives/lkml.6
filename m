Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D1C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF76724665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/AYdf1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF76724665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934000AbeFVRIE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:08:04 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45583 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933962AbeFVRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:08:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so3227420pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y30DJ0HnvajFVlXDHi2RjBpIT4wn9dgB03zWiyDYezQ=;
        b=F/AYdf1Z1nXcKe6w7g7/LAHNjktte4Tbvuk9BISFXhLbX59G9lN9IE5LBWCoU87fwy
         US1rHXzl/1EXuS4jSCkbyt1L5gph4ys+VQKZOeeR12cm+Z0qIjWjzyH6h/U+AxDEjXDV
         UjIOnIzrrQLU4ZI5BbQzxfNX55Lm9m9aK35oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y30DJ0HnvajFVlXDHi2RjBpIT4wn9dgB03zWiyDYezQ=;
        b=Yv5opbACBXHq+4e+nMPH5PlG1eizVhk8MnT1pp7Pk6WAhF4EngE9mzJfPDOhaxma9C
         Lwzl3ocpQPATYQ9WCrlnj1P1lGSf6O7b66zb1mJVsJPTPjOZ4JnQs/1H57IfPQWXeLpo
         nwkHa2WU2K3t99tWU/Tj+1az7knzOzsODqPtT7/tcLO1fOmq0T+Ji5aM5HQnG7vrvsKk
         39bit8Y2Zaw6jkI+SAxDWHGTKAPi7182Y+myTJOkzjEAxqX8NFzyA1Af+9YY0NBByNZk
         D3cw9L3T2amYRT89DZFM3mkyeRtj7yQYKsP1dA0no6gylLYmq+sD5U98O9zS591V44AD
         IOEg==
X-Gm-Message-State: APt69E14Cj+mj4BDllCJ2GHtpMhaWgGZLD1zqHMFZi5vFvEoEet95fZz
        Xp6NeP7hNLat/zX4zvvjtut2zXkoe3M=
X-Google-Smtp-Source: ADUXVKIGQks6o/AMe+yeiWDrmpD3+DL2MliTB3TLnWyV2i+dNtzNkF1A19tcxwpytPoVOsuy+srVuw==
X-Received: by 2002:a65:6186:: with SMTP id c6-v6mr2147283pgv.360.1529687281056;
        Fri, 22 Jun 2018 10:08:01 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 15-v6sm21186954pfq.81.2018.06.22.10.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:08:00 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:07:58 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org, evgreen@chromium.org,
        robh@kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v8 1/2] dt-bindings: Documentation for qcom, llcc
Message-ID: <20180622170758.GH10336@builder>
References: <1527122121-31452-1-git-send-email-rishabhb@codeaurora.org>
 <1527122121-31452-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527122121-31452-2-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23 May 17:35 PDT 2018, Rishabh Bhatnagar wrote:

> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.
> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> new file mode 100644
> index 0000000..5e85749
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -0,0 +1,26 @@
> +== Introduction==
> +
> +LLCC (Last Level Cache Controller) provides last level of cache memory in SOC,
> +that can be shared by multiple clients. Clients here are different cores in the
> +SOC, the idea is to minimize the local caches at the clients and migrate to
> +common pool of memory. Cache memory is divided into partitions called slices
> +which are assigned to clients. Clients can query the slice details, activate
> +and deactivate them.
> +
> +Properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,sdm845-llcc"
> +
> +- reg:
> +	Usage: required
> +	Value Type: <prop-encoded-array>
> +	Definition: Start address and the the size of the register region.
> +
> +Example:
> +
> +	cache-controller@1100000 {
> +		compatible = "qcom,sdm845-llcc";
> +		reg = <0x1100000 0x250000>;
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
