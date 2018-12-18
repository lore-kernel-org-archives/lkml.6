Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F10C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306CA21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545153114;
	bh=7zuagWpv7MxipcwAuF1eeYX1fMHP5H4wzlhb2u+Qq9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ap4/K1WBQm5roysY5lYcEPVkfOmHmst0l0t2whYJO3hBByshMnzIevFOstu4b+2nz
	 BwudRS5sIRd8too0pARYilOn6fOSpx3dkoKcXtzGHTZdmfXRs2NyyOh+3Wxtct1HIu
	 iQ4bHiJILcH9mqGgSpeJiGvRvKPVz/l/Mn6W7vQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeLRRLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:11:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33451 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeLRRLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:11:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so16402864otl.0;
        Tue, 18 Dec 2018 09:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygrl2FiWe+R6FPgyEioUT5XeXhqROQwQmX6FUTgJuE8=;
        b=rgcMEFEUrv65/d6WH1QyQ4EWPJ33E3bp6b9svwSKlRHaZXct72L/JzaKapaMpb/PsT
         Jozia1VwqgeXt8bDPM9vriJKNJPoKeTvsOFc1o/b1RL432V6LClCmPpg8wncw9Y757Fn
         HUMA8ds5Ju+hDlDXf3QVE11TkGK9VqgfZdluM8hanH9Pm1WuzS5PRVRw7nE5SPxvaceA
         o7auqpcRSEikpaz0TRkXj2XCwXWah80IwJbYaPUpIyC6wQb3R/78UJe3ZCNu+/mk6fKq
         73vZd//aGvtFF3txRHtMbMIhiGAueJ4udr+PtItlAss5Nz5d7tjUoVFZOXLVuq8et58T
         QmWQ==
X-Gm-Message-State: AA+aEWZUts8l5jiknSvhSOAac7b1PagaoJBEoDwqM+yA1jQVMqysh/50
        b+dyKTLvoEyvJMIlSmbSkg==
X-Google-Smtp-Source: AFSGD/Wk0pHF4zUUFvAET4hrdL8YGrYEPKiaEuvq9+nDPy2U7hJR5JUXzDJWUG7Lxt4nH9hFRCXqkQ==
X-Received: by 2002:a9d:3662:: with SMTP id w89mr13259483otb.55.1545153111855;
        Tue, 18 Dec 2018 09:11:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm13221395oia.55.2018.12.18.09.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:11:51 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:11:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] dt-bindings: timer: gpt: update binding doc
Message-ID: <20181218171150.GA21403@bogus>
References: <1544598889-2995-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544598889-2995-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 07:20:44AM +0000, Anson Huang wrote:
> The i.MX GPT timer driver binding doc is out of date,
> update it according to current GPT timer driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/timer/fsl,imxgpt.txt       | 28 +++++++++++++++++-----
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> index 9809b11..2ed84ad 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> @@ -2,17 +2,33 @@ Freescale i.MX General Purpose Timer (GPT)
>  
>  Required properties:
>  
> -- compatible : should be "fsl,<soc>-gpt"
> -- reg : Specifies base physical address and size of the registers.
> -- interrupts : A list of 4 interrupts; one per timer channel.
> -- clocks : The clocks provided by the SoC to drive the timer.
> +- compatible : must be one of following:
> +  - "fsl,imx1-gpt",
> +  - "fsl,imx21-gpt",
> +  - "fsl,imx27-gpt",
> +  - "fsl,imx31-gpt",
> +  - "fsl,imx25-gpt",
> +  - "fsl,imx50-gpt",
> +  - "fsl,imx51-gpt",
> +  - "fsl,imx53-gpt",
> +  - "fsl,imx6q-gpt",
> +  - "fsl,imx6dl-gpt",
> +  - "fsl,imx6sl-gpt",
> +  - "fsl,imx6sx-gpt".

You need to list fall-backs here. IOW, what are the valid combinations?

> +- reg : specifies base physical address and size of the registers.
> +- interrupts : should be the clock event device interrupt.

'clock event' is a Linux thing and shouldn't be part of the binding.

What happened to the 4 interrupts?

> +- clocks : the clocks provided by the SoC to drive the timer, must contain
> +           an entry for each entry in clock-names.
> +- clock-names : must include "ipg" entry first, then "per" entry, "osc_per"
> +                can be a substitute of "per" entry on some SoCs.

per or osc_per should be deprecated so only one is used going forward.

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
