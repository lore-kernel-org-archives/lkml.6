Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3143389-1522267395-2-14542330375038082425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522267394; b=AlgyBaW4uONrB6T4XgC8ldDFhF2JXPx9xbk7EP66lOptCNh
    NpCZmhggk9N7uvG01KUUGSV23oq8dOl0pjuy5tM1IhUwjofyHKInvjxTDD0JGTvS
    taygyapCfHOIr0s0N0TqPrFqA49ZtjHDruhjl+mHfVaTdDMnYVRXzEfkkhYmoz3Y
    LR0QV5sjSGgalYxcmAS1WLJqC3cZX0f4z4+PE7AO8SspMV4FrMb8y6KLowLQogTr
    M54BQpij7J45mJonEMK2U9eXxfX1MuZnu1wN1IlKCQ5X9DWVjRDgEGaFq+YYiRLI
    nXRuM9e+WvupG5RVH8BnVImn7Y4j53E5Igj0biA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1522267394; bh=0sL7q3
    AAJc0iBYWRkmWa1u8xUl1/hcCm2dkSMLk9LDw=; b=ZTREH+4iaeeWbM2VnSukoI
    lFuZVL0c+8eyKCr0PnFim6064WGGAbaxtFoEeD9H3j23Hh5U0oD6KP6MtfIrbvYX
    LKopRPqaR1VJCQvJ/GaEbpRUVrxTQd2YfBMeHurerQ4cOVJ+iACJOOwMrZbnIYgi
    h7UQtknX9PffxfxKm7hIcSlG/ato3HZIJA8Sg83J01nuergM+iymepafDJiWXMAc
    0g+P6IqoKl5PRpP9YEzEY3V0KXGecPAtZhNRnKOjhgUqV1Pjhz2sGNCmcwTL5L/V
    bBqddmpiEWydMKHvW+lw1OaFgKNPj5oB4834JZ+5HS8b37u+IBdJaYCay3h99QWg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com header.b=Kl0ZfCmn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=smtpout;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=dell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com header.b=Kl0ZfCmn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=smtpout;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=dell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIhl2y2snaTIDDPSvK7DN63sL6JnvGLwMWGWQ7tchyIYIJDvwg8nr4HaWaD4XSP9ofmEjVQmHSCLgxYrmLzrl65kva/jj1iqxa5Jad2hYL8LlZU4QN6i
    hFZhUIWbD5+6DrnJnscYHfftpyki+vd8cAyn2RKsHouvPYM4UEtrIyvnRoIZyjtaFUf5W1nLoEF1ftYSKFPi7Ybh2Gsng3cFNSqdADeljaLS1Rx5VAca2gVA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4Lw6A-RbomMA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8 a=iLNU1ar6AAAA:8 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=8_78wO1itBvVElYAFScA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeC1UDM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 16:03:12 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:54316 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753155AbeC1UDL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 16:03:11 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FAAAA19Ltah8uZ6ERdGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQibygKi1KNATSBQIEPkkqBQDoLIwiEDUwChA0hNBgBAgEBAQEBAQI?=
 =?us-ascii?q?BAhABAQEKCwkIKCMMgjgiDQRLIQgBAi8BAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBBwINOAsCGAEBAQMBOj8MBAIBCBEEAQEfBQQHRgMBBQgCBAE?=
 =?us-ascii?q?NBQiEfggPqiIRgzyIRIIph16CE4EMgwSDEQIDgRIxHYVNAotui0UIhVGIT4E3O?=
 =?us-ascii?q?YpJhySBIUyEIoJEgSUcggtwgxIJgiUagzSKUW8BjliBFwEB?=
