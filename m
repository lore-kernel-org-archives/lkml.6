Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237637-2-4405267090143911903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237636; b=OugtWqZqNfhLmzInbde8/83d8lLQwPHss9J4vy3ZyFQkNYrYx1
    3sZzgYNdQbH3ROMGC5OVYkvJRDPrwqOxmFC/dUp8sOFRs3DhCNGTS0Ecc1Zv8MuA
    El35iiJEnDXhRP9/Mx9UQ5kI9qzJHU7aeqn3No7/C4H6zlhOFgrRV+60v7LbSqWy
    VTAdoSNG5hZBWPdtYm2FVjuwcVcFTr5vAUrBtYBnMPVEgrLqBtX2E7sstlUU9lVB
    3LkMRw1ILlJaUlEImfxpgafG2EHsUtqj+M+Y1uKWTCPlFm8gkXc4hTb/pDPeUv+H
    UQ62dxxKfMc6c3JoXfZCIHHUeH0Yb7uS+b2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237636; bh=odByVvdXIe
    JQu/UqY99luvB2JOZIb8SSo6QBM8c9Pzg=; b=ty1zw2wBkg/b2l1AVmYkWYZpQQ
    2QQ8zuOd4Q5kdQSy5IC0zUJFClP3GRRXYdPMk2BPMNPxf15+ZC5wV9hgrHPUMATC
    EbO5SrlNhmsQOYTa9ZPPwsfCPL3A6SuIt/Z3Rmb3GOrF5rkmRRLrF1w0ISl4ERSt
    bRBHswbSi0zuNNziycNMC5p4rafu+8lH5iDT/IveoD3aZegJnnYpEY6oh3G8csFr
    TnWSoS4EnryT+PM0BQf+CwAc4qaT5Onh1vSp1usbcW9W9jlwIGL45Pqa6nyYNldm
    ACp0ca3mxOC2yeapeGH1lArSqWh0xgSOfab2sI7QIQtXCR49MvJmuDl5c3Hg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aSL1ION6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aSL1ION6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE9/Fey0wOdKm9hcED2mqVb54bP6nvwIPx+Q+a3wGCOYzM/MiFmYy2qR2lxKh96z6itnz49hP151E2bOl28f/ppiNZLxv26+CpJE6e/M4MH31Pw4F5BY
    ZBS0CoGG8nx+UdN3gmq31n0rBNXh/XhLxLjSqAsTquSHjGBfsNKc2mBWUyOSqjbk10eAeOCFHludcNGGVD/zr/8qQ9LJLr8JnA4ztdTgPJ1EIYAhqKDeQYcg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uP1ucDPQAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=-ITEmu96tX6iv3YGRBYA:9 a=wPNLvfGTeEIA:10 a=X3ieE3onHXUA:10
    a=9a9ggB8z3XFZH39hjkD6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbeDIAfe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:34 -0400
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:6896
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756562AbeDIAfR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Brian Norris <computersforpeace@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 030/162] mtd: handle partitioning on devices
 with 0 erasesize
Thread-Topic: [PATCH AUTOSEL for 4.4 030/162] mtd: handle partitioning on
 devices with 0 erasesize
