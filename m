Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCAFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE342070C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mAvQ11jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbfBMKyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:54:17 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:38486 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfBMKyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:54:16 -0500
X-IronPort-AV: E=Sophos;i="5.58,365,1544511600"; 
   d="scan'208";a="26479425"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 03:54:15 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 03:54:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA4HnqQDbFK950Qg7S21tclg2h/SCM3s9wrg+fD9XBQ=;
 b=mAvQ11jdmY5Gd5KNfttiC6BxdYI5GdQq14xNjKW0+jADCVxjPI/CZil4rNepQNyUBfGDQJWHz4GWrwIXauAazYKvbVvS1Qg8a4sNNgLQh6g6W5VuhvD5YSmPDgVf+OhdPLvvZdkofMnYkSNVJrO8KBapQHlDfHhROaOlUvUUWQ8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1699.namprd11.prod.outlook.com (10.173.26.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 13 Feb 2019 10:54:12 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 10:54:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <marek.vasut@gmail.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <lee.jones@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 07/11] mtd: rawnand: atmel: add sam9x60 nand controller
 support
Thread-Topic: [PATCH 07/11] mtd: rawnand: atmel: add sam9x60 nand controller
 support
Thread-Index: AQHUw3qCWFNDodb6ZkCALjA5DxGPkaXdibmAgAAEMAA=
Date:   Wed, 13 Feb 2019 10:54:12 +0000
Message-ID: <f8d77918-0bb8-d211-d139-4f8722136c8a@microchip.com>
References: <20190213085930.31578-1-tudor.ambarus@microchip.com>
 <20190213085930.31578-8-tudor.ambarus@microchip.com>
 <20190213103905.GH10129@piout.net>
In-Reply-To: <20190213103905.GH10129@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0100.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::26) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f8f8a0b-7980-4026-732f-08d691a1965f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1699;
x-ms-traffictypediagnostic: BN6PR11MB1699:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIxNjk5OzIzOjMwSVpONWc2V3Y0WnNiMExZVGNiRmJ6SWZG?=
 =?utf-8?B?RlpQOGFQQmk2bnlab0I5bkFVL0FmOGFCaTErN25WazhOOUM4eHJ4THBJNUVL?=
 =?utf-8?B?MzZlSTZDaXNaUVBkU3VjdlpDdVdoOWNBcXJaa2JtMEduTXZpVEl4a2xpSXB6?=
 =?utf-8?B?SW43Wkh5Ri8yanZpeG1LZGF2OHB3ZVQxVFVjbE9NNk9semtxVEpFbEk4YVZI?=
 =?utf-8?B?VnRwNm5ia0dnNWNtc0V2L2N1MU44QXJFaWNCelFJbUg0NVdOUUNmWFhFdWlz?=
 =?utf-8?B?cUhNT3RESFJ3NW5OYkpZdk9BOE5XQUxLOXg3Si9XU0l3Y2VRS0IrUzNBL2FB?=
 =?utf-8?B?T05TRlBuV3F2SGZYN0pVcHlCNHEyS2NqWjNNdGpkTWFrem1qZWdCVjZ6bU9B?=
 =?utf-8?B?WEFQUHBIeVU3RHFLVFVOUlYvaTRTbGpOYzN2YXUxVFZVMXpPTUdXSExiazZo?=
 =?utf-8?B?YWJoMkFBMjI0cGdZb2U1UDJHQmVKYkJUZEdBSGJ3YVRGVHNYWmVZRVFLbWRI?=
 =?utf-8?B?YldaclBtam53aW0wTVQ2eWoyUTFSSXNXMUZWUGRmd1dsdVhtaXE3Wkpra0lF?=
 =?utf-8?B?Q3p1NlBEQ29SeENjR21ETm1aN0JGMzVzUEd2N0t2SElPQVNYb2xHRmQwZVFZ?=
 =?utf-8?B?TFFZaXJaMXB1UkthSUhBUXFSME1YdTBTVWJoM2Q1bFBPdHVtd2J0VExQR05Y?=
 =?utf-8?B?VmpCaTdpWlFpaXN4UmhvVk9FaWQwb1ptTlBPaHZ3anJac0tocG1sbFF5SUIv?=
 =?utf-8?B?ZlVhUXNiekhSU3gvZHNqQ082YmZsSTFjbmprWnZ2T1VQdWtSYWVtdlFLNk5z?=
 =?utf-8?B?YUFEZTlPbEluOTRIRzZZYlZXTUc0RHZnbC9sYUVQVTM2cjVOL1krNW9qOXNF?=
 =?utf-8?B?dGV0TGwzdkFpUUlSMFYyemZYNEQrUWVmTGtVM01udlVXQVBXZzhZUUFtdklM?=
 =?utf-8?B?Y3E2TmlmanMzam9BTmR5K1NUbHp2cncvOEF2UTR6ZWpLbFF6MndpeFdFY0JF?=
 =?utf-8?B?KzQvdHRIMDFwaWh2WFJzWDJoMWV5a1ltUnh3WWg5MVFwZExTWkxHUmJUejZm?=
 =?utf-8?B?a3Z3amM4N09uUzRKTlZhaG9ycFNwVGVtR0pLSXdkVFViYUhhcFF1eFVXUkxH?=
 =?utf-8?B?OFFjeU12TzdkU05IQ2tGNzd2UDJQVVhVN0VkcWRtUmhWVC80cVYxZlNtSjUy?=
 =?utf-8?B?Wm1xOTNWUURkcExtQWl6Z3RHN1NJRnJlT0JDdHhpYjdaQk5zRHArb000a09T?=
 =?utf-8?B?dC95UTEyaGJ6eE9zeUFrbWxiRElhbndXVXQvN2MvT2R6UlpsbkhxR0c2ZUdr?=
 =?utf-8?B?N0xtL0hpVWpkYnZHUXJjN255d291VzN1enNyaDFPKytZcUpCL29zUHhJMGVG?=
 =?utf-8?B?TnlJKzN1TjhqcjZYcUt0Q1d3N2F2TFM3MW41RzVMS09raTkwclVnU2NPOWtO?=
 =?utf-8?B?c1FaeU95MGk0VmRENVh5bjJqU2kyWUhoK1FXV1pVaEw1bE1nM2hqQS9zSUVQ?=
 =?utf-8?B?SGduSHZZbjdqNDhsWHh2SUtnb3o1aVBYeGJSZktKU0x6ZGR2bFJRMDFiS1Ra?=
 =?utf-8?B?S3N5aWptdXBCOFh4N0JDSXpaNE9SQzYrcUV4WlgwVlVGdU00RmZpbDhEN3dW?=
 =?utf-8?B?ZEYwbmlzL2dmc0JFOTBKVUlKN0ZtT3M0UVUraWt1QXVUc2p6SHp1U1JJVkdz?=
 =?utf-8?B?UElMbHEzZTlrNjh0OVlCbnVMc2RxUzA1ZFMxalhSVU45VlBUcnJRUHNhcWIv?=
 =?utf-8?B?TzFOTk5NNllMMjlsMmdzdz09?=
