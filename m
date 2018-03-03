Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119068-2-2823619548927344059
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
    t=1520119066; b=uDW/8EILr9uAJRTBoCPgpWYX0Yw/yJZWG2xveNR/R7kzne6
    /amIDpoR269eAirmrBNBLcQAdcsqWJsBGI3LnK4RwkTgyKmYga0fT+7eEaKxmphm
    ZmxhYIgB8BaUrBMPtEkFq8RMXO+cnjSIZjpHPnZ1j8q0wek4KOlD5HsZRi/4PUfs
    3UAnL9ax/SvGIx+1HbFHeo6KCnBKd07Nf3WSYfjRIpXbQODgHMoF/7U90tPSek6n
    FtqBDPlie+iLzO/jELKpqgsEksrn1m50Cm63bxfAX+QUBHI3NcJ8uv2/HNP//ysY
    wwN+wJJvzDctR9+6AwZ35uHwCh/UxBsqNvvpymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520119066; bh=9nfHnyvjrSYPjpec0P7R8899OIPSeynL0JtnxX
    bsw9k=; b=o+4Y+pIHFAp1R1fUVHypcTfY37peX2rTKmuYY0WX8jDgqKb2wq9Ot/
    NbqCWXfqgTJbzYdqYvv9ZKOzjelQUGA3IHFSrrwXK4boYS1USXjbDZzNu3PsFk5Q
    AXSUXmG6yH6h8w1pf0hynNgJleGHorgNKUFYRmapj07/AKUS1boHv73sdRFJf8UI
    arCgpQcZKuPbfAgden4fOaYi/u4fUqcI6AHiRAZCh9lNA+j2MgS+vj2PMsCRaNIX
    hu4uVA7xvLysi5RVZTJ1bMdsw3kqdUgId3j+RyHIFbggCXh2Ihkih29abvQXDJKI
    Qad3g/o3b4HtaX6NVDSh61MfH3hMn3YA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ajK0GiY3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ajK0GiY3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934867AbeCCWiK (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:10 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934858AbeCCWiI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chris Wilson <chris@chris-wilson.co.uk>,
        =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Airlie <airlied@redhat.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 016/115] drm: Defer disabling the vblank IRQ
 until the next interrupt (for instant-off)
Thread-Topic: [PATCH AUTOSEL for 4.4 016/115] drm: Defer disabling the vblank
 IRQ until the next interrupt (for instant-off)
