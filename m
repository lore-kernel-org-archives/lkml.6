Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60260C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFA220811
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546042038;
	bh=5RGzi2nkmf1e/ArBzJ4JQ4miEbTPQO+r4WWpMpJDFTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mW2P3maWRNxt62IWYcfWHJCT6/t1h/Qs0xj+TtPlDcfJ8r+YHCtZWrybKZ2TWedXf
	 OOJbtIdycmTQfAcHzp9CuEAw87Cp7vJP1RALjVdT//Badq7uX8rgQIAbDUzUlVYMzE
	 87Kzzk27NThy610ddhGoPvbafJiFE94v0HdJNS6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeL2AHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 19:07:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36021 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeL2AHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 19:07:16 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so28696403itj.1;
        Fri, 28 Dec 2018 16:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yfMVC7zQ7bEaOMQTkSqqrnNV9XOHHvpwkP287tEPagk=;
        b=SnkMjsKiK1JaZLZC0yC18z7nTYEdf1o1J6PW8g9aTfSeE238vvQU+zwqkKx49GH2LW
         Uj0oGhkEWwhIUt7hKjikkxqeuZtDQ0HXOT/fuC1GJdXINS0VJTcaXVzkMG4A7EMzfl+q
         VdGPNrg8HgitbIhgXZvF7qOiKaRSBdZ3CbmypcS190Lb6OEbRSbl+vpwMNOprwTGudvv
         0IjYFKxp+AOomNS8K+FvYWeqpG+LwQCxaW4iZUd+woC9zPUB1GIUwlGdcqtRw/aT4rmc
         HQystmqdxK9edlUHn0KDbLq5AA+9pcphUrskFPtGLyFkW3vMV5Ff94ivbBCMMgwJx/n0
         498g==
X-Gm-Message-State: AJcUukfHvN2JWSE89gwWjOm0lUiEY8SxmWv9MjpZ4VnN4dw+zUd9uzY/
        8bxFOtNDEU8DdseCN/JQvA==
X-Google-Smtp-Source: ALg8bN4JUoPxV5ErIyYZWSI+508gmFCRMbwJAphMkMK87jZb54xfqTAIKHZ2+DqGcDpRTVVwuXGqHw==
X-Received: by 2002:a24:214a:: with SMTP id e71mr16903940ita.60.1546042035478;
        Fri, 28 Dec 2018 16:07:15 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id a12sm14732766ita.17.2018.12.28.16.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 16:07:14 -0800 (PST)
Date:   Fri, 28 Dec 2018 18:07:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     sboyd@kernel.org, evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: sdm845-pinctrl: add wakeup interrupt
 parent for GPIO
Message-ID: <20181229000714.GA3654@bogus>
References: <20181219221105.3004-1-ilina@codeaurora.org>
 <20181219221105.3004-5-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219221105.3004-5-ilina@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 03:11:02PM -0700, Lina Iyer wrote:
> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
> routed to the PDC as interrupts that can be used to wake the system up
> from deep low power modes and suspend.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt    | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> index 665aadb5ea28..a522ca46667d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
> @@ -29,6 +29,11 @@ SDM845 platform.
>  	Definition: must be 2. Specifying the pin number and flags, as defined
>  		    in <dt-bindings/interrupt-controller/irq.h>
>  
> +- wakeup-parent:
> +	Usage: optional
> +	Value type: <phandle>
> +	Definition: A phandle to the wakeup interrupt controller for the SoC.

Is this really necessary? Is there more than one possible wakeup-parent 
node?

> +
>  - gpio-controller:
>  	Usage: required
>  	Value type: <none>
> @@ -53,7 +58,6 @@ pin, a group, or a list of pins or groups. This configuration can include the
>  mux function to select on those pin(s)/group(s), and various pin configuration
>  parameters, such as pull-up, drive strength, etc.
>  
> -
>  PIN CONFIGURATION NODES:
>  
>  The name of each subnode is not important; all subnodes should be enumerated
> @@ -160,6 +164,7 @@ Example:
>  		#gpio-cells = <2>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> +		wakeup-parent = <&pdc>;
>  
>  		qup9_active: qup9-active {
>  			mux {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
