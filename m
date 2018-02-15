Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427002AbeBORID (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:08:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5654 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1423255AbeBORIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:08:00 -0500
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com>
 <CAHp75Ve7C4AJYK6AC=o-jzw6b2p8c8GBRd70Zjv+vYWbfytufg@mail.gmail.com>
 <adfa2009-476b-8c25-c661-b0eeb48a6c43@huawei.com>
 <CAHp75VfOa5pN4MKT-aQmWBwPGWsOaQupyfrN-weWwfR3vMLtuA@mail.gmail.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <hanjun.guo@linaro.org>, "Rob Herring" <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, "Arnd Bergmann" <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>,
        Dann Frazier <dann.frazier@canonical.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <59e5293f-0ea5-12f4-27db-b13bbcf0918b@huawei.com>
Date: Thu, 15 Feb 2018 17:07:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfOa5pN4MKT-aQmWBwPGWsOaQupyfrN-weWwfR3vMLtuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 16:16, Andy Shevchenko wrote:
> Another approach is to use ~0UL if that is preferable.
>
>>>> >>> +       list_for_each_entry(rentry, &resource_list, node)
>>>> >>> +               resources[count++] = *rentry->res;
>>> >> It has similarities with acpi_create_platform_device().
>>> >> I guess we can utilize existing code.
>> > For sure, this particular segment is effectively same as part of
>> > acpi_create_platform_device():
> Not the same, acpi_create_platform_device() does a bit more than
> copying the resources. If it indeed makes no hurt...
>
>> >         list_for_each_entry(rentry, &resource_list, node)
>> >             acpi_platform_fill_resource(adev, rentry->res,
>> >                             &resources[count++]);
>> > So is your idea to refactor this common segment into a helper function?
> ...I would go with helper.
>

Hi Andy,

Since the plan now is that this code is no longer going to be added to 
drivers/acpi, but instead pushed to the LLDD, I am pondering whether we 
should still factor out of this common code. Opinion?

Thanks,
John

>>>> >>> +               char *name = &acpi_indirect_io_mfd_cell[count].name[0];
