Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116065-2-10402121354506499844
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116065; b=UmC8+s7j9yKntGEXEM0F3wQJSPeMSevNo7Y4ERBzP7Q2S9H
    PR1gfdX/tPm/SuAzbfJl3Ijv/3W/xm2n/jq/pIJ0up5ijBMOsS7Vctu1mTvJ+ju7
    WGO4CEUHZmbUlUdl0/cLHRoJ147eV52hvjMEvvElPP1DEWpDQOVGxq3yP2DPQMjf
    AGBkiPVxTiyIGLhMVVJ02DbZSKUU1efE+cAykf9TTrXh6cenX0l5uCJvJmkOnXej
    QFgG95GUMV2u5W0Ps2wk2auTpleWHAN4gfRaRPI+Tyhf7x54QIkXVScZM9huAc+k
    aKxYyyr8LZGUk9MWVSaZhmgnLV63IyT6GjAyHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520116065; bh=TSVyVsMt/zixtIhWEEH/Yp2iP/a2O+EyEIlIBu
    Hmtmo=; b=UpllM6hSWluW0FpNeeWb+z9z3+nOSrRPrwvc6+RZT1QLX5UDLGcq7g
    A8fwNAp3l1IHca57SKqemuexwi5wQZvZXeHO+t62KPddUWuICOeQnUmKb3waaw7Y
    c8hzjJ7zsF8a/vuHFuaoRbqohrF1kLKYNg6GmUEXwF/grYY72Y4KecMwqVaOoCov
    Nbb50dD6EQQwfg+N3JkEnh4EsOBtDAqcTvmNT9Oxe38VDac4fEEqlCm+Fpj/YKMd
    9xH7TSq30dZegDWNAspfD5BqFcqgz8SQZISAdefXMxYuyR2tFCS5+VSXfEOXHocf
    MxPBWHluMepFdRWYV3BANEHcZnbAzS5A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dbAMXgCF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dbAMXgCF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932796AbeCCW04 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:56 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:17369
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932793AbeCCW0y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 066/102] drm/amdgpu: fix amdgpu_sync_resv v2
Thread-Topic: [PATCH AUTOSEL for 4.15 066/102] drm/amdgpu: fix
 amdgpu_sync_resv v2
Thread-Index: AQHTsz5wipfdTQYfYUSdfbLV5FlqUw==
Date: Sat, 3 Mar 2018 22:24:47 +0000
Message-ID: <20180303222318.26006-66-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:C+1WwQ71TL86rPj7Kn0EsZKnjV+iwKReVvPYsG8Vg65owXphXr0A2O4pJnhzXvTO7vKNNL9MEhYGkVUGkL49dyAkiQybPxTgrbUSEzYGdRGh8G2zUglDt8Ftnko8LSp+mJNzbE5Eit9obTNujObYhue7wtQ9nnMp6qwl+aTcVNKLXYRkJfzhYCwwlejZ823xhjdvcs5YzMU1bbaEC2R7O/E6H3OO+N5QAwAFQxe4LaK/qnpRxjrPQAFVV8xAFuNh
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b97c2ba-c6e9-44a1-8c12-08d58155dc81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06754458C4499355059183FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(8666007)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YbuOr37ONa7S7uHCjk09Nt1YTQnRxYnHZmygKbhHYQm5WeRgMbzwbfNnvCtH2SJAW5l5mmVeppvUNOjZcI2Pta+OIVDec/XhdnrBxSApWwkT+SZ7pX9QaO+KKxHFpKQd0AUwNrf7sLD7uYPdh8DPA0bzS7NPKy7Ovm+xCpDLhjw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <80ECADE423DDB947B1356CA52BBEED6F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b97c2ba-c6e9-44a1-8c12-08d58155dc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:47.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQpbIFVw
c3RyZWFtIGNvbW1pdCBkNGI3NjQ4ZDZkMTc3NGY5NjFmM2Y2YTc1OGQ5YjAwOWYxZjM0ZjA1IF0N
Cg0KRml4ZXMgYSBidWcgaW50cm9kdWNlZCBieSBBTURHUFVfR0VNX0NSRUFURV9FWFBMSUNJVF9T
WU5DLiBXZSBzdGlsbCBuZWVkDQp0byB3YWl0IGZvciBwaXBlbGluZWQgbW92ZXMgaW4gdGhlIHNo
YXJlZCBmZW5jZXMgbGlzdC4NCg0KdjI6IGZpeCB0eXBvDQoNClNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NClJldmlld2VkLWJ5OiBBbmRy
ZXMgUm9kcmlndWV6IDxhbmRyZXN4N0BnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBM
ZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfc3luYy5jIHwgNyArKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfc3luYy5jDQppbmRleCBhNGJmMjFmOGYxYzEuLmJiYmM0MGQ2MzBhMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMNCkBAIC0xOTEsOSArMTkx
LDYgQEAgaW50IGFtZGdwdV9zeW5jX3Jlc3Yoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQog
CWYgPSByZXNlcnZhdGlvbl9vYmplY3RfZ2V0X2V4Y2wocmVzdik7DQogCXIgPSBhbWRncHVfc3lu
Y19mZW5jZShhZGV2LCBzeW5jLCBmKTsNCiANCi0JaWYgKGV4cGxpY2l0X3N5bmMpDQotCQlyZXR1
cm4gcjsNCi0NCiAJZmxpc3QgPSByZXNlcnZhdGlvbl9vYmplY3RfZ2V0X2xpc3QocmVzdik7DQog
CWlmICghZmxpc3QgfHwgcikNCiAJCXJldHVybiByOw0KQEAgLTIxMiwxMSArMjA5LDExIEBAIGlu
dCBhbWRncHVfc3luY19yZXN2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KIAkJCSAgICAg
KGZlbmNlX293bmVyID09IEFNREdQVV9GRU5DRV9PV05FUl9WTSkpKQ0KIAkJCQljb250aW51ZTsN
CiANCi0JCQkvKiBJZ25vcmUgZmVuY2UgZnJvbSB0aGUgc2FtZSBvd25lciBhcw0KKwkJCS8qIEln
bm9yZSBmZW5jZSBmcm9tIHRoZSBzYW1lIG93bmVyIGFuZCBleHBsaWNpdCBvbmUgYXMNCiAJCQkg
KiBsb25nIGFzIGl0IGlzbid0IHVuZGVmaW5lZC4NCiAJCQkgKi8NCiAJCQlpZiAob3duZXIgIT0g
QU1ER1BVX0ZFTkNFX09XTkVSX1VOREVGSU5FRCAmJg0KLQkJCSAgICBmZW5jZV9vd25lciA9PSBv
d25lcikNCisJCQkgICAgKGZlbmNlX293bmVyID09IG93bmVyIHx8IGV4cGxpY2l0X3N5bmMpKQ0K
IAkJCQljb250aW51ZTsNCiAJCX0NCiANCi0tIA0KMi4xNC4xDQo=
