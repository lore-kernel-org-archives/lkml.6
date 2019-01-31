Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F722085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="g30sn5Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbfAaQRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:17:03 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38406 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388155AbfAaQRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:17:02 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="23261674"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 09:16:58 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:16:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBGq+zsGdOaszg0yHR++8U7etUaPSN+Gqvg6/jv1m/0=;
 b=g30sn5Ovwv/CegZnZ6SpLfKXUoHHVeXhK2xnN0clDz1mweV2324e8HVEWzgpBBCLkM6Y+tw2xf0eh4vgn0ucLRtvi0nKts7WukDjULwMGWoiaKOfFZNOslNwAhw8B1dSm2xG/sOyVhuIJTBMLxQIJc67hpuey7jB6JeDLtJXnS8=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB0014.namprd11.prod.outlook.com (10.164.204.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:16:19 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:16:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Topic: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Index: AQHUuWCeSP4bG3gsKk+RqaWqwuohGKXJT34AgAA+TYA=
Date:   Thu, 31 Jan 2019 16:16:18 +0000
Message-ID: <e23b96ad-b920-4caf-d774-2c5c43d7cea8@microchip.com>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
 <1548937733-20189-4-git-send-email-claudiu.beznea@microchip.com>
 <20190131123310.wwikkuiniqlcg445@M43218.corp.atmel.com>
In-Reply-To: <20190131123310.wwikkuiniqlcg445@M43218.corp.atmel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0153.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::46) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190131181609549
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB0014;6:omJWTxoehvq9rQpgxkuhtHv0ern/X2+euoVxzpsBeehBXM099eVdXdlbAQhZCX3imZEVqGWTYmss+88q4Tzm9WHm9M3TKDMKf2OInNdWPNfC3VKEpY5Q/QKNqy919Raj0vhB40s9Niwh/p8LShwiGEBnnVCt7zr2/tUdi0oNPBSZc4rrjIFD4qmxWUUjKNXFLNb4vMi7BGIJWP2QuSIYq84vsXLimCIr0kJoipHqt/ISRgg58gUaHomfrdEKJu6s0vFsuztQrv4wnHpw5wGD95xI+TMOpnOK05blApLe3ZzFesX4Egt0py5lTpPzikcGZp6+U+vuXlWURL4JByNNQ3Z4WOFTiBv4O4kc3r9H32/Vd1VHwH9kAIWaqqdvxFvonh7Vvo/kCq4/76h/lDWGKZjs2QwcZU2SROnV19fxXG8/6+vtB8ekWc2uiQcgO4qP9OC1FAMbA+Qu9MXJxOFP9A==;5:t08d3Rql5ao4wNlz+j7Q0Ujb0KSjnW0WY22K/dK/eDMYqELmYcAs+jynISZbBJqlI+5351e3ZWTE8RGiqaQm80MTGicDWBesBoA5X0IMJDBPIsk/J9iqgV00zI2INw4lkm9cbxuOXm6xiviXEkTud5jqQGlhJevanhQmJHD5BXol66BkaAk6a/R+hmAGR/n7lshia+mjW/87F1DfyQXiOA==;7:A7kVjNiS+ixlJQSTbvEpuoEz9vRJ4FHo7hOBCR2Scce3o+RqB/rL2pIuN1DAd9+rDkEqJGIZZv1jOsy+B8nAwuG+1KrnaRB2PzKKoU3UZvOXvQvQ5dlAeqZMXhwIsE9OLNSo5gVLuLme6HsMts/Vug==
x-ms-office365-filtering-correlation-id: b6357e5b-587c-4754-616b-08d687976ea5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB0014;
x-ms-traffictypediagnostic: MWHPR11MB0014:
x-microsoft-antispam-prvs: <MWHPR11MB0014556E5D4EEA3C0EF89BD987910@MWHPR11MB0014.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(366004)(199004)(189003)(6436002)(36756003)(6512007)(305945005)(256004)(6486002)(446003)(99286004)(6116002)(3846002)(7736002)(2906002)(2501003)(316002)(476003)(110136005)(478600001)(72206003)(76176011)(102836004)(11346002)(6506007)(25786009)(53936002)(53546011)(68736007)(71200400001)(2616005)(6246003)(386003)(229853002)(106356001)(8936002)(71190400001)(186003)(31696002)(31686004)(486006)(86362001)(2201001)(81166006)(81156014)(14454004)(26005)(52116002)(105586002)(97736004)(66066001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0014;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oy9K1QzGKcRaUXpBwrZppLPi8iuvrxe75lQSvebwxJxgKzO1VqxXwlsvx1oJZky90wWlj2E7sIZt9KxU22SYWqlkHQroLD4CmabindrU+oyH1BgC7piK5beuxvs3CnV25Snv6Kkv1oD/+IMIMAyu9JXpSRjCHBsjLj3je2Ocn1+WC3tNvWIZQR3Wx4/v/UbH4l8vp3vPTDfxL3koL3adwr44/DTx/ELXk2HpcyZPm+ldW31wK9jIcWwmyUanUZPZp79cz6R36VIyQPE/Djh9M0RZ9zDg2NRBAUQL7Iq139okBbqXym6bm70TrpYXHszmWXYfrFt9A5Mp8drC8p4Q0DKA+Gjcvi7opyTKJ1NOXYf+BICZU6SXMAa6iPt9EWlZOcwu0goexyw/Srh+md4noDfNmDu3PyuEN0MfvdQXnro=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F481A476EBBBAA4DBE1912293A56F57D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6357e5b-587c-4754-616b-08d687976ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:16:15.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0014
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMxLjAxLjIwMTkgMTQ6MzMsIEx1ZG92aWMgRGVzcm9jaGVzIHdyb3RlOg0KPiBPbiBU
aHUsIEphbiAzMSwgMjAxOSBhdCAwMToyOTozM1BNICswMTAwLCBDbGF1ZGl1IEJlem5lYSAtIE0x
ODA2MyB3cm90ZToNCj4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNy
b2NoaXAuY29tPg0KPj4NCj4+IEFkZCBjb21wYXRpYmxlcyBmb3IgU0FNOVg2MCBwaW4gY29udHJv
bGxlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpu
ZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0
OTEuYyB8IDIgKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYyBiL2RyaXZlcnMvcGlu
Y3RybC9waW5jdHJsLWF0OTEuYw0KPj4gaW5kZXggNDY0NDNiOTdkODExLi41NDU2YTI2OTJiOGMg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLmMNCj4+ICsrKyBi
L2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEuYw0KPj4gQEAgLTEyMTUsNiArMTIxNSw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0OTFfcGluY3RybF9vZl9tYXRjaFtd
ID0gew0KPj4gIAl7IC5jb21wYXRpYmxlID0gImF0bWVsLHNhbWE1ZDMtcGluY3RybCIsIC5kYXRh
ID0gJnNhbWE1ZDNfb3BzIH0sDQo+PiAgCXsgLmNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4
NS1waW5jdHJsIiwgLmRhdGEgPSAmYXQ5MXNhbTl4NV9vcHMgfSwNCj4+ICAJeyAuY29tcGF0aWJs
ZSA9ICJhdG1lbCxhdDkxcm05MjAwLXBpbmN0cmwiLCAuZGF0YSA9ICZhdDkxcm05MjAwX29wcyB9
LA0KPj4gKwl7IC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLXBpY3RybCIsIC5kYXRh
ID0gJnNhbTl4NjBfb3BzIH0sDQo+IA0KPiBUeXBvIHMvbWljcm9jaGlwLHNhbTl4NjAtcGljdHJs
L21pY3JvY2hpcCxzYW05eDYwLXBpbmN0cmwNCg0KVGhhbmsgeW91LCBMdWRvdmljISBJJ2xsIHNl
bmQgYSB2Mi4NCg0KPiANCj4+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+PiAgfTsNCj4+ICANCj4+
IEBAIC0xNzU3LDYgKzE3NTgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGdwaW9fY2hpcCBhdDkx
X2dwaW9fdGVtcGxhdGUgPSB7DQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
YXQ5MV9ncGlvX29mX21hdGNoW10gPSB7DQo+PiAgCXsgLmNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5
MXNhbTl4NS1ncGlvIiwgLmRhdGEgPSAmYXQ5MXNhbTl4NV9vcHMsIH0sDQo+PiAgCXsgLmNvbXBh
dGlibGUgPSAiYXRtZWwsYXQ5MXJtOTIwMC1ncGlvIiwgLmRhdGEgPSAmYXQ5MXJtOTIwMF9vcHMg
fSwNCj4+ICsJeyAuY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1ncGlvIiwgLmRhdGEg
PSAmc2FtOXg2MF9vcHMgfSwNCj4+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+PiAgfTsNCj4+ICAN
Cj4+IC0tIA0KPj4gMi43LjQNCj4+DQo+IA0K
