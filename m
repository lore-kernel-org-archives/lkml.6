Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AD1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EAE20838
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UJvVEOcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393021AbfBMR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:27:08 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:24838 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390484AbfBMR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:27:08 -0500
X-IronPort-AV: E=Sophos;i="5.58,366,1544511600"; 
   d="scan'208";a="26503636"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2019 10:27:07 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 13 Feb 2019 10:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMV6OLA75rRJkR+5T1pl4e6Lz7g9lxu+izkLwRX35A0=;
 b=UJvVEOcU6kSBYJyxghSXXk0tKAuok82u4jClpZpf8Wskv0y8T1xHvffz/CyoeLLK90PTzQbQzUu/Bp5j/7WVgIdXGF13DnRA2H7f1eo+1rks95f99FgL/LUR5srC1uBsOgd6K90l9CoBozmXbbcvGOsivrguUhGgWoWaqcRu9Gk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1874.namprd11.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 17:27:02 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 17:27:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <palmer@sifive.com>, <marek.vasut@gmail.com>
CC:     <wesley@sifive.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <bbrezillon@kernel.org>,
        <linux-mtd@lists.infradead.org>, <paul.walmsley@sifive.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH v2 2/2] spi-nor: add support for is25wp256
Thread-Topic: [PATCH v2 2/2] spi-nor: add support for is25wp256
Thread-Index: AQHUu8lZNYJ2Ubpy8EavTZ/VcmOfWqXeCw0A
Date:   Wed, 13 Feb 2019 17:27:01 +0000
Message-ID: <ef174850-93df-6032-c742-68237c37afde@microchip.com>
References: <20180807194059.26348-1-palmer@sifive.com>
 <20180807194059.26348-3-palmer@sifive.com>
