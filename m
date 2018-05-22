Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeEVRSb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:18:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:39175 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752453AbeEVRS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:18:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="201534841"
Subject: Re: [v4 07/11] dt-bindings: hwmon: Add documents for PECI hwmon
 client drivers
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>
References: <20180521195905.27983-1-jae.hyun.yoo@linux.intel.com>
 <20180522164230.GA11707@rob-hp-laptop>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <a05b44a2-ecc8-b028-4308-47d88523a6f1@linux.intel.com>
Date: Tue, 22 May 2018 10:18:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180522164230.GA11707@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/2018 9:42 AM, Rob Herring wrote:
> On Mon, May 21, 2018 at 12:59:05PM -0700, Jae Hyun Yoo wrote:
>> This commit adds dt-bindings documents for PECI hwmon client drivers.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>> Reviewed-by: James Feist <james.feist@linux.intel.com>
>> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
>> Cc: Andrew Jeffery <andrew@aj.id.au>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>> Cc: Joel Stanley <joel@jms.id.au>
>> ---
>>   .../bindings/hwmon/peci-cputemp.txt           | 23 ++++++++++++++++++
>>   .../bindings/hwmon/peci-dimmtemp.txt          | 24 +++++++++++++++++++
>>   2 files changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>> new file mode 100644
>> index 000000000000..2f59aee12d9e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
>> @@ -0,0 +1,23 @@
>> +Bindings for Intel PECI (Platform Environment Control Interface) cputemp driver.
>> +
>> +Required properties:
>> +- compatible : Should be "intel,peci-cputemp".
>> +- reg        : Should contain address of a client CPU. Address range of CPU
>> +	       clients is starting from 0x30 based on PECI specification.
>> +
>> +Example:
>> +	peci-bus@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		< more properties >
>> +
>> +		peci-cputemp@30 {
>> +			compatible = "intel,peci-cputemp";
>> +			reg = <0x30>;
>> +		};
> 
> [...]
> 
>> +		peci-dimmtemp@30 {
>> +			compatible = "intel,peci-dimmtemp";
>> +			reg = <0x30>;
>> +		};
> 
> As I said in the prior version, 2 nodes at the same address is wrong.
> 
> Rob
> 

In PECI bus, there is one and only bus host (adapter) and multiple
clients on a PECI bus, and PECI spec doesn't allow multiple originators
so only the host device can originate message. In this implementation,
all message transactions on a bus from client driver modules and user
space will be serialized well in the PECI core bus driver so bus
occupation and traffic arbitration will be managed well in the PECI core
bus driver even in case of a bus has 2 client drivers at the same
address. I'm sure that this implementation doesn't make that kind of
problem to OS.

Thanks,

-Jae