X-IPAS-Result: =?us-ascii?q?A2FAAAA19Ltah8uZ6ERdGgEBAQEBAgEBAQEIAQEBAYQibyg?=
 =?us-ascii?q?Ki1KNATSBQIEPkkqBQDoLIwiEDUwChA0hNBgBAgEBAQEBAQIBAhABAQEKCwkIK?=
 =?us-ascii?q?CMMgjgiDQRLIQgBAi8BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BBwINOAsCGAEBAQMBOj8MBAIBCBEEAQEfBQQHRgMBBQgCBAENBQiEfggPqiIRg?=
 =?us-ascii?q?zyIRIIph16CE4EMgwSDEQIDgRIxHYVNAotui0UIhVGIT4E3OYpJhySBIUyEIoJ?=
 =?us-ascii?q?EgSUcggtwgxIJgiUagzSKUW8BjliBFwEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.48,372,1517896800";
   d="scan'208";a="158866611"
X-DLP: DLP_GlobalPCIDSS
To: <robert.moore@intel.com>, <Alexander.Levin@microsoft.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: <erik.schmauss@intel.com>, <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Topic: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Index: AQHTv5xaTVO5Yc6WFEyJ+eHwrZ3EpqPiKMtAgAPIEICAAAEjcIAAKyYAgAACYEA=
Date: Wed, 28 Mar 2018 20:03:08 +0000
Message-ID: <7121663c27dd4e48822f58b2239eb57b@ausx13mpc120.AMER.DELL.COM>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
 <20180319160513.16384-93-alexander.levin@microsoft.com>
 <bc4e6f52fc2d45b5b7672c22aaa4dc55@ausx13mpc120.AMER.DELL.COM>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B758206C@ORSMSX110.amr.corp.intel.com>
 <9e270b49c2e44d5684c04b3eef68a72c@ausx13mpc120.AMER.DELL.COM>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B75820C7@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B75820C7@ORSMSX110.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Moore, Robert [mailto:robert.moore@intel.com]
