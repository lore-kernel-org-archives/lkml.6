Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC190C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700AB222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WUdG77Eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394234AbfBNHZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:25:28 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:29922 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfBNHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:25:27 -0500
X-IronPort-AV: E=Sophos;i="5.58,367,1544511600"; 
   d="scan'208";a="26258688"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 00:25:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 00:25:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk8YeZ0UUm6L+hSrX6uSRtuPDeFHLgSm8/beYT8YKQM=;
 b=WUdG77Eg0sEA5h+6rrnKzooRJdXBe+4pI6BWQrAE+VpJetIxdXxctdUokS5A23+tbET7dgozFNJnbsh+Laie4tQ68vVpQL04EgYQC/325pYEK5e/M8kw0WlV+Fx/txRgMvB8dSgReV1QCsfTxshBi6B2b3OekrcmVghMaKLVzaI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1460.namprd11.prod.outlook.com (10.172.21.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 07:25:22 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 07:25:22 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anuragku@xilinx.com>,
        <Cyrille.Pitchen@microchip.com>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 1/3] mtd: spi-nor: add Global Block Unlock support
Thread-Topic: [PATCH 1/3] mtd: spi-nor: add Global Block Unlock support
Thread-Index: AQHUxDZy/wu2R+oU006WVu2d37ZAMw==
Date:   Thu, 14 Feb 2019 07:25:22 +0000
Message-ID: <3626dadf-9fb1-b16d-d516-7e1e3056bc54@microchip.com>
References: <20180717162831.17947-1-tudor.ambarus@microchip.com>
In-Reply-To: <20180717162831.17947-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0003.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::13) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45dba986-2b93-4c39-3b53-08d6924d9485
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1460;
x-ms-traffictypediagnostic: BN6PR11MB1460:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIxNDYwOzIzOndwUFZ6M1p0NXNIUjNaYlNtR3JzQk1LcldN?=
 =?utf-8?B?TUNyOGhaVHhjQkdZNmpZRmorMkNjNGtPODJtcEZWcHE2ZGltekF2VnBiQ2Rm?=
 =?utf-8?B?a3pBYXRIaTdQU3dtRzJVMUFCdFFrcFRpWmlYVTlDRXpONFB5WVk2dW9GWHNH?=
 =?utf-8?B?aGUrNjFiSk4yNTR4WWxJeUU3OHNHUFpvY3V3a2h6a2tTRml4a3pZekVwcVc4?=
 =?utf-8?B?WmFPa2YwMENOL1MyKzZBbWlIYnc3aWYwV3JuREFJdm5VODBGc1pCcnhxZkVI?=
 =?utf-8?B?TzN6VEp2UUVWODZiSGJVcjkyRFgreWZiajUwblMvWktSbTFaWWxTdmpMMUlZ?=
 =?utf-8?B?eUVrRk85NXpsN1pLaWwzcjduZ1hWY0swTHNXRHI2K25rSXNCTFlDMktpaEhE?=
 =?utf-8?B?bWsxWUhDeFJyOE1FWGxwejN3akhCZW1kU2Jmd0RzTkE1RU1UbEdMV0g0TUZU?=
 =?utf-8?B?NndSa0hiYjNXWXh2Q3ZQTWkyK0txdGhZajlkd0p6a2c5eE93T1JabEltWTlV?=
 =?utf-8?B?YmJseEFqOHI0eW5UU2E0enJXdHQzNnhGRGplTm5iYkRIZWgwOUdTNmcyR0xu?=
 =?utf-8?B?TGlCYW52ekVyQjYydEI4aVJZSDlzQTIvQnZONXNsSFJ0b3duaUJvbGJablNq?=
 =?utf-8?B?QnN5clAwSTNZSm9kN0ZKTjB1N3ZjS0JkT3RDWjlwRWxzVlBIWjE1ZEkzTndV?=
 =?utf-8?B?bDdCZVVzb2s3WnJqWmZsaWJKL2JJZFBBTC9XeGtYVmhmMm1CSWovR1R0ZFBt?=
 =?utf-8?B?c0tINno5T3RCbFI4NzQ3YkplNG1EQnpoTktXMFNwa1NYTFJwVy9yK1dhK1Iz?=
 =?utf-8?B?ZjBlMGNJOWNPR0VNbSs4NlFZQnNscVZwNmR6ZHlUZS9mV1ovU2dvT2VCeWha?=
 =?utf-8?B?VUVsWFVyZmhRTzkra3JGZWJZNGZlV29FMUxvYTJ4ZDlpaEh5eVVQMllGT0xL?=
 =?utf-8?B?cVNhUUVLbGw1Z0lOZUlrbkpUOEFyd01uRlg4R3BiSVRGL1IzMWpRSll2OWJ1?=
 =?utf-8?B?eXNUV2d0MXlIU05MU2M4NEdNSzREVXpSWjNVMTB5elJnNXNIOHEyc1M0WHV4?=
 =?utf-8?B?S2V3UUlYTFB0Z0ZUS0QzejNsNjRseUdBNU5vdzhxNkhVUEJmQUF6YmVlbk5v?=
 =?utf-8?B?dXdlTEdjanhXb3dldGdHY2YwY2xDK0pFZzdTdWdwSHFlNU1kdGZQazJtZlcz?=
 =?utf-8?B?R0ZNZ3ZqQ1VvOGoyU0JNZXNkU1RXNWhsRHFuWVNMN2pwcVNheVB1TmFNeVo4?=
 =?utf-8?B?QnFJeEdnWS9rcTZKaG1ub3N0bDRtdWlTRWhaQzB6THJFV1cxNUVmOTZsN2th?=
 =?utf-8?B?Tmk3dFFvNC9EZ2lHRnplaW1IeW1JZXFBYnVsaHE2NzJYRVNCSjNjdDRzc0Ji?=
 =?utf-8?B?YXNMY3pHUzdYckFvWVR1Zmpja000QWhJVk80TGpZT2xiRndGZ2lnSndVTlEy?=
 =?utf-8?B?c1E2NGVTSGJGWEsrTEloWlNFYWYyaWJFQTZqZE1mNXBoU2tWRDdMOXV5QVRQ?=
 =?utf-8?B?em14bFZCejV3WlkvVTJOejFMeUJFLzM0RDFUZk44d2hKS21RQ056QW5DdEtk?=
 =?utf-8?B?TWZWRDhPMStadncxRVpFTXh4YWpoTG1jblRPOEdrV3pROFgydHVMb0tqQjcz?=
 =?utf-8?B?dlRneUs4bHhwMDVuSkFBNkE0ajlwVmY0Q1B4U09IVXRrMUNWNDhDRGpZbE5O?=
 =?utf-8?B?MmZXTUhEdk9rZG5ZSDgxS3JDdnc5NTBBL2FwZjJhMUpackx3MG0xUVR0cmxC?=
 =?utf-8?B?NC9TQS9pKzdLSFVCOVRxYU5YMEtxbFpxZjZLMUx6SGNMcW1iNFVza0U3Uysx?=
 =?utf-8?B?ZjRuR0Jva0oxMkVSTnNpbURCZ0RvSG9SVDB2RDRkNVFNSzh3ZlNieGl4UlpP?=
 =?utf-8?B?MjkzSm1sRFF6MkVvRjkwMkx3SHVIZkR5djFya05LbWJtOTV2L1dpOFFPK29M?=
 =?utf-8?B?Qk5mNkFzZE9nPT0=?=
