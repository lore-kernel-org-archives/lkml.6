Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75498C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9FF2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="QGSC1Mca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9FF2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeLEI6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:58:49 -0500
Received: from mail-eopbgr1410107.outbound.protection.outlook.com ([40.107.141.107]:29696
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeLEI6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7dPZ8M457orKoBAoTKPNkgebLGbWN1mHbWzuAuJjJg=;
 b=QGSC1McarGkGDHSMnQC3R2VK+QKGzL7HK1R6tfinzs+WBpmHSN+zGbfV/u2WoSW2evKVUnNd3PU3KP5qbBlywuyI8AiL2/IlRRLmMOfZhFSVyvzhbk+bGnNAWx0CwhmDresaAnvuMGXoxGnMWC0sYxaZWwmac3MasOi9rSFyIAE=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2192.jpnprd01.prod.outlook.com (52.133.178.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 08:58:44 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:58:44 +0000
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
Date:   Wed, 5 Dec 2018 08:58:44 +0000
Message-ID: <87va48bbpa.wl-kuninori.morimoto.gx@renesas.com>
References: <20181205074932.28098-1-jiada_wang@mentor.com>
In-Reply-To: <20181205074932.28098-1-jiada_wang@mentor.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:404:56::27) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2192;20:NQuFSMSzn4hEaoF99N/kiEjO8sMJ+qhLPtZTuK84Y7tLpR7RX+o+s6V3+c37dq8WNYW/GrwdjBPttRc6EqhXKgYXIZCb6f5gSVcYMRtMdixKQH0c5IvySfcZrFxdrHfkI0pawH92Nava9g95fGReAEX1GEHVO1yeRid7ZZR33TM=
x-ms-office365-filtering-correlation-id: 7fa096eb-173f-4207-cabf-08d65a8fdbb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2192;
x-ms-traffictypediagnostic: TYAPR01MB2192:
x-microsoft-antispam-prvs: <TYAPR01MB219221DA68BEBBDF9B0FC19CD4A80@TYAPR01MB2192.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2192;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2192;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(6486002)(86362001)(106356001)(186003)(66066001)(76176011)(52116002)(229853002)(102836004)(316002)(26005)(54906003)(6916009)(476003)(5660300001)(386003)(53936002)(6506007)(446003)(11346002)(2616005)(6512007)(8936002)(478600001)(68736007)(105586002)(7736002)(97736004)(6246003)(4326008)(3846002)(6116002)(14444005)(25786009)(256004)(486006)(305945005)(8676002)(39060400002)(36756003)(71190400001)(71200400001)(2906002)(99286004)(6436002)(81156014)(575784001)(14454004)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2192;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7RoY4ioHffAyM6fmvYjCV9NKNWXZ5fEdaVsbp3eiQpmh9CVgW0HsnovpXgbfzMeeDzAKjHwMZICtS8bZcirUj4bVjZvVUY8jQxlCQLbjWzUVAP8+J19stXKeFoWGF8PjxpQ4JwX8CAOy5aOfsmxYnPky6kuyd1dO3pEPQ7X1LPLlEUgjzNmy7ZQFZMAxm6P1vKcwrpR/jA7rColBgz33I6Ys3booVDcDd6/USI4Q5JdzZZmO9b+iJ8MRxBR/Pnlqud5ZJgoI0af0caZPWwGtmwnyixkVOqfy0CMrqRX9eGWE4t+arAoQFI62v9cuQhmKU5o8McEgOuMymXepmZ9HkK2ZgbTkEf4cWN4u2dTnv7Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8ADCEF26383C647801614EEBC277C64@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa096eb-173f-4207-cabf-08d65a8fdbb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:58:44.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBKaWFkYQ0KDQo+IFRoZXJlIGFyZSBBVkIgQ291bnRlciBDbG9ja3MgaW4gQURHLCBlYWNo
IGNsb2NrIGhhcyAxMmJpdHMgaW50ZWdyYWwNCj4gYW5kIDggYml0cyBmcmFjdGlvbmFsIGRpdmlk
ZXJzIHdoaWNoIG9wZXJhdGVzIHdpdGggUzBEMc+VIGNsb2NrLg0KPiANCj4gVGhpcyBwYXRjaCBy
ZWdpc3RlcnMgOCBBVkIgQ291bnRlciBDbG9ja3Mgd2hlbiBjbG9jay1jZWxscyBvZg0KPiByY2Fy
X3NvdW5kIG5vZGUgaXMgMiwNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppYWRhIFdhbmcgPGppYWRh
X3dhbmdAbWVudG9yLmNvbT4NCj4gLS0tDQoNCg0KPiArc3RhdGljIHZvaWQgY2xrX2F2Yl9kaXZf
d3JpdGUoc3RydWN0IHJzbmRfYWRnICphZGcsIHUzMiBkYXRhLCB1bnNpZ25lZCBpbnQgaWR4KQ0K
KHNuaXApDQo+ICtzdGF0aWMgdTMyIGNsa19hdmJfZGl2X3JlYWQoc3RydWN0IHJzbmRfYWRnICph
ZGcsIHVuc2lnbmVkIGludCBpZHgpDQoNCkFzIEkgbWVudGlvbmVkIGJlZm9yZSwgSSB0aGluayB3
ZSBjYW4gYXZvaWQgY29uZnVzYWJsZSBwYXJhbWV0ZXIgYnkNCg0KCXN0YXRpYyB2b2lkIGNsa19h
dmJfZGl2X3dyaXRlKHN0cnVjdCBjbGtfYXZiICphdmIsIHUzMiBkYXRhKQ0KCXN0YXRpYyB1MzIg
Y2xrX2F2Yl9kaXZfcmVhZChzdHJ1Y3QgY2xrX2F2YikJDQoNCglkaXYgPSBjbGtfYXZiX2Rpdl9y
ZWFkKGF2Yik7DQoJY2xrX2F2Yl9kaXZfd3JpdGUoYXZiLCB2YWwgfCBkaXYpOw0KDQo+ICtzdGF0
aWMgc3RydWN0IGNsayAqY2xrX3JlZ2lzdGVyX2F2YihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dCByc25kX2FkZyAqYWRnLA0KPiArCQkJCSAgICB1bnNpZ25lZCBpbnQgaWQsIHNwaW5sb2NrX3Qg
KmxvY2spDQo+ICt7DQo+ICsJc3RydWN0IGNsa19pbml0X2RhdGEgaW5pdDsNCj4gKwlzdHJ1Y3Qg
Y2xrX2F2YiAqYXZiOw0KPiArCXN0cnVjdCBjbGsgKmNsazsNCj4gKwljaGFyIG5hbWVbOF07DQo+
ICsJY29uc3QgY2hhciAqcGFyZW50X25hbWU7DQo+ICsNCj4gKwlpZiAoSVNfRVJSKGFkZy0+Y2xr
YWRnKSkNCj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7DQoNCkkgdGhpbmsgYWRnLT5jbGth
ZGcgd2lsbCBuZXZlciBoaXQgdG8gSVNfRVJSKCkuDQpJdCB3aWxsIGhhdmUgTlVMTCBvciBjb3Jy
ZWN0IHBvaW50ZXIuDQoNCgljbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAiYWRnIik7DQoJaWYgKCFJ
U19FUlIoY2xrKSkNCgkJYWRnLT5jbGthZGcgPSBjbGs7DQoNCkFuZCB0aGlzICJhZGciIGNsb2Nr
IGlzIHN0cmFuZ2UuDQpzZWUgYmVsb3cNCg0KPiArCWF2YiA9IGRldm1fa3phbGxvYyhkZXYsIHNp
emVvZigqYXZiKSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFhdmIpDQo+ICsJCXJldHVybiBFUlJf
UFRSKC1FTk9NRU0pOw0KPiArDQo+ICsJcGFyZW50X25hbWUgPSBfX2Nsa19nZXRfbmFtZShhZGct
PmNsa2FkZyk7DQoNClRoaXMgcGFyZW50X25hbWUgaXMgdmVyeSBzdHJhbmdlIHRvIG1lLg0KQVZC
IHBhcmVudCBjbGsgaXMgIkFVRElPX0NMS19BL0IvQy9JIiAoPSBjbGtfYS9iL2MvaSBpbiB0aGlz
IGRyaXZlcikNCm9yICJBVURJT19DTEtfT1VUX0EvQi9DL0QiICg9IGF1ZGlvX2Nsa291dC8xLzIv
MyBpbiB0aGlzIGRyaXZlcikuDQpBbmQgd2UgZG9uJ3QgaGF2ZSAiYWRnIiBjbG9jay4NClBsZWFz
ZSBkb3VibGUgY2hlY2sgaXQuDQoNCkJlc3QgcmVnYXJkcw0KLS0tDQpLdW5pbm9yaSBNb3JpbW90
bw0K
