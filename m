Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B78C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6DC21502
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="I+SNYuvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6DC21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeHUFRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:17:15 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:28229 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725731AbeHUFRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:17:15 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 21 Aug 2018 10:59:11 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 5F41A63C2B;
        Tue, 21 Aug 2018 10:59:11 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,267,1531753200"; 
   d="scan'208";a="290137539"
Received: from mail-ty1jpn01lp0184.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.184])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2018 10:59:11 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzX7VWvulg/PWZyHEVxYUjTxFdbqJOIzcGri11N6Pj8=;
 b=I+SNYuvwM1aLINAQ2EoF6ntNUthdPSgUN/EikvSCxRoIYAyfftbbYAhtvkbNTEQk37mJLd8c0mhOKf/aIwA84w1HBIxQyinyoRdlKrh3A2wZd73xvSvXI/cvvItX6k0mLtjHjihSnX6elel3TW33nn47zkJlApiKlETuqnfTDcQ=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB1669.jpnprd01.prod.outlook.com (52.134.226.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Tue, 21 Aug 2018 01:59:08 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::64ba:c30f:4366:5723]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::64ba:c30f:4366:5723%2]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 01:59:08 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        gregkh <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johan Hovold <johan@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hide usb_of_get_companion_dev for CONFIG_USB=n
Thread-Topic: [PATCH] usb: hide usb_of_get_companion_dev for CONFIG_USB=n
Thread-Index: AQHUM0+HsK8qGELHVE2S+ootR3xPkaS/Rx6AgAAH2ACACLMj4IAAh2EAgAD0flA=
Date:   Tue, 21 Aug 2018 01:59:08 +0000
Message-ID: <OSBPR01MB2293498CD131B2E3FAC1082CD8310@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20180813214924.3567840-1-arnd@arndb.de>
 <Pine.LNX.4.44L0.1808140957350.1466-100000@iolanthe.rowland.org>
 <CAK8P3a33DRBj6ZeJBeWGnw3RnpK3rTaYtrbs6jjZ8VVPOk8=qw@mail.gmail.com>
 <OSBPR01MB22931014287A7641FFBFBE56D8320@OSBPR01MB2293.jpnprd01.prod.outlook.com>
 <CAK8P3a1eWyqp=fevH2KvbhTgRGXFXgtXpfObkEqLO2c5x6WNvA@mail.gmail.com>
