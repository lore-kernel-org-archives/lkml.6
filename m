Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeBGNrl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:47:41 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:42543 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754394AbeBGNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:47:37 -0500
X-Google-Smtp-Source: AH8x224u6Kf5hjkHkvgotnmY2mnzlZ8yTAJGav8w8juKmbOBvcF4YdQeNHbdZ1iPk5aJ45PSUjG8xmfB9yWboaoygv4=
MIME-Version: 1.0
In-Reply-To: <d72f1065c98d4073b3f112cf8538f508@ausx13mpc120.AMER.DELL.COM>
References: <20180125224857.3622-1-alexander.n.abrosimov@gmail.com>
 <20180125230239.GA3736@fury> <20180125230615.akr2nvmmrqzfo53q@pali> <d72f1065c98d4073b3f112cf8538f508@ausx13mpc120.AMER.DELL.COM>
From: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>
Date: Wed, 7 Feb 2018 16:47:36 +0300
Message-ID: <CACKjtf6eiFXeBzzfO=cjkBru4j0M3YLtAJ1b7e_nv13k1e0A8Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Add 2-in-1 devices to the DMI whitelist
To: Darren Hart <dvhart@infradead.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Mario.Limonciello@dell.com, Matthew Garrett <mjg59@srcf.ucam.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w17DljSo013398

Darren, I have checked change on git.kernel.org and it seems to be merged twice:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/x86/dell-laptop.c?id=fe486138788ba435ffa918c8d7aba05a77b6289a

How it can be fixed?

2018-01-26 17:42 GMT+03:00 <Mario.Limonciello@dell.com>:
>
> > -----Original Message-----
> > From: Pali Rohár [mailto:pali.rohar@gmail.com]
> > Sent: Thursday, January 25, 2018 5:06 PM
> > To: Darren Hart <dvhart@infradead.org>
> > Cc: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>; Matthew Garrett
> > <mjg59@srcf.ucam.org>; Limonciello, Mario <Mario_Limonciello@Dell.com>; Andy
> > Shevchenko <andy@infradead.org>; platform-driver-x86@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] platform/x86: dell-laptop: Add 2-in-1 devices to the DMI
> > whitelist
> >
> > On Thursday 25 January 2018 15:02:39 Darren Hart wrote:
> > > On Fri, Jan 26, 2018 at 01:48:57AM +0300, Alexander Abrosimov wrote:
> > > > SMBIOS 3.0.0 Specification introduced new Chassis Types field values for
> > > > 2-in-1 devices like tablets, convertibles and detachables. Dell's
> > > > Inspiron 2-in-1 and XPS 2-in-1 fall into this category and they have to
> > > > be added to the DMI whitelist, so rfkill and backlight can be controlled
> > > > for them as for other laptops.
> > > >
> > > > Signed-off-by: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>
> > >
> > > Thanks Alexander. Looks good - just going to give Pali and +Mario a chance to
> > > respond before merging...
> >
> > I have no comments for this. This should be confirmed by Mario or
> > somebody else from Dell, which DMI names are used for a new products.
>
> Yes these chassis types from SMBIOS 3.0 are covered by Dell specs and used for
> some products.
>
> This patch looks good to me.
>
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
> >
> > > > ---
> > > >  drivers/platform/x86/dell-laptop.c | 18 ++++++++++++++++++
> > > >  1 file changed, 18 insertions(+)
> > > >
> > > > diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-
> > laptop.c
> > > > index cd4725e7e0b5..23fc94d70ea1 100644
> > > > --- a/drivers/platform/x86/dell-laptop.c
> > > > +++ b/drivers/platform/x86/dell-laptop.c
> > > > @@ -110,6 +110,24 @@ static const struct dmi_system_id dell_device_table[]
> > __initconst = {
> > > >           },
> > > >   },
> > > >   {
> > > > +         .matches = {
> > > > +                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > +                 DMI_MATCH(DMI_CHASSIS_TYPE, "30"), /*Tablet*/
> > > > +         },
> > > > + },
> > > > + {
> > > > +         .matches = {
> > > > +                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > +                 DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /*Convertible*/
> > > > +         },
> > > > + },
> > > > + {
> > > > +         .matches = {
> > > > +                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > +                 DMI_MATCH(DMI_CHASSIS_TYPE, "32"), /*Detachable*/
> > > > +         },
> > > > + },
> > > > + {
> > > >           .ident = "Dell Computer Corporation",
> > > >           .matches = {
> > > >                   DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer
> > Corporation"),
> > > > --
> > > > 2.13.6
> > > >
> > > >
> > >
> >
> > --
> > Pali Rohár
> > pali.rohar@gmail.com




-- 
Best Regards,
Abrosimov Alexander, mailto:alexander.n.abrosimov@gmail.com
