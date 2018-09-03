Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2C7C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1CB2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lvafcNFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1CB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeICSMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:12:50 -0400
Received: from mail-ve1eur01on0066.outbound.protection.outlook.com ([104.47.1.66]:34896
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeICSMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsLBzLkfSowPRBKHTeIgxHHqD2emeN9jKVCCxobtxPo=;
 b=lvafcNFjp4ylUO+/EhaSzmyu3fEO9avyQPyp7ExASncUNZYvTWVcsNpOWXnx+paIcxi5zcb8zhLxg/wBmnVDA75a3+dxyG12buCWCcHoyaUPsR+0Sqy3/zrNf2ayebPHO/RXbHsroJLPBAteVCJ5gVhuhTdQgddHQP/ylfJXkBA=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5202.eurprd04.prod.outlook.com (20.177.42.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Mon, 3 Sep 2018 13:52:14 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03%2]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 13:52:14 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RESEND] PCI: imx: Initial imx7d pm support
Thread-Topic: [RESEND] PCI: imx: Initial imx7d pm support
Thread-Index: AQHUPfkkle8GAhjxL06ov1WHU/m7v6TU8gsAgAAwDYCAACAygIAJXFgA
Date:   Mon, 3 Sep 2018 13:52:13 +0000
Message-ID: <29a8f58b4efe3e3671eec1ee78b566d69034db61.camel@nxp.com>
References: <d577303de61fb060aa428898f5df1d0bc9be89b8.1535369231.git.leonard.crestez@nxp.com>
         <20180828100758.GA27217@e107981-ln.cambridge.arm.com>
         <efcb160f08bb53620ba0570e55dbb9190275aeb0.camel@nxp.com>
         <20180828145511.GA32352@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180828145511.GA32352@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5202;6:DtxvRx22Q2kZC0u944fy8rqYH0k1Gk6/pn4GoU9vDgd85wc4LXQawAhMbVjY8mWR6ipkkluTxJqFYaBdbWeNX1AxUQjnImiHdLFop3ko8cI8/qvNuSYNwmAE/db+TTGKmohCNdCqIFfvXHRb9cF5Yn9FDJlwIgmt5AWic/InW9Ug/Srdv2JprZh2UnHwK+/XZ176qxmxsSyB04r9TDcq6H1va/b2Uzn3Fw7wlaN6cw0HJTkP3te3V8yOaYO4PSSNm23VFXhqgE3BZ4JRn1PenxlEuR7kDsZMm6KRqLuHRbYISYuAm4LTMlOe2Xcz++vsLWC/kGYlrZYh6dfWdMsqFQbwTS45nzQyv4dq22LBh7g7lDYnrAe01/uI91M6BAffZ/nsitUcyG98WJMsccvMpOk1A8th0+7AHa2SuB6wq6+onn7ZRbc53K32NqZBeHOzOAjwQPOXJKgDGK/z1mHU7g==;5:1J5mGmC9fGSceaHH1grKCLNLdgMhTYM8v0a6j2cLiX4SDflR6z2gQYcpHMOtmUvzlfMA8zMeHhpm7YZ7ntNPu2vk5sNE3rYVz/MwxyE/s3mgrN9Lutm4YKoa5qsfu3TNM5ISr210kssjRRzIar00KWPG5gHnffS1wx0ByE6gHMA=;7:pUnkDsDw3eWxebuwsGTzuSEHXyoUZBo0BRAJMJ4AD6xDXvPDhFcHn5FT7UPEEH8p1DvVWsm7KJvMfdI+A2E/2gZ361HA9qgruhUM00e7bDVTBlZUfXJkh8kXHKes0gsNUz85AqLNH4gwEzXCnwEQu7h0CCfZMOfw3fLXPxFS3XkvFVyx7a1pwSzfnzkH0xMwAqb98jtPZ6JkJpWAGKn6p5UN+eTednknLcj978MU0W3S9q/lxqutPFXLmskQrbL+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fb5edf08-aa0e-4768-7af7-08d611a47426
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5202;
x-ms-traffictypediagnostic: AM0PR04MB5202:
x-microsoft-antispam-prvs: <AM0PR04MB5202FDD2AA09363CD0F9D992EE0C0@AM0PR04MB5202.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM0PR04MB5202;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5202;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(376002)(396003)(39860400002)(199004)(189003)(8676002)(7416002)(50226002)(11346002)(26005)(81166006)(81156014)(4326008)(25786009)(2900100001)(5250100002)(478600001)(2501003)(8936002)(68736007)(86362001)(5660300001)(102836004)(3846002)(186003)(446003)(6116002)(36756003)(6506007)(305945005)(105586002)(93886005)(6916009)(76176011)(14444005)(99286004)(486006)(6512007)(66066001)(7736002)(5640700003)(2616005)(476003)(6486002)(106356001)(2351001)(97736004)(6436002)(229853002)(14454004)(2906002)(6246003)(39060400002)(256004)(44832011)(316002)(54906003)(53936002)(118296001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5202;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NWJlHRaeiycMuGLE8uqugSlFAdmeIHRS9uJUEfT4gvPin6ofCfBPAT+d2q9cgKtyGM6Fmwu2u7Wgd/k5UiXf21xWJfEg9vhXHTFwVgDzFjQUld8VtrSG8/vEPl1THX4w1c3ufhHosdfOwiPRp1Rz7Ur7MoMaWSSUiKCfwa74R5azykw5qOh3qqhob9n3XO79mMyWyP+rHo5+tg3Qgt4GoFdnbgH8jpweoQnpQlBou4cWgJrw0g5wTwWrCz7YzZG3pW/rTmEYx8uOSVg4A4w/1PjgHkkUi9wMFsZ7suKIkBCDiMGlE5Ik1VWVrt5QlVHeNjlDyYegU97FDxlukTNY84buoCprhA2nlqO+3Q0StYg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C46217CADB03C4BBF5DC587BC98CD09@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5edf08-aa0e-4768-7af7-08d611a47426
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 13:52:13.9554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTI4IGF0IDE1OjU1ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMjgsIDIwMTggYXQgMDE6MDA6MDJQTSArMDAwMCwgTGVvbmFyZCBD
cmVzdGV6IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOC0wOC0yOCBhdCAxMTowNyArMDEwMCwgTG9y
ZW56byBQaWVyYWxpc2kgd3JvdGU6DQo+ID4gPiBPbiBNb24sIEF1ZyAyNywgMjAxOCBhdCAwMjoy
ODozN1BNICswMzAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4gPiA+IE9uIGlteDdkIHRo
ZSBwY2llLXBoeSBwb3dlciBkb21haW4gaXMgdHVybmVkIG9mZiBpbiBzdXNwZW5kIGFuZCB0aGlz
IGNhbg0KPiA+ID4gPiBtYWtlIHRoZSBzeXN0ZW0gaGFuZyBhZnRlciByZXN1bWUgd2hlbiBhdHRl
bXB0aW5nIGFueSByZWFkIGZyb20gUENJLg0KPiA+ID4gPiANCj4gPiA+ID4gRml4IHRoaXMgYnkg
YWRkaW5nIG1pbmltYWwgc3VzcGVuZC9yZXN1bWUgY29kZSBmcm9tIHRoZSBueHAgaW50ZXJuYWwN
Cj4gPiA+ID4gdHJlZS4gVGhpcyB3aWxsIHByZXBhcmUgZm9yIHBvd2VyaW5nIGRvd24gb24gc3Vz
cGVuZCBhbmQgcmVzZXQgdGhlIGJsb2NrDQo+ID4gPiA+IG9uIHJlc3VtZS4NCj4gPiA+ID4gDQo+
ID4gPiA+IENvZGUgaXMgb25seSBmb3IgaW14N2QgYnV0IGEgdmVyeSBzaW1pbGFyIHNlcXVlbmNl
IGNhbiBiZSB1c2VkIGZvcg0KPiA+ID4gPiBvdGhlciBzb2NzLg0KPiA+ID4gPiANCj4gPiA+ID4g
VGhlIG9yaWdpbmFsIGF1dGhvciBpcyBtb3N0bHkgUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPiwgdGhpcw0KPiA+ID4gPiBwYXRjaCBhZGp1c3RzIHRoZSBjb2RlIHRvIHRoZSB1cHN0
cmVhbSBpbXg3ZCBpbXBsZW1lbnRpb24gdXNpbmcgcmVzZXQNCj4gPiA+ID4gY29udHJvbHMgYW5k
IHBvd2VyIGRvbWFpbnMuDQo+ID4gPiANCj4gPiA+IEkgd2lsbCBhZGQgYSBTdWdnZXN0ZWQtYnk6
IHJlcGxhY2luZyB0aGlzIHBhcmFncmFwaCwgaXQgaXMgYWx3YXlzIGJldHRlcg0KPiA+ID4gdG8g
YWRkIHByb3BlciB0YWdzIHJhdGhlciB0aGFuIGNyZWRpdCBoaWRkZW4gaW4gY29tbWl0IGxvZ3Mg
bWVzc2FnZXMuDQo+ID4gDQo+ID4gSXNuJ3QgIk9yaWdpbmFsbHktYnk6IiBhIGJldHRlciB0YWcg
Zm9yIHRoaXM/DQo+IA0KPiBXZSBjYW4gYWRkIHRoYXQsIHllcyBvciBhZGQgUmljaGFyZCBhcyBw
YXRjaCBhdXRob3IsIGFzIHlvdSBwcmVmZXIgdG8NCj4gZ2l2ZSBoaW0gY3JlZGl0Lg0KDQpJIHRo
aW5rICJPcmlnaW5hbGx5LWJ5OiIgaXMgYSBiZXR0ZXIgZml0IGJlY2F1c2UgdGhlcmUgaXMgbm8N
CmNsZWFyIGNvcnJlc3BvbmRlbmNlIHdpdGggcGF0Y2hlcyBmcm9tIHRoZSB2ZW5kb3IgdHJlZS4N
Cg0KLS0NClJlZ2FyZHMsDQpMZW9uYXJk
