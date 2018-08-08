Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B393C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B835021AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="osI+jcPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B835021AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbeHIAGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:06:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50092 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIAGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:06:54 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w78LjGjq074557;
        Wed, 8 Aug 2018 16:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533764716;
        bh=WTpiGoDMbl5acxWXHJos4prk0vD2ckWe2dHXIMecMs4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=osI+jcPi/8qC7FWWKJhPsMQf9ZdD5nYSF7pWpadSDQAZ7MVIiU9uWHtCor/WDo01g
         oAOl5KBhTvQLqZd9x7Gysbkpa7+eIksTQVm0OY5k7fgpcNlVjAt2PIQmNGdWjgmJ1+
         19F6jG4V/pyLguwb5hCC6D6Tsq8yBPvZWX20l/Jo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78LjGiU002367;
        Wed, 8 Aug 2018 16:45:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 8 Aug
 2018 16:45:15 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 8 Aug 2018 16:45:15 -0500
Received: from [172.22.156.167] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78LjFB4025927;
        Wed, 8 Aug 2018 16:45:15 -0500
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd> <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd> <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
 <53691469-4554-42a8-c182-762c1a3939b7@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <01bbf05a-8e5e-d3ce-857a-ac5c6efb779c@ti.com>
Date:   Wed, 8 Aug 2018 16:45:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <53691469-4554-42a8-c182-762c1a3939b7@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 08/08/2018 04:09 PM, Jacek Anaszewski wrote:
> Hi Dan,
> 
> On 08/08/2018 11:04 PM, Dan Murphy wrote:
>> On 08/08/2018 04:02 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>> +	- #size-cells : 0
>>>>>> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
>>>>>> +		0 - All HVLED outputs are controlled by bank A
>>>>>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
>>>>>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
>>>>>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
>>>>>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
>>>>>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
>>>>>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
>>>>>> +		7 - All HVLED outputs are controlled by bank B
>>>>>
>>>>> This is quite long way to describe a bitmask, no? Could we make
>>>>> it so that control-bank-cfg is not needed?
>>>>
>>>> The problem we have here is there is a potential to control
>>>> 3 different LED string but only 2 sinks.  So control bank A can control 2 LED strings and control
>>>> bank b can control 1 LED string.  
>>>>
>>>
>>> Can we forget about the LED strings, and just expose the sinks as
>>> Linux LED devices?
>>
>> 2 sinks 3 LED strings.  How do you know which LED string is which and what bank it belongs
>> to when setting the brightness.  Each Bank has a separate register for brightness control.
> 
> Just a blind shot, without going into details - could you please check
> if led-sources property documented in the common LED bindings couldn't
> help here?
> 

I could change the name to led-sources.  But this part does not really follow the 1 output to a
1 LED string topology.


-- 
------------------
Dan Murphy
