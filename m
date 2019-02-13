Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107FBC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C6F222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1r/sALf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389548AbfBMHRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:17:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40059 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389409AbfBMHRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:17:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so746062pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmsNk25rpIeO4ovxEfXhNjKT/5GjvGK1/IoISY4jjrg=;
        b=Z1r/sALf69MEWRMfc/woAbUd+UHb8BVFXbPhCvHHdXfPFZ13eiyEO+G1JD0ep3UxgP
         7bUSuJ/mmld4IS2VFHnrxj/jzlS8iAydNhJbipABQeJ+K1MHRU/xpuN/avJ0fQ6C1OBE
         3iNtaXXxmstSEobpCoXeuKXZl5fsRi/qqQhtUBYN1pyQ99Iw30XlnsXd+rkpxdof4zGc
         nvYqqdRcvvYd6Y3rUcseH4+gqGtkRlL3wRhX8ZCkcu0la9+rZjSva6A1S5CkXS0J3txD
         OAWwpxW1wuhQxpzLYIQGIeJ/rzWMZTDT4ZZlQeI1m34QFav+32YFr6Z8uYHd6g2RDsPR
         0jXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmsNk25rpIeO4ovxEfXhNjKT/5GjvGK1/IoISY4jjrg=;
        b=nL/w0ve4wxCzSjX10T3HOBp9jO14jmDSQkYwoUw/K3VeaovJ7S4MAyC3YbVUyl/pNI
         FFJwFwgq5I3uf50azQe2AoONEL3FvmhKqhxhOUVICOxKmvK7f3ufqSHBLlLwYvOLzq29
         IcL67+iKOfSbbjqKhxxBhQZl58RMRTvhbO9wnYLIeQ4hzKF3DtN58jX6A2kg/YJPOj7A
         qH9RqU9NCMF4rjDZJ+1fhp6i3+3i6XE2/gc9dTn5r+bfrWCAPYw9PKs8dcxtgyzMH4Oq
         wQuYemhwS+cRahSszzJGkj2hFtEMAY9uh0LLA50641dfFS1ptkbLr7R7OTx98btY13RX
         8jIw==
X-Gm-Message-State: AHQUAubMcuUkkeFBUvL34elmNJ3rMTC1zSyjTqwodzFv4NAmTtiDrcbm
        bVbOIe0cqML7/3ldlXh5v+on6A==
X-Google-Smtp-Source: AHgI3IbGs0b1EI5Q9ll26l773Fp1G4dlHcoMNMh7XEgN9dx9Ap6mFygiAqibaFwsPmwwhoNjXYjgGg==
X-Received: by 2002:a62:569b:: with SMTP id h27mr8066681pfj.163.1550042236369;
        Tue, 12 Feb 2019 23:17:16 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l19sm27511958pfi.71.2019.02.12.23.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:17:15 -0800 (PST)
Date:   Tue, 12 Feb 2019 23:17:13 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: qcom: lpass: Add CLK_IGNORE_UNUSED for lpass
 clocks
Message-ID: <20190213071713.GI31919@minitux>
References: <1545306385-31240-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545306385-31240-1-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20 Dec 03:46 PST 2018, Taniya Das wrote:

> The LPASS clocks has a dependency on the GCC lpass clocks to be enabled
> before accessing them and that was the reason to mark the gcc lpass clocks
> as critical.

I have the same problem with the TuringCC in QCS404, that in order to
disable the unused clocks GCC_CDSP_CFG_AHB_CLK must be on. But rather
than marking either side as critical or ignore-unused I think a better
solution is to describe this dependency by using the fact that the clock
framework wraps any accesses in pm_runtime_get()/put() calls. So we can
use this to link the clock controller to some resources that needs to be
turned on whenever we communicate with it.

> But in the case where the lpass subsystem would require a
> restart, toggling the lpass reset would from HW clear the SW enable bits
> of the GCC lpass clocks. Thus the next time bringing up the lpass subsystem
> out of reset would fail.

Are you saying that when we toggle AOSS_CC_LPASS_RESTART the enable bit
is cleared on all these clocks and we might get out of sync between the
clock framework and the hardware?

Can you please elaborate a little bit on this? Afaict in the remoteproc
driver at least, we first disable the clock then we issue the reset.

Regards,
Bjorn

> 
> Allow the lpass clock driver to enable/disable the gcc lpass clocks and
> mark the lpass clocks not be accessed during late_init if no client vote.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/clk/qcom/gcc-sdm845.c     | 2 --
>  drivers/clk/qcom/lpasscc-sdm845.c | 5 +++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index c782e62..8365c97 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -3163,7 +3163,6 @@ enum {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_lpass_q6_axi_clk",
> -			.flags = CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -3177,7 +3176,6 @@ enum {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "gcc_lpass_sway_clk",
> -			.flags = CLK_IS_CRITICAL,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> diff --git a/drivers/clk/qcom/lpasscc-sdm845.c b/drivers/clk/qcom/lpasscc-sdm845.c
> index e246b99..1acc741 100644
> --- a/drivers/clk/qcom/lpasscc-sdm845.c
> +++ b/drivers/clk/qcom/lpasscc-sdm845.c
> @@ -22,6 +22,7 @@
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "lpass_q6ss_ahbm_aon_clk",
> +			.flags = CLK_IGNORE_UNUSED,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -35,6 +36,7 @@
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "lpass_q6ss_ahbs_aon_clk",
> +			.flags = CLK_IGNORE_UNUSED,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -49,6 +51,7 @@
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "lpass_qdsp6ss_core_clk",
> +			.flags = CLK_IGNORE_UNUSED,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -63,6 +66,7 @@
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "lpass_qdsp6ss_xo_clk",
> +			.flags = CLK_IGNORE_UNUSED,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -77,6 +81,7 @@
>  		.enable_mask = BIT(0),
>  		.hw.init = &(struct clk_init_data){
>  			.name = "lpass_qdsp6ss_sleep_clk",
> +			.flags = CLK_IGNORE_UNUSED,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 
