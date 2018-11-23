Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B49C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EBC20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EBC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503543AbeKWVhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:37:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35348 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390614AbeKWVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:37:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANArAZL053592;
        Fri, 23 Nov 2018 04:53:11 -0600
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANArAoT077839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 04:53:10 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 04:53:10 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 04:53:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANAr6DU011381;
        Fri, 23 Nov 2018 04:53:07 -0600
Subject: Re: [RFC PATCH v2 03/15] dt-bindings: add binding for USBSS-DRD
 controller.
To:     Pawel Laszczak <pawell@cadence.com>, <devicetree@vger.kernel.org>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-4-git-send-email-pawell@cadence.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BF7DC12.4060600@ti.com>
Date:   Fri, 23 Nov 2018 12:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1542535751-16079-4-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/18 12:08, Pawel Laszczak wrote:
> Thsi patch aim at documenting USB related dt-bindings for the

s/Thsi/This

> Cadence USBSS-DRD controller.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  .../devicetree/bindings/usb/cdns3-usb.txt       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> new file mode 100644
> index 000000000000..f9e953f32d47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> @@ -0,0 +1,17 @@
> +Binding for the Cadence USBSS-DRD controller
> +
> +Required properties:
> +  - reg: Physical base address and size of the controller's register area.
> +  - compatible: Should contain: "cdns,usb3"
> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.

Do you also comply with USB generic bindings for dr_mode, speed, etc?
i.e. Documentation/devicetree/bindings/usb/generic.txt

If yes it must be mentioned in Optional properties:

> +
> +
> +Example:
> +	cdns3@f3000000 {
> +		compatible = "cdns,usb3";
> +		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0xf3000000 0x10000	//memory area for OTG/DRD registers
> +			0xf3010000 0x10000	//memory area for HOST registers
> +			0xf3020000 0x10000>;	//memory area for Device registers
> +	};
> +
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
