Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC62EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A853D2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550864790;
	bh=PDFa/TGmLAldm//K35R/9qykKb14399IVbrRsgs77kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UDau4zIpJxTP875xjP5dNQkj1eg8uFvboCDYxbfN2XZjhVvUCPraARd/JLKfSPAeW
	 1RDFHRIbfCGblHD2BRg1gCfNgjITKzJ4gVAal+8ngY2AhV1a4iohREYYBsKOvku89R
	 60+Q47zG6BFu3d1JP2hw6+VD0aRVPI7+glaUroXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfBVTq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:46:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36032 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfBVTq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:46:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id t206so2655094oib.3;
        Fri, 22 Feb 2019 11:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g/66mCBt5iuS4DHcvmT7yW3xaXm9CqK0ZEHHhvk1QgM=;
        b=XpqAaELlECC14UE5QF6owE+dK9O2032lmt6UNCRHknxneFrjKpgLSXFwEORzYkuK/x
         R8t+0K5hsgo5vylWU/Vl+AWfc531GUW/nVtXpK2KL6Ud1gBNPazGUizG7oaABjRMwQae
         CNKDb3yMj57bep+uzsYWGvHWMyOXtyMBn3gBEzU70vTDeE6x9gaaKEKWooicHZpW4vX5
         b+Ys6+tJ9SV3RpoDkQ0+dV4ZCuZUAmJeCmB8n5VSXIBDwraMhHFVciUEPoEGOVOE37Uz
         I04O+JCGAlA/Quh3jH224WnyRrYkrw7bGD5wWJp7vmQrSm9B/XXrsJVpy2mneWAPprCv
         5qtQ==
X-Gm-Message-State: AHQUAuZDJ4vxwSFWpaSKZ9L4zvNl2MialPnId7gSY0v5RcKxDGbmmg1I
        hASNmFQbSergjqhF74ZLcQ==
X-Google-Smtp-Source: AHgI3IZJqrXJalFuAnhjmqzlj7jHBWFqqRuWJoIe6WXHuUn7clHWViMEWvSw1izp8MYJPAsuB0nVXw==
X-Received: by 2002:aca:35c1:: with SMTP id c184mr2103764oia.39.1550864787562;
        Fri, 22 Feb 2019 11:46:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j1sm886053otl.43.2019.02.22.11.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:46:26 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:46:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: imx: remove unused resources from
 scu resource table
Message-ID: <20190222194626.GA13280@bogus>
References: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550673029-15910-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 02:35:02PM +0000, Anson Huang wrote:
> Removes below resources which were defined during
> pre-silicon phase and the real silicons do NOT have
> them, they have never been used, latest system
> controller firmware also removed them:
> 
> 	IMX_SC_R_DC_0_CAPTURE0
> 	IMX_SC_R_DC_0_CAPTURE1
> 	IMX_SC_R_DC_0_INTEGRAL0
> 	IMX_SC_R_DC_0_INTEGRAL1
> 	IMX_SC_R_DC_0_FRAC1
> 	IMX_SC_R_DC_1_CAPTURE0
> 	IMX_SC_R_DC_1_CAPTURE1
> 	IMX_SC_R_DC_1_INTEGRAL0
> 	IMX_SC_R_DC_1_INTEGRAL1
> 	IMX_SC_R_DC_1_FRAC1
> 	IMX_SC_R_GPU_3_PID0
> 	IMX_SC_R_M4_0_SIM
> 	IMX_SC_R_M4_0_WDOG
> 	IMX_SC_R_M4_1_SIM
> 	IMX_SC_R_M4_1_WDOG
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes since V2, just separate the patch to 2, 1 patch to remove resources and the other is to add new
> resources.
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
> index 4481f2d..32cce37 100644
> --- a/include/dt-bindings/firmware/imx/rsrc.h
> +++ b/include/dt-bindings/firmware/imx/rsrc.h
> @@ -36,15 +36,15 @@
>  #define IMX_SC_R_DC_0_BLIT1		20
>  #define IMX_SC_R_DC_0_BLIT2		21
>  #define IMX_SC_R_DC_0_BLIT_OUT		22
> -#define IMX_SC_R_DC_0_CAPTURE0		23
> -#define IMX_SC_R_DC_0_CAPTURE1		24
> +#define IMX_SC_R_UNUSED19		23
> +#define IMX_SC_R_UNUSED5		24

If unused, don't define them.
