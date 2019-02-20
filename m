Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CDEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D692089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WduY9zbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfBTUtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:49:12 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:8031 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfBTUtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:49:12 -0500
X-IronPort-AV: E=Sophos;i="5.58,392,1544511600"; 
   d="scan'208";a="26627370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 13:49:11 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 13:49:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mm4wT/NLOdTrQALZyVdbSxKHczzfmWEunlk4RbeANbE=;
 b=WduY9zbwIDB+uM8JtNumNuAusijdBNY/iMGt92jvNPzaa4UAUA8Be5QsAvurt1mKqjXnMYALIRAJ38pggUuEtVKR2YcHjdWxHkatLMMcuDoZnhhDQAvDxBTSwygTiGDC1YOJ8tb0iqyvBz3r97/r1BjKvEMYHtHf6r378mwDm5w=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) by
 DM5PR11MB1897.namprd11.prod.outlook.com (10.175.87.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.20; Wed, 20 Feb 2019 20:49:09 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1%11]) with mapi id 15.20.1622.018; Wed, 20 Feb
 2019 20:49:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <frieder.schrempf@kontron.de>, <marek.vasut@gmail.com>
CC:     <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: Add support for MX25V8035F
Thread-Topic: [PATCH v2 2/2] mtd: spi-nor: Add support for MX25V8035F
Thread-Index: AQHUx4KDfFE6B3CJYkGZ26wCQda7VaXpLGQA
Date:   Wed, 20 Feb 2019 20:49:09 +0000
Message-ID: <b471c532-00b5-55d5-14ee-ec09fd98b970@microchip.com>
References: <20190218120421.5034-1-frieder.schrempf@kontron.de>
 <20190218120421.5034-2-frieder.schrempf@kontron.de>
