Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA896C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722CE24002
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="po1ipEKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722CE24002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932955AbeGFMS7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:18:59 -0400
Received: from mail-eopbgr20087.outbound.protection.outlook.com ([40.107.2.87]:55616
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932483AbeGFMSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k+VYO695WxETAvIbs7PQPEB7SABzyYW8HNgNN8wPhE=;
 b=po1ipEKyW+i14vBOdvS+dEihbquMyCPeFmNidfgkETjok1r3m873xDD7FI+oL7UnfzLVOGIH3RkDJ+pmF0DSEbdxKE79KggF9XJhVeKakkVSr6A/CvXUjIQIYC7aBxRoLRCS2mOApEOmHAP7VIKX0az0LDjPcWW7ROL+a2hJP2c=
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com (10.168.33.22) by
 HE1PR0401MB2201.eurprd04.prod.outlook.com (10.166.76.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Fri, 6 Jul 2018 12:18:49 +0000
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::cdef:2f0e:a80e:edba]) by HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::cdef:2f0e:a80e:edba%8]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 12:18:49 +0000
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
Subject: RE: [PATCH 7/7 v5] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
Thread-Topic: [PATCH 7/7 v5] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
Thread-Index: AQHT8EGU5+/8yNxT/UOVR4wwDpHOo6R990AAgARu6uA=
Date:   Fri, 6 Jul 2018 12:18:49 +0000
Message-ID: <HE1PR0401MB2425F914BA7A9DDCB3D76AEDE6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-8-git-send-email-nipun.gupta@nxp.com>
 <88626adc-6f5b-86df-88a0-620d258f8053@arm.com>
