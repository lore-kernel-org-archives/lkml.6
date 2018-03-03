Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116147-2-2780093550589453839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116146; b=snsJ74W3KAWUekXDKgcm4h7M4tB3ch+sunf4dXJd6pdHy0l
    Xy0ikEHfW3xzZu9Pe4brheKY7M5TMus1F1GEP9717l8Ks9BC19X6B/7yHU5CCUeL
    K2W+W/oFziSl6cOTwMICQBlZN3gaDKz6FKcRspo+KmUl4q83jeM83CQdbB1sJKF/
    +9eoZQ1Dy4GmN34ZbfIX5xwcHjEq0wfyvyko5TGfuCObalHeu1+8dQmkqsV2dAqR
    YforqeLVkZQDYABtCx7Tiio279HZXLrmb1ppU4GkjriP9J7u1UcRxm3nUDuySpY6
    GcbZzsB3C72QjdWMlDaH1DyCOQCjeH4uPI/1h2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116146; bh=ORkdKu
    NUEK0jyiV7drp4Q7cBhzOsQml9cKzHcVhzuMo=; b=MOoUFyPtFIpj7OuVms5Pia
    6R9UoMQt7uWK32YD3hf1dU6WJH0gEnhCxxqJJncw8KUwo/HCCzrj7AZb6LmEwg/Z
    6rS8wCQRMclu87ddPKUe7zX8ZIBUFvtwLg/+JcF6Gv+bf6pfOlMUW5f+Kj4IlSyp
    Y/KgoxUw+OE9bl2QXQHzpYxpZJt3mRl7dcONEW8ey0OTAkjQHYDvBBIJ3khJscVn
    Va0Q/pXXbGKaGvFCz7hBJAI+RCwC9NafoKj/qXGqWFdS+5K2FWzL6r/qXoVk3kGN
    OubHCoesXpsNREagENtBw+Log0JBFzNq52G4arLk00eLcIShu8h7xdE4dIqzEl4A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o6WrzNuh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o6WrzNuh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeCCW2W (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:28:22 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933196AbeCCW2U (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 23/84] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Topic: [PATCH AUTOSEL for 4.14 23/84] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Index: AQHTsz6jVlwXAsYEiUaQOnhLPwB2xg==
Date: Sat, 3 Mar 2018 22:26:13 +0000
Message-ID: <20180303222518.26271-23-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:AjtGVxSdo4VbmZImaj4ovvOpEgmJm1u1RjVTWya4WbSvpGXtXmagdsYC4+oE9PDohyEZVHOJRTXN78cFzyZKDDQnVAc0uL5TZYiJIURS5awEwrWpjqWMKfARVibR1rYhTAe41CRJKn0BAQ1NKRis2EKVwu5cD22JG/XwdZztYqsfexzGdwGQqyPvC/Lvnv6oZyZL94+KXHGxAR8Z4TBxnx4UExywgqcK2r0Ob9wcxTcFUqxW/SCoVm3bF3vWqPVO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 08bac943-414c-4f51-7ce1-08d581561042
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115DB6CFA6A042E9F472C5AFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qMhQzpdoNMT9DlJL0WBfPZesknJLW/4l6GItOjWzkUSPgmaECZd3SvRTYyYDvkgLbLo93hJ+Ioh1ZdmyNfhUUl/UDAys9jBewm8rVWgW5xgwRlgbkiEKbO2OJJSPrZGDm2Z7azuvEcGueYOmvz9SH7mDqSPONOCclMg7EXCfzII=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bac943-414c-4f51-7ce1-08d581561042
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:13.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Miquel Raynal <miquel.raynal@free-electrons.com>

[ Upstream commit df467899da0b71465760b4e35127bce837244eee ]

Some drivers (like nand_hynix.c) call ->cmdfunc() with NAND_CMD_NONE
and a column address and expect the controller to only send address
cycles. Right now, the default ->cmdfunc() implementations provided by
the core do not filter out the command cycle in this case and forwards
the request to the controller driver through the ->cmd_ctrl() method.
The thing is, NAND controller drivers can get this wrong and send a
command cycle with a NAND_CMD_NONE opcode and since NAND_CMD_NONE is
-1, and the command field is usually casted to an u8, we end up sending
the 0xFF command which is actually a RESET operation.

Add conditions in nand_command[_lp]() functions to sending the initial
command cycle when command =3D=3D NAND_CMD_NONE.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/nand_base.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index a0b0302aea14..528e04f96c13 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -710,7 +710,8 @@ static void nand_command(struct mtd_info *mtd, unsigned=
 int command,
 		chip->cmd_ctrl(mtd, readcmd, ctrl);
 		ctrl &=3D ~NAND_CTRL_CHANGE;
 	}
-	chip->cmd_ctrl(mtd, command, ctrl);
+	if (command !=3D NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command, ctrl);
=20
 	/* Address cycle, when necessary */
 	ctrl =3D NAND_CTRL_ALE | NAND_CTRL_CHANGE;
@@ -739,6 +740,7 @@ static void nand_command(struct mtd_info *mtd, unsigned=
 int command,
 	 */
 	switch (command) {
=20
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -832,7 +834,9 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
ned int command,
 	}
=20
 	/* Command latch cycle */
-	chip->cmd_ctrl(mtd, command, NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
+	if (command !=3D NAND_CMD_NONE)
+		chip->cmd_ctrl(mtd, command,
+			       NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
=20
 	if (column !=3D -1 || page_addr !=3D -1) {
 		int ctrl =3D NAND_CTRL_CHANGE | NAND_NCE | NAND_ALE;
@@ -868,6 +872,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
ned int command,
 	 */
 	switch (command) {
=20
+	case NAND_CMD_NONE:
 	case NAND_CMD_CACHEDPROG:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
--=20
2.14.1
