Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A7FC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0432145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMQT3Vi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0432145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeK3Sqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:46:48 -0500
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]:48137
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeK3Sqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS9M2PXZFUcg1IPsMM2TKYx4pko+MX7oC/KjZEUy25E=;
 b=AMQT3Vi126TlYcgw/MCjNJ61AQooQFPiKnZe2kXAb/Y8Q094sXSCNqaaCHjGDFdOCbqBE/Tu4aol4EQQ9X8VM8UDoH7OZCUe3C50Yjbe7rdExTnu6/2On9jjhjUgM/zcM+/nbySnFCTrmkH0ItJQDHCQjoHp9acboFfSXni4GAg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Fri, 30 Nov 2018 07:38:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Fri, 30 Nov 2018
 07:38:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Thread-Topic: [PATCH] clk: imx6sl: ensure MMDC CH0 handshake is bypassed
Thread-Index: AQHUiH2hWlHF6oLZCESale1T/3ahbqVn6qkAgAAB0CA=
Date:   Fri, 30 Nov 2018 07:37:14 +0000
Message-ID: <DB3PR0402MB3916F9DC4C054747211EB90FF5D30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543562288-28638-1-git-send-email-Anson.Huang@nxp.com>
 <154356270811.88331.17520386069332746427@swboyd.mtv.corp.google.com>
