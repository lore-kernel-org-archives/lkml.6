Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E7EC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3785520874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="0L//b2Uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbfAKOTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:19:00 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48960 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbfAKOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:57 -0500
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="25369365"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Jan 2019 07:18:37 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 11 Jan 2019 07:18:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOdCH4rio62Tu9aQaHAy51ldI11moR/S69dG9CFyQJg=;
 b=0L//b2UyAIg3k/5GAwite7bBPtW1HEP0ETynN9EGGewh+WzbkhPsIss19MyfSPTC4rHcytVXaIH3bxZpXZ8Dot1gCJr62aTHQr4blOY1uWGKzt6A72AwqLqd2DUdU4VA/mSNwJlbpmwaQ+bjAZhGwFWYLkN55IdHT2H64OGLz8k=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1664.namprd11.prod.outlook.com (10.172.55.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.17; Fri, 11 Jan 2019 14:18:35 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::890b:3c0f:a8f4:5de5%7]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 14:18:35 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <bbrezillon@kernel.org>, <peda@axentia.se>
CC:     <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <boris.brezillon@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <Joshua.Henderson@microchip.com>
Subject: Re: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Topic: [PATCH 0/4] drm/atmel-hlcdc: fix plane clipping/rotation issues
Thread-Index: AQHUqbiJnoZpqps6wk2bx1LYfOfUCQ==
Date:   Fri, 11 Jan 2019 14:18:34 +0000
Message-ID: <96578f9c-74f1-38ab-7993-460fd9bc42ee@microchip.com>
References: <20190110151020.30468-1-peda@axentia.se>
 <20190110184446.75b4350a@bbrezillon>
