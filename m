Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeBHJtz convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:49:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52689 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbeBHJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:49:52 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: Parse entire table as a term_list for Dell XPS 9570 and Precision M5530
Date: Thu, 08 Feb 2018 10:48:09 +0100
Message-ID: <1730642.Ly2vjemNAk@aspire.rjw.lan>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B756CED7@ORSMSX110.amr.corp.intel.com>
References: <20180130060744.19049-1-kai.heng.feng@canonical.com> <9f0eaaf403014137a123f6676ddac5b9@ausx13mpc120.AMER.DELL.COM> <94F2FBAB4432B54E8AACC7DFDE6C92E3B756CED7@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 30, 2018 9:09:04 PM CET Moore, Robert wrote:
> 
> > -----Original Message-----
> > From: Mario.Limonciello@dell.com [mailto:Mario.Limonciello@dell.com]
> > Sent: Tuesday, January 30, 2018 11:03 AM
> > To: Schmauss, Erik <erik.schmauss@intel.com>; andy.shevchenko@gmail.com;
> > kai.heng.feng@canonical.com
> > Cc: rjw@rjwysocki.net; lenb@kernel.org; linux-acpi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Moore, Robert <robert.moore@intel.com>
> > Subject: RE: [PATCH] ACPI: Parse entire table as a term_list for Dell
> > XPS 9570 and Precision M5530
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Schmauss, Erik [mailto:erik.schmauss@intel.com]
> > > Sent: Tuesday, January 30, 2018 12:38 PM
> > > To: Andy Shevchenko <andy.shevchenko@gmail.com>; Kai-Heng Feng
> > > <kai.heng.feng@canonical.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown
> > > <lenb@kernel.org>; ACPI Devel Maling List
> > > <linux-acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; Limonciello, Mario
> > > <Mario_Limonciello@Dell.com>; Moore, Robert <robert.moore@intel.com>
> > > Subject: RE: [PATCH] ACPI: Parse entire table as a term_list for Dell
> > > XPS 9570 and Precision M5530
> > >
> > > Hi,
> > > > -----Original Message-----
> > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > owner@vger.kernel.org] On Behalf Of Andy Shevchenko
> > > > Sent: Tuesday, January 30, 2018 10:18 AM
> > > > To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown
> > > > <lenb@kernel.org>; ACPI Devel Maling List
> > > > <linux-acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > > kernel@vger.kernel.org>; Mario Limonciello
> > > > <mario.limonciello@dell.com>
> > > > Subject: Re: [PATCH] ACPI: Parse entire table as a term_list for
> > > > Dell XPS 9570 and Precision M5530
> > > >
> > > > On Tue, Jan 30, 2018 at 8:07 AM, Kai-Heng Feng
> > > > <kai.heng.feng@canonical.com> wrote:
> > > > > The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work
> > > > > out of box.
> > > > >
> > > > > The touchpad relies on its _INI method to update its _HID value
> > > > > from
> > > > > XXXX0000 to SYNA2393.
> > > > > Also, the _STA relies on value of I2CN to report correct status.
> > > > >
> > > > > Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
> > > > > correctly set up, and _INI can get run. The ACPI table in this
> > > > > machine is designed to get parsed this way.
> > >
> > > I thought I would give everyone an update: we are getting close to
> > > finishing patches to enable this term list parsing by default as well
> > > as a few other fixes with forward referencing of package elements.
> > > Once we have established that these patches are stable, we will get
> > > rid of acpi_gbl_parse_table_as_term_list. So this quirk may not be
> > needed in the near future...
> > 
> > Rafael,
> > 
> > Would you be opposed to carrying a patch similar to this (proposed)
> > quirk patch in kernel and reverting when Erik submits patches that get
> > rid of acpi_gbl_parse_table_as_term_list?
> > 
> > The reason being, I think this could also be a candidate to bring back
> > to @stable and fix this problem on earlier kernels too.
> > 
> > I don’t believe the patches that get rid of
> > acpi_gbl_parse_table_as_term_list likely will be good candidates for
> > @stable.
> > 
> 
> 
> Does anyone remember what was the exact problem that forced the creation of
> parse_table_as_term_list in the first place?

I don't remember exactly, but it was related to the MLC code.

That was introduced by this kernel commit:

commit de56ba95e8d6d760910711744a548b50b3a4262d
Author: Lv Zheng <lv.zheng@intel.com>
Date:   Wed Sep 7 14:06:54 2016 +0800

    ACPICA: Interpreter: Fix MLC issues by switching to new term_list grammar for table loading
    
    ACPICA commit 0e24fb67cde08d7df7671d7d7b183490dc79707e

which has a very detailed changelog including links to several bug entries.

Thanks,
Rafael
