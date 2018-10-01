Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB5AC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1669120666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BmPVof1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1669120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeJAHOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:24 -0400
Received: from mail-eopbgr680139.outbound.protection.outlook.com ([40.107.68.139]:29328
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbeJAHOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7+0pRY0svB9FNfCSgP/f3OrEDCvM73X5Tp09FHOWKg=;
 b=BmPVof1HwmB23AUPDSzQzYLMOBJMbHMURs8SmjE78YymHmaj/anfjpcPNE1kfkf93MvkbBoD4Q5iAIHtNgtUSsW+X70fwaMXrU+/xV9mxHfz1d2dEJP8HUTuTZyOCQ++O1eeiI0YfbbaXcqlixg88VtAyVmcS5DSf+SHM8qHqzg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 53/65] hexagon: modify ffs() and fls() to return
 int
Thread-Topic: [PATCH AUTOSEL 4.18 53/65] hexagon: modify ffs() and fls() to
 return int
Thread-Index: AQHUWR8Wd6xG+F6tf06MSMEdcQn7DQ==
Date:   Mon, 1 Oct 2018 00:38:35 +0000
Message-ID: <20181001003754.146961-53-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:dFYIRzg6XG0XsT5MqERff5dCL1CqT2pDiGjHRa6mNTMDbUwJYeV+I4YbPTfPqHzKG5HGnmlvM2pz9yNerk7W/rEZIJCUpG4xDPw0jFHvEucVTbC8zSpoVFWZfwnTmg88ml/4P6q/FuFufWlBzza7jljxPyMGU9yagdQeumUnb6Dfiaj1bEUtQOT/hcJPiqweVCe/Nt/Lm7xZxFLZLB/MDHHJeIJfJxUZVYPoVGSYnrpFGM5qJq4UGt+TTy+UHWRuFgergEw5mfxx3MOU5aMVtu9vmp+kz1xjT08ZiQQK2FLbVh7OyJ/9ZvIksFDV8rHl/kqH41BwzVRiCR8Lfm2Pvf+ViHyaDy9juQRc7zJpMyw8G9LjcvuX6xHgXt2T7kCnkLe1N1InCH7qwqxlemfq435zZpd1mjtzWSGCPaO42/1Y2yfHOLPE3U/An8XL9XLKVfGww4VlJElwsNl5yg0Arw==;5:5vzG4hETg9lEHZeHDAukB8S6uDhdMEGhuuDciTXnUwoYNZ3iTWrH2QXpNZqCQmUgQpwNiT1pnF9p5T/uQi7YldBllUS7JqWt4MOoksg6VQ8mjPXcdIhc7oxO7jbXQCcqvkO93F3k1T0uCfgJ+q8PAmhwxfr0jtza8+au982aA5o=;7:zILaakb1EvivREaJXSj7luTqD32ZmnuuIVHFplPkgoJYM9U4fffogVYDA9XzRgW8ctfJJFZJ/jjDmXJU+r8zw7Uf2zwAoiC1bQRtDTd1VSm+TRizxwHEe0mj07o0e4QDVpR/HKay+/UoV5yvrUuK4iH5NL9bhMj2aMhmgdz4KeXq4bCdYojBN09M9NrDQb7IwwiyJZn9OE1Ty7FOc4NnTl9GKVNdKVVMS5q3VFF0TwfMddWRNLUuu/nKopdpsP+F
x-ms-office365-filtering-correlation-id: 484ba051-3c2d-46d2-4746-08d627364991
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08241979F90703CC69C7AD8BFBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: G48nfzNr9dHkgDn4SO/yQcj1RxbbyEc1B0Ejcv9ZynwVsLSlBTamoXEvWL+j5P8/BqnGopke+BF2zU1caeuy9KukO6eU3Boag52x+s1EZnNdm69zA01dh+fFj24e0O+Dvp5R14kyp+hYe+rfTTzZI5SsNGYgFhcYSUAGEek5UrsaQkCUQNyPY9tmy5WGV1KTs29Bl+EtL6GXUBC816rVizeocrtoJgdmC/mFXpvRLLHYvYwmOQ1kedZC4eM3SdNYiABKxhaRma7X0+aKEjM6Qkc310i4T/uMQLcwQ9GDxmjo1IxxBLdyGFYKzm7gun1sU4Lpo5VRvONKKuRJrqhO7W1/QVeiES2C+84JhqIlDYg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484ba051-3c2d-46d2-4746-08d627364991
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:35.0172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
