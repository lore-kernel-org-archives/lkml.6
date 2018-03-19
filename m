Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475046-2-17302494711950807393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475046; b=GS3HJ730lEYbj2YvHf1OU++bhuh83kvyND2quHqp6sYtuar
    rBfGOy8EEp4tOLFNvBLzywCyIHpt6LGjbJc/rasXx71YZieC4XrQ7N/C5QHkSSeX
    XBW1xhpMg+0m3NKCsX9Cw9HK93N777yMWllcUoOLzz7v4HkIA45fUCDcz2ozLuIf
    y44y02NVqZnlFRYlg9bTwx0KyYUi4EVIt3knMQkrcQ6mZcjYJeSQqUohmiv2o3Cy
    Bzosa2wWC0+j6RUWazcPd4/0vqTBdes9xHLPCb3932ime72b4C7G0dAjaG68WekE
    IEFoArWHHZcLTATU1MZ2Y1wmjhI9J/zjDbIsXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475046; bh=0qP3Xe
    v7y3RWnwOSUKVrCaK+CUCyYAIxf4+jRQKeUUc=; b=LnujVyx5UrNGhBvysjMmlb
    QFZZzHnkGtCyGRYiZdJXaVV6TIxgeQbkRptjNroxivIKEhiT0rhj9w8aki+hFXoV
    ryEZnAFhcMYuh+1vXCmo3Rdr5mQOjwZcfcOF379aa3A1m/Yc7KuWsdqScGeZbLgH
    MWhKW4jJQxL3YqXZyCgbOTlpUWn9RLey5t7uu8PCvbfl7GLJDdN3E7mCymp8M5jr
    gIMgmm1ZNPMSpkIPCFdHHujEjPubYxltWe5qsZs3HUijIxikSdcLKkgBXzx5NauB
    E7QAmmGkRQp3IjKbomDWClwcQAZK1lEGUrugn/glin4b44YuvOD9W1ll2ptw3Efg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cwIAc+Gq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleegheegnecuvehluhhsthgvrhfuihiivgepudduke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cwIAc+Gq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleegheegnecuvehluhhsthgvrhfuihiivgepudduke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964820AbeCSP5V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:57:21 -0400
