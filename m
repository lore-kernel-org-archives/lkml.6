Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F03C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EA220815
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onelaird.onmicrosoft.com header.i=@onelaird.onmicrosoft.com header.b="8UfP5qn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeLSL2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:28:05 -0500
Received: from mail-bgr052100140093.outbound.protection.outlook.com ([52.100.140.93]:63792
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727821AbeLSL2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onelaird.onmicrosoft.com; s=selector1-lairdtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpzJQh7ySLwKcZr502506yYn3QcLXpmTDP2/duoNYzM=;
 b=8UfP5qn/RWxxEtqvA6CuqAsAQmxaQTe5HlcNetg4cMB03FYvYGd1rk8VOafPEYAInBzPqdxktKlupK5+4hH1XYf7D9wz2Y2kNCE4dtuXkQaZfe7plNjOoK+j5gzVIrRsa87UKdj/+A1kURBhjx3dmZoIw0Nt8dRMMeM5HihsISg=
Received: from BY1PR02MB1114.namprd02.prod.outlook.com (10.162.108.140) by
 BY1PR02MB1211.namprd02.prod.outlook.com (10.162.108.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Wed, 19 Dec 2018 11:27:52 +0000
Received: from BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::619e:d5fa:199e:c1b1]) by BY1PR02MB1114.namprd02.prod.outlook.com
 ([fe80::619e:d5fa:199e:c1b1%4]) with mapi id 15.20.1425.024; Wed, 19 Dec 2018
 11:27:52 +0000
From:   Ben Whitten <Ben.Whitten@lairdtech.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>
CC:     "David S. Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Subject: RE: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Thread-Topic: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class
 module
Thread-Index: AQHUlSj0xlSlK7vGv0u4S31FjvDsaKWC9/6AgAGZNICAAEksgIABC9Dg
Date:   Wed, 19 Dec 2018 11:27:52 +0000
Message-ID: <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw>
 <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
