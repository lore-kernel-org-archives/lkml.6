Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13916C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5634218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FMsZTVuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbfAaKpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:45:35 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:8953 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:45:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="25978570"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 03:45:33 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 03:45:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hj0BgrA4fZ0HvSGLRKiGCOQm50KqFxVBsey0UHH5nsY=;
 b=FMsZTVuops8wa8kwgmCTNUtYSkDdR0nu4/7aJPEOyum8fUEHVpRkO1AOS9Y4D2Y/SZeg1ckLVHwA1Fd/PEXE4lgaO5q/T5bd9sMZ8YvP4pLa2YMqYUK7mTICvxEL7yNuwEsHN8nfKc7LyRZnQ3FXFY56uXh833Y9wCmDvH8Ay7w=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1556.namprd11.prod.outlook.com (10.172.22.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 10:45:31 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 10:45:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <Nicolas.Ferre@microchip.com>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Topic: [PATCH 8/9] dt-bindings: spi: atmel-quadspi: QuadSPI driver for
 Microchip SAM9X60
Thread-Index: AQHUuK2xf3u2KPfoDkGm5485KIOYJ6XIEYeAgAEhPwA=
Date:   Thu, 31 Jan 2019 10:45:31 +0000
Message-ID: <8e2e61fe-e0a6-b84a-643a-a29c18b5861f@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
 <20190130150818.24902-9-tudor.ambarus@microchip.com>
 <20190130182958.528e5ac0@bbrezillon>
In-Reply-To: <20190130182958.528e5ac0@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:28::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1556;6:+ALk6UGCwm6ovYBqTPZtN1XoRITadVmYoFPf+D0XnVmSyoqAfPf7MYNV2QU340zGfGOWuxe8Avhtgxfa7iMVUiQiXkRTwTxsoMtfYjB2CXLAHIYj8MWm+iCa56d2vTcatcKzznaloMoW29VpL44I9ZtkpxX8N5t0uLffxDtW2E6oJKBitMa7X9L7uceB/PX0lv4lembhfCL3MGZMbqwBOdQszn1Ng8ZtoMrxOx3d2W5oPgwxH0L8ALXe7h/3h45jdMycIOT1ipPXnDbbUjNYiz0JU7tqDaIB0fTU9jpD27uPtYDF0bwMo9FsFJg9nKVQjX+iauoXdY/9Bi8mnH/Aj3keFS+FcVYpuZWvRVxXLb63DK3kgYrgYwfoJUFy0cJZt03DkhCNNpU3p5N36P5a+ebv9Z1Ktigji87JMmyRUa5mjuMZzi2iFLWJG92jse0KDlYCbFWLQxmSycijzoU5Bw==;5:oR8X6f6Ks1rP0FLHpifTvOHS/a0coJ/6gCw2Ll0qnVkoIOTTa9YMc6u+GuFfn+GabrU/pBdC8rihjSafhZOvATScJPeMVVJzDwfoFiZaBvtlTWYRpD+umpUHohmeqWqw8xvunYq/GjxKqCpuO1W38V0VSg0adORwNLCQmC+ojF1w5w8ybYbx/znDIzMjpkowiUjHPH7MrEFQNzu2iIE99w==;7:CjGeu4e9N0qkzmAhPWSTS2EIyiS9FkI6JCg6IgCMi7104O+OHeQB+4xaTab1cAd0P3d9BMmBM/+nJwFQ13PgVfiJNjIjvA5IFYsaU95dbDK6OtXnikKLMoCAeVoNtv6ucFG0+8aAq1ocofKWga9eaw==
x-ms-office365-filtering-correlation-id: 70966c54-e7c3-4252-f4c6-08d6876938ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1556;
x-ms-traffictypediagnostic: BN6PR11MB1556:
x-microsoft-antispam-prvs: <BN6PR11MB15568FC079D6BCD71C3C30B7F0910@BN6PR11MB1556.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(54906003)(86362001)(105586002)(31696002)(6486002)(102836004)(316002)(66066001)(52116002)(229853002)(99286004)(53546011)(72206003)(6436002)(2906002)(14454004)(6116002)(478600001)(3846002)(106356001)(4326008)(76176011)(25786009)(53936002)(6246003)(36756003)(386003)(6512007)(6506007)(8936002)(81156014)(7736002)(8676002)(476003)(446003)(305945005)(11346002)(2616005)(14444005)(68736007)(71200400001)(26005)(256004)(31686004)(486006)(71190400001)(6916009)(186003)(97736004)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1556;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vZ4xJidGxkHXY1qfnizA3xk0hMqDt3pQa3tQ77iYMoHQPewQ+JpnPNOzJM5jWg2JW9oJS+AV9u/zZO1hJF/mrnr20Kj9bIi1BEsRzwe2qnX6mcz5jR1QpvOMea+oADvcTiDU+eXubqRmAqQ+uJWDuTWIzafRK4gQRF5rLP8UjIEYScm6R0agu+iQOQVPUNtNnCVBGlfn/fEjKlnD6eG386iFf2fiKCOWuNormUMRaxHKKRHGN/IndCXMPsYIbHk6IJBg6BHV0nwhHhVjkwr1wE9i3aXM9Po6rgx9ghb/lMrME1a6tuv+b7cEKa+VgX+Kfg7X0pllqXrZBjNfyajqm+4PXg2piRgKWfLHKw2n6FPlBXO4lviWYZGzvn1BxD+lP1wT3vw9ZzsBlEqNCPdpfAcNIkHum7/yg7rnksGkTCw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00EF13784384DA45B49B0AA7E9E17990@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70966c54-e7c3-4252-f4c6-08d6876938ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:45:27.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1556
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzMwLzIwMTkgMDc6MzAgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
V2VkLCAzMCBKYW4gMjAxOSAxNTowODo0NSArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVz
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhlIHNhbTl4NjAgcXNwaSBjb250cm9sbGVyIHVzZXMg
MiBjbG9ja3MsIG9uZSBmb3IgdGhlIHBlcmlwaGVyYWwgcmVnaXN0ZXINCj4+IGFjY2VzcywgdGhl
IG90aGVyIGZvciB0aGUgcXNwaSBjb3JlIGFuZCBwaHkuIEJvdGggYXJlIG1hbmRhdG9yeS4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb20+DQo+PiAtLS0NCj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwtcXVh
ZHNwaS50eHQgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrLS0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbC1xdWFkc3BpLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvYXRtZWwtcXVhZHNwaS50
eHQNCj4+IGluZGV4IGU5ZGFlNjI2NGQ4OS4uZTdiN2YyOTdjNWQ3IDEwMDY0NA0KPj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbC1xdWFkc3BpLnR4dA0K
Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbC1xdWFk
c3BpLnR4dA0KPj4gQEAgLTEsMTQgKzEsMjIgQEANCj4+ICAqIEF0bWVsIFF1YWQgU2VyaWFsIFBl
cmlwaGVyYWwgSW50ZXJmYWNlIChRU1BJKQ0KPj4gIA0KPj4gIFJlcXVpcmVkIHByb3BlcnRpZXM6
DQo+PiAtLSBjb21wYXRpYmxlOiAgICAgU2hvdWxkIGJlICJhdG1lbCxzYW1hNWQyLXFzcGkiLg0K
Pj4gKy0gY29tcGF0aWJsZTogICAgIFNob3VsZCBiZSBvbmUgb2YgdGhlIGZvbGxvd2luZw0KPj4g
KwkJICAtICJhdG1lbCxzYW1hNWQyLXFzcGkiDQo+PiArCQkgIC0gIm1pY3JvY2hpcCxzYW05eDYw
LXFzcGkiDQo+PiAgLSByZWc6ICAgICAgICAgICAgU2hvdWxkIGNvbnRhaW4gdGhlIGxvY2F0aW9u
cyBhbmQgbGVuZ3RocyBvZiB0aGUgYmFzZSByZWdpc3RlcnMNCj4+ICAgICAgICAgICAgICAgICAg
ICBhbmQgdGhlIG1hcHBlZCBtZW1vcnkuDQo+PiAgLSByZWctbmFtZXM6ICAgICAgU2hvdWxkIGNv
bnRhaW4gdGhlIHJlc291cmNlIHJlZyBuYW1lczoNCj4+ICAgICAgICAgICAgICAgICAgICAtIHFz
cGlfYmFzZTogY29uZmlndXJhdGlvbiByZWdpc3RlciBhZGRyZXNzIHNwYWNlDQo+PiAgICAgICAg
ICAgICAgICAgICAgLSBxc3BpX21tYXA6IG1lbW9yeSBtYXBwZWQgYWRkcmVzcyBzcGFjZQ0KPj4g
IC0gaW50ZXJydXB0czogICAgIFNob3VsZCBjb250YWluIHRoZSBpbnRlcnJ1cHQgZm9yIHRoZSBk
ZXZpY2UuDQo+PiAtLSBjbG9ja3M6ICAgICAgICAgVGhlIHBoYW5kbGUgb2YgdGhlIGNsb2NrIG5l
ZWRlZCBieSB0aGUgUVNQSSBjb250cm9sbGVyLg0KPj4gKy0gY2xvY2tzOgkgIC0gImF0bWVsLHNh
bWE1ZDItcXNwaSI6IHRoZSBwaGFuZGxlIG9mIHRoZSBjbG9jayBuZWVkZWQgYnkgdGhlDQo+PiAr
CQkgIFFTUEkgY29udHJvbGxlci4NCj4+ICsJCSAgLSAibWljcm9jaGlwLHNhbTl4NjAtcXNwaSI6
IHNob3VsZCByZWZlcmVuY2UgdGhlIHBlcmlwaGVyYWwNCj4+ICsJCSAgYW5kIHN5c3RlbSBRU1BJ
IGNsb2Nrcy4NCj4+ICstIGNsb2NrLW5hbWVzOiAgICBPbmx5IGZvciBzYW05eDYwIC0gc2hvdWxk
IGNvbnRhaW4gdHdvIHN0cmlnczoNCj4gDQo+IAkJCQkJCQkgICBec3RyaW5ncw0KPiANCj4gQW5k
IEkgdGhpbmsgbmFtaW5nIGNsb2NrcyBldmVuIGZvciBzYW1hNWQyIGlzIGEgZ29vZCBwcmFjdGlj
ZSwgc28gSSdkDQo+IHN1Z2dlc3QgbWFraW5nICJwY2xrIiBtYW5kYXRvcnkgZXZlbiBpZiB5b3Ug
c3VwcG9ydCB1bm5hbWVkIGNsayBpbiB0aGUNCj4gZHJpdmVyIHRvIGJlIGJhY2t3YXJkIGNvbXBh
dGlibGUgd2l0aCBvbGQgRFRzLg0KDQphZ3JlZWQNCg0KPiANCj4+ICsJCSAgLSAicGNsayIgZm9y
IHRoZSBwZXJpcGhlcmFsIGNsb2NrDQo+PiArCQkgIC0gInFzcGljayIgZm9yIHRoZSBzeXN0ZW0g
Y2xvY2sNCj4+ICAtICNhZGRyZXNzLWNlbGxzOiBTaG91bGQgYmUgPDE+Lg0KPj4gIC0gI3NpemUt
Y2VsbHM6ICAgIFNob3VsZCBiZSA8MD4uDQo+PiAgDQo+PiBAQCAtMjksMyArMzcsMTkgQEAgc3Bp
QGYwMDIwMDAwIHsNCj4+ICAJCS4uLg0KPj4gIAl9Ow0KPj4gIH07DQo+PiArDQo+PiArcXNwaUBm
MDAxNDAwMCB7DQo+PiArCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtcXNwaSI7DQo+
PiArCXJlZyA9IDwweGYwMDE0MDAwIDB4MTAwPiwgPDB4NzAwMDAwMDAgMHgwODAwMDAwMD47DQo+
PiArCXJlZy1uYW1lcyA9ICJxc3BpX2Jhc2UiLCAicXNwaV9tbWFwIjsNCj4+ICsJaW50ZXJydXB0
cyA9IDwzNSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPj4gKwljbG9ja3MgPSAgPCZwbWMgUE1D
X1RZUEVfUEVSSVBIRVJBTCAzNT4sIDwmcG1jIFBNQ19UWVBFX1NZU1RFTSAxOT47DQo+PiArCWNs
b2NrLW5hbWVzID0gInBjbGsiLCAicXNwaWNrIjsNCj4+ICsJI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+PiArCSNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQi
Ow0KPj4gKw0KPj4gKwlmbGFzaEAwIHsNCj4+ICsJCS4uLg0KPj4gKwl9Ow0KPj4gK307DQo+IA0K
PiBObyBuZWVkIHRvIGFkZCBvbmUgZXhhbXBsZSBwZXIgY29tcGF0LCBlc3BlY2lhbGx5IHdoZW4g
YWxsIHRoYXQNCj4gY2hhbmdlcyBpcyB0aGUgY29tcGF0IHN0cmluZyBhbmQgYW4gZXh0cmEgY2xr
LiANCg0Kb2ssIHRoYW5rcyENCnRhDQo=
