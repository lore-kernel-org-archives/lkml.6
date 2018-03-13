Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520936568; cv=none;
        d=google.com; s=arc-20160816;
        b=0TGq+Ilc5dEfmDSoc3Tdb2rMusVJqum6+aIhPeX+PfD9kNjujImO+9fM9cqMDSNG06
         y51OeehIDDV/jWm0fLF07IppS22EbUPp8KM6VbhfSeDLHCQ++JGWUXu6dtPVyR03PmtX
         5jPxCyJzs2QeQ5GlG/7SiGiC7Xevr9dxrZw2Ry56htbnzQDRcDYCwrCQx8CamNJrOQWP
         8OpHOUovn0mSOT6L6PnALc3wmc4yQjUSmVaZ0xYasPsUh5gynqNtifKa3b4CCl88X9Nz
         p5XdmCDAw+Zrko+JEswXSyEp+IalONJ6k6K6uZxOgcTFijS3N4PXzKRtpwD1oRs5HUpG
         QwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7JoaGpUBC08kPgO2fF78tW/pGE/KC9JkfLRI+QS2v78=;
        b=c4E1ZzTXSOI/hSIk4Ln32g2KBW3PD9h2kWEEaUNtFQG3NHKbMmCEmTl5J+BaEuxnih
         CesSX7yVzd0rwh2jA6TWWVm0RZ0DYjwbo3Zhb+uFqbXBKPQe5JpF13oCwn1a1SmiZlzw
         vQF03zNqLkytU8qPmWWNfD6zbFbQx470M4jEwAT1BvtLhpzMaL3kV00XPC+qNVa5vyMd
         fcmEr53ZE4Pl2bIsknDr3ruYoX9ytoJL8Sovn8+M7Gno79UdiPVpDxhFq3IDeN4qrQrN
         kbXCGYWIyW6pbzGOivPJXpCYeUcpiHHYICACOzf9/8Ca06GWl1ktBByuUMhs09Mkytek
         rNKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AK1rS+NM;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AK1rS+NM;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AG47ELundc/YTPM4QobyZlf5Q9PwqzCs4StoaHA0TSOzE6PuQdqa6mCzchNhN5dz/Wfxckx9GsnoxmZpHsbTdCZMK+U=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <3ef757ff-8430-017f-59d3-ff67f49f5a80@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
 <1520335317.10722.416.camel@linux.intel.com> <b4459d98-ebd4-7b13-07ec-613845579558@huawei.com>
 <CAJZ5v0gnf6rDYtKLBNfKjC=g3W=2XUed_R=AO+GeGYuubP_zWw@mail.gmail.com> <3ef757ff-8430-017f-59d3-ff67f49f5a80@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Mar 2018 11:22:47 +0100
X-Google-Sender-Auth: 1c4sSR7MjkRhBAu32G0C-nmNxAA
Message-ID: <CAJZ5v0jTJ-LwyPUO7mbS47KyZ35pZeBfqkjxqubZjEGC=OJ82Q@mail.gmail.com>
Subject: Re: [PATCH v16 0/9] LPC: legacy ISA I/O support
To: John Garry <john.garry@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Hanjun Guo <hanjun.guo@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
	Olof Johansson <olof@lixom.net>, Dann Frazier <dann.frazier@canonical.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>,
	Joe Perches <joe@perches.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
	Corey Minyard <minyard@acm.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Frank Rowand <frowand.list@gmail.com>, Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594185012385637551?=
X-GMAIL-MSGID: =?utf-8?q?1594817582702334170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 5:22 PM, John Garry <john.garry@huawei.com> wrote:
>>>>>
>>>>> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC
>>>>> peripherals can
>>>>> be supported without any changes on the existing ipmi-si driver.
>>>>>
>>>>> The whole patchset has been tested on Hip07 D05 board both using DTB
>>>>> and ACPI.
>>>>>
>>>>
>>>>> V15 thread here: https://lkml.org/lkml/2018/2/26/584
>>>>
>>>>
>>>>
>>>> Thanks for an update.
>>>> Though I answered to previous thread.
>>>>
>>>> Summary: I'm fine with the series as long as maintainers are fine
>>>> (Rafael et al.). On personal side I think that the handler approach is
>>>> better. Details are in v15 thread.
>>>
>>>
>>>
>>> Hi Andy,
>>>
>>> Thanks for your input and continued support. As I mentioned in reply in
>>> v15,
>>> the handler support would (or has) faced issues. And Rafael seems fine
>>> with
>>> deferring the probe to the LLDD in Patch #7/9
>>
>>
>
> Hi Rafael,
>
>> Well, the only sort-of concern is that these devices may not be
>> "serial bus slaves" in general, so the naming is slightly confusing.
>>
>
> Right, the name.
>
> The key point is that we model the bus the same as other serial buses like
> I2C or SPI, so require the same treatment from the ACPI scan.
>
> Would you prefer acpi_is_serial_bus_slave() and
> acpi_device_flags.serial_bus_slave symbols be modified also?

Yeah, preferably.

You can rename them to acpi_device_enumeration_by_parent() and
acpi_device_flags.enumeration_by_parent, respectively, as far as I'm
concerned.

At least the names would match the purpose then. :-)

And please update the comment in acpi_default_enumeration() while at it.
