Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241308-2-9782205753726819830
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
    1523241307; b=g/3o6gT4eD5aE3MedBHaxhyKLVvYJCVvVMx0MjX9yt/35R7Y6M
    Zl8uH8PSkb8CrKy3ip5/5guvN4fcS4bsGTxy1fNsHedTLtl+IP2Ji7hyfum4ht+y
    jmJGkec0ExDdKCRswXcUzyCY44+3tYJmLk4r/S/aIx5jBtayMj9RytMKTTPV78mV
    XfdY5OHUrigFy0LI/g5Rbg6aqTOC367AuT6F/vJsfiPf84yDxbGHc7gk6vDZN7h+
    ITloj1UAUYTtiqXd/GtMC2Fhl+HOpPZUSgHSFoMII4heXuK5t3vBiHWHNqbGwfXF
    MfmSnfalHEaLZR0FVyyPUqV+2Qdrvt51SYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241307; bh=2Ddgc3wv0B
    gA+4wZmJ///QfhkNnPL1cDaS0l1tmnLjc=; b=gfktVde/DPU9e4qtG81xBvbKT/
    6NcG4q7TMYBJbRtRhMSwbVltx/PYpXCJolLMlErLyXasOikJ84/t3YWDVrjnxed5
    4WeG2QqQNywWy8JjRlnW3ea4J0rycWlaijDB3cHDv579vccaRhpTpiO0kEp8IXQa
    OwooyQUCummOfrj3NoMVgDJiwmWrAcYjWXxXAPj0CcJQh6ss1u+BvDJ90SMehdKV
    NIbBcW1jrQ+kNrfFTXWQPxzRaIScGgd8lbdD1yZGMCsg1kuBh4lotb24PKufCMCW
    inxIIfW6sWfPEUAGAGVLJ6DcJq9l6Cxfiit3NTHm+aWSEQiWwfZ2EuS94nqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CsdG25qL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CsdG25qL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHgfyZBiWIL1hUBMs52OndCZGHGMw7OOcHY00cE5Ufxqh72Xxozrgv4EFuG1YgJ3BN3Yv5QlS6l4SFiOmH51cgsZrM5h9VmMEh4GnMEZV7lt3StDkfg5
    zzfhWClR7HjbPA4tqnSXB71KNeGwabwSbmpclQayo/Zx7ggeKdv50Rw2AHe3g5P8loU3CoTtjzwAA82oo6k6OnDEsueoIAdikHwfer/+CLNFJoUBwGErMI4T
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uP1ucDPQAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=-ITEmu96tX6iv3YGRBYA:9 a=wPNLvfGTeEIA:10 a=X3ieE3onHXUA:10
    a=9a9ggB8z3XFZH39hjkD6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbeDICev (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:34:51 -0400
Received: from mail-sn1nam02on0101.outbound.protection.outlook.com ([104.47.36.101]:16522
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755602AbeDIA1j (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Brian Norris <computersforpeace@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 058/293] mtd: handle partitioning on devices
 with 0 erasesize
Thread-Topic: [PATCH AUTOSEL for 4.9 058/293] mtd: handle partitioning on
 devices with 0 erasesize
Thread-Index: AQHTz5kAgWMN5LdnDUOlZJ62Cebi8g==
Date: Mon, 9 Apr 2018 00:23:36 +0000
Message-ID: <20180409002239.163177-58-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:+b0zTzfA9IC4YyeoyrZqN5Fh+4Xn/FUpESVE+J0i9sBKXfa/55mINMt8+ZaslT5huaNWOUxn0clRjtMOVUbJk3ELUC6Fsg9/Oas9g9hjWXXmqzcZIo+inWjSkngkJ9Yu2MxcVnC504H0Wcxf1lH4vaAi2/lI2La4E7oaBbJ7e0V5mTUTKRqwhHDVus2KbD0hC3CiEvyd7sQ554C2SHPc8RJy9sPJYYqQkCJD6gihfu8F7rC3cx0+gH2AiwsCWOdg;20:Ucm1UqzfM524+xIKIO9c4Bzv5l8VOyTE9QnFnxYyUZekhpZ5Lew6OUTzZfCjr5pjEBxWvYtfKdgT4dUT8E4bj8f0jqsTgADplebwOZeFGIyxCasrS09qOtCKPy0iRxVSeWHdT2B5UctpM5kKdXbCRyZKxguESW6CUHkokH6F8NE=
X-MS-Office365-Filtering-Correlation-Id: 7e90a630-0db6-43d5-37d1-08d59db0b06d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871494D0E246E4D5137D6ACFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(39060400002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ILoamaB9Q3l7HiqnKW7TfB8nX8gmTjRIl8nslztrMedKYUWGsd4CjJMn2klrfIgsU6N/7yOcdtNF86U/hmjoaCRVwU5j7zZhQKpQ3klxF7shdvCPnYmZPZ+aWhPi0vzy/cUZz58o5n1v19L9jhHcfAcvC+8Nk7KFrz/wm7tmlx6NmXHjv33GTVfN7pwT3z1JdfXFJ2p2kaWasbDYwJtYCjmZDlZoPcne4lDti4YkxcpwS/iB+GpT9sYWekccc0z7PJ0TZN8fEWNbCfWp4ZTpIObRIvZlGx5SzgBep0v8CQosLhtt1zrTBXqevhNNnxlsCTl3Z348Uf4M9UMGke5tAPsmdei8tptjGwiE8nyXSj1gRZP7t4vqwIh9y68+kCqBe/Hjyh6emnpH2LdmHVO+o/EYgBuwPg5YHZtMhvV7FIY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e90a630-0db6-43d5-37d1-08d59db0b06d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:36.7061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index fccdd49bb964..4bb63503aabf 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -385,8 +385,12 @@ static struct mtd_part *allocate_partition(struct mtd_=
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
@@ -488,10 +492,11 @@ static struct mtd_part *allocate_partition(struct mtd=
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
@@ -556,19 +561,22 @@ static struct mtd_part *allocate_partition(struct mtd=
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
