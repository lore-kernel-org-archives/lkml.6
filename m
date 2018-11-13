Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45E8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE9E223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE9E223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeKNFJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:09:22 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:26526 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:09:22 -0500
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id EA59D1FC94;
        Tue, 13 Nov 2018 19:09:33 +0000 (UTC)
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id D9C786D;
        Tue, 13 Nov 2018 19:09:32 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) by
 G1W8108.americas.hpqcorp.net (2002:10c1:483c::10c1:483c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 13 Nov 2018 19:09:27 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8454.americas.hpqcorp.net (16.216.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 13 Nov 2018 19:09:26 +0000
Received: from AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM (10.169.2.149) by
 AT5PR8401MB1186.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 13 Nov 2018 19:09:25 +0000
Received: from AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::495:9d8a:4bf:2ad4]) by AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::495:9d8a:4bf:2ad4%8]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 19:09:24 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Aristeu Rozanski Filho" <arozansk@redhat.com>,
        "Ernst, Justin" <justin.ernst@hpe.com>
Subject: RE: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Thread-Topic: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Thread-Index: AQHUWdgoCSh2YfNBoEKJ2ttajFOTeaULKTaAgADxVxCAAAsBAIA25YGAgAtH0CA=
Date:   Tue, 13 Nov 2018 19:09:24 +0000
Message-ID: <AT5PR8401MB0371BD98A030E08B1A1833A787C20@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
References: <20180926230257.GA5666@agluck-desk>
 <20180927045244.GA30912@zn.tnic> <20180927214400.GA2249@agluck-desk>
 <20180927220355.GF19687@zn.tnic> <20180927221054.580220e5@coco.lan>
 <20181001124754.GD7269@zn.tnic> <20181001224313.GA9487@agluck-desk>
 <20181001222257.45e4fd59@coco.lan>
 <AT5PR8401MB037188B39CB70EB18ADAC11987E80@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
 <20181002162608.GC29601@zn.tnic> <20181106144535.GI13712@zn.tnic>
