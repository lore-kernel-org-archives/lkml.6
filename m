Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB43BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0E620825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0E620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeKJAzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:55:24 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56330 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKJAzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:55:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA9FECWH124133;
        Fri, 9 Nov 2018 09:14:12 -0600
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA9FECUX061561
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Nov 2018 09:14:12 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 9 Nov
 2018 09:14:12 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 9 Nov 2018 09:14:12 -0600
Received: from [172.22.160.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA9FEBcb024063;
        Fri, 9 Nov 2018 09:14:12 -0600
Subject: Re: [RFC PATCH 1/3] can: m_can: Create m_can core to leverage common
 code
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181010142055.25271-1-dmurphy@ti.com>
 <20181010142055.25271-2-dmurphy@ti.com>
 <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
 <349ef8be-f4c7-25cc-2c33-7ce1fd0b0f40@ti.com>
 <9003a544-83cf-7dce-7f14-4abd292d470e@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <6bd6596d-bdcb-512d-dc6c-0e4309c39a66@ti.com>
Date:   Fri, 9 Nov 2018 09:14:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9003a544-83cf-7dce-7f14-4abd292d470e@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 11/03/2018 05:45 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> Am 31.10.2018 um 21:15 schrieb Dan Murphy:
>> Wolfgang
>>
>> Thanks for the review
>>
>> On 10/27/2018 09:19 AM, Wolfgang Grandegger wrote:
>>> Hello Dan,
>>>
>>> for the RFC, could you please just do the necessary changes to the
>>> existing code. We can discuss about better names, etc. later. For
>>> the review if the common code I quickly did:
>>>
>>>   mv m_can.c m_can_platform.c
>>>   mv m_can_core.c m_can.c
>>>
>>> The file names are similar to what we have for the C_CAN driver.
>>>
>>>   s/classdev/priv/
>>>   variable name s/m_can_dev/priv/
>>>
>>> Then your patch 1/3 looks as shown below. I'm going to comment on that
>>> one. The comments start with "***"....
>>>
>>
>> So you would like me to align the names with the c_can driver?
> 
> That would be the obvious choice.
>> <snip>
>>>
>>> *** I didn't review the rest of the patch for now.
>>>
>>
>> snipped the code to reply to the comment.
>>
>>> Looking to the generic code, you didn't really change the way
>>> the driver is accessing the registers. Also the interrupt handling
>>> and rx polling is as it was before. Does that work properly using
>>> the SPI interface of the TCAN4x5x?
>>
>> I don't want to change any of that yet.  Maybe my cover letter was not clear
>> or did not go through.
>>
>> But the intention was just to break out the functionality to create a MCAN framework
>> that can be used by devices that contain the Bosch MCAN core and provider their own protocal to access
>> the registers in the device.
>>
>> I don't want to do any functional changes at this time on the IP code itself until we have a framework.
>> There should be no regression in the io mapped code.
>>
>> I did comment on the interrupt handling and asked if a threaded work queue would affect CAN timing.
>> For the original TCAN driver this was the way it was implemented.
> 
> Do threaded interrupts with RX polling make sense? I think we need a
> common interface allowing to select hard-irqs+napi or threaded-irqs.
> 

Sorry for the late reply I have been dealing with personal issues.

I guess it would only make sense if the IRQ was edge trigger and not level.

If the message is being processed and the interrupt is not cleared until later the
device may produce another interrupt which may be missed by the processor for external
devices.  Or when coming out of suspend the edge may be missed.

Otherwise if it was a level only then they do not make sense to support both and having to
be able to select between the two would be good.

Dan

> Wolfgang.
> 


-- 
------------------
Dan Murphy
