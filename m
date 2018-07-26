Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42468C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB78E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="X2ZW0sLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB78E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbeGZIuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:50:25 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53584 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbeGZIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:50:25 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 708CC5C06D3;
        Thu, 26 Jul 2018 09:34:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532590489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqDG1NM8fLwjKU2KvoWe2CqKLtc7JpMxwr381T+X6Xw=;
        b=X2ZW0sLaK3f306vY3WsFrtalRI/Dkk3d3pp7mMaF7XKNCzU8jXZukLh+iXUQP2uGBMmOjN
        Wt9SqqthciPnIeaOEaUFjTzW4jcQMdJ6axi6s81Dhowm/BpqR6VOgixcfwb+eegRrA8scQ
        29YvGAhLM0B3SSbKkaH4ABHHijhM8FA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 09:34:49 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH 13/15] ARM: tegra: apalis-tk1: fix pcie switch vendor
 compatible
In-Reply-To: <20180724104309.21741-14-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
 <20180724104309.21741-14-marcel@ziswiler.com>
Message-ID: <53e689eca0fe603305642abb559349db@agner.ch>
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

On 24.07.2018 12:43, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> PLX got bought by Broadcom therefore fix device tree compatible string
> vendor which silences the following checkpatch.pl warning:
> 
> WARNING: DT compatible string vendor "plx" appears un-documented
>  -- check ./Documentation/devicetree/bindings/vendor-prefixes.txt

This seems to be not the only instance, there are other places where plx
prefix is used. There are 8 instances in total, 4 ARM (in fact all
Toradex device trees) and 4 PowerPC.

One device is already documented in
Documentation/devicetree/bindings/trivial-devices.txt:
plx,pex8648               48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s)
Switch

I suggest to just add plx as a valid vendor prefix by adding plx to
Documentation/devicetree/bindings/vendor-prefixes.txt:
plx	Broadcom Corporation (formerly PLX Technology)

--
Stefan

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  arch/arm/boot/dts/tegra124-apalis-eval.dts      | 2 +-
>  arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts
> b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> index d9805fc97f5e..84ab7dc9febb 100644
> --- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
> +++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> @@ -109,7 +109,7 @@
>  		clock-frequency = <400000>;
>  
>  		pcie-switch@58 {
> -			compatible = "plx,pex8605";
> +			compatible = "brcm,pex8605";
>  			reg = <0x58>;
>  		};
>  
> diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
> b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
> index 89783fe76f65..5319f88d3cab 100644
> --- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
> +++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
> @@ -74,7 +74,7 @@
>  		clock-frequency = <400000>;
>  
>  		pcie-switch@58 {
> -			compatible = "plx,pex8605";
> +			compatible = "brcm,pex8605";
>  			reg = <0x58>;
>  		};
