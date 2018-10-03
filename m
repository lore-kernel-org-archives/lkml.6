Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DC1C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E4820835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O0zgvDrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E4820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJDA6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:58:20 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:11920
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727319AbeJDA6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzgtDAv01hoWFnM7M9UQSiHm6r/NEfQnxCJIPqXINbQ=;
 b=O0zgvDrV9JUVOnqsshJOIR91uajNzvv/FIIIiQAP2q/UuqrzDwVqAJJYCNu6vC4w49WE0YdqcrH99gnE1hZj2j3uMzs2emvZM8WPEFEa9GbTlMcQBMSh4aQW2z9xIkanda4BS7ycebKrPRpb3P+OyLe70UGkjoiyOu7EmkGLmmk=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4401.eurprd04.prod.outlook.com (52.135.148.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Wed, 3 Oct 2018 18:08:09 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.021; Wed, 3 Oct 2018
 18:08:09 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>
Subject: Re: [PATCH] regulator: fixed: Default enable high on DT regulators
Thread-Topic: [PATCH] regulator: fixed: Default enable high on DT regulators
Thread-Index: AQHUWcd49bv0W/6vgk+3Fmf6b/rzB6UL9/8AgAF4eACAAGQLAA==
Date:   Wed, 3 Oct 2018 18:08:09 +0000
Message-ID: <c2ace38e09344d325271498fe8133c888470b5f6.camel@nxp.com>
References: <20181001204346.4655-1-linus.walleij@linaro.org>
         <28e88d54f6503cf1be577eb1872cdf2c50d7dfa3.camel@nxp.com>
         <20181003121002.GA7132@sirena.org.uk>
In-Reply-To: <20181003121002.GA7132@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4401;6:jijkFM9JoQtcTsZiW88K4cEXCbq+tlDnOVwwGEkFRTNWxgCmyni8NackOKd7moYtVAy3IY10vYWCDjkkQwhPsvuMoJPAg97613Y9Bl85fiyGD+5bxCvTvRXlCgN9f8IHeUaRjqXmYiIRb2aD6wbGcG3dU6qgiBVdkSSMIsjn8KV2VSmggV5+f0n8/rgivnXiUTa9pDrm4FiEuzUaWsz+n4YejGKoHG2VzcODa5wun9QK+VcmeMBEJxrTij24dRPaIfU7tByFY6sLk2Jqs9ScBBabDGvEbJWShFHbTqWYC9LoSORl07BTS0tidkVJDny8JWq14pda8zoM4/0tsPB2WwxGyM9JwFoLYt/aFF6Kq3NAES9JX7nO4/KknhjQ+xRGxlWSo7u9rSMEZ8Z17MvhmqpqheYbpKK4m84PMkqzEtN7PHESDBpQ6urnjRE+h/hO+uIpdf9WC8HZiTe1PjiQJw==;5:HQ+6R/sKEukS3QM8NKD28pHQQwp7Oozk5oYUc/oYal60QcUABhRpRGe+7UDnMHKwRM0L8DhXROcosDQDL1Kd4ziMztXbVO8svjdrRM9RdDNUnfj7DNVg1y5+ia8rn9AbxmqDzKAPwR6wY+nqGJignlORx2yqCNsODKxbnOREaAc=;7:kCT2obmjDZMgBcrvT+XvmRz1oIN6/nXPhWDLOJTynFNFqqHzW8KZFrmbh10fGK4PWy9K0yevbFvI0oUitO3ftH9/pvZP8GgpBvZ1g2V/0PHlolCG1BMZ2j2RwPmkTLY5giK/CXjizLRNyKIemqgPlZ/47YatUEfjHoF+2gXfYBZDDlhCiqqGMpimpGAvhj8czmwMGaeytO+jTTJlXEFn92bXAE4CC70YHW/bd3Vz0XIjBUFqlk2BmHrFybPYVyBH
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 64b4cac1-8ca9-482f-0d6e-08d6295b2cf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4401;
x-ms-traffictypediagnostic: AM0PR04MB4401:
x-microsoft-antispam-prvs: <AM0PR04MB4401C685C56D0ACF2BBEC7DAEEE90@AM0PR04MB4401.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM0PR04MB4401;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4401;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(305945005)(7736002)(97736004)(966005)(478600001)(66066001)(6506007)(76176011)(2900100001)(36756003)(5660300001)(71200400001)(71190400001)(316002)(186003)(102836004)(26005)(118296001)(2501003)(446003)(14454004)(44832011)(486006)(476003)(11346002)(5250100002)(2616005)(54906003)(25786009)(110136005)(6116002)(229853002)(14444005)(256004)(3846002)(86362001)(81156014)(81166006)(6246003)(8676002)(39060400002)(106356001)(8936002)(4326008)(50226002)(2906002)(105586002)(53936002)(6306002)(68736007)(6436002)(6486002)(99286004)(6512007)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4401;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kljoNqXUgPIUGq1aSdIFKXnmL2GPyAJpOJ21uQs5PPgRtI0GmnLDHmkpS3IzYpRV4q/3G8U8/WRhXPYiOXyJR8l7A8uElhrAr3cF0KXee9KuMEJlM86wDch1W1yN718X5NxOaIZd65ZSD2t02sQXU550Alp36o6uYs2qtquOZiaZhXdZfoDlVSFbsSQss0zbg95RkYj+zBaHssyHX8b8dH5y00anTdkvqvNYTyJfON9bDK5e8lepeoiGkEH2p61LMA0Uh40sTFwCBGv9o/QDezJr1RUA+2Qu11nxZbuCDC20EW57OGvt5t5Eh1fjYtK5RBmXlV8RzMigh/urNuQewiFYW4RQEuSTEM6tSqIkvnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <10A68D272161934888D595B338EC4714@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b4cac1-8ca9-482f-0d6e-08d6295b2cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 18:08:09.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4401
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTAzIGF0IDEzOjEwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUdWUsIE9jdCAwMiwgMjAxOCBhdCAwMTo0MjozOFBNICswMDAwLCBMZW9uYXJkIENyZXN0ZXog
d3JvdGU6DQo+IA0KPiA+IFRoaXMgdHVybnMgdGhlIHBoeSBvZmYgYW5kIG9uIGFnYWluIGluc3Rl
YWQgb2YgbGVhdmluZyBpdCB1cCBmcm9tIHVib290DQo+ID4gYW5kIGl0IGRvZXNuJ3Qgd29yayBm
b3Igc29tZSByZWFzb24uIEhvd2V2ZXIgbG9va2luZyBhdA0KPiA+IHJlZ19maXhlZF92b2x0YWdl
X3Byb2JlIGludHJvZHVjaW5nIGFuIGVkZ2Ugc2VlbXMgdG8gYmUgaW50ZW50aW9uYWwgZm9yDQo+
ID4gcmVndWxhdG9ycyB3aGljaCBhcmUgbm90IG1hcmtlZCB3aXRoICJlbmFibGVkLWF0LWJvb3Qi
LiBSaWdodD8NCj4gDQo+IE5vLCB0aGF0J3MgZGVmaW5pdGVseSBub3QgZGVzaXJlZC4gIFdlIGRv
bid0IHdhbnQgdG8gY2hhbmdlIHRoZSBzdGF0ZSBvZg0KPiB0aGUgcmVndWxhdG9yIGF0IGFsbCBp
ZiB3ZSBjYW4gYXZvaWQgaXQgdW5sZXNzIHRoZSB1c2VyIGV4cGxpY2l0bHkgYXNrZWQNCj4gZm9y
IGl0Lg0KDQpUaGF0IGFsc28gbWFrZXMgc2Vuc2UsIGZvciBhIHRvcCBsZXZlbCBwZXJzcGVjdGl2
ZS4gQnV0DQpyZWdfZml4ZWRfdm9sdGFnZV9wcm9iZSBjb250YWlucyB0aGUgZm9sbG93aW5nIHNu
aXBwZXQ6DQoNCglpZiAoY29uZmlnLT5lbmFibGVkX2F0X2Jvb3QpIHsNCgkJaWYgKGNvbmZpZy0+
ZW5hYmxlX2hpZ2gpDQoJCQljZmcuZW5hX2dwaW9fZmxhZ3MgfD0gR1BJT0ZfT1VUX0lOSVRfSElH
SDsNCgkJZWxzZQ0KCQkJY2ZnLmVuYV9ncGlvX2ZsYWdzIHw9IEdQSU9GX09VVF9JTklUX0xPVzsN
Cgl9IGVsc2Ugew0KCQlpZiAoY29uZmlnLT5lbmFibGVfaGlnaCkNCgkJCWNmZy5lbmFfZ3Bpb19m
bGFncyB8PSBHUElPRl9PVVRfSU5JVF9MT1c7DQoJCWVsc2UNCgkJCWNmZy5lbmFfZ3Bpb19mbGFn
cyB8PSBHUElPRl9PVVRfSU5JVF9ISUdIOw0KCX0NCg0KVW5sZXNzIGNvbmZpZy0+ZW5hYmxlZF9h
dF9ib290IHRoZSBHUElPIGlzIGluaXRpYWxpemVkIHdpdGggdGhlDQpvcHBvc2l0ZSBwb2xhcml0
eSBvZiBlbmFibGVkLiBUaGlzIG1lYW5zIHRoYXQgZml4ZWQgcmVndWxhdG9ycyB3aGljaA0KYXJl
IG5vdCBtYXJrZWQgd2l0aCAiZW5hYmxlZC1hdC1ib290IiBidXQgaGFwcGVuIHRvIGJlICJvbiIg
YW55d2F5IGFyZQ0KYWx3YXlzIHBvd2VyIGN5Y2xlZC4NCg0KVGhpcyBpcyBmcm9tIGJlZm9yZSBy
ZWNlbnQgY2hhbmdlcyBieSBMaW51cywgY29kZSBkYXRlcyBmcm9tIDIwMTINCmNvbW1pdCAyNWE1
M2RmYmZiZmQgKCJyZWd1bGF0b3I6IGZpeGVkOiBVc2UgY29yZSBHUElPIGVuYWJsZSBzdXBwb3J0
IikuDQpFdmVuIGJlZm9yZSB0aGF0IHRoZSBsb2dpYyB3YXMgc2ltaWxhcjoNCg0KCWRydmRhdGEt
PmlzX2VuYWJsZWQgPSBjb25maWctPmVuYWJsZWRfYXRfYm9vdDsNCglyZXQgPSBkcnZkYXRhLT5p
c19lbmFibGVkID8NCiAgICAgICAgCWNvbmZpZy0+ZW5hYmxlX2hpZ2ggOiAhY29uZmlnLT5lbmFi
bGVfaGlnaDsNCglncGlvX2ZsYWcgPSByZXQgPyBHUElPRl9PVVRfSU5JVF9ISUdIIDogR1BJT0Zf
T1VUX0lOSVRfTE9XOw0KDQpMb29raW5nIGZ1cnRoZXIgYmFjayBpdCBzZWVtcyB0aGF0IHRoaXMg
YmVoYXZpb3IgaGFzIGFsd2F5cyBiZWVuDQpwcmVzZW50IGluIGZpeGVkLXJlZ3VsYXRvciBjb2Rl
Lg0KDQpJbiB0aGVvcnkgaXQgbWlnaHQgYmUgcG9zc2libGUgdG8gcmVxdWVzdCB0aGUgR1BJTyB3
aGlsZSBhc2tpbmcgdG8ga2VlcA0KdGhlIHZhbHVlIGZyb20gdGhlIGJvb3Rsb2FkZXI/IE1heWJl
IEknbSBjb25mdXNlZCBidXQgSSBkb24ndCBzZWUgYW4NCmVhc3kgd2F5IHRvIGRvIHRoaXMgdGhy
b3VnaCB0aGUgR1BJTyBhcGk7IGZ1bmN0aW9ucyBmb3IgcmVxdWVzdGluZyBpbg0Kb3V0cHV0IG1v
ZGUgYWxsIHNlZW0gdG8gYWxzbyBhc2sgZm9yIHRoZSBpbml0aWFsIHZhbHVlLg0KDQpHUElPRF9B
U0lTIGxvb2tzIGNsb3NlIGJ1dCBpdCBkb2Vzbid0IGV2ZW4gYWRqdXN0IHRoZSBkaXJlY3Rpb24u
DQoNCj4gPiBJdCdzIHBvc3NpYmxlIHRoYXQgeW91IGV4cG9zZWQgYW4gaW14IGJvYXJkLXNwZWNp
ZmljIGJ1ZzogbWF5YmUgcG93ZXINCj4gPiBjeWNsaW5nIHRoZSBwaHkgYWZ0ZXIgdWJvb3QgbmVl
ZHMgc29tZSBtaXNzaW5nIGZpeHVwPw0KPiANCj4gSXQnZCBwcm9iYWJseSBhbHNvIGJlIGdvb2Qg
dG8gc29ydCB0aGlzIG91dCB0aG91Z2guDQoNClllcywgaGFuZGxlZCBzZXBhcmF0ZWx5OiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvOTk0ODcxLw0K