In-Reply-To: <20190218120421.5034-2-frieder.schrempf@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::27) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:114::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.52.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a82b1945-a982-4612-41eb-08d69774dc7b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB1897;
x-ms-traffictypediagnostic: DM5PR11MB1897:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjExTUIxODk3OzIzOllHLzM3VVR1MHYyWTFBeVlVNHRYVFB5aWtV?=
 =?utf-8?B?RUhNSEJUa3JYbCtVVm80c2x6MmhYL3c0WjlxallQcXl6UmlqY0FHaXhacHo0?=
 =?utf-8?B?VDlGYnN1TStaWlplV2p6Y2FpL1M2N3gxdzdtaG4zckswa1VnZTkrWUtuK005?=
 =?utf-8?B?ZjE3R21MTmF6blJsN2k1LzJuajNsMnVEdUlOOC9WQzU2U2hLcDA1cG8zeTBJ?=
 =?utf-8?B?SDBZTmgrT3JrNDg5cGpQTldvYXNNMTEzZVJnMzI1RHdrSTgrNXEyQ1hKTUJE?=
 =?utf-8?B?WENhN1Uvd0FJai94clNQREliYzlIQzhvL1FZRG1pTGlJQ0E3V1RwNjVNWElT?=
 =?utf-8?B?b1lBWHdwM2wyOEIyVDZ4MHZmWFI4L1Q2anhxbk1LNSt5b2JmZyt0TzU2RndM?=
 =?utf-8?B?RXRwVXI4dlNOQ0FXSmQ2QmdpcVdlNGViZnFob1BxdFhITlhuQ0lOSi9JdXFM?=
 =?utf-8?B?YmZuRWVCbi9NWjduT2FQYW9SWjh3TlUvLzkvOEVMQ1FTY1FkVytkUkVEbnNI?=
 =?utf-8?B?aUZSdmY2VmZsQmFpUGJEZW5Bc2FYRE1KR3l6bHkvTUVSZHRVbjVkVEtMSmdH?=
 =?utf-8?B?cDN6aitCQlkxUm9nTG9KM2ducEFLcW82eVk0TlRBSTNza21JY1NDSFBPQXhE?=
 =?utf-8?B?bTlSSkFUa21ZNVd2RTBKUjFlS2lIdmR0M3Y3QVZkVDVmbVVsVnNYeTk2M3Jw?=
 =?utf-8?B?QVVmSFV2bDlRYkthQUU1NHlvYzJEd3BpR1JFWGowMGFUcS9SekdDMm1ENkFB?=
 =?utf-8?B?eExnUGI4dWpHMEFua2tuUFF6d0ZOSVhXSkNWeTYwSWt6aExsY2NJVE5oaitE?=
 =?utf-8?B?RnVHVnZ2N2hTblpoSDkvRUZJTlRkYTJMcWEwWm9OYnpKMEFZdUlBYlhkbGsr?=
 =?utf-8?B?L1JPdGMwWVlnbVVQYTAvbmJ5Zm5tNUdRZWVlUFBtd1FLTC9sYVdJaXlKanE2?=
 =?utf-8?B?S0cyNkhNS0FrbGdqNzVyV3VWZVNPY2txUFgzZHlVeTkyZjRHQUI5M201Znhi?=
 =?utf-8?B?Vk9seWhCb2EvR0lCZGkveTFTQm5nL3hMVC9TOHVxenZFbHZJaW1IblJ5YnMv?=
 =?utf-8?B?YWJucG42N3krWTlLRlRqdy9lRk1RejN0T0tRQ29jMXlXK21GNUpURU95aUM1?=
 =?utf-8?B?bXZ6SDFmUzRLQ3MwbWlZOGZOakc0cnZ3eEVtYndMbjJ0d1VBYmJGS0oxSmt2?=
 =?utf-8?B?S2hSdVdNYVN3b0pWYUR6Vy9Ya3Ftb1ZlREdQOThQVk81Wk5GWG95T0VUYTVm?=
 =?utf-8?B?OXhuSlBJNmVFWEcxdW1ybmtoZmVtY1MwZXlmclA4Z1JVQi8rZjV6S0Q2V2tq?=
 =?utf-8?B?RU1jZGxRUmplcVhXLzk3NE0wYmhWbXBCU1BlTVhWZ25SdVNydUhVWGtuYzZL?=
 =?utf-8?B?T3RWNHA0Z2JlTDAyclVGTHpheVdLSXV6T29GbnR4NXBZRTBIcGk2R29ZcE56?=
 =?utf-8?B?ZE5iODg2UWZLbzl2eVJva1h5eEdaR21EaFZnRndNRjVkb24yZ2tGejNkaFVv?=
 =?utf-8?B?aTBZeHBtYU1TWjlBNTN5WEdEZVBmL2loYnhLU1YyKzlWMXJiUEVEVHYxWGcx?=
 =?utf-8?B?QjRTM3N6azdGVm9JNVAyeWZYZjhnVTA1LzVRVzl2QklCbERvRFJKeUsvRmh4?=
 =?utf-8?B?RVVSUThWZWx1TUR6VmRwYkJYZExKdUQvdWpVaktmYzYyTTh4MFZnSVEwbDJw?=
 =?utf-8?B?SVQveVBXUEpFQjRxdEE5bStCMTY1N2VERTI3SzRTVnczaGpmcGxJOVZ6RVFP?=
 =?utf-8?B?K1RqK1ZZNDBJSUpHcUp1Zz09?=
