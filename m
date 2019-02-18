Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8914C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C59D21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qUxWwbHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfBRM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:29:01 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32242 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfBRM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:29:00 -0500
X-IronPort-AV: E=Sophos;i="5.58,384,1544511600"; 
   d="scan'208";a="24837105"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 05:28:59 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 05:28:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qzLqmDASAnVczV+mXixLdUlxbyLm3SedR09cZDgmvg=;
 b=qUxWwbHfAr7LOK/PEjxzEuN0GwHkVLcfNxlSD2rlszx7TUyHuMR+mJ7EhmvGHcTa+5uAHlAGBOkKanHPDr7w0tpaoKE8exBj+f8U+s3AdYy6PLXSHwfsWegZUpzJ9iKKrjx941ARNdQENd8+kuY6jWbwFvoGSRNwZ/KgPEYFGPI=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1821.namprd11.prod.outlook.com (10.175.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 12:28:56 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::b92e:f982:af32:2887%5]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 12:28:56 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <stern@rowland.harvard.edu>,
        <Tudor.Ambarus@microchip.com>
Subject: Re: [RESEND PATCH] dt-bindings: arm: atmel: add new sam9x60 SFR
 binding
Thread-Topic: [RESEND PATCH] dt-bindings: arm: atmel: add new sam9x60 SFR
 binding