In-Reply-To: <20180807194059.26348-3-palmer@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0085.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::11) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99db9984-e1c0-4b3e-9b2a-08d691d876ff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1874;
x-ms-traffictypediagnostic: BN6PR11MB1874:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCTjZQUjExTUIxODc0OzIzOlM1L2N2MDhjUnBWMEN0a21yVTFiVWdicHIy?=
 =?utf-8?B?ZzJmcEhUTWtnMDUvNkhCTFE1NEQ3NStQbysydTRjVzNUS3Bqa3ZneWhnSmVi?=
 =?utf-8?B?VklwcHBMN3ZlcURnZXY3ckY0SWRjRFNtZDkyejBiZy9tRmRTTkxmNSt0NUF0?=
 =?utf-8?B?dDc2dzdwdU9Ibm9RQ3VyWG56NkZqOFFrdkcrbUZRN0U1L0lNeEt2eTdCTHIx?=
 =?utf-8?B?OGI4K295L0FTOFBlN3JQUFFJTlZHNkxOU2dqZWs1UStKeDBrYXZ1OXNGeFBK?=
 =?utf-8?B?TkwxQk9SajYrSFRCclB0OEpjS1U3ZVhocWNiOGF0cU9GVWhSeHJuTC84bDVm?=
 =?utf-8?B?Y3FYaCtGVzl1OUtyZ2h3MThzZWhBTVZqS01VZE8vditFNnhES2Z5Yk9TMW52?=
 =?utf-8?B?NmcycWJVaXJhS0hTbVRjbXZsRTdtL0pMQnorYVJKZDhNbXJ5OGkzRFptMHc0?=
 =?utf-8?B?RS9tZ0poRmRCeFdtMmtQNWlkTitHVnprbE5RYzh2NHBRbjNyQk83VTI3VDVH?=
 =?utf-8?B?WkVVSXJMNWZMaVVIdkxxb24zNUhjZEZyM2d1SWJhMUQ5OGZWRXlkUHZIenNt?=
 =?utf-8?B?bCtHd2Vvem51eVZPekxQRTlGa3B2VU9jd0ZjSFNLR1R4MDlwNzhCbm9HQ3cv?=
 =?utf-8?B?bU8zVU1odnhNNUQxMHdDVkVhL0RnRUR3UVlCeE03RDBOZldxc1Jzbk9ETXFh?=
 =?utf-8?B?N3dvcjl6RkNmMisvSWQ5R2twaTZaMFdtUG12blcycEZoNmJndHJIRGdua3lu?=
 =?utf-8?B?bjk2QWFmaHgzNmJKY3QzOEZIakhudWpiTkhsNm1xbDJMTlhCTFVaYXF4L0tE?=
 =?utf-8?B?enVaSWQvZ2JpUC9nY0NGZFlxczlTZWd3d3NUNU9XdW1hT3N2NnRNL2J3UFNx?=
 =?utf-8?B?VHl2ZmorNTNrd3J2MU1yY0lmeUs4ZEpjeU4xdVk2RUwwMGQ3b0JOQ1lRV2NR?=
 =?utf-8?B?TEdPOWRLOG1HNjlmTVZiaG5xY1ExTm5YbTBYRVZ4aG0wOXM3d1ZmUk9BWndl?=
 =?utf-8?B?UnVSSFVubjVJalZHUDdlTFg0ZWYwaEF2RkZSNU5YN2cvRzJMcktQNWVwSC8x?=
 =?utf-8?B?VjQ4dFFHcFBQUjRHK0R6SXNGemdsTlZjdkNWMVg3akoxVmdTMEc5NXBxTExl?=
 =?utf-8?B?VktUU1hORW5PVkhxWnBHNUZYTitnSlptcTVyZEFhdWIzZzA2T1kyVzJPbCts?=
 =?utf-8?B?aTQvQWU0QjI4dDExUWphN252b0ZZS2VHYU15ZVlvYmEzbU4rN1loaStDdWJJ?=
 =?utf-8?B?R3Z2ZjNUbzd1R1ZhalF4em91aSt2cDFyVldYb3ovWFVtQXdIaFNFWXMvaFBj?=
 =?utf-8?B?cWd1VGgzenQ2alR5QmJDYzZZNEtyd2VaZ09lbFZ3M1QvZUZPUkN0cTVBMXQ0?=
 =?utf-8?B?UkpudXBHUitwY1I5dWN2aGdUSE4zeW5NVTBLK0I4bUxmN05XOE1GNkJVNEhS?=
 =?utf-8?B?TEo2cEVuN3lEQlZyQ05UemV1Y3FXbnFMVEVMWHlNdEpvR05QR2ZQK1QxS2NY?=
 =?utf-8?B?ZEVSZ3l4MDltZ25POWJNKzQ1STNPcTRnYWg1OHhGNFUzd0JiN1E3VlFWSjhE?=
 =?utf-8?B?Y2VZQmlCcjR3cjJlekpiNTVobVlsZVhkRVhNWnd3V0oydlRsMW1HQ0hTSmIz?=
 =?utf-8?B?dzJOSDNRdFkwZHN4dURKY0R5b28yNkp6bWNoRnpWUy9EZVlEamRjZ2lQbWRj?=
 =?utf-8?B?dlNMbjdxS2g0dFc3SGxldVdIWXRaRGRGNGdiR0NhNTkrQ28rWWtrb2pkdHh4?=
 =?utf-8?B?cFpYTUtkdTJaUVdCc2k4d05uOXAvbTFteVB0cXBkVVBmNTUwUmpFN3paYlRl?=
 =?utf-8?B?R2RyY041YlhvNDVOZ0lhRDNLNUlwMVEvakgrWGxGbzFIeGRuODBVNGdyby92?=
 =?utf-8?B?QkpodXZudDczR1Z1My9JcjZaM3YwZGV5ekVqV1FMRmlVN2xxZFJJbGI3em4y?=
 =?utf-8?B?LzdmNHpCSk1RPT0=?=
