Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16CBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6346024001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jhzjlyrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6346024001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932836AbeGFMRU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:17:20 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:50816
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932483AbeGFMRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XABdkUcYG01c/EdL92PRLAFi5EHnpz8pfz4NMUGEaoM=;
 b=jhzjlyrUsBcTBnw01iZzxtModIElfUyW+UQxz27rQ/VuoWY7nl5Stpc/SLIqW9slbSj+hmfcr4QrAAEhA0H5T7Xtt5iwNnUptz5j3SqFX7x5GJIh8geL7BkIYJgQEXWgYlmLtFa50CuzPsKqKkunV8r1Gau01kEnHlRQhP+or48=
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com (10.168.33.22) by
 HE1PR0401MB1946.eurprd04.prod.outlook.com (10.166.122.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Fri, 6 Jul 2018 12:17:09 +0000
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::cdef:2f0e:a80e:edba]) by HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::cdef:2f0e:a80e:edba%8]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 12:17:09 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 5/7 v5] bus: fsl-mc: support dma configure for devices on
 fsl-mc bus
Thread-Topic: [PATCH 5/7 v5] bus: fsl-mc: support dma configure for devices on
 fsl-mc bus
Thread-Index: AQHT8EGOSRYrId73jUqNsNx8JUAO8qR98TaAgARzrWA=
Date:   Fri, 6 Jul 2018 12:17:09 +0000
Message-ID: <HE1PR0401MB2425626DB35517BFD4FA9E15E6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-6-git-send-email-nipun.gupta@nxp.com>
 <b4cf1e86-0297-97ed-d10e-9b430ecb0bc7@arm.com>