In-Reply-To: <20181106144535.GI13712@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=justin.ernst@hpe.com; 
x-originating-ip: [15.203.227.12]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1186;6:K00D6OdytXUQPDL1UtMXKgCIjXCf01cGE0VDXfhuS8fb28DKusYn3zBhUqzmYBygsCTniCVBE7sH8UOJdrUs4y9pWhL2WJr1zRlcKKYhSttjGGUlYg7YWdMt1CAIkztm9ssNZEwrjNRLPSXMISpCK9nWaLRze5Y709Da6NzoIgln+ZrBhv6fSpSwtWVFrt2PxyvRWoNQrtKJnAscCmuRMkUnE28mWYj798I+4Btxq7ehWe2qxG+jTa0aAH3JpGscoDQOWZd0AYv1eebZ1GxaoZXlsszvqr3p03rvd6Cy4pUfPRCJyxBnghSEt6MNKKB4+OvvazkC8oqZCkHeW2/lKf9Aw4DoIVvfQ3Fk2nTDKKof4byDPo0yS1y8RLFeSJCyaYuCmdib+SGuphQqPubMacTqzzy4I6NEeA8yfmZ/ipVcNSuDwjizyQAyBfY8pITOULcCiXHvdmYEihbFIPFxjw==;5:hl3JpqZXvpqEolCxzsw/luVvhVblHidxRLXUoRXn49otO+pFE1OA8LBB8i4BoCjqumQ16JUOLgjv55u16jvhBmrxYr29aPn138HyQ/7ndxiIYRau5mqohPXoNlbgfxoHobgJDtMKMrOUFqUzxUIljuoweIXh6BMl4RJQKqTEZo4=;7:6FZWkkXr8iJusOdUQwn9unOhiPWCrh7LeSDFr+7qk2MTFJKuJxDB4DJWtGgDguC3uAkRI857khWZRMfIn9YCGjGGNH9JUxQIpIhjDeUJ3YgnWXmLHZbBxjCuYABzidvJB4s1e3/ChSJOz/rdQZIpzQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(13464003)(189003)(199004)(51444003)(8676002)(478600001)(81156014)(71200400001)(3846002)(5660300001)(66066001)(446003)(81166006)(8936002)(71190400001)(11346002)(2900100001)(486006)(476003)(7696005)(305945005)(26005)(97736004)(33656002)(76176011)(4326008)(6116002)(25786009)(74316002)(68736007)(966005)(99286004)(9686003)(55016002)(54906003)(110136005)(53936002)(6306002)(53546011)(6506007)(14454004)(6436002)(93886005)(102836004)(316002)(2906002)(105586002)(256004)(86362001)(6246003)(106356001)(229853002)(186003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1186;H:AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 2c019068-0e8a-4476-3688-08d6499b8694
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1186;
x-ms-traffictypediagnostic: AT5PR8401MB1186:
x-microsoft-antispam-prvs: <AT5PR8401MB11866F7D2C20F3A53219643987C20@AT5PR8401MB1186.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(9452136761055)(84791874153150)(222181515654134)(227479698468861)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231406)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AT5PR8401MB1186;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1186;
x-forefront-prvs: 085551F5A8
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pj7VcnHLk04aPdluCeqJN7bhPcu9W5iLtnoDC19mj/I/cuhSo9ZH0gd2kJDU2t0aSln8Hzga70OqboCvns682hnfcRXwLW0FobazvwMfShrZYurRQ/1OpKgXlIQEE1zZHZgMckgkLYwusvuTLivVWgT8jixzaw0WYtpatpcSOPXyzi7ykpA3EAhBPkkzYhtsQu3XPnaMKzXV8ymXwK2rVV2E7YNK5x4HJTU0SL8wc03vCStSPBEclptlFF2Lk/Re3lIcVBXaL5RIa/yoCTesrerRsLXosNWL8nmvk9pUWNsE6FrtcU4s0ey4n4Srl1yFxWdIZaRPzLgbyV7OQTQTwdYt5gbkZMi0kVTqnKY9RrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c019068-0e8a-4476-3688-08d6499b8694
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 19:09:24.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1186
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCBvbiBhIDMyIHNvY2tldCBzeXN0ZW0uIEFsbCA2NCBtZW1vcnkgY29udHJvbGxl
cnMgc2hvdyB1cCBhbmQgSSdtIGFibGUgdG8gc2VlIHRoZSBzYW1lIHN5c2ZzIGRpZmYuDQpUaGFu
a3MNCi1KdXN0aW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jp
c2xhdiBQZXRrb3YgW21haWx0bzpicEBhbGllbjguZGVdDQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVt
YmVyIDYsIDIwMTggODo0NiBBTQ0KPiBUbzogRXJuc3QsIEp1c3RpbiA8anVzdGluLmVybnN0QGhw
ZS5jb20+OyBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBDYzogR3JlZyBLSCA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBBbmRlcnNvbiwgUnVzcw0KPiA8cnVzcy5hbmRl
cnNvbkBocGUuY29tPjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IDxtY2hlaGFiQGtlcm5lbC5v
cmc+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEFyaXN0ZXUgUm96YW5za2kgRmlsaG8gPGFyb3phbnNrQHJlZGhhdC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEVEQUM6IERvbid0IGFkZCBkZXZpY2VzIHVuZGVyIC9zeXMv
YnVzL2VkYWMNCj4gDQo+IE9uIFR1ZSwgT2N0IDAyLCAyMDE4IGF0IDA2OjI2OjA4UE0gKzAyMDAs
IEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiBPbiBUdWUsIE9jdCAwMiwgMjAxOCBhdCAwMzo1
MTo0MVBNICswMDAwLCBFcm5zdCwgSnVzdGluIHdyb3RlOg0KPiA+ID4gVGhlIGNvbWJpbmVkIHBh
dGNoZXMgd29yayBvbiBhIDIwIHNvY2tldCBzeXN0ZW0uDQo+ID4gPiBUaGFua3MhDQo+ID4NCj4g
PiBDb29sLCB0aGFua3MgZm9yIHRlc3RpbmcuDQo+ID4NCj4gPiBOZXZlcnRoZWxlc3MsIEknbGwg
cXVldWUgdGhlbSBmb3IgNC4yMSBzbyB0aGF0IHdlIGhhdmUgYSBmdWxsIGN5Y2xlIG9mDQo+ID4g
dGVzdGluZyBiZWZvcmUgd2UgcmVhbGx5IGtpbGwgdGhlIGJ1cyB0aGluZy4NCj4gDQo+IE9rLCBJ
J3ZlIHB1c2hlZCB0aGUgdHdvIHBhdGNoZXMgb250b3Agb2YgRURBQydzIGZvci1uZXh0IGJyYW5j
aCwgaGVyZToNCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L2JwL2JwLmdpdC9sb2cvP2g9ZWRhYy1mb3ItDQo+IDQuMjEtYnVzDQo+IA0KPiBhbmQg
SSdkIGFwcHJlY2lhdGUgdGVzdGluZyB0aGVtIG9uZSBtb3JlIHRpbWUgb24gdGhlIGJpZyBib3hl
cyB5b3UgZ3V5cw0KPiBoYXZlLg0KPiANCj4gRGlmZmluZyBzeXNmcyBoZXJlIHNob3dzIHRoaXM6
DQo+IA0KPiAtLS0gZWRhYy5iZWZvcmUJMjAxOC0xMS0wNiAxMzozNzozNy45MjU0NDg2MDkgKzAx
MDANCj4gKysrIGVkYWMuYWZ0ZXIJMjAxOC0xMS0wNiAxNTozNjoxMS4yMjk0OTc3OTUgKzAxMDAN
Cj4gQEAgLTM3LDcgKzM3LDYgQEANCj4gIC9zeXMvZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzAv
ZGltbTMvcG93ZXIvY29udHJvbA0KPiAgL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21jL21jMC9k
aW1tMy9kaW1tX2Rldl90eXBlDQo+ICAvc3lzL2RldmljZXMvc3lzdGVtL2VkYWMvbWMvbWMwL2Rp
bW0zL3NpemUNCj4gLS9zeXMvZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzAvZGltbTMvc3Vic3lz
dGVtDQo+ICAvc3lzL2RldmljZXMvc3lzdGVtL2VkYWMvbWMvbWMwL2RpbW0zL2RpbW1fY2VfY291
bnQNCj4gIC9zeXMvZGV2aWNlcy9zeXN0ZW0vZWRhYy9tYy9tYzAvZGltbTMvZGltbV9sYWJlbA0K
PiAgL3N5cy9kZXZpY2VzL3N5c3RlbS9lZGFjL21jL21jMC9kaW1tMy9kaW1tX2xvY2F0aW9uDQo+
IA0KPiB3aGljaCBpcyB0aGUgYnVzIHN5bWxpbms6DQo+IA0KPiBzdWJzeXN0ZW0gLT4gLi4vLi4v
Li4vLi4vLi4vLi4vYnVzL21jMA0KPiANCj4gYW5kIEkgdGhpbmsgdGhhdCdzIG9rIGFzIG5vdGhp
bmcgc2hvdWxkIGJlIHVzaW5nIGl0Lg0KPiANCj4gVGh4Lg0KPiANCj4gLS0NCj4gUmVnYXJkcy9H
cnVzcywNCj4gICAgIEJvcmlzLg0KPiANCj4gR29vZCBtYWlsaW5nIHByYWN0aWNlcyBmb3IgNDAw
OiBhdm9pZCB0b3AtcG9zdGluZyBhbmQgdHJpbSB0aGUgcmVwbHkuDQo=
