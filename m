Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6416C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C54C21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="dK/NonD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfBGVAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:00:49 -0500
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:43348
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfBGVAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cc6v6OfaoNRFvTvdvV9r6J5i9WAeF7BmwRI71peiFQ=;
 b=dK/NonD5BdZqVtVKkHXgmb13TRWd0MA2pSjMSOAk+iTVSU9SIvskhXIu2dOgeXyUaNp3dH6UD3xlGrXtX95Bl+RwzwkfycVRso8ZJf7ueubky5/ZGOu2k01bNHOAVUOCUC/R+X0zkmnyOwC0D/XJu1La4Gbhh6hXNv2i2r2v1g8=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3737.namprd06.prod.outlook.com (10.167.236.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 7 Feb 2019 21:00:44 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 21:00:44 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6A
Date:   Thu, 7 Feb 2019 21:00:44 +0000
Message-ID: <1549573243.3075.72.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
         <20190107132226.16216-2-stefan@agner.ch>
In-Reply-To: <20190107132226.16216-2-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3737;6:Gd4ldN54T+trkzj5C+gl3ZQ6zayrbOT1Mfuq/symv3bniUoUaeDJuEC+SxQJUmr80dyEFEETmax+KcIye1+cmmOeb5rh7bIDplUJb0wGtwZNEYXWUibk6vFcJXSza5dkhRxKhKvpR/tTOZNmrPrLvhXygG4V0sdMpKxPEyPGC5bsNffniYiD0ygOQ+mbKRsm+ClNITJGVgZxCl+5Xjz4FaidxtE9BF7xyUIMzf/nG08rm2TsAhlu1zyaZUAKwLGpeG/Wpzp7s0VPxkztyD55O6yLLwcnnw+UzOrz4gpnDcu6WKDavjehNXl8jbCFZBboOsHz1D+09VZu+JralwuXArv/JhJQx2U69ifcKyuZgd3sn7JvW5H+WuqQPSE4llvIt21LDx6/SID6vi5cVwPgB87/lpcIq5wOB3XPBjYM2qLjmY6UYMlCwz2wJ6ZvOeq0CaCANO1/XXjTzfquJG6ilw==;5:LCZ7B+HGS25rPtKEOS2tvbPG7W5Iy7oZnrX6pA9ZeAs7rYj7lZHMhJ3Iua6Q+WHp6VHDWtacy342OiLPtzpwOwghNRuPmTsZqktHu0dO3E1siqeNoDQWbS0GaW0W6mnEu0kBhe+8jtdQzjkovJsFLoVtKScF8HaVImCNBk35kJ2I+HcYuMMyo5Ak+lTjPaCUN+UqvugsG6kU7NoQm3CDgQ==;7:hguK6rzUz0lvkIb5s/HQaxlXiQtY7APadLmHXItSzaKs9Ur2KOzFfhMphjr7RSDbCSBaoFgbQ5Hqhd6TTbcGLxSRwWMIQNx5p2JE/L2JBOGic6tcnvc2DyXyc06ozfBItNZaa7tldfbhUsptxO0UZQ==
x-ms-office365-filtering-correlation-id: 77f4af54-31af-4992-2107-08d68d3f537a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3737;
x-ms-traffictypediagnostic: MWHPR0601MB3737:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MWHPR0601MB37374904AD31565B8462F36ED3680@MWHPR0601MB3737.namprd06.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39850400004)(396003)(366004)(376002)(189003)(199004)(110136005)(229853002)(6506007)(25786009)(54906003)(486006)(2906002)(68736007)(4326008)(6512007)(11346002)(316002)(6306002)(476003)(103116003)(2616005)(446003)(76176011)(186003)(6486002)(99286004)(102836004)(26005)(86362001)(53936002)(2201001)(2501003)(6436002)(6246003)(71190400001)(6116002)(106356001)(3846002)(478600001)(36756003)(7416002)(71200400001)(14454004)(305945005)(97736004)(105586002)(7736002)(45080400002)(8936002)(81166006)(81156014)(66066001)(8676002)(966005)(256004)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3737;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qY/FJCbId4vNMdtQzBhutLlM7bdXSnryvT5kCVZfeCyJQLFaMhQJU+bteJa4OHrjYdpZbtttxwEbjL/6+NizM1MXP+jERZ5Gje7x0oHFpyuJbSX/sX6ndV2rC1mxuMzr+yWcEY5WXbJ8V48jjv/L2RnW8KV9dqUiqh5Iw3GxxuSbZZB973mIcjQ766AhF2eyJcXHf8feuJEZ0v2ArJQwUbXPXFEovKIHWbgmvFOA0k4Q6VlNh1jpQ9NRK7r+QXDaTT5xp4i92kOVLfs+UHDTsBqG+QlPnCGQbX7bxVQVhZbX89QuWWXnBaiZCbwO9bS7tI1q0OICRx44yRYadf57rmD2ZLodChpfu7SlBkR/lTeXzg4muTU1Set9KHeVDoG+na/UuO2zUMAbyfrG/icO4VA0f8mgs6GE/FHDJXjW7q4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78B3DAFA5E28EF4EAFD719015854BE6B@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f4af54-31af-4992-2107-08d68d3f537a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 21:00:44.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAxLTA3IGF0IDE0OjIyICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IEFsbG93IHRvIHVzZSBETUEgZm9yIFNQSSBieSBhZGRpbmcgdGhlIGFwcHJvcHJpYXRlIERNQSBw
cm9wZXJpdGVzDQo+IHRvIHRoZSBlY3NwaSBub2Rlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBBZ25lciA8c3RlZmFuQGFnbmVyLmNoPg0KPiAtLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRz
L2lteDdzLmR0c2kgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3MuZHRzaSBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDdzLmR0c2kNCj4gaW5kZXggYTA1MjE5OGY2ZTk2Li5iOTMzMDE3
NmMzYWYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdzLmR0c2kNCj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3MuZHRzaQ0KPiBAQCAtNjUzLDYgKzY1Myw4IEBADQo+
ICAJCQkJY2xvY2tzID0gPCZjbGtzIElNWDdEX0VDU1BJNF9ST09UX0NMSz4sDQo+ICAJCQkJCTwm
Y2xrcyBJTVg3RF9FQ1NQSTRfUk9PVF9DTEs+Ow0KPiAgCQkJCWNsb2NrLW5hbWVzID0gImlwZyIs
ICJwZXIiOw0KPiArCQkJCWRtYXMgPSA8JnNkbWEgNiA3IDE+LCA8JnNkbWEgNyA3IDI+Ow0KPiAr
CQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4gIAkJCX07DQoNCkFmdGVyIHVwZGF0aW5nIG15IGtlcm5lbCB0byBsaW51eC1uZXh0IG9uIG15
IElNWDdkIGJhc2VkIGRldmljZSwgSQ0KZm91bmQgdGhhdCBhbiBGUEdBLCB3aGljaCBpcyBwcm9n
cmFtbWVkIHZpYSB0aGUgRUNTUEkgaW50ZXJmYWNlLCB3YXMgbm8NCmxvbmdlciBhY2NlcHRpbmcg
aXRzIGltYWdlLg0KDQpJIHRyYWNrZWQgdGhlIHByb2JsZW0gdG8gdGhpcyBjaGFuZ2UuICBJZiBJ
IHR1cm4gb2ZmIERNQSwgaXQgd29ya3MuDQoNClRoZXJlJ3MgYW4gaW50ZXJlc3RpbmcgdGhpbmcg
dGhhdCBoYXBwZW5zIHdoZW4gRE1BIGlzIHVzZWQuICBUaGUgU1BJDQpjbG9jayBjaGFuZ2VzLiAg
SW5zdGVhZCBvZiBjeWNsaW5nIGNvbnRpbnVvdXNseSBmb3IgdGhlIGVudGlyZQ0KdHJhbnNmZXIs
IGl0IGluc3RlYWQgY2xvY2tzIG91dCA4IGJpdHMsIHRoZW4gcGF1c2VzIGZvciA0IGJpdCB0aW1l
cywNCnRoZW4gdGhlIG5leHQgYnl0ZSwgZXRjLiAgU28gaXQncyBhIG5ldCBvZiBhYm91dCA1MCUg
c2xvd2VyLiAgVGhlIHBhdXNlDQpiZXR3ZWVuIGJ5dGVzIHNjYWxlcyB3aXRoIHNwaSBmcmVxdWVu
Y3kgdG8gYWx3YXlzIGJlIGFib3V0IDQgYml0cy4NCg0KSGVyZSdzIGEgdHJhY2Ugd2l0aCBETUE6
IGh0dHBzOi8vaW1hZ2ViaW4uY2Evdi80V0VrRW52c1ZTa3ENCg0KSGVyZSdzIHdoYXQgaXQgbG9v
a3MgbGlrZSB3aXRob3V0IERNQToNCmh0dHBzOi8vaW1hZ2ViaW4uY2Evdi80V0VrVmZFcXBRMTIN
Cg0KSXQgc2VlbXMgbGlrZSB0aGVyZSBhcmUgb3RoZXIgcHJvYmxlbXMgd2l0aCBETUEgdG9vLiAg
SGVyZSdzIGFuIGVycm9yDQpJJ2xsIHJhbmRvbSBnZXQgZXZlcnkgc28gb2Z0ZW4uDQoNClsgIDE0
Mi4wODIzMjVdIHNwaV9tYXN0ZXIgc3BpMTogSS9PIEVycm9yIGluIERNQSBSWA0KWyAgMTQyLjA4
NTY3OF0gc3BpZGV2IHNwaTEuMDogU1BJIHRyYW5zZmVyIGZhaWxlZDogLTExMA0KWyAgMTQyLjA4
OTM4OV0gc3BpX21hc3RlciBzcGkxOiBmYWlsZWQgdG8gdHJhbnNmZXIgb25lIG1lc3NhZ2UgZnJv
bSBxdWV1ZQ0KDQpOb3Qgc3VyZSBpZiB0aGUgdGltZW91dCBpcyBvdmVybHkgYWdncmVzc2l2ZSBv
ciBpZiB0aGVyZSBpcyBzb21lIG90aGVyIGZhaWx1cmUuDQoNClRoZW4gc29tZXRpbWVzIHRoZXJl
IGVycm9ycyBhcmUgd29yc2U6DQoNCkludGVybmFsIGVycm9yOiBPb3BzIC0gdW5kZWZpbmVkIGlu
c3RydWN0aW9uOiAwIFsjMV0gUFJFRU1QVCBTTVAgQVJNDQpNb2R1bGVzIGxpbmtlZCBpbjoNCkNQ
VTogMCBQSUQ6IDEwMDYgQ29tbTogZnBnYS1sb2FkZXIgTm90IHRhaW50ZWQgNS4wLjAtcmM0LW5l
eHQtMjAxOTAyMDEgIzENCkhhcmR3YXJlIG5hbWU6IEZyZWVzY2FsZSBpLk1YNyBEdWFsIChEZXZp
Y2UgVHJlZSkNClBDIGlzIGF0IHNnX2xhc3QrMHg0Yy8weDY4DQpMUiBpcyBhdCAgIChudWxsKQ0K
cGMgOiBbPDgwNDk0ODAwPl0gICAgbHIgOiBbPDAwMDAwMDAwPl0gICAgcHNyOiA2MDAxMDAxMw0K
c3AgOiBiZjBhZGQ1YyAgaXAgOiBiZWE5NDU5OCAgZnAgOiBiZjM3MTIxOA0KcjEwOiBiZjA5NDlm
MCAgcjkgOiAwMDAwMDAwMCAgcjggOiBiZjA5NDgwMA0KcjcgOiBiZGMzOTMwMCAgcjYgOiBiZjM3
MTAwMCAgcjUgOiBiZGMzOTMwMCAgcjQgOiBiZjA5NGI2OA0KcjMgOiAwMDAwMDAwMCAgcjIgOiAw
MDAwMDAwMSAgcjEgOiAwMDAwMDAwMSAgcjAgOiBiZWE5NDU4MA0KRmxhZ3M6IG5aQ3YgIElSUXMg
b24gIEZJUXMgb24gIE1vZGUgU1ZDXzMyICBJU0EgQVJNICBTZWdtZW50IHVzZXINCkNvbnRyb2w6
IDMwYzUzODdkICBUYWJsZTogYmVhOTQwMDAgIERBQzogZmZmZmZmZmQNClByb2Nlc3MgZnBnYS1s
b2FkZXIgKHBpZDogMTAwNiwgc3RhY2sgbGltaXQgPSAweDYxYmM4YjczKQ0KU3RhY2s6ICgweGJm
MGFkZDVjIHRvIDB4YmYwYWUwMDApDQpkZDQwOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA4MDU2Y2RiMA0KZGQ2MDogODA1NmM5
YWMgMDAwMDEwMDAgMDAwMDAwMDAgYmRjMzkzMDAgYmYwOTQ4MDAgYmYwOTRiNjggYmYzNzEwMDAg
MDAwMDAwMDANCmRkODA6IGJmMDk0OWYwIDgwNTZiYzAwIGJmMDk0ODAwIGJkYzM5MzAwIGJmMGFk
ZWFjIGJmMDk0ODAwIGJmMDk0YWQwIDgwNTY5ZWRjDQouLi4NCmRmYzA6IDAwMjE3MzAxIDAwMTUw
MDAwIDAwMDAxMDAwIDAwMDAwMDM2IDAwZGYyMDEwIDAwMDAwMDAzIDAwMDAxMDAwIDAwZGYxMDA4
DQpkZmUwOiAwMDAyMmY3MCA3ZTllYmIxNCAwMDAxMTNiOCA3NmYyYTdmOCAyMDAxMDAzMCAwMDAw
MDAwMyAwMDAwMDAwMCAwMDAwMDAwMA0KWzw4MDQ5NDgwMD5dIChzZ19sYXN0KSBmcm9tIFs8ODA1
NmNkYjA+XSAoc3BpX2lteF90cmFuc2ZlcisweGQ4LzB4NDQ4KQ0KWzw4MDU2Y2RiMD5dIChzcGlf
aW14X3RyYW5zZmVyKSBmcm9tIFs8ODA1NmJjMDA+XSAoc3BpX2JpdGJhbmdfdHJhbnNmZXJfb25l
KzB4NTAvMHhhMCkNCls8ODA1NmJjMDA+XSAoc3BpX2JpdGJhbmdfdHJhbnNmZXJfb25lKSBmcm9t
IFs8ODA1NjllZGM+XSAoc3BpX3RyYW5zZmVyX29uZV9tZXNzYWdlKzB4MThjLzB4M2UwKQ0KWzw4
MDU2OWVkYz5dIChzcGlfdHJhbnNmZXJfb25lX21lc3NhZ2UpIGZyb20gWzw4MDU2YTQ5OD5dIChf
X3NwaV9wdW1wX21lc3NhZ2VzKzB4MzY4LzB4NTE4KQ0KWzw4MDU2YTQ5OD5dIChfX3NwaV9wdW1w
X21lc3NhZ2VzKSBmcm9tIFs8ODA1NmE3ZWM+XSAoX19zcGlfc3luYysweDE5OC8weDFhMCkNCls8
ODA1NmE3ZWM+XSAoX19zcGlfc3luYykgZnJvbSBbPDgwNTZhODE4Pl0gKHNwaV9zeW5jKzB4MjQv
MHgzYykNCls8ODA1NmE4MTg+XSAoc3BpX3N5bmMpIGZyb20gWzw4MDU2YWUxND5dIChzcGlkZXZf
c3luYysweDM4LzB4NGMpDQpbPDgwNTZhZTE0Pl0gKHNwaWRldl9zeW5jKSBmcm9tIFs8ODA1NmI2
ZjQ+XSAoc3BpZGV2X2lvY3RsKzB4NjYwLzB4NzA0KQ0KWzw4MDU2YjZmND5dIChzcGlkZXZfaW9j
dGwpIGZyb20gWzw4MDMzNWY5Yz5dIChkb192ZnNfaW9jdGwrMHhhYy8weDc5YykNCls8ODAzMzVm
OWM+XSAoZG9fdmZzX2lvY3RsKSBmcm9tIFs8ODAzMzY2YzA+XSAoa3N5c19pb2N0bCsweDM0LzB4
NTgpDQpbPDgwMzM2NmMwPl0gKGtzeXNfaW9jdGwpIGZyb20gWzw4MDIwMTEyMD5dIChyZXRfZmFz
dF9zeXNjYWxsKzB4MC8weDRjKQ0KRXhjZXB0aW9uIHN0YWNrKDB4YmYwYWRmYTggdG8gMHhiZjBh
ZGZmMCkNCmRmYTA6ICAgICAgICAgICAgICAgICAgIDAwMjE3MzAxIDAwMTUwMDAwIDAwMDAwMDAz
IDQwMjA2YjAwIDdlOWViYjgwIDAzOTM4NzAwDQpkZmMwOiAwMDIxNzMwMSAwMDE1MDAwMCAwMDAw
MTAwMCAwMDAwMDAzNiAwMGRmMjAxMCAwMDAwMDAwMyAwMDAwMTAwMCAwMGRmMTAwOA0KZGZlMDog
MDAwMjJmNzAgN2U5ZWJiMTQgMDAwMTEzYjggNzZmMmE3ZjgNCkNvZGU6IGUxNTEwMDAyIDFhZmZm
ZmYzIGUzNTMwMDAwIDE0OWRmMDA0IChlN2YwMDFmMikNCi0tLVsgZW5kIHRyYWNlIDE1ODgyMjlm
Yzc1NDE2NjkgXS0tLQ0KDQpJIHRoaW5rIERNQSBvbiBpbXggbm90IGJlIHJlYWR5IGZvciBwcmlt
ZSB0aW1lIHlldC4=
