Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE27C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E952147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="x05J1kIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfBTKsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:48:23 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:21582 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfBTKsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:48:23 -0500
X-IronPort-AV: E=Sophos;i="5.58,390,1544511600"; 
   d="scan'208";a="26850568"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 03:48:22 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 03:48:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6cA/mPCYjtMs0Fgbmf9+uTVqExX6BYDmLxrp1T1Mm4=;
 b=x05J1kIffLPFSfAGPRUggyZ1RHbY+gd1Y74on1I5AldKbxdqYQbLlnhiCHKFVzYrrDGGKT1IQaZkq2GXqWv/tz0u6gIj3gQveo7x4zEsNWEf5TbW74cexDrWQPfvgk4+Uyw8SPyNHZzSdXMDh5pApOZUlsXesRVD+l6olZES3wE=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1869.namprd11.prod.outlook.com (10.175.53.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 10:48:20 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 10:48:19 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Thread-Topic: [PATCH] clk: at91: fix at91sam9x5 peripheral clock number
Thread-Index: AQHUyQXmTxM0lGKi0EWSxBvx5w6KN6XofCSAgAAFXoA=
Date:   Wed, 20 Feb 2019 10:48:19 +0000
Message-ID: <93fd1515-ee75-75ae-a51f-f3f0e0b2bc74@microchip.com>
References: <20190219165114.2366-1-alexandre.belloni@bootlin.com>
 <c0688a84-bd8e-1874-6fab-727bb6bd657e@microchip.com>
 <20190220102901.GH11432@piout.net>
In-Reply-To: <20190220102901.GH11432@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0392.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::20) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d518163-8a54-4b26-212a-08d69720ed5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1869;
x-ms-traffictypediagnostic: MWHPR11MB1869:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxODY5OzIzOmFSM2JWajRMMGdpWVlpU3NHbUdtUzFzella?=
 =?utf-8?B?VXEyYU9wNldpVmthL1k1Tk9KOThRdGd4bENlNnprdzV6N1gxcXVxZnBqdTJ5?=
 =?utf-8?B?eGdqSHZXcmh3UWJBOEJsTWwzVHIveGU5U0RjRXMyZkZKY2hPSjRHYVgzeE9V?=
 =?utf-8?B?UmpCNXE3YjN3dVdsdnR5MXpVVXNTaVBYdTNPS1VCbWNkOWlpTkx0cWplcXlk?=
 =?utf-8?B?U282bU1zdTV6eU5hRHlpY0kwUXZHcS9iUy9qZDhMNWMwUi9QMndnTTVrVTNy?=
 =?utf-8?B?SjFibGY5U2hKbEtrWDlKU2NvL2hwbHl0Q29GUTR6R0RONGV5SEl2TWtzNmM1?=
 =?utf-8?B?WTNGRGhQY3JSSlZTQk5uWm0rVi9jNmZqYzlybUdQdjJSbHQ3MGVwdGxScy9P?=
 =?utf-8?B?QktDNmxBZFhqWlZmRHVYZlRZWVgrL3FIOEhUdkNSbkxMZ3BEdm9yc1M0R1R1?=
 =?utf-8?B?TTlHbGpLVnZENlpOMEVHZXA0blBoRWhMaEpOTklFYWxaellmUXVBdzRubVl4?=
 =?utf-8?B?RDVBa0RxY2VFVFdONnZ6UmtNU09KSjRHQVA5S1RYR3FsMXdMbFhhMS9ITFkz?=
 =?utf-8?B?SHFYZlU3bVRzeE1SaStOUzhWMjlxQ2hwUW1HR2ZqbEdoVkJkZUhGNUcrWTlP?=
 =?utf-8?B?cU9hdzJFZ1dGMGN1MDVwbzIzcjVYN3ZZbVRPYUFIa0tHWHhhdnZ0Z1l5aXFY?=
 =?utf-8?B?NWJMblZNS3UxcmNPUldYU1hWRjFnWVpNUEJOOExobHYzdGhUaGdCYzNxVFEr?=
 =?utf-8?B?bDk1OUx1YUNsemtaRGdVWGtEeHQvYVUvaEdidTdVcFBsalIreHhYQ2hFREQw?=
 =?utf-8?B?OFVpQmxIWjhTYWxnZzV2c2lOOGY3LzlBMFNkZHZDNlJFdlZlb3djWkJZMGZZ?=
 =?utf-8?B?OUszVk0vMVZvdndaYlJ0eUVqWkc5ZXpqU2ZqcW9WSnVMTmJiYzR4YW1oRlN2?=
 =?utf-8?B?d05jQUZxZ0lNeGJ4b2lvY0xpbDZQQlUyVlQ3Q2FUTENLMVpkaWtqV2xqRm9O?=
 =?utf-8?B?Q0pOc2dXYkJDWnRNRURBc0dQcFFvZElUeHVsNFZuNytwWUo0YWZhdTM0SWU3?=
 =?utf-8?B?RmZaRWszUTAyNW04V3lBaVh0Q0doWGk5UlJTSy9VazVVWlZDemhBTHVmYUNO?=
 =?utf-8?B?ZnlNNW80cTBHYk9NT3d2YkowWUpvWGVGTjV0QmdqQzByN2RUY3FYblBMNzd0?=
 =?utf-8?B?MDdrRDdRVnhHM21IdTBKenJnbndKeDE3NUkwU2VSZmdYNjBTT3E2RGZrT0FI?=
 =?utf-8?B?V2ZaUmZNQkxrdHFTTlNiSGFZR3FmOUx0ZkE3UklFWEVrRkJKa1VWT3lQRWcz?=
 =?utf-8?B?QmxVU09NN3hub0N2VEVnSGxaYmpMTVlvZE5JcFJSTzhCS2FuRk1qZTk3aURh?=
 =?utf-8?B?d09PdGZKaUJBRUtwdG5tN0d4L1FiVGNmeStwVGJ2elNyeTcwWmo1M0xCUXBs?=
 =?utf-8?B?QXFMcmh6elNwcnBnc05hK29Zcy9JUU9ka2ZsdzJDT3FiRERWWFAzQ2JlaStO?=
 =?utf-8?B?TENIQW5CWElVdmFiUExnNFVVU2V3SzJXWjFZa1dDdklUL1hKSXl3d09vWlNr?=
 =?utf-8?B?R3lEcTFlWURURkhQdHMzSG1QMEZWajNBN3cwN0E4UkNJNXlXYzBhVExnYmZh?=
 =?utf-8?B?SDkxc25mMGExanNCYkttRkhxemphWC9xaUpucVhNWklISzV5YTl6dzc3WS8x?=
 =?utf-8?B?RFIwQmI2QVdRdHBlZC9zbGRwS0VONitBRVd2Y1lMOVZycjRvMVlHTUJnaGZq?=
 =?utf-8?Q?Afs5bfy66XoPrZwhe5UdtxyhHiqF0AR4aw7PA=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB1869351B9298F7F08250592EE07D0@MWHPR11MB1869.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(376002)(136003)(199004)(189003)(31696002)(6246003)(53936002)(486006)(6916009)(99286004)(14454004)(106356001)(6512007)(2906002)(25786009)(54906003)(71200400001)(71190400001)(316002)(4326008)(86362001)(5660300002)(31686004)(256004)(386003)(105586002)(53546011)(6506007)(446003)(3846002)(8936002)(102836004)(11346002)(36756003)(8676002)(478600001)(81156014)(305945005)(6346003)(81166006)(97736004)(476003)(26005)(7736002)(2616005)(186003)(72206003)(6116002)(52116002)(68736007)(6436002)(66066001)(76176011)(6486002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1869;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JJMxV6LOwqyoRT5GJsAeXdAcNhqLPIHGMy5cv+7AzCl4fTRf8OfjpkZwM9Df/Nj6y/TYkyQuWQPzm0BZ/tvkTl77gHz20AQUzD+VunsnenDNqNWa4w0pQjMU/urQF8vREnwboSs21/kei6c8vmM894cAIblZZ4dkLAVzf2T/P2n2MchvH5jycqxC12KK7sNkidHAxJgK/V16HSGFgZ0mrN02puDm0wvUpK8V7rRmtLODF+0IqLWOymSKLHAvPMx0RhabRYxs+rVizOKx8dPmuGYSqaODZId3RLoaEtuaxCMdquK2j7tjxbvyGhY0yTwOYnNBrJmJ82EFt0OmblDFBx0rtFccniExeBitumoaa69EXAaCYU+MNjOLsCwGAevPXL7spt1ex3AoO/jcpGk/RxmtGfkKzPnKWcUX4cazzGI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CBC6DFB9AE198438BFB9C73BA4EDD80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d518163-8a54-4b26-212a-08d69720ed5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 10:48:18.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1869
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDIvMjAxOSBhdCAxMToyOSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IE9uIDIw
LzAyLzIwMTkgMTA6MjA6MjgrMDAwMCwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4+IE9uIDE5LzAy
LzIwMTkgYXQgMTc6NTEsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPj4+IG5jaygpIGxvb2tz
IGF0IHRoZSBsYXN0IGlkIGluIGFuIGFycmF5IGFuZCB1bmZvcnR1bmF0ZWx5LA0KPj4+IGF0OTFz
YW05eDM1X3BlcmlwaGNrIGhhcyBhIHNlbnRpbmVsLCBoZW5jZSB0aGUgaWQgaXMgMCBhbmQgdGhl
IGNhbGN1bGF0ZWQNCj4+DQo+PiBXZWxsLCB0aGUgbG9naWMgZm9yIGFsbCBvdGhlciBTb0MgY2xr
IGZpbGVzIGlzIHRvIG5vdCBoYXZlIHN1Y2ggYQ0KPj4gc2VudGluZWwgYW5kIGRlYWwgZGlmZmVy
ZW50bHkgd2l0aCB0aGlzIHR5cGUgb2YgYXJyYXk6IHdoeSBub3QgbW9kaWZ5DQo+PiB0aGlzIGZp
bGUgdG8gbWF0Y2ggd2l0aCBvdGhlcnM/DQo+Pg0KPj4NCj4+PiBudW1iZXIgb2YgcGVyaXBoZXJh
bCBjbG9ja3MgaXMgMSBpbnN0ZWFkIG9mIGEgbWF4aW11bSBvZiAzMS4NCj4+Pg0KPj4+IEZpeGVz
OiAxZWFiZGMyZjlkZDggKCJjbGs6IGF0OTE6IGFkZCBhdDkxc2FtOXg1IFBNQ3MgZHJpdmVyIikN
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlA
Ym9vdGxpbi5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVycy9jbGsvYXQ5MS9hdDkxc2FtOXg1
LmMgfCAzICstLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05
eDUuYyBiL2RyaXZlcnMvY2xrL2F0OTEvYXQ5MXNhbTl4NS5jDQo+Pj4gaW5kZXggMmZlMjI1YTY5
N2RmLi5kMzdlN2VkOWViOTAgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9hdDkx
c2FtOXg1LmMNCj4+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05eDUuYw0KPj4+IEBA
IC0xNDQsOCArMTQ0LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IGF0OTFzYW05eDVfcG1jX3NldHVw
KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAsDQo+Pj4gICAgCQlyZXR1cm47DQo+Pj4gICAgDQo+Pj4g
ICAgCWF0OTFzYW05eDVfcG1jID0gcG1jX2RhdGFfYWxsb2NhdGUoUE1DX01BSU4gKyAxLA0KPj4+
IC0JCQkJCSAgIG5jayhhdDkxc2FtOXg1X3N5c3RlbWNrKSwNCj4+PiAtCQkJCQkgICBuY2soYXQ5
MXNhbTl4MzVfcGVyaXBoY2spLCAwKTsNCj4+PiArCQkJCQkgICBuY2soYXQ5MXNhbTl4NV9zeXN0
ZW1jayksIDMxLCAwKTsNCj4+DQo+PiBJIHdvdWxkIHByZWZlciBsaWtlIGl0J3MgZG9uZSBvbiBv
dGhlciBTb0MgY2xrIGZpbGVzLg0KPj4NCj4gDQo+IFdlbGwsIHRoYXQgaXMgbm90IHBvc3NpYmxl
LCB3aGF0IGRvIHlvdSBzdWdnZXN0Pw0KDQpPa2F5OiBzZWVuOiBsZXQncyBrZWVwIGl0IGxpa2Ug
dGhpcy4NCg0KPiANCj4+PiAgICAJaWYgKCFhdDkxc2FtOXg1X3BtYykNCj4+PiAgICAJCXJldHVy
bjsNCj4+PiAgICANCj4+Pg0KPj4NCj4+DQo+PiAtLSANCj4+IE5pY29sYXMgRmVycmUNCj4gDQoN
Cg0KLS0gDQpOaWNvbGFzIEZlcnJlDQo=
