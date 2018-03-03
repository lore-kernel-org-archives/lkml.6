Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118619-2-2953268924108863065
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
    t=1520118618; b=MoGBCoFuLLxVZFf5YkACi/KS13emDARsjLpGfPicFpzZieK
    j+QmIr+CIbyZ91CsbgpcIs1wBUUZ1T2OnS6LxElyIBh8J4S57Yw5enrT0imZzzU0
    Ky/i01pcH/7FT3M8YhsG6uHUlLJ9RWiDmmgJ4Yqg9AJZPD0QkpXv5gFFE6iCAnZN
    aEqzKbkT63Ng0u2vuPTlT6YrNvmrVK7EKRJdp8/smJ1d/ZecWCFrXIRh1KtVzHVr
    7FFbKUIHK57EpQTtKdeURjXfvs50xKJZYcTiLNRnQ25FBWWp3g0J0Ol50uj4RQAJ
    Rs6XphNEc9KnPbqwmEkLnSpCecZOnVmd39WiRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520118618; bh=4mln8M+qcWqcVoJrh4tDr5ZEN/FasW0sE7NEOd
    +ywwU=; b=Qa8bKJgmhdGpO53RTj05rICu9dW+7n9OGTABwEqcscodXx1GeEX6sJ
    oPzhP8QH8pOLZuRjy14pJN9N+h1ZQ6k0ljqtEI/hx24CypNkxdwjyG1/MW1F1c2C
    I1O69AlWUTLSxmvOZFttaHQswDMUbPLxE0086wN3vvlyZ7TCQiKU1cGVXnb9RoF0
    SHEHC49iLZfteSXohmbZlsAyHEgF2pME+2yduYQ90wyjL3ORLkHDim19V38K+rrk
    qU42rTxCDScWwPlIm/H9kAP6F/S2fAG2gT9SxGlP71iCeL/gt+CqzvSLTuun6loi
    ishzCWFBdXf3hFMZ08q98TBTB+hOKrDw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yb+FDHSQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yb+FDHSQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934397AbeCCXIm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:08:42 -0500
Received: from mail-co1nam03on0096.outbound.protection.outlook.com ([104.47.40.96]:45422
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935101AbeCCWj4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christopher James Halse Rogers
        <christopher.halse.rogers@canonical.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 064/115] drm/radeon: Fail fb creation from
 imported dma-bufs.
Thread-Topic: [PATCH AUTOSEL for 4.4 064/115] drm/radeon: Fail fb creation
 from imported dma-bufs.
Thread-Index: AQHTsz9dvIuxMIHXr0yT+3UoB87M4A==
Date: Sat, 3 Mar 2018 22:31:26 +0000
Message-ID: <20180303223010.27106-64-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:BWKtNYF3LxBZrDERn4kq4qStHoCfG1YQx1WPMB3Yy5aP1F9JlguE1q5RQjR92Jy8WBYDTYI7R60eg33Ot+y4uocnxIhr6O9+dC+HzFwor1erI5ursPtOTxfhCFa2sTlrQbT1xOQMo1OV4i7w8D+TYGu8r/tguc1KxObR/xUrGdVHruCH8dYtno8sW8V2kmkOJqqf7T1dWPyBktsXiWqnvbOJfmNsKIVAdAXOGH/xTyplvOL8wCCPo5BCWtTZ3aaz
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25ba2246-c423-40c8-3c43-08d58157aecc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB1113518CC04E3733B8F0C2ABFBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110)(217544274631240)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(8666007)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(5890100001)(2501003)(6436002)(76176011)(575784001)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(59450400001)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(6666003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: +7J9ZHrZfQsrY0AqeZilHcNnL0CN0mM9J0Dv88a+bBorSTeWnCmZHJK/9B410gVT82kPzNRqE9vgaWz8IcFykaLj4BeefMS0lh0uLkZsz5tQzIwWUmQwsJCQ6VRAohDfknPDqcVlhRH9Y6E0DzNC5Bw2z9ix3bPz+lW9OQsOqos=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <30340A02D6EB9F45B0EBC5C7E08AED0C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba2246-c423-40c8-3c43-08d58157aecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:26.0571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
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
aXNwbGF5LmMNCmluZGV4IDM2NDViMjIzYWEzNy4uNDQ2ZDk5MDYyMzA2IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMNCkBAIC0xMzc0LDYgKzEzNzQsMTIgQEAgcmFk
ZW9uX3VzZXJfZnJhbWVidWZmZXJfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsDQogCQly
ZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsNCiAJfQ0KIA0KKwkvKiBIYW5kbGUgaXMgaW1wb3J0ZWQg
ZG1hLWJ1Ziwgc28gY2Fubm90IGJlIG1pZ3JhdGVkIHRvIFZSQU0gZm9yIHNjYW5vdXQgKi8NCisJ
aWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgew0KKwkJRFJNX0RFQlVHX0tNUygiQ2Fubm90IGNyZWF0
ZSBmcmFtZWJ1ZmZlciBmcm9tIGltcG9ydGVkIGRtYV9idWZcbiIpOw0KKwkJcmV0dXJuIEVSUl9Q
VFIoLUVJTlZBTCk7DQorCX0NCisNCiAJcmFkZW9uX2ZiID0ga3phbGxvYyhzaXplb2YoKnJhZGVv
bl9mYiksIEdGUF9LRVJORUwpOw0KIAlpZiAocmFkZW9uX2ZiID09IE5VTEwpIHsNCiAJCWRybV9n
ZW1fb2JqZWN0X3VucmVmZXJlbmNlX3VubG9ja2VkKG9iaik7DQotLSANCjIuMTQuMQ0K