x-microsoft-antispam-prvs: <BN6PR11MB187413826E67A3CB083FE6EEF0660@BN6PR11MB1874.namprd11.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(8676002)(305945005)(8936002)(81156014)(256004)(36756003)(99286004)(81166006)(7736002)(52116002)(76176011)(2501003)(316002)(7416002)(110136005)(54906003)(2906002)(71190400001)(71200400001)(14454004)(6116002)(6486002)(3846002)(6436002)(66066001)(229853002)(68736007)(486006)(72206003)(476003)(186003)(26005)(97736004)(53546011)(6512007)(386003)(6246003)(2616005)(446003)(11346002)(478600001)(31696002)(25786009)(102836004)(86362001)(31686004)(105586002)(4326008)(106356001)(6506007)(53936002)(138113003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1874;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O6TbOEEGyNPtHgGOvYZ9+mivYGjZfRCVjd5ZIx1MCSzgfO/6y+PDgqCsBB/YB3yf0+JsQ5mrQK0Mly4r5st/4oaWJ9vjYu/uHu3gWKy2l6nGUCw40h6b4TlvC4QF6usgF3DGYNTjXQ6HgvuCPUvm0w39I6KqJb74ZZ81fW4Ht4vinOYP0PG3+Aa3OrCuWR7rW/0Iy/FEB5JI2sX7xUfxnSnGfWJO0hVru+HZM+3OU3rC0QwsH2B6aB2t4Q1S54ofu7eggAezHsp9uvgrmYtQ84VoBAjpxVytxBhqGu12Oyn0ragAORZ0CJc7pS56nSRVtk118fEU9Co5QaZoiCZHPOcTF+jodxVDNprPtEBwY+p8Wvu1AOKt+TpO2R/8Fkxwk9PduGYafjO90etWUv4pLjm2PcDfLW1UE7F20v7Yiy4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <359DF4E7C2F53745AC51F8A25E428AE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99db9984-e1c0-4b3e-9b2a-08d691d876ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 17:26:59.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoaXMgb25lIGxvb2tzIHByZXR0eSBnb29kLiBZb3UnbGwgaGF2ZSB0byBzdGFydCB0
aGUgcGF0Y2gncyBzdWJqZWN0IHdpdGggIm10ZDoNCnNwaS1ub3I6IiBpbnN0ZWFkIG9mIGp1c3Qg
InNwaS1ub3IiLg0KDQpXaGVuIGluIGRvdWJ0LCBydW4gZ2l0IGxvZyAtLW9uZWxpbmUgb24gdGhl
IGZpbGUgdGhhdCB5b3UgYXJlIG1vZGlmeWluZyBhbmQgc2VlDQpob3cgcHJldmlvdXMgcGF0Y2hl
cyBhcmUgcHJlZml4aW5nIHRoZSBzdWJqZWN0Lg0KDQpPbiAwOC8wNy8yMDE4IDEwOjQwIFBNLCBQ
YWxtZXIgRGFiYmVsdCB3cm90ZToNCj4gRnJvbTogIldlc2xleSBXLiBUZXJwc3RyYSIgPHdlc2xl
eUBzaWZpdmUuY29tPg0KPiANCj4gVGhpcyBpcyB1c2VkIG9mIHRoZSBIaUZpdmUgVW5sZWFzaGVk
IGRldmVsb3BtZW50IGJvYXJkLCBhbmQgZm9sbG93cyB0aGUNCj4gcGF0dGVybiBvZiBzaW1pbGFy
IElTU0kgZGV2aWNlcyBhbHJlYWR5IGxpc3RlZC4NCj4NClBsZWFzZSBhZGQgYSBjb21tZW50IGFu
ZCBsZXQgdXMga25vdyBob3cgeW91IHRlc3RlZCB0aGUgZmxhc2gsIGl0J3MgYWx3YXlzDQpjb21m
b3J0YWJsZSB0byBzZWUgdGhhdCBuZXcgc3VwcG9ydCB3YXMgYWN0dWFsbHkgdGVzdGVkLg0KDQo+
IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBXLiBUZXJwc3RyYSA8d2VzbGV5QHNpZml2ZS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAc2lmaXZlLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkt
bm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IGluZGV4IGFh
YjkzNDYzYTVlNy4uZjEwMDE3YjQ1NDNkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGkt
bm9yL3NwaS1ub3IuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiBA
QCAtMTA3Miw2ICsxMDcyLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHNwaV9u
b3JfaWRzW10gPSB7DQo+ICAJCQlTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9S
X1FVQURfUkVBRCkgfSwNCj4gIAl7ICJpczI1d3AxMjgiLCAgSU5GTygweDlkNzAxOCwgMCwgNjQg
KiAxMDI0LCAyNTYsDQo+ICAJCQlTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9S
X1FVQURfUkVBRCkgfSwNCj4gKwl7ICJpczI1d3AyNTYiLCAgSU5GTygweDlkNzAxOSwgMCwgNjQg
KiAxMDI0LCA1MTIsDQo+ICsJICAgICAgICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxf
UkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KDQpZb3UgbWlzc2VkIHRoZSBTUElfTk9SXzRC
X09QQ09ERVMgZmxhZy4gVGhlIGZsYXNoIGhhcyA0QiBvcGNvZGVzLCBsZXQncyB1c2UgdGhlbS4N
Cg0KQ2hlZXJzLA0KdGENCg==
