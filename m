Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C052C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B6820868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="YW262+O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfAOPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:46:39 -0500
Received: from mail-eopbgr00115.outbound.protection.outlook.com ([40.107.0.115]:16000
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728876AbfAOPqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEZdGZKsdr8V6eRBnW6saFA5eTLc+qmyhwBJOWdmOfs=;
 b=YW262+O5TOHEyPjQcXtE57p1Vspa57v68QwXHeV+0T79zedA2SqAyKl9rWY23Gfo3woPOqcAn+R41WfwMRIG8enEgb5y3deC2DuuKyg0J+G0lqx+PYuBxay2WJ5SrYcqvA9n+cMYOjp4jVKED6T4twfNoB1VGCMpBBjQCxNcuVo=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2397.EURPRD10.PROD.OUTLOOK.COM (20.177.62.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Tue, 15 Jan 2019 15:46:34 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc83:d2d3:895c:e6fc%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 15:46:34 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] drm/msm: fix building with DEBUG_FS=n
Thread-Topic: [PATCH] drm/msm: fix building with DEBUG_FS=n
Thread-Index: AQHUrOl+xwuNZRmmj0O0KiKEkWsM8A==
Date:   Tue, 15 Jan 2019 15:46:34 +0000
Message-ID: <20190115154620.17964-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0008.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::18)
 To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2397;6:ml8amqeYubzHNemrbnWVlv3M0bMI8pMLfuGbGGAz+Sb+pMbD1KBqhGHgisXgyDMhul59gEIXnPN8ZP+m7SdaaLznQdQh9mICSxI/3MhyE7w5RZUZvYg20OMUY4dfocC/d4Ib9SNhVhDrjveBKSvTRX15O+ZCGcOFMUsx0Cl8Sm/HCKeKVbLraLoHqUTUsCt+fl0T0igvFNmBDEw5iieFaEVU1NBaTzxDdzU2+Kt62n3kfPgo/eqUddCr883+XZPtLOjcqxQQlRfNlamc94/0IVzeG2x45ZEi9Ru2P6DTIBWtMJs2deItkoe4VZHwqrXYF+yU34i2fUBkEQKHwErYeqE8vPKXLfEFdNYjjkhUGvsVxNK3Lf7ms6i4SdtahPebZ1HQM8pj4pKqZdIgtWvQtARexbeD7ssknzbc8+EIAhHdEiUW8VVD70bBpk7B9yjPgpbehJ6D5rZ7p8+TD4o6aA==;5:nCZXE4dXJzfp8qtwFgmusj96pDNYYKF72kV8ZGaKYJiLScNMzZ6E/lKnCA331txFFIloJc5QKoH8aN8HiOF9C3YV9q//PYB4Wx3hAlhlvMbnftzFvaCEKYdLJb8HjEg4ntj3edDrFuUAR/KaYqNd1Zh76+bCE3iXgsWTkyGJyW06cP7aoRY6/A/uFpAQz/tr0d6qpDyvf0zIKrCcRUo4CA==;7:DG3RX/CgbTaCnpR0AlKn/S/2p9Slkoa6H13Q1+pkcSQ0oqtD+IiHD30hg9mDK6TpN3/DDQg41ebITJ4QfXvp+1YA6b6+P10ziv+Jpgzm1UVuXCiuJREHdXNLWIQOKpb26m/X/0aF/RsrkCbGBcKjLA==