In-Reply-To: <CAK8P3a1eWyqp=fevH2KvbhTgRGXFXgtXpfObkEqLO2c5x6WNvA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1669;20:e6p4rCCbVuB7P5g2qcwfgaMoVyurA2pwxJRXGp+vbAAyDnlAXeagu9snVSl6dg5tA0/F7FIBRmpIRtfWmUKTwf4OeYLQQSGYbBB8I7Yi+rzESsuu3gT7ksiqL/jfPtunhat1gaqeJ/HiyHvfOmvb9ZFnsyIRVDP6X2FonsryCYQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7e92ce31-7796-4d76-0282-08d60709aec0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1669;
x-ms-traffictypediagnostic: OSBPR01MB1669:
x-microsoft-antispam-prvs: <OSBPR01MB16694C32D7FC2A7F6603D9A9D8310@OSBPR01MB1669.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(35762410373642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:OSBPR01MB1669;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1669;
x-forefront-prvs: 0771670921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(39860400002)(396003)(189003)(199004)(5660300001)(6116002)(486006)(55016002)(93886005)(2900100001)(476003)(316002)(9686003)(478600001)(3846002)(86362001)(105586002)(6436002)(106356001)(966005)(2906002)(53936002)(99286004)(6306002)(8936002)(6916009)(76176011)(7696005)(54906003)(7736002)(81156014)(81166006)(6506007)(4326008)(446003)(33656002)(345774005)(305945005)(68736007)(74316002)(11346002)(229853002)(14454004)(26005)(53546011)(256004)(6246003)(25786009)(186003)(102836004)(66066001)(5250100002)(97736004)(8676002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1669;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wz86gmmXO60aIMXKQUpxes69174rrJsuAxeilxSV+dqhQfQdOYNJ/ZTTQxSlRGmi1rF4zNntUEerDUfbFcriqJHndzKjgh/3n9E0wKNm6PxE1AeoPD2DFouSamAfrlHP33WIy4hXS9uNG6uklfmuzpNSQuA+84GeEXx3AOmEWBaGZl9JaBjg1ptonGStq9c4LYRLz6XTt4tFs38A8XfjbktgpOtXxVyEuepu44Cerc51JDZFsvUJrw4NHq+4Arb43dzsrYiazgPgbdkeBr5u/e6o2tKt7wBXYh9lyzvmf9XpmcD2YRIe1Zj+GyX23Fb8ppHVAK6w1JsSHjQyZG7tEklgNtHsIVcBLeYaY25XmaY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e92ce31-7796-4d76-0282-08d60709aec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 01:59:08.5548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1669
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uLCBTZW50OiBNb25kYXksIEF1Z3VzdCAy
MCwgMjAxOCA4OjIyIFBNDQo+IA0KPiBPbiBNb24sIEF1ZyAyMCwgMjAxOCBhdCA1OjIyIEFNIFlv
c2hpaGlybyBTaGltb2RhDQo+IDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3Jv
dGU6DQo+ID4gPiBGcm9tOiBBcm5kIEJlcmdtYW5uLCBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTQs
IDIwMTggMTE6MjcgUE0NCj4gPiA+DQo+ID4gPiBPbiBUdWUsIEF1ZyAxNCwgMjAxOCBhdCAzOjU4
IFBNIEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+IHdyb3RlOg0KPiA+ID4g
PiBPbiBNb24sIDEzIEF1ZyAyMDE4LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL0tjb25maWcgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL0tjb25maWcNCj4gPiA+ID4gPiBpbmRleCAwYTE2Y2JkNGU1MjguLjY2M2E4YmQ2
N2E3YiAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL0tjb25m
aWcNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL0tjb25maWcNCj4gPiA+
ID4gPiBAQCAtMTkzLDYgKzE5Myw3IEBAIGNvbmZpZyBVU0JfUkVORVNBU19VU0IzDQo+ID4gPiA+
ID4gICAgICAgdHJpc3RhdGUgJ1JlbmVzYXMgVVNCMy4wIFBlcmlwaGVyYWwgY29udHJvbGxlcicN
Cj4gPiA+ID4gPiAgICAgICBkZXBlbmRzIG9uIEFSQ0hfUkVORVNBUyB8fCBDT01QSUxFX1RFU1QN
Cj4gPiA+ID4gPiAgICAgICBkZXBlbmRzIG9uIEVYVENPTg0KPiA+ID4gPiA+ICsgICAgIGRlcGVu
ZHMgb24gVVNCIHx8ICFVU0INCj4gPiA+ID4NCj4gPiA+ID4gSXMgdGhpcyBzb21lIHdlaXJkIHN0
YW5kYXJkIGlkaW9tPyAgSXQgbG9va3MgcmVhbGx5IHN0cmFuZ2UuDQo+ID4gPg0KPiA+ID4gWWVz
LCBhbmQgeWVzLg0KPiA+ID4NCj4gPiA+IEEgbGVzcyBjb21tb24gd2F5IHRvIHdyaXRlIGl0IGlz
DQo+ID4gPg0KPiA+ID4gICAgICAgICBkZXBlbmRzIG9uIChVU0IgIT0gbSkgfHwgbQ0KPiA+ID4N
Cj4gPiA+IHdoaWNoIHNvbWUgcGVvcGxlIHByZWZlciwgYnV0IEkgZmluZCBldmVuIHdlaXJkZXIu
DQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCENCj4gPg0KPiA+IE9uIG90aGVyIHRo
cmVhZCwgSm9obiBtZW50aW9ucyBnYWRnZXQtc2lkZSBkcml2ZXJzIHNob3VsZCBub3QgZGVwZW5k
IG9uIGhvc3Qtc2lkZSBbMV0uDQo+ID4gU28sIEkgc3VibWl0dGVkIGEgcGF0Y2ggdG9kYXkgWzJd
LiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCBteSBzdWJtaXR0ZWQgcGF0Y2g/DQo+ID4NCj4gPiBb
MV0NCj4gPiBodHRwczovL21hcmMuaW5mby8/bD1saW51eC11c2ImbT0xNTM0MzM3NzYyMDI4NjEm
dz0yDQo+IA0KPiBJIGRvbid0IHJlYWxseSB0aGluayB0aGlzIGlzIGEgYmlnIGlzc3VlLCBhcyB5
b3UgY2FuIHN0aWxsIGJ1aWxkIHRoZSBkcml2ZXINCj4gd2l0aCBDT05GSUdfVVNCPW4sIHNvIGl0
J3Mgbm90IGEgc3RyaWN0IGRlcGVuZGVuY3kuDQoNCkkgZ290IGl0Lg0KDQo+ID4gWzJdDQo+ID4g
aHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDU2OTg0Ny8NCj4gDQo+IE9uIHRo
ZSBvdGhlciBoYW5kLCB5b3VyIHBhdGNoIGxvb2tzIG5pY2UgYW5kIGlzIHNvbWV3aGF0DQo+IGxl
c3MgY29uZnVzaW5nLCBzbyB5b3UgaGF2ZSBteSBBY2sgb24gdGhhdC4NCg0KVGhhbmsgeW91IHZl
cnkgbXVjaCBmb3IgeW91ciBBY2shDQpJJ2xsIHJlcGx5IGJ5IG15c2VsZiB0byByZWNvcmQgeW91
ciBBY2sgb24gdGhhdC4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiAg
ICAgICBBcm5kDQo=
