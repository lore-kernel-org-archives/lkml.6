Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELsV0MZYe3mkNmdxlQ9mB+O6f7lIguQ6nMRixLGO8MMz/HaTaLqWklE6/Owf1E3w6OyP3iiN
ARC-Seal: i=1; a=rsa-sha256; t=1521458023; cv=none;
        d=google.com; s=arc-20160816;
        b=Nsbtc7IhtyAMCtf13n/HpUjCQiOwnLFfFC9oiiJDJLyP1HcYWnJHSYRkopJdNM/qtp
         nrOWEZnE1nh+wHpIkbJZsk/w6Ouv8o4FuKo/zq3Q6nTi0b/FHkUsSXsw93UTf2XHUi6C
         4DbIXaTA5pLxWmlCRtAX7CLe+qJAxn7ClT6RK2RGXxxD/z4WbF5bj/NEysxw6bPnZiu8
         qJKNeO7Xb5lKgp6yNqWDzwh/UTUT/kzILByZi9VSnK6wLU9S9adAw1i40C8S4jAzMphK
         lyYwZTfZ8bNYtOJzK7BmE0JaodVhyX1KZAy8VNM/5OBhtS6kzlPrUTdANxMbwgBEWn0W
         5KOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=+y7mA+SBa07AmzMWri5b1ZnCA3DwDTQOORSWmZ3pIKk=;
        b=LWQAAFficxTFApUYCC3R6o5bMmR4AANEMF+IdbDCbdzUcxEo8sgYarQgurYu0UNzk3
         16I2jxrTGmPkjBHWqdMPPNnFng8rYF6EDgh+rAZUQjVZ2scsuf4JD/BL8vq6F8iSJ85M
         atUpZFjTYefje70ncIZGc47urKZDj8dfQ5SFpHjv5fSQREcFq8UDGtfsIOmtf2fE13wn
         OufGjAA5mEh5F4kJ2kjNsNtZ+n2Go1A0CyWvHLBKkjFRrllZC/Nx7SnCbrDjz15SVuCa
         OjwdgjbIi0P1+IXAkj6koXI1N/lN1AY5kO9+buCMFcPSQkGdUWmH2k5pu76zg4ZkbHBV
         JoYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH v17 08/10] ACPI / scan: do not enumerate Indirect IO host
 children
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-9-git-send-email-john.garry@huawei.com>
 <2309217.pWfZsU88YQ@aspire.rjw.lan>
 <906b3868-39a5-3807-23a4-dfc52c2e82c4@huawei.com>
 <CAJZ5v0gm5AokZy4JvuJzDgdNoc88FjrMmXR2RK5pdRkXgtYrXQ@mail.gmail.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann
	<arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson
	<olof@lixom.net>, Dann Frazier <dann.frazier@canonical.com>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Joe Perches <joe@perches.com>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>, Linux PCI
	<linux-pci@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, ACPI Devel Maling List
	<linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, Corey Minyard
	<minyard@acm.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, Frank Rowand
	<frowand.list@gmail.com>, Alexander Graf <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <d4048516-033c-85f1-1766-69b3e58ae295@huawei.com>
Date: Mon, 19 Mar 2018 11:13:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gm5AokZy4JvuJzDgdNoc88FjrMmXR2RK5pdRkXgtYrXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938018903038038?=
X-GMAIL-MSGID: =?utf-8?q?1595364368758728084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19/03/2018 10:57, Rafael J. Wysocki wrote:
> On Mon, Mar 19, 2018 at 11:48 AM, John Garry <john.garry@huawei.com> wrote:
>> On 19/03/2018 10:30, Rafael J. Wysocki wrote:
>>>
>>> On Wednesday, March 14, 2018 7:15:57 PM CET John Garry wrote:
>>>>
>>>>> Through the logical PIO framework systems which otherwise have
>>>>> no IO space access to legacy ISA/LPC devices may access these
>>>>> devices through so-called "indirect IO" method. In this, IO
>>>>> space accesses for non-PCI hosts are redirected to a host
>>>>> LLDD to manually generate the IO space (bus) accesses. Hosts
>>>>> are able to register a region in logical PIO space to map to
>>>>> its bus address range.
>>>>>
>>>>> Indirect IO child devices have an associated host-specific bus
>>>>> address. Special translation is required to map between
>>>>> a logical PIO address for a device and it's host bus address.
>>>>>
>>>>> Since in the ACPI tables the child device IO resources would
>>>>> be the host-specific values, it is required the ACPI scan code
>>>>> should not enumerate these devices, and that this should be
>>>>> the responsibility of the host driver so that it can "fixup"
>>>>> the resources so that they map to the appropriate logical PIO
>>>>> addresses.
>>>>>
>>>>> To avoid enumerating these child devices, we add a check from
>>>>> acpi_device_enumeration_by_parent() as to whether the parent
>>>>> for a device is a member of a known list of "indirect IO" hosts.
>>>>> For now, the HiSilicon LPC host controller ID is added.
>>>>>
>>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> You have my ACK here already.
>>>
>>> Since I've ACKed the [7/10] too, I don't think there's anything more I can
>>> do
>>> about this series and I'm assuming that it will be routed through other
>>> trees.
>>>
>>> Thanks!
>>>
>>
>> Hi Rafael,
>>
>> Thanks for this.
>>
>> Yes, I am working on getting this whole series routed through another tree.
>> Actually I think 7+8 could go separately since there is no build dependency,
>> but I will try to keep the series together.
>
> I can take the [7-8/10] if you want me to, so please let me know.
>

OK, thanks. Will do.

John

> Thanks!
>
> .
>
