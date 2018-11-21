Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0828C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE25214DE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LJOGeou3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE25214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeKUUfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:35:34 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:41655 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeKUUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:35:34 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7945B25B781;
        Wed, 21 Nov 2018 21:01:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1542794504; bh=wNuD2KgAfDtSUShJl8pKIgtcrP3uMm2VYTjm8cWbXDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJOGeou39OWCRA5rXgILLkPmvxgJbfIsCAAHkNQIjZVQJVbs8p2L9Umi3rfbUt2om
         lebi4O1y6bS3kDfZrnZ82avZTenBy6WvB7hKOB3iPL4iXfaLVEZBxAzZ/bY05y/jFb
         5hXX7m1LOaGTVXThJ/D6uGOcZMdquj3RsDFOBwRI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 9978294034F; Wed, 21 Nov 2018 11:01:42 +0100 (CET)
Date:   Wed, 21 Nov 2018 11:01:42 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: r9a06g032: Correct the GIC DT node name
Message-ID: <20181121100142.q3wwgcu5pywsdzpx@verge.net.au>
References: <20181120103427.23950-1-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120103427.23950-1-phil.edworthy@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34:27AM +0000, Phil Edworthy wrote:
> Harmless mistake, but it's incorrect.

Hi Phil,

please fill-out this changelog with an explanation of "why".

Thanks!

> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/arm/boot/dts/r9a06g032.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
> index 2322268bc862..4c1ab49c7d39 100644
> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> @@ -173,7 +173,7 @@
>  			status = "okay";
>  		};
>  
> -		gic: gic@44101000 {
> +		gic: interrupt-controller@44101000 {
>  			compatible = "arm,cortex-a7-gic", "arm,gic-400";
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
> -- 
> 2.17.1
> 
