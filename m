Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2084BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A21206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550881015;
	bh=baJlyT5r5PH8k6rTMsLIekHQsy0OJy1faifMq5CebIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WTx3ka0JrF0LDGP/WQlR46cy0GWbjYrsHmmL3OEqQUclemYaw20Ki/H+Mvp3AqWoW
	 5mFZD3ReehSLjjTZON3M0PfE2m8fQ8MARrw1sonLJ/EfVLWwSaeZ6AAVMOWmDXWtdT
	 32nOc0Yrjc6/mluS9RebPkPONpAFTB/DmpS6Opes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfBWAQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:16:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44538 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWAQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:16:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id g1so3373887otj.11;
        Fri, 22 Feb 2019 16:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F8pvHTiqZxkrzj+jeHGL8VNP+pTt1XygpHzuLbyse8U=;
        b=GVZh0C8ULcfbBEV/v10zBT9fS3rsY3OoUA9VMHB6Aw9CuqT4GRq17F1QnnfQ3C07C7
         DZMjCGxSGFjHox5nouqS84tNVaRUEfVEH+0j0MwMj+LGZB/7laL1aBXVG4n0DT08+0tQ
         bKjfhH8hNmxCoqf8R2J/f8Xar+uM+EQWqM5AaBM5qqKKb7YjyT1/aSXFVEyHzeiy6gMh
         ZtlHrwCvmZIOsj9+bSYfhnuI0N6tkuPXt6yOvGNI9W/bcqWyKmaJfQMZwu0+RgIYI5eJ
         /ZxJGyw10H+Q9YpIefQ/q1dSVy/6J6GSajMaCmBEch7y3ZyRwLDtgw9ZMt/Uzt7TjtvG
         bSsg==
X-Gm-Message-State: AHQUAuZk8/nqhYIOvLHV+lpTWcG1ZA8U0KzlUcfPYAnMDR69Jy1pVH4e
        SmGN9wZpusjFvaFVvCQuUg==
X-Google-Smtp-Source: AHgI3IZ7ykq6tSp1sxYCkSiTkxCeQO8FV3VpbHXPfdAXtjoc6CEuOBfyqst636PffD3Kdw5r1cPFjg==
X-Received: by 2002:a9d:e8b:: with SMTP id 11mr4413934otj.155.1550881012482;
        Fri, 22 Feb 2019 16:16:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d67sm1252991oig.36.2019.02.22.16.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:16:51 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:16:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Roullier <christophe.roullier@st.com>
Cc:     davem@davemloft.net, joabreu@synopsys.com, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        peppe.cavallaro@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH V2 3/8] dt-bindings: net: stmmac: add phys config
 properties
Message-ID: <20190223001651.GA22381@bogus>
References: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
 <1550824089-19961-4-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550824089-19961-4-git-send-email-christophe.roullier@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 09:28:04AM +0100, Christophe Roullier wrote:
> Add properties to support all Phy config
>  PHY_MODE	(MII,GMII, RMII, RGMII) and in normal, PHY wo crystal (25Mhz),
>  PHY wo crystal (50Mhz), No 125Mhz from PHY config.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> index 1341012..f42dc68 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
> @@ -24,9 +24,9 @@ Required properties:
>  	       encompases the glue register, and the offset of the control register.
>  
>  Optional properties:
> -- clock-names:     For MPU family "mac-clk-ck" for PHY without quartz
> -- st,int-phyclk (boolean) :  valid only where PHY do not have quartz and need to be clock
> -	           by RCC

You can't just remove properties.

> +- clock-names:     For MPU family "eth-ck" for PHY without quartz
> +- st,eth_clk_sel (boolean) : set this property in RGMII PHY when you do not want use 125Mhz
> +- st,eth_ref_clk_sel (boolean) :  set this property in RMII mode when you have PHY without crystal 50MHz

s/_/-/

'sel' I assume is short for select, but the naming here and description 
don't really tell me what I'm getting.

Rob
