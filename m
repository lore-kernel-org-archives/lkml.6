Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA2C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0079621736
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548116754;
	bh=ddWM+UBWPhRoIBvqhDahNKo1QE3UIcez5PKeEZA6eSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GKpY/FLVSTpXzNhShDqS3JHQqsC+xYnsEpKvw+VsL88txRN4T2o4WfatziJuz6ER+
	 KaB7eLV4pjhpGxT+Cv2j8YPcUaH/NX+5NA8SiY+eFht0h3ewkHXnlzq/jZYVEfiEXp
	 Vuz1bWjaimLm9Bcv/4Ib6H+hu8fVQ0q9QXma+vK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfAVAZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:25:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36925 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVAZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:25:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so22147977otq.4;
        Mon, 21 Jan 2019 16:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xV0RGCV2FL9mr4mSu1fd4WykekZj8OlmD7R8AWLzPrw=;
        b=DbIMrcVcK//xXy7e7ss0U2F8m0rHoDeMD7HvxcONTITWavmaO6Yn/mDMqC2EIPHm1o
         V/UHzrnwZohmvaErvDHChP8gjt8DLfHgQZEZoIXDaUGMw9QGaf08yPUvUu2h5IASmhl9
         dTg2tEaFOo/X9wLrva9ZOtpkbF2+eHsuUqEaHM5Dj/VYlVLLC/w0pOKhbRzG/dtQ3DDK
         kDOOYN2lqJNM8YdHVNLolYKObGv/Z0BGTKNOmMT2r00kjIeoaG1OSPYVJjLSt9fi5YpB
         yEzB0ggYQ/WWK+mwbnGXOvZ78yhiyZmaDaR5WE64SZ5ITUyxzEqw9bAdnc7K1QFLlpcT
         6izQ==
X-Gm-Message-State: AJcUukfX363YdXjwtY2rXwa7JKozVLNmG3glxHanpxDaSxrrtd0ag4+X
        8Fhs6tQzsyfUAAgRUvC+cg==
X-Google-Smtp-Source: ALg8bN7mJkNAgQXh7MU+ZkZtO6T8ERMYYp2fz0B7iLmvzAPDqWNgISZSnJPqyTViXvjfFmEaxAR/Lw==
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr22060928otb.253.1548116750605;
        Mon, 21 Jan 2019 16:25:50 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f127sm7047978oia.19.2019.01.21.16.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:25:50 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:25:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1 3/8] arm64: dts: sdm845: Add UFS PHY reset
Message-ID: <20190122002549.GA20481@bogus>
References: <20190111230129.127037-1-evgreen@chromium.org>
 <20190111230129.127037-4-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111230129.127037-4-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:01:24PM -0800, Evan Green wrote:
> Wire up the reset controller in the Qcom UFS controller for the PHY.
> This will be used to toggle PHY reset during initialization of the PHY.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> This commit is based atop the series at [1]. Patches 1 and 2 of that
> series have landed, but 3, 4, and 5 are still outstanding.
> 
> [1] https://lore.kernel.org/lkml/20181210192826.241350-1-evgreen@chromium.org/
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b29332b265d9e..029ab66405cf4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -990,6 +990,7 @@
>  			phy-names = "ufsphy";
>  			lanes-per-direction = <2>;
>  			power-domains = <&gcc UFS_PHY_GDSC>;
> +			#reset-cells = <1>;

Is this documented?

>  
>  			clock-names =
>  				"core_clk",
> @@ -1033,6 +1034,8 @@
>  			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
>  				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
>  
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
>  			status = "disabled";
>  
>  			ufs_mem_phy_lanes: lanes@1d87400 {
> -- 
> 2.18.1
> 
