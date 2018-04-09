Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236186-2-14900082278096670223
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
    1523236185; b=CvFamBKmW0Up0bouSELdXQqtr+8oSL+DX464i2ApfHhYpIiTLz
    eYan4b93TymawL/sNgVcJdJJVjZWFZKDdM/iDcuqjhknjJ71Yqb5jYiD9JOkErri
    YLeaYzVDUqir+JvZC8yw9V89GXThlsrlN4aeAcX/r99Y/RJkPfBuLt0Sekn9NQ4p
    i6twNX7aR32xzCR5ch+Hu6zduaU8zdVSf9d2dKMZD53z/YHYCWKnIzPe8cyiUGu5
    aO++BEsi/0vNhS9Fuji+Z7TNBhFR7ckJJmDjs9FNo3POSQPzmbL/0ylAFCe9ni9d
    gZi2g+TydEzMlg6PyB73BPon1f+9y3P+S2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236185; bh=Vn9CNGet+/
    gWFM0Jyu95fvJ696iiBcyl0X1YAldHcvg=; b=bHYPGqpvuoGAkEatj0rvLPVzV7
    suIRtGgNqrSz2K9h5D6OYFWfnnrYlhhSCJIVxo5t1oqa+LRh1FqrC7+obcv8Hxin
    WcGCF0R2I6Tq/EoX4g4Jwzn81+CBShwlZ2m4puTKhUys6C0R1PzUmjfK6iH9k1sT
    dTF1OwLr15ghptuVmf0QcsAb+ADW129chaG0vpLGOMvkPQnknL5hy1Ln8vDmjIMG
    Tc1Ya0wg3wsfo1vuHSUoGivcjOrge0OTiok2c1vR2zekqjf6oj7peHCNMaYbpddq
    ulNUEt7ugYalNa7Ik0LG9ahsG72AmC8LDlwh1YMVr+1jY6k2v9XPSuHOTEzw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UVeTeKWy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UVeTeKWy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF6Qm8yr2DRSKbYfJC8S/iRZgHQLCPqVEjZfLZqp9YWZ6GFpntj1Kdb7OlsJq+2CV3SeuwHsmw7mVt5wHWS1Qovr5Xe8fu5509r/+2lzzvKOwKmSQXYS
    4rpTsxKM6/UGW5NANd4IJEnIfoZkAlJnDLNMzOH4J0nUA9v1mavBeND8TvZFlaXEDWLqN6yfwTm8b/Crd+xUcuPyXaOqP/hBOtQfczC3B6/Fnaf7xCEYVDoH
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
        id S1756971AbeDIBJN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:09:13 -0400
Received: from mail-co1nam03on0120.outbound.protection.outlook.com ([104.47.40.120]:40064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933001AbeDIAis (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Parag Warudkar <parag.warudkar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 145/162] firmware: dmi_scan: Fix handling of
 empty DMI strings
Thread-Topic: [PATCH AUTOSEL for 4.4 145/162] firmware: dmi_scan: Fix handling
 of empty DMI strings
Thread-Index: AQHTz5naXUsVXziJx0y0uPQl2vrObg==
Date: Mon, 9 Apr 2018 00:29:42 +0000
Message-ID: <20180409002738.163941-145-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:pxyGqwNmoPXIY7Ddam8U3kHoRwl9OOGldllPaiwMcEt2cM2tPJxbnlCncv4LZzigEg4g6YXSZQC9Emul8m5lj5pchHtPLRH0tS/2XMlQ1ltgdn3Z+WneCyIx33Cx+rYTR1H290x9Foz0D7cQ3LajWI652GUvO1I935GDVqVNmSY0a/SER7nM1SlzlZRv4ZsTyMEzWoL84JoVlskXW6DBa939nSo+SepoQTlHD4TYpLvQt7lSvCtlS11N4ZLpzsM/;20:JLIE+fA1tlmyoI83LtS1ErFaIBP3v/TDGrcA6zSZTpyD8PW4E6hFIX7WDXrg/CYVMy0it17ECFC4NzUaobWXYPp/gWfJwYoiufVMOoHh8EHIi/C2eg2NSUmRrm0oSm9ajGhVp7ZR5Udvg1aBuvjTZiG40m5QbTqoryFG3UfINaw=
X-MS-Office365-Filtering-Correlation-Id: 53768827-bea4-497d-6ab7-08d59db24047
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11256A343CA9E8958170D033FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(6306002)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(39060400002)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(966005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(106356001)(8676002)(97736004)(6116002)(6506007)(1720100001)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2OouHMvCkuqW/upaWOXssWYZcUgpwDiNXO2gMKGp6HlbtnqZP9Vl/84LsMtl/ePy8O5aQRBWVjK5BgZiiRejxlknu0AGql4v9uHXZ7/edB6YM58Ls/6qMwwlaIHqal7X3ZfMBmQOhXx3YXdvLtlmtIta2EBlJYlNERNhxqjirYbtZtJOkfQqPQqmWP3+ohPuFqliEzNWHUeV+QxXLhazcDPHCkLPiPGLvy/oY/x43E+xbiC1vvegiDHRkZ4BfnXK0kLH5oqCrqFKHPetnAr8QAoQaA8GCzFXaSqdmRBU7GExMjGFyPOhG/SRoopkPwjrLzTsdtRIyZ3ptfWXdcaYd4rAMgIlIkmL6EP/xcoIj/RhU1gZJ+7X0sfngolanKa5vFoy52pdU/0Ee8XMYgTKOL462LTj/MOdiToFAtgYpwQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53768827-bea4-497d-6ab7-08d59db24047
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:42.6464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index e8eea181a601..ad860de53c1f 100644
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
