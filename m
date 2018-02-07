Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbeBGJtm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:49:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57115 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeBGJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:49:40 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "andriy.shevchenko@linux.intel.com"
        <andriy.shevchenko@linux.intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "acelan.kao@canonical.com" <acelan.kao@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali.rohar@gmail.com" <pali.rohar@gmail.com>
Subject: Re: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI driver
Date: Wed, 07 Feb 2018 10:47:57 +0100
Message-ID: <4289605.mKSTaFlacu@aspire.rjw.lan>
In-Reply-To: <2235169.mLvk2uMpgf@aspire.rjw.lan>
References: <20180131182614.19524-1-andriy.shevchenko@linux.intel.com> <CAHp75VeFSuQYu67DdnJDjZDoaLZiPuo7ag7Lz0q6eSCDjayobw@mail.gmail.com> <2235169.mLvk2uMpgf@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 7, 2018 10:31:01 AM CET Rafael J. Wysocki wrote:
> On Tuesday, February 6, 2018 11:37:54 PM CET Andy Shevchenko wrote:
> > Yeah, that's fixed in the branch.
> > 
> > P.S. Apologies for top-posting, wrote from phone in order to not waste time
> > 
> > On Tuesday, February 6, 2018, <Mario.Limonciello@dell.com> wrote:
> > 
> > > > -----Original Message-----
> > > > From: platform-driver-x86-owner@vger.kernel.org [mailto:
> > > platform-driver-x86-
> > > > owner@vger.kernel.org] On Behalf Of Andy Shevchenko
> > > > Sent: Monday, February 5, 2018 10:18 AM
> > > > To: Darren Hart <dvhart@infradead.org>
> > > > Cc: platform-driver-x86@vger.kernel.org; AceLan Kao
> > > > <acelan.kao@canonical.com>; linux-kernel@vger.kernel.org;
> > > > pali.rohar@gmail.com; Limonciello, Mario <Mario_Limonciello@Dell.com>;
> > > Rafael
> > > > Wysocki <rjw@rjwysocki.net>
> > > > Subject: Re: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure
> > > ACPI driver
> > > >
> > > > On Wed, 2018-01-31 at 13:37 -0800, Darren Hart wrote:
> > > > > On Wed, Jan 31, 2018 at 08:26:14PM +0200, Andy Shevchenko wrote:
> > > > > > Remove code duplication by converting driver to pure ACPI one.
> > > > >
> > > >
> > > > I have fixed couple issues, but...
> > > >
> > > > > +Rafael
> > > > >
> > > > > I don't see any reason *not* to do this, it seems the acpi driver
> > > > > model provides
> > > > > some of the boilerplate stuff we were doing manually before as a
> > > > > platform
> > > > > device. I'm scratching my head wondering why we did this as a
> > > > > platform-driver in
> > > > > the first place now...
> 
> It looks like I have overlooked this.
> 
> Generally speaking, binding drivers to ACPI device objects is a bad idea,
> because it is sort of what binding drivers to struct device_node in OF would
> be.  It was an unfortunate design choice for struct acpi_device to be based
> on struct device in the first place, but undoing it is not worth the effort
> and pain.
> 
> In some instances (PCI, PNP, I2C, SPI etc) there is a device object to bind a
> driver to already and the corresponding struct acpi_device is the "companion"
> of it.  In those cases binding a driver to the struct acpi_device itself
> clearly doesn't make sense.
> 
> In the cases like the $subject one it is less clear, but for symmetry and
> general confusion avoidance it is better to have a struct device representing
> the "physical" thing *in* *addition* to the struct acpi_device and use the
> latter as the "companion" of it.  That's why we have the platform device in
> this particular case.
> 
> Please drop this patch, it doesn't go in the right direction IMO.

BTW, please CC patches with ACPI material to linux-acpi.  They are less likely
to be overlooked by me then and the others on that list may have opinions on
them too.