> Sent: Wednesday, March 28, 2018 2:53 PM
> To: Limonciello, Mario <Mario_Limonciello@Dell.com>;
> Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Cc: Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>
> Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Window=
s 10
> version 1607 and 1703 OSI strings
>=20
>=20
>=20
> > -----Original Message-----
> > From: Mario.Limonciello@dell.com [mailto:Mario.Limonciello@dell.com]
> > Sent: Wednesday, March 28, 2018 10:18 AM
> > To: Moore, Robert <robert.moore@intel.com>;
> > Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> > stable@vger.kernel.org
> > Cc: Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>
> > Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> > Windows 10 version 1607 and 1703 OSI strings
> >
> > > -----Original Message-----
> > > From: Moore, Robert [mailto:robert.moore@intel.com]
> > > Sent: Wednesday, March 28, 2018 12:16 PM
> > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>;
> > > Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> > > stable@vger.kernel.org
> > > Cc: Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>
> > > Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> > > Windows 10 version 1607 and 1703 OSI strings
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Mario.Limonciello@dell.com [mailto:Mario.Limonciello@dell.com=
]
> > > > Sent: Monday, March 26, 2018 12:30 AM
> > > > To: Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> > > > stable@vger.kernel.org
> > > > Cc: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> > > > <erik.schmauss@intel.com>; Wysocki, Rafael J
> > > > <rafael.j.wysocki@intel.com>
> > > > Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> > > > Windows 10 version 1607 and 1703 OSI strings
> > > >
> > > > > -----Original Message-----
> > > > > From: Sasha Levin [mailto:Alexander.Levin@microsoft.com]
> > > > > Sent: Monday, March 19, 2018 11:07 AM
> > > > > To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > > > > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Bob Moore
> > > > > <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>=
;
> > > > Rafael J .
> > > > > Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
> > > > > <Alexander.Levin@microsoft.com>
> > > > > Subject: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> > > > > Windows
> > > > > 10 version 1607 and 1703 OSI strings
> > > > >
> > > > > From: Mario Limonciello <mario.limonciello@dell.com>
> > > > >
> > > > > [ Upstream commit bc4d413a819f9d0764a80a55875a5d7e1f4efed4 ]
> > > > >
> > > > > ACPICA commit 35a4a3ea723b3066f575e63e5f0116f7ce65e713
> > > > >
> > > > > The public Microsoft document listing recognized OSI strings [1]
> > > > > shows that these two strings were introduced.
> > > > > version 1607 / Anniversary Update / "Redstone 1"
> > > > > version 1703 / Creators Update / "Redstone 2"
> > > > >
> > > > > [1]
> > > > > http://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a=
9
> > > > > 7e-
> > > > > ce7ce0d98dc2/winacpi_osi.docx
> > > > >
> > > > > Link: https://github.com/acpica/acpica/commit/35a4a3ea
> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > > > > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > > > ---
> > > > >  drivers/acpi/acpica/utosi.c | 2 ++
> > > > >  include/acpi/actypes.h      | 2 ++
> > > > >  2 files changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/acpi/acpica/utosi.c
> > > > > b/drivers/acpi/acpica/utosi.c index 8f3d203aed79..51d9011b5b33
> > > > > 100644
> > > > > --- a/drivers/acpi/acpica/utosi.c
> > > > > +++ b/drivers/acpi/acpica/utosi.c
> > > > > @@ -101,6 +101,8 @@ static struct acpi_interface_info
> > > > > acpi_default_supported_interfaces[] =3D {
> > > > >  	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and
> > Server
> > > > > 2012 - Added 08/2012 */
> > > > >  	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and
> > > > Server
> > > > > 2012 R2 - Added 01/2014 */
> > > > >  	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10
> > -
> > > > Added
> > > > > 03/2015 */
> > > > > +	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/*
> Windows 10
> > > > > version 1607 - Added 12/2017 */
> > > > > +	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/*
> Windows 10
> > > > > version 1703 - Added 12/2017 */
> > > > >
> > > > >  	/* Feature Group Strings */
> > > > >
> > > > > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h inde=
x
> > > > > f914958c4adb..d27bc051f47f 100644
> > > > > --- a/include/acpi/actypes.h
> > > > > +++ b/include/acpi/actypes.h
> > > > > @@ -1284,6 +1284,8 @@ typedef enum {
> > > > >  #define ACPI_OSI_WIN_7                  0x0B
> > > > >  #define ACPI_OSI_WIN_8                  0x0C
> > > > >  #define ACPI_OSI_WIN_10                 0x0D
> > > > > +#define ACPI_OSI_WIN_10_RS1             0x0E
> > > > > +#define ACPI_OSI_WIN_10_RS2             0x0F
> > > > >
> > > > >  /* Definitions of file IO */
> > > > >
> > > > > --
> > > > > 2.14.1
> > > >
> > > > I don't believe that it would be a good idea to bring back this
> > > > patch to kernels older than 4.15.  These strings do activate some
> > > > extra features in Windows and some BIOS ASL has been written to onl=
y
> > > > activate them when the newer Windows versions are detected. I have
> > > > no concerns bringing them to 4.15 though.
> > > >
> > > > Bringing them back to stable may introduce other problems that
> > > > requires backporting additional driver changes too.
> > >
> > > [Moore, Robert]
> > >
> > > There should be no problem with this change concerning older machines=
.
> > > The firmware on these machines will simply never call _OSI with any
> > > strings newer than when the firmware was written -- including this ne=
w
> > one.
> > >
> > > Bob
> >
> > Actually I'm referring to "newer" machines that do have this string in
> > the firmware but the changes in the kernel that are relevant to the
> > string didn't land until newer kernels.
> >
> > I think it's a pretty good risk for regressions on those older stable
> > kernels as such.
>=20
> I don't think I have heard of any issues like this in the past, but I cou=
ld be wrong.
> You might look into the past when other new strings have been added to AC=
PICA.
> We add a new string every 1-2 years, depending when MS releases a new one=
.
>=20

I don't believe this has been problematic in the past, but because of Micro=
soft's
accelerated release model with Windows 10, new strings have been introduced
more frequently for the new versions.  You can see that in just the last 2 =
years
there are 3 new strings across 5 versions of Windows 10.
