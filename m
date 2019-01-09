Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD4DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ED0214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="TXHIYrtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfAIIju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:39:50 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:32372
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729961AbfAIIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqvU8BnmRaMcrVR1oeNZsOt+k4MFifh83VAGiGK7ybk=;
 b=TXHIYrtD8AhMW6ywoZ29VhTzzz3h+SmDTsrVLSIMSjzYDUAXFkgR81m/IqU1KbXPxa/K0NFbk72EZFaKxpZ3OJrHZsLRYQMk2zf9B3OFMmjO9jhTSyNi/B6eaZpd0Vgtr2A4NzHM5XveOGs0MBA6Ws3HDVIQ5AzGrAW9D70Bz3c=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3780.eurprd04.prod.outlook.com (52.133.39.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 08:39:44 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 08:39:44 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgMi80XSB2aWRlbzogc3NkMTMwN2ZiOiBEbyBu?=
 =?utf-8?Q?ot_hard_code_active-low_reset_sequence?=
Thread-Topic: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgMi80XSB2aWRlbzogc3NkMTMwN2ZiOiBEbyBu?=
 =?utf-8?Q?ot_hard_code_active-low_reset_sequence?=
Thread-Index: AQHUp/betDnBWtNTUUWMBKo5MZ8O0A==
Date:   Wed, 9 Jan 2019 08:39:44 +0000
Message-ID: <1547023165-111798-3-git-send-email-michal.vokac@ysoft.com>
References: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::35) To AM0PR0402MB3716.eurprd04.prod.outlook.com
 (2603:10a6:208:d::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3780;6:BHI6z7+QgrXZGFiCpQzSm6wIhqT81EVjPk3aeB7cHI4CMtf0yMVFyjb1i0bTsMliRB5+ca3fZn9C0oL979ry7U9IH5uQpMtcqaCBFooAf1Ty6cku0S3IubuIbtO1H0m3MI88K+b6batrW4LYaSnqTIT7z98a/yvV2rmYlgl3b72CSQyt5aiAbyMWV9Q3rQq/0WIvmgrAKTjPX+kvYD2vE/eRvxfxtMkFZ2HBMsvLlPV5bodokDjv5+j2OICZx5cQDuOPFgOM8fwTIuqKZYp63CswN4OMcmLTcv3BPK27xTWhHf+c/DjO8Tjs46DJRM2Q1ea5vSFFpMAdwBV0XFU773KIL81jdmzOJnyOVNtLDJajTxM0G9DC5qNf2FEF1HfFd99L8BuHFgoPbB9fhWwBJpsWuBxGFv4iu9JckNWZU30iDx7hT0H3UEQRfp+SX7J1MwVSH66W/EgN4WIGAtuiBA==;5:VuXmrJw7Gu0XAoYNDAEZfa5H4QMo+xeAUR3xnOt7lJNmrKE/E+59H8UuupRGAeyW85H6gsEgjNGpuNvdl8FIzm3kv6qACGOpZI54tdikob0leOAaBufBZw5zqjX52i9GnHdHBovc6LqwDFK3BG6275zyaJo3Z9bCwDY3K+Qo+dwKpNDAF9fnDusU6G4f8cXh2sRiQJrb4M/h6fEw/0HJMg==;7:XZ/p7LSaRK+RX+a7oaxW5Mwdi1elIMRvllVRqgA/5+lswZuYrcDiM5LXbjyFjKRyMU4LOi7CcjmovwxsPW3uYlnZY2BWDDh5rE4duAoYWje+ji13mqSrFlci4eelQJnQOMtK4+vAwp0taGccqFlGhg==
x-ms-office365-filtering-correlation-id: 2c38734b-368a-4ffa-e61e-08d6760e0048
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3780;
x-ms-traffictypediagnostic: AM0PR0402MB3780:
x-microsoft-antispam-prvs: <AM0PR0402MB37806496C2CB7A4149AC7CE69E8B0@AM0PR0402MB3780.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3780;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3780;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39850400004)(199004)(189003)(53936002)(5660300001)(66066001)(8936002)(6512007)(72206003)(6916009)(25786009)(4326008)(256004)(36756003)(107886003)(106356001)(6116002)(14454004)(6436002)(105586002)(81156014)(81166006)(97736004)(486006)(6486002)(3846002)(50226002)(2906002)(305945005)(7736002)(86362001)(85182001)(11346002)(478600001)(446003)(476003)(2616005)(68736007)(6346003)(76176011)(102836004)(99286004)(386003)(6506007)(186003)(71190400001)(54906003)(71200400001)(316002)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3780;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3ggBOROBxg4abfyIMfYNILf2Pxa8PY6df3b7qhBJOk2+A0sJaNPCfqLxrVOKiJThDj4+ih/fbG4wp4h80KbeACdLo1ahbo25NEj2sofgSKZ5odFQKfwkkexVhJf6CUpE2vXoLM3Cq1c4S6bqHFJKAo5wmK1qaTFIEGyQui9WrYyOpS77G4mbcxOeTlT3r+l5vG3yMruBq39o+iC7HLwCVncspz0MMXCqCQYxFHrRVkhUH/biNvOi7oQmN2bkZ2XnbNFViRYElOA7DSP1Zr23hvQE1oq5wNPawkGfSIRVgZPnZfG8U96yzWTbeGinV5Tb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <55014C793112604A8E08782E07D2EB97@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c38734b-368a-4ffa-e61e-08d6760e0048
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 08:39:42.2307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFNTRDEzMHggT0xFRMKgZGlzcGxheSByZXNldCBzaWduYWwgaXMgYWN0aXZlIGxvdy4gTm93
IHRoZSByZXNldA0Kc2VxdWVuY2UgaXMgaW1wbGVtZW50ZWQgaW4gc3VjaCBhIHdheSB0aGF0IHVz
ZXJzIGFyZSBmb3JjZWQgdG8NCmRlZmluZSByZXNldC1ncGlvcyBhcyBHUElPX0FDVElWRV9ISUdI
IGluIERUIHRvIG1ha2UgdGhlIHJlc2V0IHdvcmsuDQoNCkRvIG5vdCBoYXJkIGNvZGUgdGhlIGFj
dGl2ZS1sb3cgc2VxdWVuY2UgaW50byB0aGUgZHJpdmVyIGJ1dCBpbnN0ZWFkDQphbGxvdyB0aGUg
dXNlciB0byBzcGVjaWZ5IHRoZSBncGlvIGFzIEdQSU9fQUNUSVZFX0xPVyB0byByZWZsZWN0DQp0
aGUgcmVhbCB3b3JsZC4NCg0KUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+DQpSZXZpZXdlZC1ieTogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJv
b3RsaW4uY29tPg0KU2lnbmVkLW9mZi1ieTogTWljaGFsIFZva8OhxI0gPG1pY2hhbC52b2thY0B5
c29mdC5jb20+DQotLS0NCkNoYW5nZXMgaW4gdjIgcmVzZW5kOg0KIC0gQWRkIFItYnkgZnJvbSBB
bGV4YW5kcmUuDQoNCkNoYW5nZXMgZnJvbSB2MToNCiAtIEFkZCBSLWJ5IGZyb20gUm9iDQoNCiBk
cml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3NzZDEzMDdmYi5j
DQppbmRleCA0MDYxYTIwLi4zYjM2MWJjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy92aWRlby9mYmRl
di9zc2QxMzA3ZmIuYw0KKysrIGIvZHJpdmVycy92aWRlby9mYmRldi9zc2QxMzA3ZmIuYw0KQEAg
LTY2NywxMCArNjY3LDEwIEBAIHN0YXRpYyBpbnQgc3NkMTMwN2ZiX3Byb2JlKHN0cnVjdCBpMmNf
Y2xpZW50ICpjbGllbnQsDQogDQogCWlmIChwYXItPnJlc2V0KSB7DQogCQkvKiBSZXNldCB0aGUg
c2NyZWVuICovDQotCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocGFyLT5yZXNldCwgMCk7DQot
CQl1ZGVsYXkoNCk7DQogCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocGFyLT5yZXNldCwgMSk7
DQogCQl1ZGVsYXkoNCk7DQorCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocGFyLT5yZXNldCwg
MCk7DQorCQl1ZGVsYXkoNCk7DQogCX0NCiANCiAJaWYgKHBhci0+dmJhdF9yZWcpIHsNCi0tIA0K
Mi4xLjQNCg0K
