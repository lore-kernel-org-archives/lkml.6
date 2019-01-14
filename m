Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D49C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD54A20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PNYKIDZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbfANJwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:52:45 -0500
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:14144
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfANJwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw3XIN4/I6Zp1tVmMvX++A2HlVt5e7tSiCuaMvp1Y4U=;
 b=PNYKIDZE5fa/1ccsB9G1gl+oB1zqLictG1zCpAkMaN4mPtcppFKzeyvPnTlkfjbzLarPd7qkJO+y+T+RuEo66brKy80qAZZlJnASNOveQZkolbhIwPU/TvejxJhonKu7SZlEz9FOyRKNLeGpb2mpCTtRLb5B7OcmWdo4Owt3ns4=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB3118.eurprd04.prod.outlook.com (10.170.229.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 09:52:39 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::39b7:fa32:e307:a294]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::39b7:fa32:e307:a294%2]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 09:52:39 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: RE: [PATCH 2/2] arm64: dts: lx2160a: add sata node support
Thread-Topic: [PATCH 2/2] arm64: dts: lx2160a: add sata node support
Thread-Index: AQHUqMzIL7kuSZVoR0q13BuNpYFHy6WsmO0AgAHy+KA=
Date:   Mon, 14 Jan 2019 09:52:38 +0000
Message-ID: <VI1PR04MB4431BD06BD9651BEEED031E9ED800@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190110100533.33333-1-peng.ma@nxp.com>
 <20190110100533.33333-2-peng.ma@nxp.com> <20190113040546.GL11426@dragon>
