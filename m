Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234753-2-6715640506030555117
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
    1523234753; b=Xtprj5pH9jbf/JZ2nC8mRJoM12xIvE8WYF6aa6DEH6HeGgJGCU
    Gkixc2j7dkKDmoL7NNctlPBtH73Xds7rL9HaJiGihbbBO1hhFaBB/xNM7PUyx2Zt
    ViFbiceNnno4iU0epqz0Xbfz1DZ65zBiJ38QCfTsSi1YsUNLxAP4T1fT7gVR9io9
    /tNad6bQ5Hqvtt67ZPC3Lkz0XaR8KDKffnpB1daZGpspiqddCciex5o5govYaIsk
    6+qySAPQBEjn61pXFkvO/gdfcMf7tTn9iNlHZT4a9nh+YgAdVND/j6k709qewlbE
    XCrPlzRKJtTSHDmkElRs6mVvUfNgKtGlHqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234753; bh=HYNvjd0Ucq
    DS+obecw6wojOJljhZQOdMkcIGvyIoy6k=; b=Cv8hu3SnlKdeHB7LiEGKEVU1Nz
    cafGd5DK8bWFQDyH+VIwTJp8u5Qj2r9d399/F5KIsbvS7csV2rnTp088YVnAYHoB
    Mife/w/H9eJCpVFmWBkkM2X1r2GSafQBdXLTVUh9j/W5GoYzEUaypYgPqbzMVyh6
    VHgEvyd47gwjb8k5x4HDlz/WJcPPpXskV9DPeO8RhMiIrZAu6HFKv93vsvCD+h6c
    3rh+bpUSCMPs+Rn4ILSt25IVwAqflWkD46Z6BWw8ECifF8WnISZDguwfkSw+onQV
    l92sJ6qi+SDOaKbA/JSjQsInK9hhaBe0UfVZ4wWhF0+Ji8CSG3v2VbW3rEmA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OxKUpvoK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OxKUpvoK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJfEy/prZyvYqXIXoC99f154y8APjH/EKXZM0cn9n0SgU5OnhkU423U6NB9CN2/7Qg7FLBqgoHRDy24Q+5+tCvMJAtmOypjJgcmh1OKhJgqf0qiVtt1i
    WtONBmy2AyvVQy/oalb473L2Aq3SeIXRE/b5dR2G0vqL9+RF59+STlL+qNLnxGtTCI4NVKNLRIkB1wjGPnCxZarMjMQTcdj4AHqYSS6/RFBFFx8MpjewH1Ff
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=iGbCS3zQAAAA:8 a=bv4rzfeZVU7aaL2aLaYA:9 a=UWDkc4DsctH-CR3K:21
    a=9eFj1Q3ewxdncgMi:21 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=oRZS8w7TM5j8Y1SnqK-S:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755731AbeDIAph (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:45:37 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:44046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756615AbeDIAm0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Parag Warudkar <parag.warudkar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 090/101] firmware: dmi_scan: Fix handling of
 empty DMI strings
Thread-Topic: [PATCH AUTOSEL for 3.18 090/101] firmware: dmi_scan: Fix
 handling of empty DMI strings
Thread-Index: AQHTz5uKydB0kOfA6kyDdSCIdRoSAA==
Date: Mon, 9 Apr 2018 00:41:48 +0000
Message-ID: <20180409004042.164920-40-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:NPm+rvm0RUqwUBEleO87RA9Wxth+GU08Lq+miy+q5YDl1Al6CLv9OtEiSOgxT9ZMpcSQ3nbUVW/15d4F7DDzDtULCWlOSnrsSTCxF+Zt4I2S/yKJZRbDCFKG6PBT6IfCbIqm66SvlrXLOAoNmMiMm9tjxvQB7mdwSfQ6JCAlRoRvUaJxNnsEGWe7g3AxLoHiKWusloQnWs6wuOJxJg2r9wPDUh37fBGGgMWvHBYPSpa8xT8rRCbREp0bRtKyg/Og;20:Lo7AQjmqBQYJ+y089JBmC8AcvfwZ0g5IsrFmN1xbtEvNlu/tWt3YOcpiqkJfTW/6LEWiO53O2TiiCkz3JAVcf/8wZi/796ydIYvsOZ5tQakZLQbCMvKID4ZT+MoTTfIukWJ2FhgFzyi/Df4L51PBGkLClSvU7BhWw0OKWr6rgNM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97ec2e89-9367-4ad3-b020-08d59db2c1bb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062708DF621FD6BB8BA9D42FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(1720100001)(6116002)(3846002)(305945005)(86362001)(39060400002)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 13ENSNc/VvYy7xPQC1+4HGHiJvmf0tK3Zx++wGVUNrfvyiBKtq27YUBlhvhzS6BcJnnPSWKbHzQ8E+lwReG7K8rZgyymVOWlvRmwZb5jfMKUK+f74/i9CyApmpAlF5r93XZ65Uyn5eEn6wrAXn2rMXABj1k1Zy9vN683EViQ4aTNkBEv+v+mWBrc7fjWQPevZ0Iwok5UcfKyjekq+NQfxYxfF6p5eKejTzM9jk2YCFaAq+aahCAP85qYZuLwewfjKuWGSIdeAaIxLODvEcxZXF5hbvOsfHZwwJ+u9eNcXrAeW1RJcITS9UBgeKooEw0pua9/Xm/X2NDH/xjChSXH1vHEwV57cZv8Xu3jYSFMdT8hpuTeQyxhdauxl5pmW5ksgYvBjZ6VH0GNcCKo0JAthsLn8zor81MkgyihXwotkek=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ec2e89-9367-4ad3-b020-08d59db2c1bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:48.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index f4dbe6fe9dd9..0694e1b4004c 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -15,7 +15,7 @@
  * of and an antecedent to, SMBIOS, which stands for System
  * Management BIOS.  See further: http://www.dmtf.org/standards
  */
-static const char dmi_empty_string[] =3D "        ";
+static const char dmi_empty_string[] =3D "";
=20
 static u16 __initdata dmi_ver;
 /*
@@ -36,25 +36,21 @@ static int dmi_memdev_nr;
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
