Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B676FC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0082087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YJAJpd5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfA3IQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:16:00 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:9601 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfA3IQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:16:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="23195961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2019 01:15:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 30 Jan 2019 01:15:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0MdGx6eE7i7EF33fMVlXo8bS05mUuzAD+ypGACfpR0=;
 b=YJAJpd5Wgs/W1aloOAvKBVlm0X3kHKb5vJ1O+ng9g6UPEYtjs8gytC0e9N0mVGqyCaGKXioGD841G+1Lc4W47q8pGeRS0CmApGHJ5OyYHGxWS1QOfhbXaOvmD/1dbsXqasRLwTtYyNOjj/iMnQ16UnfCwdI358IPibwmStZ8pwQ=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1710.namprd11.prod.outlook.com (10.169.235.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 08:15:56 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 08:15:56 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <jonas@norrbonn.se>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v5 2/2] spi-atmel: support inter-word delay
Thread-Topic: [PATCH v5 2/2] spi-atmel: support inter-word delay
Thread-Index: AQHUuHQGaWNnRm8n8EiXbk47TGR6ew==
Date:   Wed, 30 Jan 2019 08:15:56 +0000
Message-ID: <78389342-af93-b233-e12e-5f6945bcb154@microchip.com>
References: <20190129205502.7741-1-jonas@norrbonn.se>
 <20190129205502.7741-3-jonas@norrbonn.se>