x-ms-office365-filtering-correlation-id: 401bcec2-fab7-42ee-d2ff-08d67b00a087
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2397;
x-ms-traffictypediagnostic: VI1PR10MB2397:
x-microsoft-antispam-prvs: <VI1PR10MB239785A86577E58976ED80E48A810@VI1PR10MB2397.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(2616005)(72206003)(36756003)(316002)(68736007)(50226002)(6436002)(8936002)(5660300001)(476003)(256004)(52116002)(14454004)(42882007)(6486002)(102836004)(66066001)(386003)(97736004)(478600001)(26005)(486006)(186003)(6506007)(6512007)(53936002)(305945005)(3846002)(81156014)(1076003)(4326008)(7736002)(44832011)(54906003)(6116002)(8676002)(110136005)(2906002)(81166006)(25786009)(74482002)(71190400001)(8976002)(71200400001)(99286004)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2397;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ohx2hVvO3YjuE2dKhmTz8RmmpIf92v7KqX8NDdIEecCvPdBdG+ipT1YpCgqyz3urLhLWi5znFi0maNvV5GQMCmOP3RfpgRx6jmFMCt1w0+N+elhpX9W5S3GfUaXTATdaWX+miJdPhU+/0kE7D4bUzvvdxKOU3aTUhhy0sg32OanX1JDSod2OqvKwBKwug7DUaAwJAbNF0oOiUoNnL0IFMaLXtC+dvaBem7unYA7y9e67Xc85EH6JYSdsP2FYVBVed5tQQztLT+TQZaszoviSapwye7YYYjBFISMkpycc8hNKwY5hoseIj6qfWVJpaQgqadDofrANRIWX/EQNgr2TUSoKOJrR8lGP7Yovoby3K5sl9yoNsH5+y4dWJ0x8plREk5QUPzjY0Dp0CPRUIPnbWF+GZfxCPnyZ3BVLueI1USQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <498BF87DF1A10E4C8B4A3204462E9C15@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 401bcec2-fab7-42ee-d2ff-08d67b00a087
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 15:46:33.7512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2l0aCBDT05GSUdfREVWX0NPUkVEVU1QPXkgYW5kIENPTkZJR19ERUJVR19GUz1uLCBidWlsZGlu
ZyBmYWlsczoNCg0KZHJpdmVycy9ncHUvZHJtL21zbS9hZHJlbm8vYTJ4eF9ncHUuYzo0Mjg6NDog
ZXJyb3I6IOKAmHN0cnVjdCBtc21fZ3B1X2Z1bmNz4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCY
c2hvd+KAmQ0KICAgLnNob3cgPSBhZHJlbm9fc2hvdywNCiAgICBefn5+DQpkcml2ZXJzL2dwdS9k
cm0vbXNtL2FkcmVuby9hMnh4X2dwdS5jOjQyODoxMTogZXJyb3I6IGluaXRpYWxpemF0aW9uIGZy
b20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRl
ci10eXBlc10NCiAgIC5zaG93ID0gYWRyZW5vX3Nob3csDQogICAgICAgICAgIF5+fn5+fn5+fn5+
DQpkcml2ZXJzL2dwdS9kcm0vbXNtL2FkcmVuby9hMnh4X2dwdS5jOjQyODoxMTogbm90ZTogKG5l
YXIgaW5pdGlhbGl6YXRpb24gZm9yIOKAmGZ1bmNzLmJhc2UuZ3B1X2J1c3nigJkpDQpjYzE6IHNv
bWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCg0KRml4ZXM6IGMwZmVjN2Y1NjJl
YzcgKGRybS9tc20vZ3B1OiBDYXB0dXJlIHRoZSBHUFUgc3RhdGUgb24gYSBHUFUgaGFuZykNCkNj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjQuMTkrDQpTaWduZWQtb2ZmLWJ5OiBSYXNtdXMg
VmlsbGVtb2VzIDxyYXNtdXMudmlsbGVtb2VzQHByZXZhcy5kaz4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tc20vbXNtX2dwdS5oIHwgNiArKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21z
bS9tc21fZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vbXNtL21zbV9ncHUuaA0KaW5kZXggZWZiNDli
YjY0MTkxLi40Y2I0MWRiN2Y5ZTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbXNtL21z
bV9ncHUuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21zbS9tc21fZ3B1LmgNCkBAIC02MywxMCAr
NjMsMTIgQEAgc3RydWN0IG1zbV9ncHVfZnVuY3Mgew0KIAlzdHJ1Y3QgbXNtX3JpbmdidWZmZXIg
KigqYWN0aXZlX3JpbmcpKHN0cnVjdCBtc21fZ3B1ICpncHUpOw0KIAl2b2lkICgqcmVjb3Zlciko
c3RydWN0IG1zbV9ncHUgKmdwdSk7DQogCXZvaWQgKCpkZXN0cm95KShzdHJ1Y3QgbXNtX2dwdSAq
Z3B1KTsNCi0jaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQotCS8qIHNob3cgR1BVIHN0YXR1cyBpbiBk
ZWJ1Z2ZzOiAqLw0KKyNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykgfHwgZGVmaW5lZChDT05G
SUdfREVWX0NPUkVEVU1QKQ0KKwkvKiBzaG93IEdQVSBzdGF0dXMgaW4gZGVidWdmcyBvciBkZXZp
Y2UgY29yZWR1bXA6ICovDQogCXZvaWQgKCpzaG93KShzdHJ1Y3QgbXNtX2dwdSAqZ3B1LCBzdHJ1
Y3QgbXNtX2dwdV9zdGF0ZSAqc3RhdGUsDQogCQkJc3RydWN0IGRybV9wcmludGVyICpwKTsNCisj
ZW5kaWYNCisjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQogCS8qIGZvciBnZW5lcmF0aW9uIHNwZWNp
ZmljIGRlYnVnZnM6ICovDQogCWludCAoKmRlYnVnZnNfaW5pdCkoc3RydWN0IG1zbV9ncHUgKmdw
dSwgc3RydWN0IGRybV9taW5vciAqbWlub3IpOw0KICNlbmRpZg0KLS0gDQoyLjIwLjENCg0K
