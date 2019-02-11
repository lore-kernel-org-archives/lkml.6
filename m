Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23DB217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="pjQpaM7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfBKUOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:14:21 -0500
Received: from mail-eopbgr710121.outbound.protection.outlook.com ([40.107.71.121]:24160
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfBKUOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAEEoVkWHdQgY1VQuIsvnL88i3Nn/XcgMpUgUU8uMqE=;
 b=pjQpaM7sCB6GhG8byMTg57Ek4ZZN5vIbn3HB2L4YgazzJKQHUo8YfcTCATPUD+gPk3xJxfTeQ+6/9/oa9MwN2HvKii2OC1dKsq9XvOxts7zcXx77TstrWC468MoYQKnqAKfjrqiEXm1sQ7ryYrzLcAyyKBu/fjrhIKOmaiasRKM=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3771.namprd06.prod.outlook.com (10.167.236.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 20:14:17 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 20:14:17 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6AgAUATgCAATwLAA==
Date:   Mon, 11 Feb 2019 20:14:16 +0000
Message-ID: <1549916056.3075.102.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
         <20190107132226.16216-2-stefan@agner.ch>
         <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
In-Reply-To: <20190211012305.GA21496@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 235fccf4-02a4-4a0c-f4ca-08d6905d7fed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3771;
x-ms-traffictypediagnostic: MWHPR0601MB3771:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3771;20:HeoXgP7yPyS4GOoOaDPtZLulNiq/NIr8wPrt1FyE1pmrYd4oFuxSqFpcgi0CzeAVdt53jeqtKh2gLpV4mlRbehwJxvnAqxVmQgW8VEwsbhv3fhFEwYr/5DKrxHTGbsgsSSQ7BfsKydMr8V1Abab+wR0aUn8uclYjQ1RnqWeGRrg=
x-microsoft-antispam-prvs: <MWHPR0601MB3771D144FDAEB46D47295D92D3640@MWHPR0601MB3771.namprd06.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39850400004)(346002)(376002)(189003)(199004)(316002)(6246003)(102836004)(53936002)(66066001)(6486002)(229853002)(86362001)(7416002)(6116002)(2351001)(25786009)(26005)(6506007)(97736004)(7736002)(5640700003)(305945005)(3846002)(103116003)(106356001)(105586002)(6436002)(6512007)(4326008)(11346002)(446003)(2501003)(14454004)(8676002)(2906002)(2616005)(476003)(99286004)(6916009)(256004)(1730700003)(71200400001)(81156014)(36756003)(54906003)(68736007)(486006)(8936002)(478600001)(76176011)(186003)(93886005)(81166006)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3771;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MQnxeZU/m+YrtG81ZoffGKfGXEJ7pXRtyB4sdcaM+lDDYHiXRY1M4/vRkHVOqSecYBo/WMv1yXGh/0/cZhyblbeRkL/gCqdPJo5vxpo8gEszJUI9JxsEHUBi2dsawesvTOXyPsMdtnDGKRDOjWd0qTeOXLmnX3cUeAxd6vxxwXSfIBU5h5/recEIv2YY/QhyvvHU1XCH0jG6Syl0tdVEVOyYEkuVpieAbFqe88kcfffU33PlkECTTLTMTxG1O4o+X7woVnqll0uEAt16iAYbfTj05ycjDK4nO/HnNt7G/q5rzdlD+9SEOsdVkiQFMp2lZmSoh4bCKLkWa3TLv4Sck9n/1IzFTSSiHNKPGbXUcDDmQBGbv8jbZkcC9PRZukc5FP/nhrRBPZ0udi4gQgNR0c49Tgp30bD6szkaeswDP0M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8C20BCD9316084191ED9ADADA43B63E@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235fccf4-02a4-4a0c-f4ca-08d6905d7fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 20:14:17.0422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTExIGF0IDA5OjIzICswODAwLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9u
IFRodSwgRmViIDA3LCAyMDE5IGF0IDA5OjAwOjQ0UE0gKzAwMDAsIFRyZW50IFBpZXBobyB3cm90
ZToNCj4gPiBPbiBNb24sIDIwMTktMDEtMDcgYXQgMTQ6MjIgKzAxMDAsIFN0ZWZhbiBBZ25lciB3
cm90ZToNCj4gPiA+IEFsbG93IHRvIHVzZSBETUEgZm9yIFNQSSBieSBhZGRpbmcgdGhlIGFwcHJv
cHJpYXRlIERNQSBwcm9wZXJpdGVzDQo+ID4gPiB0byB0aGUgZWNzcGkgbm9kZXMuDQo+ID4gPiAN
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBBZ25lciA8c3RlZmFuQGFnbmVyLmNoPg0KPiA+
ID4gDQo+ID4gVGhlcmUncyBhbiBpbnRlcmVzdGluZyB0aGluZyB0aGF0IGhhcHBlbnMgd2hlbiBE
TUEgaXMgdXNlZC4gIFRoZSBTUEkNCj4gPiBjbG9jayBjaGFuZ2VzLiAgSW5zdGVhZCBvZiBjeWNs
aW5nIGNvbnRpbnVvdXNseSBmb3IgdGhlIGVudGlyZQ0KPiA+IHRyYW5zZmVyLCBpdCBpbnN0ZWFk
IGNsb2NrcyBvdXQgOCBiaXRzLCB0aGVuIHBhdXNlcyBmb3IgNCBiaXQgdGltZXMsDQo+ID4gdGhl
biB0aGUgbmV4dCBieXRlLCBldGMuICBTbyBpdCdzIGEgbmV0IG9mIGFib3V0IDUwJSBzbG93ZXIu
ICBUaGUgcGF1c2UNCj4gPiBiZXR3ZWVuIGJ5dGVzIHNjYWxlcyB3aXRoIHNwaSBmcmVxdWVuY3kg
dG8gYWx3YXlzIGJlIGFib3V0IDQgYml0cy4NCj4gPiANCj4gPiBJIHRoaW5rIERNQSBvbiBpbXgg
bm90IGJlIHJlYWR5IGZvciBwcmltZSB0aW1lIHlldC4NCj4gDQo+IEkgZHJvcHBlZCBib3RoIHBh
dGNoZXMgZnJvbSBteSB0cmVlLg0KPiANCg0KSSd2ZSBoYWQgbW9yZSB0aW1lIHRvIHRlc3QuDQoN
CldpdGhvdXQgRE1BLCBJIGNhbiByZWxvYWQgbXkgRlBHQSBodW5kcmVkcyBvZiB0aW1lcyBhbmQg
Z2V0IGRheXMgb2YNCnVwdGltZSB1c2luZyBsaW51eC1uZXh0Lg0KDQpXaXRoIERNQSwgbG9hZGlu
ZyBpcyB1bnJlbGlhYmxlLiAgVGhlIGhpZ2hlciB0aGUgU1BJIHNwZWVkLCB0aGUgbGVzcw0KcmVs
aWFibGUgaXQgaXMuICBVbmZvcnR1bmF0ZWx5LCBpdCdzIGhhcmQgdG8gZHVwbGljYXRlIHRoZSBw
cm9ibGVtIHdpdGgNCmEgc21hbGwgYW1vdW50IG9mIGRhdGEsIGFuZCB3aXRoIGEgbGFyZ2UgYW1v
dW50IG9mIGRhdGEgSSBjYW4ndCBleGFtaW5lDQppdCBpbiBkZXB0aCBlbm91Z2ggdG8gZGV0ZXJt
aW5lIGlmIHRoZSBwcm9ibGVtIGlzIHJlbGF0ZWQgdG8gU1BJIGJ1cw0KdGltaW5nIG9yIElNWCBz
RE1BIHNlbmRpbmcgdGhlIHdyb25nIGJ5dGVzIHRvIHRoZSBzcGkgY29udHJvbGxlci4NCg0KVXNp
bmcgRE1BIHdpdGggU1BJIGNhdXNlcyBrZXJuZWwgcGFuaWNzLiAgTm90IGFsd2F5cyBpbW1lZGlh
dGVseSwgYnV0DQphZnRlciB1c2luZyBETUEgaXQncyBhIHNtYWxsZXIgb2YgbWludXRlcyBiZWZv
cmUgc29tZXRoaW5nIGNyYXNoZXMuIA0KVGhlIGJhY2t0cmFjZXMgYXJlIGFsbCBvdmVyIHRoZSBw
bGFjZSBhbmQgZG9uJ3QgdXN1YWxseSBwb2ludCBiYWNrIGludG8NClNQSS4gIEl0IGRvZXMgc2Vl
bSBsaWtlIHRoZXkgdXN1YWxseSBoaXQgc29tZXRoaW5nIGhhcyBhbGxvY2F0ZWQgb3IgaXMNCmFs
bG9jYXRpbmcgRE1BIG1lbW9yeS4=
