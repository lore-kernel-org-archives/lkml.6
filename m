Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELvcdHUDf6LLA3WBV/7n3GZ+sdMt2dHOa8V9FFuiwSxAL3EUFOCBht98riWj2Tla6qZurapf
ARC-Seal: i=1; a=rsa-sha256; t=1520937774; cv=none;
        d=google.com; s=arc-20160816;
        b=ETlK/KqaiH3ccwNPLPwFw64069sSqxX0xaoR7Tacxurx9zfVekROpDUosRLu1RktUz
         IYcUXV1V+Tcd1eudWjER5eAar1V+meqpLQO7tH4eS5QKS12ZcwRmmNB6w/rFCn18ttNc
         uBqmLeslkdWVrpoHWKFwIIrWXsyUU6PnbnULERRjuGabO2rBHCaXXSwLkfM/C5MhF2dx
         gK8Bu3h8zZ/G639I6/WoHrQHIBWE/PZ8hhnsbIBc7ZP88A2eL/O7PopPzFe/a4ZHg4LZ
         dl1z75Rz5PmsRHgQFTr5PyHgHxbyNFM2YnaZJWrlQ8EiITARlMMSkCowMB733KNUFMT0
         Vq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=L5f9AByRlmhsVHpMEoWvAulGrv/u1PV9mD/hnXHYz80=;
        b=AgTlL70cSaKZjI8FPepTMNP+FbCiTiSKzjX7lbOgre7eld8+ZXM8WkTrTj/luG1v30
         RCBX1gxOt3pmv8XnyYselt6uhTd0jR8DZ5n5CMhSxuN2oP3uqBWKFhyD2u75rjP5KaXY
         3gDu99XBYHnVJ27ymRKNmV0sJXjyPGXQqV8U4BUUqg/ZOEhnDw0dKu/yWs4iXeTHuKR3
         RmP10vCgoalyY4GInd/UQu95gqyCPlyPbxH+nxFl8sijfoL738kfybdXfJTwE6TkJ0Tb
         bM7I3tYp3FeCItBWDWorZrTQytXFXEW/pLU66l9PyJ5Uagm1FP/iFhAfDBYkgVxl00Ve
         y+Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH v16 0/9] LPC: legacy ISA I/O support
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
 <1520335317.10722.416.camel@linux.intel.com>
 <b4459d98-ebd4-7b13-07ec-613845579558@huawei.com>
 <CAJZ5v0gnf6rDYtKLBNfKjC=g3W=2XUed_R=AO+GeGYuubP_zWw@mail.gmail.com>
 <3ef757ff-8430-017f-59d3-ff67f49f5a80@huawei.com>
 <CAJZ5v0jTJ-LwyPUO7mbS47KyZ35pZeBfqkjxqubZjEGC=OJ82Q@mail.gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Hanjun Guo" <hanjun.guo@linaro.org>, Rob Herring <robh+dt@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland
	<mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Dann Frazier
	<dann.frazier@canonical.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
	Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Linux PCI
	<linux-pci@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, ACPI Devel Maling List
	<linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, Corey Minyard
	<minyard@acm.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, Frank Rowand
	<frowand.list@gmail.com>, Alexander Graf <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <fb457950-b0d7-0d77-02c5-f9531ea71d90@huawei.com>
Date: Tue, 13 Mar 2018 10:42:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jTJ-LwyPUO7mbS47KyZ35pZeBfqkjxqubZjEGC=OJ82Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594185012385637551?=
X-GMAIL-MSGID: =?utf-8?q?1594818847854188121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/03/2018 10:22, Rafael J. Wysocki wrote:
> On Tue, Mar 6, 2018 at 5:22 PM, John Garry <john.garry@huawei.com> wrote:
>>>>>>
>>>>>> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC
>>>>>> peripherals can
>>>>>> be supported without any changes on the existing ipmi-si driver.
>>>>>>
>>>>>> The whole patchset has been tested on Hip07 D05 board both using DTB
>>>>>> and ACPI.
>>>>>>
>>>>>
>>>>>> V15 thread here: https://lkml.org/lkml/2018/2/26/584
>>>>>
>>>>>
>>>>>
>>>>> Thanks for an update.
>>>>> Though I answered to previous thread.
>>>>>
>>>>> Summary: I'm fine with the series as long as maintainers are fine
>>>>> (Rafael et al.). On personal side I think that the handler approach is
>>>>> better. Details are in v15 thread.
>>>>
>>>>
>>>>
>>>> Hi Andy,
>>>>
>>>> Thanks for your input and continued support. As I mentioned in reply in
>>>> v15,
>>>> the handler support would (or has) faced issues. And Rafael seems fine
>>>> with
>>>> deferring the probe to the LLDD in Patch #7/9
>>>
>>>
>>
>> Hi Rafael,
>>
>>> Well, the only sort-of concern is that these devices may not be
>>> "serial bus slaves" in general, so the naming is slightly confusing.
>>>
>>
>> Right, the name.
>>
>> The key point is that we model the bus the same as other serial buses like
>> I2C or SPI, so require the same treatment from the ACPI scan.
>>
>> Would you prefer acpi_is_serial_bus_slave() and
>> acpi_device_flags.serial_bus_slave symbols be modified also?
>
> Yeah, preferably.
>
> You can rename them to acpi_device_enumeration_by_parent() and
> acpi_device_flags.enumeration_by_parent, respectively, as far as I'm
> concerned.
>
> At least the names would match the purpose then. :-)
>
> And please update the comment in acpi_default_enumeration() while at it.

Hi Rafael,

That should be ok. I can just add this mentioned modification to my 
series and send for review.

All the best,
John

>
> .
>
