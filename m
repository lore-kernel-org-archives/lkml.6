Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F3CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05552086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JaJfwvk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfBHPvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:51:23 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:30266 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfBHPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:51:21 -0500
X-IronPort-AV: E=Sophos;i="5.58,348,1544511600"; 
   d="scan'208";a="26293556"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Feb 2019 08:51:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 8 Feb 2019 08:51:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUIvTS25OUh6PjlvznElb0t5SwFwEiR/rz2bPyZjvjQ=;
 b=JaJfwvk4oPWRrMNvodzDW03qZLUQT8BjoyH6/AO5MjNubpnZ8y0jJKuF2YEUxY1lwhGoy4JsHAHJGDLaW/PhO1J5+/Vst59wvsQFQz5OfzfY91P7n8lvRry8tUyEQXBftOF2Vhc6zfCZHduVqVSy/BZpv3hlCdCjouM5pQmK1jQ=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1284.namprd11.prod.outlook.com (10.173.32.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Fri, 8 Feb 2019 15:51:16 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Fri, 8 Feb 2019
 15:51:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <beanhuo@micron.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <marek.vasut@gmail.com>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <richard@nod.at>, <bbrezillon@kernel.org>
Subject: Re: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Topic: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Index: AdS/uVD1jG3UvCBSRuC2oJ8LRRcc4gAA03cAAAFVpvAAAQltAA==
Date:   Fri, 8 Feb 2019 15:51:16 +0000
Message-ID: <a83a9655-0ce7-da15-ec17-80ef88764e21@microchip.com>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
 <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
In-Reply-To: <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1284;6:OckLUVGouwqqLWegrTibfWQjDSyEwxOH0yvymOLk3vfMs6NzIO4tb1O9RvIuPvOrifrw6QbEibbViqemfEQlDbNzTVS1HmDD8tG2X5d+rFdU6rb7uFO17t//5e6ErWd5HyisLQjfTf27QCp/1t0r6da6Z5fIFDbRwEyIpsY5McJ3dQWUCDOTg8WWf/Ro7mZpk6OulTvuz+E2HRx1uaL7rnIsLwNtGXBJ/2CNjBvhnP8tGqVmwdAqaRKe6DFiQ50q1SnWDHUu3fPydgwiR1lLfe69NxgvJZH8s2ErLrdppSUmEYkpKUd5fXPN6RbcMs22Jh2eB0nJRAyfMLjOpK3lg2wJ8di2QllDQwpaPQNLbmMtriB+/r3tnSJvlo8YiCD7CxLnyGc+0KIeMVKIHe9dy54IKs8ug6ZvAc54ijYdKGI1KmtQhCnzhgAwpsEkHz+9k/2fHOt2e6uEbEh9cfWKJg==;5:MO4wAK/yzWZbTa9e3RxXR/E9ByajHBUjGASqmwACHF2ZY88BIt/wxsrYHquhdLHhXtRX6DJHzY6mGHjmeIh8H63JfbpsukF9eTsaKifs7BMNbHPHcCD39ITB4fvOUPiufymFrn0W5HYJpZrQfu6APZkOhE5kw3mXgd4HzisbiizSXguStkeUSHCxqdtlCLCwgC57CiLsXAXaaZzjSxMgPg==;7:mglJugKZ1vOvia+Hva+42DPh7+A51nO9xTkybm+hZHoZ2Cs3sIe6JD1NjmHhdPup0XkrtXwQRwFmJlJLNbc9ykESX4SMrIZGvYSueqNN78wDUmseWRFBZkwwBownB4QQWUFvkPoReRW5u9c2aLng1A==
x-ms-office365-filtering-correlation-id: 35b975f5-f478-48b2-ce7f-08d68ddd4234
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1284;
x-ms-traffictypediagnostic: BN6PR11MB1284:
x-microsoft-antispam-prvs: <BN6PR11MB12843105A771EB6750B52957F0690@BN6PR11MB1284.namprd11.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(72206003)(2501003)(71190400001)(229853002)(316002)(71200400001)(99286004)(25786009)(31686004)(7736002)(305945005)(106356001)(53936002)(105586002)(478600001)(19627235002)(6246003)(52116002)(6436002)(486006)(6116002)(8676002)(2616005)(26005)(14454004)(31696002)(36756003)(6486002)(76176011)(386003)(102836004)(3846002)(86362001)(186003)(68736007)(97736004)(2906002)(110136005)(14444005)(2201001)(256004)(6506007)(54906003)(81156014)(81166006)(6512007)(66066001)(8936002)(4326008)(446003)(11346002)(476003)(53546011)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1284;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /vN2MVTfbbpast3RIha2Ak/cL6iR0NruxtvCqcPVIFYr3o86UAiDIorGgdw/buDZPABLw+2AbqDqUUZRK2AFRkSGaPTfb0DmNc2F3xYkOcOWiuDAP03VZEVFLebtCagqeZzJbZ2gHoE+ob+dRwted4shhvcdBL3KPo1qw9IcWl3lwdAg21wo+++JWmS+vRmO9QdJf1x08IhJdlzmOO1yA651ES8fqLqnuMSgTLZUvXyCM5E4qk90j1gluvp4Xem/XhBdo+5ivk3S8kFeLb3saJyCjzA2vHehLu13RbppKm6j2qFJlXvPbRfHtPZwjo3QLcwTbJHBIuO1Ieidae3gdZ6OzdsLQ9TrQhUUIcB+lMHCIF0UU+FnhPLB2r3qTX1DFQdeZVbwRh3o8cEfeCXFaygKYJEMsn7jhaPqZJxTi8A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ED8E5929B965A4798BEBCA066930722@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b975f5-f478-48b2-ce7f-08d68ddd4234
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:51:14.4108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1284
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJlYW4sDQoNCk9uIDAyLzA4LzIwMTkgMDU6MjcgUE0sIEJlYW4gSHVvIChiZWFuaHVvKSB3
cm90ZToNCj4gSGksIFR1dG9yDQo+IA0KPj4gJCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0
cmljdA0KPj4gdjItbXRkLXNwaS1ub3ItRml4LXdyb25nLWFiYnJldmlhdGlvbi1IV0NQQVMucGF0
Y2gNCj4+IFdBUk5JTkc6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZSBieSBub21pbmFsIHBh
dGNoIGF1dGhvciAnQmVhbiBIdW8NCj4+IChiZWFuaHVvKSA8YmVhbmh1b0BtaWNyb24uY29tPicN
Cj4+DQo+IEkgdGhpbmssIHRoaXMgaXMgYmVjYXVzZSBvZiBvdXIgZW1haWwgc3lzdGVtLCBpdCBh
bHdheXMgYWRkcyAnKHh4eCknIGJldHdlZW4gdXNlciBuYW1lIA0KPiBhbmQgZW1haWwgYWRkcmVz
cy4NCj4gSWYgeW91IGFyZSBjb252ZW5pZW50LCBwbGVhc2UgaGVscCBmaXggc2luY2UgaXQgaXMg
bm90IHN1Y2ggaHVnIGNoYW5nZS4NCg0KSSdtIG9uIGEgZnVubnkgZW1haWwgc2VydmVyIHRvbywg
aXQga2VlcHMgb3ZlcndyaXRpbmcgbXkgZW1haWwgaGVhZGVyICJmcm9tDQpmaWVsZCIuIEkgaGF2
ZSBhIHdvcmthcm91bmQgdGhhdCBtaWdodCB3b3JrIGZvciB5b3UgdG9vLiBIZXJlJ3MgcGFydCBv
ZiBteQ0KLmdpdGNvbmZpZzoNCg0KW3VzZXJdDQogICAgICAgIG5hbWUgPSBUdWRvciBBbWJhcnVz
DQogICAgICAgIGVtYWlsID0gdHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tDQpbc2VuZGVtYWls
XQ0KICAgICAgICBmcm9tID0gVHVkb3IgWCBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb20+DQoNCkJlY2F1c2UgbXkgW3NlbmRlbWFpbF0gZnJvbSBmaWVsZCBpcyBkaWZmZXJlbnQg
dGhhbiBteSBbdXNlcl0gbmFtZSBhbmQgZW1haWwsDQpnaXQgc2VuZC1lbWFpbCB3aWxsIGFkZCBp
biB0aGUgYm9keSBvZiB0aGUgcGF0Y2ggdGhlIFt1c2VyXSBuYW1lIGFuZCBlbWFpbDoNCg0KRnJv
bTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQpXaGVuIHRo
ZSBwYXRjaCBpcyBhcHBsaWVkLCBpdCB0YWtlcyB0aGUgYXV0aG9yIG5hbWUgZnJvbSB0aGUgcGF0
Y2ggYm9keS4gRXZlbiBpZg0KdGhlIHNlcnZlciBvdmVyd3JpdGVzIHRoZSBmcm9tIGZpZWxkIGZy
b20gdGhlIGhlYWRlciwgaXQgd2lsbCBiZSBpZ25vcmVkLg0KDQpMZXQgbWUga25vdyBpZiB0aGlz
IHdvcmtzIGZvciB5b3UuDQp0YQ0K
