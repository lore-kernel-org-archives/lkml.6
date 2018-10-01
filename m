Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCFCC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A48B2064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IX4ZH8IK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A48B2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeJAHP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:27 -0400
Received: from mail-by2nam01on0090.outbound.protection.outlook.com ([104.47.34.90]:27744
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728942AbeJAHP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQBczHP/rCdtM/Rrb8g0ns0iW/rTHvW5v8dJnBF6Grs=;
 b=IX4ZH8IKVSDY7BlAvVcPZ3ouvqkHoOqhYGZ64jsdCGYiInoyHTk3JX37iwbvqlSlx1K2YcojgfHzuMK5kj3vWo2zQh8PIj3RacKYwi7PpIjVxXwpmC8lPzPD8GMVlgDUs4LGlVi8FPdhSAA46O2QqsFKDn+BLYeAIlpuYTWDrC8=
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 27/37] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Topic: [PATCH AUTOSEL 4.14 27/37] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Index: AQHUWR8qQIB7O5xu8Eyf1LolTphcnA==
Date:   Mon, 1 Oct 2018 00:39:10 +0000
Message-ID: <20181001003850.147107-27-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:qtU+GFV5YNq4O41GKbHuGGJYcH2QTSI9E+8Xf8caicL2Jbf0XSOMdCEaGs0fUN5ZaLT+WHp0GHhJVc5jbjL3oBYPFm+pTgBFntBdJGPFpm/QmCtntZqn9N9hctLWvVgOXWk5TzUkc4I15ZHphZpoC3RnMJceoaTmUPKWh2X9xLcy4Hz69xxFMB9YniGqzn+gMTPYnT8249xOadO7+6f7+IhtVgWXAApKlgRwawTjteoOkyO8ew37J8y4PIZshf+Ao2mXoGasjulebZLCn3xPjkN+KMOlVfX+svJY/768WJ83YX770DURap3D/TOD6hmIy01xK7lxTE0nsvZ8rvCy2dB32nIZ/3EarPmVf7unwTZEs06lPlRCq4bIFy5Em23B5YFJ3nRPCWf4lxbGHvjqzoDCsjuaafYF8zfqzlx+w496Z0K+pIiL7A/t9KmnVmEJo+NGasaaiDOLWoV33M8kDA==;5:UoCxGl4E1C8eLYiVXnd/FVRzBJxJMbahLE/X0j6T1m7wVjOriwYzEf+cPBOFHE46aWW0qCiGkicMcIxoTpy1dG5EUaX5qMgEd3QQwwjtlVZqtS0Hj5PFKkmOBELHxEXdiA/nvpZcWXADUKXYYTFhD37XObfHUUmjDCa3vtCY12g=;7:bLB7SHdIeHA+SvX5JaBAVO8rtDJCgeYPSdUVySRCOyTFsUdiHAq1/yUNm6/MmWwUYPNbqtfyy0SGdhvhum9ENEdSjRQeauWf7t502gFzPs9jWEDdDoGp3x4oEYOHjGxMzqJkV53FnfYy3hvGLhmDxgeSPKmtiinX8xvfXNbf8d91w02vXMQP9KFt6zix1nldJrlAKzvuaZmnTBJb37+p53Kjo+GtMTYRgPsyvbtCXwY/lYXD8IKuT9jgjhGTXqrC
x-ms-office365-filtering-correlation-id: b416c531-cdec-4c5b-8ad4-08d62736759b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854BB18DBF1BD89BF569278FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(575784001)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +C2lXoeciDP41lipxfkpWX/nquIfQ+Au2EovxnxhL4k/REt0a8pSssXptsPISitq/BSkSzdZMGCI3+7VazGJfqgqpZihSduWVv9dXOjRY6KEBeTWrZJmlLWGBESOXDCu6PifEYsxmwELCAur0Nx8mIvlBGhOGbf0E4+RygLziwdHzsqcXUQIqS2YArEFnkMbiiDg9dByv5Iv1irsrYXojsEkulxVKes6BceFKgQl/9Mh1aKSFhLwS9pOs/R557wd8JAMw4zfLk75nuMEUmF9yP9htbc6gjTkv8Y84qwAjkMJ1Sb+eRD1ntiiX+CO33EHmFNVjS6/UlUqoWYpXyRywDtXCkw5ZH37YVHodZZXdHc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b416c531-cdec-4c5b-8ad4-08d62736759b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:10.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 200f351e27f014fcbf69b544b0b4b72aeaf45fd3 ]

Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
to unsigned long to match the function parameter type.

../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool=
_add' makes integer from pointer without a cast [enabled by default]
../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but =
argument is of type 'void *'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Patch-mainline: linux-kernel @ 07/20/2018, 20:17
[rkuo@codeaurora.org: fixed architecture name]
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/hexagon/kernel/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 546792d176a4..564651bded42 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -59,7 +59,7 @@ static void *hexagon_dma_alloc_coherent(struct device *de=
v, size_t size,
 			panic("Can't create %s() memory pool!", __func__);
 		else
 			gen_pool_add(coherent_pool,
-				pfn_to_virt(max_low_pfn),
+				(unsigned long)pfn_to_virt(max_low_pfn),
 				hexagon_coherent_pool_size, -1);
 	}
=20
--=20
2.17.1