x-microsoft-antispam-prvs: <BN6PR11MB16998029FC9F48D7DC5D8FD6F0660@BN6PR11MB1699.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(186003)(6246003)(478600001)(476003)(446003)(53936002)(6512007)(11346002)(53546011)(6506007)(97736004)(66066001)(229853002)(386003)(486006)(72206003)(68736007)(2616005)(26005)(106356001)(31686004)(25786009)(31696002)(4326008)(105586002)(102836004)(86362001)(36756003)(305945005)(76176011)(99286004)(256004)(316002)(7416002)(6916009)(52116002)(81166006)(6116002)(6486002)(14454004)(3846002)(6436002)(81156014)(71200400001)(71190400001)(4744005)(2906002)(54906003)(8676002)(7736002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1699;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mBztm7UCR+0dYMic4XfCyt1V3Ju8pt2MtKCNMDiysq6OreFGgY3JDO8psS6TS37N5DhJvzqzstkZBGyx9AoSFA9dOe4eOkD2H/2BvjkpMxnFEYS1SNPnec+CCzUZP77i/Tg7JaiuMGRwos8lTX05b7xj1EncygQqNfaHqyVSCjFxixah1fv8Fo8I8zacMX8Di6Ah1Mu9xHeiR5Yw+hjp8KMIVg2n5BSZV3ElcrZS3/naPiBn4WhPYhp9QXVGuIN1d9tJu1lswZTHhCEoEAQniyiCwYbOtLPdz6MonbRRnBXfN+yXsXOBIdFZfwvLxWqqtyyUUww9iZaVNdVoTfFyr4YDYFdyaf9MNUZr4xOaCcDr4B8FgFI46rgDDSQ9XfIJMSpGJqEoY9q2r7CBkRK/em5rW8u476UMtYXjr6yY4uQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EABFF74BBE5E954CB73CA2C7BAA5210B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8f8a0b-7980-4026-732f-08d691a1965f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 10:54:09.4113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1699
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzEzLzIwMTkgMTI6MzkgUE0sIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBI
aSwNCj4gDQo+IE9uIDEzLzAyLzIwMTkgMDk6MDA6MDUrMDAwMCwgVHVkb3IuQW1iYXJ1c0BtaWNy
b2NoaXAuY29tIHdyb3RlOg0KPj4gLQluYy0+ZWJpX2NzYV9vZmZzID0gKHVpbnRwdHJfdCltYXRj
aC0+ZGF0YTsNCj4+ICsJbmMtPmViaV9jc2EgPSAoc3RydWN0IGF0bWVsX3NtY19uYW5kX2ViaV9j
c2FfY2ZnICopbWF0Y2gtPmRhdGE7DQo+PiAgDQo+IA0KPiBUaGlzIGNhc3QgaXMgcHJvYmFibHkg
bm90IG5lY2Vzc2FyeSBhbnltb3JlIGFzIHRoaXMgY2FzdCBhIHBvaW50ZXIgdG8gYQ0KPiBwb2lu
dGVyLg0KPiANCg0KaXQncyBkb25lIHRvIGRpc2NhcmQgdGhlIGNvbnN0IHF1YWxpZmllciBmcm9t
IHBvaW50ZXIgdGFyZ2V0IHR5cGUuIGRhdGEgaXMgb2YNCnR5cGUgY29uc3Qgdm9pZCAqLiBuYy0+
ZWJpX2NzYSB3YXMgbm90IGRlY2xhcmVkIGFzIGNvbnN0IGJlY2F1c2UgYmVsb3cgaW4gdGhlDQpz
YW1lIGZ1bmN0aW9uIHdlIGFyZSBtb2RpZnlpbmcgb25lIG9mIGl0cyBtZW1iZXJzOg0KDQpuYy0+
ZWJpX2NzYS0+b2ZmcyArPSA0Ow0KDQpJJ2xsIGFkZCBhIGNvbW1lbnQsIHRoYW5rcyENCg0KQ2hl
ZXJzLA0KdGENCg==
