Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121725-2-12828928439353658598
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
    t=1520121724; b=qjRVgAzT7SmmPAFHyA9W09wOyoErW8Dr1mrEg7w9qgA205g
    QvmhlxWL953GliLGf84xWwLchR6niTWHdj6QaY926qIxDA7ozwG22Y9OgLK40LFs
    fTDHWGB9Xa/IFLoxJxCNy79NxLWDTSCxBS0MeHOfma0PJ3TmHCIVL9+CQzFku9Tb
    Ex2sGr/6iImAjZpZpoKKl4tLgdn3E9QaAQvYr2qUf7MnmfgB/7wJDg5ky4xWKFyd
    0K9DzmkPjLa/TfP6NF6UZ6FBiGKBYZ6M8+P1m0D4art0yDa6lzYLJ/XC91DhI1nv
    EMUkBVH/nWBjLDXomdc9lYaaz3A2B1Je+TjYs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520121724; bh=sxoK8VNHMOZIV6+yC2xfHgPPFAWY/1pXL4ogwO
    6p8Tc=; b=ITRO7gf/EZAmC6/nWgzKH5Uha+xEIrH8w4HtMJrMdpHkIGZLaXOpj7
    OFwo797tvEWfWRAZGBldBHEo/FM44Hec3hQ20d4F3cdHJ2bnzVDEhCWqPWKS4Hqh
    hZX6/+EuCk5vXRv4ivtynbvrSLKAgklZLmXgIwM+vyfDoYn7LDaeLRnSaHsZ5WWB
    enVC02tvEqItJi8OSv7VkANaaglcQx6S7LV0Fx5Biq9Nem/qOrRrXUTRCFSGhZLz
    6xoS5CVppexRC2QLG8kf/dzeT1ZOygK/DT47VGGtvQ3ACkN/1OS1pR2OdNqE3Yjz
    d52OEBNCYY1Kg/pVIrMsFrAroLpRXI8A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QQCaFus9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QQCaFus9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933383AbeCCWcB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:01 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933465AbeCCWb7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:59 -0500
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
Subject: [PATCH AUTOSEL for 4.9 034/219] drm: Defer disabling the vblank IRQ
 until the next interrupt (for instant-off)
Thread-Topic: [PATCH AUTOSEL for 4.9 034/219] drm: Defer disabling the vblank
 IRQ until the next interrupt (for instant-off)
Thread-Index: AQHTsz7sTI7mQCoi9EaVlptfKwqLYA==
Date: Sat, 3 Mar 2018 22:28:15 +0000
Message-ID: <20180303222716.26640-34-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:fluShBS+w6SFJHB+cH6Plf7Nru9vBz6yUd8kBWRmW7QZTYtWw3q3DWznFnQuJLveoE30nLw29SLA7FnCd5W/IrWIketoz3ZUnsoKa3db2sXFokESNS1b3yfVkNJYo0RtbzVzxmbn8xEa+lRV/XrGex2iQEZOw/jj6fmqYtk+RFxwTF8FUq45WgP8BnBuXJZol6l4OEUGVGNg6KdIOrUefjEWW/ZLn9KmtI3N3QgUJUOmrVvrdWIV/0XZoMZkjTyv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80ad37b0-a1e8-4ca0-4b57-08d5815692e3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1083043F0585BA3FED51785EFBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(39060400002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6306002)(6486002)(7416002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(966005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: yATa2YwGFuUuUX6V/1X2iTupRnTTZ2TcTqE9yz7Z3k4/ASRO3ZsijPl6qc3sj/cU1pfDKWc19DAdI8gRpzRORZUA6KjmqCjiKG7QRxQ9dH+WaVjkZRL4qmVizC0m5fkNkzeXP/pXNCCOxKufuaYW16if+iSNq4c4vWXxaQA3Yf8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FDCF6833FCD2545ABA7A53D05B61029@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ad37b0-a1e8-4ca0-4b57-08d5815692e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:15.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
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
aXZlcnMvZ3B1L2RybS9kcm1faXJxLmMNCmluZGV4IDQ4YTYxNjdmNWU3Yi4uMDBjODE1YTdjNDE0
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9pcnEuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2RybV9pcnEuYw0KQEAgLTEyMDIsOSArMTIwMiw5IEBAIHN0YXRpYyB2b2lkIGRybV92
YmxhbmtfcHV0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBwaXBlKQ0KIAlp
ZiAoYXRvbWljX2RlY19hbmRfdGVzdCgmdmJsYW5rLT5yZWZjb3VudCkpIHsNCiAJCWlmIChkcm1f
dmJsYW5rX29mZmRlbGF5ID09IDApDQogCQkJcmV0dXJuOw0KLQkJZWxzZSBpZiAoZGV2LT52Ymxh
bmtfZGlzYWJsZV9pbW1lZGlhdGUgfHwgZHJtX3ZibGFua19vZmZkZWxheSA8IDApDQorCQllbHNl
IGlmIChkcm1fdmJsYW5rX29mZmRlbGF5IDwgMCkNCiAJCQl2YmxhbmtfZGlzYWJsZV9mbigodW5z
aWduZWQgbG9uZyl2YmxhbmspOw0KLQkJZWxzZQ0KKwkJZWxzZSBpZiAoIWRldi0+dmJsYW5rX2Rp
c2FibGVfaW1tZWRpYXRlKQ0KIAkJCW1vZF90aW1lcigmdmJsYW5rLT5kaXNhYmxlX3RpbWVyLA0K
IAkJCQkgIGppZmZpZXMgKyAoKGRybV92Ymxhbmtfb2ZmZGVsYXkgKiBIWikvMTAwMCkpOw0KIAl9
DQpAQCAtMTgxOSw2ICsxODE5LDE2IEBAIGJvb2wgZHJtX2hhbmRsZV92Ymxhbmsoc3RydWN0IGRy
bV9kZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHBpcGUpDQogCXdha2VfdXAoJnZibGFuay0+cXVl
dWUpOw0KIAlkcm1faGFuZGxlX3ZibGFua19ldmVudHMoZGV2LCBwaXBlKTsNCiANCisJLyogV2l0
aCBpbnN0YW50LW9mZiwgd2UgZGVmZXIgZGlzYWJsaW5nIHRoZSBpbnRlcnJ1cHQgdW50aWwgYWZ0
ZXINCisJICogd2UgZmluaXNoIHByb2Nlc3NpbmcgdGhlIGZvbGxvd2luZyB2YmxhbmsuIFRoZSBk
aXNhYmxlIGhhcyB0bw0KKwkgKiBiZSBsYXN0IChhZnRlciBkcm1faGFuZGxlX3ZibGFua19ldmVu
dHMpIHNvIHRoYXQgdGhlIHRpbWVzdGFtcA0KKwkgKiBpcyBhbHdheXMgYWNjdXJhdGUuDQorCSAq
Lw0KKwlpZiAoZGV2LT52YmxhbmtfZGlzYWJsZV9pbW1lZGlhdGUgJiYNCisJICAgIGRybV92Ymxh
bmtfb2ZmZGVsYXkgPiAwICYmDQorCSAgICAhYXRvbWljX3JlYWQoJnZibGFuay0+cmVmY291bnQp
KQ0KKwkJdmJsYW5rX2Rpc2FibGVfZm4oKHVuc2lnbmVkIGxvbmcpdmJsYW5rKTsNCisNCiAJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5ldmVudF9sb2NrLCBpcnFmbGFncyk7DQogDQogCXJl
dHVybiB0cnVlOw0KLS0gDQoyLjE0LjENCg==
