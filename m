Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E8BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23C120827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vgIALi6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23C120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeKIAgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:36:33 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:28139 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKIAgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:36:32 -0500
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="22547399"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 08:00:38 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 08:00:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC5EtX/kwHi0AvwOv2MfeYf464/2l7fSeWAz3dzRsCs=;
 b=vgIALi6lmqKDDG4njeImFPn5ItrznKJ7hWX4rZ6LlS51HjNx3oRybmUGg0WI1Y5XqqSmKM9TMKwtiXFT1w35InKv0/Jrd9w+RyeTwYr6nSV/LeWaQEEwOGUpknlMOWxHi+nsPgXBbqIYsHCYCIKHz6HbPAdr938PuNbbmAHpkH4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1540.namprd11.prod.outlook.com (10.172.22.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Thu, 8 Nov 2018 15:00:35 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 15:00:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>
CC:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH 3/7] mtd: spi-nor: add restriction for nmaps in smpt
 parser
Thread-Topic: [PATCH 3/7] mtd: spi-nor: add restriction for nmaps in smpt
 parser
Thread-Index: AQHUd1My2DY7uJrddEu3eJNAMbNdY6VF1c6AgAAR3gCAAASWgIAACTUAgAABtwCAAAHCAA==
Date:   Thu, 8 Nov 2018 15:00:34 +0000
Message-ID: <e6e7b441-9dff-1265-4820-e29ad2ae0e0b@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
 <20181108110653.21063-4-tudor.ambarus@microchip.com>
 <20181108135447.36a0314c@bbrezillon>
 <86d16e39-15df-c12c-7bf3-25996db0c3a9@microchip.com>
 <20181108151509.364e3a85@bbrezillon>
 <4de81d92-ca8e-34f1-55b2-ef1b6b9dcec7@microchip.com>
 <20181108155414.48b64084@bbrezillon>
