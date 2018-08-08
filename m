Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D536C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CAC2150B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tvurLqsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CAC2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbeHHX0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:26:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54084 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbeHHX0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:26:25 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w78L4rea032467;
        Wed, 8 Aug 2018 16:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533762293;
        bh=S63YeLvOVlPJ/L98dG6Yo4ej5pw+KXP3fFYnuQjgyic=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tvurLqsR4jR4kp32kUCTy2Xe0NgiKXEPeiV5tljhURjUIr2/tgKJxVk/EIhB8Jg6p
         ka8zVmqPaxsIJVZKPxdQo4Jgk0PSCIqteceonZX1/Y1zmxMkLkDsSSkxKQAKvhKtn7
         gU3BvMG+bel7EoQm3ji51mk2QaB5bkB9Rwb0+6Mw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78L4rhQ024941;
        Wed, 8 Aug 2018 16:04:53 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 8 Aug
 2018 16:04:53 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 8 Aug 2018 16:04:53 -0500
Received: from [172.22.156.167] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78L4qPX002916;
        Wed, 8 Aug 2018 16:04:52 -0500
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd> <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
 <20180808210215.GA15831@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f18a5616-bb25-da0d-aec8-585e042b4919@ti.com>
Date:   Wed, 8 Aug 2018 16:04:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808210215.GA15831@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 04:02 PM, Pavel Machek wrote:
> Hi!
> 
>>>> +	- #size-cells : 0
>>>> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
>>>> +		0 - All HVLED outputs are controlled by bank A
>>>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
>>>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
>>>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
>>>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
>>>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
>>>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
>>>> +		7 - All HVLED outputs are controlled by bank B
>>>
>>> This is quite long way to describe a bitmask, no? Could we make
>>> it so that control-bank-cfg is not needed?
>>
>> The problem we have here is there is a potential to control
>> 3 different LED string but only 2 sinks.  So control bank A can control 2 LED strings and control
>> bank b can control 1 LED string.  
>>
> 
> Can we forget about the LED strings, and just expose the sinks as
> Linux LED devices?

2 sinks 3 LED strings.  How do you know which LED string is which and what bank it belongs
to when setting the brightness.  Each Bank has a separate register for brightness control.

Dan

> 									Pavel
> 


-- 
------------------
Dan Murphy
