Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2822914-1522257344-3-2428371209082199892
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
    t=1522257343; b=g3URW4VWk93eMskE+IiVI7Je546muE+vBWPs6X7wsMA63GT
    fe5IJjbglIWO3/84cyo0PM9lBTACpDuwxD0goM0tP/aXxd3zcTAGng7+XHKJi+jl
    vSYFggONQruYf2MZAuyZfM0sf4Ti3tcMRtYy0DEO/gept/gqGKAvwdS4RWcQiFk7
    Grg5Ewxdzcr3Ff4HRmssropRCjnm2MJRZodz45UomJfIm+NhbNf0c44m94frl/zo
    wxhdIn7WehX9iYHGua0avSpJKyPP66kQiPc44CXqPLC8eklnE4A20bdOzfKSX3Gd
    Pq45DJhnJ+2PNpHHlumO+69zrbOAbFzbJOY97kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1522257343; bh=l4N65b
    S5mR64Zx9/pxtfVN5RKfdIbNXnKi3rQK1lsCo=; b=dLft8MD/Q1aaSCta0864vK
    BNC2TaOpRg/jbKNY19jy8DPK0e3If+jd5aPdJHQiF11u3jvgzb5xm5GeiFMdo/Bs
    NiNCXa3ji3KAtp0LPehonhfberadjuW6xyK6hN5Eh1kp5N3KlCnX82HIyS87cpxp
    70geyp0NtBhnIXLnNul4TziBRHjpKLzmCfRXF1pCmVrs9YzPO8Nxd5kZZ7OM8oWy
    QvWtCv1oSbTgVgKckbQ8O5OHVi/tMTDIG0ZFXJ+LY3Kj4a3TiCkjP2uyHeYzZbhh
    BVDA/hJaAPFfgma6HxWCRvgYCtpnz6OfuqdOiqPLshGzGI19ZSA04h/xDf0QQniQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfGoz4bumKuT2zz2yBEuOL1kbQ7+eb7YfJSqAVxUVISqtcp7+HJ7omB8VfnQewcg1X23xftg5F8wRXSL/c/26hyQscy9s5cBhMpgCWQDx8kNWqVGbkAcs
    fNb64LDFgTmNRylljTtCaNK0QN9cqeZqjwZB78jaVlN1tPexdme2K2IPFGdl2qtUJM48cEHPMLAdRJELG4TUHVFquQ+MQ5PTFPJoQLZAaXXuBWVgPxww55pm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EbVHfS3oRaoA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=iLNU1ar6AAAA:8 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=dAfFFqthLXJ0uOMwgysA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753120AbeC1RPk convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Mar 2018 13:15:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:35797 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753089AbeC1RPk (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 13:15:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,372,1517904000";
   d="scan'208";a="41501355"
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
Thread-Index: AQHTv5xaTVO5Yc6WFEyJ+eHwrZ3EpqPiKMtAgAPIEIA=
Date: Wed, 28 Mar 2018 17:15:38 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B758206C@ORSMSX110.amr.corp.intel.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
 <20180319160513.16384-93-alexander.levin@microsoft.com>
 <bc4e6f52fc2d45b5b7672c22aaa4dc55@ausx13mpc120.AMER.DELL.COM>
In-Reply-To: <bc4e6f52fc2d45b5b7672c22aaa4dc55@ausx13mpc120.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmI5MjlhZjMtZjA0YS00NTA1LWFiZTMtYzZjNTQ3ZDBkMjYwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiIrUVhLUERQbzFhMTc2eUEwQ0VOS0RuemNJUE5zMWlDNzFEa0VoTTdrUUxoaWJXMVJWcHRORDZFZVVIRHRSYXpMIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
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
> Sent: Monday, March 26, 2018 12:30 AM
> To: Alexander.Levin@microsoft.com; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Cc: Moore, Robert <robert.moore@intel.com>; Schmauss, Erik
> <erik.schmauss@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>
> Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the
> Windows 10 version 1607 and 1703 OSI strings
> 
> > -----Original Message-----
> > From: Sasha Levin [mailto:Alexander.Levin@microsoft.com]
> > Sent: Monday, March 19, 2018 11:07 AM
> > To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
> > Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Bob Moore
> > <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>;
> Rafael J .
> > Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
> > <Alexander.Levin@microsoft.com>
> > Subject: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows
> > 10 version 1607 and 1703 OSI strings
> >
> > From: Mario Limonciello <mario.limonciello@dell.com>
> >
> > [ Upstream commit bc4d413a819f9d0764a80a55875a5d7e1f4efed4 ]
> >
> > ACPICA commit 35a4a3ea723b3066f575e63e5f0116f7ce65e713
> >
> > The public Microsoft document listing recognized OSI strings [1] shows
> > that these two strings were introduced.
> > version 1607 / Anniversary Update / "Redstone 1"
> > version 1703 / Creators Update / "Redstone 2"
> >
> > [1]
> > http://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a97e-
> > ce7ce0d98dc2/winacpi_osi.docx
> >
> > Link: https://github.com/acpica/acpica/commit/35a4a3ea
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > ---
> >  drivers/acpi/acpica/utosi.c | 2 ++
> >  include/acpi/actypes.h      | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
> > index 8f3d203aed79..51d9011b5b33 100644
> > --- a/drivers/acpi/acpica/utosi.c
> > +++ b/drivers/acpi/acpica/utosi.c
> > @@ -101,6 +101,8 @@ static struct acpi_interface_info
> > acpi_default_supported_interfaces[] = {
> >  	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server
> > 2012 - Added 08/2012 */
> >  	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and
> Server
> > 2012 R2 - Added 01/2014 */
> >  	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 -
> Added
> > 03/2015 */
> > +	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10
> > version 1607 - Added 12/2017 */
> > +	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10
> > version 1703 - Added 12/2017 */
> >
> >  	/* Feature Group Strings */
> >
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h index
> > f914958c4adb..d27bc051f47f 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -1284,6 +1284,8 @@ typedef enum {
> >  #define ACPI_OSI_WIN_7                  0x0B
> >  #define ACPI_OSI_WIN_8                  0x0C
> >  #define ACPI_OSI_WIN_10                 0x0D
> > +#define ACPI_OSI_WIN_10_RS1             0x0E
> > +#define ACPI_OSI_WIN_10_RS2             0x0F
> >
> >  /* Definitions of file IO */
> >
> > --
> > 2.14.1
> 
> I don't believe that it would be a good idea to bring back this patch to
> kernels older than 4.15.  These strings do activate some extra features
> in Windows and some BIOS ASL has been written to only activate them when
> the newer Windows versions are detected. I have no concerns bringing
> them to 4.15 though.
> 
> Bringing them back to stable may introduce other problems that requires
> backporting additional driver changes too.

[Moore, Robert] 

There should be no problem with this change concerning older machines. The firmware on these machines will simply never call _OSI with any strings newer than when the firmware was written -- including this new one.

Bob
