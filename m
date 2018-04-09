Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237458-2-315111243015819351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237458; b=LW8A/p0YkFGeOa5tNtUANDuXleWaBKoqNvOJBMqPuOutBOhdmz
    LE2q5aQrxrInonw2bA8WKuTyl1tbNmasE2hwiRzNTqvzxRrPcoJpe8cx7+EAuvEk
    MXwB5T8EbfZtW5VujJM16E9UzPH2Wi252ZMnfMQDAJ6NtQTMpCdH0upoPETuJt/q
    iD9RFfe5ao8sAFpkN/povU/zjbY+gFKZ8fwiVVa+6LMR6pTO9cmGQPV4xGgX+5gn
    50VyHgPLavjlSZ4XLH7fLniVKFkDlTvQW7WCFzB+HzsdCVp3EI573Nmhv9ZrNkek
    g2CajcQn4GDXDJJWz4oH+BVufMIgemAsQRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237458; bh=OJWuLwQbgc
    WG42SnnFuF/bgHzNkO/yRKSeGkrJq/odw=; b=WmH+5WwuGjrgAaMJmvyDI0+8v1
    nQapt8AR0aWHWxyVgBTaIXEtlte6+L+j1jK1j/ZXR7+rUdvyODJeXEy5NFNwF44e
    Xo/xCiUYvkzTI2Mg8BAwBh/qNq7imHJ3QrbLPwLK6lI35+RK7NE6hP0xBppsvwzP
    TTVIX4MIv4SoCXZVkw3I1cWeIgti903rZU06hQ7ND7S6P8EQT4JyBPPbPsPM0j6h
    axB/NaueSGCNEVZZIHzaSTjBlZqF6f7fr9D1oETpxNI44mXfwLBjl5hGKnBT033O
    u1suh5T+bhIMvBtJfsy6yia05g+DzNH5wtUoEpwe0nATwqO/Ybb0oHVbsfkg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FUyrRvjt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FUyrRvjt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA5gXgIYuigXbz+Khi2n4JUNed/GS4pbuvujWYXI3tdBwHbAk+WEv8OX4eAiJd3mZTZGy6wdNjUucN+3EDnOKMSbNZdiFGOkZwGlN13z3zQBK6Ev3HCV
    ixRASXZG0TjQLvsbP4Y2kvSyOq8AAbatowPq0IFK+Y1+OwSjfdxlY8ZnMIO0G75IDMR1NirwhxBt85tJkIGtH5JZKyqy+7L8qrGPhplgbNgXktZjjLR6iQrc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
    a=yMhMjlubAAAA:8 a=O0h_LAwhRFLNreLNoU8A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
    a=tlCzEf8P23qqGTfd:21 a=AxO8lwbmAJtHRl7a:21 a=wPNLvfGTeEIA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756624AbeDIAf5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:57 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:9440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756623AbeDIAfz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 040/162] firmware: dmi_scan: Check DMI
 structure length
Thread-Topic: [PATCH AUTOSEL for 4.4 040/162] firmware: dmi_scan: Check DMI
 structure length