Thread-Index: AQHTsz9MbZqGkTqQ1k+OVrmMo2pJEA==
Date: Sat, 3 Mar 2018 22:30:56 +0000
Message-ID: <20180303223010.27106-16-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:yg028af7o7xUnhG5010ocQFGJuUjVVcsr/uTbsUAHMV7T6en45yBn5JyjVZd+f/u7S5Sb6TASpo0FnQk7EGXJlquftP5UwWS7K1Ebc5ix0/gYSwcosmmSnkBQIC9fa05u/gWIByeNPPzd3Fm7LHXlw4f2HRzY3q385KaAa33dpR4hxw8JRSZmZj6QVNYtDuGl6IzcGoBuL03gy9jQs/na8ajz7elyZXmspFe3En66hxkjvX/OtKhwedUSOHvvHrt
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28df735d-87e5-43f4-f789-08d581576d76
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106799FE7F7463A43493A7F2FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(7416002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(39060400002)(76176011)(6116002)(25786009)(3846002)(102836004)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(6306002)(36756003)(6486002)(54906003)(966005)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ZRFAPFlvaT0tjP+tlV7hcUwZiZqVRHJ3nUavMe7qg3Pl81jhcPMPbCLwk3366m8iT8fD0JSKSnIfk5gvowqu9tq5YVleu6mDJaSrs0+a8z10vJ+5aeOKgXR/kfTY41XPsIpsuvkaL5xx/qTM1xV8G9TZgJzFtF2iKtqc2ija9Ew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EF99F55C405264C80B2FCD3A56F809B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28df735d-87e5-43f4-f789-08d581576d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:56.7134
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
YW0gY29tbWl0IDYwOGIyMDUwNjk0MTk2OWVhMzBkOGMwOGRjOWFlMDJiYjg3ZGJmN2QgXQ0KDQpP
biB2YmxhbmsgaW5zdGFudC1vZmYgc3lzdGVtcywgd2UgY2FuIGdldCBpbnRvIGEgc2l0dWF0aW9u
IHdoZXJlIHRoZSBjb3N0DQpvZiBlbmFibGluZyBhbmQgZGlzYWJsaW5nIHRoZSB2YmxhbmsgSVJR
IGFyb3VuZCBhIGRybVdhaXRWYmxhbmsgcXVlcnkNCmRvbWluYXRlcy4gQW5kIHdpdGggdGhlIGFk
dmVudCBvZiBldmVuIGRlZXBlciBoYXJkd2FyZSBzbGVlcCBzdGF0ZSwNCnRvdWNoaW5nIHJlZ2lz
dGVycyBiZWNvbWVzIGV2ZXIgbW9yZSBleHBlbnNpdmUuICBIb3dldmVyLCB3ZSBrbm93IHRoYXQg
aWYNCnRoZSB1c2VyIHdhbnRzIHRoZSBjdXJyZW50IHZibGFuayBjb3VudGVyLCB0aGV5IGFyZSBh
bHNvIHZlcnkgbGlrZWx5IHRvDQppbW1lZGlhdGVseSBxdWV1ZSBhIHZibGFuayB3YWl0IGFuZCBz
byB3ZSBjYW4ga2VlcCB0aGUgaW50ZXJydXB0IGFyb3VuZA0KYW5kIG9ubHkgdHVybiBpdCBvZmYg
aWYgd2UgaGF2ZSBubyBmdXJ0aGVyIHZibGFuayByZXF1ZXN0cyBxdWV1ZWQgd2l0aGluDQp0aGUg
aW50ZXJydXB0IGludGVydmFsLg0KDQpBZnRlciB2YmxhbmsgZXZlbnQgZGVsaXZlcnksIHRoaXMg
cGF0Y2ggYWRkcyBhIHNoYWRvdyBvZiBvbmUgdmJsYW5rIHdoZXJlDQp0aGUgaW50ZXJydXB0IGlz
IGtlcHQgYWxpdmUgZm9yIHRoZSB1c2VyIHRvIHF1ZXJ5IGFuZCBxdWV1ZSBhbm90aGVyIHZibGFu
aw0KZXZlbnQuIFNpbWlsYXJseSwgaWYgdGhlIHVzZXIgaXMgdXNpbmcgYmxvY2tpbmcgZHJtV2Fp
dFZibGFua3MsIHRoZQ0KaW50ZXJydXB0IHdpbGwgYmUgZGlzYWJsZWQgb24gdGhlIElSUSBmb2xs
b3dpbmcgdGhlIHdhaXQgY29tcGxldGlvbi4NCkhvd2V2ZXIsIGlmIHRoZSB1c2VyIGlzIHNpbXBs
eSBxdWVyeWluZyB0aGUgY3VycmVudCB2YmxhbmsgY291bnRlciBhbmQNCnRpbWVzdGFtcCwgdGhl
IGludGVycnVwdCB3aWxsIGJlIGRpc2FibGVkIGFmdGVyIGV2ZXJ5IElSUSBhbmQgdGhlIHVzZXIN
CndpbGwgZW5hYmxlZCBpdCBhZ2FpbiBvbiB0aGUgZmlyc3QgcXVlcnkgZm9sbG93aW5nIHRoZSBJ
UlEuDQoNCnYyOiBNYXJpbyBLbGVpbmVyIC0NCkFmdGVyIHRlc3RpbmcgdGhpcywgb25lIG1vcmUg
dGhpbmcgdGhhdCB3b3VsZCBtYWtlIHNlbnNlIGlzIHRvIG1vdmUNCnRoZSBkaXNhYmxlIGJsb2Nr
IGF0IHRoZSBlbmQgb2YgZHJtX2hhbmRsZV92YmxhbmsoKSBpbnN0ZWFkIG9mIGF0IHRoZQ0KdG9w
Lg0KDQpUdXJucyBvdXQgdGhhdCBpZiBoaWdoIHByZWNpc2lvbiB0aW1lc3RhbWluZyBpcyBkaXNh
YmxlZCBvciBkb2Vzbid0DQp3b3JrIGZvciBzb21lIHJlYXNvbiAoYXMgY2FuIGJlIHNpbXVsYXRl
ZCBieSBlY2hvIDAgPg0KL3N5cy9tb2R1bGUvZHJtL3BhcmFtZXRlcnMvdGltZXN0YW1wX3ByZWNp
c2lvbl91c2VjKSwgdGhlbiB3aXRoIHlvdXINCmRlbGF5ZWQgZGlzYWJsZSBjb2RlIGF0IGl0cyBj
dXJyZW50IHBsYWNlLCB0aGUgdmJsYW5rIGNvdW50ZXIgd29uJ3QNCmluY3JlbWVudCBhbnltb3Jl
IGF0IGFsbCBmb3IgaW5zdGFudCBxdWVyaWVzLCBpZS4gd2l0aCB5b3VyIG90aGVyDQoiaW5zdGFu
dCBxdWVyeSIgcGF0Y2hlcy4gQ2xpZW50cyB3aGljaCByZXBlYXRlZGx5IHF1ZXJ5IHRoZSBjb3Vu
dGVyDQphbmQgd2FpdCBmb3IgaXQgdG8gcHJvZ3Jlc3Mgd2lsbCBzaW1wbHkgaGFuZywgc3Bpbm5p
bmcgaW4gYW4gZW5kbGVzcw0KcXVlcnkgbG9vcC4gVGhlcmUncyB0aGF0IGNvbW1lbnQgaW4gdmJs
YW5rX2Rpc2FibGVfYW5kX3NhdmU6DQoNCiIqIFNraXAgdGhpcyBzdGVwIGlmIHRoZXJlIGlzbid0
IGFueSBoaWdoIHByZWNpc2lvbiB0aW1lc3RhbXANCiAqIGF2YWlsYWJsZS4gSW4gdGhhdCBjYXNl
IHdlIGNhbid0IGFjY291bnQgZm9yIHRoaXMgYW5kIGp1c3QNCiAqIGhvcGUgZm9yIHRoZSBiZXN0
Lg0KICovDQoNCldpdGggdGhlIGRpc2FibGUgaGFwcGVuaW5nIGFmdGVyIGxlYWRpbmcgZWRnZSBv
ZiB2YmxhbmsgKD09IGh3IGNvdW50ZXINCmluY3JlbWVudCBhbHJlYWR5IGhhcHBlbmVkKSBidXQg
YmVmb3JlIHRoZSB2YmxhbmsgY291bnRlci90aW1lc3RhbXANCmhhbmRsaW5nIGluIGRybV9oYW5k
bGVfdmJsYW5rLCB0aGF0IHN0ZXAgaXMgbmVlZGVkIHRvIGtlZXAgdGhlIGNvdW50ZXINCnByb2dy
ZXNzaW5nLCBzbyBza2lwcGluZyBpdCBpcyBiYWQuDQoNCk5vdyB3aXRob3V0IGhpZ2ggcHJlY2lz
aW9uIHRpbWVzdGFtcGluZyBzdXBwb3J0LCBhIGttcyBkcml2ZXIgbXVzdCBub3QNCnNldCBkZXYt
PnZibGFua19kaXNhYmxlX2ltbWVkaWF0ZSA9IHRydWUsIGFzIHRoaXMgd291bGQgY2F1c2UgcHJv
YmxlbXMNCmZvciBjbGllbnRzLCBzbyB0aGlzIHNob3VsZG4ndCBtYXR0ZXIsIGJ1dCBpdCB3b3Vs
ZCBiZSBnb29kIHRvIHN0aWxsDQptYWtlIHRoaXMgcm9idXN0IGFnYWluc3QgYSBmdXR1cmUga21z
IGRyaXZlciB3aGljaCBtaWdodCBoYXZlDQp1bnJlbGlhYmxlIGhpZ2ggcHJlY2lzaW9uIHRpbWVz
dGFtcGluZywgZS5nLiwgaGlnaCBwcmVjaXNpb24NCnRpbWVzdGFtcGluZyB0aGF0IGludGVybWl0
dGVudGx5IGRvZXNuJ3Qgd29yay4NCg0KdjM6IFBhdGNoIGJlZm9yZSBjb2ZmZWUgbmVlZHMgZXh0
cmEgY29mZmVlLg0KDQpUZXN0Y2FzZTogaWd0L2ttc192YmxhbmsNClNpZ25lZC1vZmYtYnk6IENo
cmlzIFdpbHNvbiA8Y2hyaXNAY2hyaXMtd2lsc29uLmNvLnVrPg0KQ2M6IFZpbGxlIFN5cmrDpGzD
pCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+DQpDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPg0KQ2M6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+DQpD
YzogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0K
Q2M6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+LA0KQ2M6IE1hcmlvIEtsZWluZXIg
PG1hcmlvLmtsZWluZXIuZGVAZ21haWwuY29tPg0KUmV2aWV3ZWQtYnk6IFZpbGxlIFN5cmrDpGzD
pCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwg
VmV0dGVyIDxkYW5pZWwudmV0dGVyQGZmd2xsLmNoPg0KTGluazogaHR0cDovL3BhdGNod29yay5m
cmVlZGVza3RvcC5vcmcvcGF0Y2gvbXNnaWQvMjAxNzAzMTUyMDQwMjcuMjAxNjAtMS1jaHJpc0Bj
aHJpcy13aWxzb24uY28udWsNClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIu
bGV2aW5AbWljcm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9kcm1faXJxLmMgfCAx
NCArKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9pcnEuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1faXJxLmMNCmluZGV4IDgwOTA5ODkxODViMi4uNGRkYmM0OTEyNWNk
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9pcnEuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2RybV9pcnEuYw0KQEAgLTEyNzEsOSArMTI3MSw5IEBAIHZvaWQgZHJtX3ZibGFua19w
dXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHBpcGUpDQogCWlmIChhdG9t
aWNfZGVjX2FuZF90ZXN0KCZ2YmxhbmstPnJlZmNvdW50KSkgew0KIAkJaWYgKGRybV92Ymxhbmtf
b2ZmZGVsYXkgPT0gMCkNCiAJCQlyZXR1cm47DQotCQllbHNlIGlmIChkZXYtPnZibGFua19kaXNh
YmxlX2ltbWVkaWF0ZSB8fCBkcm1fdmJsYW5rX29mZmRlbGF5IDwgMCkNCisJCWVsc2UgaWYgKGRy
bV92Ymxhbmtfb2ZmZGVsYXkgPCAwKQ0KIAkJCXZibGFua19kaXNhYmxlX2ZuKCh1bnNpZ25lZCBs
b25nKXZibGFuayk7DQotCQllbHNlDQorCQllbHNlIGlmICghZGV2LT52YmxhbmtfZGlzYWJsZV9p
bW1lZGlhdGUpDQogCQkJbW9kX3RpbWVyKCZ2YmxhbmstPmRpc2FibGVfdGltZXIsDQogCQkJCSAg
amlmZmllcyArICgoZHJtX3ZibGFua19vZmZkZWxheSAqIEhaKS8xMDAwKSk7DQogCX0NCkBAIC0x
OTAyLDYgKzE5MDIsMTYgQEAgYm9vbCBkcm1faGFuZGxlX3ZibGFuayhzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LCB1bnNpZ25lZCBpbnQgcGlwZSkNCiAJd2FrZV91cCgmdmJsYW5rLT5xdWV1ZSk7DQog
CWRybV9oYW5kbGVfdmJsYW5rX2V2ZW50cyhkZXYsIHBpcGUpOw0KIA0KKwkvKiBXaXRoIGluc3Rh
bnQtb2ZmLCB3ZSBkZWZlciBkaXNhYmxpbmcgdGhlIGludGVycnVwdCB1bnRpbCBhZnRlcg0KKwkg
KiB3ZSBmaW5pc2ggcHJvY2Vzc2luZyB0aGUgZm9sbG93aW5nIHZibGFuay4gVGhlIGRpc2FibGUg
aGFzIHRvDQorCSAqIGJlIGxhc3QgKGFmdGVyIGRybV9oYW5kbGVfdmJsYW5rX2V2ZW50cykgc28g
dGhhdCB0aGUgdGltZXN0YW1wDQorCSAqIGlzIGFsd2F5cyBhY2N1cmF0ZS4NCisJICovDQorCWlm
IChkZXYtPnZibGFua19kaXNhYmxlX2ltbWVkaWF0ZSAmJg0KKwkgICAgZHJtX3ZibGFua19vZmZk
ZWxheSA+IDAgJiYNCisJICAgICFhdG9taWNfcmVhZCgmdmJsYW5rLT5yZWZjb3VudCkpDQorCQl2
YmxhbmtfZGlzYWJsZV9mbigodW5zaWduZWQgbG9uZyl2YmxhbmspOw0KKw0KIAlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZkZXYtPmV2ZW50X2xvY2ssIGlycWZsYWdzKTsNCiANCiAJcmV0dXJuIHRy
dWU7DQotLSANCjIuMTQuMQ0K
