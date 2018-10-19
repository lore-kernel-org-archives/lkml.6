Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F3DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F0120869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kbqWIBVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F0120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJSPME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:12:04 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:59829
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbeJSPME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKKwtASjrdEw3SDwPmsthndKsZGvYBaccntl90PouoE=;
 b=kbqWIBVASpR6YB+Z3t0P6GJDJOZbVLEsg98RaGNRaPIrUdfQWGpTXeHSmqV/ST6mv3DWsYc5fwGMY3O0L6WmvKdAEpTIVWxup7lIu+ZyZqnxO5apJlz9SisMO/PLn+ZOOi+Q52PRsjR7bbhxwjWDKlrAXHQNlmEV+n7q7bhlS/A=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3791.eurprd04.prod.outlook.com (52.134.15.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Fri, 19 Oct 2018 07:07:13 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::6837:8f2b:e261:e2b7]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::6837:8f2b:e261:e2b7%3]) with mapi id 15.20.1228.027; Fri, 19 Oct 2018
 07:07:12 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        LABBE Corentin <clabbe@baylibre.com>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] net: ethernet: fec: Add missing SPEED_
Thread-Topic: [PATCH] net: ethernet: fec: Add missing SPEED_
Thread-Index: AQHUZvP8+xaoVd0Y+EmJiLWLuNqEM6UlVeAAgAACMYCAAAJlgIAABbIAgAAGPQCAAAXDgIAAAy4AgAAIk4CAAKeWgA==
Date:   Fri, 19 Oct 2018 07:07:12 +0000
Message-ID: <VI1PR0402MB360027E31680BD74F8514A5FFFF90@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1539875100-11121-1-git-send-email-clabbe@baylibre.com>
 <2621cbc9-47ed-ce2a-b7ee-262f17dc138f@gmail.com> <20181018184715.GA31736@Red>
 <d1461619-1344-e581-4eef-35cf8bbb5336@gmail.com> <20181018191612.GB31736@Red>
 <5cb0731b-83c5-5ed5-d022-98f8627d1737@gmail.com> <20181018195909.GA11317@Red>
 <1b784f69-3ec2-feb2-81e1-9a335cf477c3@gmail.com>
 <f1933c0a-d124-a7ac-afab-2fa8f88907ab@gmail.com>