In-Reply-To: <154356270811.88331.17520386069332746427@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3724;6:EHFgUGF65GQdb5KPEnmV2UdpbEoJwNLYxuzerhQnmJrGMX8TLPCI3A7hhFylX5I0Ozq9+NteyyXxxUB9aZW0LgRJWeNhbYYPRgJFGJQF+OelqiCYOKH6LpC8+l7dcWPsOHwN4yy2xQ3GY1Zw526WIT1d43yIoHDvC+08MqFEb+cpohIA6xwucqN2eQW3MPOU9PI3TY4foT7a1i2DCb3zgrwLO1VyfYCHVbbUP6iJ2I69i92sLMbGNMP9x6gB0gse3lwP0DqNZPacHbJ/hWUwcdfOnGXlpdq2WGXpzfmRkFPzXNdTjgLiB5JPV10xfWgnghIadN3ASJIsaKK6bH4Z0TZ3kdYT0E42zHk8SjkDyuEzpsNpiVyKNcdI5afWW4yDADaH9z20jj+JFrpmYcBvWLfQ+sTa0scv5b3V5nniVThVahpXrOhIZQp26ofxyP93DNMa9/WtaZFuUCpbfeJ4Yw==;5:0gefIf/kInzy28O8aNrZSBbUeTCbxhva/36WA6EUf9fUwiC0iCts6Bu7YfsY9irDyaGGCo6td8/+HJlEGmQikbA4Ozf25S6yMIzhQ+oXEkEIYQkzRD4hzuAJnSE4ZPGLNwgwi6+hBAcmyzFwwP3zwTr2TMy0tji1GR4TWCicHWw=;7:C3wDr7Sxjv+wsF3olYDhqaeRNb8aaE4fhNd/AUWGFmLvYX9lvhrD5ml9QgzTOS70Z+C6l+Sz4MWccKlQK9mWbbhfKuFBs1WI62jB0E8XKZelq3Q6EwjB2o+3mj/lAZ7Pxw7cFhnZPpDFfX7MPWYmdg==
x-ms-office365-filtering-correlation-id: 67c7cb12-5dab-4f38-60f7-08d65696cd22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-antispam-prvs: <DB3PR0402MB3724704BB5657020DDAFA2EAF5D30@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231453)(999002)(944501463)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3724;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3724;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(13464003)(11346002)(44832011)(446003)(476003)(486006)(5660300001)(71190400001)(71200400001)(6666004)(256004)(14444005)(81156014)(81166006)(8676002)(8936002)(478600001)(86362001)(2201001)(6506007)(25786009)(14454004)(33656002)(68736007)(3846002)(6116002)(26005)(186003)(106356001)(105586002)(7696005)(99286004)(53546011)(316002)(2906002)(76176011)(102836004)(2501003)(97736004)(4001150100001)(7736002)(74316002)(305945005)(53936002)(6246003)(4326008)(6436002)(6636002)(229853002)(55016002)(9686003)(110136005)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q6wpoqofUmt2wO63WaHN3qeiYI6NyTwqvHuQxgBCGQxTaMwoc0LxcEqbHh30G+XwzEmpXTIBPY6W9h4ZmI1t1+3RGL2hGv1gDy2JfrsGPjcjTt4KoYGf1VMpN4AED5YsWyyW6XuJ5qEG7OHTqwfwzivNPTImp/K6jadvZFarBY6KHfPL07IBfW0sY35vTWAIEOI8FBHQ9jAHGPdPTKkaoyzUiumQTbpvTChbHs800IRuQXhkA8IVxrTurBGAPzvJKMoRyvild+DNedl+IQV1igGS8Zk3ZaVVdMDnZAl5lWhhUc4V7/LPv8/ZTn+FEjD8kXZiAzHSwA2RWff6OhpDrMxpEHr+Du0I1AWH6cBCzBc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c7cb12-5dab-4f38-60f7-08d65696cd22
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 07:37:14.6629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgW21haWx0bzpzYm95ZEBrZXJu
ZWwub3JnXQ0KPiBTZW50OiAyMDE45bm0MTHmnIgzMOaXpSAxNToyNQ0KPiBUbzoga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxp
bnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBzaGF3bmd1
b0BrZXJuZWwub3JnOw0KPiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IEZhYmlv
IEVzdGV2YW0NCj4gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT4NCj4gQ2M6IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNsazogaW14NnNsOiBl
bnN1cmUgTU1EQyBDSDAgaGFuZHNoYWtlIGlzIGJ5cGFzc2VkDQo+IA0KPiBRdW90aW5nIEFuc29u
IEh1YW5nICgyMDE4LTExLTI5IDIzOjIzOjQ3KQ0KPiA+IFNhbWUgYXMgb3RoZXIgaS5NWDYgU29D
cywgZW5zdXJlIHVudXNlZCBNTURDIGNoYW5uZWwncyBoYW5kc2hha2UgaXMNCj4gPiBieXBhc3Nl
ZCwgdGhpcyBpcyB0byBtYWtlIHN1cmUgbm8gcmVxdWVzdCBzaWduYWwgd2lsbCBiZSBnZW5lcmF0
ZWQNCj4gPiB3aGVuIHBlcmlwaGVfY2xrX3NlbCBpcyBjaGFuZ2VkIG9yIFNSQyB3YXJtIHJlc2V0
IGlzIHRyaWdnZXJlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNv
bi5IdWFuZ0BueHAuY29tPg0KPiANCj4gRG9lcyB0aGlzIG5lZWQgYSBmaXhlcyB0YWc/DQoNCk5v
cm1hbGx5IHRoaXMgYml0IGlzIDFiJzEgYnkgcmVzZXQsIGJ1dCBkdXJpbmcgb3VyIGRldmVsb3Bt
ZW50LCBpdCB1c2VkIHRvIGJlDQpvdmVyd3JpdHRlbiBpbiB1LWJvb3QgYW5kIGxlYWQgdG8gc29t
ZSBjbG9jayBvcGVyYXRpb24gZmFpbCBpbiBMaW51eCBrZXJuZWwsIHRoYXQgaXMgd2h5IHdlIGVu
c3VyZSBpdA0KaW4gY2xvY2sgZHJpdmVyIGVhcmx5IHBoYXNlLiBJTU8sIGl0IHNob3VsZCBiZSBP
SyB0byBub3QgYWRkIGEgZml4IHRhZywgc2luY2UgaXQgaXMganVzdA0KdG8gbWFrZSBzdXJlIHRo
ZSBzZXR0aW5nIGlzIGNvcnJlY3QgYW5kIE5PVCBkZXBlbmRzIG9uIHRoZSBoYXJkd2FyZSByZXNl
dCB2YWx1ZSB3aGljaA0KY291bGQgYmUgY2hhbmdlZCBpbiB1LWJvb3QuDQoNCkFuc29uLg0KDQo=