In-Reply-To: <20181108155414.48b64084@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1540;6:x1wWK7LqXUHE5Ed6KoFGYrL1C6G945/h3RxUJaP+OSX0kNAXoZi8x19zDkZpHyjLsw6e5gUWGBkLX6PRy/j3lKqDAHRS3dOU6BMl7yFP507L0WWmZ3gVAk9VJIMz8ONBuBnx6rGBCyft+Ct0Z1FgkTNiaifmQFVpTko7GIh/dWSx/i/S6Tnj8RnWd09EdEB0c1DlUxjvjQzfSbJfa6LkSGwduIy5uetmrXyT2A8zt+bk5drRxQgZ6NflzW1Os5kW3VUAciM74jILmY2yGlcSzI00xPQmksQDJe87eC5XWkQTz1EwMDrkQwBdP+IDS2RE5D7kxM2dF4NSEHkxGitHFGRiRDQKM3+w54yM/T4ht0MeorWp64jx906K3YbEzuWNQstjN/nFPLR/IQ1cIZeYSNV2szjvgFpf3y5J96wpkcZDn+O4DUVbLIBgxB7dWUK5YOyI5Mi3Bo1V+uHbDeol/A==;5:AGZ1EG8JKZtj+gbQeM1cZB4dVXomtTrNYAV3jjdjv55zQAbRnTYKFOY62VyjPTiGNrm2IMokUIwkHiGVrGyy84lfQIy5FuJ53/nwRyC8UEP82DZTPMGd4FeG5XeK6qqKvkMZUnstlABlYGST72GFZRfa2DreVmuavOQA4kDhD9M=;7:jsyFp16kEyqve8EzjOa+jZB5Aqv0Kq83pZe3JVgRL14SBqLcq9I39Gf7OIeSyIEtC2xpP5f/pc4kFNHU1Givw5mJyRKOj2H2cwrv/4QrT7Fjd1gfvU6PcFYdPqvara9SaNXAaQ6z3U2Z/RGCnwynmg==
x-ms-office365-filtering-correlation-id: 3fda85fe-a7c9-4692-30fc-08d6458aef24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1540;
x-ms-traffictypediagnostic: BN6PR11MB1540:
x-microsoft-antispam-prvs: <BN6PR11MB15401094104FA48E3B9788E9F0C50@BN6PR11MB1540.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1540;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1540;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(71190400001)(478600001)(4326008)(6246003)(71200400001)(81166006)(6916009)(81156014)(31686004)(53936002)(6512007)(476003)(2906002)(105586002)(25786009)(6486002)(6436002)(14454004)(11346002)(39060400002)(2616005)(256004)(486006)(72206003)(229853002)(446003)(5660300001)(2900100001)(26005)(52116002)(76176011)(86362001)(99286004)(31696002)(186003)(68736007)(106356001)(316002)(386003)(7736002)(66066001)(6506007)(54906003)(8936002)(305945005)(6116002)(3846002)(93886005)(53546011)(102836004)(36756003)(97736004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1540;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U0Pym0zGWnRBsyjqf4ssEcolbMlHi1ky88pLoEy6JU2aLyD084J7qh+PmP1nTTyiQSc4wHq4OGdMJgFcw9Jcs523gPVMSDvpWp8fjrkm14V0dogc80Erpe62HMl96ck+d5Jg3KfaYSAAxtbq3AoxvH9zyoLSwlMBPu9badVtvitc7YtA+jYWlq/Fd3e4XtUVbu+/0/zOd3W/Qgi2SU5HoaqVYX29borS5DQyzk/sGHmy2wmVZZin4SmOO1g80JvOhb79U/mzG107bseI2RQKVJD5RWz0ABs9qgJaFzWESURhnSoJHS9bO1NdS6oa0FjQ1WXv1PHll5g50P/0whQTyqfIhoB7pIb+sP8SDpZSYxY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <273C3E1FA3093547980F297270F06D0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fda85fe-a7c9-4692-30fc-08d6458aef24
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 15:00:35.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1540
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA4LzIwMTggMDQ6NTQgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
VGh1LCA4IE5vdiAyMDE4IDE0OjQ4OjExICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiAgIA0KPj4+Pj4+ICsgICAgDQo+Pj4+Pg0KPj4+Pj4gTWF5YmUgSSBt
aXNzZWQgc29tZXRoaW5nIGJ1dCBpdCBzb3VuZHMgbGlrZSB0aGlzIGNoYW5nZSBpcyBqdXN0DQo+
Pj4+PiBvcHRpbWl6aW5nIHRoZSBTUE1UIHBhcnNpbmcgYSBiaXQsIGFuZCB0byBiZSBob25lc3Qs
IEknbSBub3Qgc3VyZSB0aGlzDQo+Pj4+PiBpcyByZWFsbHkgbmVlZGVkLiBNb3N0IG9mIHRoZSB0
aW1lLCBzbXB0X2xlbiB3aWxsIGJlIHJhdGhlciBzbWFsbCwgc28NCj4+Pj4+IHRyeWluZyB0byBi
YWlsIG91dCBlYXJsaWVyIGlzIG5vdCBicmluZ2luZyBtdWNoIHBlcmYgaW1wcm92ZW1lbnRzLiAg
ICANCj4+Pj4NCj4+Pj4gSXQncyByYXRoZXIgYSBzbXRwIHZhbGlkaXR5IGNoZWNrLiBJIHdhbnQg
dG8gcmV0dXJuIGFuIGVycm9yIGlmIHRoZXJlIGFyZSBub3QNCj4+Pj4gZW5vdWdoIGRldGVjdGlv
biBjb21tYW5kcyB0byBpZGVudGlmeSB0aGUgbWFwIGlkLiAgDQo+Pj4NCj4+PiBZb3Ugd291bGQg
aGF2ZSBmYWlsZWQgdGhlIHNhbWUgd2F5IHdpdGhvdXQgdGhpcyB2YWxpZGl0eSBjaGVjayBhZnRl
ciBhDQo+Pj4gbWF4aW11bSBvZiBzbXB0X2xlbiBpdGVyYXRpb25zLCByaWdodD8NCj4+PiAgIA0K
Pj4NCj4+IFJpZ2h0LiBUaGUgY29ycmVjdCBmaXggd291bGQgYmUgdG8gY291bnQgbm1hcHMgaW4g
YSBsb29wLCB0aGVuIGRvIHRoZXNlIGNoZWNrcywNCj4+IGFuZCBpZiBhbGwgb2ssIHNlYXJjaCBm
b3IgdGhlIG1hcF9pZCBpbiBhbm90aGVyIGxvb3AgOikuDQo+IA0KPiBPciBqdXN0IGVycm9yIG91
dCB3aGVuICFuY21kcyAmJiBubWFwcyA+IDEuDQoNClNvbHZlcyBwYXJ0aWFsbHkgdGhlIHByb2Js
ZW0uDQoNCj4gDQo+IElmIHlvdSBpbnNpc3Qgb24ga2VlcGluZyB0aGUgbmNtZHMgJiYgbm1hcHMg
Pj0gKDEgPDwgKG5jbWRzICsgMSkpDQo+IGNoZWNrLCB0aGF0J3MgZmluZSwgYnV0IGl0J3Mgbm90
IHJlcGxhY2luZyB0aGUgY29uc2lzdGVuY3kgY2hlY2sgSSB3YXMNCj4gZG9pbmcgOy0pLg0KPiAN
Cg0KSSBkb24ndCBoYXZlIGEgc3Ryb25nIG9waW5pb24gb24gdGhpcywgd2UgY2FuIGxpdmUgd2l0
aG91dCB0aGVzZSBjaGVja3MgYXMgd2VsbC4NCg==
