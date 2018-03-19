Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474809-2-15503639212697689924
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
    t=1521474808; b=jrG7L3cHVKFetm/Rx8hzewdWVcTwZ3EJQp3QbKzWTmEw/eh
    VYEKtUJ+prhzat36khxUEsZsYiMHw4SVtj+NZ+f89zCCJFm0ciMNKIrqi+tq/nOB
    ESGLZVh5TeUx06Pg1cwfZs5u6MTdCUflCaDxS6FSVq+rsSwvkeUQWSv6Qu1gk2ZS
    UuVMvpcTzfFRwjCjfyzFpCPipm1+L+SaJkJQL0ZPfnu1NcQy4BsH3GRnqvQ1uTRU
    0ThNhWonoG2vpcoR9k5PxhjKmd5y3jrxTI33cVmq6yIFfGjjOmNmCXf80XmVysOR
    msVpytX7CFKG7H7t/TFCoGSxvNOVtxMubsa7y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521474808; bh=0qP3Xe
    v7y3RWnwOSUKVrCaK+CUCyYAIxf4+jRQKeUUc=; b=cHVcSJe8YBeSZqJe1qVmLC
    eAzYLtpUHU3TQvjH0uitmun7RSuiM7pA7TgqaqOJU7CSUjAMTNRxIAqwOLFwGZiA
    zirZL02tlT2swRQcinBP5HqGWGa2Tuw4zb0TTmcDGfFdOb2RarRd6Otx+rRS9b3o
    DSLN3JlUTigr1mg0EltwYCzHOshqXPu19QreQehCJiQC+gx8XnZy23z7R8fJk53O
    z5C4rs6f599Ti/ihP0CnrhxHrUmA4BzJ2PUhqA4hwJGJSxQz54QRHdUSmCCyCohI
    1BckQ7A8umAXzRBIVU8aiTm6h1DTcOAr2SNU7yNZglq/Xhz+r2SNd3eFeeLQClzA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C1uM3KKF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeggeelnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C1uM3KKF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleeggeelnecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934025AbeCSPxZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:53:25 -0400
Received: from mail-bl2nam02on0111.outbound.protection.outlook.com ([104.47.38.111]:9280
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934065AbeCSPuO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 114/124] mtd: mtd_oobtest: Handle bitflips
 during reads
Thread-Topic: [PATCH AUTOSEL for 4.15 114/124] mtd: mtd_oobtest: Handle
 bitflips during reads
Thread-Index: AQHTv5nRZ5xyZs8It0u43n+JL+NAhw==
Date: Mon, 19 Mar 2018 15:49:09 +0000
Message-ID: <20180319154645.11350-114-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:WobBDMKdQzzIcyWwWthQnaalPl+RtymWeVAguxPbOcKMYfvKx9muwBGEzFircDLlw0JS2s0n5PUhRspswKmGo4oCmk2q2Zxrkh2eZIlhWyF1FctnPKNQAEM3oWrwojwJV26wXmHG9cJQYglSxRIUvpgytIekSc0IwmXZqR5ef5NAlBq13iJUdtCtK8fwKD6L9J+kbcW5ctHoBiKPYFXLQPCwHCNreQVNd9gX6E9CytybhdwynLPrZiM5hYGrrQog;20:bMp0osOENJ6ShA/n2Pa5VI/NPFaAcuT7eXr1p7OKzWDQ7taEblMBb2SIG2//8owitus4LUHoAfxDku6uHS7BjBBW7hPIETqaADAmVhuRnHS20bqDKqksWydZKN4e+astE92xj2cSDRDhCeijfj+4KcKTzUqK7yPmy0TURYJZ/8o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad74f29a-ae06-4163-c6b9-08d58db11266
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109E34852FD06247B720ECEFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NIymHPpi9RDUPOqG2lKBtXsVt46NGNQNJyuJdkY4A351qumNFzT5tcuWABGxSe4SQotNw8drTwAN6LCDjwo23Flc12lwoSYQ+vETqYF1DHMg617smzRQGsTviLeBfOTN2mNllh4dXemaRLWJW9+8Q3XMpuchtnThwdlVZS1JGfucmwmsjK5lxVMH7m0hHLo/Bz5arW8Oc3KJEbYelb0XSxxrThdxTYCNW69yv6WSrFSfJHSOmkck8RNZ5LVwAh20pRci4vX2JT4yecSEAVdqbemPqSqTHadAqqjmtJWhO7xCk20LD2c/6niMvdLn4mudRW1xfm6Ka3DsayWF50wdIA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad74f29a-ae06-4163-c6b9-08d58db11266
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:09.2891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
