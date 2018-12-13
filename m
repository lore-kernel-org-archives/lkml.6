Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657CE20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="1sf4IzzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657CE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeLMM7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:59:04 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:3720 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbeLMM7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:59:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="24166953"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Dec 2018 05:59:03 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 05:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmFWb1ptoxv6agxuvhy+mw0EdN1NdImH9+CRh+UhbiM=;
 b=1sf4IzzJAjwDEINYi+MsCT5XeNraB/N6THmU6jlMIrxMKmNNwQ0sx+6gy8xnb24CSdoqoOtQNy3B5ysOd070dvR0BP2djVW3aTZE5/tiVfuyw6ytAewQcruiJg8kYOwWaCoouEFTKb0sD1g/N0DrlXc9AiCeunhqXg7FIaD/kmU=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0728.namprd11.prod.outlook.com (10.163.112.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.25; Thu, 13 Dec 2018 12:59:00 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::cd88:53bd:589a:ab7f%2]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:59:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/5] add PM functionality for act8945a PMIC
Thread-Topic: [PATCH v4 0/5] add PM functionality for act8945a PMIC
Thread-Index: AQHUkuJSt817GApqBkOd8F4AATMFUKV8oWoA
Date:   Thu, 13 Dec 2018 12:59:00 +0000
Message-ID: <0291f79e-b8df-f7ae-1ded-cacd404bc5fc@microchip.com>
References: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1544703110-27161-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0049.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::11) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0728;6:CbT/jFJV+rn/oyT7jhcb1krtLgUBuAIKNTYR4lISrAHZqFSjJLewphHUEWYMig5hjfCQ30epEpeXbO1myd267tSqsmgsbLZFqL7E8SoIUnGvJ07TIT1spLANb86vWERqaO8RkNmJTmjSwMg71VzK+TjDbj9dq2vT1l6106F7eftCYbMN4t4FAXWm7adDRDqs9B10wuINS96NMIpLcgVpfpcogP0aP/LA41Y8h3huY64/5RTs+yIJVjLi3Qtbl56YNIN/Ya3fxpNsUFpflQELrdxQ49SCXL+ZqBSWvj6G8ihX9moDZTzHJiEhGuubsP7A7YU/DSaWT20iY6GM69TGGFNbToMnio8tuWlHom/qrsg/on2v2PT5cHfL8i3pRbajurvJArb47chXgDBHaIOpzWPdVxHd0XUF2oOjxtpP5EQU4JammaNXu6GqWzVuVtIty73eREF59yu7vn1Wr1Ms4p8zZ/5AyjYHWLQh2oxnb+U=;5:BAtwXFapqhcx8j75CPAd4FO2e08gVQ6nxwOYwnmg5b77j2HvsBO81GrHSIcsnOJHf5AGdxUPYcDR2uSpJiFGXtssdckTM541xbhXQba7DyCUogpfqbTfMyxDubKJFWv/sYMA3/v/0SbhhYfaZ0+TuqzPnySBixTswdxH17+E0LU=;7:5frqvicclKFfH2lm8d+Mlz+3uOPnlUX4b4Wnx9biMzqRRtNS0AHO7z+pcgejzv5yjHAl1lgtqaLs0NnqHoAQqsQXJDBZkrAILpx8rt3bIP0OZLYm+1qHa+i3C5EojUkCwJRSscg/ey/ZsMficw87VA==
x-ms-office365-filtering-correlation-id: 60adcae5-a101-4af5-5a89-08d660fabfe1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0728;
x-ms-traffictypediagnostic: BY2PR11MB0728:
x-microsoft-antispam-prvs: <BY2PR11MB0728DE6757532A5DCB73AD9987A00@BY2PR11MB0728.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0728;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0728;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(106356001)(81156014)(71200400001)(386003)(71190400001)(105586002)(14444005)(76176011)(66066001)(6506007)(6116002)(53546011)(256004)(2906002)(446003)(11346002)(6436002)(2616005)(316002)(110136005)(2501003)(478600001)(476003)(53936002)(6512007)(72206003)(99286004)(14454004)(52116002)(97736004)(229853002)(6636002)(68736007)(7736002)(3846002)(54906003)(186003)(5660300001)(26005)(31686004)(39060400002)(6486002)(81166006)(36756003)(4326008)(86362001)(6246003)(31696002)(102836004)(8936002)(486006)(25786009)(8676002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0728;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WVAnPWTvWWxLYGJEu0vwk5gg4CneNb4Lhs9RC1m/pWgL6AzzfktUU+ebExnWDmPs/nczoC99pesNTeLjMDjoJbd8YDACurW4hTjmSM3JRNS1CvelmFtPbRGQKu5p7uCI5H5xAY+PaaykpYnXU+21vxDNb5Ko615qznflAkP25qlbTbu3NZ6hxGvsCUE64SZYlZWvBU0fsJbLQIuc6bJa9+z1unUB1ZD1eO+8hrUFm+93LN2iHk++WrCmz+sLM6ZXxCWD+xjONRdLW3yWfHgYtaEXCUxeSk/s7gjaO7c+iQOdc0FKWPuBez0FF/D6MTm9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C412264179B89043BB78573E38543AB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 60adcae5-a101-4af5-5a89-08d660fabfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:59:00.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0728
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KSSBzYXcgdGhhdCBwcmV2aW91cyB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzIHdh
cyBhcHBsaWVkIHRvIHlvdXIgdHJlZSBqdXN0DQphZnRlciBJJ3ZlIHNlbmQgdGhpcyBuZXcgb25l
LiBUaGUgb25seSBkaWZmZXJlbmNlIGIvdyB0aGVtIGlzIGluIHRoZQ0KZG9jdW1lbnRhdGlvbiBw
YXRjaCB3aGVyZSBJIG1vdmVkIHRoZSBuZXcgaGVhZGVyLiBObyBmdW5jdGlvbmFsaXR5IGNoYW5n
ZS4NCg0KU29ycnkgZm9yIHRoZSBub2lzZSwNCkNsYXVkaXUgQmV6bmVhDQoNCk9uIDEzLjEyLjIw
MTggMTQ6NDksIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0KPiBGcm9tOiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gDQo+IFRoaXMgc2VyaWVz
IGltcGxlbWVudHMgUE0gZnVuY3Rpb25hbGl0eSBmb3IgYWN0ODk0NWEgUE1JQyBhbmQgdXNlIHRo
YXQgc3VwcG9ydA0KPiBvbiBTQU1BNUQyIFhwbGFpbmVkIGJvYXJkLg0KPiANCj4gQ2hhbmdlcyBp
biB2NDoNCj4gLSBtb3ZlIGR0LWJpbmRpbmdzL3JlZ3VsYXRvci9hY3RpdmUtc2VtaSw4OTQ1YS1y
ZWd1bGF0b3IuaCBpbiBkb2N1bWVudGF0aW9uDQo+ICAgcGF0Y2g7IGRyaXZlciB1c2VzIG1hY3Jv
cyBpbmNsdWRlZCBpbiB0aGlzIGZpbGU7IGR1ZSB0byB0aGlzIGRvY3VtZW50YXRpb24NCj4gICBw
YXRjaCBhbmQgZHJpdmVycyBwYXRjaGVzIHNob3VsZCBnbyB0aHJvdWdoIHRoZSBzYW1lIHRyZWUN
Cj4gLSBtYWtlIGRvY3VtZW50YXRpb24gcGF0Y2gsIHBhdGNoIDIgb2YgdGhpcyBzZXJpZXMNCj4g
DQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gYWRkIHBhdGNoICJ1bmxvY2sgZXhwZXJ0IHJlZ2lzdGVy
cyI7IGl0IHdhcyB3cm9uZ2x5IG1pc3NlZCBpbiBwcmV2aW91cyB2ZXJzaW9uDQo+IA0KPiBDaGFu
Z2VzIGluIHYyOg0KPiAtIHNwbGl0IHBhdGNoIDEvMSBmcm9tIHByZXZpb3VzIHNlcmllcyBpbiAz
IHBhdGNoZXM6IG9uZSBhZGRpbmcgcmVnbWFwLA0KPiAgIG9uZSBhZGRpbmcgcG0gZnVuY3Rpb25h
bGl0eSwgb25lIGFkZGluZyBzaHV0ZG93biBmdW5jdGlvbmFsaXR5DQo+IC0gdXNlIGRldl9wbV9v
cHMgc3VzcGVuZCBmdW5jdGlvbiB0byBzZXQgcmVnaXN0ZXIgc3BlY2lmaWMgdG8gUFdSSExEIGxp
bmU6IHRoaXMNCj4gICBpcyBzcGVjaWZpYyB0byBQTUlDIGl0c2VsZiBhbmQgbm90IHRvIHJlZ3Vs
YXRvcnMNCj4gLSBhZGQgbW9kZSBzdXBwb3J0IGZvciBMRE9zDQo+IC0gYWRkIGNvbnN0YW50cyBm
b3IgbW9kZSBpbiBkdC1iaW5kaW5ncy9yZWd1bGF0b3IvYWN0aXZlLXNlbWksODk0NWEtcmVndWxh
dG9yLmgNCj4gLSBkb2N1bWVudCBtb2RlcyBhbmQgcmVndWxhdG9yIHN1c3BlbmQgc3RhdGVzDQo+
IC0gcmVtb3ZlIHJkZXZzIGZyb20gc3RydWN0IGFjdDg5NDVhX3BtaWMgc2luY2Ugd2VyZSBub3Qg
dXNlZCBhbnl3aGVyZQ0KPiAtIGFkZCBvcF9tb2RlIGZpZWxkIGluIHN0cnVjdCBhY3Q4OTQ1YV9w
bWljLCB1cGRhdGUgaXQgd2hlbiBzZXR0aW5nIG1vZGUgYW5kDQo+ICAgcmV0dXJuIGl0IHdoZW4g
cmVhZGluZyBtb2RlIChhdm9pZGluZyBvbmUgZXh0cmEgcmVnaXN0ZXIgcmVhZCB3aGlsZQ0KPiAg
IHJlYWRpbmcgbW9kZSkNCj4gLSBhZGQgYSBwYXRjaCB0byBmaXggYSBjaGVja3BhdGNoLnBsIHdh
cm5pbmcNCj4gLSBpbiBzaHV0ZG93biBmdW5jdGlvbiB1c2UgZGlyZWN0bHkgYWN0ODk0NWEtPnJl
Z21hcCBpbnN0ZWFkIG9mIGFuIGludGVybWVkaWFyeQ0KPiAgIHN0cnVjdCByZWdtYXAgdmFyaWFi
bGUNCj4gDQo+IEJvcmlzIEJyZXppbGxvbiAoMik6DQo+ICAgcmVndWxhdG9yOiBhY3Q4OTQ1YS1y
ZWd1bGF0b3I6IEltcGxlbWVudCBQTSBmdW5jdGlvbmFsaXRpZXMNCj4gICBBUk06IGR0czogYXQ5
MTogc2FtYTVkMl94cGxhaW5lZDogQWRkIHByb3BlciByZWd1bGF0b3Igc3RhdGVzIGZvcg0KPiAg
ICAgc3VzcGVuZC10by1tZW0NCj4gDQo+IENsYXVkaXUgQmV6bmVhICgzKToNCj4gICByZWd1bGF0
b3I6IGFjdDg5NDVhLXJlZ3VsYXRvcjogZml4IGxpbmUgb3ZlciA4MCBjaGFycyB3YXJuaW5nDQo+
ICAgcmVndWxhdG9yOiBhY3Q4OTQ1YS1yZWd1bGF0b3I6IGFkZCBzaHV0ZG93biBmdW5jdGlvbg0K
PiAgIHJlZ3VsYXRvcjogYWRkIGRvY3VtZW50YXRpb24gZm9yIHJlZ3VsYXRvciBtb2RlcyBhbmQg
c3VzcGVuZCBzdGF0ZXMNCj4gDQo+ICAuLi4vYmluZGluZ3MvcmVndWxhdG9yL2FjdDg5NDVhLXJl
Z3VsYXRvci50eHQgICAgICB8ICAzNCArKysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNh
bWE1ZDJfeHBsYWluZWQuZHRzICAgICAgICB8ICA1NCArKysrKysNCj4gIGRyaXZlcnMvcmVndWxh
dG9yL2FjdDg5NDVhLXJlZ3VsYXRvci5jICAgICAgICAgICAgIHwgMjAwICsrKysrKysrKysrKysr
KysrKysrLQ0KPiAgLi4uL3JlZ3VsYXRvci9hY3RpdmUtc2VtaSw4OTQ1YS1yZWd1bGF0b3IuaCAg
ICAgICAgfCAgMzAgKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAzMTIgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdz
L3JlZ3VsYXRvci9hY3RpdmUtc2VtaSw4OTQ1YS1yZWd1bGF0b3IuaA0KPiANCg==