In-Reply-To: <f1933c0a-d124-a7ac-afab-2fa8f88907ab@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3791;6:ux1eoBpyk0Yabh560vV0xGnYUvmlCtuK87wwprhaef9vGdWYGUyzStWOLX+hYItGbgB8w0RT5sTfyTGralPxohse7pC2y9QP/zzZQQ/R3HNwYv40OAhv7eAZpsBkxJ0O3D0tGfAyO5a2nlmeU79Vd6gCoyi4iTdpDp4YwEEnIEcDD/5Fsr/HjgUiv2dk5Piiu5BI7DwSCzAwrVL1CbAK+6AmtADUylL/+2olyoiIjGs+h7FugrMIKRLeeqVfQoPa7MXGu3hhoOMC9o7NCqCpxXAi7LvtZVipbs3oPqqFm4KhOf/5EfkWg/vGoeAfPp4xl5ijHOpA6DlAfqhj+O3+8XZYOJmjEt1HGzWcj+1cvInoaI2YpzKZLOtsVKu8qxG+sNp5oEAm9XqN/yv2d3uLG6lrRny11XOQK2qK+UQkchaBJidS6KKQZW/6MDEsvYR7MvnWEU+EcsiM15DW1eGg7Q==;5:XB3RX5ZgieQx0WN90VKXZ+X/e+l1vTtO4LojO18B/rD7DHWehR4AphVY/4UmFdC6S5ZE4w6oHzbN5HIhzerItdtceA3HTHtJdNSI/K5GMd5uxbhdBVOCdXq37SYJxfUcIkvb674mVDQ9sl8YpoZ2c6eQL7e2LZj3DhANefS5S1w=;7:raSY8AQUGreb4vbKpoHYkWzWdFwDxm+9uQFflUfqFR4CHzX+RgRi5Zuv8BlBvpwoZO78J00YzjW9RMly79yEsTWr3WLCuaTuP3vT/qtSPg+ZQirjqCjr8Btv9U4QmCK7J45T//Vx3R3R7srCgiTNR9Yr3kUOtURkHnnQwdWS6sV6AE+1PgAmk6+zYtN9Qkb+o+AFkYArhiWsUUuM/fJVRnlMRLumvvdKNhKudOYPEb0+2i80raEDVvsfbXCLl61k
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 75e50a87-395f-4bd0-bb3d-08d635917e92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3791;
x-ms-traffictypediagnostic: VI1PR0402MB3791:
x-microsoft-antispam-prvs: <VI1PR0402MB379137390468673E5FFC1740FFF90@VI1PR0402MB3791.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3791;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3791;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39850400004)(376002)(136003)(199004)(189003)(74316002)(2906002)(66066001)(6116002)(39060400002)(6246003)(6436002)(93886005)(476003)(486006)(97736004)(14454004)(446003)(478600001)(102836004)(11346002)(186003)(229853002)(8676002)(4326008)(26005)(9686003)(3846002)(25786009)(33656002)(54906003)(105586002)(5660300001)(7696005)(53936002)(8936002)(316002)(110136005)(106356001)(53546011)(6506007)(55016002)(5250100002)(99286004)(14444005)(86362001)(575784001)(256004)(5024004)(305945005)(7736002)(71190400001)(2900100001)(81156014)(71200400001)(81166006)(76176011)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3791;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z9XjL/aXMzMaYrr7T97agSYmKdpSdeQfQUwEUs+omjqfNJBA5C3Y2Gr3aHJV/io3eVM4OXIE89Phd0gMip9JRvasoLUyQf8s/PKS2KnpB5nQXRe7xdVW9HECqOu41ZhDNtALF5pSeD1v1BRNumQRsGGJ5qmENwSZcJUko3/p7ig9uiCKxkvyD2xrnYmmoDbv0+oBdjS8RGrsAKx2Qj4IB3KtwYz1J4XBkX5wOVjwnUY+iykSw6A0xdrtFMhqubWbfZUxKPZnkYcVUvGABtQbfHfGu7zqpfIQVok5lI1PcggNMHDR80yX/CQjD5LSwdbTLOoMoGgYe/B0/2hNjoLm/Wwvub82+9jBID+1/XKk6zo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e50a87-395f-4bd0-bb3d-08d635917e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 07:07:12.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSGVpbmVyIEthbGx3ZWl0IDxoa2FsbHdlaXQxQGdtYWlsLmNvbT4gU2VudDogMjAxOOW5
tDEw5pyIMTnml6UgNDo0MQ0KPiBPbiAxOC4xMC4yMDE4IDIyOjEwLCBGbG9yaWFuIEZhaW5lbGxp
IHdyb3RlOg0KPiA+IE9uIDEwLzE4LzIwMTggMTI6NTkgUE0sIExBQkJFIENvcmVudGluIHdyb3Rl
Og0KPiA+PiBPbiBUaHUsIE9jdCAxOCwgMjAxOCBhdCAxMjozODozMlBNIC0wNzAwLCBGbG9yaWFu
IEZhaW5lbGxpIHdyb3RlOg0KPiA+Pj4gT24gMTAvMTgvMjAxOCAxMjoxNiBQTSwgTEFCQkUgQ29y
ZW50aW4gd3JvdGU6DQo+ID4+Pj4gT24gVGh1LCBPY3QgMTgsIDIwMTggYXQgMTE6NTU6NDlBTSAt
MDcwMCwgRmxvcmlhbiBGYWluZWxsaSB3cm90ZToNCj4gPj4+Pj4gT24gMTAvMTgvMjAxOCAxMTo0
NyBBTSwgTEFCQkUgQ29yZW50aW4gd3JvdGU6DQo+ID4+Pj4+PiBPbiBUaHUsIE9jdCAxOCwgMjAx
OCBhdCAxMTozOToyNEFNIC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpDQo+IHdyb3RlOg0KPiA+Pj4+
Pj4+IE9uIDEwLzE4LzIwMTggMDg6MDUgQU0sIENvcmVudGluIExhYmJlIHdyb3RlOg0KPiA+Pj4+
Pj4+PiBTaW5jZSBjb21taXQgNTgwNTZjMWUxYjBlICgibmV0OiBldGhlcm5ldDogVXNlDQo+IHBo
eV9zZXRfbWF4X3NwZWVkKCkgdG8gbGltaXQgYWR2ZXJ0aXNlZCBzcGVlZCIpLCB0aGUgZmVjIGRy
aXZlciBpcyB1bmFibGUNCj4gdG8gZ2V0IGFueSBsaW5rLg0KPiA+Pj4+Pj4+PiBUaGlzIGlzIGR1
ZSB0byBtaXNzaW5nIFNQRUVEXy4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IEJ1dCBTUEVFRF8xMDAw
IGlzIGRlZmluZWQgaW4gaW5jbHVkZS91YXBpL2xpbnV4L2V0aHRvb2wuaCBhcw0KPiA+Pj4+Pj4+
IDEwMDAsIHNvIHN1cmVseSB0aGlzIHdvdWxkIGFtb3VudCB0byB0aGUgc2FtZSBjb2RlIHBhdGhz
IGJlaW5nDQo+ID4+Pj4+Pj4gdGFrZW4gb3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlPw0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZSBiaXNlY3Qgc2Vzc2lvbiBwb2ludGVkIHlvdXIgcGF0Y2gs
IHJldmVydGluZyBpdCBmaXggdGhlIGlzc3VlLg0KPiA+Pj4+Pj4gQlVUIHNpbmNlIHRoZSBmaXgg
c2VlbWVkIHRyaXZpYWwgSSBzZW50IHRoZSBwYXRjaCB3aXRob3V0IG1vcmUgdGVzdA0KPiB0aGVu
IGNvbXBpbGUgaXQuDQo+ID4+Pj4+PiBTb3JyeSwgSSBoYXZlIGp1c3QgZm91bmQgc29tZSBtaW51
dGVzIGFnbyB0aGF0IGl0IGRpZG50IGZpeCB0aGUNCj4gaXNzdWUuDQo+ID4+Pj4+Pg0KPiA+Pj4+
Pj4gQnV0IHlvdXIgcGF0Y2ggaXMgc3RpbGwgdGhlIGNhdXNlIGZvciBzdXJlLg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gV2hhdCB5b3UgYXJlIHdyaXRpbmcgaXMgcmVhbGx5IGxvd2VyaW5n
IHRoZSBjb25maWRlbmNlIGxldmVsLA0KPiA+Pj4+PiBmaXJzdCBBbmRyZXcgaXMgdGhlIGF1dGhv
ciBvZiB0aGF0IHBhdGNoLCBhbmQgc2Vjb25kICJqdXN0DQo+ID4+Pj4+IGNvbXBpbGluZyIgYW5k
IHByZXRlbmRpbmcgdGhpcyBmaXhlcyBhIHByb2JsZW0gd2hlbiBpdCBkb2VzIG5vdCBpcw0KPiA+
Pj4+PiBub3QgcXVpdGUgd2hhdCBJIHdvdWxkIGV4cGVjdC4NCj4gPj4+Pj4NCj4gPj4+Pj4gSSBk
b24ndCBoYXZlIGEgcHJvYmxlbSBoZWxwaW5nIHlvdSBmaW5kIHRoZSBzb2x1dGlvbiBvciB0aGUg
cmlnaHQNCj4gPj4+Pj4gZml4IHRob3VnaCwgZXZlbiBpZiBpdCBpcyBub3QgbXkgcGF0Y2gsIGJ1
dCBwbGVhc2UgZ2V0IHRoZSBhdXRob3INCj4gPj4+Pj4gYW5kIGFjdHVhbCBwcm9ibGVtIHJpZ2h0
IHNvIHdlIGNhbiBtb3ZlIGZvcndhcmQgaW4gY29uZmlkZW5jZSwNCj4gdGhhbmtzIQ0KPiA+Pj4+
DQo+ID4+Pj4gU29ycnkgYWdhaW4sIEkgd2FudGVkIHRvIGFja25vbGVkZ2UgbXkgZXJyb3IgYnV0
IEkgZGlkIGl0IHRvbyBmYXN0IGFuZA0KPiBsYXRlLg0KPiA+Pj4+IEFuZCBzb3JyeSB0byBoYXZl
IGNvbmZvdW5kIHlvdSB3aXRoIEFuZHJldy4NCj4gPj4+DQo+ID4+PiBObyB3b3JyaWVzLCBoZXJl
IHRvIGhlbHAsIGxldCB1cyBrbm93IHdoYXQgeW91ciBiaXNlY3Rpb24gcG9pbnRzIHRvLg0KPiA+
Pj4gVEhhbmtzDQo+ID4+DQo+ID4+IEkgaGF2ZSBhZGRlZCBwcmludGluZyBvZiBwaHlkZXYtPnN1
cHBvcnRlZCBNeSB3b3JraW5nIGtlcm5lbCAob24gdG9wDQo+ID4+IG9mIDU4MDU2YzFlMWIwZSAr
IHJldmVydCBwYXRjaCkgZ290Og0KPiA+PiBbICAgIDUuNTUwODM4XSBmZWNfZW5ldF9taWlfcHJv
YmUgMmZmIChnYml0IGZlYXR1cmVzKQ0KPiA+PiBbICAgIDUuNTU1ODQ4XSBmZWNfZW5ldF9taWlf
cHJvYmUgMmVmICh3aXRob3V0IDEwMDBiYXNlVF9IYWxmKQ0KPiA+PiBbICAgIDUuNTYxNjIwXSBm
ZWNfZW5ldF9taWlfcHJvYmUgMjJlZiBmaW5hbCAoYWZ0ZXIgcGF1c2UpDQo+ID4+IFsgICAgNS41
NjY5MTRdIE1pY3JlbCBLU1o5MDIxIEdpZ2FiaXQgUEhZIDIxODgwMDAuZXRoZXJuZXQtMTowNjoN
Cj4gYXR0YWNoZWQgUEhZIGRyaXZlciBbTWljcmVsIEtTWjkwMjEgR2lnYWJpdCBQSFldDQo+ICht
aWlfYnVzOnBoeV9hZGRyPTIxODgwMDAuZXRoZXJuZXQtMTowNiwgaXJxPVBPTEwpDQo+ID4+IFsg
ICAgOC43MzA3NTFdIGZlYyAyMTg4MDAwLmV0aGVybmV0IGV0aDA6IExpbmsgaXMgVXAgLSAxR2Jw
cy9GdWxsIC0NCj4gZmxvdyBjb250cm9sIHJ4L3R4DQo+ID4+IFsgICAgOC43ODgzMTFdIFNlbmRp
bmcgREhDUCByZXF1ZXN0cyAuLCBPSw0KPiA+PiBbICAgIDguODMyMzU3XSBJUC1Db25maWc6IEdv
dCBESENQIGFuc3dlciBmcm9tIDE5Mi4xNjguNjYuMSwgbXkNCj4gYWRkcmVzcyBpcyAxOTIuMTY4
LjY2LjU4DQo+ID4+DQo+ID4+IHRoZSBub24td29ya2luZyBrZXJuZWwgKG5leHQtMjAxODEwMTUp
DQo+ID4+IFsgICAgNy4zMDg5MTddIGZlY19lbmV0X21paV9wcm9iZSA2MmZmIGFmdGVyIHBoeV9z
ZXRfbWF4X3NwZWVkDQo+ID4+IFsgICAgNy4zMTQ1NDVdIGZlY19lbmV0X21paV9wcm9iZSA2MmVm
IGFmdGVyDQo+IHBoeV9yZW1vdmVfbGlua19tb2RlDQo+ID4+IFsgICAgNy4zMjA0MThdIGZlY19l
bmV0X21paV9wcm9iZSA2MmVmIGFmdGVyIHBhdXNlDQo+ID4+IGFuZCB0aGVuIG5vIGxpbmsNCj4g
Pj4NCj4gPj4gU28gaXQgc2VlbXMgdGhhdCBwaHlfc2V0X21heF9zcGVlZCBhZGRzIGJpdCAxNA0K
PiA+PiAoRVRIVE9PTF9MSU5LX01PREVfQXN5bV9QYXVzZV9CSVQpDQo+ID4NCj4gPiBJdCdzIG5v
dCBtYXNraW5nIGl0IHNvIGl0IG11c3QgYmUgY29taW5nIGZyb20gcGh5X3Byb2JlKCkuDQo+ID4N
Cj4gU2VlIGRmOGVkMzQ2ZDRhOCAoIm5ldDogcGh5OiBmaXggZmxhZyBtYXNraW5nIGluIF9fc2V0
X3BoeV9zdXBwb3J0ZWQiKS4NCj4gcGh5X3NldF9tYXhfc3BlZWQoKSB1c2VkIHRvICh1bmludGVu
dGlvbmFsbHkpIG1hc2sgdGhlIHBhdXNlIGJpdHMgYW5kIGl0DQo+IHNlZW1zIHRoYXQgdGhlIGZl
YyBkcml2ZXIgdXNlZCB0aGlzIGJ1ZyBhcyBhIGZlYXR1cmUuDQo+IA0KPiA+Pg0KPiA+PiBJIGhh
dmUgcGF0Y2hlZCBieSBhZGRpbmc6DQo+ID4+IHBoeV9yZW1vdmVfbGlua19tb2RlKHBoeV9kZXYs
DQo+IEVUSFRPT0xfTElOS19NT0RFX0FzeW1fUGF1c2VfQklUKTsNCj4gDQo+IEluc3RlYWQgb2Yg
cHJvZ3JhbW1hdGljYWxseSByZW1vdmluZyB0aGUgZmVhdHVyZSBiaXQgaXQgc2hvdWxkIGJlIHBv
c3NpYmxlDQo+IHRvIGRvIHRoaXMgaW4gdGhlIFBIWSBkcml2ZXIgY29uZmlndXJhdGlvbi4gU2Vl
IGFsc28gdGhpcyBwYXJ0IG9mDQo+IHBoeV9wcm9iZSgpLg0KPiANCj4gCWlmIChwaHlkcnYtPmZl
YXR1cmVzICYgKFNVUFBPUlRFRF9QYXVzZSB8DQo+IFNVUFBPUlRFRF9Bc3ltX1BhdXNlKSkgew0K
PiAJCXBoeWRldi0+c3VwcG9ydGVkICY9IH4oU1VQUE9SVEVEX1BhdXNlIHwNCj4gU1VQUE9SVEVE
X0FzeW1fUGF1c2UpOw0KPiAJCXBoeWRldi0+c3VwcG9ydGVkIHw9IHBoeWRydi0+ZmVhdHVyZXMg
Jg0KPiAJCQkJICAgICAoU1VQUE9SVEVEX1BhdXNlIHwgU1VQUE9SVEVEX0FzeW1fUGF1c2UpOw0K
PiAJfSBlbHNlIHsNCj4gCQlwaHlkZXYtPnN1cHBvcnRlZCB8PSBTVVBQT1JURURfUGF1c2UgfA0K
PiBTVVBQT1JURURfQXN5bV9QYXVzZTsNCj4gCX0NCg0KVGhlIGtzejkwMjEgcGh5IGRyaXZlciBk
b24ndCBzZXQgUGF1c2UgZmVhdHVyZSwgIHRoZW4gdGhlIHBoeWxpYiBlbmFibGUgIlNVUFBPUlRF
RF9QYXVzZSIgYW5kICIgU1VQUE9SVEVEX0FzeW1fUGF1c2UiIGluIGJvdGguDQpNaWNyZWwuYzoN
CiAgICAgICAgLnBoeV9pZCAgICAgICAgID0gUEhZX0lEX0tTWjkwMjEsDQogICAgICAgIC5waHlf
aWRfbWFzayAgICA9IDB4MDAwZmZmZmUsDQogICAgICAgIC5uYW1lICAgICAgICAgICA9ICJNaWNy
ZWwgS1NaOTAyMSBHaWdhYml0IFBIWSIsDQogICAgICAgIC5mZWF0dXJlcyAgICAgICA9IFBIWV9H
QklUX0ZFQVRVUkVTLA0KDQpGcm9tIEBMQUJCRSBDb3JlbnRpbiBkZWJ1ZywgIGl0IHNlZW0ga3N6
OTAyMSBjYW5ub3QgYWR2ZXJ0aXNlIFBhdXNlIGFuZCBBc3ltIHBhdXNlIGluIGJvdGgsIG90aGVy
d2lzZSBpdCBjYW5ub3QgbGluayB1cC4NCkZyb20ga3N6OTAyMSBkYXRhc2hlZXQgZGVzY3JpcHRp
b24gYXMgYmVsb3csICBTeW1tZXRyaWMgJiBBc3ltbWV0cmljIFBBVVNFIGlzIGZvciBsb2NhbCBk
ZXZpY2UsICBJIGRvbid0IHVuZGVyc3RhbmQgaXRzIG1lYW4uICANCjQuMTE6MTAgUGF1c2UNClsw
LDBdID0gTm8gUEFVU0UNClsxLDBdID0gQXN5bW1ldHJpYyBQQVVTRSAobGluayBwYXJ0bmVyKQ0K
WzAsMV0gPSBTeW1tZXRyaWMgUEFVU0UNClsxLDFdID0gU3ltbWV0cmljICYgQXN5bW1ldHJpYyBQ
QVVTRSAobG9jYWwgZGV2aWNlKQ0KDQpAIExBQkJFIENvcmVudGluLCB5b3UgY2FuIHRyeSB0aGlz
Og0KTWljcmVsLmM6DQogICAgICAgIC5waHlfaWQgICAgICAgICA9IFBIWV9JRF9LU1o5MDIxLA0K
ICAgICAgICAucGh5X2lkX21hc2sgICAgPSAweDAwMGZmZmZlLA0KICAgICAgICAubmFtZSAgICAg
ICAgICAgPSAiTWljcmVsIEtTWjkwMjEgR2lnYWJpdCBQSFkiLA0KICAgICAgICAuZmVhdHVyZXMg
ICAgICAgPSBQSFlfR0JJVF9GRUFUVVJFUyB8IFNVUFBPUlRFRF9QYXVzZSwNCg0KDQpJbiBmYWN0
LCAgSSB0ZXN0IG5ldCB0cmVlIHdpdGhvdXQgYW55IGNoYW5nZSB3aXRoIEFSODAzMSBhbmQgdGhl
cmUgaGFzIG5vIGxpbmsgcHJvYmxlbS4NCg0KDQpBbmR5DQo=
