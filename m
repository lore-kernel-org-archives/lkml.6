Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44945C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCCA216F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H4uXdmJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDCCA216F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeHHIq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:46:26 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:11008
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726756AbeHHIq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOhpmQ12VDInZh7yrmTIfRXgipzi12KEjGMCz+O9jV8=;
 b=H4uXdmJkztNuRe1RKZjkjJX5nKcAxsCF+/KQJfHkWGP31+2nmvcMIvBr+xb8RnF/yH/9ht+TPQAFNAQ5EIeyDlkFwRbynxn1jSTDjgrxwAbIv0z9kunaOgkY19472Sj9gcgOd37LvSLq0Yet/UVWb028x9dYzRjQXt+IZ48FDCg=
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com (10.169.245.8) by
 AM5PR0401MB2564.eurprd04.prod.outlook.com (10.169.245.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Wed, 8 Aug 2018 06:28:09 +0000
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93]) by AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::a2:591f:fe8f:7c93%3]) with mapi id 15.20.1038.019; Wed, 8 Aug 2018
 06:28:09 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Scott Wood <oss@buserror.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "joe@perches.com" <joe@perches.com>
Subject: RE: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Thread-Topic: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Thread-Index: AQHUJY+OEK4rmRCzmU6sElTr8iVLCqS02/0AgABrfQCAACZCgIAAAdDg
Date:   Wed, 8 Aug 2018 06:28:09 +0000
Message-ID: <AM5PR0401MB2545041D99EEDC3136B201719A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
         <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
         <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <aeff83355ee5235cfd6107dba06a5f7957b45c92.camel@buserror.net>
