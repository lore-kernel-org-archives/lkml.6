Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46822ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FB02150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z5TZsJPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FB02150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbeITHzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:55:14 -0400
Received: from mail-eopbgr30050.outbound.protection.outlook.com ([40.107.3.50]:39936
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbeITHzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG5kql9C4jc1MWNdvn7hpzf99kamUt3rdtSmYy8azp0=;
 b=Z5TZsJPvxL0b0uRS7dGykWpLV04+33E0Y2ssvq/6dBUUYq9H0aaHPs/rvsYB2sJrWn6XKQiuYXIzTpWrOSlJPJZIdHujKOAcAQqTyJb4RZb6jxXcoIRaAkPkiQdQ4Gepg8UnXbpNfgB1A8PtWCuqWfTUlg6O9xJuKFonzZ4awa4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4897.eurprd04.prod.outlook.com (20.176.215.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 02:14:21 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9475:35f6:e801:6802]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9475:35f6:e801:6802%5]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 02:14:21 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: RE: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Thread-Topic: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Thread-Index: AQHUQOYAqzg0fl5c6km76P92aepQ6qTin9AQgBBfjVCABM4uAIAAv5kg
Date:   Thu, 20 Sep 2018 02:14:21 +0000
Message-ID: <AM0PR04MB4211B170CAC1B3F9E7356AF980130@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <AM0PR04MB4211EF6D783562BA8C8D690380010@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211A3900BC5A2DF857F7451801F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <7e612f6f-e9d2-2f6f-1903-3a6bcf1b65ba@linux.intel.com>
In-Reply-To: <7e612f6f-e9d2-2f6f-1903-3a6bcf1b65ba@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4897;6:xHbM2HrlvSMONqyyQlvAOPputqavhwledWlw1cNue4APHxyzt4f2m0e7GQ/bVE68lVVyRSGVArHc0b1bTPsprn5/ELpwtdhwvTBI+RYwxa7wDfvjvtfN6DsT3CXxVGAQHehTUFIzJV5zOkdLDppxpQNDpawL/yLh/zf3v2Skoxl9JwbXjq1ENE71q2WUVHSJZ8gtfhFwC3LkiqQAPZH1Qr/y7e2gJx9ZBwxQ4Vd4RX7P3ory9wuluWhV2LkhZhDAcKIVbmTcXGIV3LkSpYavvtwk2sfW/ktwLIzxPiO6w5JYWibM/BlP5rfYrp+FIbHmtvpi6h+L1INfa3fRC9bpyShJ4ZylDfvCSxR4BVF6eChiJPETYU5cen9Yg9/v/0peAdmkgCH8YQB4oLtwGIlE9Nano3e8xT9O+7/BzvsbVgyOdqbIqcwSOPvvAPBRY+HRCbZGQeaob4/z3shDU8RD2w==;5:paKmX3OO+Wna58MNjWIQXnTXMNAP9gqLXd//PdPGU1Th7CmQ0/fIA9YG/crFE/QHOUhnHZnCt26e2k1LygWFe1YBK/EFW74szyTQTu/CAH/QyG0Yggi/WHxxcuHudGcJ2juOQbvsbeODZ+ZPDy2bcRUgDFhwJ2JGHCQJV8OKhCo=;7:HLy3QIfz6GFX8tG8N9rdanTge59RvWxJYEyF5j21JUB9kRZbH0KbSetQZ+GISI3Z2LHvAiSqtdnvvz6BmUOG4OdjFh40DJN4TB2AHEamReHu2dbfbPbdE+K8yoAqwJiCpx+38MWJDPe4k9U+jkXGsRv/PqH48fohZQfr3KMHEVrw0ETDASNq+q7Kbvo35Led+49/cDGYgWAMGa4CqF0emayqeaPZ66NmHy9HihTjdRJk2EcQNpcDWiVXvG6FLpW+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fac2329e-5fa4-4e0c-e890-08d61e9ec767
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4897;
x-ms-traffictypediagnostic: AM0PR04MB4897:
x-microsoft-antispam-prvs: <AM0PR04MB489746DB6FD8F9FAD493581B80130@AM0PR04MB4897.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(9452136761055)(258649278758335)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4897;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4897;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(13464003)(199004)(189003)(2906002)(6436002)(6116002)(86362001)(966005)(256004)(575784001)(102836004)(305945005)(97736004)(7736002)(2201001)(25786009)(76176011)(5660300001)(53936002)(74316002)(316002)(186003)(4326008)(93886005)(11346002)(478600001)(7696005)(8676002)(9686003)(81156014)(6306002)(55016002)(110136005)(3846002)(2501003)(66066001)(54906003)(33656002)(5250100002)(68736007)(6506007)(486006)(106356001)(6246003)(2900100001)(229853002)(446003)(8936002)(26005)(45080400002)(53546011)(14454004)(81166006)(105586002)(99286004)(476003)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4897;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4An0nsjx+ZKM2INxwgb+HMpkGnEja3d1xLAQPYz8xvNi5yqXnklBDDPVJVOEhXtwlIR/JnM0lVxESnh5PZA6XpclkxiXCN6jIy+/1UHP6/MnWldDZT1GFkksM7AyqZ7/oY4U1mudRsguDUVffBJ3Q5ePWUGxE0+Vmehi4GfuYKVs6YscK3J1+DXZeVGLHlYOWgQuTwpHAhSwLTRZdPJTuhD3L23gjFvpTMYTgzfPh813YX5gmaVKmp6KmvfAXOGNu/dW+klQKUefN+AlRm0rsZmO6KRwusb4JIcvLcX2s6v9s6epqsk4U8o4K7qDrtVwZUXIS3MNcNjSvFjCRnUsmQ16iFznCKs7+vzAxPot/dA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac2329e-5fa4-4e0c-e890-08d61e9ec767
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:14:21.7314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9yIFRoYXllciBbbWFpbHRv
OnRob3IudGhheWVyQGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMTksIDIwMTggMTA6NDcgUE0NCj4gVG86IEEucy4gRG9uZyA8YWlzaGVuZy5kb25nQG54cC5j
b20+OyBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IHNib3lk
QGtlcm5lbC5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3Jn
Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgaGRlZ29lZGVAcmVkaGF0LmNv
bQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY2IDAvNF0gY2xrOiBuZXcgQVBJcyB0byBoYW5kbGUg
YWxsIGF2YWlsYWJsZSBjbG9ja3MNCj4gDQo+IEhpLA0KPiANCj4gT24gMDkvMTYvMjAxOCAwODoy
NCBBTSwgQS5zLiBEb25nIHdyb3RlOg0KPiA+IFBpbmcgYWdhaW4NCj4gPg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBBLnMuIERvbmcNCj4gPj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciA2LCAyMDE4IDExOjIzIEFNDQo+ID4+IFRvOiBsaW51eC1jbGtAdmdl
ci5rZXJuZWwub3JnDQo+ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IHNib3lkQGtlcm5l
bC5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+
PiB0aG9yLnRoYXllckBsaW51eC5pbnRlbC5jb207IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+Ow0KPiA+PiBoZGVnb2VkZUByZWRoYXQuY29tDQo+ID4+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggVjYgMC80XSBjbGs6IG5ldyBBUElzIHRvIGhhbmRsZSBhbGwgYXZhaWxhYmxlDQo+ID4+IGNs
b2Nrcw0KPiA+Pg0KPiA+PiBHZW50bHkgcGluZy4uLg0KPiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206IEEucy4gRG9uZw0KPiA+Pj4gU2VudDogRnJpZGF5
LCBBdWd1c3QgMzEsIDIwMTggMTI6NDYgUE0NCj4gPj4+IFRvOiBsaW51eC1jbGtAdmdlci5rZXJu
ZWwub3JnDQo+ID4+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4+IHNib3lkQGtlcm5lbC5v
cmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiA+Pj4g
dGhvci50aGF5ZXJAbGludXguaW50ZWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gPj4+IGhkZWdvZWRlQHJlZGhhdC5jb207IEEucy4gRG9uZyA8YWlzaGVuZy5kb25n
QG54cC5jb20+DQo+ID4+PiBTdWJqZWN0OiBbUEFUQ0ggVjYgMC80XSBjbGs6IG5ldyBBUElzIHRv
IGhhbmRsZSBhbGwgYXZhaWxhYmxlIGNsb2Nrcw0KPiA+Pj4NCj4gPj4+IFRoaXMgcGF0Y2ggc2Vy
aWVzIGlzIGEgY29udGludWUgb2YgZGlzY3Vzc2lvbiBmcm9tIGhlcmUsDQo+ID4+PiBodHRwczov
L2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGcA0KPiA+Pj4NCj4gYXRjaHdvcmsua2VybmVsLm9yZyUyRnBhdGNoJTJGOTk4NjI5MyUyRiZh
bXA7ZGF0YT0wMiU3QzAxJTdDYWlzaGUNCj4gbmcuDQo+ID4+Pg0KPiBkb25nJTQwbnhwLmNvbSU3
Q2I3OWYwYWE4Yzc0YzRmOTM1YWRiMDhkNjFlM2U3OTQ0JTdDNjg2ZWExZDNiYw0KPiAyYjRjNmYN
Cj4gPj4+DQo+IGE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjcyOTY1MTAxNDU0OTYzMyZh
bXA7c2RhdGE9emgwUlANCj4gVnQ0cHF5TQ0KPiA+Pj4gODRTVUZScERjYklINTgzSk5PTmxCaFRR
ZUxZd0RGbyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+Pj4gdGhhdCBzb21lIHVzZXJzIG1heSB3YW50
IHRvIGhhbmRsZSBhbGwgYXZhaWxhYmxlIGNsb2NrcyBmcm9tIGRldmljZQ0KPiA+Pj4gdHJlZSB3
aXRob3V0IG5lZWQgdG8ga25vdyB0aGUgZGV0YWlsZWQgY2xvY2sgaW5mb3JtYXRpb24gbGlrZXMg
Y2xvY2sNCj4gPj4+IG51bWJlcnMgYW5kIG5hbWVzLiBUaGlzIGlzIHVzZWZ1bCBpbiB3cml0aW5n
IHNvbWUgZ2VuZXJpYyBkcml2ZXJzIHRvDQo+ID4+PiBoYW5kbGUNCj4gPj4gY2xvY2sgcGFydC4N
Cj4gPj4+DQo+ID4+PiBOb3RlOg0KPiA+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgaXMgdGVzdGVkIG9u
IE1YNlEgU0RCIGNwdWZyZXEgZHJpdmVyIHdpdGggYSBtaW5vcg0KPiA+Pj4gY2hhbmdlIHRvIHN3
aXRjaCB0byB1c2UgY2xrX2J1bGtfZ2V0X2FsbC4NCj4gPj4+IEJ1dCBwYXRjaCA0IG9ubHkgdGVz
dCBjb21waWxpbmcuIEhvcGVmdWxseSBzb21lb25lIGNvdWxkIGhlbHAgdGVzdA0KPiA+Pj4gdGhl
IGZ1bmN0aW9uLg0KPiA+Pj4NCj4gPj4+IHYzLT52NDoNCj4gPj4+ICAgKiBpbXByb3ZlICdkZXZy
ZXMtPmNsa3MgPSAqY2xrcycgYWNjb3JkaW5nIHRvIFN0ZXBoZW4ncyBzdWdnZXN0aW9uDQo+ID4+
PiB2Mi0+djM6DQo+ID4+PiAgICogYWRkcmVzcyBhbGwgY29tbWVudHMgZnJvbSBTdGVwaGVuDQo+
ID4+PiAgICogZml4IGJ1aWxkIHdhcm5pbmdzIG9uIG90aGVyIGFyY2hpdGVjdHVyZXMuDQo+ID4+
PiB2MS0+djI6DQo+ID4+PiAgICogYWRkIGNsa19idWxrX3tnZXR8cHV0fV9hbGwoKSB3aGljaCBv
bmx5IHN1cHBvcnRzIERUIHBsYXRmb3JtDQo+ID4+PiBjdXJyZW50bHkNCj4gPj4+ICAgKiByZW1v
dmUgX2FsbCB2YXJpYW50cyBhbmQgdGhlIHdyYXBwZXIgc3RydWN0IGNsa19idWxrDQo+ID4+PiAg
ICogbWFrZSBvZl9jbGtfYnVsa19nZXQgYW5kIG9mX2Nsa19idWxrX2dldF9hbGwgcHJpdmF0ZSB1
bnRpbCBzb21lb25lDQo+ID4+PiAgICAgcHJvdmVzIHRoZXkgbmVlZCBpdCBiZWNhdXNlIHRoZXkg
ZG9uJ3QgaGF2ZSBhIHN0cnVjdCBkZXZpY2UgcG9pbnRlci4NCj4gPj4+DQo+ID4+PiBEb25nIEFp
c2hlbmcgKDQpOg0KPiA+Pj4gICAgY2xrOiBidWxrOiBhZGQgb2ZfY2xrX2J1bGtfZ2V0KCkNCj4g
Pj4+ICAgIGNsazogYWRkIG5ldyBBUElzIHRvIG9wZXJhdGUgb24gYWxsIGF2YWlsYWJsZSBjbG9j
a3MNCj4gPj4+ICAgIGNsazogYWRkIG1hbmFnZWQgdmVyc2lvbiBvZiBjbGtfYnVsa19nZXRfYWxs
DQo+ID4+PiAgICB2aWRlbzogc2ltcGxlZmI6IHN3aXRjaCB0byB1c2UgY2xrX2J1bGsgQVBJIHRv
IHNpbXBsaWZ5IGNsb2NrDQo+ID4+PiAgICAgIG9wZXJhdGlvbnMNCj4gPj4+DQo+ID4+PiAgIGRy
aXZlcnMvY2xrL2Nsay1idWxrLmMgICAgICAgICB8IDgwDQo+ID4+PiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4+ICAgZHJpdmVycy9jbGsvY2xrLWRldnJl
cy5jICAgICAgIHwgMjQgKysrKysrKysrKysrKw0KPiA+Pj4gICBkcml2ZXJzL3ZpZGVvL2ZiZGV2
L3NpbXBsZWZiLmMgfCA3MiArKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4+PiAgIGluY2x1ZGUvbGludXgvY2xrLmggICAgICAgICAgICB8IDY1DQo+ID4+PiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTg2
IGluc2VydGlvbnMoKyksIDU1IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IC0tDQo+ID4+PiAy
LjcuNA0KPiA+DQo+IEp1c3QgY2hlY2tpbmcgb24gdGhlIHN0YXR1cyBvZiB0aGlzIHBhdGNoLiBU
aGUgY2xvY2sgcm91dGluZXMgKHBhdGNoZXMNCj4gMS0zKSBhcmUgdXNlZnVsIGZvciBvbmUgb2Yg
bXkgZHJpdmVycyBidXQgaWYgdGhleSBhcmVuJ3QgYWNjZXB0ZWQgb3Igd2lsbCB0YWtlIGENCj4g
bG9uZyB0aW1lIHRvIGJlIGFjY2VwdGVkLCBJJ2xsIG5lZWQgdG8gcmVmYWN0b3IgbXkgZHJpdmVy
Lg0KPiANCg0KVGhhbmtzIGZvciB0aGlzIGluZm9ybWF0aW9uLg0KDQpTdGVwaGVuLA0KV291bGQg
eW91IGhlbHAgdG8gcHJvY2VlZCB0aGlzPw0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg==
