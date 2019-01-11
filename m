Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C615020872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfAKI1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:27:16 -0500
Received: from mailproxy07.manitu.net ([217.11.48.71]:38260 "EHLO
        mailproxy07.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfAKI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:27:15 -0500
Received: from [192.168.178.20] (aftr-88-217-180-208.dynamic.mnet-online.de [88.217.180.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id 3D092C8155;
        Fri, 11 Jan 2019 09:30:25 +0100 (CET)
Subject: Re: [RFC PATCH 1/3] can: m_can: Create m_can core to leverage common
 code
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181010142055.25271-1-dmurphy@ti.com>
 <20181010142055.25271-2-dmurphy@ti.com>
 <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
 <349ef8be-f4c7-25cc-2c33-7ce1fd0b0f40@ti.com>
 <9003a544-83cf-7dce-7f14-4abd292d470e@grandegger.com>
 <b73e200c-8a6b-00e0-dabc-af3245cc36fd@ti.com>
 <69d3a046-2d55-06e0-fba7-c9a0d20e6daa@grandegger.com>
 <06e0146a-5f96-5f60-1ab3-be21b854932a@ti.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <ed8717c2-5de3-a9f5-57c4-093496a0d5f1@grandegger.com>
Date:   Fri, 11 Jan 2019 09:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <06e0146a-5f96-5f60-1ab3-be21b854932a@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

Am 10.01.19 um 13:53 schrieb Dan Murphy:
> Wolfgang
> 
> On 1/10/19 1:44 AM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> sorry for my late response on that topic...
>>
>> Am 09.01.19 um 21:58 schrieb Dan Murphy:
>>> Wolfgang
>>>
>>> On 11/3/18 5:45 AM, Wolfgang Grandegger wrote:
>>>> Hello Dan,
>>>>
>>>> Am 31.10.2018 um 21:15 schrieb Dan Murphy:
>>>>> Wolfgang
>>>>>
>>>>> Thanks for the review
>>>>>
>>>>> On 10/27/2018 09:19 AM, Wolfgang Grandegger wrote:
>>>>>> Hello Dan,
>>>>>>
>>>>>> for the RFC, could you please just do the necessary changes to the
>>>>>> existing code. We can discuss about better names, etc. later. For
>>>>>> the review if the common code I quickly did:
>>>>>>
>>>>>>   mv m_can.c m_can_platform.c
>>>>>>   mv m_can_core.c m_can.c
>>>>>>
>>>>>> The file names are similar to what we have for the C_CAN driver.
>>>>>>
>>>>>>   s/classdev/priv/
>>>>>>   variable name s/m_can_dev/priv/
>>>>>>
>>>>>> Then your patch 1/3 looks as shown below. I'm going to comment on that
>>>>>> one. The comments start with "***"....
>>>>>>
>>>>>
>>>>> So you would like me to align the names with the c_can driver?
>>>>
>>>> That would be the obvious choice.
>>>>> <snip>
>>>>>>
>>>>>> *** I didn't review the rest of the patch for now.
>>>>>>
>>>>>
>>>>> snipped the code to reply to the comment.
>>>>>
>>>>>> Looking to the generic code, you didn't really change the way
>>>>>> the driver is accessing the registers. Also the interrupt handling
>>>>>> and rx polling is as it was before. Does that work properly using
>>>>>> the SPI interface of the TCAN4x5x?
>>>>>
>>>>> I don't want to change any of that yet.  Maybe my cover letter was not clear
>>>>> or did not go through.
>>>>>
>>>>> But the intention was just to break out the functionality to create a MCAN framework
>>>>> that can be used by devices that contain the Bosch MCAN core and provider their own protocal to access
>>>>> the registers in the device.
>>>>>
>>>>> I don't want to do any functional changes at this time on the IP code itself until we have a framework.
>>>>> There should be no regression in the io mapped code.
>>>>>
>>>>> I did comment on the interrupt handling and asked if a threaded work queue would affect CAN timing.
>>>>> For the original TCAN driver this was the way it was implemented.
>>>>
>>>> Do threaded interrupts with RX polling make sense? I think we need a
>>>> common interface allowing to select hard-irqs+napi or threaded-irqs.
>>>>
>>>
>>> I have been working on this code for about a month now and I am *not happy* with the amount of change that needs
>>> to be done to make the m_can a framework.
>>>
>>> I can tx/rx frames from another CAN device to the TCAN part but I have not even touched the iomapped code.
>>>
>>> The challenging part is that the m_can code that is currently available does not have to worry about atomic context because
>>> there is no peripheral waiting.  Since the TCAN is a peripheral device we need to take into about the hard waits in IRQ context
>>> as well as the atomic context.  Doing this creates many deltas in the base code that may break iomapped devices.  I have had to 
>>> add the thread_irqs and now I am in the midst of the issue you brought up with napi.  I would have to schedule a queue for perp devices
>>> and leave the non-threaded iomapped irq.
>>>
>>> At this point I think it may be wise to leave the m_can code alone as it is working and stable and just work on the TCAN driver as
>>> a standalone driver.  A framework would be nice but I think it would destablize the m_can driver which is embedded in many SoC's and
>>> we cannot possibly test everyone of them.
>>
>> Unfortunately, I do not have m_can hardware at hand.
>>
>>> What are your thoughts?
>>
>> What we need is a common set of functions doing tx, rx, error and state
>> handling. This will requires substantial changes to the existing
>> io-mapped m_can driver, of course. I still believe it's worth the
>> effort, but I agree that it's difficult for you to re-write and test the
>> existing m_can driver.
> 
> OK I will keep working on it.  What you are describing is what I have done.
> I have abstracted the register reads and writes away and I am in the process
> of abstracting away the device specific initialization.

Would be nice if you could show your current implementation...

>>
>> What about implementing such a set of common functions plus the SPI
>> specific part for your TCAN device. What do you/others think?
> 
> As stated above this is what I have.  But the m_can driver was written for io-mapped that has no delays
> so we need to take into about peripheral wait time in IRQ and atomic context.
> 
> This is where the issues are stemming from mainly in the atomic context.

... to understand a bit better what you exactly mean. Or does the last
patch you sent already highlight them.

Wolfgang.
