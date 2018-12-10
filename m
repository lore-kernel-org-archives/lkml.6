Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F317EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D2F2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lWE35Nc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D2F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLJJF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:05:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40868 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLJJF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:05:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBA95LEt012471;
        Mon, 10 Dec 2018 03:05:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544432721;
        bh=xV6FldpFFpO6M9GWTAr3at4a/xcErUyJPBpvusF48zo=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=lWE35Nc7PQRgp9sFhtBLwpXmLt/z1Y5IGYbGqAj4uPD9R+/4vF6fd1TLpbs/fvfGQ
         ocSRW/PEW0hcMvMp0mILhrj1rqHo8itV7zgTktOyESv5TYqhX5tlFozV83r8bChfRH
         rlKlMIXIPx/gNHIyE7Unpse7fME9vIXeNr5NeXAo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBA95LkA024745
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 03:05:21 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 03:05:21 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 03:05:21 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBA95IFB030643;
        Mon, 10 Dec 2018 03:05:18 -0600
Subject: Re: [PATCH 2/3] dt-bindings: usb: keystone-usb: Add ti,am654-dwc3
 support
To:     Vignesh R <vigneshr@ti.com>
References: <1544023171-5796-1-git-send-email-rogerq@ti.com>
 <1544023171-5796-3-git-send-email-rogerq@ti.com>
 <ec72e316-46c1-69f6-ae5b-0fbf297a9327@ti.com>
CC:     <balbi@kernel.org>, <tony@atomide.com>, <robh+dt@kernel.org>,
        <nsekhar@ti.com>, <t-kristo@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C0E2C4E.7030302@ti.com>
Date:   Mon, 10 Dec 2018 11:05:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <ec72e316-46c1-69f6-ae5b-0fbf297a9327@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 06/12/18 12:32, Vignesh R wrote:
> Hi Roger,
> 
> On 05/12/18 8:49 PM, Roger Quadros wrote:
>> The AM654 SoC from TI contains a DWC3 controller. Add
>> support for it.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  Documentation/devicetree/bindings/usb/keystone-usb.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
>> index f96e09f..fa29ff8 100644
>> --- a/Documentation/devicetree/bindings/usb/keystone-usb.txt
>> +++ b/Documentation/devicetree/bindings/usb/keystone-usb.txt
>> @@ -3,7 +3,7 @@ TI Keystone Soc USB Controller
>>  DWC3 GLUE
>>  
>>  Required properties:
>> - - compatible: should be "ti,keystone-dwc3".
>> + - compatible: should be "ti,keystone-dwc3" or "ti,am654-dwc3".
> 
> Convention is to have one compatible per line:
>  compatible: Should be
> 	"ti,am654-dwc3" for AM654 SoCs
> 	"ti,keystone-dwc3" for K2 SoCs
> 

OK. Will fix it up. Thanks.

cheers,
-roger

> 
> 
>>   - #address-cells, #size-cells : should be '1' if the device has sub-nodes
>>     with 'reg' property.
>>   - reg : Address and length of the register set for the USB subsystem on
>> @@ -21,7 +21,7 @@ SoCs only:
>>  - clock-names:		Must be "usb".
>>  
>>  
>> -The following are mandatory properties for Keystone 2 66AK2G SoCs only:
>> +The following are mandatory properties for 66AK2G and AM654:
>>  
>>  - power-domains:	Should contain a phandle to a PM domain provider node
>>  			and an args specifier containing the USB device id
>>
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
