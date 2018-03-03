Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117338-2-142122675084303052
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117337; b=O9MrcyZ9XLx5c2VkT3sHG3J440WlP2jbGR5jAz5pTFqsMRJ
    tXbU3OLkvasjg2I1cKTDPJSh08JuJTFp3/S+Fx9D6hSryUlxh7IB6SI+AOnmMifw
    mCPcboqEwG6eSJN+dPe51VI+CIt2lCcNL2ubPyDq+RSbE42cXMu2UPDHxy1nQllo
    4d7QrQPJ38cRjw5I2YM0+EutmGw03Uc2+zZTsUxv1V0wcgYtCjBNO8YtDtf3IwLj
    e9Jn7NHvt3jYVgdhzXPCalXlKEhAnC1NBQjD3Jh5M+5EZq1qcgPHWvRi2c3gpp7V
    9jhJVDTCqzER1zHa1XmRllCrbWzux+2QM9v25FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520117337; bh=4p3ZVkj1sJCOhzXYPRbWjBctFlP81sT/8u6SSu
    TJR/E=; b=a4hCrygMkbV1jPi7iKC/8jfvsd7KPoeO/vrtzzrjs6rIhoRb48VACb
    pOhPAk3dHFc8pyp1I7zbtC7aicNG/X0960tad5TqG5Tru4CRHc5ssJbD5VBBKgtn
    Q8K5dVXlu9G8as/DDCzU1cH+FkMXpq9F60L898kSr1Cyny/0X3Oz7gVDJ8kJGQ6a
    GK3gU9tFxC0xprTmZ1k/lKtryfNFQzexF9vt5WKisgjBN+ZDmX3bKdw/xH0/zQLN
    WOjEBFGNNIVo22a/ycaKUy5vTkTp/YmlvDaFAuYxFTkfeGfovA9eIdUXJwaaxmhR
    rBtTOSHta1l3A6+/Kl91LPIIqkEgpaJw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AaCDDeKm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AaCDDeKm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935277AbeCCWlu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:50 -0500
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:5824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935112AbeCCWlq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christopher James Halse Rogers
        <christopher.halse.rogers@canonical.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 36/63] drm/radeon: Fail fb creation from
 imported dma-bufs.
Thread-Topic: [PATCH AUTOSEL for 3.18 36/63] drm/radeon: Fail fb creation from
 imported dma-bufs.
Thread-Index: AQHTsz+oGN6nkdNpG0qMFQ0LwzgkQw==
Date: Sat, 3 Mar 2018 22:33:31 +0000
Message-ID: <20180303223228.27323-36-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:qd1oMxH6qJLaCUyhNoS4uOUH/N8COcKG3Ce2C6NZcbd081sKJc7lNX/tXSfoT24LTRvVtrhdb7dhS6IMoMGGx3ub7HvWCr2AYdcoYehu6fY7E7hUYiwdaUvC/tiHZgNjwr8nun88sg42NZQ0wGWuOQH2Flb3r0HG9I+hmdJsLi59/mxyysLhy7hQ8DCklSaqapyaIuyOLk6FBgIfEeDo9+DoCcLp/ZecWCf48E157HE/muTS+7jI9Alb9x9RlxuT
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f278da0c-7bf0-47d1-a47a-08d58157f0f5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB061B33AA7805231A7ECFC0FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110)(217544274631240)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(5890100001)(6506007)(26005)(2501003)(66066001)(8666007)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: SdcVCxkAB8U0rAt4QUhxZYGemEbMpikcxNYhkwe052dzjwoP4aGSoDH7IN2zh7rrZ9P3w3MAKPbCv51Hk1RWPARhjWyufB3aqDVcbH+uUMhGQ6GbXKtUH0D6NI9XrXrWUuyqWJpmcI6bphsLE4E+216Nuq4i2+vPCfiN7VLIw4U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4EE5B4D4E2BD24A91BB13773E405D10@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f278da0c-7bf0-47d1-a47a-08d58157f0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:31.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogQ2hyaXN0b3BoZXIgSmFtZXMgSGFsc2UgUm9nZXJzIDxjaHJpc3RvcGhlci5oYWxzZS5y
b2dlcnNAY2Fub25pY2FsLmNvbT4NCg0KWyBVcHN0cmVhbSBjb21taXQgYTI5NDA0M2IyZmJkOGRl
NjlkMTYxNDU3ZWQwYzdhNDAyNmJiZmE1YSBdDQoNCkFueSB1c2Ugb2YgdGhlIGZyYW1lYnVmZmVy
IHdpbGwgbWlncmF0ZSBpdCB0byBWUkFNLCB3aGljaCBpcyBub3Qgc2Vuc2libGUgZm9yDQphbiBp
bXBvcnRlZCBkbWEtYnVmLg0KDQp2MjogVXNlIERSTV9ERUJVR19LTVMgdG8gcHJldmVudCB1c2Vy
c3BhY2UgYWNjaWRlbnRhbGx5IHNwYW1taW5nIGRtZXNnLg0KDQpSZXZpZXdlZC1ieTogTWljaGVs
IETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+DQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0
b3BoZXIgSmFtZXMgSGFsc2UgUm9nZXJzIDxjaHJpc3RvcGhlci5oYWxzZS5yb2dlcnNAY2Fub25p
Y2FsLmNvbT4NCkNDOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KU2lnbmVkLW9mZi1i
eTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIHwgNiArKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
aXNwbGF5LmMNCmluZGV4IDIxZTZlOTc0NWQwMC4uMTkzOGRlNTgyNzE3IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMNCkBAIC0xMzIwLDYgKzEzMjAsMTIgQEAgcmFk
ZW9uX3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQogCQly
ZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCiAJfQ0KIA0KKwkvKiBIYW5kbGUgaXMgaW1wb3J0ZWQg
ZG1hLWJ1Ziwgc28gY2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0gZm9yIHNjYW5vdXQgKi8NCisJ
aWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgew0KKwkJRFJNX0RFQlVHX0tNUygiQ2Fubm90IGNyZWF0
ZSBmcmFtZWJ1ZmZlciBmcm9tIGltcG9ydGVkIGRtYV9idWZcbiIpOw0KKwkJcmV0dXJuIEVSUl9Q
VFIoLUVJTlZBTCk7DQorCX0NCisNCiAJcmFkZW9uX2ZiID0ga3phbGxvYyhzaXplb2YoKnJhZGVv
bl9mYiksIEdGUF9LRVJORUwpOw0KIAlpZiAocmFkZW9uX2ZiID09IE5VTEwpIHsNCiAJCWRybV9n
ZW1fb2JqZWN0X3VucmVmZXJlbmNlX3VubG9ja2VkKG9iaik7DQotLSANCjIuMTQuMQ0K
