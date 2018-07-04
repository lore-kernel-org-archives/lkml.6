Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2558924491
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HBQS13a9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pKmpx+kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2558924491
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeGDNg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:36:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbeGDNgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:36:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF15F60B25; Wed,  4 Jul 2018 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530711383;
        bh=PJvSZIKBke47jDRus7Sqnpf/tOkSr8kOWGNOafTlk4I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HBQS13a9EDIJDmuGJeBVjQ4ab0XVnWjP7iLgQrwYc3sC9bUdeTAPv84zx3IaYCUXU
         EPKLKPDbkSmzMSmgIkNSg60P08NC1ScUXtSJiJGcxxG+ad7nu3dIXs6gP064yXGCfB
         /vsU5nflAH1JIZLBOtQNQ7/wdCoioW6o4UgZEO1c=
Received: from [10.206.24.162] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94BF86031A;
        Wed,  4 Jul 2018 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530711382;
        bh=PJvSZIKBke47jDRus7Sqnpf/tOkSr8kOWGNOafTlk4I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pKmpx+kxwCDgXeivJxqnyAQNrnMd8vOxPLMJeqnTXO6G62TE898ipfd/YjiR6wleu
         9SNTQqpOG8jkK+EmhQtzaV8P01Q0/sNzR6ol+cJsi/W5A7/wumbKTdlqykiuVyWmGh
         nZ5rkhyi1y85FDCsIHfiXDP1CR9hRLIPOqDiErPw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94BF86031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
To:     Rob Herring <robh@kernel.org>
Cc:     Subhash Jadavani <subhashj@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        asutoshd@codeaurora.org, Evan Green <evgreen@chromium.org>,
        linux-scsi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
 <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
 <20180612192636.GA31725@rob-hp-laptop>
 <000101d403d3$87210d20$95632760$@codeaurora.org>
 <CAL_JsqLsdEGEjPo8yh5dGoGWTes41QxUiJ4NN0Q9qsgLBaTpjw@mail.gmail.com>
 <002401d4093d$256fdc90$704f95b0$@codeaurora.org>
 <CAL_JsqJUBQ2d1mV8ep_h3iZ-ka73ZGEJ3kZ8VkJmb8gDd_R7Sw@mail.gmail.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <4d8c8171-2ead-8953-afce-a30f260cf9c9@codeaurora.org>
