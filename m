Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDD2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA1A20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547582708;
	bh=DHFaRwK2Th/00+N1Ry7fj6VoSta82EwEIs0KDgmwz2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DFsYw1QvgDUwpP4eZnGjSBhL0peuQwJdFpvM+DaGsSC6YOCY/1VDN01XepPqC9+Ym
	 1DDDbxIhX9gQFojRK3p6iqHmHaNAxO9VS1hhlV6gy68jMZUYIwNsVEUUeJ69jQTT5v
	 CU64dHVtv/kI2H5t5Dz8GxexlatPVornMYgpeI0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbfAOUFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:05:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37865 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389610AbfAOUFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:05:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so3158657oia.4;
        Tue, 15 Jan 2019 12:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rPeJKUNFn6iPLyNpXriCiNvV+2WqOF6Aw2Ug+/zeudE=;
        b=T+gLm7c4egddsR53AO0E4hA4mQIzlZ8pU8FcF3w7V3ZT7udbHXkJ5ECl6olkoklgyf
         LoEmZNhaxx/d6loqrDwt94Ar4g8Ev++f950TmNCfDMhJ0+X1xIIJZdJ9YSgzJIjAHqql
         XeGNXMtlSgJc0012THSwaKYCIBo1DpWFhvFGtrMrbiTgu+YtSbBWUz5nk3+UJxOMna2A
         4dhZI1OUFSvCEPIyyyQpJ5d/5clSa3jJyEp/J0ico0lEXeDOr7eAcxYkqWWhhSHF6A/H
         RZFCUIlVCABggJ4v6bsAHIb6TTTMTPIutVlUEBCYI7sqf+JeqgvMx8PL9pjAP4991/LY
         qEGg==
X-Gm-Message-State: AJcUukd3n2lViuSHGIlsn++70XnEbV9sNi+deGzBImdef8N/JKQLQjgc
        jWQJ/w6UCIdeKrfyCCEm2A==
X-Google-Smtp-Source: ALg8bN61+USr4I7liBYJGd8BqhG50bjzLkYSsPa86KFiOq5aeHlnqY6DTYo0ANxGORmtcqLiAmTk7w==
X-Received: by 2002:aca:4ace:: with SMTP id x197mr3013142oia.129.1547582705684;
        Tue, 15 Jan 2019 12:05:05 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id c19sm1951057otl.16.2019.01.15.12.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:05:05 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:05:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: tegra: Add pinctrl for SDMMC
 drive strengths
Message-ID: <20190115200504.GA16841@bogus>
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 14:46:01 -0800, Sowjanya Komatineni wrote:
> Add pinctrls for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc.
> 
> Tegra210 sdmmc has pad configuration registers in pinmux register
> domain and handled thru pinctrl to pinmux device node.
> 
> Tegra186 and Tegra194 has pad configuration register with in the
> SDMMC register domain itself and are handles thru drive strength
> properties in sdmmc device node.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
