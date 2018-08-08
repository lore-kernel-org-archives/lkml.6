Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF2C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA284216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SQp37sao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA284216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHHKSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:18:49 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:47232
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726939AbeHHKSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhOF73Tj2rmk+h59g73swncfWnhFYzi5SBfwTe1etBA=;
 b=SQp37saoFYkysmWYv5G34AoR8H7uedDNRfAGX/Ncws0j3n7VloUDrp+kh0NguktqGMiQszhoy3rjRacVnVtRMaBMyWcOFNnNeLQMdcKa6xUa1y0RECEWStOn8p0+md7KOtnFSfTSamdeCF7VlAEL6FD+36rFIY28jXMAdHjYMLQ=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4195.eurprd04.prod.outlook.com (52.134.126.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 08:00:15 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%5]) with mapi id 15.20.1038.019; Wed, 8 Aug 2018
 08:00:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     "A.s. Dong" <aisheng.dong@nxp.com>,
        "marex@denx.de" <marex@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marius-cristian Vlad <marius-cristian.vlad@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Mirela Rabulea <mirela.rabulea@nxp.com>
Subject: Re: [PATCH v3 4/4] drm/mxsfb: Switch to
 drm_atomic_helper_commit_tail_rpm
Thread-Topic: [PATCH v3 4/4] drm/mxsfb: Switch to
 drm_atomic_helper_commit_tail_rpm
Thread-Index: AQHULbwVTMR/oOfggkO2mUOl9/YBvaS0psOAgADZcIA=
Date:   Wed, 8 Aug 2018 08:00:15 +0000
Message-ID: <174c00104b40ebe1f6495e679e115948bb561889.camel@nxp.com>
References: <cover.1533583611.git.leonard.crestez@nxp.com>
         <cd938df7516aee05289dc2d7dc17bc85b219be53.1533583611.git.leonard.crestez@nxp.com>
         <da414ab37c3d7c02f059fd3c0470dac9@agner.ch>
