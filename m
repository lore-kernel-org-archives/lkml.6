Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117239-2-16802073586392433485
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
    t=1520117238; b=mv1ycl/kgQlcfGQM3GUAuP8x6T2N++G1ILa6T5zmNcLFDAT
    8NrCvevZnpiXru6S563rB4x6bsPqvaTPgDykJ5kr7kNp3iy5kvCm2yELHQ8J9zNS
    HE8EZ7nYVBoIAplEoHYDCb9rajlwi++8moOzlluZa2GURLodzR4GAg/+tRau/Eov
    gVisdRWBfLI+B1sMpE6J8SyU40iAcsG/KujI8G2kzg/oi/PBZ7PHX/i5a6QLGAOA
    PNJfz4K2/f81rHkpJhTujQ5B7Kj9+NAYVWGtaiibwS7sS+f5tQ3bbphanttLJVyk
    G2dFA6atjBcQXPwoONQuIzvc9K5z7KD9F4HSWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117238; bh=sKQwVa
    HH5sfWm361127pq7/EtJo/8vu1EK0uocG88aE=; b=I6CHB8AzHr+rvnAcrU6uCw
    kBtJ8GnG4Nky2euf3ULagF1cZzSLClOq5ngYn2a/dgFHjYn+IAEWSvzBp5fE4IO9
    bm4PF0Wc7MhaODUgaZm+PiNPyYxe7zuN8PAHEtptKEhWFR4Q0W3+H60huFJzbK4+
    fkKFbQXBNfMcKTCOe8F8a8YY9gu1hBYo/vOmJ4IwZFyh9Uwl9dc1sDvaTxRUGc9f
    9Ywm0PPYI6r1aENXpRYPwXVxkHpIQxCsSFb/EGCqGfKjoz/ppTYqbDu+ymJuLwX2
    M1eNTQQ9PWdjprsEEW4pys2hL8aERoF0yH3uHbJoIS0xI2CSouzjgYJfezOtv9yQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DmevBO6t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DmevBO6t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935573AbeCCWp1 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:45:27 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:59904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935036AbeCCWl6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 50/63] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Topic: [PATCH AUTOSEL for 3.18 50/63] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Index: AQHTsz+uIfhimiHhFEiSgvoLil17pQ==
Date: Sat, 3 Mar 2018 22:33:40 +0000
Message-ID: <20180303223228.27323-50-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:7QODRnTE8gI53BR3A83I1KP8roJPv7Wy5bkCecwDQH1VLG50WG6QZ29VG2e+u+FQ84CKLWo+xwoiK1aXM0VJPQswJkA5+2y7xX95Z7TpRSaTSK7SX+UgGT/v4FcSe3feN0itCDreusxG4g375l+Zn/BMSDrC5+foZvW4brF3rsbvksddFABKZwEh++O1oU/TOqfctuTBNxMew5nSDsPKELwEruX+0ziCKZn9SuW5A4nsA9iR8MYEnElBIvEsHeiU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acf68a6b-36f2-4519-1fcb-08d58157f784
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB10184AB94082B92F06FF35FDFBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(575784001)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 1wmFf+L1BYt48SP+6qtf5c6Nv7+lc90YFUZCx7Jr2OiRMvIb5HF9Oey5M0iGn2C1xPqqZyeeLEA3zrx7qx/M4rFhW+SkhUK8bnIidQULpNx8QR8q+eOehJyLx6/T0ntPInKHfhHtceVoCos9tdAZfgDC6LLWTza2DhxedqdQ7zE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf68a6b-36f2-4519-1fcb-08d58157f784
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:40.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index 7eddb1e95de3..c8f20467ff1d 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -600,7 +600,8 @@ static void nand_command(struct mtd_info *mtd, unsigned=
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
@@ -629,6 +630,7 @@ static void nand_command(struct mtd_info *mtd, unsigned=
 int command,
 	 */
 	switch (command) {
=20
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -691,7 +693,9 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
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
@@ -724,6 +728,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
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
