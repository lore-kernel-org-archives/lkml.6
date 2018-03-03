Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122909-2-13880170102586968625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122909; b=uShOrmC213MR46/ZVDhdigZypeRMyfSGDZ1UhRoxAe1Jlzk
    mXDShVhtuSimFsW00B+dYbXGBH/YlM8GLAnOWIaRtWuZ+vX6NBo12tCALT4AbXRo
    +9PG4eJjXNkxbeDx7s0uobr3GsBN+iJMZvXkkIk8ZzCnUpBq+dJ+YjqTUgUtv08o
    7VVlUz5fnaCL8+K+h4rBIL9eWQTjtxcWH54IVbZ3T81T6V2erKjbqhmsI5RS34xF
    sLCk83s/eu12rqv0mjhDYhLnmv40v8umTuGoLiuFaWEKkSHGLu3q9FVEBk/b/KqU
    XWYVjPwGzogEBgr7g9thKPI5Hjwuxo9wOs5NSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520122909; bh=jV/BrDeGkKnJeJ4WaMjeGLKzLf4y7VuLcEI4y/
    5Paxo=; b=sggQe6w5tslKPJ8gzMMW/z32tXUOAZB7LaAuVDEdNpGRh63zqEF7Iu
    dTE4+rHkEklrHQv5xhMWtW2C4BFnID6A1OyFyvdnlzWC7RpY6udp8zh7JGXAp7k4
    eOY4NFzi4El6ND64pV/jIjNAi4xohVj7xo1EJm3wtJoVFWSksQIIUeI7TmrFzXs7
    de6fhRb+iDo/nKyeRwkOYfs8fppO8Vrc512D07h95NlbwvIgtz+Wg8J/ARtqAjjc
    M8hz8UIhKp/bJiIVSsSrrQHxFblyX4XvUBvAYqI1Ru7CXVK5lVGaR9h8CltAbEqK
    BluslbmwmynBCLdvtp+U3ws7Tw75ilgA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MVEFBXD6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MVEFBXD6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933269AbeCDAVg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:21:36 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:45301
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933265AbeCCW25 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?U3RlZmFuIEJyw7xucw==?= <stefan.bruens@rwth-aachen.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 36/84] iio: adc: ina2xx: Shift bus voltage
 register to mask flag bits
Thread-Topic: [PATCH AUTOSEL for 4.14 36/84] iio: adc: ina2xx: Shift bus
 voltage register to mask flag bits
