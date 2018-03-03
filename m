Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520124323-2-1630827967348374690
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
    t=1520124322; b=N+PnZgtRMU+jgFR93HYGoysmQdz9wgHV49ZyDYsUGDHVnYJ
    3cpj5ebgpuFqEgITERVJrZTuZhMvPMflPwWyzw2HKA25Q+njebWJRrtp6ZYkDfKD
    1lqpcxiayYW3g5uiEb5l/wbBPDatgnwU1Orke6RCBii8Xnv4f4NWvlTyZmux3yzo
    EafBIvk6VJhcmA7RxGQq55MxVmOQFWbergTDPA9+8NC4IorrEanZGclDdXKXM5J2
    Nyav6Im2VTxESPowlETiEVnNKuN4P7wNaIJGnTzL9YKFqkh+CnD3q4H5VE/TD8Uh
    9xhoEdBwPVMczkdkm30Q1WO5KhNzD721eaffIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124322; bh=ovoQD9
    /QW0doRrTLBOgRWMqm/Qmw5OzHFgPfbhK0s2o=; b=ddvYbRAcmf1HqrJWLAvExY
    z3jIsZxb05MKSzzQofQiwNz9wr+acB1GHLGBiRvvvNGlH2grnDuXItoQF7cHdl0K
    C7+lr9pwiaaLOwyA7W7b0RHnA7073MZAATMk1+U+O6Z+urhIRyDEx5R9pWJ+gZof
    73UTrVAwCcPpd1aU9q0Ar35Wm46R2GmVZ1/H6zLDEYNugEUI+vbQsvGWeJW673m9
    xflUzMbA6OeR5yLWNoUpLEzu+hGwreRGSQ2qGSVA0nby3cpoT9wjet4yCJYskCI+
    0k7kzMkuT1CSfoY9XiAz1DpTF5SfJrbd8/IxmKpoaZpSJrq5IHSV4BcVNGE1aDng
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LIoHzMZb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LIoHzMZb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932614AbeCDApI (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:45:08 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932514AbeCCW0A (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 033/102] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Topic: [PATCH AUTOSEL for 4.15 033/102] mtd: nand: fix interpretation
 of NAND_CMD_NONE in nand_command[_lp]()
Thread-Index: AQHTsz5kU4LMLK3uu0SsP0m0JM1qyA==
Date: Sat, 3 Mar 2018 22:24:28 +0000
Message-ID: <20180303222318.26006-33-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:d83WhhFhviqgNEl5zThIWhDHdjZbRnTe26x5q+8R4r6ha+MBbHCNEzektvbQGa9Ic8vtGFdq7atTuRxtvUBLLmDY6zRTd9zhkdtV8fj3kDexda+90NsmfUftSk3JzA3sKNOmSOVSR+M1xATZ75mxH4HsCrc0mIsPLZav0MFHOM5iuYZcKMrCabmKNeFXV5HXO64RBP7GcGBpFAdt1qwS80p19ChDQeebQ5pziC03dIfCoDalgwBU4lm+wDF/5jWl
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20357e82-9b11-4318-c2da-08d58155bcec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB3539C4CC3A64B130FAF0C30FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(575784001)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: MS8aYqkVRW+d+Spc2pDboYoCz/nVhvHmG01/tAklbfnQXaKLmI8TRkXCeEt9/Pd/9AZnpggRSA82iB3ahfFF89AxwlBJjnvhG+BPJQpXcR0cirVT24gu6sd3hnLZ2AGeIPWvQwejmvp/Qj+y5b26heYmDdub5tZD9oq9i1oUBhA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20357e82-9b11-4318-c2da-08d58155bcec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:28.7596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
index 9c702b46c6ee..e38edfa766f2 100644
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
@@ -738,6 +739,7 @@ static void nand_command(struct mtd_info *mtd, unsigned=
 int command,
 	 */
 	switch (command) {
=20
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -831,7 +833,9 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
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
@@ -866,6 +870,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
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
