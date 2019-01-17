Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080A5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC40820856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oAyjtt6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfAQG1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:27:48 -0500
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:45553
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbfAQG1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CGB8UPACeVFvfv1IejFTRcm+mQPgs6fKd19IjvDKTo=;
 b=oAyjtt6vFRynGQRmPjs4/Ue3vGP6If4oW4ILjHPsnbWbSJzbvfi8WydtlWEJNNmuN/Qx3valzIPMZneAm+e0qw0g+9SxsAO7AIq6b/OQmJBzlLwlpJ7w4oTpCEA2PuKog/BRUUJXO9zLvVDglEVIXgRrH4mVEqnaRuwKlsbsqZw=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5948.eurprd04.prod.outlook.com (20.178.106.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Thu, 17 Jan 2019 06:27:44 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b5b6:9a7a:7970:ffec]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b5b6:9a7a:7970:ffec%4]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 06:27:44 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/2] can: flexcan: add PE clock source select support
Thread-Topic: [PATCH 0/2] can: flexcan: add PE clock source select support
Thread-Index: AQHUkrKRyn6yL7TqVE+qZvWvbmx6sKWzNfCA
Date:   Thu, 17 Jan 2019 06:27:44 +0000
Message-ID: <DB7PR04MB4618E703A466628F22BCFBF6E6830@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5948;6:RYiUy1Spk0pc1WTi7Ljyzovm5pZEh9Etq+6zT4dfPP0AUXXkZn6t8dZ8KeXOyq7AK64BOGjZJy7MOfLMwTV/IQO6c6rJXGO+Zj3LnYIa+QisENkBCFM0WfUQkO5HpDOe7I2CfzkFpeUTA6P9E+REFRlbNXdP6YcGwKb7u8phaQ3zAEYWQTi5YKNPar5ICfXti2gkV5gTRw6EQYmhSYXvhVsdSx8E5Hw2dpJbps8qDlrsvxK289O22IOQDKJ0RjbzIzciZrReKXij88v34iIsV30nMuWdG4x0SeB1dw6BuXjK9vruMk7Z083vCU8LU75ZXEeuorvk/KSLcAc6jiXgA9ce6UlREi7pSXrgO/VG5RXkbutJkelqSjZ+MFFP06bdRACw3hhNyRl/2Lp6lUsrPAs80tTuNKtWo9j9Fp+PyQxVvzYNSAW4lpHo8BhE04PI7oBRjKfIHHKIcyq4YaVfeA==;5:W7h07+s239yYyP+t9fbpTISXLwrymGSoRHpHc5z++n81l6i7DEGMNjN+3q5K9XvbUTJAGLH54Xhc87mbPmQHHgwLVRJ9uiBB2C8HurWBcPBnLiy3aJkpEShiQIuxDXhoo4aA8ECV8+CxSPlYgLMx6qddVwGzaewnVi4cN2A6y6rYTRFL71+OY4MzpuGexe8WPNs+SKYtJLB7flr8nKc2PQ==;7:Oocr3Sf7C0Kz38oGit7dhZWbrQzDr+XUKGnacLHtMHpKE+VPqJJOIg42Wl1jaio5m6EExY8Bwb388U0qH57hVcQsoDRieklm9CRHbfZg+TXQaRX4PCHt6mXUszDVsCHGKVnBaQzE7eJPrAqqiTwb7A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a02fcc46-0c20-4b65-1474-08d67c44e433
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5948;
x-ms-traffictypediagnostic: DB7PR04MB5948:
x-microsoft-antispam-prvs: <DB7PR04MB594895F661086075E338B13BE6830@DB7PR04MB5948.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(13464003)(189003)(199004)(14454004)(4326008)(53936002)(478600001)(186003)(106356001)(105586002)(2501003)(76176011)(2906002)(7696005)(305945005)(86362001)(71190400001)(66066001)(256004)(81166006)(7736002)(9686003)(81156014)(486006)(229853002)(74316002)(476003)(11346002)(71200400001)(446003)(102836004)(569044001)(6506007)(110136005)(316002)(6436002)(4744005)(68736007)(25786009)(99286004)(55016002)(97736004)(53546011)(8676002)(6246003)(26005)(5660300001)(3846002)(6116002)(54906003)(8936002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5948;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F5O4eJeJQqr8CSZu4jxa/28Y0eHyN/1X79m03bp7HN6ICCLkaxn+DW/102UdqAHMROc2ikYC7hIvor2Nm3FwnVhFr3eTq/F2EXhm3Xx8EYb05pZcifRLpWz1cDeBIzz+z14JYKCH4dQzkg8pO2Xgs5Kf0wODfazIhoeyIjgO/0kOQ8ZZle9LuvNvCcIHmSJiHcIpKrcwoQqpzZKzO8M5tl8L/iL/C2omX0kbma0WtkjP05atgUVBzUjWrEEnCbQ2upB+4Tuftfjqxxadmi6TBusTAvJpVm7BqRzUoIXYqZ6lq1dzFAh8g/ujG+6w+yGr5RarcqLZlBmCEyFDZ+0HSuBrAC58tYKZw6yQnm+Eqya5jXBF3V8RfACGYg+8ZGfcZCHYexnNyTbri9EoP3BPGHfGAHkJHhtddxbRHHFLbRo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02fcc46-0c20-4b65-1474-08d67c44e433
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:27:44.6476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpLaW5kbHkgUGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FraW0gWmhhbmcNCj4gU2VudDogMjAx
OMTqMTLUwjEzyNUgMTU6MDgNCj4gVG86IG1rbEBwZW5ndXRyb25peC5kZTsgcm9iaEBrZXJuZWwu
b3JnDQo+IENjOiBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxs
aW51eC1pbXhAbnhwLmNvbT47IEpvYWtpbQ0KPiBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwLzJdIGNhbjogZmxleGNhbjogYWRkIFBFIGNsb2NrIHNv
dXJjZSBzZWxlY3Qgc3VwcG9ydA0KPiANCj4gVGhlIHBhdGNoIHNldCBpbnRlbmRzIHRvIGFkZCBz
dXBwb3J0IGZvciBQRSBjbG9jayBzb3VyY2Ugc2VsZWN0LiBUaGUgRmxleENBTg0KPiBjb250cm9s
bGVyIGNhbiBwYXJzZSAiZnNsLGNsay1zb3VyY2UiIHByb3BlcnR5IGZyb20gZGV2aWNlIHRyZWUg
dG8gc2VsZWN0IGNsb2NrDQo+IHNvdXJjZS4NCj4gDQo+IERvbmcgQWlzaGVuZyAoMik6DQo+ICAg
RG9jdW1lbnRhdGlvbjogY2FuOiBmbGV4Y2FuOiBhZGQgUEUgY2xvY2sgc291cmNlIHByb3BlcnR5
IHRvIGRldmljZQ0KPiAgICAgdHJlZQ0KPiAgIGNhbjogZmxleGNhbjogYWRkIHN1cHBvcnQgZm9y
IFBFIGNsb2NrIHNvdXJjZSBzZWxlY3QNCj4gDQo+ICAuLi4vYmluZGluZ3MvbmV0L2Nhbi9mc2wt
ZmxleGNhbi50eHQgICAgICAgICAgIHwgIDggKysrKysrKysNCj4gIGRyaXZlcnMvbmV0L2Nhbi9m
bGV4Y2FuLmMgICAgICAgICAgICAgICAgICAgICAgfCAxOCArKysrKysrKysrKysrKy0tLS0NCj4g
IDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IC0tDQo+IDIuMTcuMQ0KDQo=
