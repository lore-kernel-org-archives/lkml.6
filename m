Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE441C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D63820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UTO6oC9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfAVK4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:56:47 -0500
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:4282
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727199AbfAVK4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJdj1CZnxVI6V6ybj/ebBb0hDieEi/X6R1ZG0CjgzWs=;
 b=UTO6oC9IpTEtjaSasoVhBhwtWCNdNyG1Uel8kgRhkvM24YdEf2zH+6OWOEr/GOj6H0FYl1SD5cnW2h8QwO6QGtwMgMS8nSoxQ4yC9YgWremmLAgXQ0/iVlzs9Exzi8LqVvfOAhisTYYmxjJ4BKnicVCOjmbcFYkjFPUp8jQxGcg=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5170.eurprd04.prod.outlook.com (20.177.42.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Tue, 22 Jan 2019 10:56:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 10:56:42 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Topic: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
Thread-Index: AQHUrwLwJbVcVt8a/UCLFkmrL3vOD6W0tw+AgAAOR4CAAAGp8IAAB5UAgAZQ5oA=
Date:   Tue, 22 Jan 2019 10:56:42 +0000
Message-ID: <AM0PR04MB421189505D3F196A82DEF19A80980@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
 <1547801291.2626.3.camel@pengutronix.de>
 <45c7e5b6-26bb-81b1-093b-96312a1788ec@arm.com>
 <AM0PR04MB42114D5B25B23C0D7FFF95BA809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <ef6eb38d-8e74-a55d-6d78-516d81fa957f@arm.com>
In-Reply-To: <ef6eb38d-8e74-a55d-6d78-516d81fa957f@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5170;6:70FUtE9SvAKrGQPtsouBxKKofx4j/BCSvSUikxJXaRbMrWGKabG6Bm/G3tWwWSvKbVOAvT9kbYyF5oe1jwgMI5lObY8F05iN6+ZF/cs6N5L9KaSOijJyLoIksM4YsgPIc6r0YZl+i/xRBQQrxfueSO/70qnQXOh5mvZxy88TTZ7ayrC9T7y8QUaFRvoseVnYZpjEqvrMoZS6059WlOsGi4Y/+7ixPOYBFqkGCvWAEh+lGKMwBs+SqIHWg12kBD0gAJGh86AjXXendix8XG4RmPJfiFc7cAPRe77gAQbzt5K6mhic98totoFBQUEHBX1qTZMmRcabzA9QPiRKtbehR/n0nGSeigRaHEC4/CVOCJFLX0C8vUOUtnTdax4Fvx72iZzBAEdy2Hc/MqwzJDiI4nieamhUtifVA5FKvE6Wwl6ns905H9txrjbx8cQAa+HD6hW58x4zSQfGBuEpX69WMA==;5:/z3Cbk+N5gz7RkwYyvncdkbEOn435zurl8r1DpC8uyX0T1VDfoaBfUvTMPiWtBVcapXAsuCLcUrnLIcdf0lx0lHCrYCFHn9lnab1pbGm4CGi4gTdLPckro4qRGGRsIx/awIKgjMuMMYVvPlZUGY25xG971/eJgmTgu0DiOKn3yC3JIKPViPtp6+sCxVat1rmgAc8vX3RKGsnMOeHsWpi0g==;7:Cm4gHFHjTlpSLNNAHO2eoBE5LIMWOaGZJoFNXTlCktqvSF1qJTjG5zvDqbd2hdvMRBR1qy6B5lpS4h2AzOVQBPcyV56cwrqhH02xGyCMntDJdRnwPS1LGZO0uBpx0PlnDJDNIik52cn1UETCgOx1tA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cb16006d-1c06-4141-52e0-08d680584b0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5170;
x-ms-traffictypediagnostic: AM0PR04MB5170:
x-microsoft-antispam-prvs: <AM0PR04MB517005581E6B319A02A033ED80980@AM0PR04MB5170.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(74316002)(93886005)(14454004)(97736004)(76176011)(66066001)(305945005)(53936002)(102836004)(6506007)(9686003)(44832011)(2906002)(7696005)(86362001)(53546011)(256004)(14444005)(6246003)(7736002)(2501003)(186003)(25786009)(99286004)(106356001)(71190400001)(26005)(6116002)(105586002)(71200400001)(3846002)(6346003)(33656002)(4326008)(110136005)(486006)(55016002)(8936002)(11346002)(446003)(476003)(54906003)(6436002)(8676002)(478600001)(81156014)(316002)(81166006)(229853002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5170;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GaBpy4hoB1VDEpwn1p43XhDYLDy8JeGW6teXCfgRhBNP3q2ktTjwxDAxg9mEuBZ/GtRezt1mt6e3lP/2Ce9WGDuQGqVo84jX9FhT1wu0g3FucNchRAUa1UpWT1wTu4P5yN9M1/KobUUPbi9nVPwARuXFqnyot3HUpqTK4Z7OrpLGJFDHIvE565sCpUSijySKj6ytScawmJFewGjXdnFO9xMz8uNtuVXW9WTjPU2Jg8T/ihZ1jXu9JfT0Zd/6h5Y1bmec5hMPUeXNif4xMnDF16kW/epGsOFJhKjXMv2RAYbmqmo+bfQ4LwGTwrOkecxISGB2xCU1Omd5Y1MuPUKdtpLVn0k7rjtnpZ2zN/XOMCTOxDv+IxPvrTbEVBbHeLfP99GWkyAmbDy3ed4F8SJo7Wh6sW7hUwAdeRQagdqHxKo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb16006d-1c06-4141-52e0-08d680584b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 10:56:42.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNYXJjIFp5bmdpZXIgW21haWx0bzptYXJjLnp5bmdpZXJAYXJtLmNvbV0NCj4gU2Vu
dDogRnJpZGF5LCBKYW51YXJ5IDE4LCAyMDE5IDY6MTIgUE0NClsuLi5dDQo+ID4+IEZyb206IE1h
cmMgWnluZ2llciBbbWFpbHRvOm1hcmMuenluZ2llckBhcm0uY29tXQ0KPiA+PiBTZW50OiBGcmlk
YXksIEphbnVhcnkgMTgsIDIwMTkgNTozOSBQTSBPbiAxOC8wMS8yMDE5IDA4OjQ4LCBMdWNhcw0K
PiA+PiBTdGFjaCB3cm90ZToNCj4gPj4+IEFtIEZyZWl0YWcsIGRlbiAxOC4wMS4yMDE5LCAwNzo1
MyArMDAwMCBzY2hyaWViIEFpc2hlbmcgRG9uZzoNCj4gPj4+PiBOb3QgYWxsIDY0IGludGVycnVw
dHMgbWF5IGJlIHVzZWQgaW4gb25lIGdyb3VwLiBlLmcuIG1vc3QgaXJxc3RlZXINCj4gPj4+PiBp
biBpbXg4cXhwIGFuZCBpbXg4cW0gc3Vic3lzdGVtcyBzdXBwb3J0cyBvbmx5IDMyIGludGVycnVw
dHMuDQo+ID4+Pj4NCj4gPj4+PiBBcyB0aGUgSVAgaW50ZWdyYXRpb24gcGFyYW1ldGVycyBhcmUg
Q2hhbm5lbCBudW1iZXIgYW5kIGludGVycnVwdHMNCj4gPj4+PiBudW1iZXIsIGxldCdzIHVzZSBm
c2wsaXJxcy1wZXItY2hhbiB0byByZXByZXNlbnRzIGhvdyBtYW55DQo+ID4+Pj4gaW50ZXJydXB0
cyBzdXBwb3J0ZWQgYnkgdGhpcyBpcnFzdGVlciBjaGFubmVsLg0KPiA+Pj4NCj4gPj4+IFNvcnJ5
LCBidXQgdG90YWwgTkFDSy4gSSd2ZSBnb3QgdG8gZ3JlYXQgbGVuZ3RocyB3aXRoIGR1bXBpbmcg
dGhlDQo+ID4+PiBhY3R1YWxseSBpbXBsZW1lbnRlZCByZWdpc3RlciBsYXlvdXQgb24gaS5NWDhN
IGFuZCBBRkFJQ1MgdGhlIElSUXMNCj4gPj4+IGFyZSBhbHdheXMgbWFuYWdlZCBpbiBncm91cHMg
b2YgNjQgSVJRcywgZXZlbiBpZiBsZXNzIHRoYW4gdGhhdCBhcmUNCj4gPj4+IGNvbm5lY3RlZCBh
cyBpbnB1dCBJUlFzLiBUaGlzIGlzIHdoYXQgdGhlIGFjdHVhbGx5IHByZXNlbnQgcmVnaXN0ZXIN
Cj4gPj4+IHNldCBvbiBpLk1YOE0gdGVsbHMgdXMuDQo+ID4+DQo+ID4+IEFsc28sIEknZCByZWFs
bHkgbGlrZSB0aGUgRFQgYmluZGluZ3Mgbm90IHRvIGNoYW5nZSBhdCBldmVyeSByZWxlYXNlLg0K
PiA+PiBTbyB3aGF0ZXZlciBjaGFuZ2UgKGlmIGFueSkgaGFzIHRvIGJlIGRvbmUgZm9yIHRoaXMg
ZHJpdmVyIHRvIHN1cHBvcnQNCj4gPj4gZXhpc3RpbmcgSFcsIHBsZWFzZSBtYWtlIHN1cmUgdGhh
dCB0aGUgRFQgYmluZGluZ3MgYXJlIGtlcHQgYXMgc3RhYmxlIGFzDQo+IHBvc3NpYmxlLg0KPiA+
Pg0KPiA+DQo+ID4gU29ycnkgSSBzaG91bGQgY2xhcmlmeSBpdCBhIGJpdC4NCj4gPiBUaGVyZSdz
IHN0aWxsIG5vIHVzZXJzIGluIERldmljZXRyZWUuDQo+ID4gU28gSSBndWVzcyB3ZSBjYW4gdXBk
YXRlIGl0LCByaWdodD8gT3Igbm90Pw0KPiANCj4gV2hhdCBkbyB5b3UgbWVhbiBieSBubyB1c2Vy
cz8gVGhpcyBkcml2ZXIgaXMgaW4gNS4wLCBhbmQgSSBhc3N1bWUgcGVvcGxlIGFyZQ0KPiB1c2lu
ZyBpdCBvbmUgd2F5IG9yIGFub3RoZXIuIE5vdCBoYXZpbmcgYSBwbGF0Zm9ybSBpbiB0aGUga2Vy
bmVsIHRyZWUgaXMgcHJldHR5DQo+IG11Y2ggaXJyZWxldmFudCwgYXMgdGhlIGtlcm5lbCB0cmVl
IGlzIG5vdCBhIGNhbm9uaWNhbCByZXBvc2l0b3J5IG9mIGV4aXN0aW5nDQo+IHBsYXRmb3Jtcy4N
Cj4gDQoNCkkgdW5kZXJzdGFuZCB0aGUgY29uY2Vybi4NClRoZW9yZXRpY2FsbHkgeWVzLCBidXQg
aXQncyB2ZXJ5IHVubGlrZWx5IHRoYXQgdGhlcmUncyBhbHJlYWR5IGFuIG91dCBvZiB0cmVlIHVz
ZXJzDQp3YW50cyB0byB1c2UgaXQgZm9yIGEgbG9uZyB0ZXJtIGFzIHdlJ3JlIHN0aWxsIGF0IHRo
ZSB2ZXJ5IGluaXRpYWwgc3RhZ2UuDQoNCkFuZCB0aGUgbW9zdCBpbXBvcnRhbnQgcmVhc29uIGlz
IHRoYXQgY3VycmVudCB1c2luZyBhY3R1YWxseSBpcyB3cm9uZy4NCldlIGNhbiBhbHNvIGNob29z
ZSB0byBtYXJrIGl0IGFzICdkZXByZWNpYXRlZCcgYW5kIGtlZXAgdGhlIGJhY2t3YXJkIGNvbXBh
dGliaWxpdHkgaW4gZHJpdmVyLA0KYnV0IEknbSBub3Qgc3VyZSB3aGV0aGVyIGl0J3Mgd29ydGh5
IHRvIGRvIGl0IGFzIHdlIG1heSBhZGQgYSBsb3QgdWdseSBjb2RlIGluIGRyaXZlcg0KYmVuZWZp
dHMgbm8gdXNlcnMuDQoNCklkZWFzPw0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiBUaGFu
a3MsDQo+IA0KPiAJTS4NCj4gLS0NCj4gSmF6eiBpcyBub3QgZGVhZC4gSXQganVzdCBzbWVsbHMg
ZnVubnkuLi4NCg==