In-Reply-To: <20190113040546.GL11426@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3118;6:mok2st0DoBSqXZ/JHaorOjgOoldnaICFak/joJWllAo7LanXHGEZsVJHcv+/Un7APFugSIWuyCrKwCnGiTqMVLRuQ6TIyB07FBIPNtRlC/+hhrSMIri8nns4VIJurpChVfo7lvDAj0w0chaccbopqa3YAnLq1o9+VIN4e8LSfNDju7s6SMzxupXK1oUXFVh0+z272C883J6lghkj8bFpsWWpMDq1S+eHANrEJUYth5uMvcTNuJGnjy5tPvXlN4NxFtjtCGWveOBpP5ItM+JQAlgALXwfW6Fdw+zA2RjbcQ0c5TdiTfGDTUS3l9XYllTXa2rStQpRKG83Gn1ue3vql2jTpLEm7hvp+Mne9KXIowsolgUDZoZ0Rt2f1hGAFZCerk98Jo9kfiopP53Ktnabl6F20FSdaHF7tOV91juZoeEJSJsm8E5dOwja8vw52w+iET5NMc2v7YB4tz/TcDEUwA==;5:ERauOZ3t1Cp8QZohUvH/BPnr+g6Imvq1Je0mcaWBhhdWEpfMGmbwNY5ZEbDj9dKb2eqglqKJ+6lqZMN1AJVxOxi3psqYLeWnzNihGZFE4aztuvE6V3FDo23w6qe9230NIPya+VEQf44zVjO02FW1w4FJTdjbjV8+g4pcSMI0iwQmMYKrHiowSmeve44l0tYa0CUuVZQfZgannYbl1/mc1A==;7:nUGYTxTwFppEuQ/q0bnvnoNQjGEW052Lkvex4TmCWhIv9sQO50uoTOIx6aiiLtIAUMbGuBYXgYQT30bupEnwL2x4/cRnSivYvzelrXXgxB2YvNIFBmb9J+BKF7tWNofnMlFaUSD8BxS/DKS2ESIEiA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ee21baaf-3cf1-4833-7e5c-08d67a0604e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3118;
x-ms-traffictypediagnostic: VI1PR04MB3118:
x-microsoft-antispam-prvs: <VI1PR04MB31188C2962D0F809563887EFED800@VI1PR04MB3118.eurprd04.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(376002)(136003)(13464003)(199004)(189003)(66066001)(478600001)(11346002)(229853002)(476003)(446003)(6116002)(3846002)(44832011)(486006)(68736007)(7696005)(186003)(26005)(6506007)(102836004)(76176011)(6436002)(33656002)(256004)(81166006)(81156014)(6916009)(55016002)(305945005)(8676002)(7736002)(8936002)(14444005)(99286004)(105586002)(106356001)(86362001)(316002)(97736004)(54906003)(14454004)(71190400001)(71200400001)(4326008)(9686003)(74316002)(53936002)(5660300001)(2906002)(6246003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3118;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: thi6Vhb1gaciVBJtEhNfuuRkJXILuG0GU+nuHtDTVM8R0zSkNgVp8TCOlkExq05jh7z2yf2qa17BlJOVaaAYE5VfTfqpgwHIhD0kzOBCDkSOArdcCQdrENw0wJSOMzoRmt5MV5iEepFcL7mWh1GZ4FJcttgSN6y+ZZ7AZDGYlXxfp6KGKnYh5YgjMquwHGcwbWWheTyc7FW6VZ0MwZuWRveWxp5tLx+f/M9jBc25aG0zKuDJs3gH/uM+74Unf9ftvwOzTQb+abPWeie+Qwigd7bLY1qUWrFeZiGel6IJbeMaQf3OsDqXhPSFSACsmAzAiGk9JXyeiqlMzol8cbIInW/kbr4+5UBheueMWM7pu535z0On1iqPkq97bQbheu6GwsgHstJQDEWBeu1Qx9V3GN5kD+9h9uR5xf5rJ+fRAss=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee21baaf-3cf1-4833-7e5c-08d67a0604e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 09:52:38.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4NCj5TZW50OiAyMDE5xOox1MIxM8jVIDEyOjA2DQo+VG86IFBlbmcgTWEg
PHBlbmcubWFAbnhwLmNvbT4NCj5DYzogYXhib2VAa2VybmVsLmRrOyBMZW8gTGkgPGxlb3lhbmcu
bGlAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj5tYXJrLnJ1dGxhbmRAYXJtLmNvbTsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPmRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPmxpbnV4LWlkZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gYXJtNjQ6IGR0czogbHgyMTYw
YTogYWRkIHNhdGEgbm9kZSBzdXBwb3J0DQo+DQo+T24gVGh1LCBKYW4gMTAsIDIwMTkgYXQgMDY6
MDU6MzNQTSArMDgwMCwgUGVuZyBNYSB3cm90ZToNCj4+IEFkZCBzYXRhIG5vZGUgc3VwcG9ydCBh
bmQgRW5hYmxlIHNhdGEgc3VwcG9ydA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFBlbmcgTWEgPHBl
bmcubWFAbnhwLmNvbT4NCj4+IC0tLQ0KPj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjBhLXJkYi5kdHMgfCAgIDE2ICsrKysrKysNCj4+ICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpICAgIHwgICA0NA0KPisrKysrKysrKysrKysr
KysrKysrKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWx4MjE2MGEtcmRiLmR0cw0KPmIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNs
LWx4MjE2MGEtcmRiLmR0cw0KPj4gaW5kZXggNjQ4MWU1Zi4uYWFjY2EyNyAxMDA2NDQNCj4+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCj4+
ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMN
Cj4+IEBAIC0xMTcsMyArMTE3LDE5IEBADQo+PiAgJnVzYjEgew0KPj4gIAlzdGF0dXMgPSAib2th
eSI7DQo+PiAgfTsNCj4+ICsNCj4+ICsmc2F0YTAgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+
PiArfTsNCj4+ICsNCj4+ICsmc2F0YTEgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsN
Cj4+ICsNCj4+ICsmc2F0YTIgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+ICsN
Cj4+ICsmc2F0YTMgew0KPj4gKwlzdGF0dXMgPSAib2theSI7DQo+PiArfTsNCj4+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+Yi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+PiBpbmRleCBh
NzlmNWMxLi5lODU3YTE0IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0KPj4gQEAgLTc2Miw1ICs3NjIsNDkgQEANCj4+ICAJCQkJ
ICAgICA8R0lDX1NQSSAyMDkgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+PiAgCQkJZG1hLWNvaGVy
ZW50Ow0KPj4gIAkJfTsNCj4+ICsNCj4+ICsJCXNhdGEwOiBzYXRhQDMyMDAwMDAgew0KPj4gKwkJ
CXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+DQo+V2UgdXN1YWxseSBoYXZlICdzdGF0dXMnIGF0IHRo
ZSBlbmQgb2YgcHJvcGVydHkgbGlzdC4NCj4NCj5TaGF3bg0KW1BlbmcgTWFdIA0KT2ssIGdvdCBp
dCwgdGhhbmtzIHl1cmUgcXVpY2sgcmVwbHkuDQpSZWdhcmRzLA0KUGVuZw0KPg0KPj4gKwkJCWNv
bXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtYWhjaSI7DQo+PiArCQkJcmVnID0gPDB4MCAweDMyMDAw
MDAgMHgwIDB4MTAwMDA+LA0KPj4gKwkJCSAgICAgIDwweDcgMHgxMDA1MjAgMHgwIDB4ND47DQo+
PiArCQkJcmVnLW5hbWVzID0gImFoY2kiLCAic2F0YS1lY2MiOw0KPj4gKwkJCWludGVycnVwdHMg
PSA8R0lDX1NQSSAxMzMgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+PiArCQkJY2xvY2tzID0gPCZj
bG9ja2dlbiA0IDM+Ow0KPj4gKwkJCWRtYS1jb2hlcmVudDsNCj4+ICsJCX07DQo+PiArDQo+PiAr
CQlzYXRhMTogc2F0YUAzMjEwMDAwIHsNCj4+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4g
KwkJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtYWhjaSI7DQo+PiArCQkJcmVnID0gPDB4MCAw
eDMyMTAwMDAgMHgwIDB4MTAwMDA+LA0KPj4gKwkJCSAgICAgIDwweDcgMHgxMDA1MjAgMHgwIDB4
ND47DQo+PiArCQkJcmVnLW5hbWVzID0gImFoY2kiLCAic2F0YS1lY2MiOw0KPj4gKwkJCWludGVy
cnVwdHMgPSA8R0lDX1NQSSAxMzYgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+PiArCQkJY2xvY2tz
ID0gPCZjbG9ja2dlbiA0IDM+Ow0KPj4gKwkJCWRtYS1jb2hlcmVudDsNCj4+ICsJCX07DQo+PiAr
DQo+PiArCQlzYXRhMjogc2F0YUAzMjIwMDAwIHsNCj4+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPj4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtYWhjaSI7DQo+PiArCQkJcmVnID0g
PDB4MCAweDMyMjAwMDAgMHgwIDB4MTAwMDA+LA0KPj4gKwkJCSAgICAgIDwweDcgMHgxMDA1MjAg
MHgwIDB4ND47DQo+PiArCQkJcmVnLW5hbWVzID0gImFoY2kiLCAic2F0YS1lY2MiOw0KPj4gKwkJ
CWludGVycnVwdHMgPSA8R0lDX1NQSSA5NyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+ICsJCQlj
bG9ja3MgPSA8JmNsb2NrZ2VuIDQgMz47DQo+PiArCQkJZG1hLWNvaGVyZW50Ow0KPj4gKwkJfTsN
Cj4+ICsNCj4+ICsJCXNhdGEzOiBzYXRhQDMyMzAwMDAgew0KPj4gKwkJCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+PiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1haGNpIjsNCj4+ICsJCQly
ZWcgPSA8MHgwIDB4MzIzMDAwMCAweDAgMHgxMDAwMD4sDQo+PiArCQkJICAgICAgPDB4NyAweDEw
MDUyMCAweDAgMHg0PjsNCj4+ICsJCQlyZWctbmFtZXMgPSAiYWhjaSIsICJzYXRhLWVjYyI7DQo+
PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEwMCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4+
ICsJCQljbG9ja3MgPSA8JmNsb2NrZ2VuIDQgMz47DQo+PiArCQkJZG1hLWNvaGVyZW50Ow0KPj4g
KwkJfTsNCj4+ICAJfTsNCj4+ICB9Ow0KPj4gLS0NCj4+IDEuNy4xDQo+Pg0K