Received: from mail-sn1nam01on0113.outbound.protection.outlook.com ([104.47.32.113]:22624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933487AbeCSP4w (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 87/97] mtd: mtd_oobtest: Handle bitflips
 during reads
Thread-Topic: [PATCH AUTOSEL for 4.14 87/97] mtd: mtd_oobtest: Handle bitflips
 during reads
Thread-Index: AQHTv5rWRHeVrVqHx0GjnuIDNV179A==
Date: Mon, 19 Mar 2018 15:56:26 +0000
Message-ID: <20180319155411.12348-87-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1064;7:q0zVoHXunxIs1TEq1b84Cq1Qo7/1ddH/yuW1Hlo7Bkkv49e1PziKJYa2/APWicZ3yGVmU1zeG7q47zhKnBao3QghUWM00THrNMfdPhvqIRGDHomRh1Cdn0c3MOe6EVIEGzA1axMg0xLCNN4rl4+3R7ILetd0BJn9q6Fgr9iVKiOwBAwXYaHcV07+NX97LfYNtfup7j3kGJC7jGzAbbx73QGP6RLN+8REptkyxjTHukOtYVZpMp1+ODltaKVy4qFI;20:xHH6HSYlou9AQUk1gNDnQRPuDFR0o+nQ0S4oCdgceKqtxi20t2MEL/2bhEQ3jAudbMEb94lKjSLEX4yxrYYmMmIb/7CdheZf+9D2/m0M0Pzk+5wGEt8hydunG8zemGJ0TZpIbpEqdggjJspRg9o1LKkZR1QjVeuV9ASmpXjCcA4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7237ce3-e7e8-4964-2d01-08d58db20346
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1064;
x-ms-traffictypediagnostic: DM5PR2101MB1064:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10645F70DAE3CF30F62D328AFBD40@DM5PR2101MB1064.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1064;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1064;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1064;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6f9dVQSoIq1yoCxN7xFSbxFv4hr5Uj01varw5jtzn+qmOwzbUE+8eEWnwgjCAsAao+Sd7yHogxeKf+dVyjiF31RbeBis89PHejOtEvDHc3o2y5wpttobpMRf7G/d8Q995Zp61XJh/yejO6N/O/9n2SPrAYRLIoaJrFcb7Bm7yRFt+bP2CGiud5rPqGG5cA2YdkaO47cZmaVYwRiQK/qwlHZS2AegDffYhdmK8kUVB7Tlc5EVpCWGU9YKkTJud3RwFp7Kys+p9m5GVjYPga/VzTIc+t0Q3/ygjSCPiRXOeJqOEKaRlNupFGyRleLIiSy1Qnz7shmCGcgwMBcPAH/w4g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7237ce3-e7e8-4964-2d01-08d58db20346
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:56:26.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1064
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Miquel Raynal <miquel.raynal@free-electrons.com>

[ Upstream commit 12663b442e5ac5aa3d6097cd3f287c71ba46d26e ]

Reads from NAND devices usually trigger bitflips, this is an expected
behavior. While bitflips are under a given threshold, the MTD core
returns 0. However, when the number of corrected bitflips is above this
same threshold, -EUCLEAN is returned to inform the upper layer that this
block is slightly dying and soon the ECC engine will be overtaken so
actions should be taken to move the data out of it.

This particular condition should not be treated like an error and the
test should continue.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/tests/oobtest.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
index 1cb3f7758fb6..766b2c385682 100644
--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -193,6 +193,9 @@ static int verify_eraseblock(int ebnum)
 		ops.datbuf    =3D NULL;
 		ops.oobbuf    =3D readbuf;
 		err =3D mtd_read_oob(mtd, addr, &ops);
+		if (mtd_is_bitflip(err))
+			err =3D 0;
+
 		if (err || ops.oobretlen !=3D use_len) {
 			pr_err("error: readoob failed at %#llx\n",
 			       (long long)addr);
@@ -227,6 +230,9 @@ static int verify_eraseblock(int ebnum)
 			ops.datbuf    =3D NULL;
 			ops.oobbuf    =3D readbuf;
 			err =3D mtd_read_oob(mtd, addr, &ops);
+			if (mtd_is_bitflip(err))
+				err =3D 0;
+
 			if (err || ops.oobretlen !=3D mtd->oobavail) {
 				pr_err("error: readoob failed at %#llx\n",
 						(long long)addr);
@@ -286,6 +292,9 @@ static int verify_eraseblock_in_one_go(int ebnum)
=20
 	/* read entire block's OOB at one go */
 	err =3D mtd_read_oob(mtd, addr, &ops);
+	if (mtd_is_bitflip(err))
+		err =3D 0;
+
 	if (err || ops.oobretlen !=3D len) {
 		pr_err("error: readoob failed at %#llx\n",
 		       (long long)addr);
@@ -527,6 +536,9 @@ static int __init mtd_oobtest_init(void)
 	pr_info("attempting to start read past end of OOB\n");
 	pr_info("an error is expected...\n");
 	err =3D mtd_read_oob(mtd, addr0, &ops);
+	if (mtd_is_bitflip(err))
+		err =3D 0;
+
 	if (err) {
 		pr_info("error occurred as expected\n");
 		err =3D 0;
@@ -571,6 +583,9 @@ static int __init mtd_oobtest_init(void)
 		pr_info("attempting to read past end of device\n");
 		pr_info("an error is expected...\n");
 		err =3D mtd_read_oob(mtd, mtd->size - mtd->writesize, &ops);
+		if (mtd_is_bitflip(err))
+			err =3D 0;
+
 		if (err) {
 			pr_info("error occurred as expected\n");
 			err =3D 0;
@@ -615,6 +630,9 @@ static int __init mtd_oobtest_init(void)
 		pr_info("attempting to read past end of device\n");
 		pr_info("an error is expected...\n");
 		err =3D mtd_read_oob(mtd, mtd->size - mtd->writesize, &ops);
+		if (mtd_is_bitflip(err))
+			err =3D 0;
+
 		if (err) {
 			pr_info("error occurred as expected\n");
 			err =3D 0;
@@ -684,6 +702,9 @@ static int __init mtd_oobtest_init(void)
 		ops.datbuf    =3D NULL;
 		ops.oobbuf    =3D readbuf;
 		err =3D mtd_read_oob(mtd, addr, &ops);
+		if (mtd_is_bitflip(err))
+			err =3D 0;
+
 		if (err)
 			goto out;
 		if (memcmpshow(addr, readbuf, writebuf,
--=20
2.14.1
