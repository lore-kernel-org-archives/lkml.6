Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeDDKsB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:48:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43096 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeDDKsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:48:00 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Using regmap in ARM64 for EL3 register access
To: thor.thayer@linux.intel.com, Mark Brown <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <0cf26fec-a702-9d57-c7e0-85064690133c@linux.intel.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <7034387b-8dd9-77fa-95f0-63c805849ced@arm.com>
Date: Wed, 4 Apr 2018 11:47:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0cf26fec-a702-9d57-c7e0-85064690133c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/18 00:00, Thor Thayer wrote:
> Hi,
>
> I'm working on an ARM64 architecture that needs to manipulate some
> protected registers that are only accessible in EL3. Linux is running at
> EL1 which doesn't have the proper permissions for these registers.
>
If the hardware/IP registers are designed not to provide access to EL1,
then providing one in software by some means is simply wrong approach to
solve whatever issue you are trying to address here.

> Since U-Boot is running at the higher EL3, we communicate to the U-Boot
> functions through a SMC mechanism.
>
Please follow SMCCC to add any SMC interface.

> The regmap framework seems like a good match for accessing these
> registers. We need the same functionality as I2C and SPI regmaps - read,
> write, and update registers.
>
No, providing register access to EL1 using regmap+SMC just defeats the
hardware security restrictions and may provide ways to exploit.
Why not abstract to the level of services you need ?

> Any comments or suggestions about using regmap for this purpose? Is
> there a better method?
>
If you are looking for power management features, then PSCI and SCMI are
couple of specifications to look at. I would really like to know more
details on your use case to provide any suggestions.


-- 
Regards,
Sudeep