In-Reply-To: <20190129205502.7741-3-jonas@norrbonn.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:59::19) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1710;6:RDWu52H4xWWIhBZeyeSqduuRqwgmUqt58n4g9zDR1uF9a/7zPaGLi7OA/rvvPZ5oSSf5qE8o2uEgJV4UAv7gWC2CSqyjtvlBAKIgSTuwoyK0EXkqEDxExPDtA32IcO35ezUYq83Xx4HaOXeCggQJFjHa9di6+HI4MQRhhVyDcNUE0GcXsuXqABwJOdWjP+vtdrz90N+F9TlPbk5BiTkZukAjrKpzz3zm8K88yMWp4Wn6tZUyI+QznRcYZktS70ngy5MpYfIipv6wnmbPaboJh2fYO5c13Pfv+veT7WiHEKgMGzR2HBGnMrpLQz4qr4S0U9NdqeqH2dI+5SFiWRbEdfGPU9yetc8N6/7r+6jXagdvh7i3LmMtXEyS0Xx69Em1GSbEpgU3IsgvJlXH1/ITNftPk21lgqTJ68hV0sPVM1mdCh/LuPIHp/c7C3oOvBMlaQvCuYrGvTvsJPCUHlkNDQ==;5:DvBZcnUX6FASagpzZUB/GhSIxlaf0dEdH5muTpROBHZR4ydzY8/YtFVjvm2uWgcOLJMCRgnbweUMeAAJkDm1iQIqj+URknHK/JR8SO03cRCrTw4vksFidV59XyuuioupxoA1botrIfu/7VyTNduAp/fHGFb9x5RmDQ5cLKNQsjLl/M4TsBIFVdit+Q3s/Mui050C/6pTFFYdLzrKlhGXHA==;7:uB7s8SArN8xEg/Sjc6SFyx2N/jtA2wIeQ6epeJnvbw/79q+DI24mM9frhBD1nfhe2G4+1xj49BqSLZkbrriXazOK0P7W6/Ol9UudtxT1y2K6hOiXYaJUWeyGVjlihGVlNdKI8lv9PTkz8uSueKyEOA==
x-ms-office365-filtering-correlation-id: 95f7479f-a296-4d56-7919-08d6868b28b3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1710;
x-ms-traffictypediagnostic: MWHPR11MB1710:
x-microsoft-antispam-prvs: <MWHPR11MB1710E3EB98FF425019D1395AE0900@MWHPR11MB1710.namprd11.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8936002)(25786009)(81166006)(66066001)(53546011)(2616005)(86362001)(446003)(52116002)(76176011)(99286004)(476003)(26005)(11346002)(31696002)(186003)(486006)(8676002)(81156014)(256004)(97736004)(3846002)(6116002)(6486002)(316002)(4326008)(2906002)(6436002)(107886003)(6246003)(6506007)(386003)(6512007)(53936002)(305945005)(14454004)(229853002)(478600001)(68736007)(110136005)(7736002)(36756003)(102836004)(2501003)(72206003)(71200400001)(106356001)(71190400001)(105586002)(31686004)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1710;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h044vT8mpcomI5nsVndkQZ3NeYciulR0N5AHetp3qwcj+uyGZiH+6LkNBLd/RIXUxF+c4ATN5uDiRqotfPALQ3+jy2MYdglr+I27A0iywW3gK8e6GxpUo0tjhkBEx/NttlwHFHqorN0FQDlbLa8BBjaElNVUljTwJXbPofF1hCkDlbWg5NdIEIXH0Mr2rvdFjevG7FZEojqdLHos6L+HEb+ROA2bdeQf3/r2dt5fouN8tOJzoeoOlMeqqAzZ/fCTalsQ3cvKx8DxsZnvxE1WHBi3iWHJSstrTcziYTBnEqqtgIF74R7VR/b44hN6Sy+LGG2FwzXdPLACMHHathOz6L1x8tFbfZV1CgpbfTwupo60CfEzJHB3WrzO2JaIiIu2D+Bs6eMBVC17qxD+XZTUqH6U+NE5razWK032Rjerbnk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC46FB6882A4F040AF9276E15F98AE91@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f7479f-a296-4d56-7919-08d6868b28b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 08:15:53.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1710
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDEvMjAxOSBhdCAyMTo1NSwgSm9uYXMgQm9ubiB3cm90ZToNCj4gSWYgdGhlIFNQSSBz
bGF2ZSByZXF1aXJlcyBhbiBpbnRlci13b3JkIGRlbGF5LCBjb25maWd1cmUgdGhlIERMWUJDVA0K
PiByZWdpc3RlciBhY2NvcmRpbmdseS4NCj4gDQo+IFRlc3RlZCBvbiBhIFNBTUE1RDIgYm9hcmQg
KGRlcml2ZWQgZnJvbSBTQU1BNUQyLVhwbGFpbmVkIHJlZmVyZW5jZQ0KPiBib2FyZCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKb25hcyBCb25uIDxqb25hc0Bub3JyYm9ubi5zZT4NCj4gQ0M6IE5p
Y29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4gQ0M6IE1hcmsgQnJv
d24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ0M6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5k
cmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4gQ0M6IEx1ZG92aWMgRGVzcm9jaGVzIDxsdWRvdmlj
LmRlc3JvY2hlc0BtaWNyb2NoaXAuY29tPg0KPiBDQzogbGludXgtc3BpQHZnZXIua2VybmVsLm9y
Zw0KPiBDQzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IC0tLQ0KPiAg
IGRyaXZlcnMvc3BpL3NwaS1hdG1lbC5jIHwgMTEgKysrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3BpL3NwaS1hdG1lbC5jIGIvZHJpdmVycy9zcGkvc3BpLWF0bWVsLmMNCj4gaW5k
ZXggZjUzZjBjNWU2M2RhLi41N2NjNzExMGY5ZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3Bp
L3NwaS1hdG1lbC5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1hdG1lbC5jDQo+IEBAIC0xMjAx
LDEzICsxMjAxLDE0IEBAIHN0YXRpYyBpbnQgYXRtZWxfc3BpX3NldHVwKHN0cnVjdCBzcGlfZGV2
aWNlICpzcGkpDQo+ICAgCQljc3IgfD0gU1BJX0JJVChDU0FBVCk7DQo+ICAgDQo+ICAgCS8qIERM
WUJTIGlzIG1vc3RseSBpcnJlbGV2YW50IHNpbmNlIHdlIG1hbmFnZSBjaGlwc2VsZWN0IHVzaW5n
IEdQSU9zLg0KPiAtCSAqDQo+IC0JICogRExZQkNUIHdvdWxkIGFkZCBkZWxheXMgYmV0d2VlbiB3
b3Jkcywgc2xvd2luZyBkb3duIHRyYW5zZmVycy4NCj4gLQkgKiBJdCBjb3VsZCBwb3RlbnRpYWxs
eSBiZSB1c2VmdWwgdG8gY29wZSB3aXRoIERNQSBib3R0bGVuZWNrcywgYnV0DQo+IC0JICogaW4g
dGhvc2UgY2FzZXMgaXQncyBwcm9iYWJseSBiZXN0IHRvIGp1c3QgdXNlIGEgbG93ZXIgYml0cmF0
ZS4NCj4gICAJICovDQo+ICAgCWNzciB8PSBTUElfQkYoRExZQlMsIDApOw0KPiAtCWNzciB8PSBT
UElfQkYoRExZQkNULCAwKTsNCj4gKw0KPiArCS8qIERMWUJDVCBhZGRzIGRlbGF5cyBiZXR3ZWVu
IHdvcmRzLiAgVGhpcyBpcyB1c2VmdWwgZm9yIHNsb3cgZGV2aWNlcw0KPiArCSAqIHRoYXQgbmVl
ZCBhIGJpdCBvZiB0aW1lIHRvIHNldHVwIHRoZSBuZXh0IHRyYW5zZmVyLg0KPiArCSAqLw0KPiAr
CWNzciB8PSBTUElfQkYoRExZQkNULA0KPiArCQkJKGFzLT5zcGlfY2xrIC8gMTAwMDAwMCAqIHNw
aS0+d29yZF9kZWxheV91cykgPj4gNSk7DQoNCkxvb2tzIGdvb2QgdG8gbWU6DQpBY2tlZC1ieTog
Tmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gICAJYXNk
ID0gc3BpLT5jb250cm9sbGVyX3N0YXRlOw0KPiAgIAlpZiAoIWFzZCkgew0KPiANCg0KDQotLSAN
Ck5pY29sYXMgRmVycmUNCg==
