Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D95C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0E320867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BrkG6vvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0E320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeIDSA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:00:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47252 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIDSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:00:56 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84DZAPl060488;
        Tue, 4 Sep 2018 08:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536068110;
        bh=lTFsv033/Pj6kDK5Y6SBWeGfKE8+w9AQ85oNdbUovRc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BrkG6vvd69V80mmEWVwNsl+dNfbamlCdtmbg8KYnkd43FxwL+IKuGC6DaibB2tRAA
         XR00DQeCv8DfkL+MhmkC2J4YhcpyIgF0x/nysUIVGDj4+nu9KkYXCsZQ3NuJlm6BQR
         nNnoRZrVfvEgWtmMmq91EFuBVuCGLBbgLR6SfBqM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84DZAkp027803;
        Tue, 4 Sep 2018 08:35:10 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 08:35:09 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 08:35:09 -0500
Received: from [172.22.184.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84DZ9oF008453;
        Tue, 4 Sep 2018 08:35:09 -0500
Subject: Re: [PATCH 1/2] ARM: dts: imx6: RDU2: Fix the audio CODEC's reset pin
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180831191732.25504-1-afd@ti.com> <20180903045426.GM3850@dragon>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <5796c470-a533-c010-ba53-7ee785a3b9e8@ti.com>
Date:   Tue, 4 Sep 2018 08:35:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903045426.GM3850@dragon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 11:54 PM, Shawn Guo wrote:
> On Fri, Aug 31, 2018 at 02:17:31PM -0500, Andrew F. Davis wrote:
>> The correct DT property for specifying a GPIO used for reset
>> is "reset-gpios", fix this here.
>>
>> Fixes: d763762e3b58 ("ARM: dts: imx6: add ZII RDU2 boards")
> 
> This Fixes tag and word 'Fix' in subject is inappropriate to me, as you
> are not fixing something wrong from the beginning, but actually
> replacing a deprecated property with new one.
> 


reset-gpios was standard before this driver got it backwards, but it
also wasn't required to be one way or the other as far as I can tell, so
I can see your point that this isn't technically "broken". I have no
preference, so I'll change the subject and drop the fixes for v2.

Andrew


> Shawn
> 
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
>> index 7fff3717cf7c..a0f5cfda0055 100644
>> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
>> @@ -384,7 +384,7 @@
>>  		AVDD-supply = <&reg_3p3v>;
>>  		IOVDD-supply = <&reg_3p3v>;
>>  		DVDD-supply = <&vgen4_reg>;
>> -		gpio-reset = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>> +		reset-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
>>  	};
>>  
>>  	accel@1c {
>> @@ -572,7 +572,7 @@
>>  		AVDD-supply = <&reg_3p3v>;
>>  		IOVDD-supply = <&reg_3p3v>;
>>  		DVDD-supply = <&vgen4_reg>;
>> -		gpio-reset = <&gpio1 0 GPIO_ACTIVE_HIGH>;
>> +		reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>>  	};
>>  
>>  	touchscreen@20 {
>> -- 
>> 2.18.0
>>
