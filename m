Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF775C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1DE2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ql4J8dN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1DE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeJBBcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:32:52 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:22730
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbeJBBcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+eh7QCyoxlpKgLW3XJwaztDiIoMdVE4QRX/tfLcKl4=;
 b=ql4J8dN2LA/FmQYStHal4aB3jPkmUi/q+Mn6aKInqLrGLD1BD0tru75VMpwLE69zHrYS2kE8imCTKb4s8zBFQFBKVezNV/xzkMrH2nSjSy0HqojUVp1Thdqz+oEvQ+5ExI6Q97MmFVjeNk2ro3licFmitY662L7bQb8h1/ThGfk=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4018.eurprd04.prod.outlook.com (52.134.90.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Mon, 1 Oct 2018 18:53:38 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 18:53:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jmkrzyszt@gmail.com" <jmkrzyszt@gmail.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Thread-Topic: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
Thread-Index: AQHUWbgPf0PtSEzRFE2eGjinXopSfQ==
Date:   Mon, 1 Oct 2018 18:53:37 +0000
Message-ID: <afd78fe6a5e168cc9190afe3e27d12286e0dfafa.camel@nxp.com>
In-Reply-To: <20180906122436.25610-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4018;6:QaOLls0Zthb57t+cXVPYJAuGlFuJtI/Es6dXlZBXyIYWuMg23EtwziuE3lFC8OX6jzbpR5YWpgevbRlgXEVgbY0NccvJjOcp8kr0bvIuhjVlKIKae6a+b0eu77qlnq2I84SqFh5WAOH7YEA4rj3A7xLg/+3Xy1yaSKxwVkrPSXYrR/q6KhN+wMM3s/edVoHwKytsf/OjlK4ktEdNpB8W0Q7gULZYmC139d9LG9/BHIEvFLs+P/MkWDkWTgGIs08y3SXgwm8fBhV3q/d2rOoC/W6w0EpAL5C9ooMtbIXaPMaOuFIRNZqWpOkehiDsy8YE/cvBsahrEgjeWDYIsOLda5uF96qSLTzm4b3Vm2HI3FD0psKvRKzk4v1wyItOCepmPo1YEQrlMdMdX0uCxNh9ZBZh5EG3js3BBYmT2loGDP+tUZvw2fzi816Z0oFmNIEmBBwaDU7g5PRONRmQbfopeA==;5:buLrJqNDRs6Sj10iv47Qe9hRiarAhgDtvsLW2Ob1K2h7yhjdTT0Xejgt4RotmXQBo+W6mgXfUcwyhRQiJtU/IIpzjvkWQIpif84iETUwS5+y74nTsrgW4KrCaYDChXVQuKi0o3LB0DKfXs3oDb/gIFvz4kUL4UTMGP8lessBug0=;7:cYAd21LOIb3+yQC4dtRLJqEbCs9I7NGmVAAURTdfcCMgdYKmCKXfrRIJB2tPV+AvkESpPYCSQLNzCwogOkCL3aD8RMg7xrFrojdyWgCXQXAHooqEViUtsv8iPfyH37nia/KTalDPiqfVLWDoCxnQ870VVeD+GzYWHGju75ZnX/1MqhD7vb+X8yrd4rmFSW2T9oK+HmWFxLcZz/nGEa0K8LHKzHXLa3Oh8kIIkBWZNUONNXwN3G6MU2JE9Lrfumn6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 57a83b8d-2c16-48be-0e83-08d627cf32b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4018;
x-ms-traffictypediagnostic: AM0PR04MB4018:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB4018C87976AD582DCD09B22CEEEF0@AM0PR04MB4018.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4018;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4018;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(97736004)(50226002)(5660300001)(6116002)(3846002)(6486002)(26005)(316002)(39060400002)(14444005)(256004)(54906003)(25786009)(66066001)(6246003)(4326008)(110136005)(8936002)(44832011)(71200400001)(102836004)(81156014)(86362001)(6512007)(36756003)(118296001)(7416002)(966005)(99286004)(5250100002)(305945005)(8676002)(7736002)(2906002)(81166006)(6306002)(53936002)(229853002)(11346002)(14454004)(106356001)(6436002)(486006)(2900100001)(6506007)(478600001)(476003)(71190400001)(68736007)(2501003)(186003)(2616005)(105586002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4018;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 86twYRpRkyZhUweWJDIsoqPAZWZdlmod6VDHNqtWYOrI1p5pGidZPC8pnKQ6NTwxZUIakJOY5VihWs6PKneqZnvIiVWKODIm5XRJuYdB8468DKLCzY5V0/TwSdIoV+PjKBEPYkTmvjuVklQwXTyuhgcTxPa2m7TR4yxy/SzNmniID7ACSHN2/fjmetX6nuk0mEdV4+EheizXlqpKPBNyeGuoGqeXFagX/bbOB+FRG9y46UNyAfU1dXejXeEydf25O9C440N2kzqPXTPIkNMoBtgXkibhP0eiTWLKVviap04rPDKbSf8BkWVQhDCWqzj+PHmS4EgFJ2lW8QGEnk82s5f9Xbx12XKhPj4krge7nIc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D77CF36BEF8DE4D8D3E1585AF76F5E0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a83b8d-2c16-48be-0e83-08d627cf32b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 18:53:37.9965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClRoaXMgcGF0Y2ggc2VlbXMgdG8gYnJlYWsgbmV0d29yayBib290aW5nIG9uIGlt
eDZzeC1zZGIgaW4gbGludXgtbmV4dA0KYmVjYXVzZSB0aGUgZW5ldCBwaHkgcmVndWxhdG9yIGlz
IG5vdCBvbi4gUmV2ZXJ0aW5nIHRoZSBwYXRjaCBmaXhlcw0KYm9vdC4NCg0KSGVyZSBpcyB0aGUg
cmVndWxhdG9yIGRlZmluaXRpb246DQoNCnJlZ19lbmV0XzN2MzogcmVndWxhdG9yLWVuZXQtM3Yz
IHsNCgljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQoJcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCglwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZW5ldF8zdjM+Ow0KCXJlZ3VsYXRvci1u
YW1lID0gImVuZXRfM3YzIjsNCglyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsN
CglyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCglncGlvcyA9IDwmZ3BpbzIg
NiBHUElPX0FDVElWRV9MT1c+Ow0KfTsNCg0KSGVyZSBhcmUgc29tZSBwcmludHMgd2l0aCB0aGUg
cGF0Y2ggZW5hYmxlZDoNCg0KWyAgICAwLjE1MzE1MF0gcmVnLWZpeGVkLXZvbHRhZ2UgcmVndWxh
dG9yLWVuZXQtM3YzOiBPVVRfSElHSCBnZmxhZ3MgMHg3DQpbICAgIDAuMTUzMTcxXSByZWdfZml4
ZWRfdm9sdGFnZV9wcm9iZSgxNzkpOiByZWd1bGF0b3ItZW5ldC0zdjMgY2FsbCBncGlvZF9nZXRf
b3B0aW9uYWwgZ2ZsYWdzPTB4NyBlbmFfZ3Bpb19pbnZlcnQNClsgICAgMC4xNTMyMThdIHJlZ3Vs
YXRvci1lbmV0LTN2MyBHUElPIGhhbmRsZSBzcGVjaWZpZXMgYWN0aXZlIGxvdyAtIGlnbm9yZWQN
ClsgICAgMC4xNTMyMzNdIG9mX2dwaW9fZmxhZ3NfcXVpcmtzKDgzKTogcmVndWxhdG9yLWVuZXQt
M3YzIHNldCBhY3RpdmUgbG93IGJlY2F1c2UgIWVuYWJsZS1hY3RpdmUtaGlnaA0KWyAgICAwLjE1
MzI1OF0gb2ZfZ2V0X25hbWVkX2dwaW9kX2ZsYWdzOiBwYXJzZWQgJ2dwaW9zJyBwcm9wZXJ0eSBv
ZiBub2RlICcvcmVndWxhdG9yLWVuZXQtM3YzWzBdJyAtIHN0YXR1cyAoMCkNClsgICAgMC4xNTMz
MTBdIGdwaW9fdmFsdWU6IDM4IHNldCAwDQpbICAgIDAuMTUzMzMyXSBncGlvX2RpcmVjdGlvbjog
Mzggb3V0ICgwKQ0KWyAgICAwLjE1MzM2NF0gZW5ldF8zdjM6IGVuYV9ncGlvZD0ocHRydmFsKSBl
bmFfZ3Bpbz0wIGluaXQ9MCB2YWxpZD0xDQpbICAgIDAuMTUzMzc3XSBlbmV0XzN2MzogcmVxdWVz
dCBHUElPDQpbICAgIDAuMTUzMzkzXSBlbmV0XzN2MzogYWxyZWFkeSBoYXZlIGdwaW9kDQpbICAg
IDAuMTUzNDIzXSBlbmV0XzN2MzogMzMwMCBtViANCi4uLg0KWyAgICAzLjg2NzgyN10gZW5ldF8z
djM6IEdQSU8gZW5hYmxlIGNvdW50PTAgaW52PTENClsgICAgMy44NzI0MzJdIGVuZXRfM3YzOiBz
ZXQgdmFsdWUgMA0KWyAgICAzLjg3NTc3OV0gZ3Bpb192YWx1ZTogMzggc2V0IDENCg0KVGhhdCAi
Z3Bpb192YWx1ZTogMzAgc2V0IDEiIHRyYWNlcG9pbnQgaXMgd3JvbmcsIHRoZSBsaW5lIGlzIHNl
dCBoaWdoLg0KDQpJdCBzZWVtcyB0aGF0IGdwaW9kX3NldF92YWx1ZSB3aWxsIGNoZWNrIEZMQUdf
QUNUSVZFX0xPVyBhbmQNCmF1dG9tYXRpY2FsbHkgaW52ZXJ0IHNvIG1heWJlIGVuYV9ncGlvX2lu
dmVydCBzaG91bGQgbm90IGJlIHVzZWQgaWYgYQ0KZnVsbCBncGlvZCBpcyBwYXNzZWQgdG8gcmVn
dWxhdG9yPw0KDQotLS0gZHJpdmVycy9yZWd1bGF0b3IvZml4ZWQuYw0KKysrIGRyaXZlcnMvcmVn
dWxhdG9yL2ZpeGVkLmMNCkBAIC0xNDYsNyArMTQ2LDYgQEAgc3RhdGljIGludCByZWdfZml4ZWRf
dm9sdGFnZV9wcm9iZShzdHJ1Y3QNCnBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAgICAgICAg
ZHJ2ZGF0YS0+ZGVzYy5maXhlZF91ViA9IGNvbmZpZy0+bWljcm92b2x0czsNCiANCi0gICAgICAg
Y2ZnLmVuYV9ncGlvX2ludmVydCA9ICFjb25maWctPmVuYWJsZV9oaWdoOw0KICAgICAgICBpZiAo
Y29uZmlnLT5lbmFibGVkX2F0X2Jvb3QpIHsNCiAgICAgICAgICAgICAgICBpZiAoY29uZmlnLT5l
bmFibGVfaGlnaCkNCiAgICAgICAgICAgICAgICAgICAgICAgIGdmbGFncyA9IEdQSU9EX09VVF9I
SUdIOw0KDQpBbGwgdGhlc2UgaGlnaC9sb3cgaW52ZXJzaW9ucyBhbmQgZmxhZ3MgYXJlIGV4dHJl
bWVseSBjb25mdXNpbmcgdG8gbWUuDQoNCkxpbmsgdG8gb3JpZ2luYWwgdGhyZWFkOiBodHRwczov
L2xrbWwub3JnL2xrbWwvMjAxOC85LzYvNDg1DQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA0K
