Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241015-2-5844255019097904682
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
    1523241014; b=rIjty2c4kZwerPloPWKPsEyOL8ZgTa6Gay+UC527h5SU7Di0eb
    u+5BiEG//9VvH2b+jpPULrjkUYltkcYUhgOe3A/LE8yoCRQ0Do/nVlbFlSG/Qgg2
    WBMdCVfBGGmhr8Ig1zOsD8m6hXfsi6stSukgyk6NL3zXZKMezW9K35WTZ05GLsTI
    NaoM5xLB3yyqnrPZqwslVZnsFemj1q4ikV79oSZmJsvmyIUXsmHN+fu4n3Pa/Nei
    7vzQfJfCmuaoF43laj3VyNg6MTuNZCE2Bswwa0AmUH6wVGUeV0veXpR+ogQY2klJ
    WR6020qRQpdFJ30XVSWphETFOXmoFuqP5C5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241014; bh=9HFIYvEZKN
    m3lDzZcgtKJVsT+pad7UJg+KgxQZsjwXo=; b=P6/5NFjQsEbIp2LCbszMNRBzia
    oJS+isyBIPnsIXOKFhGJrx6WkkvaZNE8Yw2NfHLupQRkie4+B/jwx+aFHGD8MuAx
    jkA1ssTCGJ+4857B8VDeuFe03IeG4ZS+O5scUn5KGJVMsG+EyBrvgQnnLu5CVzjv
    CYgJUJwllFzzbJrFctfq/L/r8WzimkGQ8xH6q1hF2HrrWOYVrI41Mt5t87N1BLHO
    A6YO2f3cWoouIiAgS6NByRLWkl91kMXLwWc9vXzYcl+5xcZvLzduXM3ouBeLgx1M
    tgkb9+dGIupKBIutzgMG5L8ju1pJfkCZwfiW+2GwmIfYuKBSry11TVV1ssSA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hQLJi1D0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hQLJi1D0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLPOo6Ahc4W3leD/Miij2r+ZiptmyyBXNHSqxLICsIgkQH5qr7WjGkdTwbSxQiO/t+XeiAIVPX/yS/Eg65kO2CBCa6pF3OhGB2WUz8TxeGJfc5pwrQ6e
    fKvJ8LflwjWwYJv2mbv65ASZpE5RcSeFgab8O0fqca1EFGSMiY1vdapAV4axK0nlBdYkhE4lzUO+aaEnZKhv4QCqMER5D3q9dFdiYDXERLY8YmCmj4t0/sF/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
    a=yMhMjlubAAAA:8 a=O0h_LAwhRFLNreLNoU8A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
    a=R5P1oUGWFdry19ny:21 a=gJhd8BRMbQfjKpTo:21 a=wPNLvfGTeEIA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757901AbeDIC3c (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:29:32 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:12595
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755870AbeDIA2g (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 078/293] firmware: dmi_scan: Check DMI
 structure length
Thread-Topic: [PATCH AUTOSEL for 4.9 078/293] firmware: dmi_scan: Check DMI
 structure length
Thread-Index: AQHTz5kLKBFqgwQbZkqWKm6/DRFLDw==
Date: Mon, 9 Apr 2018 00:23:55 +0000
Message-ID: <20180409002239.163177-78-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:X77Mql8WxLqRd4c8E/7zAc8j4XPvbazC7BqfZ5ZZqxm2c1ECVbYoT0dtOtVE7OsRieB7Oe06J14LFdncX/NsOrcxVsqU4hpWsOBQSFiBbZzxYhEPt4x4F1PAVSauXPqr9MROeL/rg3vX2KYtLMqhUmfDcIowmIBloZiV+LPt4YbPBIJmUy1GIYzymgiyM9rfAa+XuPpYGJ53MC3FzJhoFQTlZy5ncsA5is6D4UzPA4756uhpnpuOpFuNcB1NHKuX;20:CSWxhW1nH0jdGSoGG6dG/KzwUuFrnXsOqEQrAGqvYsbZ32H0QQrUxQ0h0W/XrWzkqqui341XZnHz41LfcyZqRTjxiTISKq7BK4RVP4uS62Ip8MtEGNo/b9zOb8pstegaVkNja7YmK/6sX138wqRqPYsZEcUM0PV1H8cQHcnq5W8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc6f70f8-c390-4725-9ddb-08d59db0d192
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08070F4088723BF19C9AF957FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(39060400002)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wg0ouyip/qy5abkADT8zeKvFIvemDUqaiJP0ogKyG7ymTliTI3iaCAQ8nO1nrrmqWFvf1T41x0Ox2kkcF0mn7NHwQlkLLj7EQQppMI1Ewx4FQkq37I+jxS2cvLh/XZ4TkmkN7S9NF4phg/bdXb9Y3xWUX+3NOS2FB1bLvZDQvpW77ULp0inSAcFBc6SmYxEOcyi7Ak7FwrNzxWVo6WBYWJ6nC/bvJxLyLdu3UhflknUUybB6UzFwgBapBasfCnCHVYqFIcGdt8NmZ3xCvRa/mh8oOG4l8hu4vKgrDgQARr75m3Y0+Sn2/R6AXAVj2RCG3lbjohRTaaPNF+LGirdc7DEgt5fnOyhriPhvHDuAqGltG6ENtevWc28Eg1brx28L3Jsasz7VB9MPXsoqR/rAVwmmDd6DpBufLEjiibslBhQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6f70f8-c390-4725-9ddb-08d59db0d192
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:55.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
index 8590f94de9dc..18afa448bb9a 100644
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
@@ -353,6 +359,9 @@ static void __init dmi_save_extended_devices(const stru=
ct dmi_header *dm)
 	const char *name;
 	const u8 *d =3D (u8 *)dm;
=20
+	if (dm->length < 0x0B)
+		return;
+
 	/* Skip disabled device */
 	if ((d[0x5] & 0x80) =3D=3D 0)
 		return;
@@ -387,7 +396,7 @@ static void __init save_mem_devices(const struct dmi_he=
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
