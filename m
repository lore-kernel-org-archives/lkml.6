Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4147991-1523247061-2-9928056224986696825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523247060; b=rZkthr4KxlFGnosI5yZCJt91Qxr28YwZu/APO79/CpYzOrVBzx
    HwzBR1RgjclMJsK4XuZIIOcJQHcfHKRkIxUoUux2PklzSHOnb5tM/9HQbMFqi1sU
    MNYGxzNmHOHbzYbE7wTapWSZIsuckXh4pABah/o9+NqnfiOa0IoGz8nn3dVTAq53
    +U7cY/QRMUNJf0EXm3G3Ketx8DYO3RuXClZwYyLAr3pAXKa2KzLwvXmYWIOAmBfx
    Tm/licc9KXqDVobKeoL24MeJo1+2gWG5yX3Go3bZ2MHHPUcnlP3YOxhYIq+h9kIp
    hFKz5m8KHKlE1C7cZeXgIIJvW8KMD+9UetNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523247060; bh=UjproX5vAcoUUAUdLF6KBV8QYfSjBxLULZFv5Q4/R4c=; b=
    CZ7gTvlrtVQEvWTsq2/A8eovMCZUmk64Frj0HknP/2DyKF5lKiMryhqdEdRgiEAW
    2ExYN+rQcfieBn9yvkS+uA4W68nHp4YUfc+KxwyixJGDbf7ya0/GMJri8iyve2NL
    UX/LdZzHx3wfK8nmvJaK1h2iBmF5BmA+YtUjogjHsgQ6Tw0AX+vyKQ1BWnAIs4Fn
    eZoNFm/yn1ec3+BOaDG3moknXv5a0smhUOQwrYL186g/t4hoUx0LIQOD3s/wbPep
    sEO4/7gd6UJjCz5iucWjxCXxZCtCnKMjkV0CMIv6CAcCghD71vL/y8CKdOJmIpkV
    SkjdsQtv7rv0TfgzqT+dEw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NeNagTNy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NeNagTNy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCYC8tejFZR3dWw6IjajlvQo0ijkMx8GRVvshUz5/GuQVPFezTg0HBWrysEKp5KJlbaLoDeS5E+JVKApMZBgjrJyrnj/twjiB6JGUXY3GXs1KUZNPRdL
    4L0zLS+y3Itxg+JXfuOgLZfsywWwYV/lg/xqV7lEN5cfFj7o73/Dza4qXX8QdBYP+MpgVV6jveaRX6fmj+xC2ylwP4pDC8nGBqv2YD/L58idDnyLFfZla4CS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=iYBqROrJM-20mFt28jwA:9 a=GdNakm-1_ZxDm1rf:21
    a=54aOE-0-7H9qIBq9:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeDIEK4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:10:56 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:48974
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeDIARB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:01 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 016/189] platform/x86: dell-laptop: Filter
 out spurious keyboard backlight change events
Thread-Topic: [PATCH AUTOSEL for 4.15 016/189] platform/x86: dell-laptop:
 Filter out spurious keyboard backlight change events
