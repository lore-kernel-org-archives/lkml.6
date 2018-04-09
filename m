Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235483-2-15249790231718013193
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235483; b=jrRj0autqcA1RyCPY9WKtM4cxhQCzIO2A0dYwNALmnItK3G/uG
    zzCwDt1juiLKsCU8I0OQ0R/dm+NWTpP3hGEJ7/KSKRi8lwpOvoOcVKImFybWrmVK
    hg8z2ImCkUuGLP2Lh+ke2jC2b+KT5tBw2Dumg7ZS7UWTMKWm04zeuAzTjs29pPlF
    OObYa/lCSuphHhPY3nnenzc2u1SlRBiyEMm1nNTtG/aTj3t1BFPqT5HLgwFPS6Fm
    csvQEqdS+UTnLAv9r0jNV8O91oo6pNdneZS3pJo6Edz1AK5QjWB5XiPFsG+gGnWZ
    WCdbKTKvsn2IeLkN+y4tkvLIIQyIQLwcHkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235483; bh=BTg/WVsiac
    0MaHZhTavBCqVhA+WMCAfPrz3hatcVzEI=; b=emNAU8ZOyCc5p1b2fbYzXlHHBA
    SIbPxyY7L1tHPrS4xJc7bOou0ITtw/V882cQ9gyO9qBsTq+tWxHdksEug3ig7hLY
    nz6uewBW7ygzA4UhiRLV9ED89zKPZYcuNt3Ck4QdgtpKcvIwn7/I4GyTXll/z8nU
    VKnc9OupEtE3TxBMQbfA22beWHvkZztunL7In991wiNn13MiZpBGL3BgmIZ6Lz3i
    239ijYhi7hqbVuZQ6eJ5AuqEUvOHE6d4hgHjh6/0PRJHbREvckvR5/biUK4nE85h
    oAMpUfuHrXpgWl9KsAYy9hhcIOM4M6fxlE3aebO+c5K16Z19FJw36g9HtkeA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mKQW0znm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mKQW0znm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCpKrPwfoz3PdIa+X8Muqi8SZMWYJHMEep8kW3nCoap7rKJZJ0vJAr5oSP3jyjLid/Ud4NHAEnmPOAQTXoKXevtCWdSywVuwDOt9KrDXm4ZG/urVzzQg
    7XWQGfCuCecLjzK6SCyPMxl6ymQR9wruAcVkm5Hc82aaDgjM6y2rZnUGsK2XBEUFjDPFCFqClJ/uJ5yuE9m50NtKAoeuatHjUiDhNlj6JDvw2G2Ge7gyaIBt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
    a=yMhMjlubAAAA:8 a=O0h_LAwhRFLNreLNoU8A:9 a=tlCzEf8P23qqGTfd:21
    a=AxO8lwbmAJtHRl7a:21 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933456AbeDIA5h (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:57:37 -0400
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:41805
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932729AbeDIAkQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jean Delvare <jdelvare@suse.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 032/101] firmware: dmi_scan: Check DMI
 structure length
Thread-Topic: [PATCH AUTOSEL for 3.18 032/101] firmware: dmi_scan: Check DMI
 structure length
Thread-Index: AQHTz5qvDMGV+rBviUm1Lv9/lM6Ebw==
Date: Mon, 9 Apr 2018 00:35:40 +0000
Message-ID: <20180409003505.164715-32-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:sM62ACetM1KL+VK/NRvQTJQX9tJnDQTARpS3jyvCazRgG2jUqxS9zcfjMqsFwPpHmmykZrcI3HozX1vcGuJbHC/y8B/8QqRHn/AaVgRRtnWacqiEOhqpRw8uEuggNF9CLI+KIIg+Bb5tRGF4suGcuOfFOn55TXwEyrh+oE3YzmhDNh9ti779wMv6szHN7kb+uyn2f8e9Kv6IP1Uik51BhcksYY2e0Eq0Uiei8eKyB6pT+sfV+6OB/1sn4jF8vpp+;20:Cyf2GDS5dPhXG49D8vi6xi1XwDYXfg4M9G+f2wY+zhRZmaT0eoCPS+xfuv+IgFda8OzUjhpZcF2X/dqjrzWv3AmE90mTvx7Ai6HHKAqEHdOMygieGyQZHUG5TfTiXyWRa68/18iZ74v0D/InY/guZTMG3c6UCOEC0eAWOfVqcxs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a09e6a66-1319-458f-4bae-08d59db275ba
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096690B7DDF3DE09B3F728A8FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(575784001)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(39060400002)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hDs8c8PV9y5xTYYgWFzDEMTPw3w/+2hADZgFHo0/M8BkSY+00bN4dzApEW37heswwPmsB7FNsc8/YVgaKxNB19PVMNFkfSkYnrG47y8YcA8cpaWecf4MV5oV+GlLYWvOSdWgyBEW1YNkTppLGiuYA+F/qXPe8dT1WaeUaTw937mBZW8WCMheFhH+VUckR0/yADKWSFFwWFGaKOCz7pTzFYFyze7XOk0QKMNrrpvbUSTh13ucSXEjLkjMD+UqQSc0+odVWqvm47HcwA/nCswMWVHmLacHPJbRPAQNXJXDuSHGuoaiZ6v0OimbHF31R4NFIovvVXNpzTOjX/SXRwIZESA3CXha8v693lmUIXDy3JC8Iqr6WVlHZMwctUg6U772rQspzgipaDG7RNS2U4617/TDKlR9TWuWPt1omzToUwI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09e6a66-1319-458f-4bae-08d59db275ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:40.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index 35286fe52823..f4dbe6fe9dd9 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -152,7 +152,7 @@ static void __init dmi_save_ident(const struct dmi_head=
er *dm, int slot,
 	const char *d =3D (const char *) dm;
 	const char *p;
=20
-	if (dmi_ident[slot])
+	if (dmi_ident[slot] || dm->length <=3D string)
 		return;
=20
 	p =3D dmi_string(dm, d[string]);
@@ -165,13 +165,14 @@ static void __init dmi_save_ident(const struct dmi_he=
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
@@ -202,16 +203,17 @@ static void __init dmi_save_uuid(const struct dmi_hea=
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
@@ -252,9 +254,13 @@ static void __init dmi_save_devices(const struct dmi_h=
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
@@ -321,6 +327,9 @@ static void __init dmi_save_extended_devices(const stru=
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
@@ -342,7 +351,7 @@ static void __init save_mem_devices(const struct dmi_he=
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
