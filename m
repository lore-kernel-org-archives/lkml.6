Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755408AbeEHRWB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:22:01 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:25809 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeEHRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:21:23 -0400
Subject: Re: [PATCH] net: phy: DP83811: Add support for the phy
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180508141105.23867-1-dmurphy@ti.com>
 <1b6877db-61cf-101a-054e-9c1fbe95a813@ti.com> <20180508164944.GE2888@lunn.ch>
 <f4cfe325-f462-e965-3bd8-629acf460fbf@ti.com>
 <cc5acc63-bcb5-2bda-9c9d-fd18e0a7740a@gmail.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <078e57c2-ee72-6709-1a3f-ab85dccc50c5@ti.com>
Date: Tue, 8 May 2018 12:21:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cc5acc63-bcb5-2bda-9c9d-fd18e0a7740a@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian

On 05/08/2018 12:14 PM, Florian Fainelli wrote:
> On 05/08/2018 10:13 AM, Dan Murphy wrote:
>> Andrew
>>
>> On 05/08/2018 11:49 AM, Andrew Lunn wrote:
>>> On Tue, May 08, 2018 at 10:56:55AM -0500, Dan Murphy wrote:
>>>> All
>>>>
>>>> On 05/08/2018 09:11 AM, Dan Murphy wrote:
>>>>> Add support for the DP83811 phy by extending
>>>>> the DP83822 driver to recognize the PHY IDs.
>>>>>
>>>>> The DP83811 supports both rgmii and sgmii interfaces.
>>>>> There are 2 part numbers for this the DP83811R does not
>>>>> reliably support the SGMII interface but the DP83811S will.
>>>>>
>>>>> There is not a way to differentiate these parts from the
>>>>> hardware or register set.  So this is controlled via the DT
>>>>> to indicate which phy mode is required.  Or the part can be
>>>>> strapped to a certain interface.
>>>>>
>>>>> Data sheet can be found here:
>>>>> http://www.ti.com/product/DP83TC811S-Q1/description
>>>>> http://www.ti.com/product/DP83TC811R-Q1/description
>>>>>
>>>>
>>>> I am withdrawing this patch for comment.
>>>> Some of the future features have varying register definitions between the DP83811
>>>> and DP83822
>>>
>>> Hi Dan
>>>
>>> It might be worth talking to the ASIC engineers and the
>>> test/qualification engineers. There are sometime undocumented
>>> registers for testing. You might be able to identify the exact device
>>> from these registers.
>>>
>>
>> Thanks.  I talked to them prior to submitting this patch about determining which part is on the board.
>> I will ping them again and poke a little harder.
>>
>> It turns out that we will probably need a new driver for this part anyway as there are
>> additional features that need to be supported that the 811 just does not support.
>>
>> They want to support Master/Slave configurations.
>> The 822 supports fiber and eee while the 811 does not.
>> The 811 supports the IEEE802.3bw specific fields in MMD1 and MMD3, which are not in the 822.
>> The 811 does not support auto-negotiation on the MDI so all the auto-neg registers are invalid for the 811 but are valid for the 822.
>>
>> Our Customer engineers felt that combining these two devices into a single driver may confuse the customer.
> 
> Why? Having a single Kconfig option to enable and "automatically"
> gaining support for new hardware is nice.
> 

I do agree that it is nice to have.  But with additional features or lack of features the driver source will get pretty messy
differentiating between devices.

What I added was just the basic if 811 & SGMII check.

Dan 

-- 
------------------
Dan Murphy
