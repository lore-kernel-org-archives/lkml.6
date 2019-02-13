Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2640DC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A182075D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qDJvN5kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfBMNxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:53:12 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:53152
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727452AbfBMNxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59V7AEZrq509O809mYwAsMWvNF5jyBYkQR7kI9p9H6Q=;
 b=qDJvN5kfrACiq1N1oWJ0JD47X6BOqLgDbxO9wmmtaLLemilbP+AbG6A0mvgtcOf77Qs5gEn5ETAvyN/RC6XlSfAVhyaKhrSQ1k2DrZLaKJFlU8jAc8R7hesGLzvOoa6kMQwULjcwtmUSuFKql2R4iNotVWABk7YCxb67q/oStLc=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB1584.eurprd04.prod.outlook.com (10.164.84.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 13:53:04 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::fc57:e5ed:7fb2:2c67%5]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 13:53:04 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V2 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUw6CRSTAGnhFbAkysZVsEDWdrJKXdv4gA
Date:   Wed, 13 Feb 2019 13:53:04 +0000
Message-ID: <59b181b77605f516b0e3a896ddce0224b4504b30.camel@nxp.com>
References: <1550064410-28417-1-git-send-email-Anson.Huang@nxp.com>
         <1550064410-28417-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550064410-28417-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-clientproxiedby: AM5PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:206:2::35) To VI1PR04MB5533.eurprd04.prod.outlook.com
 (2603:10a6:803:d2::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c80df25-2c93-4b28-2714-08d691ba9354
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1584;
x-ms-traffictypediagnostic: VI1PR04MB1584:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIxNTg0OzIzOnFraUdxcy9tcFR1NGZpTkNTcDlxT3I4bVlq?=
 =?utf-8?B?QzNoNGY2T3dMNDhlVnliSWhsS3djWG90ODJtTXd4d0hzeTZOd2lhM2VlN2p4?=
 =?utf-8?B?ZEdGYkNCTXJmdkxWS0Z4WFdRNU1KOVMrajdJRTllb0U3U3NVaFZvL0RTT2tN?=
 =?utf-8?B?cmMzd2wwSWFtbTRIcXFrY3plc3lBK3dwMUlnemQ5QmkvdnJMRXF5Qmpad0xL?=
 =?utf-8?B?TVBXaFVEb1c5aTVuTENmOVZva2FRYmhmTm1sbWdvNk9Jc2VGeE1xaVloZEQy?=
 =?utf-8?B?QWppUnBDaUxBc0hiOHVtR1M4c0ZYV3ZsZ0g4Q1dLZmJGakNtQ2pOdHNlWFpL?=
 =?utf-8?B?c3NNTWIwQW5scGdtdjlXclZNRW5ubWJHTzdFd09Ra2pYeCtXeG9nR1VSWU9t?=
 =?utf-8?B?cDhiM1VycjBRSGxIU2tYUXU4RU5lZ1YyY25Ic1prQjF3b01pbk0rb1V5Qk45?=
 =?utf-8?B?N3RleVpJb0t3NkRWTHVyT2djcW1RUGRiUEFybVpjN2ZWbDlTV1V4b1RLY1pn?=
 =?utf-8?B?OGxIcjhaamNLZWoyalBxNGdub0x2QWNmTWRJRlNhOWhJSWJkeVVXTEJ5VUV1?=
 =?utf-8?B?anZvWUJWdGJCaDVMV3FWU3REZldhd2RVY09jeWxrZTdrdDhuNnJ1ZVFTWkJH?=
 =?utf-8?B?eWZkd3kzZmVpY2NLTUJQL0dWUWJqcndBekJiYjJFTE5VaDJIRW9sZEFVK2I1?=
 =?utf-8?B?cy9aT3gvbVgyUUdvWUEwOVIzVUZ5cHpaNThiL2ZqR3RpaWJHNGkxSWVlRFN6?=
 =?utf-8?B?QU05ZjJtQ0FlZzJBM2N6TUQrM0pSaWt4cXZGYlpoTnNycWUyeWp5dlpOYUhv?=
 =?utf-8?B?L2U5bmlBWGZBS1ZTYi90aUNLVEg3ZGs4SE05TFVoS3FQM05tZ0RoL24xMG9r?=
 =?utf-8?B?VUNkYytFdjdpSzVTZGFlYW9KM3pISzdSZDRpMTVETFEvcnZtZXcxZlNoL0RF?=
 =?utf-8?B?TlN3aDMzVVdERHNLd2h5S1hLelJaSWRjNVhSNmNmcDJ4SDMzVzFxcXpMRUZs?=
 =?utf-8?B?RDFzZG1DKzFlOEZyb3pTSy9iR2VmblpYdVQyMFcvVmtTckM3dFhjOHM0R0hS?=
 =?utf-8?B?VDJldkNxbithN1lSeTNZNEZaQ1I3bHlyNER5YXo4cGJpdGdEUFVqMTJCRk04?=
 =?utf-8?B?UWRQajN5b1BaeWRFbndUbU1VWkU3M3Vla3k4cDJvYVZ2Ykk4WC9KSnExV2RT?=
 =?utf-8?B?ZW5zbzZGVU1kMVBIL1JrMFI0SG9sZ3pxQkVpRTMvRTNjRVRZb25MSDdJcldL?=
 =?utf-8?B?cTN3WGtPVEN5MG5OVXA5VVQ3WTRlYzk3YThaM3BhZnNiYnhoVHNGNTg5dmJF?=
 =?utf-8?B?NzRXZlppT08wSDZ1ZEE0OU1xZnVhTzlQeWFEM1FldXllbFZLVFUxWlNNeFNB?=
 =?utf-8?B?bHJGdTVMeWtyTFRJMThQK0p4V2JKdWVZTmlWbHJ4ZjJBMysrTkpOSCtOYStz?=
 =?utf-8?B?RmwxYXJHVDJ4R015V2toNlN3NVgzVGFsN3o1Y25CS0tlSEVOK2V0WUtBSjRw?=
 =?utf-8?B?MnRBS0JSck1qMXdxZld5M2J4OSs0SWFwdW9QRGkwbEIrazNuVW56bmxHY0NN?=
 =?utf-8?B?d1F3Y2xKU2VoUXdvdFZqRzcxdk1PMGRXRnlMK3VYTUc3b3F4RDE0OXlHbWdF?=
 =?utf-8?B?L09xT0VsenhyNEdadTVUNzRYSERmZ3JaK2ZpS2I1T1NpYWVRaEg5aUE3eEw3?=
 =?utf-8?B?bGZlUjkvUVQrczZXbE50bm1DazdWRUxuYzdOSmhwNUFxUmpkZ2VNYzFZcnJl?=
 =?utf-8?B?VnE4QnAzVHg1dmRJdVNIcGlEbWdLRC96Z3VvSEhNWG5DVVg2dXB3T0p6NnM5?=
 =?utf-8?Q?OdArObFQs4L6i?=
x-microsoft-antispam-prvs: <VI1PR04MB1584C9D510B13DD5DBD24288EE660@VI1PR04MB1584.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(53936002)(316002)(36756003)(54906003)(86362001)(105586002)(6512007)(37006003)(99286004)(52116002)(2906002)(8676002)(81156014)(6246003)(71190400001)(11346002)(229853002)(66066001)(6486002)(76176011)(6436002)(2616005)(8936002)(50226002)(81166006)(186003)(71200400001)(446003)(68736007)(486006)(118296001)(6636002)(3846002)(14444005)(478600001)(6506007)(26005)(44832011)(97736004)(14454004)(25786009)(476003)(6116002)(7416002)(106356001)(305945005)(256004)(386003)(6862004)(4326008)(7736002)(102836004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1584;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MGsM+miX+MRT0cGGHZkLZq6o6OlyRiP3o4eQFiS3okvgTQBGx9qXCUtMGIxlWz6O5FSf9PFEKTWtntBClOVDtjk37gmxRDa39qIWB4spmpsfrS0YY5L7svL+LUgsvaE2tQrBoCIONKIs2FHu9TQ6j99g24SGb+KFr+QB0NhR9eTtjttEmflUN50f6COQpQi2cmaSS3uGPr+1EYlrlou6QZhqEdQbiuHSBpZeLqV7po7jkoOFvmze82y4zMoIt0HN9r8T5bxcpA1zNfYcWKRt8vNRkaQScKdaBFVKiI6plnk6bXrIe4I4Mr/j4zklmc2doV7KmJkkL3YkSkjB74O2lmBCF8bD1frd7S6pZOuyiliMo4cSn4roBwPPYXx6PeY7xrfjcUG2fx0WKolF3g8zgTUk93678bxdYFeY8UFjalw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFFAC317CCAA5545B90CE2DCE255FAB8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c80df25-2c93-4b28-2714-08d691ba9354
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 13:53:02.8155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1584
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTEzIGF0IDEzOjMyICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4g
T24gTlhQJ3MgaS5NWCBTb0NzIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgaW5zaWRlLCBDUFUgZnJl
cXVlbmN5DQo+IHNjYWxpbmcgY2FuIE9OTFkgYmUgZG9uZSBieSBzeXN0ZW0gY29udHJvbGxlciBm
aXJtd2FyZSwgYW5kIGl0DQo+IGNhbiBPTkxZIGJlIHJlcXVlc3RlZCBmcm9tIHNlY3VyZSBtb2Rl
LCBzbyBMaW51eCBrZXJuZWwgaGFzIHRvDQo+IGNhbGwgQVJNIFNNQyB0byB0cmFwIHRvIEFSTS1U
cnVzdGVkLUZpcm13YXJlIHRvIHJlcXVlc3Qgc3lzdGVtDQo+IGNvbnRyb2xsZXIgZmlybXdhcmUg
dG8gZG8gQ1BVIGZyZXF1ZW5jeSBzY2FsaW5nLg0KDQo+ICsjaWZkZWYgQ09ORklHX0NQVUZSRVFf
RFQNCj4gKyNkZWZpbmUgSU1YX1NJUF9DUFVGUkVRCQkJMHhDMjAwMDAwMQ0KPiArI2RlZmluZSBJ
TVhfU0lQX1NFVF9DUFVGUkVRCQkweDAwDQo+ICsNCj4gIHN0YXRpYyBzdHJ1Y3QgaW14X3NjX2lw
YyAqY2NtX2lwY19oYW5kbGU7DQoNCldpdGhvdXQgQ09ORklHX0NQVUZSRVFfRFQgdGhlIGNjbV9p
cGNfaGFuZGxlIHdvbid0IGJlIGRlZmluZWQgYW5kIGJ1aWxkDQp3aWxsIGJyZWFrLg0KDQpCdXQg
aXMgdGhlcmUgYSBnb29kIHJlYXNvbiBmb3IgaWZkZWY/IEluIGdlbmVyYWwgY2xvY2sgZnVuY3Rp
b24gYXJlDQpjb21waWxlZCBldmVuIGlmIG5vIGRyaXZlciBpcyBjYWxsaW5nIHRoZW0uDQoNCj4g
KyNpZmRlZiBDT05GSUdfQ1BVRlJFUV9EVA0KPiArCS8qIENQVSBjbG9jayBjYW4gT05MWSBiZSBk
b25lIGJ5IFRGLUEgKi8NCj4gKwlpZiAoY2xrLT5jbGtfdHlwZSA9PSBJTVhfU0NfUE1fQ0xLX0NQ
VSkgew0KPiArCQlzdHJ1Y3QgYXJtX3NtY2NjX3JlcyByZXM7DQo+ICsJCXVuc2lnbmVkIGludCBj
bHVzdGVyX2lkOw0KPiArCQlpbnQgaTsNCj4gKw0KPiArCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlf
U0laRShpbXhfc2NfY3B1ZnJlcV9kYXRhKTsgaSsrKSB7DQo+ICsJCQlpZiAoIXN0cmNtcChjbGtf
aHdfZ2V0X25hbWUoaHcpLA0KPiArCQkJCWlteF9zY19jcHVmcmVxX2RhdGFbaV0uY2xrX25hbWUp
KSB7DQo+ICsJCQkJY2x1c3Rlcl9pZCA9IGlteF9zY19jcHVmcmVxX2RhdGFbaV0uY2x1c3Rlcl9p
ZDsNCj4gKwkJCQlicmVhazsNCj4gKwkJCX0NCj4gKwkJfQ0KPiArDQo+ICsJCS8qDQo+ICsJCSAq
IEFzIHNvbWUgb3RoZXIgY2xvY2sgdHlwZXMgaGF2ZSBzYW1lIHZhbHVlIGFzDQo+ICsJCSAqIElN
WF9TQ19QTV9DTEtfQ1BVLCBzbyB3ZSBuZWVkIHRvIGRvdWJsZSBjaGVjaw0KPiArCQkgKiB0aGUg
Y2xvY2sgYmVpbmcgc2NhbGVkIGlzIGluZGVlZCBDUFUgY2xvY2sgd2hpY2gNCj4gKwkJICogbWF0
Y2hlcyB0aGUgdGFibGUgd2UgZGVmaW5lLg0KPiArCQkgKi8NCj4gKwkJaWYgKGkgPCBBUlJBWV9T
SVpFKGlteF9zY19jcHVmcmVxX2RhdGEpKSB7DQo+ICsJCQlhcm1fc21jY2Nfc21jKElNWF9TSVBf
Q1BVRlJFUSwgSU1YX1NJUF9TRVRfQ1BVRlJFUSwNCj4gKwkJCQljbHVzdGVyX2lkLCByYXRlLCAw
LCAwLCAwLCAwLCAmcmVzKTsNCj4gKwkJCXJldHVybiAwOw0KPiArCQl9DQo+ICsJfQ0KPiArI2Vu
ZGlmDQoNClRoZSBjb2RlIGluc2lkZSB0aGUgaWZkZWYgd291bGQgbG9vayBiZXR0ZXIgaW4gYSBz
ZXBhcmF0ZQ0KaW14X2Nsa19hdGZfc2V0X3JhdGUgZnVuY3Rpb24uIE1heWJlIGV2ZW4gc2VwYXJh
dGUgY2xrX29wcz8NCg0K
