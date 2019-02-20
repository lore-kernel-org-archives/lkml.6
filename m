Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16242C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4092089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tuJBJex9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfBTUoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:44:37 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:40776 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTUog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:44:36 -0500
X-IronPort-AV: E=Sophos;i="5.58,392,1544511600"; 
   d="scan'208";a="27026910"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2019 13:44:35 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 20 Feb 2019 13:44:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTRFXDZ58hNg53xN+EKHquT1NhOcpnclr7i/U9aK8Zs=;
 b=tuJBJex9lS6pTj2/Xpo+fqScYk4o+zAzkzBijqVP0GEfdthajMlbjG8YYw8u6WUhEl6OSpuCNFZBn4ZDLjZi/92cL8F5ECyd6xdN6pPuHiUqtB++1mfI5pCfCuOX30rFiKT83phYVM8MebI5gHQg1FlgamXkHN3w4WR6K1R9p2E=
Received: from DM5PR11MB1850.namprd11.prod.outlook.com (10.175.92.17) by
 DM5PR11MB2057.namprd11.prod.outlook.com (10.168.107.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Wed, 20 Feb 2019 20:44:33 +0000
Received: from DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1]) by DM5PR11MB1850.namprd11.prod.outlook.com
 ([fe80::4125:8d55:234b:a4a1%11]) with mapi id 15.20.1622.018; Wed, 20 Feb
 2019 20:44:33 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <frieder.schrempf@kontron.de>, <marek.vasut@gmail.com>
