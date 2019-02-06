Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A10DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DD12075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2Yiy+3Xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfBFRvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:51:38 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:39383 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbfBFRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:51:37 -0500
X-IronPort-AV: E=Sophos;i="5.58,340,1544511600"; 
   d="scan'208";a="23505268"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2019 10:51:37 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 6 Feb 2019 10:51:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORtZ2QwpM3ydmfvxoeItJ8YKuND1vprjzXNov0mgeQQ=;
 b=2Yiy+3XdPPNPEB/9Wwz1PoLR9iV7/fnc/GG8kH+M4X3NBo+VSi4Flvt4ksFRXmNobG64OJldTDZyPbMGPnEll4cvIGp221K5vhuN3ypp5d/ZqDMHhUZf4vgdiF4PE8oWt1p5OtLkaIcAAgXTxoJpbeNM2hEqn3sMuG13Ib9QnmA=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1709.namprd11.prod.outlook.com (10.169.234.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 17:51:33 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 17:51:33 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <sre@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <linux-usb@vger.kernel.org>, <stern@rowland.harvard.edu>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/8] ARM: at91/dt: update to existing drivers for the
 sam9x60 SoC
Thread-Topic: [PATCH 0/8] ARM: at91/dt: update to existing drivers for the
 sam9x60 SoC
