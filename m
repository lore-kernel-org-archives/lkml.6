Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681346-2-11400662847158508772
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681345; b=ODyYhaKznePBU4ZL4gCzt9D8FQ+Di6yVLqKk+yQgj9FI4y3
    GNymkb7zrUuc9Um8Ft0rXHQ8NPHN+YDTW6S8E0DRxMI5YX6qBFLnC7CyfTJlaqIm
    hTq1SlChO0uw3/dO3yu7vuTV9z2eks8wZWgR0dR/zKKL4f60h289XZkIeQjCCFPk
    xhX7g41ROzJT81t8UXMR3c+a3jcQPXyfFVrxKaHdSIEjGDxPlLbMZWh5Ob8o1swW
    juhGr7glbXYO3hoNFFBM7nA7KxVaZ5DygG9Wc/HgbS1fQu//iItWXHC40m96ISaa
    BOrYE/dOCGio86GFdTQJ5Q2D90oEQYYV2oWt6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1517681345; bh=EbZXzwB2Rpn7hdPJUwDAQ/Ys8xk7KTyozdvMnH
    hmQgs=; b=xDj0xk2GxTVi43n1NYjKIL4mfyRRpvCRDAmwOqIEAEOfMwsmgdfCve
    ikwwokq7cB0uzRhENNYMaeJjcXTG7saoiVp5As51Jdq1pFX4gXAS0IQbBakGtQ8z
    azMvxodK8Q5r1AudzSxSumLxSJefCnltIS0u73xLrvoAacgiNe1PaVAaRItBuogJ
    QHPBCFhyXlTURabJEOUOQyRwihwp4SeqDess2AJ9Oz8zkooEdZLDXqe6l4jhEGJH
    l1GLe4kU7LdX72l7euAJONw6tMVYmyC8x/ti1qMiVMc9RlventHB947Ufkv6w5d3
    VPbvFwAW1Wml2MNy1PijMS9B1wbsY9zQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H7WE+qVd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=H7WE+qVd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeBCSIz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:55 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:45338
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753580AbeBCSH3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xiongwei Song <sxwjean@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 16/24] drm/ttm: check the return value of
 kzalloc
Thread-Topic: [PATCH AUTOSEL for 3.18 16/24] drm/ttm: check the return value
 of kzalloc
Thread-Index: AQHTnRmFYZTN3X2veUqpFGheAUV9IQ==
Date: Sat, 3 Feb 2018 18:05:06 +0000
Message-ID: <20180203180444.10801-16-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:UalKQ8gF+3Lm2c+n5zwQf03iFjLo1TnRUxlbQ83Xeho+m2kkLd//4fPvGHEX6xas/K9CeOJIlnOS26nnikHQA2CC6bGoS25oCoJTlzb5+5lLPPrbENOMA2jNdmVRDxv9pj1S532lXuftQGabqcuj09z+FVhQkjJ9vV9bywfpVSL5zf/+eYGt+6EGqbp6AP9JlhqLKT1I5KBEWa6tR/GiXFvJC78ay0MTvJ8rdpMowtt2w1wSPA9F5ZndK/p5cABf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52d49add-c53c-4587-e801-08d56b30e1d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993EE88C3DD03A69BBFA6E7FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(767451399110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(8666007)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: eYdi9BqbSeQqEu4N7nT6ABVOYtuG2DAw0M/SwK4fpqVQkp6IJu9hW/4iMnjghfQn5xULZmaJhB6DFur18TsDFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6BFAE783AFFB345B292637071A5CDAC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d49add-c53c-4587-e801-08d56b30e1d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:06.9558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogWGlvbmd3ZWkgU29uZyA8c3h3amVhbkBnbWFpbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IDE5ZDg1OWE3MjA1YmM1OWZmYzM4MzAzZWIyNWFlMzk0ZjYxZDIxZGMgXQ0KDQpJbiB0aGUg
ZnVuY3Rpb24gdHRtX3BhZ2VfYWxsb2NfaW5pdCwga3phbGxvYyBjYWxsIGlzIG1hZGUgZm9yIHZh
cmlhYmxlDQpfbWFuYWdlciwgd2UgbmVlZCB0byBjaGVjayBpdHMgcmV0dXJuIHZhbHVlLCBpdCBt
YXkgcmV0dXJuIE5VTEwuDQoNClNpZ25lZC1vZmYtYnk6IFhpb25nd2VpIFNvbmcgPHN4d2plYW5A
Z21haWwuY29tPg0KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5A
bWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2Mu
YyB8IDIgKysNCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9wYWdlX2FsbG9jLmMNCmluZGV4IDVkOGRmZTAyN2IzMC4uNzVkNTFlYzk4ZTA2IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMNCkBAIC04MTgsNiArODE4LDggQEAg
aW50IHR0bV9wYWdlX2FsbG9jX2luaXQoc3RydWN0IHR0bV9tZW1fZ2xvYmFsICpnbG9iLCB1bnNp
Z25lZCBtYXhfcGFnZXMpDQogCXByX2luZm8oIkluaXRpYWxpemluZyBwb29sIGFsbG9jYXRvclxu
Iik7DQogDQogCV9tYW5hZ2VyID0ga3phbGxvYyhzaXplb2YoKl9tYW5hZ2VyKSwgR0ZQX0tFUk5F
TCk7DQorCWlmICghX21hbmFnZXIpDQorCQlyZXR1cm4gLUVOT01FTTsNCiANCiAJdHRtX3BhZ2Vf
cG9vbF9pbml0X2xvY2tlZCgmX21hbmFnZXItPndjX3Bvb2wsIEdGUF9ISUdIVVNFUiwgIndjIik7
DQogDQotLSANCjIuMTEuMA0K
