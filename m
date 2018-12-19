Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B114218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zIz4Ye0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbeLSTlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:41:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45352 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeLSTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:41:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJJfJdl004408;
        Wed, 19 Dec 2018 13:41:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545248479;
        bh=wLJHdbFKM+2c0Z8VasTKP88D8xTDi2KsLMQ7xc3c+LI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zIz4Ye0YjGC7rbNSzRKcSyBVsu0cVusQGccCJpEdMaxMzMyuP+BWyKI+E9MfjZEME
         wWVATWFMKmMX14wIt3Z3vin0FEKGYIWcqYMejtlJfxnFldJtx6ZJJW9dEwcGICuMUP
         D1z2qoixbfjsyjKpjAyGJ3zw1vWnW0b9B5tNAYQ8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJJfJYm094780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 13:41:19 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 13:41:19 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 13:41:19 -0600
Received: from [172.22.106.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJJfJLq019272;
        Wed, 19 Dec 2018 13:41:19 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
Date:   Wed, 19 Dec 2018 13:41:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181219193455.GA21159@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for the review.

On 12/19/2018 01:34 PM, Pavel Machek wrote:
> Hi!
> 
>> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
>> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
>> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
>> +
>> +static struct attribute *lp5024_ctrl_bank_attrs[] = {
>> +	&dev_attr_ctrl_bank_a_mix.attr,
>> +	&dev_attr_ctrl_bank_b_mix.attr,
>> +	&dev_attr_ctrl_bank_c_mix.attr,
>> +	NULL
>> +};
>> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
> 
> ...
>> +
>> +static DEVICE_ATTR_WO(led1_mix);
>> +static DEVICE_ATTR_WO(led2_mix);
>> +static DEVICE_ATTR_WO(led3_mix);
>> +
>> +static struct attribute *lp5024_led_independent_attrs[] = {
>> +	&dev_attr_led1_mix.attr,
>> +	&dev_attr_led2_mix.attr,
>> +	&dev_attr_led3_mix.attr,
>> +	NULL
>> +};
>> +ATTRIBUTE_GROUPS(lp5024_led_independent);
> 
> Ok, so you are adding new sysfs files. Are they _really_ neccessary?
> We'd like to have uniform interfaces for the leds.

Yes I am adding these for this driver.
They adjust the individual brightness of each LED connected (what the HW guys called mixing).

The standard brightness sysfs adjusts all 3 LEDs simultaneously so that all 3 LEDs brightness are
uniform.

I did not think these belonged in the dt as they should be user space configurable

> 
> If they are neccessary, we need documentation for them.

Sure I have no problem documenting them but where do I do that?
I am assuming Documentation/leds/leds-lp5024.txt

This looks to be where Milo did this before.

Dan

> 
> Thanks,
> 									Pavel
> 


-- 
------------------
Dan Murphy
