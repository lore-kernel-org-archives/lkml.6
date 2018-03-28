Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3133726-1522266804-2-8631623504941670389
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522266803; b=XEfolMCZmP0HiskYZWicj1EsMly1JAD5/fxRZsY2Wv8tICJ
    amXIzJpwoUnaNPVZ7pdF+9aSMKmmXzN/rSCK+SwWN6trlNtMxGwpVgTe3CFQscMH
    fra9iOXJ3LKKrAFSRm4r8ckQxxZCyQpxlz/p/EthGg6ystUx8SVBcljuHJi+Fayo
    rhqO/ocQDWPoOT//0nZRTNfrjsamm7kuHXKmykfCdVZTRLv6gOrDU7sAWktqcT2i
    UMZcfUiuF3+wCbdSOl66rT2JKEh6/Llr4ZpmG7sEEaJLIwP2A2z+6l3FDjEqRpUX
    +ViibxYBIJBPtr3eFc/1uCKPXhG631WwZShdKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1522266803; bh=vSqSgN
    K5TJzuviqUBB5wmB+GqlY4gVE7DS7HM24Ydag=; b=WYncJ2INGn+HFKZxp+JdFv
    6IDuWNJ04VhKAZJxLjqwUcx9JEA5X/6E8ARznj+lnXmbgef1iCqBvjyDpCRqhHXV
    d2buNBvjuKWSUNt8uo3MUuQ7wXxyP6VVGZPu3jwnxgIXxQNni2Oul1KZqouko9s0
    0tSSIinT2lRiy9oE/TBp8Prfufg61zjxg7vO/nci04+Gr3V0wbYaP69bWLvOJ9No
    t1X7O3UXgLKbcALYbfawE0CxxmDwnfWS2Walt358D/0SISNztF8qsM/Jod590A+o
    +uRravDh6ih8lmEfbXbtyyUF82mhsz7QqZ95il1JdcIlKZclgHF5YI3BkRMKDPPQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEPBCo9HEOcfnj0wXnz5pjoWaKrlX02Jkm2dmYx40ak16p3H4EeaeOypuwbzM9bUHghxBUaCB7i+3hB3BpVTixs3RttjMnLIM/xEObNDFb+eacBYMkGU
    Pk7C6cKnARRmfv4MWoLU8mWz7v1fCjfSrsf3ClTaPf/8ar7pkHcv+fNGp+C8NRHST10YUOn/fDQbWOEIXb+kZMnl/pU/cXdI/h+faxDn3cgmo6EvNKyeySt/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=iyVJlZHfM7sA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=UnKIVadeYqiWKdxF4joA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeC1TxV convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Mar 2018 15:53:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:35064 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbeC1TxT (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 15:53:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="215723225"
From: "Moore, Robert" <robert.moore@intel.com>
To: "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "Alexander.Levin@microsoft.com" <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows
 10 version 1607 and 1703 OSI strings
Thread-Topic: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows
 10 version 1607 and 1703 OSI strings
Thread-Index: AQHTv5xaTVO5Yc6WFEyJ+eHwrZ3EpqPiKMtAgAPIEICAAAEjcIAAKyYA
Date: Wed, 28 Mar 2018 19:53:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B75820C7@ORSMSX110.amr.corp.intel.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
 <20180319160513.16384-93-alexander.levin@microsoft.com>
 <bc4e6f52fc2d45b5b7672c22aaa4dc55@ausx13mpc120.AMER.DELL.COM>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B758206C@ORSMSX110.amr.corp.intel.com>
 <9e270b49c2e44d5684c04b3eef68a72c@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <9e270b49c2e44d5684c04b3eef68a72c@ausx13mpc120.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzBjNTU4OTEtNWRmNi00OTA2LTg3YjgtYTI1NWUxNmI1NDkzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJlWlBZWDhyb0VrWDlkZUlwcGtJU1I4dWVOenJ0emhVUnpHd0h3VlppOFBwb1dZOWlpS0xObUZOVVhQc3Vka0dyIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Mario.Limonciello@dell.com [mailto:Mario.Limonciello@dell.com]
> Sent: Wednesday, March 28, 2018 10:18 AM
> To: Moore, Robert <robert.moore@intel.com>;
> Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Cc: Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>
> Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> Windows 10 version 1607 and 1703 OSI strings
> 
> > -----Original Message-----
> > From: Moore, Robert [mailto:robert.moore@intel.com]
> > Sent: Wednesday, March 28, 2018 12:16 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>;
> > Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> > stable@vger.kernel.org
> > Cc: Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>
> > Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> > Windows 10 version 1607 and 1703 OSI strings
> >
> >
> >
> > > -----Original Message-----
> > > From: Mario.Limonciello@dell.com [mailto:Mario.Limonciello@dell.com]
> > > Sent: Monday, March 26, 2018 12:30 AM
> > > To: Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> > > stable@vger.kernel.org
> > > Cc: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> > > <erik.schmauss@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>
> > > Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> > > Windows 10 version 1607 and 1703 OSI strings
> > >
> > > > -----Original Message-----
> > > > From: Sasha Levin [mailto:Alexander.Levin@microsoft.com]
> > > > Sent: Monday, March 19, 2018 11:07 AM
> > > > To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > > > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Bob Moore
> > > > <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>;
> > > Rafael J .
> > > > Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
> > > > <Alexander.Levin@microsoft.com>
> > > > Subject: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> > > > Windows
> > > > 10 version 1607 and 1703 OSI strings
> > > >
> > > > From: Mario Limonciello <mario.limonciello@dell.com>
> > > >
> > > > [ Upstream commit bc4d413a819f9d0764a80a55875a5d7e1f4efed4 ]
> > > >
> > > > ACPICA commit 35a4a3ea723b3066f575e63e5f0116f7ce65e713
> > > >
> > > > The public Microsoft document listing recognized OSI strings [1]
> > > > shows that these two strings were introduced.
> > > > version 1607 / Anniversary Update / "Redstone 1"
> > > > version 1703 / Creators Update / "Redstone 2"
> > > >
> > > > [1]
> > > > http://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a9
> > > > 7e-
> > > > ce7ce0d98dc2/winacpi_osi.docx
> > > >
> > > > Link: https://github.com/acpica/acpica/commit/35a4a3ea
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > > > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > > ---
> > > >  drivers/acpi/acpica/utosi.c | 2 ++
> > > >  include/acpi/actypes.h      | 2 ++
> > > >  2 files changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/acpi/acpica/utosi.c
> > > > b/drivers/acpi/acpica/utosi.c index 8f3d203aed79..51d9011b5b33
> > > > 100644
> > > > --- a/drivers/acpi/acpica/utosi.c
> > > > +++ b/drivers/acpi/acpica/utosi.c
> > > > @@ -101,6 +101,8 @@ static struct acpi_interface_info
> > > > acpi_default_supported_interfaces[] = {
> > > >  	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and
> Server
> > > > 2012 - Added 08/2012 */
> > > >  	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and
> > > Server
> > > > 2012 R2 - Added 01/2014 */
> > > >  	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10
> -
> > > Added
> > > > 03/2015 */
> > > > +	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10
> > > > version 1607 - Added 12/2017 */
> > > > +	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10
> > > > version 1703 - Added 12/2017 */
> > > >
> > > >  	/* Feature Group Strings */
> > > >
> > > > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > > > f914958c4adb..d27bc051f47f 100644
> > > > --- a/include/acpi/actypes.h
> > > > +++ b/include/acpi/actypes.h
> > > > @@ -1284,6 +1284,8 @@ typedef enum {
> > > >  #define ACPI_OSI_WIN_7                  0x0B
> > > >  #define ACPI_OSI_WIN_8                  0x0C
> > > >  #define ACPI_OSI_WIN_10                 0x0D
> > > > +#define ACPI_OSI_WIN_10_RS1             0x0E
> > > > +#define ACPI_OSI_WIN_10_RS2             0x0F
> > > >
> > > >  /* Definitions of file IO */
> > > >
> > > > --
> > > > 2.14.1
> > >
> > > I don't believe that it would be a good idea to bring back this
> > > patch to kernels older than 4.15.  These strings do activate some
> > > extra features in Windows and some BIOS ASL has been written to only
> > > activate them when the newer Windows versions are detected. I have
> > > no concerns bringing them to 4.15 though.
> > >
> > > Bringing them back to stable may introduce other problems that
> > > requires backporting additional driver changes too.
> >
> > [Moore, Robert]
> >
> > There should be no problem with this change concerning older machines.
> > The firmware on these machines will simply never call _OSI with any
> > strings newer than when the firmware was written -- including this new
> one.
> >
> > Bob
> 
> Actually I'm referring to "newer" machines that do have this string in
> the firmware but the changes in the kernel that are relevant to the
> string didn't land until newer kernels.
> 
> I think it's a pretty good risk for regressions on those older stable
> kernels as such.

I don't think I have heard of any issues like this in the past, but I could be wrong. You might look into the past when other new strings have been added to ACPICA. We add a new string every 1-2 years, depending when MS releases a new one.