In-Reply-To: <b4cf1e86-0297-97ed-d10e-9b430ecb0bc7@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1946;7:he0tTtiB7DXG1bk1Ca0HzjA6snRk3KFR8yczRM8EaBDjq5f/MG2xbfZnnk43cLbnxjKgfHMXPMZINMlraVtRW6rRpf+jGMl9Rb5paZFaHov/Kg9c9HiOf8ETU36/e4PMrpk2Jyex2hiUx/wEAJ9hqODIyEBf8cPNf+ULFqo6bHSRvufIChfGJONnWCa+Iq75ixIK65e02A27lz2MdsYVhkatHey0zvd2qBJ/nN/mNattBdwdv5jKBeNxwsqomoSU
x-ms-office365-filtering-correlation-id: 741fc52d-e3bc-4974-f631-08d5e33a65be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1946;
x-ms-traffictypediagnostic: HE1PR0401MB1946:
x-microsoft-antispam-prvs: <HE1PR0401MB19462614174CF13553FC6FC2E6470@HE1PR0401MB1946.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB1946;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1946;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(13464003)(199004)(189003)(53936002)(229853002)(86362001)(105586002)(7416002)(7736002)(6116002)(478600001)(76176011)(14454004)(3846002)(7696005)(54906003)(2906002)(33656002)(110136005)(74316002)(305945005)(316002)(2201001)(5660300001)(106356001)(53546011)(6506007)(25786009)(6436002)(2900100001)(9686003)(68736007)(55236004)(99286004)(97736004)(2501003)(5250100002)(81166006)(8676002)(8936002)(39060400002)(256004)(14444005)(6246003)(26005)(486006)(446003)(44832011)(66066001)(11346002)(186003)(81156014)(102836004)(55016002)(476003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1946;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7z+bAX67imAJzX0QxMOGWsPyDuUGNggzJTCCGiYaC0La4aLhh+nfJGKgYD8A5t2+3GAJXGT/UirLeCTDUsOP0YUoDe7H8rL2jP23lTNmhbOCh+gz0bNh/Rh9nrtYPGc5deNavqchwFbHLELwq18HSlQORp6byvbhvGOLEl+LQbxaY9vGSg34t6eRLlNg9+5Rq9xJD1gcSmD58H7iqF2l0p8jKyw3QZ9Yn1j1t9QAg3QM6nVk5vmwMwoXs2pBjNTIMdaiI9YEUM8oyLJ2uWJ8ooPFOPTI15uOjCLp+MqSG9IMrtV3OvF5I1gW5oJpdvhm4ZIe9rhs3LBF0oby30A07G21XheOMs9NlK+dHDo9Ino=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741fc52d-e3bc-4974-f631-08d5e33a65be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 12:17:09.5383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMywgMjAx
OCA5OjQ0IFBNDQo+IFRvOiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAbnhwLmNvbT47IHdpbGwu
ZGVhY29uQGFybS5jb207DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBt
YXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnOyBMYXVyZW50aXUgVHVkb3INCj4gPGxhdXJlbnRpdS50dWRvckBu
eHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbQ0KPiBDYzogaGNoQGxzdC5kZTsgam9yb0A4Ynl0
ZXMub3JnOyBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGZyb3dhbmQubGlzdEBnbWFpbC5jb207IGlvbW11QGxpc3RzLmxpbnV4LQ0KPiBmb3VuZGF0aW9u
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXhwcGMt
ZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBCaGFy
YXQgQmh1c2hhbiA8YmhhcmF0LmJodXNoYW5AbnhwLmNvbT47DQo+IHN0dXlvZGVyQGdtYWlsLmNv
bTsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS83
IHY1XSBidXM6IGZzbC1tYzogc3VwcG9ydCBkbWEgY29uZmlndXJlIGZvciBkZXZpY2VzDQo+IG9u
IGZzbC1tYyBidXMNCj4gDQo+IE9uIDIwLzA1LzE4IDE0OjQ5LCBOaXB1biBHdXB0YSB3cm90ZToN
Cj4gPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBvZiBkbWEgY29uZmlndXJhdGlvbiBmb3IgZGV2
aWNlcyBvbiBmc2wtbWMNCj4gPiBidXMgdXNpbmcgJ2RtYV9jb25maWd1cmUnIGNhbGxiYWNrIGZv
ciBidXNzZXMuIEFsc28sIGRpcmVjdGx5IGNhbGxpbmcNCj4gPiBhcmNoX3NldHVwX2RtYV9vcHMg
aXMgcmVtb3ZlZCBmcm9tIHRoZSBmc2wtbWMgYnVzLg0KPiANCj4gTG9va3MgbGlrZSB0aGlzIGlz
IHRoZSBmaW5hbCBhcmNoX3NldHVwX2RtYV9vcHMgb2ZmZW5kZXIsIHlheSENCj4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQG54cC5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9yQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gICBkcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5jIHwgMTUgKysrKysrKysrKyst
LS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5j
IGIvZHJpdmVycy9idXMvZnNsLW1jL2ZzbC1tYy0NCj4gYnVzLmMNCj4gPiBpbmRleCA1ZDgyNjZj
Li5mYTQzYzdkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVz
LmMNCj4gPiArKysgYi9kcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5jDQo+ID4gQEAgLTEy
Nyw2ICsxMjcsMTYgQEAgc3RhdGljIGludCBmc2xfbWNfYnVzX3VldmVudChzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+IHN0cnVjdCBrb2JqX3VldmVudF9lbnYgKmVudikNCj4gPiAgIAlyZXR1cm4gMDsN
Cj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGZzbF9tY19kbWFfY29uZmlndXJlKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZG1hX2RldiA9IGRl
djsNCj4gPiArDQo+ID4gKwl3aGlsZSAoZGV2X2lzX2ZzbF9tYyhkbWFfZGV2KSkNCj4gPiArCQlk
bWFfZGV2ID0gZG1hX2Rldi0+cGFyZW50Ow0KPiA+ICsNCj4gPiArCXJldHVybiBvZl9kbWFfY29u
ZmlndXJlKGRldiwgZG1hX2Rldi0+b2Zfbm9kZSwgMCk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBz
dGF0aWMgc3NpemVfdCBtb2RhbGlhc19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUNCj4gKmF0dHIsDQo+ID4gICAJCQkgICAgIGNoYXIgKmJ1ZikNCj4gPiAg
IHsNCj4gPiBAQCAtMTQ4LDYgKzE1OCw3IEBAIHN0cnVjdCBidXNfdHlwZSBmc2xfbWNfYnVzX3R5
cGUgPSB7DQo+ID4gICAJLm5hbWUgPSAiZnNsLW1jIiwNCj4gPiAgIAkubWF0Y2ggPSBmc2xfbWNf
YnVzX21hdGNoLA0KPiA+ICAgCS51ZXZlbnQgPSBmc2xfbWNfYnVzX3VldmVudCwNCj4gPiArCS5k
bWFfY29uZmlndXJlICA9IGZzbF9tY19kbWFfY29uZmlndXJlLA0KPiA+ICAgCS5kZXZfZ3JvdXBz
ID0gZnNsX21jX2Rldl9ncm91cHMsDQo+ID4gICB9Ow0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwo
ZnNsX21jX2J1c190eXBlKTsNCj4gPiBAQCAtNjMzLDEwICs2NDQsNiBAQCBpbnQgZnNsX21jX2Rl
dmljZV9hZGQoc3RydWN0IGZzbF9tY19vYmpfZGVzYw0KPiAqb2JqX2Rlc2MsDQo+ID4gICAJCQln
b3RvIGVycm9yX2NsZWFudXBfZGV2Ow0KPiA+ICAgCX0NCj4gPg0KPiA+IC0JLyogT2JqZWN0cyBh
cmUgY29oZXJlbnQsIHVubGVzcyAnbm8gc2hhcmVhYmlsaXR5JyBmbGFnIHNldC4gKi8NCj4gPiAt
CWlmICghKG9ial9kZXNjLT5mbGFncyAmDQo+IEZTTF9NQ19PQkpfRkxBR19OT19NRU1fU0hBUkVB
QklMSVRZKSkNCj4gDQo+IEFsdGhvdWdoIGl0IHNlZW1zIHdlIGRvIGVuZCB1cCB3aXRob3V0IGFu
eSBoYW5kbGluZyBvZiB0aGlzDQo+ICJub24tY29oZXJlbnQgb2JqZWN0IGJlaGluZCBjb2hlcmVu
dCBNQyIgY2FzZSwgYW5kIEknbSBub3Qgc3VyZSBob3cNCj4gZWFzaWx5IHRoYXQgY291bGQgYmUg
YWNjb21tb2RhdGVkIGJ5IGdlbmVyaWMgY29kZS4uLiA6LyBIb3cgaW1wb3J0YW50IGlzDQo+IHRo
ZSBxdWlyaz8NCg0KV2UgaGF2ZSBhbGwgdGhlIGRldmljZXMgYXMgY29oZXJlbnQgaW4gb3VyIFNv
QydzIG5vdyA6KSBTbyB0aGlzIGlzIGZpbmUuDQpXZSBoYXZlIGludGVybmFsbHkgZGlzY3Vzc2Vk
IGl0Lg0KDQpSZWdhcmRzLA0KTmlwdW4NCg0KPiANCj4gUm9iaW4uDQo+IA0KPiA+IC0JCWFyY2hf
c2V0dXBfZG1hX29wcygmbWNfZGV2LT5kZXYsIDAsIDAsIE5VTEwsIHRydWUpOw0KPiA+IC0NCj4g
PiAgIAkvKg0KPiA+ICAgCSAqIFRoZSBkZXZpY2Utc3BlY2lmaWMgcHJvYmUgY2FsbGJhY2sgd2ls
bCBnZXQgaW52b2tlZCBieSBkZXZpY2VfYWRkKCkNCj4gPiAgIAkgKi8NCj4gPg0K