Thread-Index: AQHTsz6nrQaaMRE7gEu9DAPPt2nwKQ==
Date: Sat, 3 Mar 2018 22:26:20 +0000
Message-ID: <20180303222518.26271-36-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:QyC9akYI3leK9X0wiYC9NAwMhaaN43C0urEXqKWw8gBGg5LKUUa6HKZgtIA47GazV0EObNvZroYfDqRxeiDrLUj4JRAa4N/GLjPIyoK6dTEoZgZk06B4DbC1qGE/7nfQPuQCAWOt+52Okbfefb/gNg0bBO3EtgnYLPh+vXxeWlBX7LkoPZN+WpL61ON7BWZ0X3DLoPA771ygJXah/ejC/ayyTcfbJpKpLVf01wOZu0F50VCkTgA2lrWaolUzGZP2
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e823ccd1-ab37-4c17-0026-08d5815626b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB111556F942404C72B8DFB553FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: PUnu5i85hfZIo33AsZFXGMdUC1J4aWi8Jm+p+seWSsdFrgh/NvMiLe8h4qsb1WpUOKYGy1mZ7vdoSFax/cNTW/zWryhsnYvNkq2bkEXoPKFYFV6jRG0iISfrZV9tnGiEoDZxMdHH9Wa0fNaS9kmZ8pGHl1Q2vjcyEnLI/jAv1Gg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FE63017ABB6FB418758E60379A1DD8D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e823ccd1-ab37-4c17-0026-08d5815626b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:20.7129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogU3RlZmFuIEJyw7xucyA8c3RlZmFuLmJydWVuc0Byd3RoLWFhY2hlbi5kZT4NCg0KWyBV
cHN0cmVhbSBjb21taXQgMmU2NDQzODQ4NzY5N2YzZjA5OTk0NmVkYzhhY2Q0Y2VlYTZiMWFiMiBd
DQoNCkxvd2VyIGJpdHMgb2YgdGhlIElOQTIxOS8yMjAgYnVzIHZvbHRhZ2UgcmVnaXN0ZXIgYXJl
IGNvbnZlcnNpb24NCnN0YXR1cyBmbGFncywgcHJvcGVybHkgc2hpZnQgdGhlIHZhbHVlLg0KDQpX
aGVuIHJlYWRpbmcgdmlhIElJTyBidWZmZXIsIHRoZSB2YWx1ZSBpcyBwYXNzZWQgb24gdW5hbHRl
cmVkLA0Kc2hpZnRpbmcgaXMgdGhlIHJlc3BvbnNpYmlsaXR5IG9mIHRoZSB1c2VyLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW4gQnLDvG5zIDxzdGVmYW4uYnJ1ZW5zQHJ3dGgtYWFjaGVuLmRlPg0K
U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWku
Y29tPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3Nv
ZnQuY29tPg0KLS0tDQogZHJpdmVycy9paW8vYWRjL2luYTJ4eC1hZGMuYyB8IDI2ICsrKysrKysr
KysrKysrKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDkg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvaW5hMnh4LWFkYy5j
IGIvZHJpdmVycy9paW8vYWRjL2luYTJ4eC1hZGMuYw0KaW5kZXggZjM4N2I5NzJlNGY0Li41OWY5
OWIzYTE4MGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lpby9hZGMvaW5hMnh4LWFkYy5jDQorKysg
Yi9kcml2ZXJzL2lpby9hZGMvaW5hMnh4LWFkYy5jDQpAQCAtNDQsNyArNDQsNiBAQA0KIA0KICNk
ZWZpbmUgSU5BMjI2X01BU0tfRU5BQkxFCQkweDA2DQogI2RlZmluZSBJTkEyMjZfQ1ZSRgkJCUJJ
VCgzKQ0KLSNkZWZpbmUgSU5BMjE5X0NOVlIJCQlCSVQoMSkNCiANCiAjZGVmaW5lIElOQTJYWF9N
QVhfUkVHSVNURVJTICAgICAgICAgICAgOA0KIA0KQEAgLTc5LDYgKzc4LDExIEBADQogI2RlZmlu
ZSBJTkEyMjZfSVRTX01BU0sJCUdFTk1BU0soNSwgMykNCiAjZGVmaW5lIElOQTIyNl9TSElGVF9J
VFModmFsKQkoKHZhbCkgPDwgMykNCiANCisvKiBJTkEyMTkgQnVzIHZvbHRhZ2UgcmVnaXN0ZXIs
IGxvdyBiaXRzIGFyZSBmbGFncyAqLw0KKyNkZWZpbmUgSU5BMjE5X09WRgkJQklUKDApDQorI2Rl
ZmluZSBJTkEyMTlfQ05WUgkJQklUKDEpDQorI2RlZmluZSBJTkEyMTlfQlVTX1ZPTFRBR0VfU0hJ
RlQJMw0KKw0KIC8qIENvc21ldGljIG1hY3JvIGdpdmluZyB0aGUgc2FtcGxpbmcgcGVyaW9kIGZv
ciBhIGZ1bGwgUD1VeEkgY3ljbGUgKi8NCiAjZGVmaW5lIFNBTVBMSU5HX1BFUklPRChjKQkoKGMt
PmludF90aW1lX3ZidXMgKyBjLT5pbnRfdGltZV92c2h1bnQpIFwNCiAJCQkJICogYy0+YXZnKQ0K
QEAgLTExMiw3ICsxMTYsNyBAQCBzdHJ1Y3QgaW5hMnh4X2NvbmZpZyB7DQogCXUxNiBjb25maWdf
ZGVmYXVsdDsNCiAJaW50IGNhbGlicmF0aW9uX2ZhY3RvcjsNCiAJaW50IHNodW50X2RpdjsNCi0J
aW50IGJ1c192b2x0YWdlX3NoaWZ0Ow0KKwlpbnQgYnVzX3ZvbHRhZ2Vfc2hpZnQ7CS8qIHBvc2l0
aW9uIG9mIGxzYiAqLw0KIAlpbnQgYnVzX3ZvbHRhZ2VfbHNiOwkvKiB1ViAqLw0KIAlpbnQgcG93
ZXJfbHNiOwkJLyogdVcgKi8NCiAJZW51bSBpbmEyeHhfaWRzIGNoaXBfaWQ7DQpAQCAtMTM1LDcg
KzEzOSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW5hMnh4X2NvbmZpZyBpbmEyeHhfY29uZmln
W10gPSB7DQogCQkuY29uZmlnX2RlZmF1bHQgPSBJTkEyMTlfQ09ORklHX0RFRkFVTFQsDQogCQku
Y2FsaWJyYXRpb25fZmFjdG9yID0gNDA5NjAwMDAsDQogCQkuc2h1bnRfZGl2ID0gMTAwLA0KLQkJ
LmJ1c192b2x0YWdlX3NoaWZ0ID0gMywNCisJCS5idXNfdm9sdGFnZV9zaGlmdCA9IElOQTIxOV9C
VVNfVk9MVEFHRV9TSElGVCwNCiAJCS5idXNfdm9sdGFnZV9sc2IgPSA0MDAwLA0KIAkJLnBvd2Vy
X2xzYiA9IDIwMDAwLA0KIAkJLmNoaXBfaWQgPSBpbmEyMTksDQpAQCAtMTcwLDYgKzE3NCw5IEBA
IHN0YXRpYyBpbnQgaW5hMnh4X3JlYWRfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQog
CQllbHNlDQogCQkJKnZhbCAgPSByZWd2YWw7DQogDQorCQlpZiAoY2hhbi0+YWRkcmVzcyA9PSBJ
TkEyWFhfQlVTX1ZPTFRBR0UpDQorCQkJKnZhbCA+Pj0gY2hpcC0+Y29uZmlnLT5idXNfdm9sdGFn
ZV9zaGlmdDsNCisNCiAJCXJldHVybiBJSU9fVkFMX0lOVDsNCiANCiAJY2FzZSBJSU9fQ0hBTl9J
TkZPX09WRVJTQU1QTElOR19SQVRJTzoNCkBAIC0yMDMsOSArMjEwLDkgQEAgc3RhdGljIGludCBp
bmEyeHhfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCiAJCQlyZXR1cm4gSUlP
X1ZBTF9GUkFDVElPTkFMOw0KIA0KIAkJY2FzZSBJTkEyWFhfQlVTX1ZPTFRBR0U6DQotCQkJLyog
cHJvY2Vzc2VkIChtVikgPSByYXcqbHNiICh1VikgLyAoMTAwMCA8PCBzaGlmdCkgKi8NCisJCQkv
KiBwcm9jZXNzZWQgKG1WKSA9IHJhdyAqIGxzYiAodVYpIC8gMTAwMCAqLw0KIAkJCSp2YWwgPSBj
aGlwLT5jb25maWctPmJ1c192b2x0YWdlX2xzYjsNCi0JCQkqdmFsMiA9IDEwMDAgPDwgY2hpcC0+
Y29uZmlnLT5idXNfdm9sdGFnZV9zaGlmdDsNCisJCQkqdmFsMiA9IDEwMDA7DQogCQkJcmV0dXJu
IElJT19WQUxfRlJBQ1RJT05BTDsNCiANCiAJCWNhc2UgSU5BMlhYX1BPV0VSOg0KQEAgLTUzMiw3
ICs1MzksNyBAQCBzdGF0aWMgc3NpemVfdCBpbmEyeHhfc2h1bnRfcmVzaXN0b3Jfc3RvcmUoc3Ry
dWN0IGRldmljZSAqZGV2LA0KICAqIFNhbXBsaW5nIEZyZXEgaXMgYSBjb25zZXF1ZW5jZSBvZiB0
aGUgaW50ZWdyYXRpb24gdGltZXMgb2YNCiAgKiB0aGUgVm9sdGFnZSBjaGFubmVscy4NCiAgKi8N
Ci0jZGVmaW5lIElOQTIxOV9DSEFOX1ZPTFRBR0UoX2luZGV4LCBfYWRkcmVzcykgeyBcDQorI2Rl
ZmluZSBJTkEyMTlfQ0hBTl9WT0xUQUdFKF9pbmRleCwgX2FkZHJlc3MsIF9zaGlmdCkgeyBcDQog
CS50eXBlID0gSUlPX1ZPTFRBR0UsIFwNCiAJLmFkZHJlc3MgPSAoX2FkZHJlc3MpLCBcDQogCS5p
bmRleGVkID0gMSwgXA0KQEAgLTU0NCw3ICs1NTEsOCBAQCBzdGF0aWMgc3NpemVfdCBpbmEyeHhf
c2h1bnRfcmVzaXN0b3Jfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KIAkuc2Nhbl9pbmRleCA9
IChfaW5kZXgpLCBcDQogCS5zY2FuX3R5cGUgPSB7IFwNCiAJCS5zaWduID0gJ3UnLCBcDQotCQku
cmVhbGJpdHMgPSAxNiwgXA0KKwkJLnNoaWZ0ID0gX3NoaWZ0LCBcDQorCQkucmVhbGJpdHMgPSAx
NiAtIF9zaGlmdCwgXA0KIAkJLnN0b3JhZ2ViaXRzID0gMTYsIFwNCiAJCS5lbmRpYW5uZXNzID0g
SUlPX0xFLCBcDQogCX0gXA0KQEAgLTU3OSw4ICs1ODcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGlpb19jaGFuX3NwZWMgaW5hMjI2X2NoYW5uZWxzW10gPSB7DQogfTsNCiANCiBzdGF0aWMgY29u
c3Qgc3RydWN0IGlpb19jaGFuX3NwZWMgaW5hMjE5X2NoYW5uZWxzW10gPSB7DQotCUlOQTIxOV9D
SEFOX1ZPTFRBR0UoMCwgSU5BMlhYX1NIVU5UX1ZPTFRBR0UpLA0KLQlJTkEyMTlfQ0hBTl9WT0xU
QUdFKDEsIElOQTJYWF9CVVNfVk9MVEFHRSksDQorCUlOQTIxOV9DSEFOX1ZPTFRBR0UoMCwgSU5B
MlhYX1NIVU5UX1ZPTFRBR0UsIDApLA0KKwlJTkEyMTlfQ0hBTl9WT0xUQUdFKDEsIElOQTJYWF9C
VVNfVk9MVEFHRSwgSU5BMjE5X0JVU19WT0xUQUdFX1NISUZUKSwNCiAJSU5BMjE5X0NIQU4oSUlP
X1BPV0VSLCAyLCBJTkEyWFhfUE9XRVIpLA0KIAlJTkEyMTlfQ0hBTihJSU9fQ1VSUkVOVCwgMywg
SU5BMlhYX0NVUlJFTlQpLA0KIAlJSU9fQ0hBTl9TT0ZUX1RJTUVTVEFNUCg0KSwNCi0tIA0KMi4x
NC4xDQo=
