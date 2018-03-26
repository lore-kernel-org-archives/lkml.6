Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-372244-1522049438-2-10440213599916354113
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
    t=1522049437; b=i8LGU645U99tKefrKDH1eGyOo/CzEoWJVOEnl9xWs+9DsgQ
    NXLGKotKKobYiTsUpixh+GpTNRWae3RZ17e2/cmiueZrAkfBYdYcSTXUx/dBshyG
    vRC2JqX5MGbke/7Fmv9GJoO0UkC1b5HJul5rylItdn9ySmCRkYfnbx0sdtqMokSl
    gPzjtvs+1tN4c/1fUIwmQevMhK6yppQaHFTIQEzOJalPRobOHHrTEOcL5Vb5OK4D
    h+xJztc6rZZA0xXCDeXb9JwryZ4H+9lTGU+x304LTU9/RhVBu9yyV7XxfbmsAdUU
    8+0htwVlYJHakdCpOthb+IZauUJbloqaiabWSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1522049437; bh=kg5Uyl
    mmOUdZHNF0/w6uRabr7lBWslNn/ok19a1VvRc=; b=haHgKmOEQCgCAWFb1hwBtn
    vmTkHkqWNHA1XQaCKSjjZgw9KMbmv43MbWre195poPvvJBhYMTZiExGKCsCNlrrk
    tEfCp/e+lEGfd5itwwoLa6DaXNSY5JLA6Tzxg5WE6VYYQz8Eorrzc6h3e2oqxSLj
    KyO/JXtLG1wtmJ+Soh3U7O2EXk6vyKvYG9n9HktJ4Qb+FydktGyjKjjA8GLy+7R3
    L/ieunO2BKwyVfLEP56ZlymnFuOAP97gBVeUfnxwQn3xH5pmoWzMBvPIzaBVKkZX
    ahqZ11gWrynebB3hvSD1D8DTrHglZftKypvEvJT8hWzqWZQn7L4wWKmov91DqU+g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com header.b=moXt8C2B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=smtpout;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=dell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com header.b=moXt8C2B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=smtpout;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=dell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM1vlfHoNX8HmG0qlhhCEw5tE2EtjFOKEj9lwRjVrL2IWj4JOOeHIpmvN0UZ09i2fFfnTqSlEmfnr1gzEeK31APgw6B6w92KH1MMoQXZrlupltQ0wRY1
    SGB6zwII4zoOgLwtTyr0DdoTDHQOaufbqVHPr/IvrFu/2PRb9fd4mSKvHaSKh+iJotFFIvcO/NSs86z/ofRQkEqilSETGsLkL7N9EVjS0x4TAIkCW1KsZoNP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wCHvqnb4SGkA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=iLNU1ar6AAAA:8
    a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=_e9451T5AyU8L2fV36UA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeCZHae (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 03:30:34 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:5032 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750928AbeCZHad (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Mar 2018 03:30:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EzAADHoLhamMqZ6EReGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQUDnAoCotSjQ00gUCBEZJRgUk9CyMJhA1MAoN4ITQYAQIBAQEBAQE?=
 =?us-ascii?q?CAQIQAQEBAQEICwsGKCMMgjgiDQRLIQgBAi8BAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBBwINOAsCGAEBAQQ6PwwEAgEIEQQBAR8FBAdGAwEFCAI?=
 =?us-ascii?q?EAQ0FCIUGD6l4EYNAiD2CGodYghSBDIMHgxMCA4EUMR2FTgOXPwiFUohXgTg5i?=
 =?us-ascii?q?lCHJoEiS4QegkWBJRyCC3CDEgmCJhyDNIpRbwGPEYEXAQE?=
X-IPAS-Result: =?us-ascii?q?A2EzAADHoLhamMqZ6EReGgEBAQEBAgEBAQEIAQEBAYQUDnA?=
 =?us-ascii?q?oCotSjQ00gUCBEZJRgUk9CyMJhA1MAoN4ITQYAQIBAQEBAQECAQIQAQEBAQEIC?=
 =?us-ascii?q?wsGKCMMgjgiDQRLIQgBAi8BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBBwINOAsCGAEBAQQ6PwwEAgEIEQQBAR8FBAdGAwEFCAIEAQ0FCIUGD6l4E?=
 =?us-ascii?q?YNAiD2CGodYghSBDIMHgxMCA4EUMR2FTgOXPwiFUohXgTg5ilCHJoEiS4QegkW?=
 =?us-ascii?q?BJRyCC3CDEgmCJhyDNIpRbwGPEYEXAQE?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.48,364,1517896800";
   d="scan'208";a="157141401"
X-DLP: DLP_GlobalPCIDSS
To: <Alexander.Levin@microsoft.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC: <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Topic: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Index: AQHTv5xaTVO5Yc6WFEyJ+eHwrZ3EpqPiKMtA
Date: Mon, 26 Mar 2018 07:30:24 +0000
Message-ID: <bc4e6f52fc2d45b5b7672c22aaa4dc55@ausx13mpc120.AMER.DELL.COM>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
 <20180319160513.16384-93-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-93-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: Sasha Levin [mailto:Alexander.Levin@microsoft.com]
> Sent: Monday, March 19, 2018 11:07 AM
> To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Bob Moore
> <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>; Rafael=
 J .
> Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>
> Subject: [PATCH AUTOSEL for 4.4 093/167] ACPICA: Recognize the Windows 10
> version 1607 and 1703 OSI strings
>=20
> From: Mario Limonciello <mario.limonciello@dell.com>
>=20
> [ Upstream commit bc4d413a819f9d0764a80a55875a5d7e1f4efed4 ]
>=20
> ACPICA commit 35a4a3ea723b3066f575e63e5f0116f7ce65e713
>=20
> The public Microsoft document listing recognized OSI strings [1]
> shows that these two strings were introduced.
> version 1607 / Anniversary Update / "Redstone 1"
> version 1703 / Creators Update / "Redstone 2"
>=20
> [1] http://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a97e-
> ce7ce0d98dc2/winacpi_osi.docx
>=20
> Link: https://github.com/acpica/acpica/commit/35a4a3ea
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  drivers/acpi/acpica/utosi.c | 2 ++
>  include/acpi/actypes.h      | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
> index 8f3d203aed79..51d9011b5b33 100644
> --- a/drivers/acpi/acpica/utosi.c
> +++ b/drivers/acpi/acpica/utosi.c
> @@ -101,6 +101,8 @@ static struct acpi_interface_info
> acpi_default_supported_interfaces[] =3D {
>  	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server
> 2012 - Added 08/2012 */
>  	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and Server
> 2012 R2 - Added 01/2014 */
>  	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 - Added
> 03/2015 */
> +	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10
> version 1607 - Added 12/2017 */
> +	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10
> version 1703 - Added 12/2017 */
>=20
>  	/* Feature Group Strings */
>=20
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index f914958c4adb..d27bc051f47f 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1284,6 +1284,8 @@ typedef enum {
>  #define ACPI_OSI_WIN_7                  0x0B
>  #define ACPI_OSI_WIN_8                  0x0C
>  #define ACPI_OSI_WIN_10                 0x0D
> +#define ACPI_OSI_WIN_10_RS1             0x0E
> +#define ACPI_OSI_WIN_10_RS2             0x0F
>=20
>  /* Definitions of file IO */
>=20
> --
> 2.14.1

I don't believe that it would be a good idea to bring back this patch to ke=
rnels older
than 4.15.  These strings do activate some extra features in Windows and so=
me BIOS
ASL has been written to only activate them when the newer Windows versions =
are
detected. I have no concerns bringing them to 4.15 though.

Bringing them back to stable may introduce other problems that requires bac=
kporting
additional driver changes too.
