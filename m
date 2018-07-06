Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D558C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2614023F47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aDNgNcuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2614023F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbeGFMLG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:11:06 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:57024
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932502AbeGFMLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIo84zyvCw5KKt4XAyXlcULKLmTDJeOPzr2s4Yox/Rw=;
 b=aDNgNcuZiPHg2j12HyMlc3Kd7rkTo/UpBp9PFx0Mw7A3AtuHjdM1hnw1TE2b1p8MbS32fxZcErlm3dwrAbvZsQsqD1b+CjjYWGCHjivspHG7JoSfHkQbv6GFs8XMVCKWAdbXL7vURhjAXYyO4+OURdmN/CZNAF9fo+eEIsSvQHE=
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com (10.168.33.22) by
 HE1PR0401MB1738.eurprd04.prod.outlook.com (10.169.118.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Fri, 6 Jul 2018 12:10:53 +0000
Received: from HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::cdef:2f0e:a80e:edba]) by HE1PR0401MB2425.eurprd04.prod.outlook.com
 ([fe80::cdef:2f0e:a80e:edba%8]) with mapi id 15.20.0930.016; Fri, 6 Jul 2018
 12:10:53 +0000
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
Subject: RE: [PATCH 1/7 v5] Docs: dt: add fsl-mc iommu-map device-tree binding
Thread-Topic: [PATCH 1/7 v5] Docs: dt: add fsl-mc iommu-map device-tree
 binding
Thread-Index: AQHT8EGCFe4LrNM79UqY3jKcMIV40aR91uyAgASNNAA=
Date:   Fri, 6 Jul 2018 12:10:53 +0000
Message-ID: <HE1PR0401MB2425F74655E5DFE4DDE38EE3E6470@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-2-git-send-email-nipun.gupta@nxp.com>
 <cd70dc56-ce6a-f6ef-1362-143d9c31bb46@arm.com>
