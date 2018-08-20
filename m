Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF63C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 03:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8BF2152C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 03:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="WdBHJgT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8BF2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeHTGf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 02:35:59 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:21884 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725926AbeHTGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 02:35:59 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 20 Aug 2018 12:22:06 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id F21D37512F;
        Mon, 20 Aug 2018 12:22:06 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,263,1531753200"; 
   d="scan'208";a="288505356"
Received: from mail-ty1jpn01lp0180.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.180])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2018 12:22:06 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfaPOFKCXgMJzDtU35+eUVhJT97twmHAwjinWMVovVY=;
 b=WdBHJgT8a36VYNxpONoPi5yHEQmKuyh2hjhTS2+DRMo3mLK40ry568lM1JIi4u1F5+fmX/KUM39RafPFtuExsmfDi9RsrexTxzdxsmk3Mo/YB4plx3jvj7dXFdN/YzJQ8p5hUYWDY2bCZv4PyIGCAzR4eNGk2I42BEQajTQytQo=
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com (52.134.243.14) by
 OSBPR01MB2149.jpnprd01.prod.outlook.com (52.134.241.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Mon, 20 Aug 2018 03:22:04 +0000
Received: from OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::64ba:c30f:4366:5723]) by OSBPR01MB2293.jpnprd01.prod.outlook.com
 ([fe80::64ba:c30f:4366:5723%2]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 03:22:04 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     gregkh <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johan Hovold <johan@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hide usb_of_get_companion_dev for CONFIG_USB=n
Thread-Topic: [PATCH] usb: hide usb_of_get_companion_dev for CONFIG_USB=n
Thread-Index: AQHUM0+HsK8qGELHVE2S+ootR3xPkaS/Rx6AgAAH2ACACLMj4A==
Date:   Mon, 20 Aug 2018 03:22:04 +0000
Message-ID: <OSBPR01MB22931014287A7641FFBFBE56D8320@OSBPR01MB2293.jpnprd01.prod.outlook.com>
References: <20180813214924.3567840-1-arnd@arndb.de>
 <Pine.LNX.4.44L0.1808140957350.1466-100000@iolanthe.rowland.org>
 <CAK8P3a33DRBj6ZeJBeWGnw3RnpK3rTaYtrbs6jjZ8VVPOk8=qw@mail.gmail.com>
In-Reply-To: <CAK8P3a33DRBj6ZeJBeWGnw3RnpK3rTaYtrbs6jjZ8VVPOk8=qw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [211.11.155.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2149;20:NSdevYgK6g2ifxU04jAckfY6di82ya3GZ6rSlnyKRvU1c2/5iGLoGqoOFfeAtjR2X7YCgH8Tkyh51bIkN0o1WwAxogQ4P6CvhynGpy/6uDG92qGkXyOF6u+xAF6uuLGd7KfHB2pl9Nwm4k88Cri/wVyY+yR43PBo/qKuLT6av9Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ce5698d9-4db7-4754-623c-08d6064c1a4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2149;
x-ms-traffictypediagnostic: OSBPR01MB2149:
x-microsoft-antispam-prvs: <OSBPR01MB2149B62A704378E150BC485CD8320@OSBPR01MB2149.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(35762410373642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:OSBPR01MB2149;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2149;
x-forefront-prvs: 0770F75EA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(6306002)(9686003)(76176011)(81156014)(8676002)(81166006)(6246003)(478600001)(186003)(966005)(54906003)(2171002)(97736004)(53936002)(26005)(99286004)(33656002)(7696005)(5660300001)(4326008)(25786009)(55016002)(74316002)(7736002)(6116002)(3846002)(305945005)(2900100001)(6436002)(86362001)(5250100002)(106356001)(105586002)(102836004)(256004)(446003)(110136005)(66066001)(68736007)(229853002)(11346002)(476003)(14454004)(6506007)(53546011)(486006)(2906002)(345774005)(8936002)(316002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2149;H:OSBPR01MB2293.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A10+R7BDUf7NsJaIjIWJNnl980JgnZXcHXDAjjiSbJkG5m4is++ZcME2Jit43MC0NfCiRSWCLVHssmuNiut2DYX4PApDkdFJPqf3Y/xpHyq8MWrAV+EiPSu8RNEMWZ2oH0S7QHb5Fj9yNuiar3poS3XPCR0F2teErgKocz0hm7DYDZZEFyRefp5VBMHbYJZ+iGdU09GZNi3DIGmiJHo90VFt1VfHjiFxXC7z3ofI3hYzpJjXJ4ywYX6cQXPJhgITd85PbV+krtOWxropTr2n//h0AMVyp3CV9rmFlzYSzcJc4cm6mK/cKaZ1HHpsAX2sgD4Iyq3D8zbDjlgnQ7M0ThUNc+qq/38Z6Eq/NBJ1dCU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5698d9-4db7-4754-623c-08d6064c1a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 03:22:04.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uLCBTZW50OiBUdWVzZGF5LCBBdWd1c3Qg
MTQsIDIwMTggMTE6MjcgUE0NCj4gDQo+IE9uIFR1ZSwgQXVnIDE0LCAyMDE4IGF0IDM6NTggUE0g
QWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5oYXJ2YXJkLmVkdT4gd3JvdGU6DQo+ID4gT24gTW9u
LCAxMyBBdWcgMjAxOCwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL0tjb25maWcgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL0tj
b25maWcNCj4gPiA+IGluZGV4IDBhMTZjYmQ0ZTUyOC4uNjYzYThiZDY3YTdiIDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9LY29uZmlnDQo+ID4gPiArKysgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL0tjb25maWcNCj4gPiA+IEBAIC0xOTMsNiArMTkzLDcgQEAgY29u
ZmlnIFVTQl9SRU5FU0FTX1VTQjMNCj4gPiA+ICAgICAgIHRyaXN0YXRlICdSZW5lc2FzIFVTQjMu
MCBQZXJpcGhlcmFsIGNvbnRyb2xsZXInDQo+ID4gPiAgICAgICBkZXBlbmRzIG9uIEFSQ0hfUkVO
RVNBUyB8fCBDT01QSUxFX1RFU1QNCj4gPiA+ICAgICAgIGRlcGVuZHMgb24gRVhUQ09ODQo+ID4g
PiArICAgICBkZXBlbmRzIG9uIFVTQiB8fCAhVVNCDQo+ID4NCj4gPiBJcyB0aGlzIHNvbWUgd2Vp
cmQgc3RhbmRhcmQgaWRpb20/ICBJdCBsb29rcyByZWFsbHkgc3RyYW5nZS4NCj4gDQo+IFllcywg
YW5kIHllcy4NCj4gDQo+IEEgbGVzcyBjb21tb24gd2F5IHRvIHdyaXRlIGl0IGlzDQo+IA0KPiAg
ICAgICAgIGRlcGVuZHMgb24gKFVTQiAhPSBtKSB8fCBtDQo+IA0KPiB3aGljaCBzb21lIHBlb3Bs
ZSBwcmVmZXIsIGJ1dCBJIGZpbmQgZXZlbiB3ZWlyZGVyLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBw
YXRjaCENCg0KT24gb3RoZXIgdGhyZWFkLCBKb2huIG1lbnRpb25zIGdhZGdldC1zaWRlIGRyaXZl
cnMgc2hvdWxkIG5vdCBkZXBlbmQgb24gaG9zdC1zaWRlIFsxXS4NClNvLCBJIHN1Ym1pdHRlZCBh
IHBhdGNoIHRvZGF5IFsyXS4gV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgbXkgc3VibWl0dGVkIHBh
dGNoPw0KDQpbMV0NCmh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LXVzYiZtPTE1MzQzMzc3NjIw
Mjg2MSZ3PTINCg0KWzJdDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNTY5
ODQ3Lw0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+ICAgICAgICBBcm5k
DQo=
