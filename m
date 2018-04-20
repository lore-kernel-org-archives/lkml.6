Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754866AbeDTNYu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:24:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754762AbeDTNYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:24:48 -0400
Subject: Re: [RFC PATCH 1/2] ACPI / PNP: Don't add "enumeration_by_parent"
 devices
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-2-git-send-email-john.garry@huawei.com>
 <20180420130727.GV2173@lahna.fi.intel.com>
CC: <rjw@rjwysocki.net>, <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <z.liuxinliang@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <27c3f84e-4d53-4b6b-7382-04908082ed01@huawei.com>
Date: Fri, 20 Apr 2018 14:24:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180420130727.GV2173@lahna.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

On 20/04/2018 14:07, Mika Westerberg wrote:
> On Fri, Apr 20, 2018 at 06:07:25PM +0800, John Garry wrote:
>> +	} else {
>> +		device->driver_data = dev;
>
> I think this deserves a comment explaining why we (ab)use driver_data
> like this.

Sure, could add. I didn't see any other way for the acpi_device 
structure to reference the derived PNP device.

TBH, This overall approach is not good since we are creating the PNP 
device in the scan, and then leaving the device in limbo, waiting for 
the parent to add it, if at all. There's no rule for this.

So I'm looking for ideas on how to improve this.

Thanks,
John

>
> .
>