Thread-Index: AQHTz5mf7dWBBTaUVk63GYeyUDAI7g==
Date: Mon, 9 Apr 2018 00:28:04 +0000
Message-ID: <20180409002738.163941-30-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:BMMWQwk12kFWNdtQbt9oXgoG2947emXovHh9ylsRP7aBMaqZgUYKdy2LcltEUk3/cnUoj62uhoU+6Env3MwsBF+7GMTRNIB1Qtsg5KWm2sFZ/zrmMyOGPLldnQMg6H6yBj0HiDhyT6oGgf5CMzW033MnXHQU+Y2pmJID3WuXJC5oNJIubIHX1VjlesXKO3AaknWmO4/i2NJ2Uphm0K51GEFgNuxiEa7IdjQhDzuLoILra2QQ0Oi0TTVmqhX9m2mO;20:yyNeFO6y+ulyrcYMpASuHgmrigXYXJwmXyHBdL6avRHflHcVyKL2TCxd4835GAGB4R0zHW4sAtIhuvzcflUcmzp1i44YFuhSiXIfD6z6gMumVTgik2FtkimwM5+A+XPwKxez300luVrA5TDknUqDAyqZlVu6o6vgoVrBA0/Xx90=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2897cdd-7004-41b6-8bf8-08d59db1c087
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725CA59C0F62364EA592D83FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(39060400002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 5DTI5YtzhWl6DDy4skWEqssC6TrGMD5q9kN2FP+1Npm6hHblUvTNqw4Bc5jMFnfUcbJYO7kYz7lnURLCNKTsL/EghBk4aF3ZztoWwaN+pzuod+tbQ4PbFbcEBY33c5aycy7Wpocn1X8GmF1qYsF/dezYVUbylpeQ1wlzFR2VwAWBlMC5kDh77zUhxdabslo624ZBVVKLgbjoDa76jG0cEn9VI5sQmCN6WTaEV5mpip0GLkwuEAoDaLaooH2FkDcljrk4SVDF1yhEfAH46+UQyO0AI+CnJaoGX8H+N7SoQgLMNB7jybyDSwPI5mCwjXO3iwG2z6r95Byd93KeujMIUs8d+2tbK9AgL6kVk9iT/0zei9Forjg3PRMIkpYmozrRlkbTwERC+U9Qpyd8IumO2gKDH/6txZuWqrET6fwmPs0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2897cdd-7004-41b6-8bf8-08d59db1c087
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:04.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

[ Upstream commit 1eeef2d7483a7e3f8d2dd2a5b9939b3b814dc549 ]

erasesize is meaningful for flash devices but for SRAM there is no
concept of an erase block so erasesize is set to 0. When partitioning
these devices instead of ensuring partitions fall on erasesize
boundaries we ensure they fall on writesize boundaries.

Helped-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/mtdpart.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index f8ba153f63bf..3b7ac1989f90 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -353,8 +353,12 @@ static struct mtd_part *allocate_partition(struct mtd_=
info *master,
 			const struct mtd_partition *part, int partno,
 			uint64_t cur_offset)
 {
+	int wr_alignment =3D (master->flags & MTD_NO_ERASE) ? master->writesize:
+							    master->erasesize;
 	struct mtd_part *slave;
+	u32 remainder;
 	char *name;
+	u64 tmp;
=20
 	/* allocate the partition structure */
 	slave =3D kzalloc(sizeof(*slave), GFP_KERNEL);
@@ -449,10 +453,11 @@ static struct mtd_part *allocate_partition(struct mtd=
_info *master,
 	if (slave->offset =3D=3D MTDPART_OFS_APPEND)
 		slave->offset =3D cur_offset;
 	if (slave->offset =3D=3D MTDPART_OFS_NXTBLK) {
+		tmp =3D cur_offset;
 		slave->offset =3D cur_offset;
-		if (mtd_mod_by_eb(cur_offset, master) !=3D 0) {
-			/* Round up to next erasesize */
-			slave->offset =3D (mtd_div_by_eb(cur_offset, master) + 1) * master->era=
sesize;
+		remainder =3D do_div(tmp, wr_alignment);
+		if (remainder) {
+			slave->offset +=3D wr_alignment - remainder;
 			printk(KERN_NOTICE "Moving partition %d: "
 			       "0x%012llx -> 0x%012llx\n", partno,
 			       (unsigned long long)cur_offset, (unsigned long long)slave->offse=
t);
@@ -517,19 +522,22 @@ static struct mtd_part *allocate_partition(struct mtd=
_info *master,
 		slave->mtd.erasesize =3D master->erasesize;
 	}
=20
-	if ((slave->mtd.flags & MTD_WRITEABLE) &&
-	    mtd_mod_by_eb(slave->offset, &slave->mtd)) {
+	tmp =3D slave->offset;
+	remainder =3D do_div(tmp, wr_alignment);
+	if ((slave->mtd.flags & MTD_WRITEABLE) && remainder) {
 		/* Doesn't start on a boundary of major erase size */
 		/* FIXME: Let it be writable if it is on a boundary of
 		 * _minor_ erase size though */
 		slave->mtd.flags &=3D ~MTD_WRITEABLE;
-		printk(KERN_WARNING"mtd: partition \"%s\" doesn't start on an erase bloc=
k boundary -- force read-only\n",
+		printk(KERN_WARNING"mtd: partition \"%s\" doesn't start on an erase/writ=
e block boundary -- force read-only\n",
 			part->name);
 	}
-	if ((slave->mtd.flags & MTD_WRITEABLE) &&
-	    mtd_mod_by_eb(slave->mtd.size, &slave->mtd)) {
+
+	tmp =3D slave->mtd.size;
+	remainder =3D do_div(tmp, wr_alignment);
+	if ((slave->mtd.flags & MTD_WRITEABLE) && remainder) {
 		slave->mtd.flags &=3D ~MTD_WRITEABLE;
-		printk(KERN_WARNING"mtd: partition \"%s\" doesn't end on an erase block =
-- force read-only\n",
+		printk(KERN_WARNING"mtd: partition \"%s\" doesn't end on an erase/write =
block -- force read-only\n",
 			part->name);
 	}
=20
--=20
2.15.1