Thread-Index: AQHTz5mkTID2i85DA0uQFSUP9RIiNg==
Date: Mon, 9 Apr 2018 00:28:11 +0000
Message-ID: <20180409002738.163941-40-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:lXzsZrdNRFRJiYHPfSDfUpzaEVpVwMBhuWMxrP9+/cZPaM843XMcu2UNTOQHIpUcI02y6x9ZSsY8FW/uwqbnEtyGr3YK7Ui3P0uUllEQp5QV+8ZruJ/5u9TyuVq6QdAPYWdGW+P3uh0bugxKrUlTwq6CZos56QPCfwNjtXwqgZycDX2tdreuNXxx7KAJoywE5GNHoRH0J2eVIvjtx0BTD+fTnhiOhlLtzE1reTQa/Lrr9EyNcnzL7hrT13uA4CKh;20:VyT/P+rkUjE/Qh+q1z+ApvTDxhYmlxJF1/4UqlPXyk9wwoeh1G1fP7GUM2t980XfaD0voYG5Ltjq2kgRYxx2zfL86t7X8bAjFsdKey9y+LeNWHIJDWvBPVd8REXKjpqwK6K0/7eJBrOnyTZrWpv4ho6u+xhPrcco30k+2mmisiQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2453d76c-4276-4e16-bfc9-08d59db1d999
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07251862EDB72ED9CFC3DBEEFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(39060400002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: EMNMI/UUqMXSMuiCrsc+aCQE7f2Ls+MmO2iFARCqdVgmmUKX49RU12vR7loLWO/ak0ro8uVhEI3Fim0wAqSaX1JWCct7jUefdf3W5pRvnUSlYwRLYNKSBKEZaAT8AklyCXqcT/40i2C9NzNf2FilZtRBrWzu9WdXeUUw7PaqXgE3IZK8HUDs111J4gZYPrjNLaWu3fHfmHPsAj+E1KZsYzr775GAxZbXIPbiuWM0BQfIQq96Q0BdIGOfMzTQjadRXEcby2YCQYqLXmCjKrpsI8RpTzbMiN2AiHsJisKzbM7n9798/JUD8LMJptIPEJU9KgXXIAe9CIVwV8+EM01vz1wKfpVVRd+U8baCg8rCsZHD7eYd1qxaEBrXoC9p44Uu8PIhciHbCk9sn6V2uZ+E1Ef0OJ49ZTzgIsa6pShQQZI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2453d76c-4276-4e16-bfc9-08d59db1d999
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:11.9424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jean Delvare <jdelvare@suse.de>

[ Upstream commit a814c3597a6b6040e2ef9459748081a6d5b7312d ]

Before accessing DMI data to record it for later, we should ensure
that the DMI structures are large enough to contain the data in
question.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firmware/dmi_scan.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index f1d4881dd2fc..e8eea181a601 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -178,7 +178,7 @@ static void __init dmi_save_ident(const struct dmi_head=
er *dm, int slot,
 	const char *d =3D (const char *) dm;
 	const char *p;
=20
-	if (dmi_ident[slot])
+	if (dmi_ident[slot] || dm->length <=3D string)
 		return;
=20
 	p =3D dmi_string(dm, d[string]);
@@ -191,13 +191,14 @@ static void __init dmi_save_ident(const struct dmi_he=
ader *dm, int slot,
 static void __init dmi_save_uuid(const struct dmi_header *dm, int slot,
 		int index)
 {
-	const u8 *d =3D (u8 *) dm + index;
+	const u8 *d;
 	char *s;
 	int is_ff =3D 1, is_00 =3D 1, i;
=20
-	if (dmi_ident[slot])
+	if (dmi_ident[slot] || dm->length <=3D index + 16)
 		return;
=20
+	d =3D (u8 *) dm + index;
 	for (i =3D 0; i < 16 && (is_ff || is_00); i++) {
 		if (d[i] !=3D 0x00)
 			is_00 =3D 0;
@@ -228,16 +229,17 @@ static void __init dmi_save_uuid(const struct dmi_hea=
der *dm, int slot,
 static void __init dmi_save_type(const struct dmi_header *dm, int slot,
 		int index)
 {
-	const u8 *d =3D (u8 *) dm + index;
+	const u8 *d;
 	char *s;
=20
-	if (dmi_ident[slot])
+	if (dmi_ident[slot] || dm->length <=3D index)
 		return;
=20
 	s =3D dmi_alloc(4);
 	if (!s)
 		return;
=20
+	d =3D (u8 *) dm + index;
 	sprintf(s, "%u", *d & 0x7F);
 	dmi_ident[slot] =3D s;
 }
@@ -278,9 +280,13 @@ static void __init dmi_save_devices(const struct dmi_h=
eader *dm)
=20
 static void __init dmi_save_oem_strings_devices(const struct dmi_header *d=
m)
 {
-	int i, count =3D *(u8 *)(dm + 1);
+	int i, count;
 	struct dmi_device *dev;
=20
+	if (dm->length < 0x05)
+		return;
+
+	count =3D *(u8 *)(dm + 1);
 	for (i =3D 1; i <=3D count; i++) {
 		const char *devname =3D dmi_string(dm, i);
=20
@@ -347,6 +353,9 @@ static void __init dmi_save_extended_devices(const stru=
ct dmi_header *dm)
 {
 	const u8 *d =3D (u8 *) dm + 5;
=20
+	if (dm->length < 0x0B)
+		return;
+
 	/* Skip disabled device */
 	if ((*d & 0x80) =3D=3D 0)
 		return;
@@ -368,7 +377,7 @@ static void __init save_mem_devices(const struct dmi_he=
ader *dm, void *v)
 	const char *d =3D (const char *)dm;
 	static int nr;
=20
-	if (dm->type !=3D DMI_ENTRY_MEM_DEVICE)
+	if (dm->type !=3D DMI_ENTRY_MEM_DEVICE || dm->length < 0x12)
 		return;
 	if (nr >=3D dmi_memdev_nr) {
 		pr_warn(FW_BUG "Too many DIMM entries in SMBIOS table\n");
--=20
2.15.1
