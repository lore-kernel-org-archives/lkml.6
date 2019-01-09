Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3593BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED51420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="AEEsKklV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfAIIkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:40:08 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:32372
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729852AbfAIIjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B4ieJwoPAJFbd1qkl5Bu8MaWRgqtrOLFoL+ZrWaGbI=;
 b=AEEsKklV+xwMpnHIsnennOuOyCevNkorfCjuGMtVif46ex8c3r0cqSSsBhtZpPlPZk/IUfv2zxFwz91vx+CQjS4YSKt6QhRK4Kz7/NgwrxaWJiVyW+mBi00LBWhnfxScbAnKD9qOOBtj9bf6CDpRz91Ib59BNOwHZOgjVKV3wQQ=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3780.eurprd04.prod.outlook.com (52.133.39.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 08:39:42 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 08:39:42 +0000
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
Subject: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgMS80XSBkdC1iaW5kaW5nczogZGlzcGxheTog?=
 =?utf-8?B?c3NkMTMwN2ZiOiBSZW1vdmUgcmVzZXQtYWN0aXZlLWxvdyBmcm9tIGV4YW1w?=
 =?utf-8?Q?les?=
Thread-Topic: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgMS80XSBkdC1iaW5kaW5nczogZGlzcGxheTog?=
 =?utf-8?B?c3NkMTMwN2ZiOiBSZW1vdmUgcmVzZXQtYWN0aXZlLWxvdyBmcm9tIGV4YW1w?=
 =?utf-8?Q?les?=
Thread-Index: AQHUp/bdjPljmMcHhEmWoWKyLx2qKg==
Date:   Wed, 9 Jan 2019 08:39:42 +0000
Message-ID: <1547023165-111798-2-git-send-email-michal.vokac@ysoft.com>
References: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3780;6:rI1bnynPAE3H/SS0Rv7zTLbx7OR2g9oKVTZhQO9rxuujmhHoHShQ3B9F9323y2CKSoOxHLMJXcbzQnWd6z6Pu9IR4GK1C2BsbG7FaVaresiyBeAf3CGtnqjootbBFiG7nWjSEWSmuGEwzqCdr2ShyDAhweUonnFqMpXIzLCCP2urfjqH71Ec23SIYnszMDXLVpc3QQKYcRDEDpbO8Ur+CdUvX6Lt42fLlMJ6VqDxdqf2IFBdfyj6ZopMU0wzlmhbtOkmAzLKYUE4PhY+X7mW1GJOdYD+JRyqJDFgJ8a+zJP6aWc5eDhoPq4WsiAAfLbacNIi5V/dMFbF9pbvgyOK3Yz6oynydUUqPNBx1Z7go5E55BalEa0oadpRJjOdekw1p1y6roVoM10JgvqUM1bEC2qFkDdaaUSSm3aw0JPpmldjf0YPifrd36FW0gaq9FpAC4ASOmibH/s/aJPW6jtPiA==;5:x8NKn5fLANBWjA9JNa/uN83iMGczZKtQDzVVKPmT3QEkA7uDAHzqmOUsPU2iwknqiL6n75nW4d3HBwuYvc/TU44GvmoiNFfpmegQzhoFE6leeitxKSEmH/+bmiBiCmUeb2xoJE3inBIMff0+6P0OOn9pi2uQ0y/wjkQNQECchEYqBfC36mdhC/b3G1Piz9rs7NIhDFFfpKzWinNokzk9XQ==;7:ZOkn0a+UZoPBNgKYVeW/YhdAKDtGN4Y3ixR0hPEhmEuyeimjeEAxHfYRLIafOT7i8PFpmrKsagc+QvW6/07DuuXa/xQ6L4RPEew+NIY8Q+3iRWEipo0GLkljW4q4PyK3GkLYLohLm6cwoT/R+dRMMA==
x-ms-office365-filtering-correlation-id: 5c26dd0c-3e31-43ed-f039-08d6760dff50
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3780;
x-ms-traffictypediagnostic: AM0PR0402MB3780:
x-microsoft-antispam-prvs: <AM0PR0402MB3780FC1626BEE2895D2E752F9E8B0@AM0PR0402MB3780.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3780;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3780;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39850400004)(199004)(189003)(53936002)(5660300001)(66066001)(8936002)(6512007)(72206003)(6916009)(25786009)(4326008)(256004)(36756003)(107886003)(106356001)(6116002)(14454004)(6436002)(105586002)(81156014)(81166006)(97736004)(486006)(6486002)(3846002)(50226002)(2906002)(305945005)(7736002)(86362001)(85182001)(11346002)(478600001)(446003)(476003)(2616005)(68736007)(6346003)(76176011)(102836004)(99286004)(386003)(6506007)(186003)(71190400001)(54906003)(71200400001)(316002)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3780;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2QVlfrmoDOiE8P81Kfota3MscchadjU4AM9MU9y5LoJwkJm9zLLc0qs+7pVjNL8Cut01HHfP3/oZrQ+tKovrvoxnuybifK44HCfFTrBibcJCnfrnLy6O3MYbt3h3UP1PiroLkD5xVbMHhHf8YzUlbUanpCVHdgLNMAMNPjE1pLo70Q6OoFuDG0jZvUxhDTF42EZ9HKJi95bzQJOfoQf/q3ZXAG34/cvD3IFXU2ciST1TxdqchkUbb3BWTd6jw7GA72TFYWy1pcRrMKN2jWdYdQHfKBRH2KTEiPWU+hX3nCYJY6ExIjZDW6wyUg1GwU6a
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9F7B441B015AE48B595B670E655EE13@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c26dd0c-3e31-43ed-f039-08d6760dff50
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 08:39:40.5900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlc2V0LWFjdGl2ZS1sb3cgcHJvcGVydHkgaGFzIGJlZW4gcmVtb3ZlZCBicm9tIHRoZSBi
aW5kaW5nIGEgd2hpbGUNCmFnby4gU28gcmVtb3ZlIGl0IGZyb20gdGhlIGV4YW1wbGVzIGFzIHdl
bGwuDQoNCkZpeGVzOiA1MTliNGRiICgiZmJkZXY6IHNzZDEzMDdmYjogUmVtb3ZlIHJlc2V0LWFj
dGl2ZS1sb3cgZnJvbSB0aGUgRFQgYmluZGluZyBkb2N1bWVudCIpDQpSZXZpZXdlZC1ieTogUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClJldmlld2VkLWJ5OiBBbGV4YW5kcmUgQmVsbG9u
aSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWwg
Vm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0tLQ0KQ2hhbmdlcyBpbiB2MiByZXNl
bmQ6DQogLSBBZGQgUi1ieSBmcm9tIEFsZXhhbmRyZS4NCg0KQ2hhbmdlcyBmcm9tIHYxOg0KIC0g
QWRkIFItYnkgZnJvbSBSb2INCg0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L3NzZDEzMDdmYi50eHQgfCAyIC0tDQogMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9zc2QxMzA3ZmIudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvc3NkMTMwN2ZiLnR4dA0KaW5kZXggMjA5ZDkzMS4uYjY3ZjhjYSAxMDA2NDQNCi0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3NzZDEzMDdmYi50eHQN
CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3NzZDEzMDdm
Yi50eHQNCkBAIC0zNiw3ICszNiw2IEBAIHNzZDEzMDc6IG9sZWRAM2Mgew0KICAgICAgICAgcmVn
ID0gPDB4M2M+Ow0KICAgICAgICAgcHdtcyA9IDwmcHdtIDQgMzAwMD47DQogICAgICAgICByZXNl
dC1ncGlvcyA9IDwmZ3BpbzIgNz47DQotICAgICAgICByZXNldC1hY3RpdmUtbG93Ow0KIH07DQog
DQogc3NkMTMwNjogb2xlZEAzYyB7DQpAQCAtNDQsNyArNDMsNiBAQCBzc2QxMzA2OiBvbGVkQDNj
IHsNCiAgICAgICAgIHJlZyA9IDwweDNjPjsNCiAgICAgICAgIHB3bXMgPSA8JnB3bSA0IDMwMDA+
Ow0KICAgICAgICAgcmVzZXQtZ3Bpb3MgPSA8JmdwaW8yIDc+Ow0KLSAgICAgICAgcmVzZXQtYWN0
aXZlLWxvdzsNCiAgICAgICAgIHNvbG9tb24sY29tLWxycmVtYXA7DQogICAgICAgICBzb2xvbW9u
LGNvbS1pbnZkaXI7DQogICAgICAgICBzb2xvbW9uLGNvbS1vZmZzZXQgPSA8MzI+Ow0KLS0gDQoy
LjEuNA0KDQo=
