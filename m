Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245532-3-7330407841858863902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245531; b=NYwdlVwrvR0YH/xLMaILRpahRL7+gUJsjPhS+384cN/kAQ9arS
    LPEvJzJ8E3KdNXsEu5vz9cL9VdMA2kigkgV30kJSXhOO1xFMVPxdVEpnsbZYd42b
    c6hE/wyim6g6YzN63Xpgf75Cdfcg5NmwGxj5d6zs3Kr9ap0Oy8pwaeefpIdHur0P
    wkAipoIO6mF039RfIt3G7tsXjdx0VngNq+LzpVlX6tuJGizCFZix1CxwCn0GvVv3
    f7it2aW9IoW9n5PmGOYNhIC/7b1HSsRfqImP/j/E5ioB9JLkueyqeRqEg04PdjMv
    z0GVbgOWeNB6IRj5vMjnFWyaOIjiGHl4ZRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245531; bh=S3QQqobTJ7
    hDOpzu5RgBG4MoH11YSNieTLs2xR6CnIE=; b=t0uYdl5LsosV05zQZzwM2omw58
    KNor15r2qVzC4/24lOUL96XHk45Ft7ZyXzKa2jsLces+M6CarzUbs+b5WzUPKHNT
    8IGbE+cL780mm09oeYxO4RCcqiqJxej39QPhaoXWgPn2iRDo0ByX+yHQB+mG66+j
    2dZyslsTqWEffYXxxW8S54Vm6Xr1RGnO+e4IjIsIrO/846YonPjxglY43vwFR3x3
    nwEc7zDnMsHsiIx9xj3Y8KgXT1V9dDfXJsPoJnYyUvKp5N7HGbRLF39aKrsY6Jkk
    iUyb3TCzxv2Ufx3qxhY0mRIdzGHiGUmpK2d2TR89glmXVbYhye2p1drxXNFg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lxGBGqyp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lxGBGqyp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBZVObQxn6Vn4Ezp6AqlUD/cgWXK8YMmF6kEXAAnLc8J+ruymGJlIrrEdn0P9A21xlzwf41rHw4C5Tr3Z9Qt0I0JBV4Ek8fbbM4uTon5iHs1K50/1WRh
    K5efixhTTH/Ab8sN/GwGBXrQL1IsuWLj3fZd94yNFLG5/MBWLFazALKpeImaOI5HrdCSWczFyJd3FZ8Bd6E74bspHF7CbboM9QHgC82699kzJYg3YpWxtVRt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=iGbCS3zQAAAA:8 a=bv4rzfeZVU7aaL2aLaYA:9 a=6sajjAAjhuskInPx:21
    a=vmhlu8lV-3mZ9uS2:21 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=oRZS8w7TM5j8Y1SnqK-S:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754241AbeDIDod (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:44:33 -0400
Received: from mail-dm3nam03on0097.outbound.protection.outlook.com ([104.47.41.97]:45238
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753783AbeDIAUW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Parag Warudkar <parag.warudkar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 142/189] firmware: dmi_scan: Fix handling of
 empty DMI strings
Thread-Topic: [PATCH AUTOSEL for 4.15 142/189] firmware: dmi_scan: Fix
 handling of empty DMI strings
Thread-Index: AQHTz5hQBhMhxEMTO0WPtYNVp2XM1g==
Date: Mon, 9 Apr 2018 00:18:42 +0000
Message-ID: <20180409001637.162453-142-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:hXDmqYKXm/2gEJHFDZbM9Dv9QQrhmJzD5EsRrAZVAMmxRLZlo9+IlgpfENTdcHP86Jb0xw8eMQZtm/+GozXEH4tEBwj+uoC6Bya4au/EXPyehjcrVC+0CDqqvkI98k9B7fY2GnZ/YoOtt8NT9dCxdmO2r66a4iH8J+yX51qA1TKfilyaxcGq6muzdIkV51dxPHPtSQ33fQ5q6X3z0iJjx0eFfp9sPozksxeJYdNKew2DG8ZkpwhyFdbOiBPBUBIC;20:ZfrXZhbZQycXLuUN27W21jO18+qwx9GmSWRr06qNNR+H8Z9KHrElDHRyzIBFlw6AuYYtqkFt6+RjQ0hVaCMdf41MH94HvAYWDWjyM13CdA2B5y62lVmoDGcXXJRPf2LL/3lyH9goQPjttS0qBXcy9saTo2o2WncInpE8qtTW8Hs=
X-MS-Office365-Filtering-Correlation-Id: cdcb1e7b-634e-4b4a-baa2-08d59dafade1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092056C924A869C8D479C3B5FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(1720100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(39060400002)(6666003)(6512007)(4326008)(107886003)(6306002)(5660300001)(478600001)(6436002)(105586002)(10290500003)(966005)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 23lwmbXE67c6ZKGW+SGquI6nOSaDkCvtnEw2JaefsIQEgC/xj2H5dF/u0WDVaOU+YYohO2Ct1ph5IDnNQg/WDMkh6FjSgTqAZsnF2/i80C4J5ONx9fb9/Oagn12WiPNvKZEWXqy70Wa/Heei3wtij34CYYMJMVQxByEbHTuFWpxtCaThaoT0N5tMAjVpupfE+fnoSc3x3Cf3grlex/k5D19rVq1oKBsihBwQZVKg2fCj/Ghd4P88aEG6O7enzmm6JDeWmNGsGMqvqLZQVCehBpy3kBzjazNUKNLHLt7n7AUTxZBIFABClpqp4lp8D0xzZm1WJd9jUMHwU0ijM8PpSeazn50GNIb9u44fZDxApZXQHfcbvbbEYr0ALB4ZopbdZZCTZoeZoeJApaC0hdhcRoZqG80/wJ87eTW1kQlr0fM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcb1e7b-634e-4b4a-baa2-08d59dafade1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:42.7844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit a7770ae194569e96a93c48aceb304edded9cc648 ]

The handling of empty DMI strings looks quite broken to me:
* Strings from 1 to 7 spaces are not considered empty.
* True empty DMI strings (string index set to 0) are not considered
  empty, and result in allocating a 0-char string.
* Strings with invalid index also result in allocating a 0-char
  string.
* Strings starting with 8 spaces are all considered empty, even if
  non-space characters follow (sounds like a weird thing to do, but
  I have actually seen occurrences of this in DMI tables before.)
* Strings which are considered empty are reported as 8 spaces,
  instead of being actually empty.

Some of these issues are the result of an off-by-one error in memcmp,
the rest is incorrect by design.

So let's get it square: missing strings and strings made of only
spaces, regardless of their length, should be treated as empty and
no memory should be allocated for them. All other strings are
non-empty and should be allocated.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 79da4721117f ("x86: fix DMI out of memory problems")
Cc: Parag Warudkar <parag.warudkar@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/dmi_scan.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 783041964439..e8db9659a36b 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -18,7 +18,7 @@ EXPORT_SYMBOL_GPL(dmi_kobj);
  * of and an antecedent to, SMBIOS, which stands for System
  * Management BIOS.  See further: http://www.dmtf.org/standards
  */
-static const char dmi_empty_string[] =3D "        ";
+static const char dmi_empty_string[] =3D "";
=20
 static u32 dmi_ver __initdata;
 static u32 dmi_len;
@@ -44,25 +44,21 @@ static int dmi_memdev_nr;
 static const char * __init dmi_string_nosave(const struct dmi_header *dm, =
u8 s)
 {
 	const u8 *bp =3D ((u8 *) dm) + dm->length;
+	const u8 *nsp;
=20
 	if (s) {
-		s--;
-		while (s > 0 && *bp) {
+		while (--s > 0 && *bp)
 			bp +=3D strlen(bp) + 1;
-			s--;
-		}
-
-		if (*bp !=3D 0) {
-			size_t len =3D strlen(bp)+1;
-			size_t cmp_len =3D len > 8 ? 8 : len;
=20
-			if (!memcmp(bp, dmi_empty_string, cmp_len))
-				return dmi_empty_string;
+		/* Strings containing only spaces are considered empty */
+		nsp =3D bp;
+		while (*nsp =3D=3D ' ')
+			nsp++;
+		if (*nsp !=3D '\0')
 			return bp;
-		}
 	}
=20
-	return "";
+	return dmi_empty_string;
 }
=20
 static const char * __init dmi_string(const struct dmi_header *dm, u8 s)
--=20
2.15.1
