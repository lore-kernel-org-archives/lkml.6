Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-646354-1522056198-2-12077128485250111880
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
    t=1522056198; b=M9/IU+H31niqQncnm8cKe0RZmr2LeALssWq/kcb6V1SCp4E
    TcoahhzFf7g1qn1Kl5juEzFGe/JqAqgloZvFLn3GNZsykZjZ7cBPEtcvZu99ysOi
    t2mRUFkM/KOsamwivJIqiPUbuh3p1fBjRkvwHH2eqFuiZqb7jtw0VJdham/4bKLB
    hhgrOyUPXQxKQ+sKQC5fp8NkUZ7fvOfM4//HYPHUCBOleJZ9wAC/YEkaOTBizy1k
    hYLVixpUYxPokMmHOQBaicSgKRQYXBa0LaZTE4f+m56qZxnaUxZ6TUsDMO1QzFvs
    6eo9ktUK2DKeP5M8ecFOhV+bryLznsA5VVYw5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1522056198; bh=7b131v
    sVrrq5qpChvtuYE+EiwrS5RaacJMc4ERijIEY=; b=aGYXmsI7yokEiMaohe6PA5
    KJWnOklsv0f40gyF1rMXHih+Q8LnRNked5OqjciANWB8G51KM0bUD+ZXrIBJrgbm
    vtuR9OPt4UrdGaiR0LDfo24WC20DcaH92aH2gyI8S60Eo0IbguXyVSc+NYD5W6U+
    WGS4oV4n9ReHn9Ebl2ThlIRpdNZGIJIjaUTyR5MjfJTpgSRHrDJDADq8NUTzSEOs
    0QFg0rCjWm4ZAjRgmoA9wGdbGCl02vUkBY6ucOBzoSaIyfhwFkWX8eYddo4Bfsix
    V0r0SnCYRn4uMkIKAIwEKu/9bKfO6US9w2NnnNURyGwa5TMAIfuvk5rCNjwKJdaA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com header.b=jYrgpH/l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=smtpout;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=dell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=dell.com header.i=@dell.com header.b=jYrgpH/l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=smtpout;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=dell.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dell.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE+4xYZE0eDHaQ2I7NxydH3VwpOtxAwp21Et0j+s22kdZ506K9Lt4eDTs9UHq4RipMbA9cBeZaQtXz8yduhCBUK1iUfZtUi+k/+nXA4Ul9Mt2OL6bXTr
    TlNZ0yk/R9oian5/C4lIwgSOJN/II2sN6R1psYdLKeClnZGANYnbEGAcdgamGktmJAH6gDkFlDeZpE5aYEHwRcNzDZuj4z7foqC0AGSNT1O+/aC+zeSOKIXr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wCHvqnb4SGkA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8 a=iLNU1ar6AAAA:8
    a=QyXUC8HyAAAA:8 a=NEAV23lmAAAA:8 a=gnDlLK7X971D4A0utR0A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeCZJXP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 05:23:15 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:6136 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750864AbeCZJXO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Mar 2018 05:23:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EzAADnuLhamMqZ6EReGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQUDnAoCotSjQ00gUCBEZJRFIE1PQsjCYQNTAKDeiE0GAECAQEBAQE?=
 =?us-ascii?q?BAgECEAEBAQEBCAsLBigjDII4Ig0ESyEIAQIvAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQcCDTgLAhgBAQEEOj8MBAIBCBEEAQEfBQQHRgMBBQg?=
 =?us-ascii?q?CBAENBQiFBg+pPRGDQIg9ghqHWIIUgQyDB4MTAgOBFBQBEgEJHYVOA5c/CIVSi?=
 =?us-ascii?q?FeBODmKUIcmgSJLhB6CRYElHIEacXCDEgmCJhyDNIpRbwGNcYEggRcBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EzAADnuLhamMqZ6EReGgEBAQEBAgEBAQEIAQEBAYQUDnA?=
 =?us-ascii?q?oCotSjQ00gUCBEZJRFIE1PQsjCYQNTAKDeiE0GAECAQEBAQEBAgECEAEBAQEBC?=
 =?us-ascii?q?AsLBigjDII4Ig0ESyEIAQIvAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcCDTgLAhgBAQEEOj8MBAIBCBEEAQEfBQQHRgMBBQgCBAENBQiFBg+pP?=
 =?us-ascii?q?RGDQIg9ghqHWIIUgQyDB4MTAgOBFBQBEgEJHYVOA5c/CIVSiFeBODmKUIcmgSJ?=
 =?us-ascii?q?LhB6CRYElHIEacXCDEgmCJhyDNIpRbwGNcYEggRcBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.195
X-IronPort-AV: E=Sophos;i="5.48,364,1517896800";
   d="scan'208";a="1233475981"
X-DLP: DLP_GlobalPCIDSS
To: <Alexander.Levin@microsoft.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC: <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH AUTOSEL for 4.15 050/124] ACPICA: Recognize the Windows 10
 version 1607 and 1703 OSI strings
Thread-Topic: [PATCH AUTOSEL for 4.15 050/124] ACPICA: Recognize the Windows
 10 version 1607 and 1703 OSI strings
Thread-Index: AQHTv5mjS5s9T/qcp0eNCtacHINC9KPiRbIA
Date: Mon, 26 Mar 2018 09:12:03 +0000
Message-ID: <9e47cad5d0144285864141c298e8c27c@ausx13mpc120.AMER.DELL.COM>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-50-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-50-alexander.levin@microsoft.com>
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
> Sent: Monday, March 19, 2018 10:48 AM
> To: linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; Bob Moore
> <robert.moore@intel.com>; Erik Schmauss <erik.schmauss@intel.com>; Rafael=
 J .
> Wysocki <rafael.j.wysocki@intel.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>
> Subject: [PATCH AUTOSEL for 4.15 050/124] ACPICA: Recognize the Windows 1=
0
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
> index 3175b133c0e4..f6b8dd24b006 100644
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
> index 4f077edb9b81..bfc8a814379a 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1299,6 +1299,8 @@ typedef enum {
>  #define ACPI_OSI_WIN_7                  0x0B
>  #define ACPI_OSI_WIN_8                  0x0C
>  #define ACPI_OSI_WIN_10                 0x0D
> +#define ACPI_OSI_WIN_10_RS1             0x0E
> +#define ACPI_OSI_WIN_10_RS2             0x0F
>=20
>  /* Definitions of getopt */
>=20
> --
> 2.14.1

This is fine by me for 4.15, as mentioned in other email I don't think it s=
hould go to 4.14, 4.9 or 4.4.
