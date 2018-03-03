Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117797-2-12053005730988309963
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
    t=1520117796; b=dIi1iU0mKxHYHnrjSr1R7GYBBRJFTCtIZ925e7Hwl6X7P/R
    Z9ri7FG+nkIVIoJbegToPX5S9dyz9gPL8ljX8cYhBnCbIxlsen5v4xW6aC6G9HDy
    AKX69z8e4GmV/i8cQKDAJhxhAMERNt3aafucjx5k5lQ9RFapOWx5/xLOw7Nnnaqj
    aKZH/p1IXSo8lF6Cw+Th4RsxUW7WC8e712nwJG+z7EJGGgcN5zf3WtkzedPpQ1dK
    BPTYX2X2J8/l3KS3UidkPLkz4R1gCWt5XUj7hF9vFu5M3h1bWLgXIETp/p3b2NOD
    Hz2qXCpaa0zXQtLE8m9FNLJHYHeY+6/pnd9/fdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520117796; bh=KIKDeUYt2VLSUAf+aADN4JlwT73A2uCgRbWAYZ
    d9rww=; b=X1rm6xwThOPzhMl27CLxdGFeJw94wAyHUJ2qNzSmfLpaoTAbIT6e2V
    fRBbqzStADFwVECBbrA9PTybHlz4PeFEumnUbhzSjLErA+VyZfnQ+X88PbXQzKv7
    YwO5vme85jPXl2pQn+yAkTKV5HfJXuDpuh3X8Cim2Xc3fO0zccmEl7OQzW00merB
    M8ByxOr9ckQCdHUasc4OwMYSQgYF/QrZLPaLaXQty+zZxqbMJv2lf37K4FDrq/bG
    E00+lRNz04GtqAxtbBsvsHeNbSAOhqgdwNk9XGfZ9vRq+cJtVRE+jwaLM3FWuHbm
    BZPFKqmBWISzdpld889a97BFoHxZ7dUA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o+EY6CUe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o+EY6CUe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933734AbeCCWzu (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:55:50 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932652AbeCCWlA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:00 -0500
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
Subject: [PATCH AUTOSEL for 3.18 09/63] drm: Defer disabling the vblank IRQ
 until the next interrupt (for instant-off)
Thread-Topic: [PATCH AUTOSEL for 3.18 09/63] drm: Defer disabling the vblank
 IRQ until the next interrupt (for instant-off)
Thread-Index: AQHTsz+eKLsiTOmUsk6ECHtwjO6uUA==
Date: Sat, 3 Mar 2018 22:33:14 +0000
Message-ID: <20180303223228.27323-9-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:GCthlh77XMu7970ORnaFP/SA3gjh77TEeJgfK5zJuO1lFHmftU6Vbkq5PQk7PNtVXXtLkU4ni1VNKrfgmtR9nIcODz95huknpevxzLT2MatofQq85vYZgtM5QA6nYb39ft0keh89BrBa1KL8NJVeOdGDZRwSyQX8wWw8ixne684ksnlS23JASxDvviTE4nsTOO8at+tDfrG70e3UZL/Hf82gE4JvunBcfC+IwOK2CGBRn2yOw+PVXEcosnWQCz8F
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ee037f4-0653-493f-9dac-08d58157d57e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09404AD3CDF78EB56BEAC586FBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(39060400002)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(6306002)(4326008)(966005)(5250100002)(305945005)(2501003)(76176011)(7416002)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: feoDtJCRL/stvXL2H5bQc+Hh4Yj1nTif8JrjFbkuII5tjFTsp1Rqprbk3WQVLaJ/xOWDFVRw7ZKZPZfOe86bQ3IHvNgadc4sommjBJj0WK43hf2QJ/ryTGPgnv9gGVDlGTsUKIN2iLEarOl1nDTdH1NBjdDZ8rxhFAF2jZ0Cu+g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0396E8D6A686A44486A64D25DCB9D3AF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee037f4-0653-493f-9dac-08d58157d57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:14.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
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
aXZlcnMvZ3B1L2RybS9kcm1faXJxLmMNCmluZGV4IDdkNjRkMjI0ODZlOS4uNGEzYjEzZDg4M2Nj
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9pcnEuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL2RybV9pcnEuYw0KQEAgLTEwMzgsOSArMTAzOCw5IEBAIHZvaWQgZHJtX3ZibGFua19w
dXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgaW50IGNydGMpDQogCWlmIChhdG9taWNfZGVjX2Fu
ZF90ZXN0KCZ2YmxhbmstPnJlZmNvdW50KSkgew0KIAkJaWYgKGRybV92Ymxhbmtfb2ZmZGVsYXkg
PT0gMCkNCiAJCQlyZXR1cm47DQotCQllbHNlIGlmIChkZXYtPnZibGFua19kaXNhYmxlX2ltbWVk
aWF0ZSB8fCBkcm1fdmJsYW5rX29mZmRlbGF5IDwgMCkNCisJCWVsc2UgaWYgKGRybV92Ymxhbmtf
b2ZmZGVsYXkgPCAwKQ0KIAkJCXZibGFua19kaXNhYmxlX2ZuKCh1bnNpZ25lZCBsb25nKXZibGFu
ayk7DQotCQllbHNlDQorCQllbHNlIGlmICghZGV2LT52YmxhbmtfZGlzYWJsZV9pbW1lZGlhdGUp
DQogCQkJbW9kX3RpbWVyKCZ2YmxhbmstPmRpc2FibGVfdGltZXIsDQogCQkJCSAgamlmZmllcyAr
ICgoZHJtX3ZibGFua19vZmZkZWxheSAqIEhaKS8xMDAwKSk7DQogCX0NCkBAIC0xNjY0LDYgKzE2
NjQsMTYgQEAgYm9vbCBkcm1faGFuZGxlX3ZibGFuayhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBp
bnQgY3J0YykNCiAJd2FrZV91cCgmdmJsYW5rLT5xdWV1ZSk7DQogCWRybV9oYW5kbGVfdmJsYW5r
X2V2ZW50cyhkZXYsIGNydGMpOw0KIA0KKwkvKiBXaXRoIGluc3RhbnQtb2ZmLCB3ZSBkZWZlciBk
aXNhYmxpbmcgdGhlIGludGVycnVwdCB1bnRpbCBhZnRlcg0KKwkgKiB3ZSBmaW5pc2ggcHJvY2Vz
c2luZyB0aGUgZm9sbG93aW5nIHZibGFuay4gVGhlIGRpc2FibGUgaGFzIHRvDQorCSAqIGJlIGxh
c3QgKGFmdGVyIGRybV9oYW5kbGVfdmJsYW5rX2V2ZW50cykgc28gdGhhdCB0aGUgdGltZXN0YW1w
DQorCSAqIGlzIGFsd2F5cyBhY2N1cmF0ZS4NCisJICovDQorCWlmIChkZXYtPnZibGFua19kaXNh
YmxlX2ltbWVkaWF0ZSAmJg0KKwkgICAgZHJtX3ZibGFua19vZmZkZWxheSA+IDAgJiYNCisJICAg
ICFhdG9taWNfcmVhZCgmdmJsYW5rLT5yZWZjb3VudCkpDQorCQl2YmxhbmtfZGlzYWJsZV9mbigo
dW5zaWduZWQgbG9uZyl2YmxhbmspOw0KKw0KIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYt
PmV2ZW50X2xvY2ssIGlycWZsYWdzKTsNCiANCiAJcmV0dXJuIHRydWU7DQotLSANCjIuMTQuMQ0K
