Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756544AbeDZOXp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:23:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755998AbeDZOXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:23:44 -0400
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
 <20180420130727.GV2173@lahna.fi.intel.com>
 <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
 <20180420135222.GY2173@lahna.fi.intel.com>
 <75eae3ac-228f-d6a4-bb0e-4bd27e35c55d@huawei.com>
 <09e3aa95-86ae-ca30-7bb5-a9704d296b43@huawei.com>
 <20180426140808.GK2173@lahna.fi.intel.com>
CC: <andriy.shevchenko@linux.intel.com>, <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <z.liuxinliang@hisilicon.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <15443a87-2622-01ee-f7f2-426a51ca0f11@huawei.com>
Date: Thu, 26 Apr 2018 15:23:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180426140808.GK2173@lahna.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2018 15:08, Mika Westerberg wrote:
> On Thu, Apr 26, 2018 at 02:49:49PM +0100, John Garry wrote:
>> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
>> index 2d4611e..b04425b 100644
>> --- a/drivers/bus/hisi_lpc.c
>> +++ b/drivers/bus/hisi_lpc.c
>> @@ -18,6 +18,8 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/pci.h>
>>  #include <linux/slab.h>
>> +#include <linux/serial_8250.h>
>> +#include "../tty/serial/8250/8250.h"
>>
>>  #define DRV_NAME "hisi-lpc"
>>
>> @@ -345,6 +347,7 @@ static void hisi_lpc_comm_outs(void *hostdata, unsigned
>> long pio,
>>  #define MFD_CHILD_NAME_LEN (ACPI_ID_LEN + sizeof(MFD_CHILD_NAME_PREFIX) -
>> 1)
>>
>>  struct hisi_lpc_mfd_cell {
>> +	struct plat_serial8250_port serial8250_port;
>>  	struct mfd_cell_acpi_match acpi_match;
>>  	char name[MFD_CHILD_NAME_LEN];
>>  	char pnpid[ACPI_ID_LEN];
>> @@ -513,10 +516,31 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>>  		dev_warn(&child->dev, "set resource fail (%d)\n", ret);
>>  			return ret;
>>  		}
>> +	if (!strcmp(acpi_device_hid(child), "HISI1031")) {
>

Hi Mika,

> Hmm, there is a way in struct mfd_cell to match child devices using _HID
> so is there something preventing you from using that?

Not that I know about. Can you describe this method? I guess I also 
don't need to set the mfd_cell pnpid either for this special case device.

Thanks,
John


>
> .
>