In-Reply-To: <cd70dc56-ce6a-f6ef-1362-143d9c31bb46@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1738;7:GTsNg6vFk6uFFvMaH0Z86caSrnVsIHrLboBON65yo/Iv0wCgNHSYM2okD75k1Or6TrgZ0VTEAfXPTm6d0AF5ZVv3ZvO/zJg0+iBuaUFra2PxMeo5Jujzd/ouYMfgqOh2YjjFgyL3mRG1nOJLmzguDaYnowPrZKEDpzwXH/Vp7sRijIntBY7FBB7Zjo55oWYp38k7v6Rfj+fmpgtIkpLTApbMirl+YLduyF5mq3so/F/jybBgaRKpx5PoNGfCucBW
x-ms-office365-filtering-correlation-id: 2fc2229c-0a42-4a1f-7d14-08d5e339858f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1738;
x-ms-traffictypediagnostic: HE1PR0401MB1738:
x-microsoft-antispam-prvs: <HE1PR0401MB173885BC15DE9E1A20486B07E6470@HE1PR0401MB1738.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335)(211936372134217)(275809806118684)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB1738;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1738;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(13464003)(44832011)(106356001)(39060400002)(7416002)(25786009)(5250100002)(14454004)(2501003)(105586002)(478600001)(6436002)(55016002)(2900100001)(305945005)(7736002)(8936002)(74316002)(3846002)(6116002)(9686003)(97736004)(81156014)(5660300001)(68736007)(8676002)(2906002)(81166006)(4326008)(66066001)(229853002)(2201001)(6246003)(102836004)(110136005)(11346002)(76176011)(476003)(53936002)(86362001)(486006)(256004)(54906003)(26005)(6506007)(53546011)(575784001)(14444005)(316002)(99286004)(33656002)(55236004)(7696005)(186003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1738;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9thyU3R08KgCgACllAjaxnPb+oBLNjWGYgDgnSZGKXfbXT7Hmv/fm1BM5ayRTJUhmzt2n2FHExUqINuhDq8+AIN4XxCM4DkGx7hexHuZ0PViMS5LCCIpK3eGN7jib97jS05/qjaYE3AHdvDoZlr724qCO+6oTfcN/nZ9st57n99kn6MfCTvE0RQiFu4JElRq9VeUch9MY98d3zT9TFualEMIthn2SSGEkve0/bMmi3Q3/DwYsXFvS1slM5hU374xoMd2oWmINQ/x0IC6rNlDehta28s3tGNJaU776v1FriukQeSuUVslrelEONlnr8cMYqRcNu/rQ668nBLzYkiuQIHyhfnZqGVOswonwbr+iko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc2229c-0a42-4a1f-7d14-08d5e339858f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 12:10:53.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMywgMjAx
OCA4OjEwIFBNDQo+IFRvOiBOaXB1biBHdXB0YSA8bmlwdW4uZ3VwdGFAbnhwLmNvbT47IHdpbGwu
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
bTsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS83
IHY1XSBEb2NzOiBkdDogYWRkIGZzbC1tYyBpb21tdS1tYXAgZGV2aWNlLXRyZWUNCj4gYmluZGlu
Zw0KPiANCj4gT24gMjAvMDUvMTggMTQ6NDksIE5pcHVuIEd1cHRhIHdyb3RlOg0KPiA+IFRoZSBl
eGlzdGluZyBJT01NVSBiaW5kaW5ncyBjYW5ub3QgYmUgdXNlZCB0byBzcGVjaWZ5IHRoZSByZWxh
dGlvbnNoaXANCj4gPiBiZXR3ZWVuIGZzbC1tYyBkZXZpY2VzIGFuZCBJT01NVXMuIFRoaXMgcGF0
Y2ggYWRkcyBhIGdlbmVyaWMgYmluZGluZyBmb3INCj4gPiBtYXBwaW5nIGZzbC1tYyBkZXZpY2Vz
IHRvIElPTU1VcywgdXNpbmcgaW9tbXUtbWFwIHByb3BlcnR5Lg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTmlwdW4gR3VwdGEgPG5pcHVuLmd1cHRhQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9taXNjL2ZzbCxxb3JpcS1tYy50eHQgICAgICB8IDM5DQo+ICsrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21p
c2MvZnNsLHFvcmlxLW1jLnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9taXNjL2ZzbCxxb3JpcS1tYy50eHQNCj4gPiBpbmRleCA2NjExYTdjLi44Y2JlZDRmIDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL2ZzbCxx
b3JpcS1tYy50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bWlzYy9mc2wscW9yaXEtbWMudHh0DQo+ID4gQEAgLTksNiArOSwyNSBAQCBibG9ja3MgdGhhdCBj
YW4gYmUgdXNlZCB0byBjcmVhdGUgZnVuY3Rpb25hbCBoYXJkd2FyZQ0KPiBvYmplY3RzL2Rldmlj
ZXMNCj4gPiAgIHN1Y2ggYXMgbmV0d29yayBpbnRlcmZhY2VzLCBjcnlwdG8gYWNjZWxlcmF0b3Ig
aW5zdGFuY2VzLCBMMiBzd2l0Y2hlcywNCj4gPiAgIGV0Yy4NCj4gPg0KPiA+ICtGb3IgYW4gb3Zl
cnZpZXcgb2YgdGhlIERQQUEyIGFyY2hpdGVjdHVyZSBhbmQgZnNsLW1jIGJ1cyBzZWU6DQo+ID4g
K2RyaXZlcnMvc3RhZ2luZy9mc2wtbWMvUkVBRE1FLnR4dA0KPiANCj4gTml0OiBMb29rcyBsaWtl
IHRoYXQncyBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZHBhYTIvb3ZlcnZpZXcucnN0IG5vdy4N
Cj4gDQo+ID4gKw0KPiA+ICtBcyBkZXNjcmliZWQgaW4gdGhlIGFib3ZlIG92ZXJ2aWV3LCBhbGwg
RFBBQTIgb2JqZWN0cyBpbiBhIERQUkMgc2hhcmUgdGhlDQo+ID4gK3NhbWUgaGFyZHdhcmUgImlz
b2xhdGlvbiBjb250ZXh0IiBhbmQgYSAxMC1iaXQgdmFsdWUgY2FsbGVkIGFuIElDSUQNCj4gPiAr
KGlzb2xhdGlvbiBjb250ZXh0IGlkKSBpcyBleHByZXNzZWQgYnkgdGhlIGhhcmR3YXJlIHRvIGlk
ZW50aWZ5DQo+ID4gK3RoZSByZXF1ZXN0ZXIuDQo+ID4gKw0KPiA+ICtUaGUgZ2VuZXJpYyAnaW9t
bXVzJyBwcm9wZXJ0eSBpcyBpbnN1ZmZpY2llbnQgdG8gZGVzY3JpYmUgdGhlIHJlbGF0aW9uc2hp
cA0KPiA+ICtiZXR3ZWVuIElDSURzIGFuZCBJT01NVXMsIHNvIGFuIGlvbW11LW1hcCBwcm9wZXJ0
eSBpcyB1c2VkIHRvDQo+IGRlZmluZQ0KPiA+ICt0aGUgc2V0IG9mIHBvc3NpYmxlIElDSURzIHVu
ZGVyIGEgcm9vdCBEUFJDIGFuZCBob3cgdGhleSBtYXAgdG8NCj4gPiArYW4gSU9NTVUuDQo+ID4g
Kw0KPiA+ICtGb3IgZ2VuZXJpYyBJT01NVSBiaW5kaW5ncywgc2VlDQo+ID4gK0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9pb21tdS50eHQuDQo+ID4gKw0KPiA+ICtGb3Ig
YXJtLXNtbXUgYmluZGluZywgc2VlOg0KPiA+ICtEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaW9tbXUvYXJtLHNtbXUudHh0Lg0KPiA+ICsNCj4gPiAgIFJlcXVpcmVkIHByb3BlcnRp
ZXM6DQo+ID4NCj4gPiAgICAgICAtIGNvbXBhdGlibGUNCj4gPiBAQCAtODgsMTQgKzEwNywzNCBA
QCBTdWItbm9kZXM6DQo+ID4gICAgICAgICAgICAgICAgIFZhbHVlIHR5cGU6IDxwaGFuZGxlPg0K
PiA+ICAgICAgICAgICAgICAgICBEZWZpbml0aW9uOiBTcGVjaWZpZXMgdGhlIHBoYW5kbGUgdG8g
dGhlIFBIWSBkZXZpY2Ugbm9kZSBhc3NvY2lhdGVkDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHdpdGggdGhlIHRoaXMgZHBtYWMuDQo+ID4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+
ID4gKw0KPiA+ICstIGlvbW11LW1hcDogTWFwcyBhbiBJQ0lEIHRvIGFuIElPTU1VIGFuZCBhc3Nv
Y2lhdGVkIGlvbW11LQ0KPiBzcGVjaWZpZXINCj4gPiArICBkYXRhLg0KPiA+ICsNCj4gPiArICBU
aGUgcHJvcGVydHkgaXMgYW4gYXJiaXRyYXJ5IG51bWJlciBvZiB0dXBsZXMgb2YNCj4gPiArICAo
aWNpZC1iYXNlLGlvbW11LGlvbW11LWJhc2UsbGVuZ3RoKS4NCj4gPiArDQo+ID4gKyAgQW55IElD
SUQgaSBpbiB0aGUgaW50ZXJ2YWwgW2ljaWQtYmFzZSwgaWNpZC1iYXNlICsgbGVuZ3RoKSBpcw0K
PiA+ICsgIGFzc29jaWF0ZWQgd2l0aCB0aGUgbGlzdGVkIElPTU1VLCB3aXRoIHRoZSBpb21tdS1z
cGVjaWZpZXINCj4gPiArICAoaSAtIGljaWQtYmFzZSArIGlvbW11LWJhc2UpLg0KPiA+DQo+ID4g
ICBFeGFtcGxlOg0KPiA+DQo+ID4gKyAgICAgICAgc21tdTogaW9tbXVANTAwMDAwMCB7DQo+ID4g
KyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLG1tdS01MDAiOw0KPiA+ICsgICAgICAg
ICAgICAgICAjaW9tbXUtY2VsbHMgPSA8Mj47DQo+IA0KPiBUaGlzIHNob3VsZCBiZSAxIGlmIHN0
cmVhbS1tYXRjaC1tYXNrIGlzIHByZXNlbnQuIEJhZCBleGFtcGxlIGlzIGJhZCA6KQ0KDQpBZ3Jl
ZSA6KS4gSWxsIHVwZGF0ZSBpdC4NCg0KPiANCj4gUm9iaW4uDQo+IA0KPiA+ICsgICAgICAgICAg
ICAgICBzdHJlYW0tbWF0Y2gtbWFzayA9IDwweDdDMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAu
Li4NCj4gPiArICAgICAgICB9Ow0KPiA+ICsNCj4gPiAgICAgICAgICAgZnNsX21jOiBmc2wtbWNA
ODBjMDAwMDAwIHsNCj4gPiAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxxb3Jp
cS1tYyI7DQo+ID4gICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MDAwMDAwMDggMHgwYzAwMDAw
MCAwIDB4NDA+LCAgICAvKiBNQyBwb3J0YWwgYmFzZSAqLw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIDwweDAwMDAwMDAwIDB4MDgzNDAwMDAgMCAweDQwMDAwPjsgLyogTUMgY29udHJvbCBy
ZWcgKi8NCj4gPiAgICAgICAgICAgICAgICAgICBtc2ktcGFyZW50ID0gPCZpdHM+Ow0KPiA+ICsg
ICAgICAgICAgICAgICAgLyogZGVmaW5lIG1hcCBmb3IgSUNJRHMgMjMtNjQgKi8NCj4gPiArICAg
ICAgICAgICAgICAgIGlvbW11LW1hcCA9IDwyMyAmc21tdSAyMyA0MT47DQo+ID4gICAgICAgICAg
ICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQo+ID4gICAgICAgICAgICAgICAgICAgI3Np
emUtY2VsbHMgPSA8MT47DQo+ID4NCj4gPg0K
