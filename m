Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A1DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54172170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f8Go6/5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54172170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeI1LtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:49:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36766 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1LtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:49:05 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8S5QS4Q082419;
        Fri, 28 Sep 2018 00:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538112388;
        bh=2SK59Fm7J4tWTYyJ9580x17q0j5NjdzlB/V1FN1xZSQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=f8Go6/5v7Z8T748kZt148Bp2xum2hcrWnsNg6VCMpzEWnzLqv0ULIse3ucz7XaYBP
         fPIGru3Q+Eh58KYEMwulmcc3AUH7tG6pvvoYVz/SSyFMtpIdof0FONaVTqvrk+Wxcs
         BxMPeWPuuhC7ZgWjlZOduvIgp2dIixTvt0Mtaseg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S5QSle015055;
        Fri, 28 Sep 2018 00:26:28 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 00:26:28 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 00:26:27 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S5QNnI007219;
        Fri, 28 Sep 2018 00:26:24 -0500
Subject: Re: [PATCH 1/2] dt-bindings: i2c-omap: Add new compatible for AM654
 SoCs
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     "Nori, Sekhar" <nsekhar@ti.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Menon, Nishanth" <nm@ti.com>, "Kristo, Tero" <t-kristo@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180926115751.20421-1-vigneshr@ti.com>
 <20180926115751.20421-2-vigneshr@ti.com>
 <c3421929-1c40-513a-5c14-73e132a11d0f@axentia.se>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <3943f2b1-3850-ad1e-6318-cfaec0eff485@ti.com>
Date:   Fri, 28 Sep 2018 10:57:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c3421929-1c40-513a-5c14-73e132a11d0f@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 26 September 2018 08:14 PM, Peter Rosin wrote:
> On 2018-09-26 13:57, Vignesh R wrote:
>> AM654 SoCs have similar I2C IP as OMAP SoCs. Add new compatible to
>> handle AM654 SoCs.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
>> index 7e49839d4124..11ce869d682d 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
>> @@ -2,7 +2,8 @@ I2C for OMAP platforms
>>  
>>  Required properties :
>>  - compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
>> -  or "ti,omap4-i2c"
>> +  or "ti,omap4-i2c" for OMAP2+ SoCs
>> +- compatible : Must "ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
>                       ^
>                      be
> 
> Also, it looks bad with two 'compatible' entries in the properties list.
> I think the trend is to list one valid compatible (plus fallbacks)
> per line. So, you should consider reformatting, possibly like so:
> 
> - compatible : Must be one of
> 	"ti,omap2420-i2c"
> 	"ti,omap2430-i2c"
> 	"ti,omap3-i2c"
>         "ti,omap4-i2c"
> 	"ti,am654-i2c", "ti,omap4-i2c"
> 

I have sent v2 with these changes. Thanks for the review!


-- 
Regards
Vignesh
