Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBABC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED6B21848
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545080941;
	bh=CPmGztZI3Qfs+jll2GvUVCaQQfH94+qxFuJcoD43YRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C8LzdRSHhRmmH1k4faMgNJWoq0TPObVT72fRlq4c1goCT0ubqutlujkkJ+zzXstBY
	 OsScldkKA/jlkIIYFV2GTifgsHu1mlwnt5384Nv6sCipH1tsrpEQa/OBEIC7mWd+GU
	 ADihmavd13NcwgE3ZicG7m89r+zfR/h60ugWjgho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbeLQVJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:09:00 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40092 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeLQVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:08:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so189216oie.7;
        Mon, 17 Dec 2018 13:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lfgk9kYLhBCqu4ZKMO+SH8npCkmGRUG0kUHyQjuXehM=;
        b=K28nj7AaBuY5jfiIhq3yKchK2MZdEV1wZS2waMpw32vND0BC83VvP+lP2cds+HBBDP
         ft05fqv564q798AgAHmm6vp8suHR2YkKfBRkgl+jByzU4+1rg2HvFrLk/nxNKZtLuCKr
         yz42I8ySsS4nhmh/VqxvtTNAJIiPnGSSJLdHdaqfiTP5N90LPzuKYS1xEIWiSJpOJz0p
         sqKIiUMGo3KGEw1tThB0A8YFBFYEi8z8xZplEb515oI9fU12wMPewXdTQ3VcM+JwkzxX
         KnZoW5rdb2qfqTFPznS0z7kle8CxxlBLb6BNZHf4CT1YJ0FatXrcwt6WHGrbWOHT6Pdm
         CkSg==
X-Gm-Message-State: AA+aEWYOZZNUWspElmFOplkPctIFUCgauLJ7+qLpQQnaQaGyA7pcWPRc
        s5bFlgTRAheiJ6brrjngxA==
X-Google-Smtp-Source: AFSGD/UtL97zs73huE6gdK5I/7i3DR6koB71J4rEWIOI6OUyuTIo1wuyKrQQH1TIeZMEGL6d/HUOKQ==
X-Received: by 2002:aca:4805:: with SMTP id v5mr5878943oia.292.1545080930586;
        Mon, 17 Dec 2018 13:08:50 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id v141sm6972378oia.25.2018.12.17.13.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:08:49 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:08:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, viresh.kumar@linaro.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] dt-bindings: power: Add qcom rpm power domain
 driver bindings
Message-ID: <20181217210849.GA15490@bogus>
References: <20181212092131.13046-1-rnayak@codeaurora.org>
 <20181212092131.13046-3-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212092131.13046-3-rnayak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 02:51:23PM +0530, Rajendra Nayak wrote:
> Add DT bindings to describe the rpm/rpmh power domains found on Qualcomm
> Technologies, Inc. SoCs. These power domains communicate a performance
> state to RPM/RPMh, which then translates it into corresponding voltage on a
> PMIC rail.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.txt  | 146 ++++++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h        |  39 +++++
>  2 files changed, 185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>  create mode 100644 include/dt-bindings/power/qcom-rpmpd.h
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> new file mode 100644
> index 000000000000..a776e4407f09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -0,0 +1,146 @@
> +Qualcomm RPM/RPMh Power domains
> +
> +For RPM/RPMh Power domains, we communicate a performance state to RPM/RPMh
> +which then translates it into a corresponding voltage on a rail
> +
> +Required Properties:
> + - compatible: Should be one of the following
> +	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
> +	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
> + - power-domain-cells: number of cells in Power domain specifier
> +	must be 1.

#power-domain-cells

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
