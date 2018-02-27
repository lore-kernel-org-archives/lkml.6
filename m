Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeB0SDc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:03:32 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:34496 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751679AbeB0SD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:03:28 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HTAABLnJVah8mZ6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmgQAoCoNKmCGCAoEWhyGNCYIVCoUyAhqCMlYWAQIBAQEBAQE?=
 =?us-ascii?q?CAQIQAQEBCgsJCCgvgjgigkoBAQEBAyMRRQwEAgEIEQQBAQECAiMDAgICHyUBC?=
 =?us-ascii?q?AgCBA4FCIR1AxWsEYInhzMNgTCCFgEBAQEBAQEDAQEBAQEBASGBD4Y7gz2DLYJ?=
 =?us-ascii?q?qgj4QIxKCQYJiBZoeMAmNOIMwgW+ENIhaijOHHYEuJAGCA3CDEoJDEAwWgWV3i?=
 =?us-ascii?q?zuBFwEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HTAABLnJVah8mZ6EReGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mgQAoCoNKmCGCAoEWhyGNCYIVCoUyAhqCMlYWAQIBAQEBAQECAQIQAQEBCgsJC?=
 =?us-ascii?q?CgvgjgigkoBAQEBAyMRRQwEAgEIEQQBAQECAiMDAgICHyUBCAgCBA4FCIR1AxW?=
 =?us-ascii?q?sEYInhzMNgTCCFgEBAQEBAQEDAQEBAQEBASGBD4Y7gz2DLYJqgj4QIxKCQYJiB?=
 =?us-ascii?q?ZoeMAmNOIMwgW+ENIhaijOHHYEuJAGCA3CDEoJDEAwWgWV3izuBFwEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.47,401,1515477600";
   d="scan'208";a="623692136"
X-DLP: DLP_GlobalPCIDSS
To: <andy.shevchenko@gmail.com>
CC: <dvhart@infradead.org>, <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Topic: [PATCH v2 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Index: AQHTr/UdMlgwnVF6RkmgvUVNpj824KO4ioGA
Date: Tue, 27 Feb 2018 18:03:25 +0000
Message-ID: <162f864ef8814432a9027ec6d9fcfb58@ausx13mpc124.AMER.DELL.COM>
References: <1519753659-3376-1-git-send-email-mario.limonciello@dell.com>
 <1519753659-3376-3-git-send-email-mario.limonciello@dell.com>
 <CAHp75VcpkO8=iF=pXhbyaR_kP+kPhmr1AEQM-CwGuL78Z7T1Bg@mail.gmail.com>
In-Reply-To: <CAHp75VcpkO8=iF=pXhbyaR_kP+kPhmr1AEQM-CwGuL78Z7T1Bg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RI3dn6009443

> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> Sent: Tuesday, February 27, 2018 12:02 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Darren Hart <dvhart@infradead.org>; Pali Rohár <pali.rohar@gmail.com>;
> LKML <linux-kernel@vger.kernel.org>; Platform Driver <platform-driver-
> x86@vger.kernel.org>
> Subject: Re: [PATCH v2 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
> modules together
> 
> On Tue, Feb 27, 2018 at 7:47 PM, Mario Limonciello
> <mario.limonciello@dell.com> wrote:
> > Some race conditions were raised due to dell-smbios and its backends
> > not being ready by the time that a consumer would call one of the
> > exported methods.
> >
> > To avoid this problem, guarantee that all initialization has been
> > done by linking them all together and running init for them all.
> >
> > As part of this change the Kconfig needs to be adjusted so that
> > CONFIG_DELL_SMBIOS_SMM and CONFIG_DELL_SMBIOS_WMI are boolean
> > rather than modules.
> >
> > CONFIG_DELL_SMBIOS is a visually selectable option again and both
> > CONFIG_DELL_SMBIOS_WMI and CONFIG_DELL_SMBIOS_SMM are optional.
> 
> > changes from v1:
> >  * Move #ifdefs into dell-smbios.h and use static inline functions
> 
> > --- a/drivers/platform/x86/dell-smbios-smm.c
> > +++ b/drivers/platform/x86/dell-smbios-smm.c
> 
> > +#ifdef CONFIG_DELL_SMBIOS_SMM
> 
> Hmm... It's still here.
> 
> Hint: in Makefile you need something like
> 
> obj-$(CONFIG_DELL_SMBIOS_SMM) += dell-smbios-smm.o

Thanks makes sense.  Will adjust again.

> 
> > +#endif /* CONFIG_DELL_SMBIOS_SMM */
> 
> > --- a/drivers/platform/x86/dell-smbios-wmi.c
> > +++ b/drivers/platform/x86/dell-smbios-wmi.c
> 
> > +#ifdef CONFIG_DELL_SMBIOS_WMI
> 
> Ditto.
> 
> > +#endif /* CONFIG_DELL_SMBIOS_WMI */
> 
> 
> > +#ifdef CONFIG_DELL_SMBIOS_WMI
> > +int init_dell_smbios_wmi(void);
> > +void exit_dell_smbios_wmi(void);
> > +#else /* CONFIG_DELL_SMBIOS_WMI */
> > +static inline int init_dell_smbios_wmi(void)
> > +{
> > +       return -ENODEV;
> > +}
> 
> > +static inline void exit_dell_smbios_wmi(void)
> > +{}
> 
> One line, please.
> 
> > +#endif /* CONFIG_DELL_SMBIOS_WMI */
> > +
> > +#ifdef CONFIG_DELL_SMBIOS_SMM
> > +int init_dell_smbios_smm(void);
> > +void exit_dell_smbios_smm(void);
> > +#else /* CONFIG_DELL_SMBIOS_SMM */
> > +static inline int init_dell_smbios_smm(void)
> > +{
> > +       return -ENODEV;
> > +}
> 
> > +static inline void exit_dell_smbios_smm(void)
> > +{}
> 
> Ditto.
> 
> > +#endif /* CONFIG_DELL_SMBIOS_SMM */
> 
> --
> With Best Regards,
> Andy Shevchenko