Thread-Index: AQHUx4WEXfob+TfGvkO0ZSe4kBgSnw==
Date:   Mon, 18 Feb 2019 12:28:56 +0000
Message-ID: <51c2d2af-3d2f-0fa8-c9e7-5fc6a4f1a1b4@microchip.com>
References: <20190206180425.27324-1-nicolas.ferre@microchip.com>
In-Reply-To: <20190206180425.27324-1-nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::22) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicolas.Ferre@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.6.168.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2edbae24-6594-4d4f-374e-08d6959ca6d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1821;
x-ms-traffictypediagnostic: MWHPR11MB1821:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtNV0hQUjExTUIxODIxOzIzOkh6MTNqNi9ua09QZW4rSjZrMnFHZ09McmFI?=
 =?utf-8?B?dUN4SzNhMEpJQUZjcDl5cm9uOU94TEJUMUhIczZmeDlBdnZYNHArQTdvMHE3?=
 =?utf-8?B?bXc4Yk9SRUhIQktZb0E4dGROVzlYMC9UQnJnenJyeE5MQit4ZHVMYWw2dkxT?=
 =?utf-8?B?ZmFYRHN5elplYVhjVTFTakhYaGtnRWpaVXBiUEFjcHlXeDJzOFlTS0NCRGhs?=
 =?utf-8?B?ZW5pRVR3U0dIcTVSOFBBN3lubTFZemJSVGRxelRvZE9nSzIvOFNQTW0xbGR1?=
 =?utf-8?B?cXNCUG1EdUFoVDRTQUR6UVc4eFhBMDJTTkhFZjhiUUcvZ1U4THJNRHVzN2Y2?=
 =?utf-8?B?WTVpZ1JyZUJkdUwyaE5WLzgvaXoxWWtBZHROTnVlK281SHRGSFBjYlBBVVB6?=
 =?utf-8?B?SThma0VyWmUxSVdqcjhMU3I4RVJ3Lzg1cCtiU1VJaHhQK05KYlE2UHZyYm15?=
 =?utf-8?B?aXNrNnJkV1hGbDFqUldIQ1UxSnZ5SXpHTk1MMUl4M1hqQ0p1NkNPdWViWE82?=
 =?utf-8?B?WEI1WjQ5ckhhK1N2dlVqMUYyQm1VMzd3RkdaMDNYb3FSOWo5MStHVFZnemZy?=
 =?utf-8?B?UE1SYzkweXQvdFZvR2JPOXFla2ZhOFVoZTJpaytnaTdUbXNEbStVUVVQaWha?=
 =?utf-8?B?VlNHMnRzaGJ1RHFhbkFRZHZzTFpHRVIvcndIQ0FBRmp4WXl4T1o1UzRib0JJ?=
 =?utf-8?B?QUkvQ0FTdWUyOVhpUUEwOGUvMm8welBmQ3JMWHl0RmYzbmFGdlo1SGRBRzgx?=
 =?utf-8?B?L0h6T2o2Q2p0VzVEclhVVEIyR3oxNENhQXA2NGtPc2wxUWFUWWlZY2pJN2lN?=
 =?utf-8?B?VGZVcUs0dWI5VHhOWDFBWTRkNmhIWTM1OXppdlduT2ZocU1pRkdNbFRDbk90?=
 =?utf-8?B?eE1uZ2s2d3hxZVpPUTJ5Ry9XclhHNkNMOFZzRUYxT1EyNnVJZ1AySXU0TmRK?=
 =?utf-8?B?bmxXa2lIeTV2Mis4cm1JMTQycWxCRVcvU0M0ZUYycUdtd3hpTE9rSDJUUGwz?=
 =?utf-8?B?ak02TjZIYW5NdFpGRlZCRkd5aWpnM0RYYnErWFM4QWUwTlppbXE4TnV4cUls?=
 =?utf-8?B?bEh1STNveUprWDBkRlZYSkJZYTE3NzBIYW9mMGRkSkNjM1NiOVl5RDcyM0Vr?=
 =?utf-8?B?NmloTkpDNDNDMmFJRWVXYjF2WXhoQmRuUGFCZ2Q3cmRUZk4vSmxXRnUyd2ln?=
 =?utf-8?B?TEdIT05jeXpjQVl4elNCL05kTEV5K3BiMkVxWWFsQmcyUk1icHNHaXplaEVH?=
 =?utf-8?B?RjhtMWNiM2JqOERlWk15VHBFOFZkUWdSSUROWkg1WG5BbFoxdHJaUWw4Y2o2?=
 =?utf-8?B?a1dJVlNFRWlCMWE2WDFZbjZHZ2UrcmFUcTY4UlRFNHljU0lWclVodFdGMzQx?=
 =?utf-8?B?a1FyZEFOQ2FXNzl3eENkV2tDaEtaWTNlR0RnNEV0UUpaN1pNMXhUU3I1SVZL?=
 =?utf-8?B?TWlkN1JiS3d4czVnK2NEZ0dMQy9kcEE0VTVwcm1XbndLM1pKcXdOQUVpdWgw?=
 =?utf-8?B?QWU1b3hmK1h1MWw0aTg3cFZPM2hHOGUrbGU3aWJCZ25mZTN1WDV6UkErUjZt?=
 =?utf-8?B?aWkrU0N4TlRrdklVZEpRRjJJd0N3SjI3MURzR0R1OXRCYVM4VWdRMEhXdGJz?=
 =?utf-8?B?MlpsaEFSVjZrQjdJZ1p2NlVUREpQVnlkQjI4ZmhBTkV2eG0xamFiYXJZcmV2?=
 =?utf-8?B?cWpVMzZlQXJ3dG12d25NUUYrSHp5NUFCZWc2YThMVURveitpRjE3NEVMZkhZ?=
 =?utf-8?B?M2d4NDRpQ2I2cU1ycURyTlk1aVo0Y1JMNkloZ2lXWmFDOUtGUmpSajFXSkJ5?=
 =?utf-8?Q?aIwvHaPB1SWCL?=
