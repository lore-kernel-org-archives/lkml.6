Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5268C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ffaNTXMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C28C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeJFCKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:10:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39864 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeJFCKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:10:36 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w95JAGbh108791;
        Fri, 5 Oct 2018 14:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538766616;
        bh=WFafaqKB5oPD5uBbDNbu/e8fwGD+/SA5H922zE81JyI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ffaNTXMN2rVfk+AZ5lvrNSwsMIJ64m4JYfIsDJPsVVPXCDrQYuvslebnSd1kucY9m
         fHKk67C23dB5QpwkIzES5fU4m2qX4N9n1sBeWjrTmKTXxsGWLlDkNfdTDoj+xE0Cu8
         qkvB8bKlQSke8cIb1SweadIsJ5fsT9mdDF9RzT5o=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95JAGof016315;
        Fri, 5 Oct 2018 14:10:16 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 5 Oct
 2018 14:10:16 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 5 Oct 2018 14:10:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w95JAGF4010144;
        Fri, 5 Oct 2018 14:10:16 -0500
Date:   Fri, 5 Oct 2018 14:10:16 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh R <vigneshr@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address
Message-ID: <20181005191015.qkk7vvmdoksemctw@kahuna>
References: <20180927050146.17847-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180927050146.17847-1-vigneshr@ti.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05:01-20180927, Vignesh R wrote:
> cbass_wakeup interconnect which is the parent of wakeup_uart node
> defines address-cells=1 and size-cells=1, therefore fix up reg property
> of wakeup_uart node accordingly. Otherwise, this UART instance fails to
> probe if enabled.
> 
> Fixes: 4201af2544b3 ("arm64: dts: ti: am654: Add uart nodes")
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> Based on next-20180926
> 
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index ee56959f4af8..c617393ea767 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -44,7 +44,7 @@
>  
>  	wkup_uart0: serial@42300000 {
>  		compatible = "ti,am654-uart";
> -		reg = <0x00 0x42300000 0x00 0x100>;
> +		reg = <0x42300000 0x100>;
>  		reg-shift = <2>;
>  		reg-io-width = <4>;
>  		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;


Thanks. Tero: we should probably queue for rc fixes. wkup_uart is used
by System Firmware logs (if enabled), so kernel usage is limited to some
specific platforms. This is a valid fix and my miss..

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
