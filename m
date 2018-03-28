Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2822914-1522257515-2-10612951628930430860
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
    t=1522257514; b=N1rbX0mrckpC4a716zSQMqHSBdhfAfrOUMt/VerngX4bm4l
    0dV9XwyfK3YAyx8JFWpOF06IyEjI5toP8LEQdgdXEjhYBAP3zztilzEbFwMrf01h
    tAVwm0GXwVB1AeHjhnXinCxHOGUT4gX80njZZ+7l6OXNykg+bX+gn0QGHkn2DVBd
    UxNAbJZZTKtlbWeBTBJoUjA/5wD5p5EIgeObbR3Vl/7i1yf5vaCtlrjLIEYBkBhK
    YkFs1SGVqFZlijcDb9C1IgRsc7tkEgEbIhvev3QLLb0Rq7Xdic897Hc22OwPO9JB
    K3ZeIXPsInr1UByA5rtrAC6TVFKcWQF/MP4pI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1522257514; bh=lHbSSG
    I1V7iQbQdNlTy0er/OUw40WywI+eP5kxWlESw=; b=YTemRktqSnyQvGZjjTV1pq
    d3yc65LgtNyxzkgSaB7lU3vSay+VD9JTSx24UYywD+kz0KPX5b9xyW1BXF0durO1
    Gj2J9aTgxUzpT+LP4iCPzf31OnnyQw8vvMOB8W1qc+Rg5Lh8wNO2axisGY1J/qx6
    Yr0+vtJnmzdU2GQZZ8R0jQyIGmy8q9FYYv16B1oyf2uu2Ne0kIwA7E//OpR0pp6u
    XuXYF/B9z9Fj55ocpgzFfFZAipv/xW6klBe35xHXMK7RZlm83SKjisCKB9YaGtfa
    RAcSo3WQyFk0yaGPSO4+1L0IA1P5MRNvNhCcKydz/42FtwTDV7BVCkLFoDw+2bEg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com header.b=z9WTJCg/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=smtpout;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=dell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com header.b=z9WTJCg/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=smtpout;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=dell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO32jjI+2O2cYwrileWOAGr1A2AAIrIO+8ZqakfXIUP9GOYWenNdoNsE+Flg0zHjTYisshL0hxY8RevtOHpF3REBg61cF79eipVng8KhKa0BMKIYASfQ
    XPurPMckIj0Z7YdTYmPu3wV3qLYm+q1nt9YxE/7oHiws42UZiF1rrNkvzkmmdwrNHx8gFmYgHBSYr2xtQubCRI0EJVnUBpeXIey6NiK8mEND1qFn46RlwkNj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4Lw6A-RbomMA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=QyXUC8HyAAAA:8 a=iLNU1ar6AAAA:8 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=3ockf_e_wCieMyH0AYQA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeC1RSb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 13:18:31 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:2028 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751219AbeC1RSa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 13:18:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FAAACNzbtamMqZ6ERdGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQibygKi1KNATSBQIEPkkqBQDoLIwiEDUwChA0hNBgBAgEBAQEBAQI?=
 =?us-ascii?q?BAhABAQEBAQgLCwYoIwyCOCINBEshCAECLwEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEHAg04CwIYAQEBBDo/DAQCAQgRBAEBHwUEB0YDAQUIAgQ?=
 =?us-ascii?q?BDQUIhQYPqj8RgzyIRYIph16CE4EMgwSDEQIDgRIxHYVNAotui0UIhVGIT4E3O?=
 =?us-ascii?q?YpJhySBIUyEIoJEgSUcggtwgxIJgiUagzSKUW8BjliBFwEB?=
X-IPAS-Result: =?us-ascii?q?A2FAAACNzbtamMqZ6ERdGgEBAQEBAgEBAQEIAQEBAYQibyg?=
 =?us-ascii?q?Ki1KNATSBQIEPkkqBQDoLIwiEDUwChA0hNBgBAgEBAQEBAQIBAhABAQEBAQgLC?=
 =?us-ascii?q?wYoIwyCOCINBEshCAECLwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEHAg04CwIYAQEBBDo/DAQCAQgRBAEBHwUEB0YDAQUIAgQBDQUIhQYPqj8Rg?=
 =?us-ascii?q?zyIRYIph16CE4EMgwSDEQIDgRIxHYVNAotui0UIhVGIT4E3OYpJhySBIUyEIoJ?=
 =?us-ascii?q?EgSUcggtwgxIJgiUagzSKUW8BjliBFwEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.48,372,1517896800";
   d="scan'208";a="157494710"
