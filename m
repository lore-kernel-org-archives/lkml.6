Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521457036; cv=none;
        d=google.com; s=arc-20160816;
        b=Ytc0hnbGZqDcV18qYRhSjT29aVT+SuDKuxld2KvZogNQa6iVqReu+cKOGDDfZVyK45
         LDnKsKJZjLdSYWFOsp/+nvruAHzQWp2tZsIvxkKUk6qiXBf4fj1Pz7Pg+PuynaxxdD7q
         jbPpjwXbP4p+uAjla0Q6OCu66W40VNnI1G+iebihl3lPyIOQM2vixoJfYnpcZYIpPiid
         Q4BNrWIthwcDE8dcIpsKPLxqb5mKnv2/LYCRibO1c+QvQ4RTkWzzWX55lXPmwqc74sWV
         VR98CspyBEfARSPCXDMMa3la8CQlCNmgvX5sn3KluSix9kcjdCXNcOm5nsl0x/qQfl32
         k3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eJqKlBEhKWfbyERoF7CZmxbGFrcyurQyivbN7+3mY8g=;
        b=I3z2AgBAziEzrIVZTcBwFpl7QiKTnJo74rcretKqfG/kop9BGBKIg0VpMM5WcEv982
         ijVG48jTXJ0UIlCMcTyIpwf1vOSG5B/OLgyDpBeXWQwbaWY0ZKbnw/4jqW4xr9WKFalK
         aAIDPPCt25Z60Y6ZqCvrpM9Vl7h4u4mHPOLB1kTaK/MgXsiAG3bd+44XqwvC0poYoRau
         /YtvlcxT5viC3uLsULondrGCV7nYr+X7QIHWB3ScYcYtYJgmyJuGwR+CtG5xzMk5YrBU
         YPHFoiBlni/lc+e0RJpiJJcAXPRukUQAZxWK3g3f0GlX73hm1peqD1EJXNPW4dIrN4tC
         dhOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tCxWqu76;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tCxWqu76;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AG47ELt/DegxI6lOX4Y50eZVJjCMbZvh1qw/XI5FnKJBADJUrLr49oEUD7//MPGOsvvDDQdohtbCDRwpBw363rph5Nc=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <906b3868-39a5-3807-23a4-dfc52c2e82c4@huawei.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-9-git-send-email-john.garry@huawei.com> <2309217.pWfZsU88YQ@aspire.rjw.lan>
 <906b3868-39a5-3807-23a4-dfc52c2e82c4@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Mar 2018 11:57:15 +0100
X-Google-Sender-Auth: 0bxz0fifBw3GFRIyk0j0tt4cTdo
Message-ID: <CAJZ5v0gm5AokZy4JvuJzDgdNoc88FjrMmXR2RK5pdRkXgtYrXQ@mail.gmail.com>
Subject: Re: [PATCH v17 08/10] ACPI / scan: do not enumerate Indirect IO host children
To: John Garry <john.garry@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
	Olof Johansson <olof@lixom.net>, Dann Frazier <dann.frazier@canonical.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joe Perches <joe@perches.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
	Corey Minyard <minyard@acm.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Frank Rowand <frowand.list@gmail.com>, Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938018903038038?=
X-GMAIL-MSGID: =?utf-8?q?1595363332863731271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 11:48 AM, John Garry <john.garry@huawei.com> wrote:
> On 19/03/2018 10:30, Rafael J. Wysocki wrote:
>>
>> On Wednesday, March 14, 2018 7:15:57 PM CET John Garry wrote:
>>>
>>> > Through the logical PIO framework systems which otherwise have
>>> > no IO space access to legacy ISA/LPC devices may access these
>>> > devices through so-called "indirect IO" method. In this, IO
>>> > space accesses for non-PCI hosts are redirected to a host
>>> > LLDD to manually generate the IO space (bus) accesses. Hosts
>>> > are able to register a region in logical PIO space to map to
>>> > its bus address range.
>>> >
>>> > Indirect IO child devices have an associated host-specific bus
>>> > address. Special translation is required to map between
>>> > a logical PIO address for a device and it's host bus address.
>>> >
>>> > Since in the ACPI tables the child device IO resources would
>>> > be the host-specific values, it is required the ACPI scan code
>>> > should not enumerate these devices, and that this should be
>>> > the responsibility of the host driver so that it can "fixup"
>>> > the resources so that they map to the appropriate logical PIO
>>> > addresses.
>>> >
>>> > To avoid enumerating these child devices, we add a check from
>>> > acpi_device_enumeration_by_parent() as to whether the parent
>>> > for a device is a member of a known list of "indirect IO" hosts.
>>> > For now, the HiSilicon LPC host controller ID is added.
>>> >
>>> > Signed-off-by: John Garry <john.garry@huawei.com>
>>> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> You have my ACK here already.
>>
>> Since I've ACKed the [7/10] too, I don't think there's anything more I can
>> do
>> about this series and I'm assuming that it will be routed through other
>> trees.
>>
>> Thanks!
>>
>
> Hi Rafael,
>
> Thanks for this.
>
> Yes, I am working on getting this whole series routed through another tree.
> Actually I think 7+8 could go separately since there is no build dependency,
> but I will try to keep the series together.

I can take the [7-8/10] if you want me to, so please let me know.

Thanks!
