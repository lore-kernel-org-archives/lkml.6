Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEF0C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE0E2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Tr7La1nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE0E2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeGZIe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:34:59 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53412 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeGZIe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:34:59 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C9C405C1E35;
        Thu, 26 Jul 2018 09:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532589568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bho0YUSAMGOwGdakk24nZY6/SGDMZV8WbqR31xrM6v4=;
        b=Tr7La1nmepbAOQyttm9aLybdbmXr1e1CqoX27xHwPvQ/4ICasGzdD3QSHnaVNBLqVrCZwD
        Lh/lMcGB+xZ5j0z1/PFqdy3AzJbcxGgDdvjgctqbqVv6Ugn2lIjlu3tojWFrlRb8rrmK5M
        t63PKQeLty+sVszOsSLMZeUegwtonM4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 09:19:27 +0200
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
Subject: Re: [PATCH 02/15] ARM: tegra: apalis-tk1: reorder pcie properties
In-Reply-To: <20180724104309.21741-3-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
 <20180724104309.21741-3-marcel@ziswiler.com>
Message-ID: <0de82cabf0585608a5b7f8316f59c054@agner.ch>
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

On 24.07.2018 12:42, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Reorder PCIe properties.

Hm, first vs. last property, as far as I can tell there is no official
recommendation. Maybe Rob can comment on that?

Most device trees put status last, also the base device trees
tegra30.dtsi/tegra124.dtsi. So I think in this case we should go with
last property (before subnodes).

--
Stefan

> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
>  arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 +-
>  arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
> b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
> index 09e3641258ae..cb7e53c86408 100644
> --- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
> +++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
> @@ -39,9 +39,9 @@
>  
>  		/* I210 Gigabit Ethernet Controller (On-module) */
>  		pci@2,0 {
> +			status = "okay";
>  			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
>  			phy-names = "pcie-0";
> -			status = "okay";
>  
>  			pcie@0 {
>  				reg = <0 0 0 0 0>;
> diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi
> b/arch/arm/boot/dts/tegra124-apalis.dtsi
> index 5e7ae5e92fb8..d73ee974648a 100644
> --- a/arch/arm/boot/dts/tegra124-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
> @@ -74,9 +74,9 @@
>  
>  		/* I210 Gigabit Ethernet Controller (On-module) */
>  		pci@2,0 {
> +			status = "okay";
>  			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
>  			phy-names = "pcie-0";
> -			status = "okay";
>  
>  			pcie@0 {
>  				reg = <0 0 0 0 0>;