In-Reply-To: <88626adc-6f5b-86df-88a0-620d258f8053@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2201;7:6So8AU90qF/0D7blw6VJFVCGI97V/Dta2z09RDpNTKpz9a3Dh+QCSz87z72vEq0fFSFTbDKPBczemjU02XUyPwZLMwpIkgsU3LsV4eCh0XesoOHlpJWgZIdFFLHDSXYVzZrt5SAw9kg3oINSNMjcpr3EaD1O+eCj9pjpZJUQb7eyjIPUVA/CY6GYk2Il8pvXjW1AiNeuDOvS/CYW4gMXc8qik12c2lnA16eQH1JA09aYXT9Zp9v8j3tXVjQA+iNf
x-ms-office365-filtering-correlation-id: b85e084c-dbc9-4675-79df-08d5e33aa10d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2201;
x-ms-traffictypediagnostic: HE1PR0401MB2201:
x-microsoft-antispam-prvs: <HE1PR0401MB2201A1D1453B92D5732C416AE6470@HE1PR0401MB2201.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(275809806118684)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2201;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2201;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(13464003)(189003)(53936002)(54906003)(575784001)(86362001)(53546011)(6506007)(102836004)(110136005)(26005)(2201001)(229853002)(55236004)(316002)(106356001)(6116002)(3846002)(14454004)(66066001)(105586002)(478600001)(76176011)(7696005)(55016002)(6436002)(97736004)(2900100001)(9686003)(486006)(25786009)(11346002)(476003)(2906002)(446003)(44832011)(68736007)(2501003)(5250100002)(7416002)(81166006)(8676002)(81156014)(186003)(8936002)(39060400002)(305945005)(99286004)(6246003)(7736002)(5660300001)(33656002)(4326008)(14444005)(256004)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2201;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c9zyj/r8y5FSEQi+5kLLk+qDbgPEABsa77rf4Tcu3MQVqjRUE6nM+jeBhgvm+N/HN7CvmlT9Q4KP/iMYmPhFZnQnLCZTYuFuVdGtPB1vn97bUsAKduiV2SUQGJ6UTtLk91jBy8OOYLiCy32M4XMAbSPOgLTj6A+TcklTwh3FM+rt+Nq28kkDODrPgjmtgeP4T1vrXqpkNOnw0CPBSEwAo8dgVVMYPs/4KF8+sDJ78nNtzX7GDD8kHNAWDB0IcSrwir/9nYtnGNS9W+ugvxx3AAjUrgtveqfLDIeKGHVoZtfQKracjAUaIUgRmQwXuoGM1mOe9/0kA3PLFZsJRgMDW3wBy01HGsMFAF/+WQNO4jQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85e084c-dbc9-4675-79df-08d5e33aa10d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 12:18:49.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMywgMjAx
OCAxMDowNiBQTQ0KPiBUbzogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQG54cC5jb20+OyB3aWxs
LmRlYWNvbkBhcm0uY29tOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsg
bWFyay5ydXRsYW5kQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZzsgTGF1cmVudGl1IFR1ZG9yDQo+IDxsYXVyZW50aXUudHVkb3JA
bnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb20NCj4gQ2M6IGhjaEBsc3QuZGU7IGpvcm9AOGJ5
dGVzLm9yZzsgbS5zenlwcm93c2tpQHNhbXN1bmcuY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBmcm93YW5kLmxpc3RAZ21haWwuY29tOyBpb21tdUBsaXN0cy5saW51eC0NCj4gZm91bmRhdGlv
bi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgQmhh
cmF0IEJodXNoYW4gPGJoYXJhdC5iaHVzaGFuQG54cC5jb20+Ow0KPiBzdHV5b2RlckBnbWFpbC5j
b207IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDcv
NyB2NV0gYXJtNjQ6IGR0czogbHMyMDh4YTogY29tcGx5IHdpdGggdGhlIGlvbW11IG1hcA0KPiBi
aW5kaW5nIGZvciBmc2xfbWMNCj4gDQo+IE9uIDIwLzA1LzE4IDE0OjQ5LCBOaXB1biBHdXB0YSB3
cm90ZToNCj4gPiBmc2wtbWMgYnVzIHN1cHBvcnQgdGhlIG5ldyBpb21tdS1tYXAgcHJvcGVydHku
IENvbXBseSB0byB0aGlzIGJpbmRpbmcNCj4gPiBmb3IgZnNsX21jIGJ1cy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE5pcHVuIEd1cHRhIDxuaXB1bi5ndXB0YUBueHAuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPiA+IC0t
LQ0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMjA4eGEuZHRzaSB8
IDYgKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWxzMjA4eGEuZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2Zz
bC1sczIwOHhhLmR0c2kNCj4gPiBpbmRleCAxMzdlZjRkLi42MDEwNTA1IDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczIwOHhhLmR0c2kNCj4gPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMyMDh4YS5kdHNpDQo+ID4g
QEAgLTE4NCw2ICsxODQsNyBAQA0KPiA+ICAgCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiAg
IAkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gICAJCXJhbmdlczsNCj4gPiArCQlkbWEtcmFuZ2Vz
ID0gPDB4MCAweDAgMHgwIDB4MCAweDEwMDAwIDB4MDAwMDAwMDA+Ow0KPiA+DQo+ID4gICAJCWNs
b2NrZ2VuOiBjbG9ja2luZ0AxMzAwMDAwIHsNCj4gPiAgIAkJCWNvbXBhdGlibGUgPSAiZnNsLGxz
MjA4MGEtY2xvY2tnZW4iOw0KPiA+IEBAIC0zNTcsNiArMzU4LDggQEANCj4gPiAgIAkJCXJlZyA9
IDwweDAwMDAwMDA4IDB4MGMwMDAwMDAgMCAweDQwPiwJIC8qIE1DIHBvcnRhbA0KPiBiYXNlICov
DQo+ID4gICAJCQkgICAgICA8MHgwMDAwMDAwMCAweDA4MzQwMDAwIDAgMHg0MDAwMD47IC8qIE1D
DQo+IGNvbnRyb2wgcmVnICovDQo+ID4gICAJCQltc2ktcGFyZW50ID0gPCZpdHM+Ow0KPiA+ICsJ
CQlpb21tdS1tYXAgPSA8MCAmc21tdSAwIDA+OwkvKiBUaGlzIGlzIGZpeGVkLXVwIGJ5DQo+IHUt
Ym9vdCAqLw0KPiA+ICsJCQlkbWEtY29oZXJlbnQ7DQo+ID4gICAJCQkjYWRkcmVzcy1jZWxscyA9
IDwzPjsNCj4gPiAgIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+DQo+ID4gQEAgLTQ2MCw2ICs0
NjMsOCBAQA0KPiA+ICAgCQkJY29tcGF0aWJsZSA9ICJhcm0sbW11LTUwMCI7DQo+ID4gICAJCQly
ZWcgPSA8MCAweDUwMDAwMDAgMCAweDgwMDAwMD47DQo+ID4gICAJCQkjZ2xvYmFsLWludGVycnVw
dHMgPSA8MTI+Ow0KPiA+ICsJCQkjaW9tbXUtY2VsbHMgPSA8MT47DQo+ID4gKwkJCXN0cmVhbS1t
YXRjaC1tYXNrID0gPDB4N0MwMD47DQo+ID4gICAJCQlpbnRlcnJ1cHRzID0gPDAgMTMgND4sIC8q
IGdsb2JhbCBzZWN1cmUgZmF1bHQgKi8NCj4gPiAgIAkJCQkgICAgIDwwIDE0IDQ+LCAvKiBjb21i
aW5lZCBzZWN1cmUgaW50ZXJydXB0ICovDQo+ID4gICAJCQkJICAgICA8MCAxNSA0PiwgLyogZ2xv
YmFsIG5vbi1zZWN1cmUgZmF1bHQgKi8NCj4gPiBAQCAtNTAyLDcgKzUwNyw2IEBADQo+ID4gICAJ
CQkJICAgICA8MCAyMDQgND4sIDwwIDIwNSA0PiwNCj4gPiAgIAkJCQkgICAgIDwwIDIwNiA0Piwg
PDAgMjA3IDQ+LA0KPiA+ICAgCQkJCSAgICAgPDAgMjA4IDQ+LCA8MCAyMDkgND47DQo+ID4gLQkJ
CW1tdS1tYXN0ZXJzID0gPCZmc2xfbWMgMHgzMDAgMD47DQo+IA0KPiBTaW5jZSB3ZSdyZSBpbiBo
ZXJlLCBpcyB0aGUgU01NVSBpdHNlbGYgYWxzbyBjb2hlcmVudD8gSWYgaXQgaXMsIHlvdQ0KPiBw
cm9iYWJseSB3YW50IHRvIHNheSBzbyBhbmQgYXZvaWQgdGhlIG92ZXJoZWFkIG9mIHBvaW50bGVz
c2x5IGNsZWFuaW5nDQo+IGNhY2hlIGxpbmVzIG9uIGV2ZXJ5IHBhZ2UgdGFibGUgdXBkYXRlLg0K
DQpZZXMsIGRtYS1jb2hlcmVudCBwcm9wZXJ0eSBpcyBhbHNvIHJlcXVpcmVkIGhlcmUuIEkgbWlz
c2VkIGl0IHNvbWVob3cuDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMuDQoNClJlZ2FyZHMsDQpO
aXB1bg0KDQo+IA0KPiBSb2Jpbi4NCj4gDQo+ID4gICAJCX07DQo+ID4NCj4gPiAgIAkJZHNwaTog
ZHNwaUAyMTAwMDAwIHsNCj4gPg0K
