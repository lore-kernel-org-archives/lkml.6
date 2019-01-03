Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC775C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70B021479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiXuk6ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfACXn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:43:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35619 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfACXnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:43:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so16655220pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SbuMexbqKJbiq23yhllit1ncYbW3SgvaBwrWDm8xrXE=;
        b=ZiXuk6ic6vg+9NzHjmc0e6Rx6zniLuRmwHvxq6BQQ1RhUb+t60bfzHK/XSJwFqmJxU
         HMqN+RGc0ba+sMGhlbAJVbYckGMP6gdOEVLpvKmx62EXsAV2W2pLM03jLPuU5jG9kHmh
         Dly8JLxdnZ0T6Gui4AZnq2ncEI+AO3gb9f9ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbuMexbqKJbiq23yhllit1ncYbW3SgvaBwrWDm8xrXE=;
        b=mwDPi4gCY8i+oKQZrPZiz+SkUsnU0LTOw2SDLAsmpmUKXYz7lQJWzULZxSG0tIuG4J
         /UuOC1scr8i/D4TF+UdIjag8/0cB4TnYqkOKrK5ldzLIfPeK1lSyWmOjWTJM0dHxNaev
         ngsXOvi0G5ldwlpw3+KaT0qCCCG1rrirSYbxHOV1XnZo9R0Vd0PzhHYvKzZgwHQnkaca
         O+ITK5/7mghoWkdU80zbWTNA2AKyYai09X1suEnRws9tZpOyWBs5j3PJHtijqfAVSllM
         0uiTDPS2O9B6MzGtyVFtnPPrE31uZ53bqqgpT9NIFefi3GpN+Yk+zkA6Qj0frU+08zkj
         +Iyw==
X-Gm-Message-State: AJcUukf2F8lknJopfDWQ1KQGloGyf12YlC+ZOgC3cUQC0lqsvlzseGB/
        wxU788MgSR2VduhkYSf5Mqg4Gg==
X-Google-Smtp-Source: ALg8bN4HYnxODhrpaSAISreSFxJSIJSh9m7PHctjQ3vNVDj3uCNSX/EgDXdDv0fvx7QyKQhdS5TIyg==
X-Received: by 2002:a63:4948:: with SMTP id y8mr18741354pgk.32.1546559034057;
        Thu, 03 Jan 2019 15:43:54 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h129sm99446322pfb.110.2019.01.03.15.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:43:53 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:42:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     dianders@chromium.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: Add ADSP reserve-memory
 nodes
Message-ID: <20190103234249.GH31596@builder>
References: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
 <1545313174-13481-2-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545313174-13481-2-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20 Dec 05:39 PST 2018, Rohit kumar wrote:

> Add memory nodes required for remoteproc q6v5_adsp pil.
> 

This range doesn't match the documented memory map. I would prefer to
see a "Specify all PIL regions as defined in V10" or similar.

Regards,
Bjorn

> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 23a253b..c0a012f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -88,6 +88,11 @@
>  			reg = <0 0x86200000 0 0x2d00000>;
>  			no-map;
>  		};
> +
> +		pil_adsp_mem: memory@8b100000 {
> +			reg = <0 0x8b100000 0 0x1a00000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
