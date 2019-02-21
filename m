Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C474C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67C32085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cxn5BooC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfBUOKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:10:03 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:26674 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUOKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:10:02 -0500
X-IronPort-AV: E=Sophos;i="5.58,395,1544511600"; 
   d="scan'208";a="24226512"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Feb 2019 07:10:02 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 21 Feb 2019 07:10:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PBlad3HwjgaxXFTRcgVTWxlkGiUuVJ71eatm/tl+Hs=;
 b=cxn5BooCVKb/j/GI+KPvutABfILdXQXZzuKOH097e62wjuns5oAwF3SQyESdZEdbnTEV84pdE2kSx+FvIGumXBiO6dNmyt6a4UqzEER1xpIjdJ6tBH8QK310Q97yh4eAevuUKy02l2CT2dLfZ3Gn4zpSH9Q5Esl63ktFxum/96Q=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB2030.namprd11.prod.outlook.com (10.169.236.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 14:09:57 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 14:09:57 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Topic: [PATCH v2 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Thread-Index: AQHUyevGQg3OphZfLEu2uH5tbWx1E6XqSl0A
Date:   Thu, 21 Feb 2019 14:09:57 +0000
Message-ID: <4d728bb8-cada-6656-204f-2ae766211f5e@microchip.com>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
 <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550756716-3032-4-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::28) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b8c97f9-2091-4307-aa2d-08d698064241
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2030;
x-ms-traffictypediagnostic: MWHPR11MB2030:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIyMDMwOzIzOkFUVzRBVm5HQm13dURwZWw1WlRZR2VJWE5D?=
 =?utf-8?B?ZUZ5Yi8xbFZiMmllNHdLRllNeUdtamR0OXZVeDZvQmZWZThPU1NMZnFFczIw?=
 =?utf-8?B?ZGNEYlI2SDY2eXRTTWVNYm9lWmh0RGQ5VGMrTDNnNUJ4c2I3bkRzVENxRm15?=
 =?utf-8?B?eTd2Q3NBR0hrTjYvalloWGNFbXp1b0FDaGRvYUxQaWNFUWZiNGZKZE50bjV2?=
 =?utf-8?B?QkIrZkFNZkc2Qm9NMmNibTBOdWtQMlhWNjNEL3FEbkFNaExFdXpjRFhZU2pT?=
 =?utf-8?B?cWt4ekZodDF6bmptZmQ4K21WZ0hwcUtVZE9SUWF0NzhUMmVkMDAwRlpnUndJ?=
 =?utf-8?B?L3YrbkRBazRsdDBpNFpOZ0VEMDRlU3VINlBzSnVaVzlKVkVhd0RENkJ0bDE0?=
 =?utf-8?B?ZnVobTUyam40K0gwSFFTZHNmWDFURnZQM0VvNEpiNTIzTUFxWE5oVVRIcFRH?=
 =?utf-8?B?ZklQcXQxWFVZOXJvQWM2aS9ReFI3Zlp3b3dWR1UxWHdYQ2JEbGVlQVc5dHFD?=
 =?utf-8?B?aE43NzJHZHI0U1l6ejBhUlQ5MHE2bWlKSzZMUEJwaytBQVV6N1IweDJhbUds?=
 =?utf-8?B?OWdmR2RROW5vU3dzWUdYQmlSajJSRHBGUVdEUHZvdzdyU0J4MnpZRG1NSUM1?=
 =?utf-8?B?VW1LQVhUZ09KS2hJWldGejdCd3ZjZkxBazc0a3VFVjFSYmRRMmk2RlFUYnVh?=
 =?utf-8?B?SFZZOHJaQ0JBMjQ5Mm5tLzdvMHd0TDFmc3FqSnRDQmhPL1lUMTRwZkg4QS9O?=
 =?utf-8?B?UW4vV1ozMGhxRHpqd3h6V3U5L3FwZW5zQnNYRzFDNjRWeWVHVk9HMWgxd1M1?=
 =?utf-8?B?UHdFOEI4QVhRQ0Nwd3NhKy9FejRzYk8xUVhlV2d3RWw5TjdNZm96Q0YwZEpN?=
 =?utf-8?B?djlLZGtDQVo4NFM4dTVwZVpnMUkvMUtHc0lTZTRPMDVNV1czZExVaVFHN3VZ?=
 =?utf-8?B?b0JXSi9YNkRjZHZVRkUwUnBCdjRqNlpzcExVeE9RQVRhRGZDN2dlQStPS09r?=
 =?utf-8?B?ajJxQUNTdzdiR21KekN4NFRwem5oSUZKQ1NKeVlKVVc0ZXpFZEhjNHVqL2VE?=
 =?utf-8?B?STZhVmV1TGtpdTNJUG9ITDRwZ09kQjB4WEtRZFVtUlZNSUZ0VE40MGtZdElJ?=
 =?utf-8?B?a0hGbDIwc0VaR0JkVnZxam5ab0J1N0xLZTY2OFN2UUhhbGY3OFVGTnU1bEZh?=
 =?utf-8?B?dGlva1lVdHNoYmRSK1hhTUJMUU9pWFdKR1NYb0xDMWExNUdrRGQ5dS9aVnJP?=
 =?utf-8?B?TExlUGdpVkZpUlVBeE5ZUUFxZkhXNXFud3pyMzlQc3hUbzh1VXNwOWNUdVpu?=
 =?utf-8?B?RHllb1hJdWQvVURqeGczTFdoVm0xWUQrTTVlVE1uWG9odWxmSCtLZDBMWENG?=
 =?utf-8?B?d2RVdGJWQ0I2MVNZUi8rOXdkek84REo3RzZqTVExaE1zNDhTMlVDNWNNa05a?=
 =?utf-8?B?cHpwQTk0ZmNxTGVYOC9GWGNmelBWQXI3ZGx4NTRidkNyRDNaVHVqS0dFcnVL?=
 =?utf-8?B?MUIzTHVlMXNNaCtZeFY1NnRwbEl3b2JCMWFmV1ZxOVhZV1dvbFl5MTg3N0JK?=
 =?utf-8?B?Z25XNjhlNnlzaFN6eC9ZeTBvUlA0WEVjT1NkdmF0WmNyaTRHQjZZUSsxWWRu?=
 =?utf-8?B?MGJEQ0NWY1ZBREdEUWFNL2psTlYxWG5TK3B3cVIxZWJ2V0pvRi9oYWtML2wv?=
 =?utf-8?B?ZjVYek1OYUNoYW1FS1g5bWdlaVhEV1VPdktsbFVlRzlxWFlUNkFMbXcvcS91?=
 =?utf-8?B?UFBtNXp4L2hLbzlsNDVNY0xRcURmbWZtcE0xYkZGbm04NUp5T1RDbis5L3hn?=
 =?utf-8?Q?FupZLEOVNhMJk?=
x-microsoft-antispam-prvs: <MWHPR11MB20303280238CB4C42C642459E07E0@MWHPR11MB2030.namprd11.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(53546011)(386003)(99286004)(2501003)(68736007)(2906002)(26005)(25786009)(476003)(2616005)(486006)(76176011)(11346002)(446003)(97736004)(102836004)(6506007)(52116002)(186003)(66066001)(86362001)(31696002)(6246003)(4326008)(6116002)(3846002)(72206003)(36756003)(478600001)(14454004)(105586002)(54906003)(305945005)(110136005)(229853002)(7736002)(8936002)(6486002)(71190400001)(256004)(106356001)(31686004)(6512007)(53936002)(81156014)(81166006)(14444005)(8676002)(316002)(5660300002)(6436002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2030;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NyS5PQDPZ3p6wjEdlrdE74agVISK1opQKurdY6kGY6t5kGPWoNS1UVmjgVtez7ymZdSYuRTzcXRTMnX129THe1xswpCoArOWFKFpYpwWCpSMmeEIfWQpVPfGXzHEPxwqghdWRn2DKk8BAdxvKlLNddxAUYi0siMGVg512RFp/8aYSYJZ/P4j9ZCEGa7MFw6+OOAmaPQ0AATONUOZgq0PmVG3sXWij+2daicHIIbnytEtQR/LgfTRn3DyDrBAyKyBoGcu5jug69Cp1KDZzd0eoytA8HTGu72iYsU5psSiEz5Kw3oxZkYTpYS86hoth58tRSguvOuDt7eXTwpoZzn/ms1BLFPl76A/tW9qZq6T/bajW13h9Xio4bx+mPOm5gJR1PyPEBYz8CbxmYOYgZ8tMXEFngVXnPJCodywzshevqg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14B759396FBAD44AB926956191F84D69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8c97f9-2091-4307-aa2d-08d698064241
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 14:09:54.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2030
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjEvMDIvMjAxOSBhdCAxNDo0NSwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+
IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gQWRkIGRvY3VtZW50YXRpb24gZm9yIFNBTTlYNjAgc2h1dGRvd24gY29udHJvbGxlci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2No
aXAuY29tPg0KDQpBY2tlZC1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2No
aXAuY29tPg0KDQpUaGFua3MgQ2xhdWRpdS4gUmVnYXJkcywNCiAgIE5pY29sYXMNCg0KPiAtLS0N
Cj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3Mu
dHh0IHwgNSArKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dA0KPiBpbmRleCAxNGYzMTlmNjk0YjcuLjUwZjI4
MmNjYmNiNyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9hdG1lbC1zeXNyZWdzLnR4dA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0DQo+IEBAIC04Myw3ICs4Myw3IEBAIFNIRFdD
IFNBTUE1RDItQ29tcGF0aWJsZSBTaHV0ZG93biBDb250cm9sbGVyDQo+ICAgMSkgc2hkd2Mgbm9k
ZQ0KPiAgIA0KPiAgIHJlcXVpcmVkIHByb3BlcnRpZXM6DQo+IC0tIGNvbXBhdGlibGU6IHNob3Vs
ZCBiZSAiYXRtZWwsc2FtYTVkMi1zaGR3YyIuDQo+ICstIGNvbXBhdGlibGU6IHNob3VsZCBiZSAi
YXRtZWwsc2FtYTVkMi1zaGR3YyIgb3IgIm1pY3JvY2hpcCxzYW05eDYwLXNoZHdjIi4NCj4gICAt
IHJlZzogc2hvdWxkIGNvbnRhaW4gcmVnaXN0ZXJzIGxvY2F0aW9uIGFuZCBsZW5ndGgNCj4gICAt
IGNsb2NrczogcGhhbmRsZSB0byBpbnB1dCBjbG9jay4NCj4gICAtICNhZGRyZXNzLWNlbGxzOiBz
aG91bGQgYmUgb25lLiBUaGUgY2VsbCBpcyB0aGUgd2FrZS11cCBpbnB1dCBpbmRleC4NCj4gQEAg
LTk1LDYgKzk1LDkgQEAgb3B0aW9uYWwgcHJvcGVydGllczoNCj4gICAgIG1pY3Jvc2Vjb25kcy4g
SXQncyB1c3VhbGx5IGEgYm9hcmQtcmVsYXRlZCBwcm9wZXJ0eS4NCj4gICAtIGF0bWVsLHdha2V1
cC1ydGMtdGltZXI6IGJvb2xlYW4gdG8gZW5hYmxlIFJlYWwtVGltZSBDbG9jayB3YWtlLXVwLg0K
PiAgIA0KPiArb3B0aW9uYWwgbWljcm9jaGlwLHNhbTl4NjAtc2hkd2MgcHJvcGVydGllczoNCj4g
Ky0gYXRtZWwsd2FrZXVwLXJ0dC10aW1lcjogYm9vbGVhbiB0byBlbmFibGUgUmVhbC10aW1lIFRp
bWVyIFdha2UtdXAuDQo+ICsNCj4gICBUaGUgbm9kZSBjb250YWlucyBjaGlsZCBub2RlcyBmb3Ig
ZWFjaCB3YWtlLXVwIGlucHV0IHRoYXQgdGhlIHBsYXRmb3JtIHVzZXMuDQo+ICAgDQo+ICAgMikg
aW5wdXQgbm9kZXMNCj4gDQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
