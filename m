Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDDSPV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:15:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:35133 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751417AbeDDSPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:15:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="217550135"
Reply-To: thor.thayer@linux.intel.com
Subject: Re: RFC: Using regmap in ARM64 for EL3 register access
To: Sudeep Holla <sudeep.holla@arm.com>, Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0cf26fec-a702-9d57-c7e0-85064690133c@linux.intel.com>
 <7034387b-8dd9-77fa-95f0-63c805849ced@arm.com>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <2f15aea6-e3f0-f6e1-6797-efb2f9b78180@linux.intel.com>
Date: Wed, 4 Apr 2018 13:18:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7034387b-8dd9-77fa-95f0-63c805849ced@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 04/04/2018 05:47 AM, Sudeep Holla wrote:
> 
> 
> On 30/03/18 00:00, Thor Thayer wrote:
>> Hi,
>>
>> I'm working on an ARM64 architecture that needs to manipulate some
>> protected registers that are only accessible in EL3. Linux is running at
>> EL1 which doesn't have the proper permissions for these registers.
>>
> If the hardware/IP registers are designed not to provide access to EL1,
> then providing one in software by some means is simply wrong approach to
> solve whatever issue you are trying to address here.
> 
Thank you for the reply!

Sorry, I didn't describe this very well. This mechanism is similar to 
PSCI. We have System Management registers that could be needed by more 
than 1 virtual machine. So arbitration is needed and we use U-Boot for this.

>> Since U-Boot is running at the higher EL3, we communicate to the U-Boot
>> functions through a SMC mechanism.
>>
> Please follow SMCCC to add any SMC interface.
> 
Yes, the existing implementation is doing this and implements a SiP 
service framework.

>> The regmap framework seems like a good match for accessing these
>> registers. We need the same functionality as I2C and SPI regmaps - read,
>> write, and update registers.
>>
> No, providing register access to EL1 using regmap+SMC just defeats the
> hardware security restrictions and may provide ways to exploit.
> Why not abstract to the level of services you need ?
> 
I'm not following about abstracting the level of services. For accessing 
the registers, I thought a regmap implementation would be nice because 
of the read/write/update functionality that would wrap around the SMC 
SiP service functions.

>> Any comments or suggestions about using regmap for this purpose? Is
>> there a better method?
>>
> If you are looking for power management features, then PSCI and SCMI are
> couple of specifications to look at. I would really like to know more
> details on your use case to provide any suggestions.
> 
Thank you for those pointers. I vaguely knew about PSCI but I wasn't 
aware of SCMI. Let me study these interfaces, particularly SCMI, before 
I reply further because this may answer many of my questions.

Thank you again,

Thor
