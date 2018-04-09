Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242953-2-7555704402103477292
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
    1523242952; b=R4uwKDqOiKVpBYoW+VwrFO7YY2O7+xXTNSFfTCm/WAV9W8aufc
    krMDyoxcq8aehEN4BNg3tLUbllrt9SyRHPiCRr89o9H2QGO3WT8pRd+NRvgF10pE
    HXDF1VETF9A7DIOGyWXGQqt+7DusNeFd2LeYuSNMqtMjZNhej5LsMmjuhO1M1d+I
    qFQ+KchO/KlVDVMYvcumLmb5jSHi4RAKrM/MEMC3F1//ciWICrINJPydpfCeNN25
    mBa2BxfV/xwL9j/m95Mvj3S0eJI+egwy0EdXiDRbPj+np6rHECBvtfxstF8KB4eF
    RkAtun3Ch3TbV9zof/i0AqCVQDT+X4nL7TpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242952; bh=S3QQqobTJ7
    hDOpzu5RgBG4MoH11YSNieTLs2xR6CnIE=; b=KKnaMjsZmWeZZW17305aTe8qxc
    JmxFyIaryP2wDBeO0uyjcP/v9A6kvV3Y7ete7Fj9stZo4N9/tElIoLsaOuKykJ5C
    ltJUFFEMVXpIfxHObiu2COdStbHjqAcGIvAjjO1B1Ih8DpmlPT2Q6ksnFUzu+XWa
    gvMe7KaRIbo1bDeUxpYwQ9hBuNkq7PX1RAWKesjZZ/oQYkgCpku7QS31Hxnj/Lp4
    oeZ3JItRLvS1Fm4fAW6vvNG2HyVPM8AokouUfzGxRsXYvu2Xt8zdVop1SjD3Q2hF
    K3NKmqFIptImq++2aFf0WcpSRTT03vWFWRIs4aY6PA54S0OPMRH+YUiDiORw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ff1zw8ed x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ff1zw8ed x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIfUgZzAavR4KIpaHKKtNirnqXAGWSaD9S6eSzsOi55sswN5G8uVI5Wqp8CK+wtQjXKWAayWDNHzz8lLUOrXqT06rATOqK5ltsv1/Fk9oktBFORVReBA
    13eixKvaT6IZMBfBD41zPGovvHWkEh++r9HAatEp+oEg5O+uKVRfptF4xUaFvb9d6EUzCekohyHC2BYkFivOK8XmlA2/t3DPllDAXGPTMrp+UKEVNpDI6XKc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=iGbCS3zQAAAA:8 a=bv4rzfeZVU7aaL2aLaYA:9 a=6sajjAAjhuskInPx:21
    a=vmhlu8lV-3mZ9uS2:21 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=oRZS8w7TM5j8Y1SnqK-S:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeDIDCa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:02:30 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:17920
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755156AbeDIAZ0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Parag Warudkar <parag.warudkar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 118/161] firmware: dmi_scan: Fix handling of
 empty DMI strings
Thread-Topic: [PATCH AUTOSEL for 4.14 118/161] firmware: dmi_scan: Fix
 handling of empty DMI strings
Thread-Index: AQHTz5i0NNcQ1qS7T0qWOz+1IQsXGg==
Date: Mon, 9 Apr 2018 00:21:30 +0000
Message-ID: <20180409001936.162706-118-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:WJAHXPBTJ4gSXs8061sImDzszZ5hGlpGyL/SbG4xLpQ2i+uo2bfTiRDgn0hayx9yZTbXr1zh5r9JzSn+Y8iwB/SbQkjEIeam15hXOQEVxiciEfw0vrzgaNUxOfR0whbCZFUl2fDTr8aapldUmA2RzA/HqE6lNacjabaje3VafH24TdrXNH7oFSpkSEFVoQOCdoMq8VfXfZVX0zFjrG5W4h4by20ycYgMpQwFigWkDZ8Zz5V9ZTpiAQTk5C9RuKT8;20:6FsxHO3d/oImO2djZ4yTt7MWsuHfR2EQFqu3X5ciGUz1kjoFdJlp7eENMsoEIrBQUPQwRrmdNssKsouGg6rEySTpwlhpPwsFsEwesjhjSdraBxqkn4+P6ZzDb3b6DZnDME8g12RTpZXOPQNlLqPT8OwQwL01wYc+RhKXXEecMJ0=
X-MS-Office365-Filtering-Correlation-Id: 2f323162-347a-498d-c3f7-08d59db062b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10133F4EDE62A0211E4308CBFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6666003)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(22452003)(110136005)(39060400002)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(1720100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Fr1kSrRAo6HeJy809VVT7qxSuLuqRjzltK9k7Qd9J0RcwVTcaZpFsPqLqCmFxL51g35EaoQEtjGgQGqE0woc/Iy5/odDHXCx1KjlFwArzT62soqdGlpISV8UpkViAFrXibK9BQFGdMMuDFzKZ5JMQJP/QD0V4hvfebgac812rbj4lCqh/YYwz30HIS/el985JX5KbVJCXOr3MSVUPXvuINx9xeSrKzlU7e7Ls2fI8I2QBJzaVdZm07w3X6icc10Yuvf5oOk1YTeEu9JZMNdiUYMI3YArjGNVR9mjE3+5nDK/NvNgFU16qT7MwCl9t9PdjSQKAMvmRgM6tzveTtAfQG4iZjkSvGgBKDSjHmJuFF/Yq5PR8Zjzhe+LgMRYmr631uVyG3YnqwQ0a1YG6L2mSReV9wYLKdkqk2CWVfn6/zk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f323162-347a-498d-c3f7-08d59db062b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:30.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
