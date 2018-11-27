Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04D5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72505208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pSn0vDJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72505208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeK0RSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:18:36 -0500
Received: from mail-eopbgr30063.outbound.protection.outlook.com ([40.107.3.63]:17488
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbeK0RSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVuN8c4WqJTXecBtC1UJizYjUmUEhZ4WAMnzpZ2N2k8=;
 b=pSn0vDJ0N3IYq5IEgnDtTxJXoLwqkqWQYSA9HkMeg7HlP/P/fvXlKoOvwK+FSCNBS896Cb5n92D+p6KSxC25Wjtq8w8X+wa6wouX2Fev8cwhIQ/DO3I8yC0F/wb858/CyKD5+3oq4LT9WBmtuQ1C4qsM7hAfWAd2FmN0qVH6e60=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 27 Nov 2018 06:21:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 06:21:05 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Topic: [PATCH] ARM64: dts: imx: add i.MX8QXP thermal support
Thread-Index: AQHUhhkRGF2zbaCoWk6q9yXIOFtdVKVjJm6A
Date:   Tue, 27 Nov 2018 06:21:05 +0000
Message-ID: <DB3PR0402MB39167E727CC0C0520806191BF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543299200-8526-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543299200-8526-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:aKStjDCTE0UJnmJz23XAaEEOfNHX4dPiKt7+C1VSMD+4lYxgH3J4cz0ltDHsaJlNTRvwcgNoBv21cqwdNv8izMf+KQfD3osj61T4WIOB6zeuY97BcLwMKYiRuq57yjGZ2kfy0M0BZcz8/kcIsrmQBawfiQX52m7FTTKN+V5sSq5VyC7/zWm6/0jnm5Ua2ZGqJyBChiswnMLyzqIa2Zdo8PFusr3K3LrSNFV7h21mAK5fONtOmBgrHODgEZ6CUAcZ6kB+lq/09L1GhMq0wyk7p3IiAaYWD1hFLCrO4GtG8qudXMwRYJfMS8+eVHiwmxY8IlPsDhuCmh5ON720hm0kLN2nPj7Sc48C8GRmjNpQfylWqjmSNtwzYV6UhMidbnE0t9uBt+VBkxh9kiN5RFkxYd3F/Xn3b2rHtG+d0OjyhfuYLEsBvgRe4QTt3Ej6stSDMcwIkec91zo/WM3dDsTRYA==;5:fj0Fm74hKcGKgfAq1njSVuqba2ZjyX/ZipoSfB9w0lasABg6G+vKUPOcAwxpS0SOzQdtsqz9uKNANviUZRLPMKzFe+F4kK7/1pkzJ+bv3RdHsN4tTDzRqhgPl6E9WBuqgEV9Z5zLcGuwMfA5ZPdSgViLLi6W1QY1a2/j7XmERkg=;7:5Dtez44Jj2JA5ayUgi2o4YpenRP/OasWsJPNNdiphEOVDIwcg+wWxK9ky+cI5pxUCmyVRcc2pFbaAAW4Ruam4vUxT3PNaWN+Vo5VArWlKli3BG1n2DlBNcf0Qz/OQ+sSpeYO6LQ+zARZ5/aZ6EOzNw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e65b5fc3-8877-485b-d3ac-08d65430834c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB365958615B125D111CC361C8F5D00@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3659;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3659;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(189003)(13464003)(97736004)(53546011)(6506007)(110136005)(4326008)(25786009)(102836004)(2501003)(8676002)(7736002)(26005)(8936002)(2201001)(76176011)(6306002)(7696005)(186003)(478600001)(55016002)(86362001)(53936002)(44832011)(6436002)(81156014)(81166006)(6246003)(476003)(11346002)(66066001)(105586002)(486006)(33656002)(3846002)(99286004)(6116002)(316002)(2906002)(106356001)(68736007)(229853002)(966005)(71200400001)(9686003)(71190400001)(74316002)(14454004)(305945005)(256004)(5660300001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LXvT+1wJUKrYAKFKCODZJhzDvAtRhojNrbsC5VfAiPt+v5nGMVCeFK1nvuuhS/qHsTqSAVYmMSrcNYvdWePepTGBZwEJTxxufAIIDYjP2npFzIS/DKXt/+JT00iZxLUid0LpECACSeBQmCZ3TMee0CP+1Ye2h7K9dpIiAySqK5w5RESXEQ4vnciGJP84WFKJXS8MMaABsmeFS66lYvMtfwqqDizAqqbxb/g57BDho09WffZA76VS9MR5eNSIM1Mvr2jz37bHqWnrxihg9QEbfWm6hSbo4/ZmikMXxNCdwzD4B3Sf5YIQ2DeamN81G6YvsBNeN9J1d1JTKNbO8Sm8L5dOs3rKaVS77Esv2Gn0P8I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65b5fc3-8877-485b-d3ac-08d65430834c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 06:21:05.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yZ290IHRvIG1lbnRpb25lZDogVGhpcyBwYXRjaCBpcyBiYXNlZCBvbiAiW1Y0LDMvNV0gYXJt
NjQ6IGR0czogaW14OiBhZGQgaW14OHF4cCBzdXBwb3J0IiwgaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC8xMDY3NzMxMS8NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50
OiAyMDE4xOoxMdTCMjfI1SAxNDoxOQ0KPiBUbzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1
dGxhbmRAYXJtLmNvbTsgQWlzaGVuZyBET05HDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBzaGF3bmd1b0BrZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIEFSTTY0OiBkdHM6IGlteDogYWRkIGkuTVg4UVhQIHRo
ZXJtYWwgc3VwcG9ydA0KPiANCj4gQWRkIGkuTVg4UVhQIENQVSB0aGVybWFsIHpvbmUgc3VwcG9y
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29t
Pg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaSB8
IDI3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDI3
IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4cXhwLmR0c2kNCj4gaW5kZXggZGE5OWI2Zi4uOTE1NWQ0NSAxMDA2NDQNCj4gLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KPiBAQCAtOSw2ICs5LDcgQEANCj4g
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5oPiAgI2luY2x1ZGUNCj4g
PGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BpbmN0cmwv
cGFkcy1pbXg4cXhwLmg+DQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvdGhlcm1hbC90aGVybWFs
Lmg+DQo+IA0KPiAgI2luY2x1ZGUgImlteDgtY2EzNS5kdHNpIg0KPiANCj4gQEAgLTg1LDYgKzg2
LDMyIEBADQo+ICAJCX07DQo+ICAJfTsNCj4gDQo+ICsJdHNlbnM6IHRoZXJtYWwtc2Vuc29yIHsN
Cj4gKwkJY29tcGF0aWJsZSA9ICJueHAsaW14OHF4cC1zYy10aGVybWFsIjsNCj4gKwkJdHNlbnMt
bnVtID0gPDE+Ow0KPiArCQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MT47DQo+ICsJfTsNCj4g
Kw0KPiArCXRoZXJtYWxfem9uZXM6IHRoZXJtYWwtem9uZXMgew0KPiArCQljcHUtdGhlcm1hbDAg
ew0KPiArCQkJcG9sbGluZy1kZWxheS1wYXNzaXZlID0gPDI1MD47DQo+ICsJCQlwb2xsaW5nLWRl
bGF5ID0gPDIwMDA+Ow0KPiArCQkJdGhlcm1hbC1zZW5zb3JzID0gPCZ0c2VucyAzNTU+Ow0KPiAr
CQkJdHJpcHMgew0KPiArCQkJCWNwdV9hbGVydDA6IHRyaXAwIHsNCj4gKwkJCQkJdGVtcGVyYXR1
cmUgPSA8MTA3MDAwPjsNCj4gKwkJCQkJaHlzdGVyZXNpcyA9IDwyMDAwPjsNCj4gKwkJCQkJdHlw
ZSA9ICJwYXNzaXZlIjsNCj4gKwkJCQl9Ow0KPiArCQkJCWNwdV9jcml0MDogdHJpcDEgew0KPiAr
CQkJCQl0ZW1wZXJhdHVyZSA9IDwxMjcwMDA+Ow0KPiArCQkJCQloeXN0ZXJlc2lzID0gPDIwMDA+
Ow0KPiArCQkJCQl0eXBlID0gImNyaXRpY2FsIjsNCj4gKwkJCQl9Ow0KPiArCQkJfTsNCj4gKwkJ
fTsNCj4gKwl9Ow0KPiArDQo+ICAJYWRtYV9zdWJzeXM6IGJ1c0A1OTAwMDAwMCB7DQo+ICAJCWNv
bXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ICAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAt
LQ0KPiAyLjcuNA0KDQo=
