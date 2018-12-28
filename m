Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A4EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3908C21874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546040429;
	bh=jz5avUvpfc+SYWQud5E/NCNwwkrlDPXlqwWVRyfN1XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R8E3F8vdyDkZPVLKoWMkSdUNNsWHpUVrnrd0OsxqivXAbSovjb/e4qxVfHQV2UxvR
	 xOF/4tTQM175yDlMLo4VZc4JwwKF6yFLw69oAwC1RCJQR50USlL8HWVpKkgiET6Ij3
	 5ZFWXBtUcoduPTmnrkLTxIW2PYdefF5ZIKpRqGrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeL1Xk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:40:28 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52778 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeL1Xk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:40:27 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so30219683itg.2;
        Fri, 28 Dec 2018 15:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hut2pR/6AQ/MsPlUxUVHh7ZOjnYbXgIabxOCwJ9Un8E=;
        b=S3ayfiCr5Iv8zFfqBFqPWDj3K0gfPK+5uVeX98irQOCaKQ38bAeGpGxF+RlB/nuuXX
         JM7TfnoCUcv9HsLL7TljdUTs6qFEMXmUCBfSosiyCnVQYQMxFVggeWBNXxvv5OgkPU8c
         Bk+OnA3v100NWU0KESLzOz3RxgaZFfLdrt3pfJA+hy+ROryPg2FxMHnxLziNFW55PzkU
         SfNUSVE1/29AzuCGCzQUGe+rOkacgAgI86AP6vgjChx/SX0f17OKapucQc7agXXPEfnE
         wYMCivVH6rR2O2qJHibAGKIEfXBq5I2Gh/Ww97hqWLEORQ6ygZzuSSLtX4qrBICe8aFy
         4muQ==
X-Gm-Message-State: AA+aEWYx+38msCLgDxvbesvf9Dl3AYl+Jfv8rYz+MrvPknEoMuNIxKBS
        dFJ4rWjE21HlxegJWI/L6qZnlEg=
X-Google-Smtp-Source: AFSGD/UA3bdCQbqjB5xpgXOGXJ0TMferGgevOFErVoMVMfWdmutbWXm4wUWA9WMM2FMKrEmteo2gtQ==
X-Received: by 2002:a24:6f42:: with SMTP id x63mr18885319itb.152.1546040425731;
        Fri, 28 Dec 2018 15:40:25 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id m20sm18458191itm.29.2018.12.28.15.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 15:40:24 -0800 (PST)
Date:   Fri, 28 Dec 2018 17:40:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3] dt-bindings: timer: gpt: update binding doc
Message-ID: <20181228234024.GA21929@bogus>
References: <1545203073-10659-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545203073-10659-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 07:09:10AM +0000, Anson Huang wrote:
> The i.MX GPT timer driver binding doc is out of date,
> update it according to current GPT timer driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.txt       | 35 ++++++++++++++++++----
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> index 9809b11..a7f23a6 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> @@ -2,17 +2,40 @@ Freescale i.MX General Purpose Timer (GPT)
>  
>  Required properties:
>  
> -- compatible : should be "fsl,<soc>-gpt"
> -- reg : Specifies base physical address and size of the registers.
> -- interrupts : A list of 4 interrupts; one per timer channel.
> -- clocks : The clocks provided by the SoC to drive the timer.
> +- compatible : should be one of following:
> +
> +  should be "fsl,imx1-gpt" for i.MX1;
> +
> +  should be one of following for i.MX21/i.MX27:
> +  - "fsl,imx21-gpt",
> +  - "fsl,imx27-gpt",

What this says and your example still don't match. I think you want:

- "fsl,imx21-gpt"
- "fsl,imx27-gpt", "fsl,imx21-gpt"

> +
> +  should be one of following for i.MX31/i.MX25/i.MX50/i.MX51/i.MX53/i.MX6Q:
> +  - "fsl,imx31-gpt",
> +  - "fsl,imx25-gpt",
> +  - "fsl,imx50-gpt",
> +  - "fsl,imx51-gpt",
> +  - "fsl,imx53-gpt",
> +  - "fsl,imx6q-gpt",

I'm sure some of these are backwards compatible. 

> +
> +  should be one of following for i.MX6DL/i.MX6SL/i.MX6SX:
> +  - "fsl,imx6dl-gpt",
> +  - "fsl,imx6sl-gpt",
> +  - "fsl,imx6sx-gpt".
> +
> +- reg : specifies base physical address and size of the registers.
> +- interrupts : should be the gpt interrupt.
> +- clocks : the clocks provided by the SoC to drive the timer, must contain
> +           an entry for each entry in clock-names.
> +- clock-names : must include "ipg" entry first, then "per" entry.
>  
>  Example:
>  
>  gpt1: timer@10003000 {
> -	compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
> +	compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
>  	reg = <0x10003000 0x1000>;
>  	interrupts = <26>;
> -	clocks = <&clks 46>, <&clks 61>;
> +	clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
> +		 <&clks IMX27_CLK_PER1_GATE>;
>  	clock-names = "ipg", "per";
>  };
> -- 
> 2.7.4
> 