x-microsoft-antispam-prvs: <BN6PR11MB1460C47DD4406C1772B100FCF0670@BN6PR11MB1460.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(51444003)(6116002)(86362001)(476003)(110136005)(31686004)(36756003)(31696002)(316002)(53546011)(6506007)(386003)(102836004)(186003)(2201001)(26005)(106356001)(72206003)(966005)(6436002)(99286004)(14454004)(105586002)(11346002)(2616005)(6512007)(229853002)(2906002)(3846002)(54906003)(6306002)(256004)(14444005)(446003)(6486002)(7736002)(478600001)(4326008)(305945005)(68736007)(2501003)(25786009)(8936002)(4744005)(71200400001)(71190400001)(76176011)(52116002)(97736004)(53936002)(6246003)(107886003)(8676002)(81156014)(81166006)(486006)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1460;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6Dh9Gx9xYTr7jMHFKPHIxHBG06+X6zC9LmajsQIEzmBUmHsiMkgzJSNyVGcK2cR0i0LTYbbN6GrCPwcQKzKktlcmqjAB+kxSKmfqpnLmAYJsIXTuiKCKJMPyZY2ID5IvuR3jUsoeD/eUJBEtlyEftQmZPJ6RKyeeojHLLmKTTzdAAtirqYu+YWR9oqIE48Xg2hq96icPRPgDBj5RtKUcGPp9jE4oxLCPnyXScGB0XToyyyYhfnqz/tyAedewQneb9KWzCIYS/2xCPTpLmXDFNY1lDqeGM9omnF6UbBcgxfoh0k+bmDYkFUIJ9PBQ3GJyZNE93MbBgSLJpHwE57P/kNk+CPPGTgY7btd7v3AeLHt5c3BANnDSfpsEaqNCOtXBBRtu6xdXtFVnhWpwG3pOMgZZ04JwFdcRv39rgcjsvzU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0ED9B39C33B574E8551CC30BB8EF148@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dba986-2b93-4c39-3b53-08d6924d9485
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 07:25:20.3735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1460
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA3LzE3LzIwMTggMDc6MjggUE0sIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+IFdlIGNh
bid0IGRldGVybWluZSB0aGlzIHB1cmVseSBieSBtYW51ZmFjdHVyZXIgdHlwZSBhbmQgaXQncyBu
b3QNCj4gYXV0b2RldGVjdGFibGUgYnkgYW55dGhpbmcgbGlrZSBTRkRQLCBzbyBtYWtlIGEgbmV3
IGZsYWcgZm9yIGl0Og0KPiBVTkxPQ0tfR0xPQkFMX0JMT0NLLg0KPiANCj4gTm90ZSB0aGF0IHRo
ZSBHbG9iYWwgQmxvY2sgVW5sb2NrIGNvbW1hbmQgaGFzIGRpZmZlcmVudCBuYW1lcw0KPiBkZXBl
bmRpbmcgb24gdGhlIG1hbnVmYWN0dXJlciwgYnV0IGFsd2F5cyB0aGUgc2FtZSBjb21tYW5kIHZh
bHVlOg0KPiAweDk4LiBNYWNyb25peCdzIE1YMjVVMTI4MzVGIG5hbWVzIGl0IEdhbmcgQmxvY2sg
VW5sb2NrLA0KPiBXaW5ib3VuZCdzIFcyNVExMjhGViBuYW1lcyBpdCBHbG9iYWwgQmxvY2sgVW5s
b2NrIGFuZA0KPiBNaWNyb2NoaXAncyBTU1QyNlZGMDY0QiBuYW1lcyBpdCBHbG9iYWwgQmxvY2sg
UHJvdGVjdGlvbiBVbmxvY2suDQo+IA0KPiBCYXNlZCBvbiBpbml0aWFsIHdvcmsgZG9uZSBieSBB
bnVyYWcgS3VtYXIgVnVsaXNoYToNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC83NjExMjcxLw0KDQpUaW1lIHBhc3NlZCBhbmQgbm93IEkgdGhpbmsgdGhhdCB0aGlzIHNob3Vs
ZCBiZSBwYXJ0IG9mIHRoZSBpbmRpdmlkdWFsIGJsb2NrDQpsb2NrIHN1cHBvcnQsIGFzIGFuIG9w
dGltaXphdGlvbiB3aGVuIG9uZSB3YW50cyB0byB1bmxvY2sgdGhlIGVudGlyZSBmbGFzaA0KbWVt
b3J5LiBXaWxsIHJld29yayBpdC4NCg0KQ2hlZXJzLA0KdGENCg0K
