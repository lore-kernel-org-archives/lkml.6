Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92700C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8B620657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547585585;
	bh=QeytTp6CDp1zOVCV7OqblW9J9sO0HdqhYvZdzQAj2+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k+wNhaSLzP2Re4N3Ax869IJJVfNrWzqdycm4I0BeFDa72TByAsOGvi6XF7OmFl7mC
	 wiTH7lvebzgJQzfj82V9/rRcXAmWJBZ6OQC2oK1SdqATWxA2g2wwE7hef1NM65no12
	 maApYlXPcpFwklgLK7hJ13Slz7Z9otbwR+QjRxhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbfAOUxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:53:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34642 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732656AbfAOUxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:53:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so3892098otk.1;
        Tue, 15 Jan 2019 12:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ROrkXXo5qsdJ0iuuGeMbJDifHoAHsOI//Na7Wm597Kg=;
        b=DyX06A07YHQyxQfAWO9S1PLr/4XB3eEr45WYmWrkSM6I5H08qKybEuM61kf6EkrSAR
         B5ZzsrHnQYjAZhFg806iJvNmKr2ViBrvmZtnYdb/8PjmPj3b89fnMwkIFT4oRwYfVkLJ
         Qv9T5+VFBjBaFhAX1pfnmFYK6wt7805Q1wmrDH5aexjzeb+ZIYcnrgyLsx/Z4iir/2mg
         R+CBTyhbcCkAjKYxKl+T8VPXjw0upxPWL1rmEjFZTSi8pjCAsljL0vyyfKSDoTyHQITo
         bpXL8dNuChGguYZdlqgVMuga0oW9sT6W4mGfFOxVbrv7XTrjPlS/F+CgeE1BJ49JOBhC
         krDw==
X-Gm-Message-State: AJcUukdpKjcz6bGZCGNIkgQL77IYl6k79KtQBK+755mwCe8n9FKrgiCS
        pHGDZIgz8TJUInj8B54EmQ==
X-Google-Smtp-Source: ALg8bN6sXM5TnhamZ3fwO9i1DDsJp5DZfhYDlek6hz8ceVd1VqnmjtBuAr8ruFZyT7YT3w8Odv018w==
X-Received: by 2002:a9d:3426:: with SMTP id v35mr3762667otb.71.1547585581834;
        Tue, 15 Jan 2019 12:53:01 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id c78sm2803656oig.30.2019.01.15.12.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:53:01 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:53:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 1/2] dt-bindings: bcm-ns-usb2-phy: rework binding to
 use CRU syscon
Message-ID: <20190115205300.GA6754@bogus>
References: <20190107082545.5529-1-zajec5@gmail.com>
 <20190108123907.19816-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108123907.19816-1-zajec5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:39:06PM +0100, Rafał Miłecki wrote:
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

DMU sounds like some sort of block, not just a bus.

> +		ranges = <0 0x1800c000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		cru: syscon@100 {
> +			compatible = "syscon", "simple-mfd";

Those 2 compatibles alone are not valid. And 'simple-mfd' implies child 
nodes.

Without any knowledge of what else is in the DMU, I can't give any 
advice as to what this should look like instead.

> +			reg = <0x100 0x1a4>;
> +		};
> +	};
> +
>  	usb2-phy {
>  		compatible = "brcm,ns-usb2-phy";
> -		reg = <0x1800c000 0x1000>;
> -		reg-names = "dmu";
> +		syscon-cru = <&cru>;

No need for this. Make it a child of cru node.

There's not a contiguous range of phy registers? If there are, keep 
'reg' even if Linux doesn't (currently) use it.

>  		#phy-cells = <0>;
>  		clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
>  		clock-names = "phy-ref-clk";
> -- 
> 2.13.7
> 
