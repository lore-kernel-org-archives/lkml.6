Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76069C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB9120989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gaGoF2xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfA3Grp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:47:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33062 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfA3Grp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:47:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so10638441plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9vE9ijSUbiIsg6uzwmCvGDksh5briP2shZXnqIqK5t0=;
        b=gaGoF2xmqjQbTGUPoF0e2bFowINL9MHOPXYVMC7aonsjGxvSPJ6ERrU0BkNh0MxEwr
         XduJjASzJvVNyJiwDnDySgI+yTKF9E0WHS8nAiKesFUt/40UcxlEZ8z9UWEX94y7oxIN
         RiMOZiaNlUeURgz8fKpzgXU1QvuMz1cyZpyMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9vE9ijSUbiIsg6uzwmCvGDksh5briP2shZXnqIqK5t0=;
        b=pF+GeeP9XjFomEzeudm/Tk0AJsFG+Zu/hhx1OrLg++ggLQKqhCPaOc1ql07LYtnSCc
         C9hi6YLLX49Vl4xEeMvmoQqtDrzkTV/k9ZJ0mS6TDY+snrFBrgofcYCO06HIReOA9M/a
         I3k0AByg8PsVD6Ci5JPK+2+7dVIWlTkKcUDoJHr+kC2kjRxYxtm2c4bpZnc+CzZQXkw9
         RZp/+0PF53Et3aza3iVnMqoA9VzIcUgDr7kkngy7n9RTSJnl8Bznta/Bl0OSZSQ3ie5P
         JqgdjS2q5hhbkmyE7aJstRIWL76zH47XLeid9WRPni1MhJ50hD+/7tsdn9KRz380XxAv
         l2aQ==
X-Gm-Message-State: AJcUukeCoS3O63fYnT2Kd4Ao2JL6jkqfukUhserleSrdPrKJ3LmvZiAT
        7yV/uHO5OGHrvCZ2YGnW6LEC8g==
X-Google-Smtp-Source: ALg8bN6K7SkjrFkVd7xaH2xl9LAum6mgSRtoC1N6XQHTl6Mt52fhHOjCTAfdP8UKdTVc+Ft6ME3gYA==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr29570041pld.23.1548830864134;
        Tue, 29 Jan 2019 22:47:44 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f13sm908674pgq.82.2019.01.29.22.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 22:47:42 -0800 (PST)
Date:   Tue, 29 Jan 2019 22:47:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: sdm845: Define rmtfs memory
Message-ID: <20190130064740.GB2387@tuxbook-pro>
References: <20190129232009.5033-1-bjorn.andersson@linaro.org>
 <20190129232009.5033-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129232009.5033-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29 Jan 15:20 PST 2019, Bjorn Andersson wrote:

> Define the rmtfs memory node, as described in version 10 of the memory
> map.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v3:
> - Labeled the node
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c363848e9001..afaffcc1e835 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -78,6 +78,15 @@
>  			no-map;
>  		};
>  
> +		mpss_efs: memory@85d00000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0 0x85d00000 0 0x200000>;

It would be nice if this is how math works, but unfortunately I missed
that this overlaps with the xbl_mem below.

Will fix and resend the series.

Regards,
Bjorn

> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +
>  		xbl_mem: memory@85e00000 {
>  			reg = <0x0 0x85e00000 0 0x100000>;
>  			no-map;
> -- 
> 2.18.0
> 