In-Reply-To: <20190110184446.75b4350a@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::34) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1664;6:oeW9YYzNpBImqNhZcy7pTGWeCF1NGDCsrVAEfXym/f9I5QZW8rVQbabaQezwIHhKBfhrfq9MbxDWRv1rKQAO88ExxudHHVPzWa2ouQSSpDf92SRn442Y3Q97nZvbzAOz64oZsArYm9HKus4YjMHygyFokwhwCl2X/XgnQOPPT59S+pCkegn6VJOz29feaXO3N8hgJomMLwpAdCXIQ6gyLXiKHGjMBVbUDmgqDRXZcTkl9Ye9I8XvPoy57Z0cP/mDWcMpZaFDFTqDpO7KJGGNOUkeUKgtBmhHCg2ye5bWVtIsvs1qBX3/n+nhLq/C26I1MtjMBUN89B3xC+YAHorre/UnIThSazQKD8kAzLgU5qxAZCdYzkj8CRF3tVMQDky1RZxv5qXr1zbEM/8/MvErHoVnb3jrffneBhqI+vBcmD+bHJEiFjqi0DIZnHxdi9O768iGwZzW+lkMDt74Wqxrjw==;5:WRRyEekPSobdXLRAQwWxdfTqkcSuA1sdd8ZmWjSxF+YxkCMR3AHX4SHbSy4WRaKDi3Ht1Jsq9h/3nlRamiNBgNScNFz7ib0kj3ntSn+j0+k6f5aP5ZfnEfLQFaKH/5c1vyBmd1XcX2nt4Z+JV7lCemWqcWHa/hZ/m1Wea3cO3SAOwqcEsTaUVP+lznNjxi3V+slO+hIlGoCwhcl1BuSVgg==;7:ZcicWsq9t9KChY0M/YiheA4aNyIPTFggVBMTUDaIZhAbYIA4It+ilXlDFKWwjmg639GscvBmYZrUswiXPFyNykHHHMfnT0T+25MJUKxjc9ub77vDoTXlrbynhX7XwcNt0JBlF36l9f/7YAp5FLMTDg==
x-ms-office365-filtering-correlation-id: e1c40280-40a5-45f5-e02e-08d677cfabf5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1664;
x-ms-traffictypediagnostic: MWHPR11MB1664:
x-microsoft-antispam-prvs: <MWHPR11MB16646F8C8DA2DB35E336F734E0850@MWHPR11MB1664.namprd11.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(52314003)(52116002)(4326008)(54906003)(316002)(86362001)(229853002)(76176011)(31696002)(6436002)(6486002)(106356001)(14454004)(105586002)(6116002)(478600001)(6512007)(72206003)(53936002)(107886003)(6246003)(31686004)(486006)(5660300001)(7736002)(305945005)(3846002)(25786009)(97736004)(2906002)(99286004)(36756003)(186003)(14444005)(8676002)(6506007)(53546011)(102836004)(26005)(386003)(110136005)(68736007)(71200400001)(71190400001)(2616005)(66066001)(256004)(476003)(11346002)(8936002)(81156014)(81166006)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1664;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MYY6k8DEkGokQzAPFVCnHTNSdXV+LKWwjcapHR1ejud/L3lLLM+Zr59RaT9Jq/i4CPILlOYLbPPan0I3DP4+JULewU1R1Ujr+RV/UUOWNd4r7yRTlcaQ3mr4g5oFAEBCFtLVG2wFlTbsAAJ63qo6/M2mvFdpAVDveeC5/9kxUhy+TomwHftPp3b3paqc59TPDDDcOrqsdnUEeKWbZ/Ro2ghqnaG+5bjjdrEh90xQ24bFBlWRKwec/jHL1ry+UkGRZs/cQNxIikGh7eFdh0x75R3/5b/Y4Oy/Uwj1uPOcioHThjSY6GTuh5PKveUdmUjt0vkzvV3EHOfMU0niyjth8vhgYcBZ6UQe4uf+K8RLAyFnZtiTYLlBsvY7OrC0cF7dd/D6Vwa0jHlEqfA9KNmXPc+1Lw2tW+LAXHvhr+larIs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6AF515EE756F04F910A90230508F347@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c40280-40a5-45f5-e02e-08d677cfabf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 14:18:34.9589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1664
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMDEvMjAxOSBhdCAxODo0NSwgQm9yaXMgQnJlemlsbG9uIHdyb3RlOg0KPiBPbiBUaHUs
IDEwIEphbiAyMDE5IDE1OjEwOjI4ICswMDAwDQo+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEu
c2U+IHdyb3RlOg0KPiANCj4+IEhpIQ0KPj4NCj4+IEkgZm91bmQgYW4gdW5mb3J0dW5hdGUgaXNz
dWUgd2hpbGUgcmVjb2RpbmcgcGxhbmUgaGFuZGxpbmcgdG8gdXNlDQo+PiBkcm1fYXRvbWljX2hl
bHBlcl9jaGVja19wbGFuZV9zdGF0ZSgpLiBUaGUgZHJpdmVyIHJvdGF0ZXMgY2xvY2t3aXNlLA0K
Pj4gd2hpY2ggaXMgbm90IGNvcnJlY3QuIEkgc2ltcGx5IGZpeGVkIGl0IChwYXRjaCAxLzQpLCBi
dXQgbWF5YmUgdGhhdA0KPj4gd2lsbCBjYXVzZSByZWdyZXNzaW9ucyBmb3IgdW5zdXNwZWN0aW5n
IHVzZXJzIHdobyBzaW1wbHkgYXNzdW1lZA0KPj4gdGhhdCB0aGUgY2xvY2t3aXNlIHJvdGF0aW9u
IHdhcyBjb3JyZWN0PyBJIGRvbid0IGtub3cgd2hhdCB0byBkbw0KPj4gYWJvdXQgdGhhdD8gQWRk
aW5nIGFuIG9wdGlvbiB0byBnZXQgdGhlIG9sZCBicm9rZW4gYmVoYXZpb3Igc2VlbXMNCj4+IHVz
ZWxlc3MsIHdvdWxkbid0IGl0IGJlIGp1c3QgYXMgZWFzeSB0byBqdXN0IGZpeCB3aGF0ZXZlciBh
cHAgdG8NCj4+IHJvdGF0ZSB0aGUgb3RoZXIgd2F5IGluc3RlYWQgb2YgYWRkaW5nIGFuIG9wdGlv
biBzb21ld2hlcmU/DQo+IA0KPiBIbSwgcm90YXRpb24gc3VwcG9ydCBoYXMgYmVlbiBhZGRlZCBi
ZWZvcmUgdGhlIHN0YW5kYXJkIHJvdGF0aW9uDQo+IHByb3BlcnR5IHdhcyBjcmVhdGVkLCBhbmQg
YXQgdGhhdCB0aW1lIEkgYXNzdW1lZCByb3RhdGlvbiB3YXMgY2xvY2t3aXNlDQo+ICh3aGljaCBh
cHBhcmVudGx5IHdhcyBhbiB1bndpc2UgY2hvaWNlKS4gQW55d2F5LCBJIGRvbid0IGhhdmUgYQ0K
PiBzb2x1dGlvbiBmb3IgdGhpcyBwcm9ibGVtLCBzbyBJJ2xsIGxldCBOaWNvbGFzIGRlY2lkZSBp
ZiBpdCdzDQo+IGFjY2VwdGFibGUgdG8gY2hhbmdlIHRoZSByb3RhdGlvbiBiZWhhdmlvci4NCg0K
WWVzLCBiZWluZyBjb25zaXN0ZW50IHdpdGggc3RhbmRhcmQgRFJNIHN1Yi1zeXN0ZW0gaXMgZmFy
IG1vcmUgaW1wb3J0YW50IA0KaW4gbXkgb3Bpbmlvbi4NCg0KQmVzdCByZWdhcmRzLA0KICAgTmlj
b2xhcw0KDQo+PiBJIGhhdmUgb25seSB0ZXN0ZWQgdGhpcyBzZXJpZXMgb24gc2FtYTVkMywgYnV0
IEkgZGlkIGNoZWNrIHRoZSBkb2NzDQo+PiBmb3IgdmFyaW91cyBvdGhlciBjaGlwcyAoc2FtYTVk
Miwgc2FtYTVkNCwgc2FtOW4xMiwgc2FtOWcxNSwgc2FtOWczNQ0KPj4gYW5kIHNhbTl4MzUpIHN1
cHBvcnRlZCBieSB0aGUgZHJpdmVyIChyZWxldmFudCB0byBwYXRjaCA0LzQpLg0KPiANCj4gVGhh
bmtzIGZvciBhZGRyZXNzaW5nIHRob3NlIHByb2JsZW1zLg0KPiANCj4+DQo+PiBDaGVlcnMsDQo+
PiBQZXRlcg0KPj4NCj4+IFBldGVyIFJvc2luICg0KToNCj4+ICAgIGRybS9hdG1lbC1obGNkYzog
cm90YXRlIHBsYW5lcyBjb3VudGVyY2xvY2t3aXNlDQo+PiAgICBkcm0vYXRtZWwtaGxjZGM6IGRv
IG5vdCBzd2FwIHcvaCBvZiB0aGUgY3J0YyB3aGVuIGEgcGxhbmUgaXMgcm90YXRlZA0KPj4gICAg
ZHJtL2F0bWVsLWhsY2RjOiBmaXggY2xpcHBpbmcgb2YgcGxhbmVzDQo+PiAgICBkcm0vYXRtZWwt
aGxjZGM6IGRvIG5vdCBpbW1lZGlhdGVseSBkaXNhYmxlIHBsYW5lcywgd2FpdCBmb3IgbmV4dA0K
Pj4gICAgICBmcmFtZQ0KPj4NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVs
X2hsY2RjX3BsYW5lLmMgfCAxNzkgKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCAxMTIgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4g
DQoNCg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
