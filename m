Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NKrgAFrnGltKYwAAmS7hNA
	; Fri, 08 Jun 2018 20:30:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D9128607E7; Fri,  8 Jun 2018 20:30:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PY6xzadl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 48263601D2;
	Fri,  8 Jun 2018 20:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48263601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932092AbeFHUaP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:30:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38693 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeFHUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:30:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id b74-v6so7180423pfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 13:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wwQOtuXl4E4GgWhitlx0Pj0xixasp8LEMmt5iX5JPzI=;
        b=PY6xzadlpnHDh22W29cdykFU1anQ0Gj6ujKeqe/MeWV/+Kin+tXJUerKTGynNYtY/n
         3fWsFn28xHNfeAjnQhlCeZipPWKKRofP5coLUpr/VAj1+ji4uajr3VWHAfIgC/TVy/iR
         1qKfaYELbOaHoMEQ6tNOE4nQ3EDWdHqTqu3WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wwQOtuXl4E4GgWhitlx0Pj0xixasp8LEMmt5iX5JPzI=;
        b=RYe+JuvU6Q1nTRjbw22IM2woe/fyYJ8wQjj1HBMukxDYVITDmR3oEEneI/oFB+8kAd
         RkLBdQmJQCeKNueqEtaCm/5OI8vzzgYwDVUfWp0YclygqQvPZCGSyXjDz4854H0IJOSB
         h48iRJRklR6u9pEPhRS6rH5wtSleCRkB1tgM7SiXJJAfI4n9XuZtoAOWxFJZhpdrKNNC
         901ToHq5l+RHYoCO0SIqF1x85vEIN04AT0hTAIgpc5DeyRpw49FND8F6r0j1UJuXoiwv
         o8b4XQ1+mfieKSOcC5KMuVgppC3L085pWco7KwJZBUmnkh4NX3wDGxz+jSpDPXiQiVku
         L60g==
X-Gm-Message-State: APt69E1BUftmdQcxzFID7lS4zo2wH2H1latTXdPe7ZukMLAAyekF4QKN
        nRv6YsGE2Qgx7HgnSgDVrkf+7w==
X-Google-Smtp-Source: ADUXVKIydJPj1NjAm/uMX59mtrIF5y77id0xoMBYvE0A4vKoz0ISUJ0yKz5lnFCvmrTz3HvlPt4t2g==
X-Received: by 2002:a63:7d4c:: with SMTP id m12-v6mr6412945pgn.201.1528489812596;
        Fri, 08 Jun 2018 13:30:12 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w3-v6sm7409811pfi.109.2018.06.08.13.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:30:11 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:30:09 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: [PATCH 07/20] coresight: dts: Document usage of graph bindings
Message-ID: <20180608203009.GF30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-8-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-8-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:18PM +0100, Suzuki K Poulose wrote:
> Before we update the bindings, document the current graph bindings
> and usage of additional properties.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  .../devicetree/bindings/arm/coresight.txt          | 31 +++++++++++++++++++---
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 9aa30a1..ed6b555 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -52,9 +52,7 @@ its hardware characteristcs.
>  	  clocks the core of that coresight component. The latter clock
>  	  is optional.
>  
> -	* port or ports: The representation of the component's port
> -	  layout using the generic DT graph presentation found in
> -	  "bindings/graph.txt".
> +	* port or ports: see "Graph bindings for Coresight" below.
>  
>  * Additional required properties for System Trace Macrocells (STM):
>  	* reg: along with the physical base address and length of the register
> @@ -71,7 +69,7 @@ its hardware characteristcs.
>  	  AMBA markee):
>  		- "arm,coresight-replicator"
>  
> -	* port or ports: same as above.
> +	* port or ports: see "Graph bindings for Coresight" below.
>  
>  * Optional properties for ETM/PTMs:
>  
> @@ -90,6 +88,31 @@ its hardware characteristcs.
>  	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
>  	  use the SG mode on this system.
>  
> +Graph bindings for Coresight
> +-------------------------------
> +
> +Coresight components are interconnected to create a data path for the flow of
> +trace data generated from the "sources" to their collection points "sink".
> +Each coresight component must describe the "input" and "output" connections.
> +The connections must be described via generic DT graph bindings as described
> +by the "bindings/graph.txt", where each "port" along with an "endpoint"
> +component represents a hardware port and the connection.
> +
> +Since it is possible to have multiple connections for any coresight component
> +with a specific direction of data flow, each connection must define the
> +following properties to uniquely identify the connection details.
> +
> + * Direction of the data flow w.r.t the component :
> +   Each input port must have the following property defined at the "endpoint"
> +   for the port.
> +	"slave-mode"
> +
> + * Hardware Port number at the component:
> +     -  The hardware port number is assumed to be the address of the "port"
> +         component.
> +
> +
> +
>  Example:
>  
>  1. Sinks
> -- 
> 2.7.4
> 
