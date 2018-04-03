Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AIpwx4/6MFd9h3m1TCR+HjWVF6YOA9JVHbxpZ8NgnR7fE5ba8H84GbcmL26iWf9fivtKPbMqkykY
ARC-Seal: i=1; a=rsa-sha256; t=1522764196; cv=none;
        d=google.com; s=arc-20160816;
        b=HBs/grD7FIkCjcAg4L6RjkMOUz3/GYNejPO00NQDket7gV6UjXolFc2DZ7gGKCPdIm
         y8H3X+8kZlKsdF0A3yb8cWa97cTTKZ5rrhZOSxx8zLHQwyHX/DpSyqRBm10Z8dE6EZOm
         QAkN+v+qYTqyZ/677rz+VmLCQ9twQ0M0AAzc0wZvjfR4YSODpmxKbo5ixx3qtZM4Qb3p
         9s7mt9fmL5JyO3IyyanGai3J1zrCdlB/KrBEwycmiEpc2naWy5HOmydD/f01wPIu93FZ
         ybrEMXjeVOK9bGNdh3X5fVdXMr/j6heWomTZvhjehA+XNQxsyJpUrjVJER0DdaVR8Als
         17Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=WbfoZWIZ6ytIXwaTxujs+WVqcJ2erWBMintyLrA4RBk=;
        b=Ss3a2lVHz2udmoslrOi6ASWuEKZGd331kkTPZXdZKUY9mQTFHJpacweMmca5WhVxyL
         bed421Lwrp/IbIE9S5dvwnbdkYejAfgT9y3B0vYl7yOuWVn8vqgzmEPrcm/lnWvTVK3z
         fwruEiFbn7fRkrEoQVloBki2rSbgXiwRCzBPv4E1PYQr11QKhTm93KJjng02LamyAiRa
         zPblwmoqkevRa8IsWMBoxHVqU/fsqAXRZ7dOvqJnj3wlCP9LtqmweqXKiKFCVdCynEZK
         wuJ5ILEF/GLCCzblMSTtsLwbVpb0tv9a1SR0OQdKOo4AUHne9tbinrWTve6U1wMrczUA
         VUzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH v17 04/10] PCI: Apply the new generic I/O management on
 PCI IO hosts
To: Thierry Reding <thierry.reding@gmail.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-5-git-send-email-john.garry@huawei.com>
 <20180403134531.GD27789@ulmo>
CC: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>,
	<andriy.shevchenko@linux.intel.com>, <joe@perches.com>,
	<benh@kernel.crashing.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxarm@huawei.com>, <minyard@acm.org>, <devicetree@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
	<gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
	<frowand.list@gmail.com>, <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <40460bc7-401f-9625-fe59-26dc6408f60e@huawei.com>
Date: Tue, 3 Apr 2018 15:02:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180403134531.GD27789@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938017737328012?=
X-GMAIL-MSGID: =?utf-8?q?1596733990329048096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/04/2018 14:45, Thierry Reding wrote:
> On Thu, Mar 15, 2018 at 02:15:53AM +0800, John Garry wrote:
>> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>
>> After introducing the new generic I/O space management(Logical PIO), the
>> original PCI MMIO relevant helpers need to be updated based on the new
>> interfaces defined in logical PIO.
>> This patch adapts the corresponding code to match the changes introduced
>> by logical PIO.
>>
>> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>        #earlier draft
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Tested-by: dann frazier <dann.frazier@canonical.com>
>> ---
>>  drivers/pci/pci.c        | 92 +++++++++---------------------------------------
>>  include/asm-generic/io.h |  2 +-
>>  2 files changed, 18 insertions(+), 76 deletions(-)
>
> Today's linux-next regresses on NFS boot for Jetson TK1. I was able to
> bisect it to this commit. I'll comment below for where I think this is
> buggy.
>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 3f30b7d..09c2490 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/string.h>
>>  #include <linux/log2.h>
>> +#include <linux/logic_pio.h>
>>  #include <linux/pci-aspm.h>
>>  #include <linux/pm_wakeup.h>
>>  #include <linux/interrupt.h>
>> @@ -3436,17 +3437,6 @@ int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
>>  }
>>  EXPORT_SYMBOL(pci_request_regions_exclusive);
>>
>> -#ifdef PCI_IOBASE
>> -struct io_range {
>> -	struct list_head list;
>> -	phys_addr_t start;
>> -	resource_size_t size;
>> -};
>> -
>> -static LIST_HEAD(io_range_list);
>> -static DEFINE_SPINLOCK(io_range_lock);
>> -#endif
>> -
>>  /*
>>   * Record the PCI IO range (expressed as CPU physical address + size).
>>   * Return a negative value if an error has occured, zero otherwise
>> @@ -3454,51 +3444,28 @@ struct io_range {
>>  int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
>>  			resource_size_t	size)
>>  {
>> -	int err = 0;
>> -
>> +	int ret = 0;
>>  #ifdef PCI_IOBASE
>> -	struct io_range *range;
>> -	resource_size_t allocated_size = 0;
>> -
>> -	/* check if the range hasn't been previously recorded */
>> -	spin_lock(&io_range_lock);
>> -	list_for_each_entry(range, &io_range_list, list) {
>> -		if (addr >= range->start && addr + size <= range->start + size) {
>> -			/* range already registered, bail out */
>> -			goto end_register;
>> -		}
>> -		allocated_size += range->size;
>> -	}
>> +	struct logic_pio_hwaddr *range;
>>
>> -	/* range not registed yet, check for available space */
>> -	if (allocated_size + size - 1 > IO_SPACE_LIMIT) {
>> -		/* if it's too big check if 64K space can be reserved */
>> -		if (allocated_size + SZ_64K - 1 > IO_SPACE_LIMIT) {
>> -			err = -E2BIG;
>> -			goto end_register;
>> -		}
>> -
>> -		size = SZ_64K;
>> -		pr_warn("Requested IO range too big, new size set to 64K\n");
>> -	}
>> +	if (!size || addr + size < addr)
>> +		return -EINVAL;
>>
>> -	/* add the range to the list */
>>  	range = kzalloc(sizeof(*range), GFP_ATOMIC);
>> -	if (!range) {
>> -		err = -ENOMEM;
>> -		goto end_register;
>> -	}
>> +	if (!range)
>> +		return -ENOMEM;
>>
>> -	range->start = addr;
>> +	range->fwnode = fwnode;
>>  	range->size = size;
>> +	range->hw_start = addr;
>> +	range->flags = LOGIC_PIO_CPU_MMIO;
>>
>> -	list_add_tail(&range->list, &io_range_list);
>> -
>> -end_register:
>> -	spin_unlock(&io_range_lock);
>> +	ret = logic_pio_register_range(range);
>
> This ends up returning -EFAULT at some point, causing the driver's
> (pci-tegra.c) ->probe() to fail.
>
> Let me comment on a prior patch to pinpoint what exactly goes wrong.

Hi Thierry,

Thanks for the notification. So this patch is where we transistion from 
using the PCI internal pio management to the new framework.

I already had tried today's linux-next with hisi PCI host controller in 
pcie-hisi.c on an arm64 system, and it looked ok.

Function logic_pio_register_range() returns fault when we try to 
register the same range twice or there is an overlap in ranges.

I wonder if is there something special about this host controller driver 
in terms of IO space management. And what arch/system was the host?

John

>
> Thierry
>
