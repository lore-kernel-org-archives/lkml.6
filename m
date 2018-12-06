Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95FEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A008520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X3UQWZ+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A008520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbeLFKcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:32:04 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38174 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbeLFKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:32:03 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB6AW07M127564;
        Thu, 6 Dec 2018 04:32:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544092320;
        bh=6x5VWLjeQA1gjTaM50q94BzWmPrwklajqxf2QM2CFc4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=X3UQWZ+ro4LlOOaRUtsP8zFSz64gg6DZ9qOt5icqBW5n+zVFE/LV4SHQwb9nsdIPd
         rtilZsesLtRa6R1abXaXY4v5X41WHROChfjII/w2OhQOLHz7fjv8YkHby9f5wxlhF1
         BoSCaDILD20vQ7ENQJPEbROu8NPYoeZmTNvetkGI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB6AW0FT102753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 04:32:00 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 6
 Dec 2018 04:32:00 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 6 Dec 2018 04:32:00 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB6AVuF5030397;
        Thu, 6 Dec 2018 04:31:57 -0600
Subject: Re: [PATCH 2/3] dt-bindings: usb: keystone-usb: Add ti,am654-dwc3
 support
To:     Roger Quadros <rogerq@ti.com>
CC:     <balbi@kernel.org>, <tony@atomide.com>, <robh+dt@kernel.org>,
        <nsekhar@ti.com>, <t-kristo@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <1544023171-5796-1-git-send-email-rogerq@ti.com>
 <1544023171-5796-3-git-send-email-rogerq@ti.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <ec72e316-46c1-69f6-ae5b-0fbf297a9327@ti.com>
Date:   Thu, 6 Dec 2018 16:02:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544023171-5796-3-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On 05/12/18 8:49 PM, Roger Quadros wrote:
> The AM654 SoC from TI contains a DWC3 controller. Add
> support for it.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/keystone-usb.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
> index f96e09f..fa29ff8 100644
> --- a/Documentation/devicetree/bindings/usb/keystone-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/keystone-usb.txt
> @@ -3,7 +3,7 @@ TI Keystone Soc USB Controller
>  DWC3 GLUE
>  
>  Required properties:
> - - compatible: should be "ti,keystone-dwc3".
> + - compatible: should be "ti,keystone-dwc3" or "ti,am654-dwc3".

Convention is to have one compatible per line:
 compatible: Should be
	"ti,am654-dwc3" for AM654 SoCs
	"ti,keystone-dwc3" for K2 SoCs



>   - #address-cells, #size-cells : should be '1' if the device has sub-nodes
>     with 'reg' property.
>   - reg : Address and length of the register set for the USB subsystem on
> @@ -21,7 +21,7 @@ SoCs only:
>  - clock-names:		Must be "usb".
>  
>  
> -The following are mandatory properties for Keystone 2 66AK2G SoCs only:
> +The following are mandatory properties for 66AK2G and AM654:
>  
>  - power-domains:	Should contain a phandle to a PM domain provider node
>  			and an args specifier containing the USB device id
> 

-- 
Regards
Vignesh
