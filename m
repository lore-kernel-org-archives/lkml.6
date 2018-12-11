Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7699C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7638E2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xm4XlMnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7638E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeLKKQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:16:40 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60774 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:16:39 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBAGV4W118852;
        Tue, 11 Dec 2018 04:16:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544523391;
        bh=4rJ+R33zdAmLPoMVK8NpEm2EDT88UCXqTknwMpLUE0M=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Xm4XlMnxa8GadPLBIDDBXMHuq7l+OixF2K1hoWfWNCr0Gw2BrYUZtj4l2JS/VS2XV
         f0kpPV8M7zH7cRAFiZouLtN6epQzQSHSzQ6fRwmSNFZyrvf/UWNO8Wo/xpWlg5GeD3
         dcZGZuyBy1XJ1uXnM2OhAaC4/NztTj9siC6/ph6M=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBAGVwD083589
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 04:16:31 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 04:16:31 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 04:16:31 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBAGRRv022842;
        Tue, 11 Dec 2018 04:16:28 -0600
Subject: Re: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD controller.
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-2-git-send-email-pawell@cadence.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <balbi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <sureshp@cadence.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C0F8E7B.3030601@ti.com>
Date:   Tue, 11 Dec 2018 12:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1544445555-17325-2-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 10/12/18 14:39, Pawel Laszczak wrote:
> This patch aim at documenting USB related dt-bindings for the
> Cadence USBSS-DRD controller.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  .../devicetree/bindings/usb/cdns3-usb.txt     | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> new file mode 100644
> index 000000000000..ae4a255f0b10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> @@ -0,0 +1,31 @@
> +Binding for the Cadence USBSS-DRD controller
> +
> +Required properties:
> +  - reg: Physical base address and size of the controller's register areas.
> +	 Controller has 3 different regions:
> +	 region 1 - HOST registers area
> +	 region 2 - DEVICE registers area
> +	 region 3 - OTG/DRD registers area
> +  - compatible: Should contain: "cdns,usb3"
> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
> +		Driver supports only single interrupt line.
> +                This single interrupt is shared between Device,
> +		host and OTG/DRD part of driver.
> +
> +Optional propertiesi:

s/propertiesi/properties

> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
> +                   "full-speed"; refer to usb/generic.txt
> + - dr_mode: Should be one of "host", "peripheral" or "otg".
> + - phys: reference to the USB PHY
> + - phy-names: name of the USB PHY, should be "cdns3,usbphy"
> +
> +
> +Example:
> +	usb@f3000000 {
> +		compatible = "cdns,usb3";
> +		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0xf3000000 0x10000	//memory area for HOST registers
> +			0xf3010000 0x10000	//memory area for DEVICE registers
> +			0xf3020000 0x10000>;	//memory area for OTG/DRD registers

Use "/* <comment> */" instead.

> +	};
> +
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