x-microsoft-antispam-prvs: <MWHPR11MB1821F9B35A418F4DBDB75F13E0630@MWHPR11MB1821.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(478600001)(8936002)(8676002)(97736004)(81166006)(53936002)(14454004)(5660300002)(186003)(26005)(81156014)(102836004)(31696002)(229853002)(6512007)(6436002)(6246003)(86362001)(68736007)(4326008)(36756003)(107886003)(6486002)(66066001)(3846002)(6116002)(71190400001)(71200400001)(316002)(105586002)(54906003)(2906002)(305945005)(72206003)(7736002)(99286004)(52116002)(106356001)(110136005)(486006)(11346002)(476003)(446003)(386003)(2616005)(6506007)(53546011)(25786009)(31686004)(14444005)(256004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1821;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UAQcHt6ohuM1supUOwjZmcfOCSoa9F+Nn8FK1COgXbOCEohaSecWrPMleBb/HL8X1WzuQOReVqrPPHCzvUQrThCKqr7ZZxyoUrK2W6OMGzOnDuPXviRMd9RV+8T25txStJvhjE0PVR4EGaYTkZpD6svYkOnaGP7gocOuix643f1/v0rDUSbzigFA0IzyyyK/nqEuTDnVFdG78/JugUOzhpsLv76W0ro1aVV6/UBL1Ogd1nhflM3mCjQs13wQv3dsBPsMJjNy6Q7nj8K/3xglMkqtxyruCU0UahFKvIluE5qoZ5EMnQoZQJ3zlKUKJI6CRbWQ2BmDYYOxWKSgyGzFIDzpJIIO+cIjfKhDOLoIS4pa08IagkjGNMasC7wF0CL4VONwJR+USRHthbTxeSMzcBqct3WU7UORPFkcf8DJN3A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE25B2A2E8D5964B884831A01533094A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edbae24-6594-4d4f-374e-08d6959ca6d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 12:28:53.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1821
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDIvMjAxOSBhdCAxOTowNCwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4gQWRkIHRoaXMg
U0ZSIGNvbXBhdGlibGUgZGVmaW5pdGlvbiBmb3IgdGhlIHNhbTl4NjAgU29DLiBXaWxsIGJlIG5l
ZWRlZA0KPiBpbiBPSENJIGRyaXZlcjogb2hjaS1hdDkxLmMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiBI
aSBSb2IsDQo+IEl0IHNlZW1zIHRoYXQgdGhpcyBwYXRjaCB3YXMgbG9zdCBpbiBteSBzZXJpZXMg
IltQQVRDSCAwLzhdIEFSTTogYXQ5MS9kdDoNCj4gdXBkYXRlIHRvIGV4aXN0aW5nIGRyaXZlcnMg
Zm9yIHRoZSBzYW05eDYwIFNvQyIuIEkgc3BsaXQgaXQgYW5kIHJlc2VuZCBpdCBvbmx5DQo+IGZv
ciBVU0IgdHJlZS4NCg0KUm9iLA0KDQpQaW5nLi4uDQoNCg0KPiBIaSBHcmVnLA0KPiANCj4gVGhp
cyBEVCBiaW5kaW5kIGdvZXMgd2l0aCB0aGUgcGF0Y2ggYWxyZWFkeSBxdWV1ZWQgaW4geW91ciB1
c2ItbmV4dCB0cmVlICJVU0I6DQo+IGhvc3Q6IG9oY2ktYXQ5MTogYWRkIHNhbTl4NjAtc2ZyIGRl
ZmluaXRpb24gZm9yIG9oY2kiLg0KPiANCj4gT25jZSBSb2IgYWRkZWQgaGlzIHRhZywgY2FuIHlv
dSBwbGVhc2UgcXVldWUgaXQgaW4geW91ciB0cmVlIGFzIEkgcmV2aWV3ZWQgbXkNCj4gZmlyc3Qg
aWRlYSBvZiBhZGRpbmcgaXQgdG8gdGhlIGFybS1zb2MgdHJlZT8NCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gICAgTmljb2xhcw0KPiANCj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2F0bWVsLXN5c3JlZ3MudHh0IHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vYXRtZWwtc3lzcmVncy50eHQNCj4gaW5kZXggYmFkY2U2ZWYzYWIzLi5kZmM5
MWJjMDJiOTcgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vYXRtZWwtc3lzcmVncy50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9hdG1lbC1zeXNyZWdzLnR4dA0KPiBAQCAtMTQ4LDYgKzE0OCw3IEBAIHJl
cXVpcmVkIHByb3BlcnRpZXM6DQo+ICAgLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgImF0bWVsLDxj
aGlwPi1zZnIiLCAic3lzY29uIiBvcg0KPiAgIAkiYXRtZWwsPGNoaXA+LXNmcmJ1IiwgInN5c2Nv
biINCj4gICAgIDxjaGlwPiBjYW4gYmUgInNhbWE1ZDMiLCAic2FtYTVkNCIgb3IgInNhbWE1ZDIi
Lg0KPiArICBJdCBhbHNvIGNhbiBiZSAibWljcm9jaGlwLHNhbTl4NjAtc2ZyIiwgInN5c2NvbiIu
DQo+ICAgLSByZWc6IFNob3VsZCBjb250YWluIHJlZ2lzdGVycyBsb2NhdGlvbiBhbmQgbGVuZ3Ro
DQo+ICAgDQo+ICAgCXNmckBmMDAzODAwMCB7DQo+IA0KDQoNCi0tIA0KTmljb2xhcyBGZXJyZQ0K
