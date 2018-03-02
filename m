Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425918AbeCBJh5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:37:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36684 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1424995AbeCBJhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:37:05 -0500
Subject: Re: [PATCH 1/8] dt-bindings: scsi: hisi_sas: add an property of
 signal attenuation
To: Rob Herring <robh@kernel.org>
References: <1519067611-206638-1-git-send-email-john.garry@huawei.com>
 <1519067611-206638-2-git-send-email-john.garry@huawei.com>
 <20180301214010.ptcaoah756z5xias@rob-hp-laptop>
CC: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <mark.rutland@arm.com>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiaofei Tan <tanxiaofei@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <584282a9-225c-0000-06bd-c07c0ae55007@huawei.com>
Date: Fri, 2 Mar 2018 09:36:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180301214010.ptcaoah756z5xias@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2018 21:40, Rob Herring wrote:
> On Tue, Feb 20, 2018 at 03:13:24AM +0800, John Garry wrote:
>> From: Xiaofei Tan <tanxiaofei@huawei.com>
>>
>> For some new boards with hip07 chipset we are required to
>> set PHY config registers differently. The hw property which
>> determines how to set these registers is in the PHY signal
>> attenuation readings.
>>
>> This patch add an devicetree property, signal-attenuation, which
>> is used to describe the signal attenuation of an board.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/scsi/hisilicon-sas.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt b/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>> index df3bef7..bd32ecd 100644
>> --- a/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>> +++ b/Documentation/devicetree/bindings/scsi/hisilicon-sas.txt
>> @@ -53,6 +53,13 @@ Main node required properties:
>>  Optional main node properties:
>>   - hip06-sas-v2-quirk-amt : when set, indicates that the v2 controller has the
>>  			    "am-max-transmissions" limitation.
>> + - signal-attenuation : array of 3 32-bit values, containing de-emphasis,
>
> Needs a vendor prefix.

Fine, I can add it. It's going to be "hisilicon-signal-attenuation" or 
similar.

Thanks,
John

>
>> +		preshoot, and boost attenuation readings for the board. They
>> +		are used to describe the signal attenuation of the board. These
>> +		values' range is 7600 to 12400, and used to represent -24dB to
>> +		24dB.
>> +		The formula is "y = (x-10000)/10000". For example, 10478
>> +		means 4.78dB.
>>
>>  Example:
>>  	sas0: sas@c1000000 {
>> --
>> 1.9.1
>>
>
> .
>
