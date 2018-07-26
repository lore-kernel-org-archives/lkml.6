Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D66C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680322064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="iOo+OEWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680322064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeGZJ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:58:01 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54196 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeGZJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:58:01 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 1722A5C1E35;
        Thu, 26 Jul 2018 10:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532594530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BL4vbMH9ICFhZYeV8mbOw5fuY6oN6Z45KNRN69g5khQ=;
        b=iOo+OEWJf80HMjAQcBem3NzoIHy7nuuJTaQJHlomFnVT9z1jwY0l81Y/AvTd9kzQcoG0Hz
        caiSeiLCm2baIoFkBzkJjRE0pfbc9/iLsJpUlbPGP7Q5GzpIPuxt9jhfAfCRFD0o11BnO6
        oeR6wOlcq7bKKOQuSyqxexT8LRs8YcE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 10:42:10 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: tegra20/tegra30: add pmu interrupt-affinity
In-Reply-To: <20180720163426.4410-2-marcel@ziswiler.com>
References: <20180720163426.4410-1-marcel@ziswiler.com>
 <20180720163426.4410-2-marcel@ziswiler.com>
Message-ID: <e5e24974662564d2501b28ac6faf0b09@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-1.60 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.2018 18:34, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This is similar to tegra124 and avoids the following being reported
> upon boot:
> 
> hw perfevents: no interrupt-affinity property for /pmu, guessing.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> ---
> 
>  arch/arm/boot/dts/tegra20.dtsi | 2 ++
>  arch/arm/boot/dts/tegra30.dtsi | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index a22c6a8f8f83..dcad6d6128cf 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -867,5 +867,7 @@
>  		compatible = "arm,cortex-a9-pmu";
>  		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&{/cpus/cpu@0}>,
> +				     <&{/cpus/cpu@1}>;
>  	};
>  };
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index a6781f653310..1de10f0d1da7 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -1013,5 +1013,9 @@
>  			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&{/cpus/cpu@0}>,
> +				     <&{/cpus/cpu@1}>,
> +				     <&{/cpus/cpu@2}>,
> +				     <&{/cpus/cpu@3}>;
>  	};
>  };