Thread-Index: AQHUvkSYTxNCyb6XpkuKX39DVzeCBA==
Date:   Wed, 6 Feb 2019 17:51:33 +0000
Message-ID: <0a24778f-9fc3-6edc-5d74-d152a95d5a98@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWXP265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::21) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1709;6:bJtjXy4+KEbG9mY888MWaB4Sq2SS3nlCRqHSrS6XNrCZnKwVZ0iEBKGT+ZbVYBZwNG19/2rDKpiNRx5UJm+rIYBK6L0vX27Q7D1tHCmu1XbSMYVoOllZcomxySjkq0TDjYlhiTvLt4mLlEOhd9IpbJk3SslMYwGAtQUEXwxmHMBsRvowf8Cy4rC/Qo2La+BPEZQqaFfrApE+PSQk1JBLF5+w4uCY5HCAQdo4BG4NtnDpgNl4qM1sq+M5PxM6SnGmhvAZZVbaacxjgzvgoRGFAczJe2vfR5ohSSysqBfYfmCELoUPIizrXm/I7J5ng8GPdivEsBDBLrz900MlTXcd99cvfFmgFvCRxZBr6RKB7e7jrv0fn30CMMYyBG4QllwWBQ20fDFJgu3RsZY9Dk4Q8zLDUDzDmXM3RySTjOzmIqdfOjJdrH4RvVVblOJjwMg094j8z5DARFjTM8Ov0pw4OQ==;5:18+lJhfPjKx4NclLBHyB3OiMTYDuxf6iCKK5COCxd/UqPPeUheuZzzueS7cp8OCGXKhRN4t/XI4dmSvexU+eVYHek4Yv2KI+zZ1DTX9c00P4JpZ9SruQLmSxoOsfywaOk3QY6lcfEYnNSfe49MyLiJkxcNGP+xb6fNYu2EZLS7SD5vyK+Kw0OOnXAEN5sLff4V3qNTs3nu/obx1jonzq6Q==;7:4B9/IpsKY/h936L2SxwRwgNZtOiZ177BpNyC5GBXnjKUVspZNIyzAi7KWfB0s78+uBVYWo6V9n21aQoR2300YYUEIWULGhuYf4k0o5WWTFiFZtr3zpIyhfrZgmSnTdGiQVAS9qGtbnBBS/pEootUIg==
x-ms-office365-filtering-correlation-id: c0a3bfd6-ff53-4638-42ba-08d68c5bbb40
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1709;
x-ms-traffictypediagnostic: MWHPR11MB1709:
x-microsoft-antispam-prvs: <MWHPR11MB170977498F9E66924795B26AE06F0@MWHPR11MB1709.namprd11.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(25786009)(15650500001)(36756003)(7416002)(71200400001)(71190400001)(476003)(446003)(81166006)(81156014)(8676002)(68736007)(8936002)(11346002)(86362001)(99286004)(52116002)(105586002)(26005)(256004)(53546011)(2616005)(386003)(186003)(486006)(97736004)(2906002)(76176011)(305945005)(6436002)(6512007)(6116002)(3846002)(102836004)(6506007)(66066001)(4326008)(106356001)(72206003)(316002)(14454004)(6246003)(31686004)(229853002)(6486002)(7736002)(53936002)(54906003)(110136005)(478600001)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1709;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DMLWHF3UcozAHHmQxbaWzHnxLiq8VaLiVJvMXXA2yMY9/OyvvoDDrSgTn4zHYtpeQuviZhlbRP/5nhjul5nBWeV3/7/rNkzeN123AYaXjAHdgpnw5h+WGnIAwAH3ywtO4YeXoVtp3kV6LfJOuMufOOeuJGgnmZNhTFlEWZulLuyDNwUCVIZ9qHn2VwZAWeafBlLMm+tUXrRlRZPg9bsYalKOFg0CxWg+aXxsBNrKUgcsZu2SqRZANlCa9BPCxMPheDCP3+OnOa2rVR67KyXKfKmUq+8I7Ls/ZOTOkacUVQ4AJfJk6ab7lCVtwDORNS/Z25vlA+/K4sXD+xcTLvq7oNIeEGz1IhUNJ7tQENdvSxuTWE1jvCxzYfH1VTwx5ajL4JM8mE191wx6H0y/1CMo36ujlNE7npKR5YqvHwYeTQU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C96802A825E3BB469161DBD1AE2DE3B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a3bfd6-ff53-4638-42ba-08d68c5bbb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 17:51:30.0882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1709
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxsLA0KDQpPbiAxNi8wMS8yMDE5IGF0IDEwOjU3LCBOaWNvbGFzIEZlcnJlIHdyb3RlOg0KPiBI
aSwNCj4gDQo+IFRoaXMgc2VyaWVzIGNvbGxlY3RzIHNvbWUgbGl0dGxlIG1vZGlmaWNhdGlvbnMg
dG8gRFQgYmluZGluZ3MgYW5kIGFzc29jaWF0ZWQNCj4gZHJpdmVycyBjaGFuZ2VzIGZvciBzdXBw
b3J0aW5nIHRoZSB1cGNvbWluZyBTQU05WDYwIFNvQy4NCj4gDQo+IEkgdG9vayB0aGUgYWR2YW50
YWdlIG9mIHRoaXMgc2VyaWVzIGZvciBmaXhpbmcgc29tZSBvZiB0aGUgbGVmdG92ZXJzIGluIERU
DQo+IGJpbmRpbmdzIGZvciByZXNldCBjb250cm9sbGVyIGFuZCBFdGhlcm5ldCBtYWNiLg0KPiAN
Cj4gVGhlc2UgY2hhbmdlcyB0b3VjaCBzZXZlcmFsIHN1Yi1zeXN0ZW1zIGJ1dCBJIHdvdWxkIGxp
a2UgdGhhdCB0aGVzZSAobW9zdGx5DQo+IHRyaXZpYWwpIHBhdGNoZXMgc3RheSB0b2dldGhlciBm
b3IgZmFjaWxpdGF0aW5nIHJldmlld3MsIHByZXZlbnQgYnJlYWtpbmcNCj4gZGVwZW5kZW5jaWVz
IGFuZCBmYWNpbGl0YXRpbmcgdGhlIHRyYWNraW5nIG9mIGFjY2VwdGFuY2Ugc3RhdHVzLiBIb3dl
dmVyLCB0ZWxsDQo+IG1lIGlmIHlvdSB0aGluayBvdGhlcndpc2UuDQoNCkl0IHNlZW1zIGl0J3Mg
bm90IHRoZSBwcmVmZXJyZWQgd2F5IHRvIGdvIGFuZCB0aGF0IEkgbXVzdCBzcGxpdCBhbmQgc2Vu
ZCANCnRvIHN1Yi1zeXN0ZW0gTWFpbnRhaW5lcnMgc28gdGhhdCBiaW5kaW5ncyBhbmQgZHJpdmVy
IGNvZGUgZ28gdG9nZXRoZXIgDQp0aHJvdWdoIE1haW50YWluZXIncyBnaXQgdHJlZXMgKFVTQiwg
cG93ZXIvcmVzZXQsIG5ldGRldikuDQoNCj4gTXkgaW50ZW50aW9ucyBhcmUgdGhhdCB0aGUgc2Vy
aWVzIHdvdWxkIGVudGVyIE1haW5saW5lIHRocm91Z2ggYXJtLXNvYyB0cmVlOg0KPiBzb3VuZHMg
b2theSB0byBldmVyeW9uZT8gSWYgb2theSwgSSdtIHJlYWR5IHRvIGNvbGxlY3QgQWNrIHRhZ3Mu
Li4NCg0KSSdtIHJlLXNlbmRpbmcgdGhpcyBzcGxpdCBzZXJpZXMuIFNvbWUgb2YgdGhlICJSZXZp
ZXdlZC1ieToiIGFyZSBtaXNzaW5nIA0Kc28gd2UnbGwgaGF2ZSB0aGUgY2hhbmNlIHRvIGFkZCB0
aGVtIG9uIGluZGl2aWR1YWwgc2VyaWVzLg0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3cyBzbyBm
YXIuDQoNCkJlc3QgcmVnYXJkcywNCiAgIE5pY29sYXMNCg0KDQo+IEZvciB0aGUgZmlyc3QgYmF0
Y2gsIEkgc2VuZCB0aGUgd2hvbGUgc2VyaWVzIHRvIGV2ZXJ5b25lLiBJJ2xsIHRyeSBteSBiZXN0
IHRvDQo+IHJlZHVjZSBzdWJzZXF1ZW50IG1lc3NhZ2UgZGVsaXZlcmllcyBpZiBvbmUgcGFydCBv
ZiB0aGUgc2VycmllcyBuZWVkcyByZXdvcmsuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+ICAgIE5p
Y29sYXMNCj4gDQo+IA0KPiBOaWNvbGFzIEZlcnJlICg4KToNCj4gICAgZHQtYmluZGluZ3M6IGFy
bTogYXRtZWw6IGFkZCBtaXNzaW5nIHNhbXg3IHRvIHJlc2V0IGNvbnRyb2xsZXINCj4gICAgZHQt
YmluZGluZ3M6IGFybTogYXRtZWw6IGFkZCBuZXcgc2FtOXg2MCByZXNldCBjb250cm9sbGVyIGJp
bmRpbmcNCj4gICAgZHQtYmluZGluZ3M6IGFybTogYXRtZWw6IGFkZCBuZXcgc2FtOXg2MCBTRlIg
YmluZGluZw0KPiAgICBuZXQvbWFjYjogYmluZGluZ3MgZG9jL3RyaXZpYWw6IGZpeCBkb2N1bWVu
dGF0aW9uIGZvciBzYW1hNWQzIDEwLzEwMA0KPiAgICAgIGludGVyZmFjZQ0KPiAgICBuZXQvbWFj
YjogYmluZGluZ3MgZG9jOiBhZGQgc2FtOXg2MCBiaW5kaW5nDQo+ICAgIHBvd2VyOiByZXNldDog
YXQ5MS1yZXNldDogYWRkIHN1cHBvcnQgZm9yIHNhbTl4NjAgU29DDQo+ICAgIFVTQjogaG9zdDog
b2hjaS1hdDkxOiBhZGQgc2FtOXg2MC1zZnIgZGVmaW5pdGlvbiBmb3Igb2hjaQ0KPiAgICBuZXQ6
IG1hY2I6IGFkZCBzYW05eDYwLW1hY2IgY29tcGF0aWJpbGl0eSBzdHJpbmcNCj4gDQo+ICAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0ICAgICAgIHwgIDQgKysr
LQ0KPiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbWFjYi50eHQgICAg
ICB8ICA0ICsrLS0NCj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5j
ICAgICAgICAgICAgfCAgMSArDQo+ICAgZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMg
ICAgICAgICAgICAgICAgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvdXNiL2hv
c3Qvb2hjaS1hdDkxLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICA3ICsrKysrLS0NCj4gICA1
IGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KDQoN
Ci0tIA0KTmljb2xhcyBGZXJyZQ0K
