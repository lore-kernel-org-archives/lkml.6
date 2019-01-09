Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369B6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C7720821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="qiMLLyY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfAIIjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:39:45 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:32372
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729702AbfAIIjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9kND0CFfLkeBkj2WFbB7gCj32x+LPHHAYhRkxSQPQU=;
 b=qiMLLyY0aDugkiZbVRcLWJoomZ47890fuoAOqkMeoF3+95t7k4+lamtUydYMrU3IjubJTM9x2JH6E9UPyrhB6ZgPOQ2aSL/nQ9Ilosg0WyqKYYKEX58blwSj9FbMHuVIPC3JcU6UAa9v5VFAf0riMJYc48Zt6LXP4jsxt8BtpUA=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3780.eurprd04.prod.outlook.com (52.133.39.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 08:39:40 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 08:39:40 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgMC80XSBGaXggc3NkMTMwN2ZiIE9MRUQgZHJp?=
 =?utf-8?Q?ver_reset?=
Thread-Topic: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgMC80XSBGaXggc3NkMTMwN2ZiIE9MRUQgZHJp?=
 =?utf-8?Q?ver_reset?=
Thread-Index: AQHUp/bcEUgGv/u4CUGjK/vpxH7Dew==
Date:   Wed, 9 Jan 2019 08:39:40 +0000
Message-ID: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::35) To AM0PR0402MB3716.eurprd04.prod.outlook.com
 (2603:10a6:208:d::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3780;6:ACJn5p0TfTCBef8X11R97SASO5rBpt81YVYKF6HwmAkDTL27w6Djh0EVPROvIFPHgqm/3WuwX9wPayXeKgptrOtErH3w0dL7QC+iktci0+m5UgaEq1ABbwOQSJw77flpXauBPugcxLjDpS7KeRpdmN2TfQim+DJ5SqXj/nRUYT5CiUI9myhyw8Xm0Bx/6tXTdV/1xshk+1eAlSlFsyXwxyUjwYHBkS8L9xfl8q0n//lGcZsNj9e0aqL4PWYPQfeYo+3MPoProzaAb5krALTlFSOPpr7sGTzCV6t+Saxaj8nmb03MYnSAbAZCAxyaJTNqF8f960Qc/jTbW90v6bqzu7RaKZZYCtJ55f1n6E33LvojX6REic9hsjI5lUO0NO+M++GVgKPe2bsV8a3VzCCUeRcMCjG5BSLzHXwmDm6BQynLJQ9X84/BufeVvCSCCC7m6d4D46fME/fbAana7cuz4A==;5:p/D5d6xJcEVjJa2et4kz/rwbxX0E4ffPsMqAwQEnf7WOdXpg5kfyeYEgbbUEghK+JXorN5fNiD4COYzG+FEzjg86YLYIBRJ0kBmv8NzQhs2Bu+fl7qPYBvRspUduRiG1XgIwT+2tESBOmPL2XJa2efhgGX654rLfu6K97+HqpSMyUhLSqSmO3k3XDmaaGT5AWDvzIk++6NANZyF5nTQhwA==;7:Ne2utTKKA4mi4wMunPus5lf/7X29OEatctkvk8tL4uoDzXr6xE6Cn4sQuYoMd7eVGjB9lh9hDELPoFKB8D4r2bPEWrozqAxK75zgTWFA3NSi2NqCaP3wlGPfeG6+L3hgklgmEWCjTnq4J4/SNp6B5A==
x-ms-office365-filtering-correlation-id: 27a474f0-c206-4965-22b0-08d6760dfe41
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3780;
x-ms-traffictypediagnostic: AM0PR0402MB3780:
x-microsoft-antispam-prvs: <AM0PR0402MB37806C71AB3A752334653E1F9E8B0@AM0PR0402MB3780.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3780;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3780;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39850400004)(199004)(189003)(53754006)(53936002)(5660300001)(66066001)(966005)(8936002)(6512007)(6306002)(72206003)(6916009)(25786009)(4326008)(256004)(36756003)(107886003)(106356001)(6116002)(14454004)(6436002)(105586002)(81156014)(81166006)(97736004)(486006)(6486002)(3846002)(50226002)(2906002)(305945005)(7736002)(86362001)(85182001)(478600001)(476003)(2616005)(68736007)(6346003)(102836004)(99286004)(386003)(6506007)(186003)(71190400001)(54906003)(71200400001)(53546011)(316002)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3780;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h8xp84L2Tj9Tz58Mo0WuhCAgq+AuVw5EMzakv93QAhj93UfOtr/zQ5AZ8d4LUoa41n77SI7Jzuex6//ccw1xGQEXdbx2++wWH0/oly2tLui2r08qpjSkvEjTQR6tVvxX42E+HRGf5JMRoKLjfaeNKvs8z7HaxCKC1636PBqNfjz6Wjbhs26jCVBzaU6CGLcrd52cPr0ChgnLIbhwM4G7CJhRxkYG7UUsrSHb2jqSfGJ8iB8NNo1BroByt7PRKRIK3yrwDriluNC/C4T6pGJlLEv5MMTSRNhQNc4gyYAxPgvqLUUw2qgKBPlzJcIqVAzD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC3C0063FB6E0041AD5CD11815D0B8BE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a474f0-c206-4965-22b0-08d6760dfe41
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 08:39:38.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYWxsLA0KDQp0aGlzIGlzIG15IHRoaXJkIGF0dGVtcHQgdG8gZml4IHRoZSBzc2QxMzA3ZmIg
T0xFRCBkcml2ZXIgcmVzZXQuIEluIHRoZQ0Kc2Vjb25kIGF0dGVtcHQgWzFdIFJvYiBzdWdnZXN0
ZWQgdG8gdGFrZSBkaWZmZXJlbnQgYXByb2FjaC4gVGhhdCBpcyB0bw0KYXBwbHkgd2hhdCB3YXMg
b3JpZ2luYWx5IHBhcnQgb2YgdGhlIGZpcnN0IHJvdW5kIGFuZCBldmVudHVhbGx5IG1lcmdlZA0K
YnV0IHJldmVydGVkIGxhdGVyIG9uIFsyXVszXS4NCg0KVGhlIGxhc3QgcGF0Y2ggaW4gdGhpcyBz
ZXJpZXMgaXMgYSBmaXh1cCBmb3IgdGhlIHNpbmdsZSB1c2VyIChpbi10cmVlKQ0KdGhhdCB1c2Vz
IHRoaXMgT0xFRC4gUm9iIHN1Z2dlc3RlZCB0aGUgZml4dXAgbWF5IGFjdHVhbGx5IGJlIGFwcGxp
ZWQNCm9ubHkgYWZ0ZXIgc29tZW9uZSBjb21wbGFpbnMgdGhlaXIgZGlzcGxheSBicm9rZS4NCg0K
QW5kIGEgY29tbWVudCBmcm9tIEFsZXhhbmRyZSByZWdhcmRpbmcgdGhlIHN0YXR1cyBvZiB0aGUg
Q3J5c3RhbGZvbnR6DQpwbGF0Zm9ybToNCg0KT24gMjAuMTIuMjAxOCAxMzozNSwgQWxleGFuZHJl
IEJlbGxvbmkgd3JvdGU6DQo+IEhvbmVzdGx5LCB0aGUgcGxhdGZvcm0gaGFzIGJlZW4gZGlzY29u
dGludWVkIGFuZCBJIGRvbid0IHJlYWxseSB0aGluaw0KPiBpdCBpcyB3b3J0aCBoYXZpbmcgdGhh
dCBmaXh1cCBpbiB0aGUgdHJlZSBmb3JldmVyLg0KDQpUaGFuayB5b3UsDQpNaWNoYWwNCg0KWzFd
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA2NjU1OTcvIzIyMzI3MjI3DQpb
Ml0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDYxNzcyOS8NClszXSBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEwNjE3NzMxLyMyMjI1NzE3NQ0KDQpNaWNo
YWwgVm9rw6HEjSAoNCk6DQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBzc2QxMzA3ZmI6IFJlbW92
ZSByZXNldC1hY3RpdmUtbG93IGZyb20gZXhhbXBsZXMNCiAgdmlkZW86IHNzZDEzMDdmYjogRG8g
bm90IGhhcmQgY29kZSBhY3RpdmUtbG93IHJlc2V0IHNlcXVlbmNlDQogIEFSTTogZHRzOiBpbXgy
OC1jZmExMDAzNjogRml4IHRoZSByZXNldCBncGlvIHNpZ25hbCBwb2xhcml0eQ0KICBBUk06IG14
czogY2ZhMTAwMzY6IEZpeHVwIE9MRUQgZGlzcGxheSByZXNldCBwb2xhcml0eQ0KDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9zc2QxMzA3ZmIudHh0ICAgICAgfCAgMiAtDQogYXJj
aC9hcm0vYm9vdC9kdHMvaW14MjgtY2ZhMTAwMzYuZHRzICAgICAgICAgICAgICAgfCAgMyArLQ0K
IGFyY2gvYXJtL21hY2gtbXhzL21hY2gtbXhzLmMgICAgICAgICAgICAgICAgICAgICAgIHwgNDQg
KysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvdmlkZW8vZmJkZXYvc3NkMTMwN2ZiLmMg
ICAgICAgICAgICAgICAgICAgIHwgIDQgKy0NCiA0IGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xLjQNCg0K