x-microsoft-antispam-prvs: <DM5PR11MB1897FFB088ABB939B421ACBCF07D0@DM5PR11MB1897.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39850400004)(136003)(376002)(366004)(189003)(199004)(71200400001)(256004)(2906002)(6246003)(71190400001)(81156014)(8676002)(25786009)(4326008)(72206003)(81166006)(14454004)(486006)(6486002)(106356001)(68736007)(31686004)(8936002)(6436002)(186003)(476003)(6512007)(11346002)(2616005)(478600001)(105586002)(386003)(36756003)(86362001)(99286004)(31696002)(53546011)(52116002)(97736004)(5660300002)(6116002)(102836004)(446003)(53936002)(76176011)(66066001)(305945005)(110136005)(7736002)(6506007)(316002)(229853002)(54906003)(26005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1897;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3nqjjEiTlQN3Ha5fWzWASiMWXb8yd80SFDcDClFiOwA7O2nrzeuMIyTsJUU6Ii7aI0fYgms0W1DJFOzVu4cJxQT4Fu/7GldMTEwmOwM91NtDEmKBvBiv25OmmzsgYKIqdehL32A7TF7et38tUdSVYjusHqn2SDh8sTdj/TYUAWhSre2DJOEoZok99hya81plnnlocY0BqEQhYbp4YHRPunEoQEL6x19ji4Z8kuqlmeCx/81FMv1JZa1FqSihqN9aWaGnNMBALoKxWoz/EhqQiziGYg0c5rLJiEkNXqmRbe9afEOBG1bo35gdGBOTo4LMKHJMQlQSkoKHfFBXumaYSWMdf08MaeZ/vL8NqXx4uPPpipQiDlQRf8VEOPvqfIMORtmDcsbE8K2zU+mvdYSY5f/tLWIeQKGgjpwXjLOdKXs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7FD16909B6C3C4E8B245A8CEFB2BC6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a82b1945-a982-4612-41eb-08d69774dc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 20:49:07.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1897
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzE4LzIwMTkgMDI6MDQgUE0sIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+IEZy
b206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gDQo+
IFRoaXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgTWFjcm9uaXggTVgyNVY4MDM1RiwgYSA4TWIgU1BJ
IE5PUiBjaGlwLg0KPiBJdCBpcyB1c2VkIG9uIGkuTVg2VUwvVUxMIFNvTXMgYnkgS29udHJvbiBF
bGVjdHJvbmljcyBHbWJIIChONjMxeCkuDQo+IEl0IHdhcyBvbmx5IHRlc3RlZCB3aXRoIGEgc2lu
Z2xlIGRhdGEgbGluZSBjb25uZWN0ZWQsIGJ5IHdyaXRpbmcgYW5kDQo+IHJlYWRpbmcgcmFuZG9t
IGRhdGEgd2l0aCBkZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZy
aWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMg
PHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gPT09PT09PT09PT09PT0NCj4gKiBBZGQgaW5mb3JtYXRpb24gYWJvdXQgYm9hcmRzIHVzaW5n
IHRoZSBjaGlwIGFuZCB0ZXN0aW5nIHRvIHRoZSBjb21taXQNCj4gICBtZXNzYWdlDQo+IC0tLQ0K
PiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5v
ci9zcGktbm9yLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiBpbmRleCA3ZDc0
MzZmYWNjNTcuLjQ0YmUzNGMxZDJjMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5v
ci9zcGktbm9yLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gQEAg
LTE4NDksNiArMTg0OSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzcGlfbm9y
X2lkc1tdID0gew0KPiAgCQkJIFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQp
DQo+ICAJCQkgLmZpeHVwcyA9ICZteDI1bDI1NjM1X2ZpeHVwcyB9LA0KPiAgCXsgIm14MjV1MjU2
MzVmIiwgSU5GTygweGMyMjUzOSwgMCwgNjQgKiAxMDI0LCA1MTIsIFNFQ1RfNEsgfCBTUElfTk9S
XzRCX09QQ09ERVMpIH0sDQo+ICsJeyAibXgyNXY4MDM1ZiIsICBJTkZPKDB4YzIyMzE0LCAwLCA2
NCAqIDEwMjQsICAxNiwNCj4gKwkJCSBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElf
Tk9SX1FVQURfUkVBRCkgfSwNCj4gIAl7ICJteDI1bDI1NjU1ZSIsIElORk8oMHhjMjI2MTksIDAs
IDY0ICogMTAyNCwgNTEyLCAwKSB9LA0KPiAgCXsgIm14NjZsNTEyMzVsIiwgSU5GTygweGMyMjAx
YSwgMCwgNjQgKiAxMDI0LCAxMDI0LCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9S
RUFEIHwgU1BJX05PUl80Ql9PUENPREVTKSB9LA0KPiAgCXsgIm14NjZ1NTEyMzVmIiwgSU5GTygw
eGMyMjUzYSwgMCwgNjQgKiAxMDI0LCAxMDI0LCBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQg
fCBTUElfTk9SX1FVQURfUkVBRCB8IFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCj4gDQo=