Date:   Wed, 4 Jul 2018 19:06:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJUBQ2d1mV8ep_h3iZ-ka73ZGEJ3kZ8VkJmb8gDd_R7Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/2018 11:34 PM, Rob Herring wrote:
> On Thu, Jun 21, 2018 at 2:52 AM sayali <sayalil@codeaurora.org> wrote:
>> Hi Rob,
>>
>> Please check my comment inline.
> As mentioned in the back and forth comments previously in this thread,
> please fix your email client (hint: you can't use Outlook) and
> properly quote your replies (i.e. the leading ">")
I have started using Thunderbird now. Hope you can see my replies 
correctly this time.
>
>> Thanks,
>> Sayali
>> -----Original Message-----
>> From: Rob Herring [mailto:robh@kernel.org]
>> Sent: Thursday, June 14, 2018 7:59 PM
>> To: sayali <sayalil@codeaurora.org>
>> Cc: Subhash Jadavani <subhashj@codeaurora.org>; Can Guo <cang@codeaurora.org>; Vivek Gautam <vivek.gautam@codeaurora.org>; Rajendra Nayak <rnayak@codeaurora.org>; Vinayak Holikatti <vinholikatti@gmail.com>; James E.J. Bottomley <jejb@linux.vnet.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>; asutoshd@codeaurora.org; Evan Green <evgreen@chromium.org>; linux-scsi@vger.kernel.org; Mark Rutland <mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>; open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
>>
>> On Thu, Jun 14, 2018 at 5:33 AM, sayali <sayalil@codeaurora.org> wrote:
>>> Comment inline.
>>>
>>> Thanks,
>>> Sayali
>>> -----Original Message-----
>>> From: Rob Herring [mailto:robh@kernel.org]
>>> Sent: Wednesday, June 13, 2018 12:57 AM
>>> To: Sayali Lokhande <sayalil@codeaurora.org>
>>> Cc: subhashj@codeaurora.org; cang@codeaurora.org;
>>> vivek.gautam@codeaurora.org; rnayak@codeaurora.org;
>>> vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
>>> martin.petersen@oracle.com; asutoshd@codeaurora.org;
>>> evgreen@chromium.org; linux-scsi@vger.kernel.org; Mark Rutland
>>> <mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>; open
>>> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
>>> <devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>>> Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock
>>> setting
>>>
>>> On Fri, Jun 08, 2018 at 04:36:28PM +0530, Sayali Lokhande wrote:
>>>> From: Subhash Jadavani <subhashj@codeaurora.org>
>>>>
>>>> UFS host supplies the reference clock to UFS device and UFS device
>>>> specification allows host to provide one of the 4 frequencies (19.2
>>>> MHz,
>>>> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
>>>> device reference clock frequency setting in the device based on what
>>>> frequency it is supplying to UFS device.
>>>>
>>>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>>>> Signed-off-by: Can Guo <cang@codeaurora.org>
>>>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>>>> ---
>>>>   .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  7 +++
>>>>   drivers/scsi/ufs/ufs.h                             |  9 ++++
>>>>   drivers/scsi/ufs/ufshcd-pltfrm.c                   | 24 ++++++++++
>>>>   drivers/scsi/ufs/ufshcd.c                          | 52
>>> ++++++++++++++++++++++
>>>>   drivers/scsi/ufs/ufshcd.h                          |  1 +
>>>>   5 files changed, 93 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>>>> b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>>>> index c39dfef..4522434 100644
>>>> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>>>> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>>>> @@ -41,6 +41,12 @@ Optional properties:
>>>>   -lanes-per-direction : number of lanes available per direction -
>>>> either 1
>>> or 2.
>>>>                          Note that it is assume same number of lanes
>>>> is
>>> used both
>>>>                          directions at once. If not specified, default
>>>> is 2
>>> lanes per direction.
>>>> +- dev-ref-clk-freq   : Specify the device reference clock frequency, must
>>> be one of the following:
>>>> +                       0: 19.2 MHz
>>>> +                       1: 26 MHz
>>>> +                       2: 38.4 MHz
>>>> +                       3: 52 MHz
>>>> +                       Defaults to 26 MHz if not specified.
>>> I must have misunderstood your last response. I thought you could
>>> handle things without DT. If not, my question remains.
>>> [Sayali]: Ref clk frequency setting could vary from
>>> platfrom-to-platform(vendor specific). Hence we need to pass it via DT.
>>>          Currently in DT we do not set/mention any ref clk frequency
>>> parameter. Hence I have added one new DT entry to configure
>>>          required ref clk freq.
>> The clocks property contains "ref_clk". Is that not the same clock?
>> Why can't you read what that frequency is? Or you need to be able to change it to a specific frequency? These all look like typical oscillator frequencies, so I wouldn't expect you could change them (other than divide by 2 maybe).
>> [Sayali] : It is the same "ref_clk", but we need to be able to change it to a specific frequency as per requirement. Thus, we need new DT entry to specify/override reference clock frequency as per need.
> That is not what your patch does. It just tells the device what the
> frequency is. If you need to get the rate, use "clk_get_rate" on
> "ref_clk". If you need to actually set it to a specific frequency,
> then we have properties for that already (assigned-clock-rates).
Yes, we need to set it to a specific frequency. I will use 
"assigned-clock-rates" for passing ref_clk frequency in next patch set.
>
> Seems to me that by the time you get to Linux, the bootloader would
> have already set this. Otherwise, how do you boot? Seems like you
> would want to read the attr and ensure "ref_clk" freq matches.
Yes, ref_clk freq will be already set in device via bootloader. In 
Kernel, before updating ref_clk freq (if required and passed via DT), we 
are reading the current ref_clk set in device and only if it is 
different than what has been passed via DT, we will be updating ref_clk 
freq, otherwise we just return.
> Rob
Thanks,
Sayali
