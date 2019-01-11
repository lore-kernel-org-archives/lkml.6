Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E288120657
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547223085;
	bh=wlhzySpQexfDTHBtmYOaa4kUngy8ps93uoCtSzAwEVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bB6zCwMTYoZJvXlAgS8kkp/3Wj7GYNYVlwtBEKwkVN4lHWob179jJzH3/mh8RXJRq
	 3FnAUYjvhYLO9P/7S8hpvcVQwmQBvbshqFQeuh90XDZBlEQST5IlEAHZEdb8BETZv2
	 MTynCjS/2K0PcMMYMNMgVYVfZGU6mrKgWOoEHoVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbfAKQLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:11:24 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39289 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfAKQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:11:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so12615031oia.6;
        Fri, 11 Jan 2019 08:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GRecEAjgtFmhrxC47GMtKt+tli6Fq5d/fm+B5suVxdo=;
        b=Pr5PKO2rDqnewo8KjcuHn6a+Cq2BqZ8nMw3BeGDTh+tq4Rgx65l6Ch3wjUZdDgOfA6
         U/jXCH2RUczJOecLeKFI188cVdjAvxQ9uq5aFcokpS/OcnI/39ej6CQ/OF0W67n1KHx9
         Xj/LV7jg2BL9+W21UPTKLjjxMR5l1PrKDaTYake7UoF18aplcBruzSFIWr8tUHyg+AiK
         fINsy0gPLOkIcXTGmYR2O3BsAtgcYyoQqvXH1XoG+IsdCtXvPo5P8SgjL3cYzhuV1maa
         Ce6M8qbin+RCwnWUwDhD0r9ONEwadmggm4RcWViQpv8v0u6VsK093nvB6wWQ/yh5B2uE
         RARQ==
X-Gm-Message-State: AJcUuked2y9LN06xBxyFC9u4nHQg/jweA8Pc3pNZkY+Z4g5yj0whtkqb
        7esxrb6OQFZMIJlrBNCGpw==
X-Google-Smtp-Source: ALg8bN5EZVAbXcE+pNN4ZsRZ3vwo0tPAt9UQdPCMHIojTQmtpwtreFKxVw/SOKXJq5KG7oWQAv2HZg==
X-Received: by 2002:aca:2409:: with SMTP id n9mr9974996oic.40.1547223082407;
        Fri, 11 Jan 2019 08:11:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p203sm54969009oic.49.2019.01.11.08.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 08:11:21 -0800 (PST)
Date:   Fri, 11 Jan 2019 10:11:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad
 drive strength config
Message-ID: <20190111161120.GA6491@bogus>
References: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2019 12:57:52 -0800, Sowjanya Komatineni wrote:
> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc which has pad configuration registers in the pinmux
> reigster domain.
> Pad drive strengths for Tegra186 and Later are
> part of SDMMC device node itself.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
