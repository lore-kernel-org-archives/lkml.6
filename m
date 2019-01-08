Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B422070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hGiWXlWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfAHRvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:51:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34445 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfAHRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:51:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so5108505ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TunmPpxnSDssVSB22DghBoBwVTaYNV4M0VnGyOqA2S4=;
        b=hGiWXlWzH97th7AZgls4CDcCQVO5dz7DUNQh9/YhfvouMkK5PeVvk1TIuIco1e2y5x
         f5b2dMWtRzNaO242+N/tomlxhFgX7VzCQqNEv7CVzGcEXnhbqlaV5U0vdjxbnIFlxd5J
         ChT/EUMTaEITc3KgaF6Vr9wmXTUi9CjPm2bVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TunmPpxnSDssVSB22DghBoBwVTaYNV4M0VnGyOqA2S4=;
        b=ee3/qTHAvYxuT7uGtt9BjL7AsfQXjFyhFjGGJjCMYREvwXWx7v5GzaJnVky4HwxnDB
         X9c5fkv7YxNEX6mzvsrD8WU45opRkfUAeKYXDeodNJNvc17wMpLryZyMlIqtyEYmx8FY
         +6Ru2IIgXqsA8U8+eiTYid6Qh9rbfAP7BpAK8ufjV/t+kZpQafkAD8aZlSth/D09ZW57
         TOAe57DyVjSE/ffcQ72qbKxtoaRIK0v8RdlL9YblxKD0IaNFtBreTahvTbdge9CgslcW
         StTKamJrSLFaAj0yywquF0duMaW/95mR1l3FvWxzdD6PmQVXZ5Y6XQ7oMKpCzJUGOEmq
         dKjA==
X-Gm-Message-State: AJcUuke0XNJFZimUIger8YIlb2tRReo9IVVXFtWSWpeKzwBkExkWiiuz
        xv2x3XQWZ93FGGQJvxNGn7fa9w==
X-Google-Smtp-Source: ALg8bN4Rkr/VtNYB+Qsj0/f/c7N8Je5Muu4vVl29X9BAopMe+/dVIDQ8HfPAYisF0kYBTTL0uoRP4g==
X-Received: by 2002:a50:af21:: with SMTP id g30mr2891224edd.234.1546969878753;
        Tue, 08 Jan 2019 09:51:18 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e7-v6sm203995ejt.23.2019.01.08.09.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:51:18 -0800 (PST)
Subject: Re: [PATCH V2 1/2] dt-bindings: bcm-ns-usb2-phy: rework binding to
 use CRU syscon
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190107082545.5529-1-zajec5@gmail.com>
 <20190108123907.19816-1-zajec5@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <74b4fbf0-89ca-7d70-cb58-4b83300dc881@broadcom.com>
Date:   Tue, 8 Jan 2019 09:51:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108123907.19816-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2019 4:39 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> USB 2.0 PHY is a hardware block that happens to use two registers from
> the CRU block to setup a single PLL. It's not part of the CRU or DMU
> and so its binding shouldn't cover the whole DMU.
> 
> The correct way of handling this is to reference CRU block node using a
> syscon. Document that & deprecate the old way.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: use syscon@ in example (thanks Ray)
> ---
>  .../devicetree/bindings/phy/bcm-ns-usb2-phy.txt    | 27 ++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
> index a7aee9ea8926..2cafee6b4a8b 100644
> --- a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
> @@ -2,19 +2,38 @@ Driver for Broadcom Northstar USB 2.0 PHY
>  
>  Required properties:
>  - compatible: brcm,ns-usb2-phy
> -- reg: iomem address range of DMU (Device Management Unit)
> -- reg-names: "dmu", the only needed & supported reg right now
> +- syscon-cru: phandle to the CRU (Central Resource Unit) syscon
>  - clocks: USB PHY reference clock
>  - clock-names: "phy-ref-clk", the only needed & supported clock right now
>  
> +Deprecated:
> +
> +PHY block should not claim the whole DMU so such a binding has been deprecated.
> +It only requires to access few CRU (a DMU subblock) registers and that should be
> +handled with a syscon since CRU is a MFD (Multi-Function Device).
> +
> +- reg: iomem address range of DMU (Device Management Unit)
> +- reg-names: "dmu", the only needed & supported reg right now
> +
>  To initialize USB 2.0 PHY driver needs to setup PLL correctly. To do this it
>  requires passing phandle to the USB PHY reference clock.
>  
>  Example:
> +	dmu@1800c000 {
> +		compatible = "simple-bus";
> +		ranges = <0 0x1800c000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		cru: syscon@100 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x100 0x1a4>;
> +		};
> +	};
> +
>  	usb2-phy {
>  		compatible = "brcm,ns-usb2-phy";
> -		reg = <0x1800c000 0x1000>;
> -		reg-names = "dmu";
> +		syscon-cru = <&cru>;
>  		#phy-cells = <0>;
>  		clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
>  		clock-names = "phy-ref-clk";
> 

Looks good to me!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
