Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119826-2-5574489794488149135
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
    t=1520119825; b=M2ISXTBo5HlL46rCDRuvkaWTSKJI3/OUFaZd8HczXBaOtfR
    si40xVzfNwkGVGNmHJaI7kMajz/2Rd2OLqBqhZlaGGZE9cARcLGwXWSaeGXxEMox
    90ytibPZN5PF9x7uOnUvy+yg9gllQxRG/pSjf2zI2yo66aTabf1Y82Izi6nEnmmu
    Ec3+9i/Vld0RDFs5WU032wUDa+Vq+QulTWPDbxqLkL5qDTvFmNt2xlm1Yur6WfQs
    VB0MfqqKvlmc2vMXh2dCttCCMS3qO9eM6WV+c+QwXBiHvR1rz13iQ5DpHeZQPhE9
    EYUX2fOU3fXdy1WvHHKug+e3pp+EC/kWcCef9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119825; bh=6os3/k
    dhNCPiDOGQRrN1xMQltF53/X+OsvET9/NhQBQ=; b=OfkVcYj3djalmSCXfebiI7
    NNLsm8BkwW8gLZeujOE+RA+N5NGnNaD6Nn/Rg0+XQxv0XvC7ZzPmgDk9zwDddt01
    dBwRW6eSplhfb/uDGA+2p0MbYJLqVX+jEldinR71AKh4qSq/NoJeuRN0HxNk7fnK
    pa1rcfq4f0UDtxW7hqQSqbIhH+utB+3uEk4o0r7qKgCTmo0sxzQ9iDJKBsO6V9NH
    Xu7GO3AfZVoGT7c4e/tVHhg+9FVlNjk4axLkmM5yteWF8rydcDo25JG9Pxvs7rN9
    zWme51s3dqpCgHJkkxWwRaEua4bNmrI+8uVOsKuX+pEO1zw8WV7/0zQ9aFECDD8g
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XLHTH3lj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XLHTH3lj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeCCXaG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:30:06 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933659AbeCCWgo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:44 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 183/219] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Topic: [PATCH AUTOSEL for 4.9 183/219] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Index: AQHTsz8gse7VvqyFcUmTWkuc7b0FYg==
Date: Sat, 3 Mar 2018 22:29:43 +0000
Message-ID: <20180303222716.26640-183-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;7:0VJCxQPdo4ag1OMYfLTYEG7WUWlcCd7baSXD7awT7Bwi+z2tbDw2tBV3DPJ1NM4/Smr1vxRcBvopvJG71jKaIs3p0qVZdzlMoigGvUUcw98GUwP69gPo9eMLa+xJvThHwi6kn6+H3UHZtGS+0eMWY02C2F+fmf4L2dJFO1V6t8UA0t4Qo0J5dEM5OTxN4NzSb1Dr2Xd+j3pXkttiXditfqhydrt+XUQJz3ULXoKo0tRr9rKKPUnrwF49uCnB0LHa
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3282bf32-8d97-4577-7164-08d581573bf4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020951A74CEEB9911C750FBFBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: V5xHI7GBiJROOH0vFla8uYNUZv8ZaX0EOtTcPMo1ewUDDtI5LP1s6oDc9uuIg9FTbfcyePbi9GifuPnb5wMPu6VtskmthVeMl7fE2hCiitwOcgsXa94qHWG1Tp/7fym5N1fUh84TTa3987QMjH66HSyHegJ85in3qXBe3Msh9PE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3282bf32-8d97-4577-7164-08d581573bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:43.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
index 21c03086bb7f..a3e86e52640a 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -715,7 +715,8 @@ static void nand_command(struct mtd_info *mtd, unsigned=
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
@@ -744,6 +745,7 @@ static void nand_command(struct mtd_info *mtd, unsigned=
 int command,
 	 */
 	switch (command) {
=20
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -806,7 +808,9 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
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
@@ -842,6 +846,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
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