In-Reply-To: <da414ab37c3d7c02f059fd3c0470dac9@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4195;6:ZgUoN+KU53+8ZjteYTqAV4omYQUuGTHA5wxGhZ7eDSmlBjwI2UqWc3e65cLY1nQrxzUMtcAR2kxGbJplChsRIijnUONl5QFvy3CYhDWp7jwQE3hsXSwbYFWGNMksqzYreXIcO6oVpq2ljbnzhYDqA8FjGy3/rISLTH0OQL4EqyCArsupw5t9JYyxeNeMmrAeLnZK/FC9NGRQVnVUBAGtkQt8z8cojEQGxCUB+G9xI+TMs4SFVQiq2WYSYa+OQZIp9hkwO8rncTZWJFXktLcmlnA/C54gdGTHk/hgQvoXjEY/qg0cKD4GGyG/TNG48cbYPmYBiECtOBGCHkpOMGRnxOlAfhTjZ3tmjTwm7Qv6txjzEg/R+DyhzkpLwLNY62H5UnBYJELdTQ7CVWqBvMP0OAvAFSQGvSlDobVgZh7OmVPt3UYHnYKsyMm1tF7PShvPEsoU31YInUMxmfPsTZLd/Q==;5:bGX2Vx1I1bKRs74p1f0npQjcQ0voiOuNWCjzge7ATbP5LzK0Ato+3fjbr+Lojr8yJyOkc9MAio/ThiGZ4cgCxy+0c8ygXSvP3wloJxshsLGXQAmXxWP0S3Jx1EwrCOxXVoZW30/v9+KDfL7LTqeNdXtcIs/6n7H/cmZhxinxg4w=;7:Gy+inFjc7JEJ3ggyOFdWsZGuhe+6E5LhTo2OIpYp0gi7SXfqDsx/AsgQcEsVhoUmunHLw81ljTfHH9FCtPhnzec+P+MuVTiAcSfB6CuvbmjL3GSuN0jK43pgXcEUpiHmaPfvn0V+kV2mOYC2oat0jkdoMcsofos6vg6z7OFsQi5JeLj9WO1ICtVhJencKd5rq6j5dZMOEM03S5b7NytgMFB8DfeYlqUMjisikoz/tTd325sRCEbNPQpKskVJzj0l
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 22e45a11-0c49-4599-f586-08d5fd04f9f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4195;
x-ms-traffictypediagnostic: AM0PR04MB4195:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB4195C14C9D8817499B09EB21EE260@AM0PR04MB4195.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4195;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4195;
x-forefront-prvs: 07584EDBCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(136003)(376002)(189003)(199004)(99286004)(316002)(106356001)(105586002)(478600001)(305945005)(7736002)(50226002)(8676002)(8936002)(1730700003)(81156014)(81166006)(2906002)(86362001)(6486002)(54906003)(6512007)(229853002)(25786009)(36756003)(53936002)(5640700003)(6436002)(97736004)(68736007)(118296001)(4326008)(44832011)(14454004)(3846002)(76176011)(6116002)(2616005)(11346002)(446003)(476003)(6246003)(2351001)(486006)(53546011)(6506007)(6916009)(186003)(2900100001)(26005)(256004)(2501003)(5250100002)(102836004)(5660300001)(66066001)(14444005)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4195;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y64QpWckZ9T5uPKlYvPdzIu/laCRxYKgjHbNt2t3rOTh6pjeWG7t44IJRY4Dq7GiqK4t+IgKJ5RutwvYqfxtPgYk9BRwwGHAcqR2lecO5HCdPJ3MqogT3z/bV0Ye9D5MKwadzktTos+0GrqxAyyXOSLRFzYAzgAIOJRXEGHgGrhixFpEpadwyYyUsmgW3KUKCVygYNNYROUhs2Z69jcsNV5xf3VcGIthA9Lkiz0+gx4VPv2tjO/1DUFXuKbcx+FjkUbgxf47Y/fRrTpHaMf4SQZvGP8tOCex6+sJQM1/W4lNUQRHbeCIC17prCFoS3yFR+oFwO+OXC3njIlw6vsIJUP8AwiC9ICpKWaixaRyXC0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF926E124EB60348B339920DF2A33897@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e45a11-0c49-4599-f586-08d5fd04f9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2018 08:00:15.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTA3IGF0IDIxOjAxICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDA2LjA4LjIwMTggMjE6MzEsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToNCj4gPiBUaGUgbGNk
aWYgYmxvY2sgaXMgb25seSBwb3dlcmVkIG9uIHdoZW4gZGlzcGxheSBpcyBhY3RpdmUgc28gcGxh
bmUNCj4gPiB1cGRhdGVzIHdoZW4gbm90IGVuYWJsZWQgYXJlIG5vdCB2YWxpZC4gV3JpdGluZyB0
byBhbiB1bnBvd2VyZWQgSVAgYmxvY2sNCj4gPiBpcyBtb3N0bHkgaWdub3JlZCBidXQgY2FuIHRy
aWdnZXIgYnVzIGVycm9ycyBvbiBzb21lIGNoaXBzLg0KPiA+IA0KPiA+IFByZXZlbnQgdGhpcyBz
aXR1YXRpb24gYnkgc3dpdGNoaW5nIHRvIGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF90YWlsX3Jw
bQ0KPiA+IGFuZCBoYXZpbmcgdGhlIGRybSBjb3JlIGVuc3VyZSBhdG9taWNfcGxhbmVfdXBkYXRl
IGlzIG9ubHkgY2FsbGVkIHdoaWxlDQo+ID4gdGhlIGNydGMgaXMgYWN0aXZlLiBUaGlzIGF2b2lk
cyBoYXZpbmcgdG8ga2VlcCB0cmFjayBvZiAiZW5hYmxlZCIgYml0cw0KPiA+IGluc2lkZSB0aGUg
bXhzZmIgZHJpdmVyLg0KPiA+IA0KPiA+IFRoaXMgYWxzbyByZXF1aXJlcyBoYW5kbGluZyB0aGUg
dmJsYW5rIGV2ZW50IGZvciBkaXNhYmxlIGZyb20NCj4gPiB+fm14c2ZiX3BpcGVfdXBkYXRlfn4g
KipteHNmYl9waXBlX2Rpc2FibGUqKi4NCj4gDQo+IEhtLCBJIGRvbid0IHRoaW5rIHRoaXMgaXMg
YSBuZXcgcmVxdWlyZW1lbnQuIFNpbXBsZSBLTVMgSGVscGVyIFJlZmVyZW5jZQ0KPiBjbGVhcmx5
IHN0YXRlcyB0aGF0IGl0IHNob3VsZCBiZSBjYWxsZWQgZnJvbSB1cGRhdGUuDQo+IA0KPiBQcm9i
YWJseSB1c2luZyBkcm1fYXRvbWljX2hlbHBlcl9jb21taXRfdGFpbF9ycG0ganVzdCBleGFjZXJi
YXRlcyBhbg0KPiBpc3N1ZSB3aGljaCB3ZSBoYXZlbid0IHNlZW4gYmVmb3JlLi4uDQo+IA0KPiBT
aW5jZSBJIHRoaW5rIGl0IGlzIGEgZ2VuZXJhbCBmaXgsIEknZCByYXRoZXIgcHJlZmVyIGhhdmUg
aXQgaW4gYQ0KPiBzZXBhcmF0ZSBjb21taXQuDQoNCkkgd3JvdGUgdGhlIGNvbW1pdCBtZXNzYWdl
IHdyb25nLCB3aGF0IEkgbWVhbnQgaXMgdGhhdCBpdCByZXF1aXJlcw0KaGFuZGxpbmcgdGhlIHZi
bGFuayBldmVudCBmcm9tICpkaXNhYmxlKi4NCg0KU3dpdGNoaW5nIHRvIGF0b21pY19oZWxwZXJf
Y29tbWl0X3RhaWxfcnBtIG1lYW5zIGF0b21pY191cGRhdGUgaXMgbm8NCmxvbmdlciBjYWxsZWQg
d2hlbiAhc3RhdGUtPmFjdGl2ZSBzbyBub2JvZHkgZGlzcGF0Y2hlcyB0aGUgbGFzdCB2YmxhbmsN
CmV2ZW50IGZvciBkaXNhYmxpbmcgdGhlIGNydGMuIFRoaXMgY2F1c2VzIGEgd2FybmluZyBpbg0K
ZHJtX2F0b21pY19oZWxwZXJfY29tbWl0X2h3X2RvbmUgb24gZGlzYWJsZS4NCg0KTG9va2luZyB0
aHJvdWdoIHRoZSBkb2NzIHRoZXJlIHNlZW1zIHRvIGJlIGEgbG90IG9mIGNvbXBsZXhpdHkgYmVo
aW5kDQp2YmxhbmsgZXZlbnRzIHNvIG1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGluZy4=