In-Reply-To: <aeff83355ee5235cfd6107dba06a5f7957b45c92.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2564;6:mGfXW8WNEnKHAnzIMJnS99Wpw13Xldur05OQNMAbo1U6Mw5ygtQW7gK816e7hiZuSv0620nWTF9AfKz8iLlBsYLudyVz3owEmVRsBp7FBsSz7L2frTwSUlLNxlBqz7H5vzXYIZiHdZuqLOThUBAGyr+54WOpNY9l4DNbpMorT7Dwx1pzc4AScXSKdLCxjbnW+LxNtUJXrCCDPeaVIoV3p5UKGgdCnbr5ei8RUb6iGNd4on09prH8JxezJ+JTlgAotj2xnoJaQHFi2wLxpMndXfU4djkMYMGgjzp7esc5Ai94MSKUMEacafp0M50/t1A1AlvWnYIdDNnFbgMYtXxL6Bwl4upyAPtK1lhq3v72bHyA2XZYL1Qo4fbU16VBYclpLaYvqZdRByeJRrrdzq2yU/QDlLBUdvkd3WDRrgIyPq2jYqaLAnvkIhyHWJPEqtS6KUNEpa3VwA70CpnQBeJVAQ==;5:9t0ik9shUqouq5oFvf6XXwW4CAcpNkCZCsYPeGgtsjBIzDreyO3HdesGGi7VPocCEhir268ZUm3LQaW7788SUdRGhy2ldqzB16ibnIqsP8EDEfStgTIrHlvbnkJfBRzJYhV5OSmj8colsNh8cv2UR7XyNaf/BmFcZcmH7wZFz1s=;7:IvJTGRkUJld9ikfn1gx6ZeSZ/rD9qpFAFJF8gzyMVEwNzQLv388xacUjZQdZ2OHhOo4kxh0g65wFaDHp3q8IsZ5v2fO6bCOFO9poYRpC9QCQmxFQNo+7CUUQxw+2T6IkIsZV5IBovb7Dxpv1QUsBrVQ7+ZFtjIZa1LaX+OcqBHMh4dpx/Lgr0bhm8qRiH0r1g72HuUwPXTKhwb6Aua0X4JSBjPGqbx3vrufDn1+V+Y1aUJPfn815C1fNs14niJOS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 531a8690-bff9-42a0-e24e-08d5fcf81c20
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2564;
x-ms-traffictypediagnostic: AM5PR0401MB2564:
x-microsoft-antispam-prvs: <AM5PR0401MB256447BBA25AFDD13E92FAB99A260@AM5PR0401MB2564.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2564;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2564;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(13464003)(189003)(199004)(68736007)(316002)(6506007)(6246003)(53546011)(8936002)(110136005)(54906003)(9686003)(7696005)(102836004)(55016002)(305945005)(74316002)(25786009)(7736002)(76176011)(53936002)(8676002)(4326008)(6436002)(26005)(229853002)(81166006)(81156014)(14454004)(478600001)(99286004)(186003)(93886005)(97736004)(256004)(66066001)(2906002)(105586002)(106356001)(7416002)(2201001)(44832011)(86362001)(2501003)(11346002)(446003)(476003)(5250100002)(486006)(33656002)(2900100001)(6116002)(3846002)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2564;H:AM5PR0401MB2545.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e4Rs/bgaGicN8deduFTKXM0ooGgG8erNIEJ0+7xGX6B1v2nl6nieJh2U7i/yczsBJIdUM6X/ybgxW+cR+0pTQY+MKY/QGqjE9w938grfGE7OWCrOZujQ2YXJ/rJrBy7/eume6wAcRMWwp8NE0JM+pnQJxzbzLonwS+13Zh9waYNjbeNxmj/EKbAbqSIpTr1IH51bFYOH4UZV+1eAZ0PRQvP8bcTSSvj/UI81fm7OFAlXcyl7HClDh8hC6VSzEIFYLFeVZCaISER5ia3cUhQkS0GydKCf2ZPIROd5p7GyN6FwFp9JuKellQ8EoiF9ZGUGF+Rc80M/WB+54bb7r98HRxPbIpjL0DY9NsMvknGLTOA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531a8690-bff9-42a0-e24e-08d5fcf81c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 06:28:09.5798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTgg
MTE6MjYgQU0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPjsN
Cj4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBtcGVAZWxsZXJt
YW4uaWQuYXU7DQo+IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IG1hcmsucnV0bGFuZEBhcm0u
Y29tOw0KPiBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0
cy5vemxhYnMub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogcm9i
aEBrZXJuZWwub3JnOyBrZWVzY29va0BjaHJvbWl1bS5vcmc7IHR5cmVsZEBsaW51eC52bmV0Lmli
bS5jb207DQo+IGpvZUBwZXJjaGVzLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyA1LzVdIHBvd2Vy
cGMvZnNsOiBBZGQgc3VwcG9ydGVkLWlycS1yYW5nZXMgZm9yIFAyMDIwDQo+IA0KPiBPbiBXZWQs
IDIwMTgtMDgtMDggYXQgMDM6NDQgKzAwMDAsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFNjb3R0IFdvb2QgW21haWx0
bzpvc3NAYnVzZXJyb3IubmV0XQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgOCwgMjAx
OCAyOjQ0IEFNDQo+ID4gPiBUbzogQmhhcmF0IEJodXNoYW4gPGJoYXJhdC5iaHVzaGFuQG54cC5j
b20+Ow0KPiA+ID4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBt
cGVAZWxsZXJtYW4uaWQuYXU7DQo+ID4gPiBnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnOyBtYXJr
LnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC0NCj4gPiA+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IENjOiByb2JoQGtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9t
aXVtLm9yZzsNCj4gPiA+IHR5cmVsZEBsaW51eC52bmV0LmlibS5jb207IGpvZUBwZXJjaGVzLmNv
bQ0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgNS81XSBwb3dlcnBjL2ZzbDogQWRkIHN1cHBvcnRl
ZC1pcnEtcmFuZ2VzIGZvcg0KPiA+ID4gUDIwMjANCj4gPiA+DQo+ID4gPiBPbiBGcmksIDIwMTgt
MDctMjcgYXQgMTU6MTggKzA1MzAsIEJoYXJhdCBCaHVzaGFuIHdyb3RlOg0KPiA+ID4gPiBNUElD
IG9uIE5YUCAoRnJlZXNjYWxlKSBQMjAyMCBzdXBwb3J0cyBmb2xsb3dpbmcgaXJxDQo+ID4gPiA+
IHJhbmdlczoNCj4gPiA+ID4gICA+IDAgLSAxMSAgICAgIChFeHRlcm5hbCBpbnRlcnJ1cHQpDQo+
ID4gPiA+ICAgPiAxNiAtIDc5ICAgICAoSW50ZXJuYWwgaW50ZXJydXB0KQ0KPiA+ID4gPiAgID4g
MTc2IC0gMTgzICAgKE1lc3NhZ2luZyBpbnRlcnJ1cHQpDQo+ID4gPiA+ICAgPiAyMjQgLSAyMzEg
ICAoU2hhcmVkIG1lc3NhZ2Ugc2lnbmFsZWQgaW50ZXJydXB0KQ0KPiA+ID4NCj4gPiA+IFdoeSBk
b24ndCB5b3UgY29udmVydCB0byB0aGUgNC1jZWxsIGludGVycnVwdCBzcGVjaWZpZXJzIHRoYXQg
bWFrZQ0KPiA+ID4gZGVhbGluZyB3aXRoIHRoZXNlIHJhbmdlcyBsZXNzIGVycm9yLXByb25lPw0K
PiA+DQo+ID4gT2sgLCB3aWxsIGRvIGlmIHdlIGFncmVlIHRvIGhhdmUgdGhpcyBzZXJpZXMgYXMg
cGVyIGNvbW1lbnQgb24gb3RoZXIgcGF0Y2guDQo+IA0KPiBJZiB5b3UncmUgY29uY2VybmVkIHdp
dGggZXJyb3JzLCB0aGlzIHdvdWxkIGJlIGEgZ29vZCB0aGluZ3MgdG8gZG8gcmVnYXJkbGVzcy4N
Cj4gIEFjdHVhbGx5LCBpdCBzZWVtcyB0aGF0IHAyMDIwc2ktcG9zdC5kdHNpIGFscmVhZHkgdXNl
cyA0LWNlbGwgaW50ZXJydXB0cy4NCj4gDQo+IFdoYXQgaXMgbW90aXZhdGluZyB0aGlzIHBhdGNo
c2V0PyAgSXMgdGhlcmUgc29tZXRoaW5nIHdyb25nIGluIHRoZSBleGlzdGluZw0KPiBkdHMgZmls
ZXM/DQoNClRoZXJlIGlzIG5vIGVycm9yIGluIGRldmljZSB0cmVlLiBNYWluIG1vdGl2YXRpb24g
aXMgdG8gaW1wcm92ZSBjb2RlIGZvciBmb2xsb3dpbmcgcmVhc29uczogDQogIC0gV2hpbGUgY29k
ZSBzdHVkeSBpdCB3YXMgZm91bmQgdGhhdCBpZiBhIHJlc2VydmVkIGlycS1udW1iZXIgdXNlZCB0
aGVuIHRoZXJlIGFyZSBubyBjaGVjayBpbiBkcml2ZXIuIGlycSB3aWxsIGJlIGNvbmZpZ3VyZWQg
YXMgY29ycmVjdCBhbmQgaW50ZXJydXB0IHdpbGwgbmV2ZXIgZmlyZS4NCiAtIFdhcm5pbmdzIHdl
cmUgb2JzZXJ2ZWQgb24gZGV2ZWxvcG1lbnQgcGxhdGZvcm0gKHNpbXVsYXRvcikgd2hlbiByZWFk
L3dyaXRlIHRvIHJlc2VydmVkIE1QSUMgcmVhc29uIGR1cmluZyBpbml0Lg0KICANCj4gDQo+IA0K
PiA+DQo+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84
NXh4L21wYzg1eHhfcmRiLmMNCj4gPiA+ID4gYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgv
bXBjODV4eF9yZGIuYw0KPiA+ID4gPiBpbmRleCAxMDA2OTUwLi40OWZmMzQ4IDEwMDY0NA0KPiA+
ID4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvbXBjODV4eF9yZGIuYw0KPiA+
ID4gPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvbXBjODV4eF9yZGIuYw0KPiA+
ID4gPiBAQCAtNTcsNiArNTcsMTEgQEAgdm9pZCBfX2luaXQgbXBjODV4eF9yZGJfcGljX2luaXQo
dm9pZCkNCj4gPiA+ID4gIAkJCU1QSUNfQklHX0VORElBTiB8DQo+ID4gPiA+ICAJCQlNUElDX1NJ
TkdMRV9ERVNUX0NQVSwNCj4gPiA+ID4gIAkJCTAsIDI1NiwgIiBPcGVuUElDICAiKTsNCj4gPiA+
ID4gKwl9IGVsc2UgaWYgKG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgiZnNsLFAyMDIwUkRCLVBD
IikpIHsNCj4gPiA+ID4gKwkJbXBpYyA9IG1waWNfYWxsb2MoTlVMTCwgMCwNCj4gPiA+ID4gKwkJ
ICBNUElDX0JJR19FTkRJQU4gfA0KPiA+ID4gPiArCQkgIE1QSUNfU0lOR0xFX0RFU1RfQ1BVLA0K
PiA+ID4gPiArCQkgIDAsIDAsICIgT3BlblBJQyAgIik7DQo+ID4gPiA+ICAJfSBlbHNlIHsNCj4g
PiA+ID4gIAkJbXBpYyA9IG1waWNfYWxsb2MoTlVMTCwgMCwNCj4gPiA+ID4gIAkJICBNUElDX0JJ
R19FTkRJQU4gfA0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsgd2Ugd2FudCB0byBncm93IGEg
bGlzdCBvZiBldmVyeSBzaW5nbGUgcmV2aXNpb24gb2YNCj4gPiA+IGV2ZXJ5IGJvYXJkIGluIHRo
ZXNlIHBsYXRmb3JtIGZpbGVzLg0KPiA+DQo+ID4gT25lIG90aGVyIGNvbmZ1c2luZyBvYnNlcnZh
dGlvbiBJIGhhdmUgaXMgdGhhdCAiaXJxX2NvdW50IiBmcm9tDQo+ID4gcGxhdGZvcm0gY29kZSBp
cyBnaXZlbiBwcmVjZWRlbmNlIG92ZXIgImxhc3QtaW50ZXJydXB0LXNvdXJjZSIgaW4gZGV2aWNl
LQ0KPiB0cmVlLg0KPiA+IFNob3VsZCBub3QgZGV2aWNlLXRyZWUgc2hvdWxkIGhhdmUgcHJlY2Vk
ZW5jZSBvdGhlcndpc2UgdGhlcmUgaXMgbm8NCj4gPiBwb2ludCB1c2luZyAiIGxhc3QtaW50ZXJy
dXB0LXNvdXJjZSIgaWYgcGxhdGZvcm0gY29kZSBwYXNzZXMNCj4gPiAiaXJxX2NvdW50IiBpbiBt
cGljX2FsbG9jKCkuDQo+IA0KPiBNYXliZSwgdGhvdWdoIEkgZG9uJ3QgdGhpbmsgaXQgbWF0dGVy
cyBtdWNoIGdpdmVuIHRoYXQgbGFzdC1pbnRlcnJ1cHQtc291cmNlDQo+IHdhcyBvbmx5IGFkZGVk
IHRvIGF2b2lkIGhhdmluZyB0byBwYXNzIGlycV9jb3VudCBpbiBwbGF0Zm9ybSBjb2RlLg0KDQpU
aGFua3MgZm9yIGNsYXJpZnlpbmc7DQoNCk15IHVuZGVyc3RhbmRpbmcgd2FzIHRoYXQgImxhc3Qt
aW50ZXJydXB0LXNvdXJjZSIgYWRkZWQgdG8gZW5zdXJlIHRoYXQgd2UgY2FuIG92ZXItcmlkZSB2
YWx1ZSBwYXNzZWQgZnJvbSBwbGF0Zm9ybSBjb2RlLiBJbiB0aGF0IGNhc2Ugd2UgZG8gbm90IG5l
ZWQgdG8gY2hhbmdlIGNvZGUgYW5kIGNhbiBjb250cm9sIGZyb20gZGV2aWNlIHRyZWUuDQoNClRo
YW5rcw0KLUJoYXJhdA0KDQoNCj4gDQo+IC1TY290dA0KDQo=