In-Reply-To: <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Whitten@lairdtech.com; 
x-originating-ip: [109.174.151.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR02MB1211;7:vzGACmQUQDXgKsCIRZEQbvJvURMXnOub5bIOHmyQq1Zy80mfZSsxToe6OMisGFV+fEEL1u9keyCWZv2Ii728q2oEzAjV5Ii+z+Lce06VHJPM7bAd2HnosjtKPjZmozWGstcmVvUjl9tyN23qn6l0xg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e563e2a1-9862-48c7-e6f6-08d665a503a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY1PR02MB1211;
x-ms-traffictypediagnostic: BY1PR02MB1211:|BY1PR02MB1211:
x-microsoft-antispam-prvs: <BY1PR02MB121187E23CA79507D29E01DDE7BE0@BY1PR02MB1211.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231475)(944501520)(4982022)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY1PR02MB1211;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1211;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(99286004)(305945005)(14454004)(966005)(2171002)(6246003)(7736002)(6436002)(55016002)(81166006)(81156014)(8676002)(476003)(6306002)(33656002)(9686003)(5660300001)(478600001)(93886005)(229853002)(7416002)(486006)(8936002)(53936002)(2906002)(74316002)(4326008)(97736004)(102836004)(110136005)(54906003)(6506007)(68736007)(71190400001)(71200400001)(446003)(6116002)(316002)(3846002)(66066001)(11346002)(256004)(106356001)(26005)(7696005)(186003)(105586002)(72206003)(25786009)(14444005)(86362001)(76176011)(4432625001);DIR:OUT;SFP:1501;SCL:5;SRVR:BY1PR02MB1211;H:BY1PR02MB1114.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lairdtech.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G2f7jrYvr/lDH/lKp7WuCLtriz2Nuhji2rjqFYqvfiN3Ze999zBTbVbgutNGpbWmyTxVbyOenKBTW/y9anxn9HhdQ9iSucExaZyeFp8OtBE+NvEPeQj65wYN7grEUtI5fZLAJBBZrbqgLdL1beZDNas1dfUmpCWlhgHue2EYv6x8Sraewn6+DRvLZUSNSMriy93u7KZNdUCr9O1MNrKlCjFXcJ1VO7kp4OqAhlLQszbhwy3zWM7X+1UId3r8mAUlVYgG02HzTaZG5yftfGeo2RSfP63FuGdm9Eyc3Zpos9iIScTdOeWFkDN6t8NRNj9yiniMlaF+TEWgIkCbEc1nHf/JrJzTduOG6FaIQ/yWCpo+h7xXBkZTFJ22IPkHkafqG1pMiKXS1SWP9LhGwyqQx7aBm70mQmfyb1gHEFj7Z/fj7/wyhFRgLWnvegQjK1syBPChODL5D3/DkarTN37+7lv5RrBJ0jaXMUl0fKX/CNBkWS5pWxJUmRR118+wOdVp
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e563e2a1-9862-48c7-e6f6-08d665a503a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 11:27:52.3729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4d27a54-2db1-4088-a044-1a83c778ad1b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBbSAxOC4xMi4xOCB1bSAxNToyNyBzY2hyaWViIEppYW4tSG9uZyBQYW46DQo+ID4+IFN1biwg
RGVjIDE2LCAyMDE4IGF0IDExOjE4OjU5QU0gQ0VULCBzdGFybmlnaHRAZy5uY3UuZWR1LnR3IHdy
b3RlOg0KPiA+Pj4gTG9SYVdBTiBkZWZpbmVkIGJ5IExvUmEgQWxsaWFuY2UoVE0pIGlzIHRoZSBN
QUMgbGF5ZXIgb3ZlciBMb1JhDQo+IGRldmljZXMuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBwYXRjaCBp
bXBsZW1lbnRzIHBhcnQgb2YgQ2xhc3MgQSBlbmQtZGV2aWNlcyBTb2Z0TUFDIGRlZmluZWQgaW4N
Cj4gPj4+IExvUmFXQU4oVE0pIFNwZWNpZmljYXRpb24gVmVyLiAxLjAuMjoNCj4gPj4+IDEuIEVu
ZC1kZXZpY2UgcmVjZWl2ZSBzbG90IHRpbWluZw0KPiA+Pj4gMi4gT25seSBzaW5nbGUgY2hhbm5l
bCBhbmQgc2luZ2xlIGRhdGEgcmF0ZSBmb3Igbm93DQo+ID4+PiAzLiBVbmNvbmZpcm1lZCBkYXRh
IHVwL2Rvd24gbWVzc2FnZSB0eXBlcw0KPiA+Pj4NCj4gPj4+IE9uIHRoZSBvdGhlciBzaWRlLCBp
dCBkZWZpbmVzIHRoZSBiYXNpYyBpbnRlcmZhY2UgYW5kIG9wZXJhdGlvbg0KPiA+Pj4gZnVuY3Rp
b25zIGZvciBjb21wYXRpYmxlIExvUmEgZGV2aWNlIGRyaXZlcnMuDQo+ID4+Pg0KPiA+Pj4gU2ln
bmVkLW9mZi1ieTogSmlhbi1Ib25nIFBhbiA8c3Rhcm5pZ2h0QGcubmN1LmVkdS50dz4NCj4gWy4u
Ll0NCj4gPj4+IG5ldC9tYWNsb3Jhd2FuL0tjb25maWcgIHwgIDE0ICsNCj4gPj4+IG5ldC9tYWNs
b3Jhd2FuL01ha2VmaWxlIHwgICAyICsNCj4gPj4+IG5ldC9tYWNsb3Jhd2FuL21hYy5jICAgIHwg
NTU1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4gbmV0L21h
Y2xvcmF3YW4vbWFpbi5jICAgfCA2MDYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+Pj4gNCBmaWxlcyBjaGFuZ2VkLCAxMTc3IGluc2VydGlvbnMoKykNCj4g
Pj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBuZXQvbWFjbG9yYXdhbi9LY29uZmlnDQo+ID4+PiBjcmVh
dGUgbW9kZSAxMDA2NDQgbmV0L21hY2xvcmF3YW4vTWFrZWZpbGUNCj4gPj4+IGNyZWF0ZSBtb2Rl
IDEwMDY0NCBuZXQvbWFjbG9yYXdhbi9tYWMuYw0KPiA+Pj4gY3JlYXRlIG1vZGUgMTAwNjQ0IG5l
dC9tYWNsb3Jhd2FuL21haW4uYw0KPiA+Pg0KPiA+PiBJIGRvbid0IGdldCBpdC4gSW4gcGF0Y2gg
IkFkZCBMb1JhV0FOIEFQSSBkZWNsYXJhdGlvbiBmb3IgTG9SYSBkZXZpY2VzIg0KPiA+PiB5b3Ug
YWRkIGhlYWRlcnMgZm9yICJBUEkiIGFuZCBoZXJlIHlvdSBpbXBsZW1lbnQgZnVuY3Rpb25zLiBU
aGF0IGlzIGp1c3QNCj4gPj4gd2VpcmQuIERvZXMgaXQgbWVhbiB5b3UgY2FuIGhhdmUgb3RoZXIg
aW1wbGVtZW50YXRpb25zPw0KPiA+DQo+ID4gTG9SYVdBTiBkZWZpbmVkIGJ5IExvUmEgQWxsaWFu
Y2UoVE0pIGlzIHRoZSBNQUMgbGF5ZXIgb3ZlciBMb1JhIFBIWS4NCj4gPiBUaGlzIHBhcnQgaXMg
c29mdC1NQUMgYXMgQW5kcmVhcyBtZW50aW9uZWQNCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9waXBlcm1haWwvbGludXgtbHB3YW4vMjAxOC0NCj4gRGVjZW1iZXIvMDAwMDEwLmh0bWwN
Cj4gPg0KPiA+PiBBbHNvLCB5b3UgZG9uJ3QgcmVhbGx5IGhhdmUgYW55IHVzZXIgb2YgdGhpcyBB
UEkgaW4gdGhlIHNldC4gUGxlYXNlDQo+ID4+IGludHJvZHVjZSBhdCBsZWFzdCAxIGRyaXZlciwg
cHJlZmVyYWJseSBtb3JlIChJIHNlZSB0aGF0IEFuZHJlYXMgaGFzDQo+ID4+IG11bHRpcGxlIG9u
ZXMgaW4gaGlzIHBhdGNoc2V0KS4gWW91IGNhbm5vdCBwdXNoIGtlcm5lbCBpbmZyYXN0cnVjdHVy
ZQ0KPiA+PiB3aXRob3V0IGtlcm5lbCB1c2VyLg0KPiA+DQo+ID4gVGhlIHNvZnQtTUFDIGlzIHN1
aXRhYmxlIGZvciB0aGUgTG9SYSBjaGlwcycgZGV2aWNlIGRyaXZlcnMsIGxpa2UNCj4gPiBzeDEy
NzYvNzcvNzgvNzksIFJGTTk1Lzk2Lzk3Lzk4VyAuLi4NCj4gPiBTdGlsbCB3YWl0aW5nIGZvciBB
bmRyZWFzJyBzeDEyNzYgdmVyc2lvbiAyIHBhdGNoIGFuZCBtb3JlIGRpc2N1c3Npb24uDQo+IA0K
PiBzeDEyNzYgcmVnbWFwIGNvbnZlcnNpb24gd2FzIHB1c2hlZCB0byBteSBzdGFnaW5nIHRyZWUg
dG9nZXRoZXIgd2l0aA0KPiBCZW4ncyBzeDEzMDEgZmluYWwgY29udmVyc2lvbiBsYXN0IG5pZ2h0
LCBsaWdodGx5IHRlc3RlZC4NCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2FmYWVyYmVyL2xpbnV4LQ0KPiBsb3JhLmdpdC9sb2cvP2g9bG9yYS1u
ZXh0DQo+IA0KPiBUQkQ6IHJlbmFtZSB0byBzeDEyN3gsIGltcGxlbWVudCByZWdtYXAgZmllbGRz
LCBvbmx5IGF1dG8tZGV0ZWN0IHJlc2V0DQo+IHdoZW4gbm8gT0Ygbm9kZSBhdmFpbGFibGUgKGFs
bCBsb3cgcHJpb3JpdHkgYXRtLCBwYXRjaGVzIHdlbGNvbWUpDQo+IA0KPiAoYW5kIGZvciBzeDEz
MDEgSSBzdGlsbCBuZWVkIHRvIHVwZGF0ZSBteSBEVCBvdmVybGF5cyB3aXRoIHRoZSBuZXcgY2xr
KQ0KPiANCj4gPiBGb3IgZXhhbXBsZSwgaG93IHRvIG1ha2UgUEZfTE9SQSBhbmQgUEZfTE9SQVdB
TiBsaWtlIEV0aGVybmV0LA0KPiBQRl9JTkVUDQo+ID4gYW5kIFBGX0lORVQ2IGRvbid0IG5lZWQg
c2VwYXJhdGUgZGV2aWNlcyBlaXRoZXIsIGJvdGggdXNlIGV0aDAuDQo+ID4gaHR0cHM6Ly9sa21s
Lm9yZy9sa21sLzIwMTgvOC8zLzI2Ng0KPiANCj4gSmlyaSwgSSBhbSBleHBlY3RpbmcgdGhlIG1h
Y2xvcmF3YW4gZHJpdmVyIHRvIGxvd2VyIHBhY2tldHMgZnJvbQ0KPiBFVEhfUF9MT1JBV0FOIHRv
IEVUSF9QX0xPUkEgaW4gYSBnZW5lcmljIHdheSwgc28gdGhhdCBhbnkgb2YgdGhlIExvUmENCj4g
ZGV2aWNlIGRyaXZlcnMgY2FuIGJlbmVmaXQgb2YgaXQsIHdpdGggbWFjbG9yYXdhbiB1c2luZyB0
aGUgTG9SYSBuZXRsaW5rDQo+IGNvbW1hbmRzIHRoYXQgdGhlIGluZGl2aWR1YWwgZHJpdmVycyBp
bXBsZW1lbnQuDQo+IE5vdCBzdXJlIHdoYXQgaWYgYW55dGhpbmcgaXMgbWlzc2luZyBmb3IgdGhh
dCBpbiB0aGUgY3VycmVudCByZXZpc2lvbj8NCj4gU3RpbGwgZGVhbGluZyB3aXRoIHRoZSBsb3dl
ci1sZXZlbCBpbmZyYXN0cnVjdHVyZSBhbmQgbXkgdGVzdCBzZXR1cCAuLi4NCj4gcHJvZ3Jlc3Np
bmcgc2xvd2x5Lg0KPiANCj4gSSdsbCBwcm9iYWJseSBuZWVkIHRvIHF1ZXVlIHRoZSByZW1haW5p
bmcgZ2VuZXJpYyBMb1JhV0FOIHBhcnQgMS82IGluIG15DQo+IHRyZWUgdG8gcmVzb2x2ZSB0aGlz
IGNpcmN1bGFyIGRlcGVuZGVuY3kgYmV0d2VlbiBKaWFuLUhvbmcgYW5kIG1lLCBzbw0KPiB0aGF0
IG9ubHkgdGhlIHNvZnQtTUFDIGltcGxlbWVudGF0aW9uIHJlbWFpbnMgYSBzZXBhcmF0ZSBwYXRj
aCBzZXJpZXMuDQo+IFRoZSBoYXJkLU1BQyBpbXBsZW1lbnRhdGlvbnMgd2lsbCBiZSBvbiBteSBw
bGF0ZSBtb3N0bHksIGFzIGJvdGggU1gxMjc2DQo+IGFuZCBTWDEzMDEgbmVlZCB0aGUgc29mdC1N
QUMuDQoNCk9uIHRoZSBTWDEzMDEgc2lkZSBvZiB0aGluZ3MsIHRoZSBhYmlsaXR5IHRvIHNlbmQg
bWVzc2FnZXMgYXMgYSBMb1JhV0FODQpub2RlIGRldmljZSBpcyBhIG5pY2hlIHVzZSBjYXNlLCB0
aGUgbWFqb3JpdHkgaWYgbm90IGFsbCBwZW9wbGUgd2lsbCB1c2UgdGhlDQpjb25jZW50cmF0b3Ig
Y2FyZCBhcyB0aGUgcGFzcyB0aHJvdWdoIGdhdGV3YXkgdG8gdGhlIG5vZGUuDQoNCkluIHRoaXMg
bW9kZSBvZiBvcGVyYXRpb24gdGhlIHBhcmFtZXRlcnMgZm9yIHRyYW5zbWlzc2lvbiBzdWNoIGFz
OyBmcmVxdWVuY3ksDQpzcHJlYWRpbmcgZmFjdG9yIC8gZGF0YSByYXRlLCBwb3dlciwgYXJlIGdp
dmVuIGJ5IGEgcmVtb3RlIHNlcnZlciBhbmQgcGFzc2VkDQppbiBmcm9tIHRoZSB1c2Vyc3BhY2Ug
YXBwbGljYXRpb24gd2hpY2ggcmVjZWl2ZWQgaXQuDQpFdmVudHVhbGx5IGluIHRoZSBrZXJuZWwg
dGhlc2UgbmVlZCB0byBiZSBjaGVja2VkIGxvY2FsbHkgdG8gZW5zdXJlIHJlZ3VsYXRvcnkNCmNv
bXBsaWFuY2UuDQpUbyB0aGF0IGVuZCBJIGhhdmUgZXhwZXJpbWVudGVkIHdpdGggZnJhbWluZywg
YXMgQ0FOIGRvZXMsIHNvIHRoYXQgdGhpcw0KbWV0YWRhdGEgY2FuIGJlIHByb3ZpZGVkIG9uIGEg
d3JpdGUgZnJvbSB1c2Vyc3BhY2UgdG8gdGhlIFNYMTMwMSBkcml2ZXIuDQoNClNvdW5kcyBsaWtl
IHdlIG5lZWQgZGlmZmVyZW50IHByb3RvY29scyBmb3IgZnJhbWluZyB3aXRoaW4gdGhlIHByb3Rv
Y29sIGZhbWlseS4NClJhdyBpbiB0aGUgY2FzZSBvZiBub2RlcyBhbmQgZnJhbWVkIHdpdGggbWV0
YWRhdGEgaW4gdGhlIGNhc2Ugb2YgY29uY2VudHJhdG9yDQpjYXJkcywgdGhvdWdodHM/DQpJIHdp
bGwgc2VuZCBteSBleHBlcmltZW50IFJGQyB0byB0aGUgbHB3YW4gbWFpbGluZyBsaXN0Lg0KDQpS
ZWdhcmRzLA0KQmVuIFdoaXR0ZW4NCg==
