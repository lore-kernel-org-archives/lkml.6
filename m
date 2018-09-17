Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E34ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511CD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iq8Xxyb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511CD2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeIQIae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:34 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:18657
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730570AbeIQIad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUS+NM3xCElNwWyVB0rCTgIdP0DofccLjpJrCoOoVhA=;
 b=iq8Xxyb7JPLnljWvGXfj/oq5qVruWL0NAxhU5ElhuFPATESb65cT66GJm8ElFtchmck4FBY/veLE5eQGMLuotsc7FM3ZerkC9j5UKLuLjmdtn6A00GLrXNGvV88XJV80JL8hQHxKjIVpEBplEH6QnblIohfpuKl66BpOUfvOxHI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stafford Horne <shorne@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 01/57] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Topic: [PATCH AUTOSEL 4.9 01/57] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Index: AQHUTjMLDalYEffR+EylONMMbNRvkA==
Date:   Mon, 17 Sep 2018 03:03:44 +0000
Message-ID: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:1a5hiPQjFwTiREf8D6tMiFo7J87AIbcvQDC9e0o5udF14bM2E+QDVCXyAPPYAe4hQhVHviyLvD8c/nIgeZ/arfV/29NxKXP1u37WlDBiyoZhhpFdUjuFfebn6WhxXD5HL84mNXEmbZ73QP7rG/nHgprfQQ9T7euy5fqQpBdyNpxYxx+qBiFyUCAtFiM/GSDK9pzu450+RxvelhNizpDLU7a0a9zFOscNmcdswEqYSKpLFuLT8OoIbFDti2sirhv8ws5N4rhh0DfjBZEJthmvGVhN6z71mbwzEHa2Lhuvj1a7sCv5Bapoxm2unewzVQ8CGx24BmB8q3MjmIzy2A2ztayzvRoh4HmLC9C9DSzIdfnJ5zqX9pT9MJSerCho0UFc2vaDtSfJZDmKBmeFMQnY/TwrZ+IcnqdmhbBV+MVQZ2eW9N9ZNdTGP+blLlE9TO7qoH2ZlX+LpUzdpoFNTrk6ng==;5:MT0NUEN++TgLjHWARllTw3KoSpQOLLnAW3jGd438FaaRB/lUUIJKFMeVCGYwyJfEfRSro8SMYz38ffC8U0YWkYPnRXzQZDqyl9sxApcW/4pozcCRO8lKN4TyNdbEOBA9fX9Wolf5YoLAgZ/EFWJyFyQmhfUrTFz27sXa6oaWjII=;7:Y1qYmAuhCdcgBHSkjxlyG75nQlnCgJVwpkgJB2kkUjTs1pMmSiN0xFLCxElxTNwVKYI2gPdt6d/a7xWVzbsturYUAv5B2Dw235ROSZF168h4PoSGUEnO8AdFJ7l7ojAt+OAO8gEY416+NF9wv6kQEj/SxvFTwyQqqmmHSXHJmg+tZ0QPrIC96dQWc5re6XIT4F44FY2Qq5gRXYo60GKyZOzOv5MZ9nMXayo0A1XiJc2v8KhQM6tm9uqvbkUi45g9
x-ms-office365-filtering-correlation-id: 302889f4-e12c-410e-a072-08d61c4a5e4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0133944744C7E008055F3B01FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(39060400002)(110136005)(2501003)(10090500001)(14444005)(305945005)(7736002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +0suir4u5Zh94Ket3l35xh3TiOBZP2WzF5pgGC4QUUtopUjtbPaYkTsNqH1ANGfN7FLaja+Na4MfK5RzEYoM4lbcj7cHBwIWeYXzGxk9fd8xeZpNpPUDcW15htLLEvIFbZRD/faS6mhxADJFekR63HabdacWARWLb7ZOedmkt60Pk6JW2HMVGLdwP1Nd3HpCe72lW6VxpLXUGR0SaoHpiqcHxhnJ/lIFQyuufGdOEQX6VDnrYSsgSNhDiYnn4JQgtpZGJ31ludgwiEcx33LBPVFrIrHG3c7/erBAam4uxCHLwI4SWZmcOTvNC7kA0TRvfTiUgxU3ZPBlc9QUY7Yi+jZx7dwVA4CJq+fwfLPl9gc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CCCD1A178578A47A8D9A9259EEAA024@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302889f4-e12c-410e-a072-08d61c4a5e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:44.5242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RhZmZvcmQgSG9ybmUgPHNob3JuZUBnbWFpbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IGNlZmQ3NjlmZDAxOTJjODRkNjM4ZjY2ZGEyMDI0NTllZDhhZDYzYmEgXQ0KDQpBcyBvZiBH
Q0MgOS4wLjAgdGhlIGJ1aWxkIGlzIHJlcG9ydGluZyB3YXJuaW5ncyBsaWtlOg0KDQogICAgY3J5
cHRvL2FibGtjaXBoZXIuYzogSW4gZnVuY3Rpb24g4oCYY3J5cHRvX2FibGtjaXBoZXJfcmVwb3J0
4oCZOg0KICAgIGNyeXB0by9hYmxrY2lwaGVyLmM6Mzc0OjI6IHdhcm5pbmc6IOKAmHN0cm5jcHni
gJkgc3BlY2lmaWVkIGJvdW5kIDY0IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV3N0cmluZ29w
LXRydW5jYXRpb25dDQogICAgICBzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+Y3JhX2Fi
bGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQogICAgICAg
c2l6ZW9mKHJibGtjaXBoZXIuZ2VuaXYpKTsNCiAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+DQoNClRoaXMgbWVhbnMgdGhlIHN0cm55Y3B5IG1pZ2h0IGNyZWF0ZSBhIG5vbiBudWxsIHRl
cm1pbmF0ZWQgc3RyaW5nLiAgRml4IHRoaXMgYnkNCmV4cGxpY2l0bHkgcGVyZm9ybWluZyAnXDAn
IHRlcm1pbmF0aW9uLg0KDQpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4NCkNjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KQ2M6IE1heCBG
aWxpcHBvdiA8amNtdmJrYmNAZ21haWwuY29tPg0KQ2M6IEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnMz
QGdtYWlsLmNvbT4NCkNjOiBOaWNrIERlc2F1bG5pZXJzIDxuaWNrLmRlc2F1bG5pZXJzQGdtYWls
LmNvbT4NClNpZ25lZC1vZmYtYnk6IFN0YWZmb3JkIEhvcm5lIDxzaG9ybmVAZ21haWwuY29tPg0K
U2lnbmVkLW9mZi1ieTogSGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1Pg0K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
Pg0KLS0tDQogY3J5cHRvL2FibGtjaXBoZXIuYyB8IDIgKysNCiBjcnlwdG8vYmxrY2lwaGVyLmMg
IHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L2NyeXB0by9hYmxrY2lwaGVyLmMgYi9jcnlwdG8vYWJsa2NpcGhlci5jDQppbmRleCA4NjBjOWU1
ZGZkN2EuLjNiYzBlNzZlYWFlZiAxMDA2NDQNCi0tLSBhL2NyeXB0by9hYmxrY2lwaGVyLmMNCisr
KyBiL2NyeXB0by9hYmxrY2lwaGVyLmMNCkBAIC0zNjcsNiArMzY3LDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYWJsa2NpcGhlcl9yZXBvcnQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGNyeXB0
b19hbGcgKmFsZykNCiAJc3RybmNweShyYmxrY2lwaGVyLnR5cGUsICJhYmxrY2lwaGVyIiwgc2l6
ZW9mKHJibGtjaXBoZXIudHlwZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+
Y3JhX2FibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhl
ci5nZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAt
IDFdID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3Np
emU7DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9hYmxrY2lwaGVyLm1pbl9r
ZXlzaXplOw0KQEAgLTQ0MSw2ICs0NDIsNyBAQCBzdGF0aWMgaW50IGNyeXB0b19naXZjaXBoZXJf
cmVwb3J0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBjcnlwdG9fYWxnICphbGcpDQogCXN0
cm5jcHkocmJsa2NpcGhlci50eXBlLCAiZ2l2Y2lwaGVyIiwgc2l6ZW9mKHJibGtjaXBoZXIudHlw
ZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+Y3JhX2FibGtjaXBoZXIuZ2Vu
aXYgPzogIjxidWlsdC1pbj4iLA0KIAkJc2l6ZW9mKHJibGtjaXBoZXIuZ2VuaXYpKTsNCisJcmJs
a2NpcGhlci5nZW5pdltzaXplb2YocmJsa2NpcGhlci5nZW5pdikgLSAxXSA9ICdcMCc7DQogDQog
CXJibGtjaXBoZXIuYmxvY2tzaXplID0gYWxnLT5jcmFfYmxvY2tzaXplOw0KIAlyYmxrY2lwaGVy
Lm1pbl9rZXlzaXplID0gYWxnLT5jcmFfYWJsa2NpcGhlci5taW5fa2V5c2l6ZTsNCmRpZmYgLS1n
aXQgYS9jcnlwdG8vYmxrY2lwaGVyLmMgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCmluZGV4IDI3Zjk4
NjY2NzYzYS4uNTlhMDkzNmVkOGJjIDEwMDY0NA0KLS0tIGEvY3J5cHRvL2Jsa2NpcGhlci5jDQor
KysgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCkBAIC01MTAsNiArNTEwLDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYmxrY2lwaGVyX3JlcG9ydChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgY3J5cHRv
X2FsZyAqYWxnKQ0KIAlzdHJuY3B5KHJibGtjaXBoZXIudHlwZSwgImJsa2NpcGhlciIsIHNpemVv
ZihyYmxrY2lwaGVyLnR5cGUpKTsNCiAJc3RybmNweShyYmxrY2lwaGVyLmdlbml2LCBhbGctPmNy
YV9ibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhlci5n
ZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAtIDFd
ID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3NpemU7
DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9ibGtjaXBoZXIubWluX2tleXNp
emU7DQotLSANCjIuMTcuMQ0K
