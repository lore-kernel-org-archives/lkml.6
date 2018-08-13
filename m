Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475A4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0757321779
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0757321779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbeHMWKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:10:10 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36098 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeHMWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:10:09 -0400
Received: by mail-io0-f193.google.com with SMTP id m4-v6so14878057iop.3;
        Mon, 13 Aug 2018 12:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sIeoPV/MenzLMjGuxMoojm/8QbXFNn98IZ2FNASTKE=;
        b=gEI5hkrLr7e+yuJXSNXNTXKC18eHN/vNdZOT/8EtverociOtv18ks8e9RVNYHsunS7
         KLXSEONvxqbGrmBma49NxEEHD4FOb6kL+fi4Qm7hp26ICjOLP/wUlhVhsrUTzaD/JGpm
         Opf9Kk8IWPgmAgn9YhmXpkpZUAM6s/rXhByeXLLoDeSE4d8GAkBttGAl9oMJTdIk55/N
         02JorIabrLA5VCc6QG94Y3xwZWor+cpGZQzbwABVMt/fn9XMOGrO43GiNYyJX1IKfRp+
         1+0dzneoip3T/S2qlU/glb/Nnw5E1GhQEfq3gIHFRqfHxWgs3F/jTjg6gFfUN4FVGsh3
         VDeQ==
X-Gm-Message-State: AOUpUlHLJPVlUCZahMgEACarW45QVY4HTJmfjzKJcc80gptjoq3POzRH
        3/3TKtTuOMxInwPeh7T9lA==
X-Google-Smtp-Source: AA+uWPwzT+YiVhQOJLyv9WnlqdCKzZg24TDCM+mrnR2tJ7NQVo8BCvUwrIeuuEROAOXKKcAYYZg/FA==
X-Received: by 2002:a6b:8e8f:: with SMTP id q137-v6mr16353708iod.174.1534188394166;
        Mon, 13 Aug 2018 12:26:34 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u139-v6sm5763662ita.1.2018.08.13.12.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:26:33 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:26:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: mmc: Add DQS trim value to Tegra
 SDHCI
Message-ID: <20180813192632.GA28960@rob-hp-laptop>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
 <1533924845-1466-2-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533924845-1466-2-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:13:58PM +0300, Aapo Vienamo wrote:
> Document HS400 DQS trim value device tree property.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
