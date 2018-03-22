Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AG47ELssNYz7B2Tx+tFSDZLYnJHA1vtmS6X+NeXmTQi8Ky1FeISGSzjpyidaU8LCwM2MyEElTge1
ARC-Seal: i=1; a=rsa-sha256; t=1521725746; cv=none;
        d=google.com; s=arc-20160816;
        b=og9KkiVeH+n80Gd9ssd7N7qqMvg4xcq5xCynZp1WDetGVn0EmPSI4mwnnCggWEoms6
         jTB/Ij9H4yFMQ1JLWdJa4K/m39vhvGrcA1E/4aCWSzDUspbT8GH7xS1rksLC6A7Zu6bB
         IwOGnydxVc0CHtKzivD54RAzcWR1eBuTGNrqf4XRQElPWv0gnilO801pMHKPk2T3U/Fp
         JZI/jQ9e09kZ3D3zxxL2EFmLyDRUU3n8MHRNTH1kjhqzWgMgq2aPFh+Du1vrvLihtYsJ
         NrhJKCO71PEnRzSYz2MmLOtmwR29phOI40Sh9q070c4AbpvfJG+FTjOnNRU+Vsw8ca/b
         UcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=Q2QWcsMbgXc43vsAg+VGdD4XbxI8ZT9QUg9Qc2GuThE=;
        b=d4D61NtSpfxfJoupuTdUfKzNGRNVNUhVb8uZ/uAXtwdoKU24kPzpDwBl7t7zW00hix
         JvsPJvFn6VpcSm8Td6y3rLPXvsF/sk2mLjqfTsnoLxLNqo8N+byOez486fhLuXGyyiyD
         dVrdpqpMbCCOBC/kD56+XLQE26yx5Dz2HDAIv0Rqh+plUwi8A1mjjA1hnevG2Z+4zXr8
         xjyQyPGLDhhw0QO1GdsOY6yysWK7ZBqV7lDlr853Xe/i4VZcY/3UzVIFlSjlj/u0+1Bq
         O+VdFGduShKH3VOZvbk7AELcJnJBnWKWXZD8/wnAAWssKti2FCos9QI7A6IFfKR8XkZm
         px3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4ED217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Thu, 22 Mar 2018 08:35:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"olof@lixom.net" <olof@lixom.net>,
	"dann.frazier@canonical.com" <dann.frazier@canonical.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"joe@perches.com" <joe@perches.com>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>, "minyard@acm.org" <minyard@acm.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"frowand.list@gmail.com" <frowand.list@gmail.com>,
	"agraf@suse.de" <agraf@suse.de>
Subject: Re: [PATCH v17 00/10] LPC: legacy ISA I/O support
Message-ID: <20180322133544.GA236400@bhelgaas-glaptop.roam.corp.google.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <20180321233940.GI38649@bhelgaas-glaptop.roam.corp.google.com>
 <334da3b2-5233-5ad3-728e-7ae95231bf01@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334da3b2-5233-5ad3-728e-7ae95231bf01@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938019590734035?=
X-GMAIL-MSGID: =?utf-8?q?1595645095717801265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 10:38:37AM +0000, John Garry wrote:
> On 21/03/2018 23:39, Bjorn Helgaas wrote:
> > On Thu, Mar 15, 2018 at 02:15:49AM +0800, John Garry wrote:
> > > This patchset supports the IPMI-bt device attached to the Low-Pin-Count
> > > interface implemented on Hisilicon Hip06/Hip07 SoC.
> > >                         -----------
> > >                         | LPC host|
> > >                         |         |
> > >                         -----------
> > >                              |
> > >                 _____________V_______________LPC
> > >                   |                       |
> > >                   V                       V
> > >                                      ------------
> > >                                      |  BT(ipmi)|
> > >                                      ------------
> > > ...
> > 
> > > Gabriele Paoloni (2):
> > >   PCI: Remove unused __weak attribute in pci_register_io_range()
> > >   PCI: Add fwnode handler as input param of pci_register_io_range()
> > > 
> > > John Garry (4):
> > >   ACPI / scan: rename acpi_is_serial_bus_slave() to widen use
> > >   ACPI / scan: do not enumerate Indirect IO host children
> > >   HISI LPC: Add ACPI support
> > >   MAINTAINERS: Add maintainer for HiSilicon LPC driver
> > > 
> > > Zhichang Yuan (4):
> > >   LIB: Introduce a generic PIO mapping method
> > >   PCI: Apply the new generic I/O management on PCI IO hosts
> > >   OF: Add missing I/O range exception for indirect-IO devices
> > >   HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings
> > > 
> > >  .../arm/hisilicon/hisilicon-low-pin-count.txt      |  33 ++
> > >  MAINTAINERS                                        |   7 +
> > >  drivers/acpi/pci_root.c                            |   8 +-
> > >  drivers/acpi/scan.c                                |  33 +-
> > >  drivers/bus/Kconfig                                |   8 +
> > >  drivers/bus/Makefile                               |   2 +
> > >  drivers/bus/hisi_lpc.c                             | 623 +++++++++++++++++++++
> > >  drivers/of/address.c                               |  96 +++-
> > >  drivers/pci/pci.c                                  |  95 +---
> > >  include/acpi/acpi_bus.h                            |   2 +-
> > >  include/asm-generic/io.h                           |   4 +-
> > >  include/linux/logic_pio.h                          | 124 ++++
> > >  include/linux/pci.h                                |   3 +-
> > >  lib/Kconfig                                        |  15 +
> > >  lib/Makefile                                       |   2 +
> > >  lib/logic_pio.c                                    | 282 ++++++++++
> > >  16 files changed, 1229 insertions(+), 108 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
> > >  create mode 100644 drivers/bus/hisi_lpc.c
> > >  create mode 100644 include/linux/logic_pio.h
> > >  create mode 100644 lib/logic_pio.c
> > 
> > I applied this whole series to pci/lpc for v4.17.
> > 
> > I made the following whitespace and other trivial corrections.
> > Hopefully I didn't break anything.
> > 
> 
> Hi Bjorn,
> 
> Super thanks for doing this. In general the changes look ok. However a build
> issue has appeared, below.

It didn't just "appear"; I added it myself!  I fixed it and repushed the
branch.
