Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1432057-1520499553-2-4383811616055600810
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520499552; b=j27goNqttJeaQFwY4ZaikjCytMh/A85NxBiA1F1RkIOG0kZ
    fYi/NVAMs0jmB30yW1v7xYhx8j15v0arL4wN6wPV5N2J4BbVcC53VhDna6NHidtX
    oUv8kJ+JU51AKAjOoiubuaWw+XrQfaAowwAG0WBd1sGdPgQIWERpKWkzpcaXQTki
    NFuLndyzwkgfKfrVnYoLXFiraoYXWCP/CbOlPvA5YYZNC0pj+K5ebktbk7NFaChe
    H1e1snozH9wL1bMirjt4zUcSQvF/l3NHCqNbbM45Y1srfLkiCsUO7sbkkOGD+ceE
    OfKmjXX89cts8Of6vmaZGbCSXbPhPs7maGrlw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520499552; bh=qCPw7zpXUKgjznq8wlEt976EH0
    L0QhBz9m3b9fXXOWw=; b=VEP13Ucz1D/kuWKrTwqtYo7ePQNaHIpquwZS1HdDsr
    gvGEjqQxxKghKgdJ9TBFPieaDvw21ZtvGHmLnHLqnN4clzNngjHkTQ+2EeNjHUR0
    9DHaR3u/SmPOSOsSSsTKyJ1BZMA9W0t1k4Tl5bfm6lCteAYYyLLKwq4UVNYSIwgY
    g8nBqQ659yAsPKMdSNMk0+qXE2ePF4XXxaQ7+srzSqyeivPjKdc7GC+plYaMaNzs
    5Ol+TYnYB72KaLWdLPe8KF0E2iynXtm1NqzXKDGXe2ByUIIVIxH2qfFdjq8b9MjV
    byX4bFkU+GQVY4y1EGZwGtAI/LpRFr0wciUIXPjgsd6w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755494AbeCHI66 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 03:58:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbeCHI65 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Mar 2018 03:58:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B38208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 8 Mar 2018 16:58:14 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>
Cc: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] USB3/DWC3: Add property "snps,
 incr-burst-type-adjustment" for INCR burst type
Message-ID: <20180308085813.GZ3217@dragon>
References: <20180306085911.5930-1-ran.wang_1@nxp.com>
 <20180306085911.5930-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306085911.5930-2-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 04:59:10PM +0800, Ran Wang wrote:
> Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0 DWC3.
> When only one value means INCRx mode with fix burst type.
> When more than one value, means undefined length burst mode, USB controller
> can use the length less than or equal to the largest enabled burst length.
> 
> While enabling undefined length INCR burst type and INCR16 burst type,
> get better write performance on NXP Layerscape platforms:
> around 3% improvement (from 364MB/s to 375MB/s).
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v5:
>   - add support for ls1021a, ls1012a, ls1046a, ls1088a, ls1021a
>   - update ls208xa support according to code base change
> Changes in v4:
>   - change definition for this property.
> Changes in v3:
>   - add new property for INCR burst in usb node.
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |    6 ++++++

Please do not mix bindings doc with DTS change in one patch, and only
send DTS patch after bindings and driver changes are accepted.

Shawn

>  arch/arm/boot/dts/ls1021a.dtsi                 |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    2 ++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    2 ++
>  7 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 44e8bab..d1779b2 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -59,6 +59,11 @@ Optional properties:
>  	fladj_30mhz_sdbnd signal is invalid or incorrect.
>  
>   - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
> + - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
> +	register, undefined length INCR burst type enable and INCRx type.
> +	When just one value, which means INCRX burst mode. When more than one
> +	value, which means undefined length INCR burst type enabled.
> +	The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
>  
>   - in addition all properties from usb-xhci.txt from the current directory are
>     supported as well
> @@ -71,4 +76,5 @@ dwc3@4a030000 {
>  	reg = <0x4a030000 0xcfff>;
>  	interrupts = <0 92 4>
>  	usb-phy = <&usb2_phy>, <&usb3,phy>;
> +	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  };
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c31dad9..b0c3f4f 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -705,6 +705,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		pcie@3400000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index 82b272f..4275a8f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -464,6 +464,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		sata: sata@3200000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 380e7c7..0067567 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -622,6 +622,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb1: usb3@3000000 {
> @@ -631,6 +632,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb2: usb3@3100000 {
> @@ -640,6 +642,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		sata: sata@3200000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 06b5e12..2bf6756 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -602,6 +602,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb1: usb@3000000 {
> @@ -611,6 +612,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb2: usb@3100000 {
> @@ -620,6 +622,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		sata: sata@3200000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 4fc150c..c2b5b45 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -478,6 +478,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  			status = "disabled";
>  		};
>  
> @@ -488,6 +489,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index f3a40af..d5b25f2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -754,6 +754,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb1: usb3@3110000 {
> @@ -764,6 +765,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		ccn@4000000 {
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