Thread-Index: AQHTz5gRDSZlmlw+eEemMRsyQ0UJjA==
Date: Mon, 9 Apr 2018 00:16:56 +0000
Message-ID: <20180409001637.162453-16-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:GovZ/T9Dcdyd6tvEH7rXp/Cn++2aCA0CcS73y4A7yY4f6fiNZhx7IveN/FKKlTbLFAcq9Sdh6p8GBHREJVY4Xp8HIcKQAPBVW1tzKEMQwiqhRQToEZ0LZkcOjOEXoOKtqtfCyV8i+DIn5U8UzWxfNVq7GfF/8jbMeK0jVsSZsovigfzB/8d7ZuDaiOrEGhGkEK3Zj9KC2eo8J7S1xMsxtjSbuL6qvgnVegLp6F6aHyDGv/fB/vrIW1GBQgidARoA;20:9FD0EdyLMjBl61Hft1RA/BfV04CONbAHkmvTd0OOLUG6YysguB8FiKagb4g0eIOD423QWjOK8MclDTgnPx74iLP8Z2TOOiEdsV/X02fdvhJbn2v+A/t9SMeiYx3Ok68Z3HZXdmWogaX4EZ9Jhq8ug6LR1HnqZXA/6/OyvVt5d9U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 561030fe-19e7-466c-6a44-08d59daf3497
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11270559F3EEDBB3D1FABB7CFBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(83566789882024)(211171220733660)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(966005)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(6306002)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tVXs2L5qdlPXGHDa4fIwnByHFVXWtsfiCVm0lf6Z28EVkfHpa1ubeHan2laxLSI9eX6DzwJl0VmEFTG+QRSIa6wNT0TDHlYIwyq19Mp9+INLa/SuY7b1ZSSQszURHkQqS4z941qDZamWXXp2vENjkwAF6WuAE9UZGYgCo0nUQoE8ovWw/8LSHICYVdk9Hl4UjPytV6nLwOvEb9OAHId0MX1845C9xaAqIAR2PvuBY0UraQ+joka0Hrrjs1MDBHiZ5+xVDGD3ZiK3ZbqjvKcY9/cCkyho0F6B3ZVYbxAylCtKEyr/NaCVDMP7uYkcf7fjzpFxvp5xBDHn+EcCHKVGcz9Zw9RjkJO2uXiea0kwpp4tsjdgkxtCTzXTViv5xjZrcQ5W+Ajz9IXk86uaoXnsuACctpwPqcRwK6r9X29Hpns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D50E0DAD44FA40A8D1A2DE333F4CF1@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561030fe-19e7-466c-6a44-08d59daf3497
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:56.8406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCg0KWyBVcHN0cmVhbSBj
b21taXQgNGQ2YmRlNTEyYTg2YzMyZGYzYTFmMjg5ZDJiNGNkMDRiMTc3NThkMSBdDQoNCk9uIHNv
bWUgRGVsbCBYUFMgbW9kZWxzIFdNSSBldmVudHMgb2YgdHlwZSAweDAwMDAgcmVwb3J0aW5nIGEg
a2V5Y29kZSBvZg0KMHhlMDBjIGdldCByZXBvcnRlZCB3aGVuIHRoZSBicmlnaHRuZXNzIG9mIHRo
ZSBMQ0QgcGFuZWwgY2hhbmdlcy4NCg0KVGhpcyBsZWFkcyB0byB1cyByZXBvcnRpbmcgZmFsc2Ut
cG9zaXRpdmUga2JkX2xlZCBjaGFuZ2UgZXZlbnRzIHRvDQp1c2Vyc3BhY2Ugd2hpY2ggaW4gdHVy
biBsZWFkcyB0byB0aGUga2JkIGJhY2tsaWdodCBPU0Qgc2hvd2luZyB3aGVuIGl0DQpzaG91bGQg
bm90Lg0KDQpXZSBhbHJlYWR5IHJlYWQgdGhlIGN1cnJlbnQga2V5Ym9hcmQgYmFja2xpZ2h0IGJy
aWdodG5lc3MgdmFsdWUgd2hlbg0KcmVwb3J0aW5nIGV2ZW50cyBiZWNhdXNlIHRoZSBsZWRfY2xh
c3NkZXZfbm90aWZ5X2JyaWdodG5lc3NfaHdfY2hhbmdlZA0KQVBJIHJlcXVpcmVzIHRoaXMuIENv
bXBhcmUgdGhpcyB2YWx1ZSB0byB0aGUgbGFzdCBrbm93biB2YWx1ZSBhbmQgZmlsdGVyDQpvdXQg
ZHVwbGljYXRlIGV2ZW50cywgZml4aW5nIHRoaXMuDQoNCk5vdGUgdGhlIGZpeGVkIGlzc3VlIGlz
IGVzcC4gYSBwcm9ibGVtIG9uIFhQUyBtb2RlbHMgd2l0aCBhbiBhbWJpZW50IGxpZ2h0DQpzZW5z
b3IgYW5kIGF1dG9tYXRpYyBicmlnaHRuZXNzIGFkanVzdG1lbnRzIHR1cm5lZCBvbiwgdGhpcyBj
YXVzZXMgdGhlIGtiZA0KYmFja2xpZ2h0IE9TRCB0byBzaG93IGFsbCB0aGUgdGltZSB0aGVyZS4N
Cg0KQnVnTGluazogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0x
NTE0OTY5DQpGaXhlczogOWM2NTZiMDc5OSAoInBsYXRmb3JtL3g4NjogZGVsbC0qOiBDYWxsIG5l
dyBsZWQgaHdfY2hhbmdlZCBBUEkgLi4uIikNCkFja2VkLWJ5OiBQYWxpIFJvaMOhciA8cGFsaS5y
b2hhckBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUBy
ZWRoYXQuY29tPg0KU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFu
ZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxs
LWxhcHRvcC5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKy0tDQogMSBmaWxlIGNoYW5nZWQs
IDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni9kZWxsLWxhcHRvcC5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVsbC1s
YXB0b3AuYw0KaW5kZXggYzg2NDQzMGI5ZmNmLi44ZGRiMzA5Y2ZjODUgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLWxhcHRvcC5jDQorKysgYi9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9kZWxsLWxhcHRvcC5jDQpAQCAtMTE0OSw2ICsxMTQ5LDcgQEAgc3RhdGljIHU4IGtiZF9w
cmV2aW91c19tb2RlX2JpdDsNCiANCiBzdGF0aWMgYm9vbCBrYmRfbGVkX3ByZXNlbnQ7DQogc3Rh
dGljIERFRklORV9NVVRFWChrYmRfbGVkX211dGV4KTsNCitzdGF0aWMgZW51bSBsZWRfYnJpZ2h0
bmVzcyBrYmRfbGVkX2xldmVsOw0KIA0KIC8qDQogICogTk9URTogdGhlcmUgYXJlIHRocmVlIHdh
eXMgdG8gc2V0IHRoZSBrZXlib2FyZCBiYWNrbGlnaHQgbGV2ZWwuDQpAQCAtMTk3MSw2ICsxOTcy
LDcgQEAgc3RhdGljIGVudW0gbGVkX2JyaWdodG5lc3Mga2JkX2xlZF9sZXZlbF9nZXQoc3RydWN0
IGxlZF9jbGFzc2RldiAqbGVkX2NkZXYpDQogc3RhdGljIGludCBrYmRfbGVkX2xldmVsX3NldChz
dHJ1Y3QgbGVkX2NsYXNzZGV2ICpsZWRfY2RldiwNCiAJCQkgICAgIGVudW0gbGVkX2JyaWdodG5l
c3MgdmFsdWUpDQogew0KKwllbnVtIGxlZF9icmlnaHRuZXNzIG5ld192YWx1ZSA9IHZhbHVlOw0K
IAlzdHJ1Y3Qga2JkX3N0YXRlIHN0YXRlOw0KIAlzdHJ1Y3Qga2JkX3N0YXRlIG5ld19zdGF0ZTsN
CiAJdTE2IG51bTsNCkBAIC0yMDAwLDYgKzIwMDIsOSBAQCBzdGF0aWMgaW50IGtiZF9sZWRfbGV2
ZWxfc2V0KHN0cnVjdCBsZWRfY2xhc3NkZXYgKmxlZF9jZGV2LA0KIAl9DQogDQogb3V0Og0KKwlp
ZiAocmV0ID09IDApDQorCQlrYmRfbGVkX2xldmVsID0gbmV3X3ZhbHVlOw0KKw0KIAltdXRleF91
bmxvY2soJmtiZF9sZWRfbXV0ZXgpOw0KIAlyZXR1cm4gcmV0Ow0KIH0NCkBAIC0yMDI3LDYgKzIw
MzIsOSBAQCBzdGF0aWMgaW50IF9faW5pdCBrYmRfbGVkX2luaXQoc3RydWN0IGRldmljZSAqZGV2
KQ0KIAkJaWYgKGtiZF9sZWQubWF4X2JyaWdodG5lc3MpDQogCQkJa2JkX2xlZC5tYXhfYnJpZ2h0
bmVzcy0tOw0KIAl9DQorDQorCWtiZF9sZWRfbGV2ZWwgPSBrYmRfbGVkX2xldmVsX2dldChOVUxM
KTsNCisNCiAJcmV0ID0gbGVkX2NsYXNzZGV2X3JlZ2lzdGVyKGRldiwgJmtiZF9sZWQpOw0KIAlp
ZiAocmV0KQ0KIAkJa2JkX2xlZF9wcmVzZW50ID0gZmFsc2U7DQpAQCAtMjA1MSwxMyArMjA1OSwy
NSBAQCBzdGF0aWMgdm9pZCBrYmRfbGVkX2V4aXQodm9pZCkNCiBzdGF0aWMgaW50IGRlbGxfbGFw
dG9wX25vdGlmaWVyX2NhbGwoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwNCiAJCQkJICAgICB1
bnNpZ25lZCBsb25nIGFjdGlvbiwgdm9pZCAqZGF0YSkNCiB7DQorCWJvb2wgY2hhbmdlZCA9IGZh
bHNlOw0KKwllbnVtIGxlZF9icmlnaHRuZXNzIG5ld19rYmRfbGVkX2xldmVsOw0KKw0KIAlzd2l0
Y2ggKGFjdGlvbikgew0KIAljYXNlIERFTExfTEFQVE9QX0tCRF9CQUNLTElHSFRfQlJJR0hUTkVT
U19DSEFOR0VEOg0KIAkJaWYgKCFrYmRfbGVkX3ByZXNlbnQpDQogCQkJYnJlYWs7DQogDQotCQls
ZWRfY2xhc3NkZXZfbm90aWZ5X2JyaWdodG5lc3NfaHdfY2hhbmdlZCgma2JkX2xlZCwNCi0JCQkJ
CQlrYmRfbGVkX2xldmVsX2dldCgma2JkX2xlZCkpOw0KKwkJbXV0ZXhfbG9jaygma2JkX2xlZF9t
dXRleCk7DQorCQluZXdfa2JkX2xlZF9sZXZlbCA9IGtiZF9sZWRfbGV2ZWxfZ2V0KCZrYmRfbGVk
KTsNCisJCWlmIChrYmRfbGVkX2xldmVsICE9IG5ld19rYmRfbGVkX2xldmVsKSB7DQorCQkJa2Jk
X2xlZF9sZXZlbCA9IG5ld19rYmRfbGVkX2xldmVsOw0KKwkJCWNoYW5nZWQgPSB0cnVlOw0KKwkJ
fQ0KKwkJbXV0ZXhfdW5sb2NrKCZrYmRfbGVkX211dGV4KTsNCisNCisJCWlmIChjaGFuZ2VkKQ0K
KwkJCWxlZF9jbGFzc2Rldl9ub3RpZnlfYnJpZ2h0bmVzc19od19jaGFuZ2VkKCZrYmRfbGVkLA0K
KwkJCQkJCQkJa2JkX2xlZF9sZXZlbCk7DQogCQlicmVhazsNCiAJfQ0KIA0KLS0gDQoyLjE1LjEN
Cg==