X-DLP: DLP_GlobalPCIDSS
To: <robert.moore@intel.com>, <Alexander.Levin@microsoft.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: <erik.schmauss@intel.com>, <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Topic: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Index: AQHTv5xaTVO5Yc6WFEyJ+eHwrZ3EpqPiKMtAgAPIEICAAAEjcA==
Date: Wed, 28 Mar 2018 17:18:27 +0000
Message-ID: <9e270b49c2e44d5684c04b3eef68a72c@ausx13mpc120.AMER.DELL.COM>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
 <20180319160513.16384-93-alexander.levin@microsoft.com>
 <bc4e6f52fc2d45b5b7672c22aaa4dc55@ausx13mpc120.AMER.DELL.COM>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B758206C@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B758206C@ORSMSX110.amr.corp.intel.com>
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
> Sent: Wednesday, March 28, 2018 12:16 PM
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
> > Sent: Monday, March 26, 2018 12:30 AM
> > To: Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> > stable@vger.kernel.org
> > Cc: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> > <erik.schmauss@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>
> > Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> > Windows 10 version 1607 and 1703 OSI strings
> >
> > > -----Original Message-----
> > > From: Sasha Levin [mailto:Alexander.Levin@microsoft.com]
> > > Sent: Monday, March 19, 2018 11:07 AM
> > > To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Bob Moore
> > > <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>;
> > Rafael J .
> > > Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
> > > <Alexander.Levin@microsoft.com>
> > > Subject: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Window=
s
> > > 10 version 1607 and 1703 OSI strings
> > >
> > > From: Mario Limonciello <mario.limonciello@dell.com>
> > >
> > > [ Upstream commit bc4d413a819f9d0764a80a55875a5d7e1f4efed4 ]
> > >
> > > ACPICA commit 35a4a3ea723b3066f575e63e5f0116f7ce65e713
> > >
> > > The public Microsoft document listing recognized OSI strings [1] show=
s
> > > that these two strings were introduced.
> > > version 1607 / Anniversary Update / "Redstone 1"
> > > version 1703 / Creators Update / "Redstone 2"
> > >
> > > [1]
> > > http://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a97e-
> > > ce7ce0d98dc2/winacpi_osi.docx
> > >
> > > Link: https://github.com/acpica/acpica/commit/35a4a3ea
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > ---
> > >  drivers/acpi/acpica/utosi.c | 2 ++
> > >  include/acpi/actypes.h      | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.=
c
> > > index 8f3d203aed79..51d9011b5b33 100644
> > > --- a/drivers/acpi/acpica/utosi.c
> > > +++ b/drivers/acpi/acpica/utosi.c
> > > @@ -101,6 +101,8 @@ static struct acpi_interface_info
> > > acpi_default_supported_interfaces[] =3D {
> > >  	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server
> > > 2012 - Added 08/2012 */
> > >  	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and
> > Server
> > > 2012 R2 - Added 01/2014 */
> > >  	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 -
> > Added
> > > 03/2015 */
> > > +	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10
> > > version 1607 - Added 12/2017 */
> > > +	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10
> > > version 1703 - Added 12/2017 */
> > >
> > >  	/* Feature Group Strings */
> > >
> > > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > > f914958c4adb..d27bc051f47f 100644
> > > --- a/include/acpi/actypes.h
> > > +++ b/include/acpi/actypes.h
> > > @@ -1284,6 +1284,8 @@ typedef enum {
> > >  #define ACPI_OSI_WIN_7                  0x0B
> > >  #define ACPI_OSI_WIN_8                  0x0C
> > >  #define ACPI_OSI_WIN_10                 0x0D
> > > +#define ACPI_OSI_WIN_10_RS1             0x0E
> > > +#define ACPI_OSI_WIN_10_RS2             0x0F
> > >
> > >  /* Definitions of file IO */
> > >
> > > --
> > > 2.14.1
> >
> > I don't believe that it would be a good idea to bring back this patch t=
o
> > kernels older than 4.15.  These strings do activate some extra features
> > in Windows and some BIOS ASL has been written to only activate them whe=
n
> > the newer Windows versions are detected. I have no concerns bringing
> > them to 4.15 though.
> >
> > Bringing them back to stable may introduce other problems that requires
> > backporting additional driver changes too.
>=20
> [Moore, Robert]
>=20
> There should be no problem with this change concerning older machines. Th=
e
> firmware on these machines will simply never call _OSI with any strings n=
ewer than
> when the firmware was written -- including this new one.
>=20
> Bob

Actually I'm referring to "newer" machines that do have this string in the =
firmware
but the changes in the kernel that are relevant to the string didn't land u=
ntil newer
kernels.

I think it's a pretty good risk for regressions on those older stable kerne=
ls as such.
