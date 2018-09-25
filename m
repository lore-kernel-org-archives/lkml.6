Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CDBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A87320867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A87320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIZBNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:13:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43925 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIZBNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:13:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id e21-v6so12845869otk.10;
        Tue, 25 Sep 2018 12:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSId57oobYwLEUG2UHCfJvH1SVAHeTeW+QoJI4r1KGM=;
        b=CHGcVi7w+jBB++ffvsHb+rksy5EB3axGFU9MNfMv7OgVvMLSEeGvNc0psF4nQtTyyR
         ur13wqDLoxH8B+gO2IrzgVmgXZ5YV4TMA+Hs5mg/hLSbJAliCUQH3ZnJQIpGlQVACp71
         5u8rQiQXpLiD+VTdGL3ucZkHDE0nxO+LhXHMReCp1MCNbPf1vDHs4I/4Z8w05gyUo/Ko
         8zcn0NiuvlNIi5+1UTGou6QZDaYChj8wghfg24VLEPYaIhEntOgQ7fv4LuSfLL/nVuge
         LzbFzw4edPCiZgplSjbd5B7LZrzkKPhTPhrQalzVpgbF0Q+dMzegl3caFg1XNDW15/fL
         wNcA==
X-Gm-Message-State: ABuFfojM01FU9xJdAO/Xz7zQvPShSSYBkF9tLApWbD2HElJZLr6wX0wF
        tSCKTCKpgkLBmfJiIJ8jQCqP2vY/Ko8f
X-Google-Smtp-Source: ACcGV61foXeOLWj4WRKK53WXryv+4hVa3rOjTcYX3GIPZPkQsFySBAT3jt7kd9MSUtkyA9PngbHyww==
X-Received: by 2002:a9d:24e6:: with SMTP id z93-v6mr1810186ota.90.1537902289277;
        Tue, 25 Sep 2018 12:04:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u6-v6sm1023628ota.75.2018.09.25.12.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:04:48 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:04:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 29/37] ARM: tegra: colibri_t20: iris: simplify model
 and compatible properties
Message-ID: <20180925190448.GA9309@bogus>
References: <20180902100906.25792-1-marcel@ziswiler.com>
 <20180902100906.25792-30-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902100906.25792-30-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 12:08:58PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Simplify model and compatible by dropping the 256/512 MB from the model,
> -512 from the compatible and rename that property from toradex,iris to
> toradex,colibri_t20-iris to be more in-line with all our other device
> trees.

Doesn't seem to be anything related to '-512' in the patch.

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Also reflect this change in the device tree bindings documentation.
> 
>  Documentation/devicetree/bindings/arm/tegra.txt | 2 +-
>  arch/arm/boot/dts/tegra20-colibri-iris.dts      | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra.txt b/Documentation/devicetree/bindings/arm/tegra.txt
> index 5e1b0b30ece2..0909122a2bee 100644
> --- a/Documentation/devicetree/bindings/arm/tegra.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra.txt
> @@ -54,9 +54,9 @@ board-specific compatible values:
>    toradex,apalis-tk1-v1.2
>    toradex,apalis-tk1-v1.2-eval
>    toradex,colibri_t20
> +  toradex,colibri_t20-iris
>    toradex,colibri_t30
>    toradex,colibri_t30-eval-v3
> -  toradex,iris
>  
>  Trusted Foundations
>  -------------------------------------------
> diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
> index cd47ac5b528f..dbdf596dd151 100644
> --- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
> +++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
> @@ -6,7 +6,8 @@
>  
>  / {
>  	model = "Toradex Colibri T20 on Iris";
> -	compatible = "toradex,iris", "toradex,colibri_t20", "nvidia,tegra20";
> +	compatible = "toradex,colibri_t20-iris", "toradex,colibri_t20",
> +		     "nvidia,tegra20";
>  
>  	aliases {
>  		rtc0 = "/i2c@7000c000/rtc@68";
> -- 
> 2.14.4
> 
