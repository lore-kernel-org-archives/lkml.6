Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC492C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7105C20857
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AqwL68ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7105C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754432AbeGIJgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:36:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43658 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeGIJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:36:33 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w699a3xX015427;
        Mon, 9 Jul 2018 04:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531128963;
        bh=9S0IHSfAi26vRVLphua35eeqV3P1420mIvxziQENfLg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AqwL68efdmEJi6/fZxwt/O+f4B7vrrOEMsrt52dfbslmSBSQGNrrzKDUA+B156Daj
         Nbtsyduxz5eKMCL6vnk+/WRB6puOb+lGvqFlPv8n1Y+kyi81fZXvQ2K2phBYGGhlLP
         B15MXR8T9akZv68HTCyB+zwTQcw1uDVoSEpArUOU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w699a2Dg006872;
        Mon, 9 Jul 2018 04:36:03 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 9 Jul
 2018 04:36:02 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 9 Jul 2018 04:36:02 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w699Zx36015955;
        Mon, 9 Jul 2018 04:36:00 -0500
Subject: Re: [PATCH v2] rtc: OMAP: Add support for rtc-only mode
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Johan Hovold <johan@kernel.org>
CC:     <a.zummo@towertech.it>, <t-kristo@ti.com>,
        <linux-rtc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1531116709-20135-1-git-send-email-j-keerthy@ti.com>
 <20180709075553.GA3633@localhost> <20180709092952.GF16084@piout.net>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <9717549d-29ac-14b9-b8f5-6b39fbbd74e7@ti.com>
Date:   Mon, 9 Jul 2018 15:05:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180709092952.GF16084@piout.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 09 July 2018 02:59 PM, Alexandre Belloni wrote:
> On 09/07/2018 09:55:53+0200, Johan Hovold wrote:
>> On Mon, Jul 09, 2018 at 11:41:49AM +0530, Keerthy wrote:
>>> Prepare rtc driver for rtc-only with DDR in self-refresh mode.
>>> omap_rtc_power_off now should cater to two features:
>>>
>>> 1) RTC plus DDR in self-refresh is power a saving mode where in the
>>> entire system including the different voltage rails from PMIC are
>>> shutdown except the ones feeding on to RTC and DDR. DDR is kept in
>>> self-refresh hence the contents are preserved. RTC ALARM2 is connected
>>> to PMIC_EN line once we the ALARM2 is triggered we enter the mode with
>>> DDR in self-refresh and RTC Ticking. After a predetermined time an RTC
>>> ALARM1 triggers waking up the system[1]. The control goes to bootloader.
>>> The bootloader then checks RTC scratchpad registers to confirm it was an
>>> rtc_only wakeup and follows a different path, configure bare minimal
>>> clocks for ddr and then jumps to the resume address in another RTC
>>> scratchpad registers and transfers the control to Kernel. Kernel then
>>> restores the saved context. omap_rtc_power_off_program does the ALARM2
>>> programming part.
>>>
>>>      [1] http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf Page 2884
>>>
>>> 2) Power-off: This is usual poweroff mode. omap_rtc_power_off calls the
>>> above omap_rtc_power_off_program function and in addition to that
>>> programs the OMAP_RTC_PMIC_REG for any external wake ups for PMIC like
>>> the pushbutton and shuts off the PMIC.
>>>
>>> Hence the split in omap_rtc_power_off.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> ---
>>>
>>> Changes in v2:
>>>
>>>   * Add details in the commit log.
>>>   * Use of_device_is_system_power_controller to check if rtc node is
>>>     indeed the system power control instead of manually reading property.
>>>
>>>  drivers/rtc/interface.c |  12 ++++
>>>  drivers/rtc/rtc-omap.c  | 167 +++++++++++++++++++++++++++++++++---------------
>>>  include/linux/rtc.h     |   2 +
>>>  3 files changed, 131 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
>>> index 6d4012d..d8b70f0 100644
>>> --- a/drivers/rtc/interface.c
>>> +++ b/drivers/rtc/interface.c
>>> @@ -1139,3 +1139,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
>>>  	trace_rtc_set_offset(offset, ret);
>>>  	return ret;
>>>  }
>>> +
>>> +/**
>>> + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
>>> + * line and can be used to power off the SoC.
>>> + *
>>> + * Kernel interface to program rtc to power off
>>> + */
>>> +void rtc_power_off_program(struct rtc_device *rtc)
>>> +{
>>> +	rtc->ops->power_off_program(rtc->dev.parent);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rtc_power_off_program);
>>
>> We typically do not add new interfaces without any users, so this will
>> probably have to go in along with the corresponding omap changes for
>> rtc-only mode.
>>
> 
> I'm probably not smart enough but I still don't get why you need to add
> an interface at all, especially one that will result in a NULL pointer
> dereference on 99.6% of the drivers.
> 
> This is so specific to your use case that this has zero chance to be
> reused by another driver.

Alexandre,

So are you suggesting use an EXPORT API from omap-rtc driver alone?
as it is too specific to one use case?

- Keerthy
> 
