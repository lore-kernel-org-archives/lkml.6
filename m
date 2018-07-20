Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F54CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E3020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Apk/gl20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E3020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeGTLVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:21:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59646 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeGTLVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:21:14 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6KAXNfv013932;
        Fri, 20 Jul 2018 05:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532082804;
        bh=jpuVWm2ZSlJkfuD+lpF7czFQD6EGGKPcpMbShz06U8g=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=Apk/gl20kCHqVbV+7nJUHYF0WJSAuZBOC/YCznLZr316HG2kYqQWYdpu9LV56wgqq
         vRDShoP/0IRbt0Vb1J834vEomD8gZ4BuFnMjmokxIGK03O8t1foYQkU1KlhEt/QF/x
         n98+aOr3wkf0ORZufREGuMz5p2suHZ5aXIGOw6z0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6KAXNwb007500;
        Fri, 20 Jul 2018 05:33:23 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 20
 Jul 2018 05:33:23 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 20 Jul 2018 05:33:23 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6KAXKsB019501;
        Fri, 20 Jul 2018 05:33:21 -0500
Subject: Re: [PATCH v4 1/4] rtc: omap: Cut down the shutdown time from 2
 seconds to 1 sec
From:   Keerthy <j-keerthy@ti.com>
To:     Johan Hovold <johan@kernel.org>
CC:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <t-kristo@ti.com>, <linux-rtc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-2-git-send-email-j-keerthy@ti.com>
 <20180719100229.GQ10204@localhost>
 <ed335c7a-f079-082d-d572-93632087fd8f@ti.com>
 <a6930aca-f475-5b53-ce9d-d45fbc75d69c@ti.com>
 <20180719123617.GV10204@localhost>
 <e3841afa-fe18-84c0-e5b6-520365c5e4a1@ti.com>
Message-ID: <28f0d002-f05e-b4dc-f0dd-d0bc0fc5616d@ti.com>
Date:   Fri, 20 Jul 2018 16:03:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <e3841afa-fe18-84c0-e5b6-520365c5e4a1@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 19 July 2018 06:16 PM, Keerthy wrote:
> 
> 
> On Thursday 19 July 2018 06:06 PM, Johan Hovold wrote:
>> On Thu, Jul 19, 2018 at 05:52:17PM +0530, Keerthy wrote:
>>> On Thursday 19 July 2018 05:23 PM, Keerthy wrote:
>>>> On Thursday 19 July 2018 03:32 PM, Johan Hovold wrote:
>>>>> On Thu, Jul 12, 2018 at 10:37:37AM +0530, Keerthy wrote:
>>
>>>>>> @@ -470,6 +476,9 @@ static void omap_rtc_power_off(void)
>>>>>>  	val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>>>>>>  	rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>>>>>>  			val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
>>
>>>>>> +	/* Our calculations started right before the rollover, try again */
>>
>>>>>> +	if (seconds != rtc_read(omap_rtc_power_off_rtc, OMAP_RTC_SECONDS_REG))
>>>>>> +		goto again;
>>>>>
>>>>> Here the alarm may have gone off as part of the roll over, in which case
>>>>> you shouldn't retry.
>>>>
>>>> Ex: We programmed at Sec = 2 and we expect ALARM2 to fire at sec = 3.
>>>>
>>>> In the event of Roll over before setting the
>>>> OMAP_RTC_INTERRUPTS_IT_ALARM2 bit in the OMAP_RTC_INTERRUPTS_REG will we
>>>> not miss the ALARM2 event? Then poweroff would fail right?
>>
>> Right, that would fail.
>>
>>>> Hence the attempt to retry the next second. This sequence would begin
>>>> right at the beginning of a new second and we expect the full sequence
>>>> to get over without having to retry again.
>>>>
>>>> Hope i am clear.
>>
>> Yes, sure, but my point is that could end up retrying also after the
>> alarm has fired correctly (e.g. due to latencies in turning of the
>> power)>
>> It may be enough to check OMAP_RTC_STATUS_REG before retrying.

On a second thought. Status gets set only after the next second.

if ALARM2 status bit is set that surely means interrupt has fired but if
it is not set then there are 2 possibilities

1) ALARM2 is missed as the roll over happened
2) ALARM2 yet to fire as we are yet to get to the next second.

On the other hand Seconds gives me clear indication if we missed the
interrupt or we are about to get one.

> 
> Ah okay. Yes this makes sense. I will use the status to retry.
> 
>>
>>> I tried to program the interrupt for the same second on the hardware and
>>> it does not fire. So to take care of roll over corner case one attempt
>>> to retry is needed.
>>
>> Yes, that's expected.
>>
>> Thanks,
>> Johan
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
