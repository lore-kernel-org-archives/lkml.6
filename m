Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA020C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0432054F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FtgpCBbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfAGSoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:44:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44222 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfAGSoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:44:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so500706pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2rLPjW8RsDHi3ecEnaW6OM9vjtfNzzCiW8A03rvpCw=;
        b=FtgpCBbdHGUWgENIZ6C9AjSCQBm4slFZxUXPF/fW1YzpmsCUqzyJjfAJA1GW3lzHWt
         Ej7v2MkolIOrGPhcp2uzy0xvaogByQS/D917f+7mNeOOaNvP7pfbG4KchaPurMFQs0k9
         pjHetbe15OQw3OE6d6Bso/AF5VlyPZfC8FYQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2rLPjW8RsDHi3ecEnaW6OM9vjtfNzzCiW8A03rvpCw=;
        b=uafDTF5pkEZMZps6gs18ktf6lYqQwfd9pdRSqbsGIss07ocdt428i2NHWPNITB9oeG
         ihrpfH5mA2lT0i62QWcLsl0UQxRMBUw3aT5ycW0adOFlDkNl4dryRamsqB/nX6dThFUa
         U6LdSRt0eMxnzBZiKBspMNfERC6HIXEL6ZK7+2/Z7w2+aZEn5vRRgEbWgHQ+nsPOA9KW
         8RQjHvv0c3F5sSnR/nRUYxgNOb5vDYvcFvSj4UH7LOZsZ4ieNTRkuRyCMRW3rmiuQfyH
         MmOuW7Il6Njszd1LLX/MfF/raljQntp1oCBVl3vnfeQdkOsyAUCjpu1VoeOzLPX/mive
         4SaA==
X-Gm-Message-State: AJcUukc7UMHjzL9/1VgwBpkFLeK1EAR8pkGp32VQFQcky54h0PAKqwun
        OgRoJdil43GUAlJiVAFoskO16pVqZRAxYw==
X-Google-Smtp-Source: ALg8bN7wYMqrT8qYfl9CDIIlGFdKzrusoqMS8E4r6GxdiK/+eYQOkJ4OLPg16eYu3AkXLalZA1IrkQ==
X-Received: by 2002:a63:fb4c:: with SMTP id w12mr11988596pgj.321.1546886645034;
        Mon, 07 Jan 2019 10:44:05 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j197sm105311489pgc.76.2019.01.07.10.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:44:03 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: bcm-ns-usb2-phy: rework binding to use
 CRU syscon
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20190107082545.5529-1-zajec5@gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <0ff798e3-55ed-9043-2136-4431f7f4a020@broadcom.com>
Date:   Mon, 7 Jan 2019 10:44:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107082545.5529-1-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/2019 12:25 AM, Rafał Miłecki wrote:
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
>  .../devicetree/bindings/phy/bcm-ns-usb2-phy.txt    | 27 ++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
> index a7aee9ea8926..36b634d2f0ca 100644
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
> +		cru: cru@100 {

cru: syscon@100 {

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
