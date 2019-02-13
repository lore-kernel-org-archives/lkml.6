Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C6C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790F6222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="aWxUPH7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbfBMAHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:07:24 -0500
Received: from mail-eopbgr750138.outbound.protection.outlook.com ([40.107.75.138]:23541
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728789AbfBMAHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c2CcpKNZQ3vOHmbydgcLwLYlHcKbwhT/ivOh8IvbhQ=;
 b=aWxUPH7RNsjyqt9QLoB38njCJ7idFH35xngN+aXqAA+gmN9iwo2eHETR9O1qOVgd/w/vROgtL1hC0hf23W0rqKacHXlKuU5u3g4McTc4S3mbIhffcdv7J4uWVfFbB7WDBAY+vbY7sSmmF1839V6JEM5vH9tYlONq2u15bCeaCx4=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3673.namprd06.prod.outlook.com (10.167.236.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 00:07:17 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 00:07:17 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6AgAUATgCAATwLAIAAFl6AgAANW4CAAWRIAIAAS20A
Date:   Wed, 13 Feb 2019 00:07:17 +0000
Message-ID: <1550016436.3075.127.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
         <20190107132226.16216-2-stefan@agner.ch>
         <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
         <1549916056.3075.102.camel@impinj.com>
         <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
         <1549923727.3075.103.camel@impinj.com>
         <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Ccovx2hMU0SmPm9ToZDNXOdLWkoQ8QT7EOhLocL7GAEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e893883-a83b-4d58-df13-08d691473760
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3673;
x-ms-traffictypediagnostic: MWHPR0601MB3673:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3673;20:Lp95K+5c0Cwv7fDsK1Wi4d17xqUTjrMbLaH1rE7uIS+xkeqRsNiN+AVemboKpybkl1S99pTtMw1km3o+9MesW3v+AvP0HE3+t22COzUELIJLlTS7gnjtEhvMMs5OStA1t520MQxiHaAMctAyVtsNgdRLpFXuzukzdi3C+2qB10U=
x-microsoft-antispam-prvs: <MWHPR0601MB367388510C9BC189107BD08ED3660@MWHPR0601MB3673.namprd06.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39850400004)(199004)(189003)(51444003)(4326008)(6506007)(71190400001)(36756003)(14454004)(26005)(71200400001)(106356001)(53546011)(6512007)(1411001)(478600001)(66066001)(53936002)(6486002)(3846002)(486006)(14444005)(186003)(8936002)(6916009)(256004)(68736007)(5640700003)(6436002)(6116002)(6246003)(476003)(8676002)(229853002)(86362001)(81156014)(54906003)(103116003)(93886005)(1361003)(81166006)(305945005)(7416002)(102836004)(1730700003)(97736004)(105586002)(2616005)(2351001)(2906002)(11346002)(446003)(76176011)(99286004)(7736002)(2501003)(316002)(25786009)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3673;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TVWIYD+a3xth9w9cTyqHWN87rRFrG8HnelxuzR2KDDxAZDyibdrP4cLgB0NicBhR4TRdJBeOTWGi/Qw+qa4Wo0QQre+hHXkc9WyiZeQtoj5bCb/y9Fk8XDS/Jv9iEBTfOsA2awS+CY7ZVWq1Jksv6wYeDKsbri+eQH62/FE9axQ5US3TZ3GZS0jlNNhLLMfWrgw/2/3q6nOMxcjEH3mNWO1SkN91Cz/XqwCt5+YWsX2mKs8t/2Z7i3nZHAC8Gg+9rj5/u17TwnnU80zXQOGjQuOdt0qg0Dz8Swcdj4AfMkxB2UzhZDmBzlaSN0KGAsjSwcSD1v78nhVqDWnUv6geL+2XQixd1kDeYsEOxZmUfy0HE712c79ZVk+p46mFfH+PagiJ9jb2Vz95BtHWwqOPBq3EZUBlYlBDPlVAqHU6+F0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <047FC06350572F43B74894761A4D517A@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e893883-a83b-4d58-df13-08d691473760
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 00:07:17.5813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTEyIGF0IDE3OjM3IC0wMjAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBPbiBNb24sIEZlYiAxMSwgMjAxOSBhdCA4OjIyIFBNIFRyZW50IFBpZXBobyA8dHBpZXBob0Bp
bXBpbmouY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gPiBKdXN0IHRyeWluZyB0byB1bmRlcnN0YW5k
IGlmIHRoZSBTRE1BIGZpcm13YXJlIHBsYXlzIGEgcm9sZSBvbg0KPiA+ID4gdGhpcw0KPiA+ID4g
YmVoYXZpb3Igb3Igbm90Lg0KPiA+IA0KPiA+IFRoZSBST00gZmlybXdhcmUgb25seS4NCj4gDQo+
IERvZXMgdGhlIHByb2JsZW0gYWxzbyBoYXBwZW4gaWYgdGhlIGV4dGVybmFsIFNETUEgZmlybXdh
cmUgaXMgdXNlZD8NCj4gSnVzdCB0cnlpbmcgdG8gbmFycm93IGl0IGRvd24uDQoNClRyaWVkIFNE
TUEgZmlybXdhcmUgNC4yLiAgU3RpbGwgYnJva2VuLiAgTm8gYXBwYXJlbnQgY2hhbmdlLg0KDQpH
ZXQgNCBjeWNsZSBwYXVzZSBhZnRlciBlYWNoIGJ5dGUuDQoNCkFuZCBjcmFzaCB3aGlsZS9hZnRl
ciB1c2luZyBETUEuICBDbGVhcmx5IHNvbWUgc29ydCBvZiBtZW1vcnkNCmNvcnJ1cHRpb24gZ29p
bmcgb24uICBGb3J0dW5hdGVseSwgaXQncyB2ZXJ5IHJlbGlhYmxlIHRoYXQgdXNpbmcgRE1BDQph
bG1vc3QgaW1tZWRpYXRlbHkgY2F1c2VzIGEgcHJvYmxlbSBhbmQgdGhpcyBpcyBlYXN5IHRvIHJl
cHJvZHVjZS4gIEkNCnRoaW5rIHRoYXQgaW5kaWNhdGVzIGl0J3MgZWl0aGVyIGNsb2JiZXJzIGEg
bG90IG9mIFJBTSwgb3IgY29uc2lzdGVudGx5DQptYW5hZ2VzIHRvIGhpdCBhIHZlcnkgaW1wb3J0
YW50IGxvY2F0aW9uIGZvciBrZXJuZWwgbWVtb3J5IGFsbG9jYXRvcnMuDQoNCkkndmUgZ290IGFu
IGlkZWEgb2Ygd2hlcmUgdGhhdCBtaWdodCBiZSBoYXBwZW5pbmcgdGhhdCBJJ20gbG9va2luZw0K
aW50by4NCg0KSSB0aGluayBpdCdzIHJlYXNvbmFibGUgdG8gYWRkIHRoZSBkbWEgYXR0cmlidXRl
cywgYnV0IHB1dCBhIGNoZWNrIGluDQp0aGUgc3BpLWlteCBkcml2ZXIgdG8gZGlzYWJsZSBETUEg
b24gaW14N2QgYXQgbGVhc3Qu