CC:     <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: Add support for EN25Q80A
Thread-Index: AQHUx4IiJS154BEowUOup13mq/gQ7qXpKxqA
Date:   Wed, 20 Feb 2019 20:44:32 +0000
Message-ID: <137c7e1a-0cd5-269b-1854-ce8666d7dc50@microchip.com>
References: <20190218120421.5034-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190218120421.5034-1-frieder.schrempf@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0101.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::27) To DM5PR11MB1850.namprd11.prod.outlook.com
 (2603:10b6:3:114::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.52.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 103539de-f60f-4805-3553-08d6977437aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB2057;
x-ms-traffictypediagnostic: DM5PR11MB2057:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTVQUjExTUIyMDU3OzIzOnlyQW5EUSs3elJWcjduSkRkU1lXUVlRd2NF?=
 =?utf-8?B?eVhQZy9JdFJ4UFBuejZreXNocXlyV2tLUXBJRWRSYWlhNWZvenJjRERwZUV3?=
 =?utf-8?B?clZ2QlNXWWh0MGNHWFoveDF6MWVzN2lRaVpZMjZNYjlrQ3FRTmpYdk8xVEZ5?=
 =?utf-8?B?TnBuMHE3Um9BcU92NmdGdzV0M083dmh1Y1JjckVVM0thY3lTUVA5emQ5VTlz?=
 =?utf-8?B?L21SaXdsVDNZa2pqV29Lc3lhYWVpTmw5eTEwblQ5WEtmTTZzMzVsVmpVSzJS?=
 =?utf-8?B?d0FiNzZtNHNuVEJZamRLR0R3cGRONnlrcCt1SS9WRFQ2ZWlPdGZSbkZnVzFP?=
 =?utf-8?B?SFZEY29rMXQ3bExwUjg1cUJrTHlNRGNzVEhLMmYxb3RyN01WZ0JXcEZxZ3Q4?=
 =?utf-8?B?MHZPY1cvdXRuK0Q2WG1lbDhLWVhyS3BHZGZJTVlNTlprK05BeUprOEdHSGdj?=
 =?utf-8?B?WHhxSi9BaFNaQi9UTEMyWk9NaDR4aDQxQ1hJZ3dSSzNmZ0NpejZDUUFqbVZQ?=
 =?utf-8?B?enk2dkdIejF6WHNFQ2Y4TTVjc0NzWC9HbW13ZXhFd3B4U1ZiZ3JLZkRKTVN4?=
 =?utf-8?B?cGNlU2VvRGpSVVlJR1hqTEN5T0crZWhydXNZMzh1dFNqVHA1NU1hZVFaMjNX?=
 =?utf-8?B?cHVUK3I0YUVkK1ZTYko4bG4vbVJnd3M3UTZYY1pibUd1bVUzQzdvaG9BQklM?=
 =?utf-8?B?MHd0NzRvUEtoUENDcE9YMVJCTzF2Y1NZODJhdVkrY2Rkb29ZSzBPOXpWNmpp?=
 =?utf-8?B?YjVnTUdrZzFmTnNPWUF6a1hNckszNC9ZcjBSRXJyVnU1V2M1VHVneGR3MzdB?=
 =?utf-8?B?WFAzM1VobUMrdlhHdzVxeGtmRllxWUFqTzBJMnR2c0IrVjhkS1BPeVQzZy9W?=
 =?utf-8?B?YmQrZnZnOVRKckJhV1FQbm8vU1VrdENvSVh0Q1FUZzdlVnNTZjNCVmtHbzRp?=
 =?utf-8?B?Q3ZIU1k5c0Fwd2VOYXFuRFAvRUIwWml1d3BXb3NJdEdsTEFLRmEybVh3TmpK?=
 =?utf-8?B?Vk5lK0hwMTdrMElWKzJ6SHhrczNybjZEVGlzeFFoYURZcEZFRnRMTk51WFpq?=
 =?utf-8?B?OGhmRnMzREJmWTZaL2Q4NzJKWGdxSERlWEQvZ09qZmpDamt5M1lUMGhpNURi?=
 =?utf-8?B?cU0xanBMY1RBNE9SdWhMS1I4RFJMR01ZRlNDNDJmY3UxUER2Q2pzNWRDa3J4?=
 =?utf-8?B?MHNJR1phZG1qL3kvcGpMNERvUW5MMk5BZ1hLLzFhdVVzM2xzUXBWYzBBSGZM?=
 =?utf-8?B?UXF2TVFqVW5uWDZjVGRFdTcrRVlIcFlZQjQ4WXVOR1Eya1BIZWE1MjZZRjJo?=
 =?utf-8?B?VFE4NGRWd2YyVnB4SkpPR3crRjlWYjA4NC91dnlKcE91VGIxd1ZvMWExYnFu?=
 =?utf-8?B?MEhvaXk3YS9OTldtRWZ1TlEwWm5VeDlDTlhNcVB0cytEZGlqVUV3UG1pcVRs?=
 =?utf-8?B?RzA5cDRTOEVrUzFpZjNWTmRIc3RjbDZoTmxxVk5RMHdOOTZDazB1WkI4Wngy?=
 =?utf-8?B?VU5QZG91SDFHTHppdFIxL05ONUZjVDZzZVhDbnV3aU1kREdFTEpqdkh6Vjdm?=
 =?utf-8?B?NWVDaUFVVkl4d0pCcEVtSFY2TFIvdTZyN3p5dElkdDZSQlRZaDljN3Y5bDgr?=
 =?utf-8?B?Ym1PaHAzUThuaG9FeGR6bEJvdElaY295aXFYbnJ5dDdrVG0wWTFEYk5WQ1h0?=
 =?utf-8?B?SGF4QldKYnlUbzdWODc0U29Mb24wRVM2UGVhYzU3UUkrdGNZQ1A3STlnbm1U?=
 =?utf-8?Q?T7nvmUiqodK9P2TyXDTiAzjbv6ZpJHCNTR/2U=3D?=
x-microsoft-antispam-prvs: <DM5PR11MB2057A07B30C681C8ABB2F794F07D0@DM5PR11MB2057.namprd11.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(31686004)(476003)(66066001)(106356001)(53546011)(14454004)(52116002)(2906002)(11346002)(229853002)(105586002)(186003)(86362001)(446003)(5660300002)(2616005)(6486002)(26005)(6436002)(4326008)(25786009)(31696002)(81156014)(81166006)(8676002)(102836004)(71190400001)(486006)(71200400001)(110136005)(99286004)(68736007)(54906003)(97736004)(386003)(7736002)(6506007)(36756003)(3846002)(8936002)(14444005)(256004)(316002)(478600001)(76176011)(6116002)(6246003)(72206003)(6512007)(305945005)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB2057;H:DM5PR11MB1850.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O6wmkWwjOy3klhUIGgQFuzmTrM4jpLfa5Fs4AsjNHokDa/sgLwBN0pnoKmcMtHFYii0uaFlQI8PGeQyfLJu8bURQxPVVHne+9xZn/i6AJECCVECElL0WTSD0YPQi4NTuGM0+Hm74lYUxixwPu38OwEVjCg9GTsB7pIDNsyzQBuPRjyX6wZkamGIGawEmZDVktDhNh9TOODdP5KyLr0V/MUBW5Mp8g0uGjWVKSQEiQKLolmRn0/Oi02eXGJX6fj/ZpiR+HjJbJ93tGBikbOqw7zZY6pwSAlbbJu2gWy9y0mEM5ZzeYo84XSkD+COuEY3kyLME9i/FcFV2zjwqx/yjxwwY49HLmgw/nFV0tGbP7POGqxFbFRNIhhZSMIZBwK+x4gqlTpyqsdoKTKo8TZrTQbawjUtv/Q9uD/BwL9y7JLI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A23BA13920729C4495306135C4FD6B45@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 103539de-f60f-4805-3553-08d6977437aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 20:44:30.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2057
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzE4LzIwMTkgMDI6MDQgUE0sIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+IEZy
b206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gDQo+
IFRoaXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgRU9OIEVOMjVRODBBLCBhIDhNYiBTUEkgTk9SIGNo
aXAuDQo+IEl0IGlzIHVzZWQgb24gaS5NWDYgYm9hcmRzIGJ5IEtvbnRyb24gRWxlY3Ryb25pY3Mg
R21iSA0KPiAoTjYweHgsIE42MXh4KS4NCj4gSXQgd2FzIG9ubHkgdGVzdGVkIHdpdGggYSBzaW5n
bGUgZGF0YSBsaW5lIGNvbm5lY3RlZCwgYnkgd3JpdGluZyBhbmQNCj4gcmVhZGluZyByYW5kb20g
ZGF0YSB3aXRoIGRkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJp
ZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KDQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0K
PiA9PT09PT09PT09PT09PQ0KPiAqIEFkZCBpbmZvcm1hdGlvbiBhYm91dCBib2FyZHMgdXNpbmcg
dGhlIGNoaXAgYW5kIHRlc3RpbmcgdG8gdGhlIGNvbW1pdA0KPiAgIG1lc3NhZ2UNCj4gKiBSZW1v
dmUgU1BJX05PUl9RVUFEX1JFQUQgYXMgdGhlIGNoaXAgZG9lcyBub3Qgc3VwcG9ydCAxXzFfNCBy
ZWFkDQo+ICAgY29tbWFuZCAoMHg2YikNCj4gKiBNb3ZlIHRoZSBlbnRyeSBhZnRlciBlbjI1cTY0
IGZvciBhbHBoYWJldGljYWwgb3JkZXINCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3Nw
aS1ub3IuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc3BpLW5vci5jDQo+IGluZGV4IDZlMTNiYmQxYWFhNS4uN2Q3NDM2ZmFjYzU3IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiArKysgYi9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiBAQCAtMTc0MCw2ICsxNzQwLDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHNwaV9ub3JfaWRzW10gPSB7DQo+ICAJeyAiZW4yNXEz
MmIiLCAgIElORk8oMHgxYzMwMTYsIDAsIDY0ICogMTAyNCwgICA2NCwgMCkgfSwNCj4gIAl7ICJl
bjI1cDY0IiwgICAgSU5GTygweDFjMjAxNywgMCwgNjQgKiAxMDI0LCAgMTI4LCAwKSB9LA0KPiAg
CXsgImVuMjVxNjQiLCAgICBJTkZPKDB4MWMzMDE3LCAwLCA2NCAqIDEwMjQsICAxMjgsIFNFQ1Rf
NEspIH0sDQo+ICsJeyAiZW4yNXE4MGEiLCAgIElORk8oMHgxYzMwMTQsIDAsIDY0ICogMTAyNCwg
ICAxNiwNCj4gKwkJCVNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCkgfSwNCj4gIAl7ICJlbjI1
cWgzMiIsICAgSU5GTygweDFjNzAxNiwgMCwgNjQgKiAxMDI0LCAgIDY0LCAwKSB9LA0KPiAgCXsg
ImVuMjVxaDEyOCIsICBJTkZPKDB4MWM3MDE4LCAwLCA2NCAqIDEwMjQsICAyNTYsIDApIH0sDQo+
ICAJeyAiZW4yNXFoMjU2IiwgIElORk8oMHgxYzcwMTksIDAsIDY0ICogMTAyNCwgIDUxMiwgMCkg
fSwNCj4gDQo=
