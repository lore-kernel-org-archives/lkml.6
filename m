Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116146-2-7375505904286735938
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
    t=1520116145; b=MnLjCfk1o3GO/XH5H566V8KqYF6nLA+CcUY+P2vFsN8EymU
    iZ2pIhMM3/czgSUl3MPXjAwVh5AP61GYMuHvk85z6pVMWwPZtSoPedh58hbN7aUU
    CD32ftqtl3dLzfOZ1mWKnU9zRwEtPg5sRBDdH5YeAHv7IaP9FB17xerNvsLyliWf
    XXoA9/hPse42QHdJlV8dOQipCfMCi69DTkJ+Ly6rhHdsNXSHYb9LCQPvM7xrj1JU
    yTz9rcUGtVI/IdKzYDJNqz6aFn0okbebCGzBlvX/fvVPrDXZ+t1KqT1nH0vXhfN9
    5hy+3PHmj/9jZKPpr9WKZM6mjZCkHoOOUgU8wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520116145; bh=E0YHtP5QEzdD2XgPJr8EgB3+iS5qp1mILKAo+x
    t7bNs=; b=mVBHAVVEvzOYyJ2MXYQQqSXh7vFfksJQ081t1fdyurotBRO8tEtQZl
    102S0fvC9guxUCabTQraydnjvhm2OUQd07byR4G5qMTJjsqSbbMGROZ0DeEkfdFW
    gypg1MypyjSZszL4pBbwNFBK0TQ6eJPjoXI2BwTF48PfV+ZIT1QZ/ObRJ53qTp2W
    RWEttfYq60u7ByXzhPDqRiJF84Qf6xlIR+f6+vAdaTqTe+KVX6yXmHWoLxd3S0xc
    h4XJi4iKhc3zf/17eIO/48mj8M1usfgHXtKhz8LcDaaomKPJDMKGZY0CwuqM1JY+
    panEczcJRZE91sFX5VrBPuCy+wSWhxtA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dQXdOGc5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dQXdOGc5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933074AbeCCW2H (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:07 -0500
Received: from mail-co1nam03on0110.outbound.protection.outlook.com ([104.47.40.110]:19475
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932963AbeCCW2A (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        Rob Clark <robdclark@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 02/84] dma-buf/fence: Fix lock inversion
 within dma-fence-array
Thread-Topic: [PATCH AUTOSEL for 4.14 02/84] dma-buf/fence: Fix lock inversion
 within dma-fence-array
Thread-Index: AQHTsz6byeMiYUTYvUm3yeSbnINLxQ==
Date: Sat, 3 Mar 2018 22:26:01 +0000
Message-ID: <20180303222518.26271-2-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:QaCsx/s1Z8Ht2rpng5LZjXqE5Yc9y7jqZeK0QXzDvKCxdOs5kyhEg3m9QRcZE7q+J2nIYlN4JtJXVsltu1CJYXrTATo+gYVOIKPwzzDgM7+U2Abu2WEXknS65w/O1E1YfSC20wICCEMFOBR1rQ3eZ0Fi5S6BJQaquiFYKEl0zpCtFHwYRdt7v8J7t8qEiGq0NrBgQhknhEI/Su3P076mMK6HbPOyzSUrU0lWHx2oVsOl5HbRJFWxQV5HlBdILD6k
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e00a65f1-0de7-4136-d3bb-08d5815603ce
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1067EA197E547494831E105DFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(966005)(54906003)(6306002)(36756003)(6486002)(8666007)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(39060400002)(6506007)(5660300001)(102836004)(575784001)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(325944009)(2900100001)(3280700002)(8676002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: IEu4e09Tw2OoSLa9d9lBWmQPBspaSCVEus5bHMiollGO1gmsBf1nO4cg6ZsjPTMmTXGqoVsIJc1E2GlUo2d0sU4ClpUI/D1QDCTZeuO8k4jVLfd4JQ+rcz70RyytKdhFXPI5E9UrQok+5Fx5GmcoWTSBKl8dCfNIL7FkxyXxICg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FA12BFEEA46FC449A848C273DC85FAE@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00a65f1-0de7-4136-d3bb-08d5815603ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:01.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQ2hyaXMgV2lsc29uIDxjaHJpc0BjaHJpcy13aWxzb24uY28udWs+DQoNClsgVXBzdHJl
YW0gY29tbWl0IDAzZTRlMGE5ZTAyY2Y3MDNkYTMzMWZmNmNmZDU3ZDBiZTliZjU2OTIgXQ0KDQpB
Z2VzIGFnbyBSb2IgQ2xhcmsgbm90ZWQsDQoNCiJDdXJyZW50bHkgd2l0aCBmZW5jZS1hcnJheSwg
d2UgaGF2ZSBhIHBvdGVudGlhbCBkZWFkbG9jayBzaXR1YXRpb24uICBJZg0Kd2UgZmVuY2VfYWRk
X2NhbGxiYWNrKCkgb24gYW4gYXJyYXktZmVuY2UsIHRoZSBhcnJheS1mZW5jZSdzIGxvY2sgaXMN
CmFjcXVpcmVkIGZpcnN0LCBhbmQgaW4gaXQncyAtPmVuYWJsZV9zaWduYWxpbmcoKSBjYWxsYmFj
aywgaXQgd2lsbCBpbnN0YWxsDQpjYnMgb24gaXQncyBhcnJheS1tZW1iZXIgZmVuY2VzLCBzbyB0
aGUgYXJyYXktbWVtYmVyJ3MgbG9jayBpcyBhY3F1aXJlZA0Kc2Vjb25kLg0KDQpCdXQgaW4gdGhl
IHNpZ25hbCBwYXRoLCB0aGUgYXJyYXktbWVtYmVyJ3MgbG9jayBpcyBhY3F1aXJlZCBmaXJzdCwg
YW5kDQp0aGUgYXJyYXktZmVuY2UncyBsb2NrIGFjcXVpcmVkIHNlY29uZC4iDQoNClJvYiBwcm9w
b3NlZCBlaXRoZXIgZXh0ZW5zaXZlIGNoYW5nZXMgdG8gZG1hLWZlbmNlIHRvIHVubmVzdCB0aGUN
CmZlbmNlLWFycmF5IHNpZ25hbGluZywgb3IgdG8gZGVmZXIgdGhlIHNpZ25hbGluZyBvbnRvIGEg
d29ya3F1ZXVlLiBUaGlzDQppcyBhIG1vcmUgcmVmaW5lZCB2ZXJzaW9uIG9mIHRoZSBsYXRlciwg
dGhhdCBzaG91bGQga2VlcCB0aGUgbGF0ZW5jeQ0Kb2YgdGhlIGZlbmNlIHNpZ25hbGluZyB0byBh
IG1pbmltdW0gYnkgdXNpbmcgYW4gaXJxLXdvcmssIHdoaWNoIGlzDQpleGVjdXRlZCBhc2FwLg0K
DQpSZXBvcnRlZC1ieTogUm9iIENsYXJrIDxyb2JkY2xhcmtAZ21haWwuY29tPg0KU3VnZ2VzdGVk
LWJ5OiBSb2IgQ2xhcmsgPHJvYmRjbGFya0BnbWFpbC5jb20+DQpSZWZlcmVuY2VzOiAxNDc2NjM1
OTc1LTIxOTgxLTEtZ2l0LXNlbmQtZW1haWwtcm9iZGNsYXJrQGdtYWlsLmNvbQ0KU2lnbmVkLW9m
Zi1ieTogQ2hyaXMgV2lsc29uIDxjaHJpc0BjaHJpcy13aWxzb24uY28udWs+DQpDYzogUm9iIENs
YXJrIDxyb2JkY2xhcmtAZ21haWwuY29tPg0KQ2M6IEd1c3Rhdm8gUGFkb3ZhbiA8Z3VzdGF2by5w
YWRvdmFuQGNvbGxhYm9yYS5jby51az4NCkNjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBs
aW5hcm8ub3JnPg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4NClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3Jn
Pg0KTGluazogaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoL21zZ2lkLzIw
MTcxMTE0MTYyNzE5LjMwOTU4LTEtY2hyaXNAY2hyaXMtd2lsc29uLmNvLnVrDQpTaWduZWQtb2Zm
LWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmluQG1pY3Jvc29mdC5jb20+DQotLS0NCiBk
cml2ZXJzL2Jhc2UvS2NvbmZpZyAgICAgICAgICAgICAgfCAgMSArDQogZHJpdmVycy9kbWEtYnVm
L2RtYS1mZW5jZS1hcnJheS5jIHwgMTQgKysrKysrKysrKysrLS0NCiBpbmNsdWRlL2xpbnV4L2Rt
YS1mZW5jZS1hcnJheS5oICAgfCAgMyArKysNCiAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvS2NvbmZp
ZyBiL2RyaXZlcnMvYmFzZS9LY29uZmlnDQppbmRleCAyNDE1YWQ5ZjZkZDQuLjQ5ZmQ1MGZjY2Q0
OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYmFzZS9LY29uZmlnDQorKysgYi9kcml2ZXJzL2Jhc2Uv
S2NvbmZpZw0KQEAgLTI0OSw2ICsyNDksNyBAQCBjb25maWcgRE1BX1NIQVJFRF9CVUZGRVINCiAJ
Ym9vbA0KIAlkZWZhdWx0IG4NCiAJc2VsZWN0IEFOT05fSU5PREVTDQorCXNlbGVjdCBJUlFfV09S
Sw0KIAloZWxwDQogCSAgVGhpcyBvcHRpb24gZW5hYmxlcyB0aGUgZnJhbWV3b3JrIGZvciBidWZm
ZXItc2hhcmluZyBiZXR3ZWVuDQogCSAgbXVsdGlwbGUgZHJpdmVycy4gQSBidWZmZXIgaXMgYXNz
b2NpYXRlZCB3aXRoIGEgZmlsZSB1c2luZyBkcml2ZXINCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Rt
YS1idWYvZG1hLWZlbmNlLWFycmF5LmMgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLWFycmF5
LmMNCmluZGV4IDAzNTA4MjliYTYyZS4uZGQxZWRmYjI3YjYxIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9kbWEtYnVmL2RtYS1mZW5jZS1hcnJheS5jDQorKysgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWZl
bmNlLWFycmF5LmMNCkBAIC0zMSw2ICszMSwxNCBAQCBzdGF0aWMgY29uc3QgY2hhciAqZG1hX2Zl
bmNlX2FycmF5X2dldF90aW1lbGluZV9uYW1lKHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlKQ0KIAly
ZXR1cm4gInVuYm91bmQiOw0KIH0NCiANCitzdGF0aWMgdm9pZCBpcnFfZG1hX2ZlbmNlX2FycmF5
X3dvcmsoc3RydWN0IGlycV93b3JrICp3cmspDQorew0KKwlzdHJ1Y3QgZG1hX2ZlbmNlX2FycmF5
ICphcnJheSA9IGNvbnRhaW5lcl9vZih3cmssIHR5cGVvZigqYXJyYXkpLCB3b3JrKTsNCisNCisJ
ZG1hX2ZlbmNlX3NpZ25hbCgmYXJyYXktPmJhc2UpOw0KKwlkbWFfZmVuY2VfcHV0KCZhcnJheS0+
YmFzZSk7DQorfQ0KKw0KIHN0YXRpYyB2b2lkIGRtYV9mZW5jZV9hcnJheV9jYl9mdW5jKHN0cnVj
dCBkbWFfZmVuY2UgKmYsDQogCQkJCSAgICBzdHJ1Y3QgZG1hX2ZlbmNlX2NiICpjYikNCiB7DQpA
QCAtMzksOCArNDcsOSBAQCBzdGF0aWMgdm9pZCBkbWFfZmVuY2VfYXJyYXlfY2JfZnVuYyhzdHJ1
Y3QgZG1hX2ZlbmNlICpmLA0KIAlzdHJ1Y3QgZG1hX2ZlbmNlX2FycmF5ICphcnJheSA9IGFycmF5
X2NiLT5hcnJheTsNCiANCiAJaWYgKGF0b21pY19kZWNfYW5kX3Rlc3QoJmFycmF5LT5udW1fcGVu
ZGluZykpDQotCQlkbWFfZmVuY2Vfc2lnbmFsKCZhcnJheS0+YmFzZSk7DQotCWRtYV9mZW5jZV9w
dXQoJmFycmF5LT5iYXNlKTsNCisJCWlycV93b3JrX3F1ZXVlKCZhcnJheS0+d29yayk7DQorCWVs
c2UNCisJCWRtYV9mZW5jZV9wdXQoJmFycmF5LT5iYXNlKTsNCiB9DQogDQogc3RhdGljIGJvb2wg
ZG1hX2ZlbmNlX2FycmF5X2VuYWJsZV9zaWduYWxpbmcoc3RydWN0IGRtYV9mZW5jZSAqZmVuY2Up
DQpAQCAtMTM2LDYgKzE0NSw3IEBAIHN0cnVjdCBkbWFfZmVuY2VfYXJyYXkgKmRtYV9mZW5jZV9h
cnJheV9jcmVhdGUoaW50IG51bV9mZW5jZXMsDQogCXNwaW5fbG9ja19pbml0KCZhcnJheS0+bG9j
ayk7DQogCWRtYV9mZW5jZV9pbml0KCZhcnJheS0+YmFzZSwgJmRtYV9mZW5jZV9hcnJheV9vcHMs
ICZhcnJheS0+bG9jaywNCiAJCSAgICAgICBjb250ZXh0LCBzZXFubyk7DQorCWluaXRfaXJxX3dv
cmsoJmFycmF5LT53b3JrLCBpcnFfZG1hX2ZlbmNlX2FycmF5X3dvcmspOw0KIA0KIAlhcnJheS0+
bnVtX2ZlbmNlcyA9IG51bV9mZW5jZXM7DQogCWF0b21pY19zZXQoJmFycmF5LT5udW1fcGVuZGlu
Zywgc2lnbmFsX29uX2FueSA/IDEgOiBudW1fZmVuY2VzKTsNCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2RtYS1mZW5jZS1hcnJheS5oIGIvaW5jbHVkZS9saW51eC9kbWEtZmVuY2UtYXJyYXku
aA0KaW5kZXggMzMyYTU0MjAyNDNjLi5iYzg5NDBjYTI4MGQgMTAwNjQ0DQotLS0gYS9pbmNsdWRl
L2xpbnV4L2RtYS1mZW5jZS1hcnJheS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1mZW5jZS1h
cnJheS5oDQpAQCAtMjEsNiArMjEsNyBAQA0KICNkZWZpbmUgX19MSU5VWF9ETUFfRkVOQ0VfQVJS
QVlfSA0KIA0KICNpbmNsdWRlIDxsaW51eC9kbWEtZmVuY2UuaD4NCisjaW5jbHVkZSA8bGludXgv
aXJxX3dvcmsuaD4NCiANCiAvKioNCiAgKiBzdHJ1Y3QgZG1hX2ZlbmNlX2FycmF5X2NiIC0gY2Fs
bGJhY2sgaGVscGVyIGZvciBmZW5jZSBhcnJheQ0KQEAgLTQ3LDYgKzQ4LDggQEAgc3RydWN0IGRt
YV9mZW5jZV9hcnJheSB7DQogCXVuc2lnbmVkIG51bV9mZW5jZXM7DQogCWF0b21pY190IG51bV9w
ZW5kaW5nOw0KIAlzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2VzOw0KKw0KKwlzdHJ1Y3QgaXJxX3dv
cmsgd29yazsNCiB9Ow0KIA0KIGV4dGVybiBjb25zdCBzdHJ1Y3QgZG1hX2ZlbmNlX29wcyBkbWFf
ZmVuY2VfYXJyYXlfb3BzOw0KLS0gDQoyLjE0LjENCg==
