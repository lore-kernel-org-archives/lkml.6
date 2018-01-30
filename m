Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeA3UJH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:09:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:5750 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752899AbeA3UJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:09:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,436,1511856000";
   d="scan'208";a="15640222"
From: "Moore, Robert" <robert.moore@intel.com>
To: "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>
CC: "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: Parse entire table as a term_list for Dell XPS
 9570 and Precision M5530
Thread-Topic: [PATCH] ACPI: Parse entire table as a term_list for Dell XPS
 9570 and Precision M5530
Thread-Index: AQHTmZC6rNttyuuvQkOUdxhOtkKTxaONQEaA//97iTCAAJEbgP//jAkg
Date: Tue, 30 Jan 2018 20:09:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B756CED7@ORSMSX110.amr.corp.intel.com>
References: <20180130060744.19049-1-kai.heng.feng@canonical.com>
 <CAHp75VdPQuEwNOOakvZpC1gzWB9p5yx+CHUjRgMDZ9ZDvxGckQ@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED5396EE01A@ORSMSX110.amr.corp.intel.com>
 <9f0eaaf403014137a123f6676ddac5b9@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <9f0eaaf403014137a123f6676ddac5b9@ausx13mpc120.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTQ0ZDI2N2QtN2VkNC00ZjA5LThkM2QtM2YyZTMzYTVjMzI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJZS2VkTkR1NXlzTGFaTTdRbnFVdGV3R3gzY2lDcHc2VFdocW9Md3F6YVFRS25NbUxnaUVDdmg4RFZBdFFXMDBVIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UK9C7W026331



> -----Original Message-----
> From: Mario.Limonciello@dell.com [mailto:Mario.Limonciello@dell.com]
> Sent: Tuesday, January 30, 2018 11:03 AM
> To: Schmauss, Erik <erik.schmauss@intel.com>; andy.shevchenko@gmail.com;
> kai.heng.feng@canonical.com
> Cc: rjw@rjwysocki.net; lenb@kernel.org; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; Moore, Robert <robert.moore@intel.com>
> Subject: RE: [PATCH] ACPI: Parse entire table as a term_list for Dell
> XPS 9570 and Precision M5530
> 
> 
> 
> > -----Original Message-----
> > From: Schmauss, Erik [mailto:erik.schmauss@intel.com]
> > Sent: Tuesday, January 30, 2018 12:38 PM
> > To: Andy Shevchenko <andy.shevchenko@gmail.com>; Kai-Heng Feng
> > <kai.heng.feng@canonical.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown
> > <lenb@kernel.org>; ACPI Devel Maling List
> > <linux-acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Limonciello, Mario
> > <Mario_Limonciello@Dell.com>; Moore, Robert <robert.moore@intel.com>
> > Subject: RE: [PATCH] ACPI: Parse entire table as a term_list for Dell
> > XPS 9570 and Precision M5530
> >
> > Hi,
> > > -----Original Message-----
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > owner@vger.kernel.org] On Behalf Of Andy Shevchenko
> > > Sent: Tuesday, January 30, 2018 10:18 AM
> > > To: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown
> > > <lenb@kernel.org>; ACPI Devel Maling List
> > > <linux-acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; Mario Limonciello
> > > <mario.limonciello@dell.com>
> > > Subject: Re: [PATCH] ACPI: Parse entire table as a term_list for
> > > Dell XPS 9570 and Precision M5530
> > >
> > > On Tue, Jan 30, 2018 at 8:07 AM, Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > > The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work
> > > > out of box.
> > > >
> > > > The touchpad relies on its _INI method to update its _HID value
> > > > from
> > > > XXXX0000 to SYNA2393.
> > > > Also, the _STA relies on value of I2CN to report correct status.
> > > >
> > > > Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
> > > > correctly set up, and _INI can get run. The ACPI table in this
> > > > machine is designed to get parsed this way.
> >
> > I thought I would give everyone an update: we are getting close to
> > finishing patches to enable this term list parsing by default as well
> > as a few other fixes with forward referencing of package elements.
> > Once we have established that these patches are stable, we will get
> > rid of acpi_gbl_parse_table_as_term_list. So this quirk may not be
> needed in the near future...
> 
> Rafael,
> 
> Would you be opposed to carrying a patch similar to this (proposed)
> quirk patch in kernel and reverting when Erik submits patches that get
> rid of acpi_gbl_parse_table_as_term_list?
> 
> The reason being, I think this could also be a candidate to bring back
> to @stable and fix this problem on earlier kernels too.
> 
> I don’t believe the patches that get rid of
> acpi_gbl_parse_table_as_term_list likely will be good candidates for
> @stable.
> 


Does anyone remember what was the exact problem that forced the creation of parse_table_as_term_list in the first place?

Bob


> 
> >
> > Erik
> > > >
> > > > Also, change the quirk table to a more generic name.
> > >
> > > > +static int set_gbl_term_list(const struct dmi_system_id *id) {
> > > > +       pr_notice("%s detected - parse the entire table as a
> term_list\n",
> > > > +                 id->ident);
> > > > +       acpi_gbl_parse_table_as_term_list = 1;
> > > > +       return 0;
> > > > +}
> > > >  #endif
> > >
> > > The above should be outside of another #ifdef. Basically after the
> above #endif.
> > >
> > > >  #else
> > >
> > > >  #endif
> > >
> > > > @@ -1005,7 +1034,7 @@ void __init acpi_early_init(void)
> > >
> > > >          * If the machine falls into the DMI check table,
> > > >          * DSDT will be copied to memory
> > > >          */
> > >
> > > It might make sense to adjust comment above that it's about quirks
> in general.
> > > And, if needed, move current content to actual DMI group of records.
> > >
> > > > -       dmi_check_system(dsdt_dmi_table);
> > > > +       dmi_check_system(acpi_quirks_dmi_table);
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-acpi" in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at http://vger.kernel.org/majordomo-info.html
