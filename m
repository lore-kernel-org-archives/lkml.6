Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933735AbeB1Te2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:34:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:45525 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932389AbeB1Te0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:34:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="21041991"
Message-ID: <1519846461.10722.309.camel@linux.intel.com>
Subject: Re: [PATCH v1 2/4] x86/pci: Re-use new dmi_get_bios_year() helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 28 Feb 2018 21:34:21 +0200
In-Reply-To: <20180228202144.2ae8149f@endymion>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
         <20180222125923.57385-2-andriy.shevchenko@linux.intel.com>
         <20180226172832.7bf82336@endymion>
         <1519813744.10722.258.camel@linux.intel.com>
         <CAJZ5v0hOvU25zWfVjBw-2iz5Y7V2FkSwoTZVZTpjEG9KOCQ6oQ@mail.gmail.com>
         <20180228202144.2ae8149f@endymion>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-28 at 20:21 +0100, Jean Delvare wrote:
> On Wed, 28 Feb 2018 11:33:39 +0100, Rafael J. Wysocki wrote:
> > On Wed, Feb 28, 2018 at 11:29 AM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > I would assume that no BIOS date is related to prehistoric
> > > firmwares and
> > >  using _CRS would sound weird on them.  
> > 
> > Careful here.
> > 
> > You seem to be assuming that the DMI information is always valid
> > and/or complete which is know to not be the case sometimes.
> 
> True. While the BIOS date is not the worst offender when it comes to
> broken DMI data, you must remember that the date comes as a string,
> and
> older SMBIOS specifications did not even recommend a specific format
> for that string. As a matter of fact, my collection of DMI tables
> includes a few creative samples like "Jul  7 2016" or "09-16-08" which
> the kernel fails to parse.
> 
> So the default behavior at the driver level shouldn't be based on what
> older systems are most likely to enjoy. The default behavior must be
> the safest option, regardless of the age of the system.

Yep.

And here is a very good question which path is more safer: use _CRS, or
not?

Rafael, do you know any consequences of not using _CRS for PCI on older
and newer machines?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
