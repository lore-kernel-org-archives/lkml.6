Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234084-2-6135665858645820084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234083; b=eX5Nmlw3uT2FaDKO7AdLppB76NS0KsuL3q1DuAzgkLCYDUNcc7
    mxDEm6LcwsaEg9rdHM2qRKP6E10NuNCTzKesMxLNXoWL62Bq5HkXO0NWh9dQaAUI
    MNeD8JUWKYTbxVWugcpq10HOsoUrcEITPR4oEX2gDQ+Z1K53xemXQTHnNokeHTGt
    poshHOLDcFNr/iQkUbTVMf1hhCIyyw0EghbfFhdDH9WVDm8rBLto6LrU7AfwwJSm
    oEQ9IvrKx8sovbghHVcEsxczp5T6RclyXieOmQe4gfKW63MSiKNB+pRcPpbre9xt
    ZIhw+SODgSezOeEDkH55jqt8s8vrMFCd5MYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234083; bh=DTSg8iueH1
    onEpHLqVN56xwo+gqhReKQClqHLZXGJJE=; b=lmDWupT8vwpxcECCZtjVp2NeSO
    PDSS3resSvnl+Ghj/XPp+dizi/OjJzkkFmw2aT9bIj8QuCazKBWU/bTna5EIvxku
    Aa5b4FV3+C9QpiErQlVwHFlragnpAowKg0tVg6PnSpch/KSOw2Aup1WetOjrElvf
    0ULPMHlawq8KGV8qdYVcTI1WDIMFy6VB3cE4XOTyK9iY5gNxja7C0QTY/BRmr9bS
    POd6419rdojq7HsSSJ75YSijQhjSIaMcyKpGjTOJgdImdPNMwNtRCuz/FMYLnTQu
    aELIyizLtvRyzIQq5I38ClPpr7dcbQbLHSegoivtqHpqiGRDtvxIisijYazQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gGKhxZVG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gGKhxZVG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK71aTm9MXiW1cCpFuC6jjR/tyFLs/iA0kM/Ir9OTw6li+J2AbkfpCdz3KyD1hJXdSgUMYlatDvkrXarJyUgG4DfNfAQ5AmklCrhAuuYmOIMr5tsIh8f
    kP3e/ooSJOIpl1B/EwLSAXxDhi7/N1vXtNZmsG79XTaRyLI7/qmU8yAog5tiRtYFzyjX4UtV4i41AhPJHKZ0kOLesK4EfdRd4erF/SJmhcR2i4PIaM6UNJ2n
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
        id S932425AbeDIAeZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:34:25 -0400
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:2685
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932258AbeDIAeI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Parag Warudkar <parag.warudkar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 269/293] firmware: dmi_scan: Fix handling of
 empty DMI strings
Thread-Topic: [PATCH AUTOSEL for 4.9 269/293] firmware: dmi_scan: Fix handling
 of empty DMI strings
Thread-Index: AQHTz5lkQ5Ouc7stW0iTngDXCtbEdQ==
Date: Mon, 9 Apr 2018 00:26:25 +0000
Message-ID: <20180409002239.163177-269-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:ab719RWbvhQRJopM0CyvOo0h73BiXSax/ShenlIinQPqfkeHVtEeK4mFuuL2IVGWzP834+UIHMk2IGwz+wqsNUnm6JGrwno4QEJa6vzRC6ybAmoXpEngYn8ijPeZvoCjtwHjxhwgInolPtORLO57DkEwpuq2hv4+EFCsWhEl6//ZgjtTPk6P9Fcby8yZjsxyDL443pkAV8eeX0V/3l0bQ/tXyAqo4YMINtdvdWjAItA5a62l8KarwHLLKqRkk9Q4;20:6h82B9/Jo7dS474Dl2ZbZfhLr58CAKVOJHiPeFObZjug30K1R8Eya/3lSyA8akhlKoDPsiVRh5iaKa4OHSX/sn9Wi4O+6wGsMZYITMa0MwJT0c4ADYKw/zyEMy7Tn8nbu8w2eIZvisuOIYaW5+pwHh5xdRTS2y71cTSKGtRkKrg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 655eafdb-959b-41d7-3bfe-08d59db198cc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984EE4A5EB9BDA81976AD4AFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(1720100001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(966005)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(39060400002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(6306002)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: I5xOdUjBywkj04ln9u6C5iRogOGueiiHnwdi61bdi+pvgUkzktfl8ykZe9En19GIyGcpNNw4XcxDILCRguQ2bUZUH8iPTmPFrIzOxgS37PAgY4xmPeJSJ7i2/LD8ub9kyuRvXKb2Wu2aQ3wDEMBUePoGIW9TqNa2Ar+VX6tk8hxpydvMYwiokeaToFKQRB3FNqhdPfGEOf/DxbZZLIAZQdxv+Ey5UxkSO4bNer/jR6Di+tvoxAbo3ikWv2w2gdau6V9axD/oIP5BqncDdXqY7emTfui4b2+gWUQt7rQXLpvtfPGzKELYv2sMch/ojpa7oRIr3UQ+6+c0AvyHOK8QLgUZo36LIuZTHsuMAk/NWv02qxXvyoKwj6JT+ahClKD4BgKFckMQZtozDB6zFdKvp77gH9FH+sRpSf5Ye0ffOd8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655eafdb-959b-41d7-3bfe-08d59db198cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:25.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index 18afa448bb9a..659d5b29952f 100644
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
