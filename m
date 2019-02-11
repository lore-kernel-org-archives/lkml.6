Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C261C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391B5218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="eaF5QIll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfBKWWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:22:15 -0500
Received: from mail-eopbgr690125.outbound.protection.outlook.com ([40.107.69.125]:51919
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfBKWWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ncr1vqWIcCFfDQ+JoQdZCBEJBWvJ2tL5QxoNNaIT9M=;
 b=eaF5QIlll+QcTblTBe6dEFNFla6x2AoRZW0ySDIbapbWRNMtW/W8YyHOXhrAusWKVNR1/sgLayrRMyPoeOx91Vm7WaAHanojL3Ff4nB5lecPJAteXzYdiuwqCl7e8zjfFxnl7CYJdip122KGR5dih+mC2yHMVShrbIJ5Krezwkw=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3659.namprd06.prod.outlook.com (10.167.236.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 22:22:08 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 22:22:08 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Topic: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Thread-Index: AQHUvyD/DkP33gVxsUSHwHJ5QzA1bqXU0h6AgAUATgCAATwLAIAAFl6AgAANW4A=
Date:   Mon, 11 Feb 2019 22:22:07 +0000
Message-ID: <1549923727.3075.103.camel@impinj.com>
References: <20190107132226.16216-1-stefan@agner.ch>
         <20190107132226.16216-2-stefan@agner.ch>
         <1549573243.3075.72.camel@impinj.com> <20190211012305.GA21496@dragon>
         <1549916056.3075.102.camel@impinj.com>
         <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
In-Reply-To: <CAOMZO5BrTLyg7Q51tPcHbN8S2VmA4HAENOVzNhw+Yx7Nniz3Gg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25321201-83ba-45a4-2078-08d6906f5c24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3659;
x-ms-traffictypediagnostic: MWHPR0601MB3659:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3659;20:LPzvUFD2xloKfKA4RV8f54A7mRX4jQpcJ0oBvxgv4R8isrzmnT324Un7lbPUkmd75wKLwu4TMPAU8l5Ab1BYZAiTyKS7IvOfcwA7bTm+5zmzMg6IciW5zfyyWB9uqCmHelUcgbpPdVFYm7AgMylVDjdNsG78+p+Kj+HNXvVoDQ0=
x-microsoft-antispam-prvs: <MWHPR0601MB365907C6B2CEAE4B9992A4E9D3640@MWHPR0601MB3659.namprd06.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39840400004)(199004)(189003)(316002)(102836004)(6246003)(66066001)(6486002)(229853002)(25786009)(7416002)(86362001)(53936002)(6116002)(2351001)(26005)(6506007)(97736004)(7736002)(53546011)(5640700003)(3846002)(305945005)(103116003)(106356001)(1411001)(6436002)(6512007)(105586002)(4326008)(11346002)(446003)(14454004)(8676002)(2501003)(2906002)(2616005)(476003)(99286004)(6916009)(256004)(1730700003)(71200400001)(36756003)(54906003)(1361003)(68736007)(81156014)(8936002)(478600001)(76176011)(486006)(186003)(93886005)(81166006)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3659;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J8VNIZmvl1zEzz2jsqKMZaZHatTXKO98JKlZzms6s4iM2z9SKg4Trq3jnJpYT/1i4umI2h5m7IWw3zHmSUE6jzSvC+oTnHz+EFsVFQZ7EgSctcX1qY2iZIjz4Ay0mRvWBKeHGGYyz8rNustUt2FnfpZWqRvRve9KEm22UEUwOBi6omKCw1J8LOKsCh2IFKh91LeI044aWDLIPH6ojPiQa9rwm3tLT5+7YHM4WHWRWpdCqYrymsnwuaNWfQMiuO04Org9bwIBPVZeaZEwK0GH9JlaG0Z4TqhTltOr1cLLhSjsS5O+QRLpMjLdqC1VspOtXR+IjbLXRzXEAc3/pSpKWZhzxvglfjqzMyocWL7lvuWvzIFRoTarTcHMZWdag5G24nf0rglOFLn2GfSGxsgMLqDYwW/qwVpXL4sJMb21Z5g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C92860F19D57624E88286F1F866A4B77@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25321201-83ba-45a4-2078-08d6906f5c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 22:22:07.9613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTExIGF0IDE5OjM0IC0wMjAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBUcmVudCwNCj4gDQo+IE9uIE1vbiwgRmViIDExLCAyMDE5IGF0IDY6NDQgUE0gVHJlbnQg
UGllcGhvIDx0cGllcGhvQGltcGluai5jb20+IHdyb3RlOg0KPiANCj4gPiBJJ3ZlIGhhZCBtb3Jl
IHRpbWUgdG8gdGVzdC4NCj4gPiANCj4gPiBXaXRob3V0IERNQSwgSSBjYW4gcmVsb2FkIG15IEZQ
R0EgaHVuZHJlZHMgb2YgdGltZXMgYW5kIGdldCBkYXlzIG9mDQo+ID4gdXB0aW1lIHVzaW5nIGxp
bnV4LW5leHQuDQo+ID4gDQo+ID4gV2l0aCBETUEsIGxvYWRpbmcgaXMgdW5yZWxpYWJsZS4gIFRo
ZSBoaWdoZXIgdGhlIFNQSSBzcGVlZCwgdGhlIGxlc3MNCj4gPiByZWxpYWJsZSBpdCBpcy4gIFVu
Zm9ydHVuYXRlbHksIGl0J3MgaGFyZCB0byBkdXBsaWNhdGUgdGhlIHByb2JsZW0gd2l0aA0KPiA+
IGEgc21hbGwgYW1vdW50IG9mIGRhdGEsIGFuZCB3aXRoIGEgbGFyZ2UgYW1vdW50IG9mIGRhdGEg
SSBjYW4ndCBleGFtaW5lDQo+ID4gaXQgaW4gZGVwdGggZW5vdWdoIHRvIGRldGVybWluZSBpZiB0
aGUgcHJvYmxlbSBpcyByZWxhdGVkIHRvIFNQSSBidXMNCj4gPiB0aW1pbmcgb3IgSU1YIHNETUEg
c2VuZGluZyB0aGUgd3JvbmcgYnl0ZXMgdG8gdGhlIHNwaSBjb250cm9sbGVyLg0KPiA+IA0KPiA+
IFVzaW5nIERNQSB3aXRoIFNQSSBjYXVzZXMga2VybmVsIHBhbmljcy4gIE5vdCBhbHdheXMgaW1t
ZWRpYXRlbHksIGJ1dA0KPiA+IGFmdGVyIHVzaW5nIERNQSBpdCdzIGEgc21hbGxlciBvZiBtaW51
dGVzIGJlZm9yZSBzb21ldGhpbmcgY3Jhc2hlcy4NCj4gPiBUaGUgYmFja3RyYWNlcyBhcmUgYWxs
IG92ZXIgdGhlIHBsYWNlIGFuZCBkb24ndCB1c3VhbGx5IHBvaW50IGJhY2sgaW50bw0KPiA+IFNQ
SS4gIEl0IGRvZXMgc2VlbSBsaWtlIHRoZXkgdXN1YWxseSBoaXQgc29tZXRoaW5nIGhhcyBhbGxv
Y2F0ZWQgb3IgaXMNCj4gPiBhbGxvY2F0aW5nIERNQSBtZW1vcnkuDQo+IA0KPiBEaWQgeW91IHRl
c3Qgd2l0aCBhbiBleHRlcm5hbCBTRE1BIGZpcm13YXJlIG9yIHdpdGggdGhlIFJPTSBTRE1BIGZp
cm13YXJlPw0KPiANCj4gSnVzdCB0cnlpbmcgdG8gdW5kZXJzdGFuZCBpZiB0aGUgU0RNQSBmaXJt
d2FyZSBwbGF5cyBhIHJvbGUgb24gdGhpcw0KPiBiZWhhdmlvciBvciBub3QuDQoNClRoZSBST00g
ZmlybXdhcmUgb25seS4=
