Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520118127-2-14293515832536843008
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
    t=1520118127; b=sdt0PLxz0LIwqLADkFXLlQfGN+p+Yvg9MVeiM+6WJQ3jfTG
    H23lZFM97CL1Zov3obgXE9CNEFcg59Ebti1jRG+qTpCbo+UliFC7FTfb26PP1CsL
    /ZVt4IprufZ5UE8JZPZHY5thcrTVFXPiIdodBWt8uPj2hFmABiDFEMFhgwUCfuKZ
    DYF4SpchBJstSF6iJq7dLZ90J7aD87pZle51qcLLNfJoMked+xrNwwei4dVTMICW
    sLsPqCI4Q3Bh2kuYohz720doFZkbx6pQacAx18AMmgipeJd+iXGw+dV+MEblx8Ch
    9NkYgto/hMeV0vTupLQTJv1j1tWDbwbFt82dm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118127; bh=0Ot0cz
    LW9REkyELrVhC96Y1w0+iNBZ1Yh373iKzWKHk=; b=T9+SbxMfnplx9FI2z8sxlV
    xFyf2JmmboUCwIJZYKyCFBfT4vpPmPSJLIk7qqEirF48HxFMepeOqeMD1JfJx3Bo
    rpwsLP8u+D83ja4jqda4Avka9REDFnzmMyqhcHPUDmkMWCfqGdSZt//Nj4mbAQAH
    CKKuzRYD3gTjG+B2OpQt4EqVXcRHJ6GLWjf9xKTb+4wtZQFatet8Zfuu6jApQ+Nv
    vsTbIYCQPnhQLZsmEb45VMtfn4c1KewDr539BHjRYVUxh2nQNintExuiqNrb+Omx
    OiJYf+Rz4BbvAZldLpsAmvwtTEzuhChJWmURAovOVpctWXkGpTTPcXttNevO5+lw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=le9EJ0qi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=le9EJ0qi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934500AbeCCWks (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:48 -0500
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:9680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933046AbeCCWkq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 092/115] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Topic: [PATCH AUTOSEL for 4.4 092/115] mtd: nand: fix interpretation of
 NAND_CMD_NONE in nand_command[_lp]()
Thread-Index: AQHTsz9odobplVk5AkentklOhsmXoQ==
Date: Sat, 3 Mar 2018 22:31:44 +0000
Message-ID: <20180303223010.27106-92-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:OTraSLsFsJVL+UCZ8ilQTwUatBfl90fHG6SFblMx6hXXZaPh/JvKeV813OgNzUs64eU9BNM7cSZgzfvkpQL9VUfqynYZ9IZBjKfE1H4FXFi+2Q2c1ZY/lXR0s8hKcgup9n7huQvhFYk/+qowL57PMw/fuuVDcmaJyclhCzghM1NZw5SJ2tAlztwVE8CmroD7QsAoJyo2UaLHB2FXNF2m4J6Lsdrcucac6vjh4lqDG3hcS7OTlUjRwgdyMWe5m6PF
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91104ef6-d4e5-4acc-cb07-08d58157cc30
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09394BC94C2B65E61F243279FBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(575784001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cUBroAtVsEUIOeP9Fh+ddiqjy10NKflEUZsqDBqRrya3l/NjBfPwUyUMckh7KDDy3hyOCsfkks7I428mEx90HphAf7c8AdU9SQbw3nrK6qFIu3xznW3kvkYKtyoN4TxYYt+472GAriqSnvuOXGdaUwCGXWQKcsWMtRpts2AKeXw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91104ef6-d4e5-4acc-cb07-08d58157cc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:44.5270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index 27864c0863ef..8406f346b0be 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -626,7 +626,8 @@ static void nand_command(struct mtd_info *mtd, unsigned=
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
@@ -655,6 +656,7 @@ static void nand_command(struct mtd_info *mtd, unsigned=
 int command,
 	 */
 	switch (command) {
=20
+	case NAND_CMD_NONE:
 	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
@@ -717,7 +719,9 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
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
@@ -750,6 +754,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsig=
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
