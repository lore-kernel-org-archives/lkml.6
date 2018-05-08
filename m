Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755199AbeEHRNR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:13:17 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:26588 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbeEHRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:13:15 -0400
Subject: Re: [PATCH] net: phy: DP83811: Add support for the phy
To: Andrew Lunn <andrew@lunn.ch>
CC: <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180508141105.23867-1-dmurphy@ti.com>
 <1b6877db-61cf-101a-054e-9c1fbe95a813@ti.com> <20180508164944.GE2888@lunn.ch>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <f4cfe325-f462-e965-3bd8-629acf460fbf@ti.com>
Date: Tue, 8 May 2018 12:13:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508164944.GE2888@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

On 05/08/2018 11:49 AM, Andrew Lunn wrote:
> On Tue, May 08, 2018 at 10:56:55AM -0500, Dan Murphy wrote:
>> All
>>
>> On 05/08/2018 09:11 AM, Dan Murphy wrote:
>>> Add support for the DP83811 phy by extending
>>> the DP83822 driver to recognize the PHY IDs.
>>>
>>> The DP83811 supports both rgmii and sgmii interfaces.
>>> There are 2 part numbers for this the DP83811R does not
>>> reliably support the SGMII interface but the DP83811S will.
>>>
>>> There is not a way to differentiate these parts from the
>>> hardware or register set.  So this is controlled via the DT
>>> to indicate which phy mode is required.  Or the part can be
>>> strapped to a certain interface.
>>>
>>> Data sheet can be found here:
>>> http://www.ti.com/product/DP83TC811S-Q1/description
>>> http://www.ti.com/product/DP83TC811R-Q1/description
>>>
>>
>> I am withdrawing this patch for comment.
>> Some of the future features have varying register definitions between the DP83811
>> and DP83822
> 
> Hi Dan
> 
> It might be worth talking to the ASIC engineers and the
> test/qualification engineers. There are sometime undocumented
> registers for testing. You might be able to identify the exact device
> from these registers.
> 

Thanks.  I talked to them prior to submitting this patch about determining which part is on the board.
I will ping them again and poke a little harder.

It turns out that we will probably need a new driver for this part anyway as there are
additional features that need to be supported that the 811 just does not support.

They want to support Master/Slave configurations.
The 822 supports fiber and eee while the 811 does not.
The 811 supports the IEEE802.3bw specific fields in MMD1 and MMD3, which are not in the 822.
The 811 does not support auto-negotiation on the MDI so all the auto-neg registers are invalid for the 811 but are valid for the 822.

Our Customer engineers felt that combining these two devices into a single driver may confuse the customer.

Dan

>      Andrew
> 


-- 
------------------
Dan Murphy
