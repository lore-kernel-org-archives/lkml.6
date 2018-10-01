Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67B5C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C4F20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D8ScegMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C4F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbeJAHWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:22:11 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:27744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728942AbeJAHPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7+0pRY0svB9FNfCSgP/f3OrEDCvM73X5Tp09FHOWKg=;
 b=D8ScegMB4u1NTRSjRtbR5zj2xg9p7mDGtFchbQbYMIYCn2anUX14H/zkvZ2aDzvk6alJonuxsX27ZbT9v7avUVHL++mFKFKmqvNY9vdO3iW6ZUsiP750TGTxnWQMqviO0y3DxlH/2IKKStKWqX+MWSwlwT7ODyY5vDDb0MgF6b8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:40:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 28/37] hexagon: modify ffs() and fls() to return
 int
Thread-Topic: [PATCH AUTOSEL 4.14 28/37] hexagon: modify ffs() and fls() to
 return int
Thread-Index: AQHUWR8r9IdWLfbxcE+j11zRr9pzYQ==
Date:   Mon, 1 Oct 2018 00:39:10 +0000
Message-ID: <20181001003850.147107-28-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:t47zE/R2FQnOvBNtI0W8BHO6y29MF5Y2nNM/6jOc1+o8pz63UiKL99QkrwP1AsGGxbB6GUr6BNuyxosxEaXrZGvnqbbkI1ho+9KtYmSnQ1vAy8XmlzVe+zemWF2K6NVfqUgD66IxpEKzi7F0wdNBWBV+4aIxEQXSDv1BULAChF+4WNObDmL2RneBZTPXF8YsrDIB7cLXXmyaGFe+7EpAhBp+g2jeSTnG2wPD2yfmFkUw3xsjm+z2FEJhbt9BOZo2wWoyUTRi5Yl6ZIoXxDAaC70+Z1Wl9yUVRLawEt1cRlpLWqoxAKoVMjkNAEYYQiFKogHzo90BFswMiRZ5g6MjsHcTA5pHcTUjynouM9uDKTJaPMN2EEmRbfHuDt/kBEAPtNr/zbvrhcRCRG9uw/639h74KpSusnlGUUpSyexkCsVllGk/MLrAVyp8KdG0BVkbpkonUAHAuj5g3K5vwZaPcQ==;5:ERIktxwuOUZy+XIXrv31ymZh5vri+AWPIlSNWdwGgjXuWwl3D9wLwELhoNkefZk3Cn256SYjNbAqQ122zxQ1Ktt48J0RPZWgoV1PC806xlsYeURs1mOI+h6ypmM8Eyo8VdGSOBkieq+AZ6hRvfavXW+oRA2/vceDk5Hfy+xXFos=;7:FVpe34arLqCuMBrqFcVRrpx267lV4ZUAqWzhqKtD6PIerGUDEQjV1OlD/C70rpztqu5MpXCm7jywIuOob2T2WqXf1XtG28earruk7zz9x4cLio/f1hCX+PIuNUHP8aAO8+VBb93Riqcp425x0ALrjemue8MiNXexOMMFMeVC58l7DTNiphTkMmGYjPL6sgNL8FwPTBMKv/Qojvx0oBlTw5qLQVmXaxlH+LkbNsEgJMqjPYREOBh5BjV3aOn5ta8k
x-ms-office365-filtering-correlation-id: 2c132aff-afbf-4065-a1eb-08d6273675cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB08548CED1AC978185CFFA8FFFBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AIK4ikIJZVx2qWgsHryHhZ4rWTRLMBqpQs6cSjy6lSaNYfjMqOhSbxXz4MoJ0ygToKEKlPaspPL40VmEfaFBtm4EBMq8choXX1Raq5E1LW9QQ9cZ7dqm/SvR8rNioy4eujxwPvLS/+4eY9fuU06nqPRNvnQbkzfzS1ziBXDXHGqkMtu6Dqah5AMJiLdcrFlqT5ZMkbot7OG8dz2nV5dlk0vNp/6aRmuKw9SgtWdnLizkGLIr0jxkORVhYfEQ/skKjW/7wjf1AGGsd26Xw9nHFH2XiSrM0EkWBhu6UccYt7oE8AacH+/OhtJS7kw2ZeBhDEV9SNqMtkpJqNJwM99Lj046gFbXGDh79fmpDl6SEqY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c132aff-afbf-4065-a1eb-08d6273675cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:10.6387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 5c41aaad409c097cf1ef74f2c649fed994744ef5 ]

Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
printk format build warning.  This is due to hexagon's ffs() being
coded as returning long instead of int.

Fix the printk format warning by changing all of hexagon's ffs() and
fls() functions to return int instead of long.  The variables that
they return are already int instead of long.  This return type
matches the return type in <asm-generic/bitops/>.

../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argum=
ent of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]

There are no ffs() or fls() allmodconfig build errors after making this
change.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Patch-mainline: linux-kernel @ 07/22/2018, 16:03
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/hexagon/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/b=
itops.h
index 5e4a59b3ec1b..2691a1857d20 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) =3D 0, fls(1) =3D 1, fls(0x80000000) =3D 32.
  */
-static inline long fls(int x)
+static inline int fls(int x)
 {
 	int r;
=20
@@ -232,7 +232,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
=20
--=20
2.17.1
