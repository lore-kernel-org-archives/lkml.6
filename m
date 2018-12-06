Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C21BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58C20879
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="DSJ0NQPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C58C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeLFA7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:59:53 -0500
Received: from mail-eopbgr1400101.outbound.protection.outlook.com ([40.107.140.101]:44144
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727358AbeLFA7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt48WGdo9FONGyjVDmJ2LIhkykVXkp5vjm9VxvpZUXE=;
 b=DSJ0NQPD1RoPdmawdUw+E+jm533VD/v0FGlDaZIudWBhz1O5c+nQFV6KmffS1adgntgcP2ZYetDRbtZY+Pl6+IoSdTxL65RjSwDRIGsnQJwTin3t4oVqzKs0omxtRnYVXHwx7eAlWtf00abNLcRty/eK0bAuomfBb5c9xNrp3HI=
Received: from OSAPR01MB3652.jpnprd01.prod.outlook.com (20.178.102.21) by
 OSAPR01MB2676.jpnprd01.prod.outlook.com (52.134.248.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 00:59:46 +0000
Received: from OSAPR01MB3652.jpnprd01.prod.outlook.com
 ([fe80::1082:83c0:48f5:59a6]) by OSAPR01MB3652.jpnprd01.prod.outlook.com
 ([fe80::1082:83c0:48f5:59a6%4]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 00:59:46 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Jiada Wang <jiada_wang@mentor.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "vladimir_zapolskiy@mentor.com" <vladimir_zapolskiy@mentor.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-next v3 6/7] ASoC: rsnd: add avb clocks
Thread-Topic: [PATCH linux-next v3 6/7] ASoC: rsnd: add avb clocks
Thread-Index: AQHUjHi5uIHaJM2ZQUK9E1ICoJh5yg==
Date:   Thu, 6 Dec 2018 00:59:44 +0000
Message-ID: <878t13jx6y.wl-kuninori.morimoto.gx@renesas.com>
References: <20181205074932.28098-1-jiada_wang@mentor.com>
        <87va48bbpa.wl-kuninori.morimoto.gx@renesas.com>
        <612ee648-c217-e9b4-224c-87183e43d83d@mentor.com>
In-Reply-To: <612ee648-c217-e9b4-224c-87183e43d83d@mentor.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::24) To OSAPR01MB3652.jpnprd01.prod.outlook.com
 (2603:1096:604:58::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSAPR01MB2676;20:Bv8MV5L6Ezb5UzavukJ2ZOupIsP2PALMVaw9E4NAVvjm+Fj9kq2KprEmsNAzD3MaidPXca0IdvTOaXeFyUsT3yWXyY2P9nt2zmJ5sPUScrhRZhpHJd8oD5MWINzPoOTrslNVpBiTJr4nbT9R/X3XtUIAZjFNwXz+jnrOeyX5Tsc=
x-ms-office365-filtering-correlation-id: 26323770-6890-4a5b-f24d-08d65b161bd2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSAPR01MB2676;
x-ms-traffictypediagnostic: OSAPR01MB2676:
x-microsoft-antispam-prvs: <OSAPR01MB2676292E80BA83EDB23EACF1D4A90@OSAPR01MB2676.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:OSAPR01MB2676;BCL:0;PCL:0;RULEID:;SRVR:OSAPR01MB2676;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(14454004)(52116002)(6246003)(8936002)(76176011)(54906003)(7736002)(305945005)(81166006)(36756003)(6916009)(68736007)(81156014)(2906002)(316002)(66066001)(3846002)(6512007)(102836004)(26005)(186003)(25786009)(6116002)(5660300001)(8676002)(53936002)(105586002)(99286004)(106356001)(4326008)(6506007)(386003)(39060400002)(446003)(478600001)(71190400001)(86362001)(575784001)(71200400001)(476003)(486006)(11346002)(2616005)(6486002)(6436002)(256004)(229853002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB2676;H:OSAPR01MB3652.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MT4j8PAfOh0SKgbBA0ADXwFNPd83xDKjsHIYnqYYH/6uLhciRuGQZD63oUHUi74pWNdRYNyXcyc/SsP86h1Ww7uigSUGmCtHm+U5OQitCJ2nThj9lC8uaEVmWd8yk3wVeW31wAJc9C7sxGLPup9fIjl9lzmsFFQAROgYtS/T61p2jcQVDltN/hlFsTcRZ5l+xdQ+WeOICJqcydwa8MTW2qCdmYn3JXzjwlmsn35Snz1zl0iHNMpEaY6nIYhvZgsxDU4L4iwyWR0IxVsmAjUTjun3yGljqQNwsXGIQpc7OurxsvOD7f50/0BHoH4+z0RTHCX6cCG4wyEXVs6E6DHqUEVJKhBSdUn1L9tEHhrD3hg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D115A518988F4147A0B678A391742412@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26323770-6890-4a5b-f24d-08d65b161bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 00:59:44.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBKaWFkYQ0KDQo+ID4+ICsJYXZiID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCphdmIp
LCBHRlBfS0VSTkVMKTsNCj4gPj4gKwlpZiAoIWF2YikNCj4gPj4gKwkJcmV0dXJuIEVSUl9QVFIo
LUVOT01FTSk7DQo+ID4+ICsNCj4gPj4gKwlwYXJlbnRfbmFtZSA9IF9fY2xrX2dldF9uYW1lKGFk
Zy0+Y2xrYWRnKTsNCj4gPiBUaGlzIHBhcmVudF9uYW1lIGlzIHZlcnkgc3RyYW5nZSB0byBtZS4N
Cj4gPiBBVkIgcGFyZW50IGNsayBpcyAiQVVESU9fQ0xLX0EvQi9DL0kiICg9IGNsa19hL2IvYy9p
IGluIHRoaXMgZHJpdmVyKQ0KPiA+IG9yICJBVURJT19DTEtfT1VUX0EvQi9DL0QiICg9IGF1ZGlv
X2Nsa291dC8xLzIvMyBpbiB0aGlzIGRyaXZlcikuDQo+ID4gQW5kIHdlIGRvbid0IGhhdmUgImFk
ZyIgY2xvY2suDQo+ID4gUGxlYXNlIGRvdWJsZSBjaGVjayBpdC4NCj4gSSBoYXZlIHNvbWUgbG9j
YWwgZGV2aWNlLXRyZWUgY2hhbmdlLCB3aGljaCBleHBlbmRzICdhZGcnIHJlZ2lzdGVyDQo+IHJh
bmdlIGFuZCBhZGQNCj4gImFkZyIgY2xvY2sgdG8gcmNhcl9zb3VuZCBub2RlIHdoaWNoIHJlZmVy
IHRvIG5ld2x5IGFkZGVkICdhZGcnIGNsb2NrDQo+IChTMEQxz5UpIGluIHRoaXMgcGF0Y2gtc2V0
DQooc25pcCkNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGNsb2NrcyA9IDwmY3BnIENQR19NT0QgMTAwNT4sDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbG9ja3MgPSA8JmNwZyBDUEdfTU9EIDkyMj4sIDwmY3Bn
IENQR19NT0QgMTAwNT4sDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPCZjcGcgQ1BHX01PRCAxMDA2PiwgPCZjcGcgQ1BH
X01PRCAxMDA3PiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNwZyBDUEdfTU9EIDEwMDg+LCA8JmNwZyBDUEdfTU9E
IDEwMDk+LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDwmY3BnIENQR19NT0QgMTAxMD4sIDwmY3BnIENQR19NT0QgMTAx
MT4sDQo+IEBAIC0xODU2LDcgKzE4NTYsNyBAQA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwmYXVkaW9fY2xrX2E+LCA8
JmF1ZGlvX2Nsa19iPiwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmF1ZGlvX2Nsa19jPiwNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmNw
ZyBDUEdfQ09SRSBSOEE3Nzk1X0NMS19TMEQ0PjsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2NrLW5hbWVzID0gInNzaS1hbGwiLA0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xvY2stbmFtZXMgPSAiYWRn
IiwgInNzaS1hbGwiLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAic3NpLjkiLCAic3NpLjgiLCAic3Np
LjciLCAic3NpLjYiLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAic3NpLjUiLCAic3NpLjQiLCAic3Np
LjMiLCAic3NpLjIiLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAic3NpLjEiLCAic3NpLjAiLA0KDQpO
b29vbyAhIQ0KSXQgYnJlYWtzIHNvdW5kIGNsb2NrIC8gbW9kdWxlIHN0b3AgY29udHJvbGluZyAh
IQ0KDQpPSywgbm93IEkgY2hlY2tlZCBtb3JlIGRldGFpbCBvZiBBREcgZm9yIEVBVkIvSUYuDQoN
CjFzdCwgSSBkb24ndCB0aGluayB3ZSBuZWVkIHRvIGFkZCAiYWRnIiBjbG9jay4NCkl0IGlzIG5v
dCBleGlzdCBvbiBHZW4yLCBhbmQgZGVmYXVsdCBPTiBvbiBHZW4zLg0KSWYgeW91IHdhbnQgdG8g
YWRkIGl0LCBwbGVhc2UgYWRkIGl0IHRvICJsYXN0IiBvZiBjbG9ja3MsIG5vdCAiZmlyc3QiLg0K
ImZpcnN0IiBjbG9jayBpcyBoYW5kbGluZyB3aG9sZSBTU0kgcG93ZXIuDQoNCjJuZCwgaXQgaXMg
Ik1vZHVsZSBzdG9wIGNsb2NrIiwgbm90ICJTMEQxz5UiLg0KV2UgYWxyZWFkeSBoYW5kbGluZyBp
dCBhcyAiY2xrX2kiLg0KDQozcmQsIHdlIG5lZWQgdG8gY3JlYXRlIG5ldyBjbG9jay9oYW5kbGVy
IGZvcg0KYXZiX2NvdW50ZXI4IC8gYXVkaW9fY2xrX2RpdjMgLyBhdmJfZGl2OCBmb3IgImludGVy
bmFsIiBwdXJwb3NlLA0KYW5kIG5lZWQgdG8gY3JlYXRlIGF2Yl9hZGdfc3luW10gY2xvY2sgZm9y
ICJleHRlcm5hbCIgcHVycG9zZSBmb3IgRUFWQi9JRi4NCllvdXIgY29kZSBpcyBjcmVhdGluZyAv
IHJlZ2lzdGVyaW5nIGFkZy0+Y2xrYXZiW10sDQpidXQgaXQgaXMgZm9yIGF2Yl9jb3VudGVyOCBp
biBteSB1bmRlcnN0YW5kaW5nLg0KV2UgZG9uJ3QgbmVlZCB0byByZWdpc3RlciBpdCBhcyBmb3Jt
YWwgY2xvY2sgSU1PLg0KDQo0dGgsIEVBVkIgZHJpdmVyIG5lZWQgdG8gZ2V0IGNsb2NrIGZyb20g
QVZCIHZpYSBEVA0KYXMgImF2Yl9hZGdfc3luW10iIGNsb2NrLCBub3QgImF2Yl9jb3VudGVyOCIu
DQoNCkknbSBub3Qgc3VyZSBFQVZCIHNpZGUgZHJpdmVyLCBidXQgcGxlYXNlIGRvdWJsZSBjaGVj
ayB0aGVzZS4NCg0KDQpCZXN0IHJlZ2FyZHMNCi0tLQ0KS3VuaW5vcmkgTW9yaW1vdG8NCg==
