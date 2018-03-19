Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481198-2-953342501106014124
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
    t=1521481197; b=MhFP3U5LB7CEKsLL7E9iobhf68tIYKryZWTJraPMuo8xYNn
    CbkMHRMDyA52bfmmsW5k+qxL7KceO/n+RJ8wvJeXmNaS2WR2P2WtokevRmvgJorm
    SWUGdgS/TBpHC74MWJz667Xwauxeh2osuXNrLT5D9k3Z2HzaS9y/UkN1rt9G3u3I
    HbpyOr9Zi+zQWDoZTbwa5GPDgo5P8LB/PU/AiR12OelqvjM+6fAK1cbyrUAzpe1L
    x6mTUZt2nZFGgOYt8/FtiIYpqQz76iKIShXOoEntPwkozLmLjz5YAwKDf6YzPU10
    xAQDGsXAjpAvkeh5Wa9MUcxrdit6QVP/1WF4nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481197; bh=0qP3Xe
    v7y3RWnwOSUKVrCaK+CUCyYAIxf4+jRQKeUUc=; b=PbdsosB+ytc7o9qPgAo0M9
    VOhv/dzrmGbIbYfYd0YN6KyIOkR6uaxorvTM/sD+tiiHx6CtLiyIoalyo2OUOnLK
    KReDjanOWoIpZzyfd0T2L4I//nAKVQLx58ZSRJ9Bsrm+ma7iuNDEhS8rESDX9zqB
    n0S+opneAUkb0bEERbMpeDiLk4y8REXsMVL3ZY+UUbDBWZM+IKUK2zZ4gleytMBg
    fP2NXmliHk9443JJwH1PuxjCjAk2ldw8zlC2bLC+BzzuCsO5VEDmkDZUETasK8NS
    TkQWkSGrVa5Um5MlYvs+/R0Na74SrMyqFk2d4RZUB/N4bG2G3AW34Shve+Zokvzg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LTak2vcz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelgeehkeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LTak2vcz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelgeehkeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966003AbeCSRjl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:39:41 -0400
Received: from mail-by2nam01on0122.outbound.protection.outlook.com ([104.47.34.122]:13968
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965954AbeCSQGj (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Miquel Raynal <miquel.raynal@free-electrons.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 275/281] mtd: mtd_oobtest: Handle bitflips
 during reads
Thread-Topic: [PATCH AUTOSEL for 4.9 275/281] mtd: mtd_oobtest: Handle
 bitflips during reads
Thread-Index: AQHTv5vNUGU5866kpU+hJ8fnuAyKmw==
Date: Mon, 19 Mar 2018 16:03:21 +0000
Message-ID: <20180319155742.13731-275-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0728;7:DnX6xpYUd3f7MvtEFiioiF/y9gQs2nENLujboAo3MuKOufJV8K8kVVaeHc4sRCelCN+wqTgCOFmL6pf4auN5klUcxoLn6NVXfFrUQr5hYYfvY/qEza/d9Er/fKZx50nKoWLbtl41MyIQB5FkM3aL3CUYl/7YGJZit8S8Ijq4JgEZw5qpitBYIOXGHFre+yV4TpainlqIGKSy1yiY049bo8svyfl36nXKv6l4KL57xgXezxYHHZCwHDhJ64lVOnJR;20:vLQzZeJp8l+2s1LUnXkKwGlQuM6yutPoHOICqGLOidZ2CTjIvWWQ0zTHZQiKfm0sNviAHiITHOKUQJ9q71XlWMpf0SxcieRBZLUT09T7fyE7aTL8kQSBzLcWetseSjCzWb++Ok5wkIV7cAVf6Gaah/lPX3QDp8vu2EoyKocud7A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 669977c5-830f-4b53-681f-08d58db3639e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0728;
x-ms-traffictypediagnostic: DM5PR2101MB0728:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072816E9878C58B608980589FBD40@DM5PR2101MB0728.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0728;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0728;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(99286004)(478600001)(53936002)(107886003)(110136005)(86612001)(72206003)(97736004)(76176011)(316002)(3280700002)(5250100002)(2501003)(36756003)(2906002)(105586002)(1076002)(86362001)(14454004)(6436002)(54906003)(6512007)(6116002)(6486002)(106356001)(3846002)(22452003)(3660700001)(186003)(59450400001)(68736007)(66066001)(25786009)(102836004)(4326008)(10290500003)(26005)(6666003)(305945005)(2950100002)(7736002)(10090500001)(81156014)(81166006)(8676002)(6506007)(5660300001)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0728;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: p0wrwoHaZf3djdJyjcYyK26pJga4/xo+Fn2zVbqcDUfVQ6XWomaSaQ69E5wb1KypmY5QLGrjo4Ej6sGaHzai/+bkCmNvg6sdIdH6c8ux5oark8wkkmJDyLR/2nqQzEyjDxVVVuRc118rQFh94Jbx9VK+ROtmy4gydQ8iDhKytcq+USSG0TGKMiHwju9I9099yCE9UWvQPD9w7nsnoHPxdkJoesogqFfDllbpbofG1aJbmLS3b/bWI/DeP3ul1y3zcqXNFqVa0TB1PJs3HrkTMLJMqyg7e9VZmv6wnmHosnokaACOnkLpP0fLTbqVfHwDyiEkBuBHQaTVB0KVO3zmpQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669977c5-830f-4b53-681f-08d58db3639e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:03:21.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0728
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
