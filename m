Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CC8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9338F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H9JnM4G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeL0PTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 10:19:44 -0500
Received: from mail-eopbgr70119.outbound.protection.outlook.com ([40.107.7.119]:49856
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbeL0PTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 10:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aslssUOCQGWR8pQa9aoXaiL9ct7fwtLn4BkD4E7y07I=;
 b=H9JnM4G9aEUXSN2z9v7C6D89FCqI1yMcpEiZnt8t2XpD+GDnd/9jc1Gjh5vZTlcjYMTLBx83nx3XTcWqG5iszaRcYqTd8A83wetdTzUdy35bLkRNX8Af4Y7EexlsLZbGmgbMoXHiPPSMIRSpAFGgViZYPa7+AxxFiS1Sv9WAgeY=
Received: from VI1PR08MB3117.eurprd08.prod.outlook.com (52.133.15.22) by
 VI1PR08MB3808.eurprd08.prod.outlook.com (20.178.14.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Thu, 27 Dec 2018 15:18:55 +0000
Received: from VI1PR08MB3117.eurprd08.prod.outlook.com
 ([fe80::40c5:8008:1ab4:4067]) by VI1PR08MB3117.eurprd08.prod.outlook.com
 ([fe80::40c5:8008:1ab4:4067%4]) with mapi id 15.20.1446.027; Thu, 27 Dec 2018
 15:18:55 +0000
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 0/1] mm: add a warning about high order allocations
Thread-Topic: [RFC PATCH 0/1] mm: add a warning about high order allocations
Thread-Index: AQHUnGgITKYxWm8xu020vQlGHxSq86WQsv2AgAIDJoA=
Date:   Thu, 27 Dec 2018 15:18:54 +0000
Message-ID: <e7660465-2e1e-b641-5730-448dee45b220@virtuozzo.com>
References: <20181225153927.2873-1-khorenko@virtuozzo.com>
 <20181226083505.GF16738@dhcp22.suse.cz>
In-Reply-To: <20181226083505.GF16738@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0045.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::31) To VI1PR08MB3117.eurprd08.prod.outlook.com
 (2603:10a6:803:46::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3808;20:yiX6PktSS0NBDR1/EHLvNckRkNdcXfxv1GrHMAhin2bugnYFRO7bD/OoeDInuvehRd7knS6p5xRQ9+8GOSP6FP178GKvuD4IMwJUG+QhaN9OYSXc+klOXwNbTb0xABcVfNx90TJ1iMgBZwGc+yS/Z6eA1/uFOZY6DNJk6/IwiIg=
x-ms-office365-filtering-correlation-id: 75cc7aa7-f0f1-41ea-877b-08d66c0e9d6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3808;
x-ms-traffictypediagnostic: VI1PR08MB3808:
x-microsoft-antispam-prvs: <VI1PR08MB380828E0B70749E63C14DB1FC8B60@VI1PR08MB3808.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3808;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3808;
x-forefront-prvs: 0899B47777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(376002)(136003)(396003)(366004)(189003)(199004)(14454004)(6486002)(3846002)(256004)(14444005)(217873002)(476003)(6436002)(305945005)(2616005)(54906003)(446003)(11346002)(7736002)(229853002)(36756003)(486006)(68736007)(8936002)(5660300001)(99286004)(97736004)(6512007)(53936002)(105586002)(81166006)(31686004)(102836004)(52116002)(386003)(6506007)(53546011)(6246003)(25786009)(186003)(8676002)(478600001)(76176011)(6916009)(6116002)(2906002)(106356001)(316002)(81156014)(4326008)(66066001)(86362001)(26005)(31696002)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3808;H:VI1PR08MB3117.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x4QzjQfpbU/9EUzxzmDBtdcljjZC6yaReoVyFAzhRQfNVm8tK1o9vLm+h/6hNJkeJPohfJrb1pNFj8+ZbgNAPUAMKzMEXeIbskaB4u8sPqOD7Eq9602P4reqh+GBWEnqsgV5LfvPTB4+XTwW5cFYtapkatvHTpVcwWkC+PSOwRQnQW12zMCEu4jv2mZ5aYFhzCS4F8Ed4b2OEdBBie9En9BlLIvKJuRWKvjnCzum04NpDh99U4Tai0pX+puYvKDf1HET1IP6Vhtdvp7TyaOWs2pwF3/sVzdWM5ZU47ftSVpcY0I/XBQCkx1k0uV4o+dV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E1226E736A32D4E8B6126627B7F2003@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cc7aa7-f0f1-41ea-877b-08d66c0e9d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2018 15:18:55.0356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFsLA0KDQp0aGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHF1ZXN0aW9ucywgcGxl
YXNlIHNlZSBteSBub3RlcyBiZWxvdy4NCg0KT24gMTIvMjYvMjAxOCAxMTozNSBBTSwgTWljaGFs
IEhvY2tvIHdyb3RlOg0KPiBPbiBUdWUgMjUtMTItMTggMTg6Mzk6MjYsIEtvbnN0YW50aW4gS2hv
cmVua28gd3JvdGU6DQo+PiBROiBXaHkgZG8gd2UgbmVlZCB0byBib3RoZXIgYXQgYWxsPw0KPj4g
QTogSWYgYSBub2RlIGlzIGhpZ2hseSBsb2FkZWQgYW5kIGl0cyBtZW1vcnkgaXMgc2lnbmlmaWNh
bnRseSBmcmFnbWVudGVkDQo+PiAodW5mb3J0dW5hdGVseSBhbG1vc3QgYW55IG5vZGUgd2l0aCBz
ZXJpb3VzIGxvYWQgaGFzIGhpZ2hseSBmcmFnbWVudGVkIG1lbW9yeSkNCj4+IHRoZW4gYW55IGhp
Z2ggb3JkZXIgbWVtb3J5IGFsbG9jYXRpb24gY2FuIHRyaWdnZXIgbWFzc2l2ZSBtZW1vcnkgc2hy
aW5rIGFuZA0KPj4gcmVzdWx0IGluIHF1aXRlIGEgYmlnIGFsbG9jYXRpb24gbGF0ZW5jeS4gQW5k
IHRoZSBub2RlIGJlY29tZXMgbGVzcyByZXNwb25zaXZlDQo+PiBhbmQgdXNlcnMgZG9uJ3QgbGlr
ZSBpdC4NCj4+IFRoZSB1bHRpbWF0ZSBzb2x1dGlvbiBoZXJlIGlzIHRvIGdldCByaWQgb2YgbGFy
Z2UgYWxsb2NhdGlvbnMsIGJ1dCB3ZSBuZWVkIGFuDQo+PiBpbnN0cnVtZW50IHRvIGRldGVjdCB0
aGVtLg0KPg0KPiBDYW4geW91IHBvaW50IHRvIGFuIGV4YW1wbGUgb2YgdGhlIHByb2JsZW0geW91
IGFyZSByZWZlcnJpbmcgaGVyZT8gQXQNCj4gbGVhc3QgZm9yIGNvc3RseSBvcmRlcnMgd2UgZG8g
YmFpbCBvdXQgZWFybHkgYW5kIHRyeSB0byBub3QgY2F1c2UNCj4gbWFzc2l2ZSByZWNsYWltLiBT
byB3aGF0IGlzIHRoZSBvcmRlciB0aGF0IHlvdSBhcmUgY29uY2VybmVkIGFib3V0Pw0KDQpXZWxs
LCB0aGlzIGlzIHRoZSBtb3N0IGRpZmZpY3VsdCBxdWVzdGlvbiB0byBhbnN3ZXIuDQpVbmZvcnR1
bmF0ZWx5IGkgZG9uJ3QgaGF2ZSBhIHJlcHJvZHVjZXIgZm9yIHRoYXQsIHVzdWFsbHkgd2UgZ2V0
IGludG8gc2l0dWF0aW9uDQp3aGVuIHNvbWVvbmUgZXhwZXJpZW5jZXMgc2lnbmlmaWNhbnQgbm9k
ZSBzbG93ZG93biwgbm9kZXMgbW9zdCBvZnRlbiBoYXZlIGEgbG90IG9mIFJBTSwNCndlIGNoZWNr
IHdoYXQgaXMgZ29pbmcgb24gdGhlcmUgYW5kIHNlZSB0aGUgbm9kZSBpcyBidXN5IHdpdGggcmVj
bGFpbS4NCkFuZCBhbG1vc3QgZXZlcnkgdGltZSB0aGUgcmVhc29uIHdhcyAtIGZyYWdtZW50ZWQg
bWVtb3J5IGFuZCBoaWdoIG9yZGVyIGFsbG9jYXRpb25zLg0KTW9zdGx5IG9mIDJuZCBhbmQgM3Jk
ICh3aGljaCBpcyBzdGlsbCBjb25zaWRlcmVkIG5vdCBjb3N0bHkpIG9yZGVyLg0KDQpSZWNlbnQg
cmVsYXRlZCBpc3N1ZXMgd2UgZmFjZWQgd2VyZSBhYm91dCBGVVNFIGRldiBwaXBlOg0KZDZkOTMx
YWRjZTExICgiZnVzZTogdXNlIGt2bWFsbG9jIHRvIGFsbG9jYXRlIGFycmF5IG9mIHBpcGVfYnVm
ZmVyIHN0cnVjdHMuIikNCg0KYW5kIGFib3V0IGJueCBkcml2ZXIgKyBtdHUgOTAwMCB3aGljaCBm
b3IgZWFjaCBwYWNrZXQgcmVxdWlyZWQgcGFnZSBvZiAybmQgb3JkZXINCihhbmQgaXQgZXZlbiBm
YWlsZWQgc29tZXRpbWVzLCB0aG91Z2ggaXQgd2FzIG5vdCB0aGUgcm9vdCBjYXVzZSk6DQogICAg
IGtzd2FwZDA6IHBhZ2UgYWxsb2NhdGlvbiBmYWlsdXJlOiBvcmRlcjoyLCBtb2RlOjB4NDAyMA0K
ICAgICBDYWxsIFRyYWNlOg0KICAgICAgICAgZHVtcF9zdGFjaysweDE5LzB4MWINCiAgICAgICAg
IHdhcm5fYWxsb2NfZmFpbGVkKzB4MTEwLzB4MTgwDQogICAgICAgICBfX2FsbG9jX3BhZ2VzX25v
ZGVtYXNrKzB4N2JmLzB4YzYwDQogICAgICAgICBhbGxvY19wYWdlc19jdXJyZW50KzB4OTgvMHgx
MTANCiAgICAgICAgIGttYWxsb2Nfb3JkZXIrMHgxOC8weDQwDQogICAgICAgICBrbWFsbG9jX29y
ZGVyX3RyYWNlKzB4MjYvMHhhMA0KICAgICAgICAgX19rbWFsbG9jKzB4Mjc5LzB4MjkwDQogICAg
ICAgICBibngyeF9mcmFnX2FsbG9jLmlzcmEuNjErMHgyYS8weDQwIFtibngyeF0NCiAgICAgICAg
IGJueDJ4X3J4X2ludCsweDIyNy8weDE3YzAgW2JueDJ4XQ0KICAgICAgICAgYm54MnhfcG9sbCsw
eDFkZC8weDI2MCBbYm54MnhdDQogICAgICAgICBuZXRfcnhfYWN0aW9uKzB4MTc5LzB4MzkwDQog
ICAgICAgICBfX2RvX3NvZnRpcnErMHgxMGYvMHgyYWENCiAgICAgICAgIGNhbGxfc29mdGlycSsw
eDFjLzB4MzANCiAgICAgICAgIGRvX3NvZnRpcnErMHg2NS8weGEwDQogICAgICAgICBpcnFfZXhp
dCsweDEwNS8weDExMA0KICAgICAgICAgZG9fSVJRKzB4NTYvMHhlMA0KICAgICAgICAgY29tbW9u
X2ludGVycnVwdCsweDZkLzB4NmQNCg0KQW5kIGFzIGJvdGggcGxhY2VzIHdlcmUgY2FsbGVkIHZl
cnkgb2Z0ZW4gLSB0aGUgc3lzdGVtIGxhdGVuY3kgd2FzIGhpZ2guDQoNClRoaXMgd2FybmluZyBj
YW4gYmUgYWxzbyB1c2VkIHRvIGNhdGNoIGFsbG9jYXRpb24gb2YgNHRoIG9yZGVyIGFuZCBoaWdo
ZXIgd2hpY2ggbWF5DQplYXNpbHkgZmFpbC4gVGhvc2UgcGxhY2VzIHdoaWNoIGFyZSByZWFkeSB0
byBnZXQgYWxsb2NhdGlvbiBlcnJvcnMgYW5kIGhhdmUNCmZhbGxiYWNrcyBhcmUgbWFya2VkIHdp
dGggX19HRlBfTk9XQVJOLg0KDQo+PiBROiBXaHkgd2FybmluZz8gVXNlIHRyYWNlcG9pbnRzIQ0K
Pj4gQTogV2VsbCwgdGhpcyBpcyBhIG1hdHRlciBvZiBtYWdpYyBkZWZhdWx0cy4NCj4+IFllcywg
eW91IGNhbiB1c2UgdHJhY2Vwb2ludHMgdG8gY2F0Y2ggbGFyZ2UgYWxsb2NhdGlvbnMsIGJ1dCB5
b3UgbmVlZCB0byBkbyB0aGlzDQo+PiBvbiBwdXJwb3NlIGFuZCByZWd1bGFybHkgYW5kIHRoaXMg
aXMgdG8gYmUgZG9uZSBieSBldmVyeSBkZXZlbG9wZXIgd2hpY2ggaXMNCj4+IHF1aXRlIHVucmVh
bC4NCj4+IE9uIHRoZSBvdGhlciBoYW5kIGlmIHlvdSBkZXZlbG9wIHNvbWV0aGluZyBhbmQgZ2V0
IGEgd2FybmluZywgeW91J2xsIGhhdmUgdG8NCj4+IHRoaW5rIGFib3V0IHRoZSByZWFzb24gYW5k
IGVpdGhlciBzdWNjZWVkIHdpdGggcmV3b3JraW5nIHRoZSBjb2RlIHRvIHVzZQ0KPj4gc21hbGxl
ciBhbGxvY2F0aW9uIHNpemVzIChhbmQgdGh1cyBkZWNyZWFzZSBhbGxvY2F0aW9uIGxhdGVuY3kh
KSBvciBqdXN0IHVzZQ0KPj4ga3ZtYWxsb2MoKSBpZiB5b3UgZG9uJ3QgcmVhbGx5IG5lZWQgcGh5
c2ljYWxseSBjb250aW51b3MgY2h1bmsgb3IgY29tZSB0byB0aGUNCj4+IGNvbmNsdXNpb24geW91
IGRlZmluaXRlbHkgbmVlZCBwaHlzaWNhbGx5IGNvbnRpbnVvcyBtZW1vcnkgYW5kIHNodXQgdXAg
dGhlDQo+PiB3YXJuaW5nLg0KPg0KPiBXZWxsLCBub3QgcmVhbGx5LiBGb3Igb25lIHRoaW5nLCB0
aGVyZSBhcmUgc3lzdGVtcyB0byBwYW5pYyBvbiB3YXJuaW5nDQo+IGFuZCB5b3UgcmVhbGx5IGRv
IG5vdCB3YW50IHRvIGJsb3cgdXAganVzdCBiZWNhdXNlIHNvbWVib2R5IGlzIGRvaW5nIGENCj4g
bGFyZ2Ugb3JkZXIgYWxsb2NhdGlvbi4NCg0KV2VsbCwgb24gb25lIGhhbmQgLSB5ZXMsIGkgYWdy
ZWUgd2l0aCB5b3UuIFRoYXQncyB3aHkgaSBkb24ndCBzdWdnZXN0IHRvIGVuYWJsZQ0KdGhlIHdh
cm5pbmcgYnkgZGVmYXVsdCByaWdodCBub3cgLSB1bnRpbCBhbGwgKG1vc3QpIG9mIGxhcmdlIGFs
bG9jYXRpb25zIGFyZSBtYXJrZWQNCnByb3Blcmx5Lg0KQnV0IGFmdGVyIGl0J3MgZG9uZSBhbmQg
dGhlcmUgYXJlIG5vIChhbG1vc3QpIHVubWFya2VkIGhpZ2ggb3JkZXIgYWxsb2NhdGlvbnMgLQ0K
d2h5IG5vdD8gVGhpcyB3aWxsIHJldmVhbCBuZXcgY2FzZXMgb2YgaGlnaCBvcmRlciBhbGxvY2F0
aW9ucyBzb29uLg0KaSB0aGluayBwZW9wbGUgd2hvIHJ1biBzeXN0ZW1zIHdpdGggImtlcm5lbC5w
YW5pY19vbl93YXJuIiBlbmFibGVkIGRvIGNhcmUNCmFib3V0IHJlcG9ydGluZyBpc3N1ZXMuDQoN
Cj4+IFE6IFdoeSBjb21waWxlIHRpbWUgY29uZmlnIG9wdGlvbj8NCj4+IEE6IEluIG9yZGVyIG5v
dCB0byBkZWNyZWFzZSB0aGUgcGVyZm9ybWFuY2UgZXZlbiBhIGJpdCBpbiBjYXNlIHNvbWVvbmUg
ZG9lcyBub3QNCj4+IHdhbnQgdG8gaHVudCBmb3IgbGFyZ2UgYWxsb2NhdGlvbnMuDQo+PiBJbiBh
biBpZGVhbCBsaWZlIGknZCBwcmVmZXIgdGhpcyBjaGVjay93YXJuaW5nIGlzIGVuYWJsZWQgYnkg
ZGVmYXVsdCBhbmQgbWF5IGJlDQo+PiBldmVuIHdpdGhvdXQgYSBjb25maWcgb3B0aW9uIHNvIGl0
IHdvcmtzIG9uIGV2ZXJ5IG5vZGUuIE9uY2Ugd2UgZmluZCBhbmQgcmV3b3JrDQo+PiBvciBtYXJr
IGFsbCBsYXJnZSBhbGxvY2F0aW9ucyB0aGF0IHdvdWxkIGJlIGdvb2QgYnkgZGVmYXVsdC4gVW50
aWwgdGhhdCB0aG91Z2gNCj4+IGl0IHdpbGwgYmUgbm9pc3kuDQo+DQo+IFNvIHdobyBpcyBnb2lu
ZyB0byBlbmFibGUgdGhpcyBvcHRpb24/DQoNCkF0IHRoZSBiZWdpbm5pbmcgLSBwZW9wbGUgd2hv
IHdhbnQgdG8gZGVidWcga2VybmVsIGFuZCB2ZXJpZnkgdGhlaXIgZmFsbGJhY2tzIG9uDQptZW1v
cnkgYWxsb2NhdGlvbnMgZmFpbHVyZXMgaW4gdGhlIGNvZGUgb3IganVzdCBzcGVlZCB1cCB0aGVp
ciBjb2RlIG9uIG5vZGVzDQp3aXRoIGZyYWdtZW50ZWQgbWVtb3J5IC0gZm9yIDJuZCBhbmQgM3Jk
IG9yZGVycy4NCg0KbW0gcGVyZm9ybWFuY2UgaXNzdWVzIGFyZSB0b3VnaCwgeW91IGtub3csIGFu
ZCB0aGlzIGlzIGp1c3QgYW5vdGhlciB3YXkgdG8NCmdhaW4gbW9yZSBwZXJmb3JtYW5jZS4gSXQg
d29uJ3QgYXZvaWQgdGhlIG5lY2Vzc2l0eSBvZiBkaWdnaW5nIG1tIGZvciBzdXJlLA0KYnV0IG1p
Z2h0IGRlY3JlYXNlIHRoZSBwcmVzc3VyZSBsZXZlbC4NCg0KTGF0ZXIgKGkgaG9wZSkgaSBjb3Vs
ZCBiZSBlbmFibGVkIGJ5IGRlZmF1bHQgc28gYWxsIGJpZyBuZXcgYWxsb2NhdGlvbnMNCmFyZSB2
ZXJpZmllZCBzb29uZXIgYW5kIGVpdGhlciByZXdvcmtlZCBvciBtYXJrZWQgd2l0aCBfX0dGUF9O
T1dBUk4gaWYgdGhlIGNvZGUgaXMNCnJlYWR5Lg0KDQotLQ0KQmVzdCByZWdhcmRzLA0KDQpLb25z
dGFudGluIEtob3JlbmtvLA0KVmlydHVvenpvIExpbnV4IEtlcm5lbCBUZWFtDQoNCj4+IEFub3Ro
ZXIgb3B0aW9uIGlzIHRvIHJld29yayB0aGUgcGF0Y2ggdmlhIHN0YXRpYyBrZXlzIChoYXZpbmcg
dGhlIHdhcm5pbmcNCj4+IGRpc2FibGVkIGJ5IGRlZmF1bHQgc3VyZWx5KS4gVGhhdCBtYWtlcyBp
dCBwb3NzaWJsZSB0byB0dXJuIG9uIHRoZSBmZWF0dXJlDQo+PiB3aXRob3V0IHJlY29tcGlsaW5n
IHRoZSBrZXJuZWwgLSBkdXJpbmcgdGVzdGluZyBwZXJpb2QgZm9yIGV4YW1wbGUuDQo+Pg0KPj4g
SWYgeW91IHByZWZlciB0aGlzIHdheSwgaSB3b3VsZCBiZSBoYXBweSB0byByZXdvcmsgdGhlIHBh
dGNoIHZpYSBzdGF0aWMga2V5cy4NCj4NCj4gSSB3b3VsZCByYXRoZXIgZ28gYW5kIGNoYXNlIHRo
ZSB1bmRlcmx5aW5nIGlzc3VlLiBTbyBjYW4gd2UgZ2V0IGFuDQo+IGFjdHVhbCBkYXRhIHBsZWFz
ZT8NCg==
