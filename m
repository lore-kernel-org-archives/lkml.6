Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeB0QNT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:13:19 -0500
Received: from esa8.dell-outbound.iphmx.com ([68.232.149.218]:55032 "EHLO
        esa8.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752281AbeB0QNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:13:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HVAADVgpVah2Oa6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmEHAoCoNKmCGCAoEWhyGNCYFTQgolhQ0CGoIyVhYBAgEBAQE?=
 =?us-ascii?q?BAQIBAhABAQEKCwkIKC+COCINBEsqLwEBAQEBAQEBAQEBAQEBARoCDV0BAQEBA?=
 =?us-ascii?q?yMRRQwEAgEIEQQBAQECAiMDAgICHyUBCAgCBA4FCIR1AxUQqzKCJ4czDYEwghQ?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEYBYEPhjuDPYMtgmpEAgKBdhAjEoJBgmIFm?=
 =?us-ascii?q?h4wCYZQhmiDMI59iXo5hx2BLiUEgX9wgxKCQxAMFoFld4s7gRcBAQE?=
X-IPAS-Result: =?us-ascii?q?A2HVAADVgpVah2Oa6EReGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mEHAoCoNKmCGCAoEWhyGNCYFTQgolhQ0CGoIyVhYBAgEBAQEBAQIBAhABAQEKC?=
 =?us-ascii?q?wkIKC+COCINBEsqLwEBAQEBAQEBAQEBAQEBARoCDV0BAQEBAyMRRQwEAgEIEQQ?=
 =?us-ascii?q?BAQECAiMDAgICHyUBCAgCBA4FCIR1AxUQqzKCJ4czDYEwghQBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEYBYEPhjuDPYMtgmpEAgKBdhAjEoJBgmIFmh4wCYZQhmiDMI5?=
 =?us-ascii?q?9iXo5hx2BLiUEgX9wgxKCQxAMFoFld4s7gRcBAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.47,401,1515477600";
   d="scan'208";a="1221590566"
X-DLP: DLP_GlobalPCIDSS
To: <andy.shevchenko@gmail.com>
CC: <dvhart@infradead.org>, <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Topic: [PATCH 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Thread-Index: AQHTr+VUitA7yqQUn0mRpGoyYCsa26O4avDg
Date: Tue, 27 Feb 2018 16:13:11 +0000
Message-ID: <92c22f39a7df439a9e18cb975eec086e@ausx13mpc124.AMER.DELL.COM>
References: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
 <1519747014-17561-3-git-send-email-mario.limonciello@dell.com>
 <CAHp75VcNWo0Mh8jYU0vV+RRt3ZudKns_ZStcp_7ueebJfwL_nQ@mail.gmail.com>
In-Reply-To: <CAHp75VcNWo0Mh8jYU0vV+RRt3ZudKns_ZStcp_7ueebJfwL_nQ@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RGDQcW032630

> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> Sent: Tuesday, February 27, 2018 10:09 AM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: Darren Hart <dvhart@infradead.org>; Pali Rohár <pali.rohar@gmail.com>;
> LKML <linux-kernel@vger.kernel.org>; Platform Driver <platform-driver-
> x86@vger.kernel.org>
> Subject: Re: [PATCH 3/3] platform/x86: dell-smbios: Link all dell-smbios-* modules
> together
> 
> On Tue, Feb 27, 2018 at 5:56 PM, Mario Limonciello
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
> 
> > --- a/drivers/platform/x86/dell-smbios-smm.c
> > +++ b/drivers/platform/x86/dell-smbios-smm.c
> 
> > +#ifdef CONFIG_DELL_SMBIOS_SMM
> 
> > +#else /* CONFIG_DELL_SMBIOS_SMM */
> > +int init_dell_smbios_smm(void)
> > +{
> > +       return -ENODEV;
> > +}
> 
> > +void exit_dell_smbios_smm(void)
> > +{}
> > +#endif /* CONFIG_DELL_SMBIOS_SMM */
> 
> > --- a/drivers/platform/x86/dell-smbios-wmi.c
> > +++ b/drivers/platform/x86/dell-smbios-wmi.c
> 
> > +#ifdef CONFIG_DELL_SMBIOS_WMI
> 
> > +#else /* CONFIG_DELL_SMBIOS_WMI */
> > +int init_dell_smbios_wmi(void)
> > +{
> > +       return -ENODEV;
> > +}
> > +
> > +void exit_dell_smbios_wmi(void)
> > +{}
> > +#endif /* CONFIG_DELL_SMBIOS_WMI */
> 
> It's rather strange to see above in *.c and not in *.h where it's
> usually supposed to be...

Thanks that was my original thought too, but I was following
the style that I had seen in drivers/input/mouse which is 
used for psmouse/synaptics.
Eg: https://github.com/torvalds/linux/blob/master/drivers/input/mouse/synaptics.c#L1692

> 
> > --- a/drivers/platform/x86/dell-smbios.h
> > +++ b/drivers/platform/x86/dell-smbios.h
> > @@ -75,4 +75,10 @@ int dell_laptop_register_notifier(struct notifier_block
> *nb);
> >  int dell_laptop_unregister_notifier(struct notifier_block *nb);
> >  void dell_laptop_call_notifier(unsigned long action, void *data);
> >
> > +/* for the supported backends */
> > +int init_dell_smbios_wmi(void);
> > +void exit_dell_smbios_wmi(void);
> > +int init_dell_smbios_smm(void);
> > +void exit_dell_smbios_smm(void);
> > +
> 
> ...here...

So do you mean you would rather see inline functions in header
file for the #else case then?
