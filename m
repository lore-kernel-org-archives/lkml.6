Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124692-2-6438937214196704653
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
    t=1520124692; b=ZdL6kUrTJBh8LqdPR82JE5bVADAs/3tKZksQthth2ibW1qO
    8A6LB9JWhIwsmb8wXJh47+mLPAVYj0Rx+GiEuaF71OsDMJvb5TGUE3+xPh6roBd+
    Z1ThaouZxhUpEOM6kxHhKytbD7/njzwVrEnqU5amK11KPyRdY5vMeKh8DDT51ojI
    RRjYzJgr6UEGBy4lWm1XyxYcH1zW+EkNmDGaubMjPPtKNLhZqMycMBMP5UL5ErSF
    EvriVp0wcMDgyZL9bQmAlNjXh+1xKzxs6UfD6yqEs7339t3w6AYwqViWEoXiQVmK
    GXnsESz3kwKaYEXWUKJau8Z03QNpOEQf0QJsw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520124692; bh=E0YHtP5QEzdD2XgPJr8EgB3+iS5qp1mILKAo+x
    t7bNs=; b=BsIGzlMbW/Z/vE+K6nF5MJW0sdaH5AP263ijJlrOs7DvuPM42jCw9k
    c9qhBZ93+hOk5/gr3TlDnJtXeKvMDzPiEK9t9pkCuHPxEF4itt90EL2E2e0u9RW8
    1AzZ/AfVX7E6IYxjtiSKoChM/ksn/V+/kVbbIdTTtBzpFXdwiydeYLFJx3hzaW3i
    jti3JtOcfVuvTnOmo0yjqhf/QPVQz2TA4NQ4IusSW2IuMblYlQHR/kZxOJqG1wxh
    TITzxQHQUf/6/b50I+qNRsk2mliQ4hm+5o+wyzSB3g5l23AMVZVBFKhIXhu4uDOQ
    H4+FhTbxklF6g2B6qnqUdZM02uOV8yLg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lqV3Xhoo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lqV3Xhoo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932248AbeCDAvB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:51:01 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:60008
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752321AbeCCWYQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        Rob Clark <robdclark@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 004/102] dma-buf/fence: Fix lock inversion
 within dma-fence-array
Thread-Topic: [PATCH AUTOSEL for 4.15 004/102] dma-buf/fence: Fix lock
 inversion within dma-fence-array
Thread-Index: AQHTsz5aGlLy5DT1bkSDr2zv9m6Ptw==
Date: Sat, 3 Mar 2018 22:24:11 +0000
Message-ID: <20180303222318.26006-4-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;7:AVzTNUl1l32O16CBOV6fDGPl8wibXvJn1CLsTEAqiJF2hxis3ptYo1yWZ2EnYp9weYszlSflrV6ILlKTkQfICJ0aMB7AegUI1CJILUJIilmrHmD/X6898dUBylUC93igDcEzxsqJkyyKxy6x87DP/FlVSdfDzhU3Agx3mOu8CwcB3SkKHa+kciL9W1/vRHL9jLP59CyoaErMilaPV2PoUFExdxC8pkSigaVFnMjz1mpzOIv5xFGbhoT0ROMUA71A
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5dba8b21-bef2-46ec-c270-08d581557eb8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10368673DC6D938B5F8DA37CFBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(39060400002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(325944009)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(8666007)(6306002)(2501003)(966005)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(575784001)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: IQTp2uCFuUPxTpz1WYkmaphuHgSiEtocWY5GS2+sX5dsT5B5197916OBMWlznR3Fu1Ud9fzu5KyAv69Hoiv/SQrRlXvBhEYa/kpDShW/fKetzfPGwa3HgMi5vLV7yWIU/BnjGPRRLnFf9b2fHVT+4/KzCc+mZyYlc6YQZa42pIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F86BEEECA27AF54DA5B1C006087CDCC8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dba8b21-bef2-46ec-c270-08d581557eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:11.0877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
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
