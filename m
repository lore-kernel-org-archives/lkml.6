Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520350204; cv=none;
        d=google.com; s=arc-20160816;
        b=ioKmmylPvyk6RRGB7WDYxu+T4373Na8zbPn6Eoo0Q6rCo/71vrqhJljVzI3xUOUpmY
         6h0c/kxiVQga5bE4pWUXMZGio0B+jLIlSNyeAYqZSNcoHWOXGY0SGeKAIyVexT+XSpDV
         G0WMAQs8R1cuaHYcrrYNR4ZlfsRwcUkJXVHK33ttKZjVJA+GV40Uytun1WzEQVLkz1wP
         NkjRZCk+xxuanmxQxlkso8SFACXOgVT8oSeuFDwTBE1o9NR8DpzRp+v/qA5QxA8UTe0n
         wsyMMvSuzYp1TkBErJDtRvdqs1A37hSmbmUn7mU2Xg04hiF8u2zzYvlAxWj53YaEFUSH
         WQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=W1JM8PEsDy23whaiYBxu6b8GSMr8cqKmMKJ71VOnECc=;
        b=Qo4HZ03pP8qqkwAGNCYig7wvujgesiRP4CyR5s02FiNofQQsEtD+zjmbAInq1A04gr
         9EsxqfLkdZJGSj+1bBSHuvhPMWozgj1t1RekSTRsz1XuimvJ+qiX83wwdPX3kIsPVtGC
         oqhdNQE1RhKye1lx5vYcfXqMvesXPF5MVR0fGrWPyFT75BRO3C2ZnCIQpV50Ta+6BBp0
         fgtl8aSqA5dKkiZmWBOI2XZ7uFerq43NW4MFeVorWGtWqj1hb6JRbG4JlVk3k5rkq0xO
         uM+Jxe2T5mFCcVK29gJLcgoM74rykpvYjJhLu5mzwrEW4Gyfvd8FMo3do75wibcyJk/D
         ICIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HJfpSf1C;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HJfpSf1C;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AG47ELu2Fnx6141UoIrfvKYQwM9u/6rZn3JiTiVRrkfnXUGxFBvII9II7MESyfE0aargwNr9SUj4PBwlbC+XE3WulMw=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <b4459d98-ebd4-7b13-07ec-613845579558@huawei.com>
References: <1520333268-82754-1-git-send-email-john.garry@huawei.com>
 <1520335317.10722.416.camel@linux.intel.com> <b4459d98-ebd4-7b13-07ec-613845579558@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 Mar 2018 16:30:03 +0100
X-Google-Sender-Auth: OeP7TLrt8_TZDJ9iam2AxtNdHUI
Message-ID: <CAJZ5v0gnf6rDYtKLBNfKjC=g3W=2XUed_R=AO+GeGYuubP_zWw@mail.gmail.com>
Subject: Re: [PATCH v16 0/9] LPC: legacy ISA I/O support
To: John Garry <john.garry@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1594202736423831464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 12:36 PM, John Garry <john.garry@huawei.com> wrote:
> On 06/03/2018 11:21, Andy Shevchenko wrote:
>>
>> On Tue, 2018-03-06 at 18:47 +0800, John Garry wrote:
>>>
>>> This patchset supports the IPMI-bt device attached to the Low-Pin-
>>> Count
>>> interface implemented on Hisilicon Hip06/Hip07 SoC.
>>>                         -----------
>>>                         | LPC host|
>>>                         |         |
>>>                         -----------
>>>                              |
>>>                 _____________V_______________LPC
>>>                   |                       |
>>>                   V                       V
>>>                                      ------------
>>>                                      |  BT(ipmi)|
>>>                                      ------------
>>>
>>> When master accesses those peripherals beneath the Hip06/Hip07 LPC, a
>>> specific
>>> LPC driver is needed to make LPC host generate the standard LPC I/O
>>> cycles with
>>> the target peripherals'I/O port addresses. But on curent arm64 world,
>>> there is
>>> no real I/O accesses. All the I/O operations through in/out accessors
>>> are based
>>> on MMIO ranges; on Hip06/Hip07 LPC the I/O accesses are performed
>>> through driver
>>> specific accessors rather than MMIO.
>>> To solve this issue and keep the relevant existing peripherals'
>>> drivers untouched,
>>> this patchset:
>>>    - introduces a generic I/O space management framework, logical PIO,
>>> to support
>>>       I/O operations on host controllers operating either on MMIO
>>> buses or on buses
>>>      requiring specific driver I/O accessors;
>>>    - redefines the in/out accessors to provide a unified interface for
>>> both MMIO
>>>      and driver specific I/O operations. Using logical PIO, th call of
>>> in/out() from
>>>      the host children drivers, such as ipmi-si, will be redirected to
>>> the
>>>      corresponding device-specific I/O hooks to perform the I/O
>>> accesses.
>>>
>>> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC
>>> peripherals can
>>> be supported without any changes on the existing ipmi-si driver.
>>>
>>> The whole patchset has been tested on Hip07 D05 board both using DTB
>>> and ACPI.
>>>
>>
>>> V15 thread here: https://lkml.org/lkml/2018/2/26/584
>>
>>
>> Thanks for an update.
>> Though I answered to previous thread.
>>
>> Summary: I'm fine with the series as long as maintainers are fine
>> (Rafael et al.). On personal side I think that the handler approach is
>> better. Details are in v15 thread.
>
>
> Hi Andy,
>
> Thanks for your input and continued support. As I mentioned in reply in v15,
> the handler support would (or has) faced issues. And Rafael seems fine with
> deferring the probe to the LLDD in Patch #7/9

Well, the only sort-of concern is that these devices may not be
"serial bus slaves" in general, so the naming is slightly confusing.

But overall this approach and the one based on a scan handler both
boil down to checking a (list of) device ID(s) and doing something
special in case of a match.
