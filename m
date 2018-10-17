Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4A0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C73C204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C73C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJQVUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:20:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35699 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:20:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id 14so22141212oth.2;
        Wed, 17 Oct 2018 06:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JqOqw3V8YwEmgAhLIO4EalN/+h6GeD1TvUcxpYuBVAc=;
        b=eUECntwmbWoyTXWqPODLEXIFTKqrkogZYQPDlK7s1NM/NbjUDiuWt3kSkyUuHQW+UL
         /8BEIoGE0Suz+eh/dz/JGLJ+KlDOyMC4efyvbv3adIdl1DNrXLjF3O2yUZGVRqNNFkP5
         6hoiTPsTzz+dp2rFAoCqrp/K6bqJco/7LV9JhHSlyCPvMEFRgxglxICUDLlS+uF0FNoy
         VtLyu2Ngw+NWgBstwSqv5JfngNXw06QXJ1WsFyH3ItUZcRFLQxHe1bpOhWUPWnD2hxG6
         TKXZ0YeebNpyAEadjYTTslwKqSOh//75HOwtwhaMmc94i4zpfYJjJ4xfM1x/HXSCeNQK
         yfew==
X-Gm-Message-State: ABuFfoimWlkjRWayTPvcl6f3ElmMr21Sg2gI51NWcpgmVPLFSWmo9e+L
        jxdchCMYXMnFOqrdgzg5dA==
X-Google-Smtp-Source: ACcGV63SzjoL6tL+nLZQ4b1yhPrTdZvT852hummCkhMcLYV3ZcvC9aZZcCqpC4RVZeX82pdgNwmsMQ==
X-Received: by 2002:a9d:2f9b:: with SMTP id r27mr17266234otb.298.1539782703549;
        Wed, 17 Oct 2018 06:25:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j22sm5835861ote.61.2018.10.17.06.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 06:25:02 -0700 (PDT)
Date:   Wed, 17 Oct 2018 08:25:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v1 05/11] dt-bindings: regulator: Change
 regulator-coupled-max-spread property
Message-ID: <20181017132501.GA19385@bogus>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005153638.1886-6-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 06:36:32PM +0300, Dmitry Osipenko wrote:
> Redefine binding for regulator-coupled-max-spread property in a way that
> max-spread values are defined per regulator couple instead of defining
> single max-spread for the whole group of coupled regulators.
> 
> With that change the following regulators coupling configuration will be
> possible:
> 
> regA: regulatorA {
> 	regulator-coupled-with = <&regB &regC>;
> 	regulator-coupled-max-spread = <100000 300000>;
> };
> 
> regB: regulatorB {
> 	regulator-coupled-with = <&regA &regC>;
> 	regulator-coupled-max-spread = <100000 200000>;
> };
> 
> regC: regulatorC {
> 	regulator-coupled-with = <&regA &regB>;
> 	regulator-coupled-max-spread = <300000 200000>;
> };
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
> index a7cd36877bfe..9b525b657fca 100644
> --- a/Documentation/devicetree/bindings/regulator/regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
> @@ -76,8 +76,9 @@ Optional properties:
>  - regulator-coupled-with: Regulators with which the regulator
>    is coupled. The linkage is 2-way - all coupled regulators should be linked
>    with each other. A regulator should not be coupled with its supplier.
> -- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
> -  in microvolts.
> +- regulator-coupled-max-spread: Array of maximum spread between voltages of
> +  coupled regulators in microvolts, each value in the array relates to the
> +  corresponding couple specified by the regulator-coupled-with property.

Is this in use already? How is a single entry handled?

Rob
