Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838F3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4489920852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4489920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeGYRWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:22:02 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42637 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeGYRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:22:01 -0400
Received: by mail-io0-f195.google.com with SMTP id g11-v6so6772649ioq.9;
        Wed, 25 Jul 2018 09:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zveYfD43KUMYUlwJCQTXLPLpI+Ezu85MTjtv6EkTUnY=;
        b=D65gspLN0IivGLUA6N1q6tQhEzX7tGIHH7q55mxOKyQmtsAfSHkIbMc6RRSZbzon0k
         T/lzcmpLDFlDRvOJ7EVAKMhwIVpVK1fq1wkmvohh3JWsgqn6neOMZXAbFU7EMLgsDRaU
         ZL/0Hji8+wj16qfjaNK0F6cSWrimCscJrG6hh+aF1SNepPe2ZUATPMlVhc10scOBYGKb
         qUsVaf3cU8X4/QZJfHFkK+kmrxfpfE6O1ZvaxQ9NaIR4MkKNY3BOwFOIanvMcyc0ENGl
         4bJ74qqwemo55s1wtafFzO50N2Vek3dS53vpSvxGzIRWu+Akd+MnTMtWj81IhAk+NEPc
         036A==
X-Gm-Message-State: AOUpUlHRengfPXzK0vS/ZKvv943cwkGY2vj8Zrx4GWxw3c4Z+b0aE+Rw
        T+5CzW3bwVVUTUR1LxXrBg==
X-Google-Smtp-Source: AAOMgpfvV6nFsSARAXnJJfrGa9y7V0L3myG9pqeg46BvctIwqkVT/ULnw0TNYeinnvrocYhsLgyuyA==
X-Received: by 2002:a6b:db01:: with SMTP id t1-v6mr17197283ioc.114.1532534981155;
        Wed, 25 Jul 2018 09:09:41 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id r137-v6sm2653794ith.26.2018.07.25.09.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 09:09:40 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:09:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, sudeep.holla@arm.com,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, matt.sealey@arm.com,
        charles.garcia-tobin@arm.com, coresight@lists.linaro.org,
        john.horley@arm.com, mike.leach@linaro.org
Subject: Re: [PATCH v2 09/10] coresight: Cleanup coresight DT bindings
Message-ID: <20180725160939.GA24323@rob-hp-laptop>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-10-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531997715-6767-10-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:55:13AM +0100, Suzuki K Poulose wrote:
> The coresight drivers relied on default bindings for graph
> in DT, while reusing the "reg" field of the "ports" to indicate
> the actual hardware port number for the connections. This can
> cause duplicate ports with same addresses, but different
> direction. However, with the rules getting stricter w.r.t to the
> address mismatch with the label, it is no longer possible to use
> the port address field for the hardware port number.
> 
> This patch introduces new DT binding rules for coresight
> components, based on the same generic DT graph bindings, but
> avoiding the address duplication.
> 
> - All output ports must be specified under a child node with
>   name "out-ports".
> - All input ports must be specified under a childe node with
>   name "in-ports".
> - Port address should match the hardware port number.
> 
> The support for legacy bindings is retained, with a warning.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 91 ++++++++++----------
>  drivers/hwtracing/coresight/of_coresight.c         | 97 +++++++++++++++++++---
>  2 files changed, 129 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 8e21512..f39d2c6 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -104,19 +104,9 @@ The connections must be described via generic DT graph bindings as described
>  by the "bindings/graph.txt", where each "port" along with an "endpoint"
>  component represents a hardware port and the connection.
>  
> -Since it is possible to have multiple connections for any coresight component
> -with a specific direction of data flow, each connection must define the
> -following properties to uniquely identify the connection details.
> -
> - * Direction of the data flow w.r.t the component :
> -   Each input port must have the following property defined at the "endpoint"
> -   for the port.
> -	"slave-mode"
> -
> - * Hardware Port number at the component:
> -     -  The hardware port number is assumed to be the address of the "port"
> -         component.
> -

Why do you add this in the previous patch and then remove it here?

> + * All output ports must be listed inside a child node named "out-ports"
> + * All input ports must be listed inside a child node named "in-ports".
> + * Port address must match the hardware port number.
