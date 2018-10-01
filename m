Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01114C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A937820840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JJtvntIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A937820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeJAH0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:26:07 -0400
Received: from mail-eopbgr680138.outbound.protection.outlook.com ([40.107.68.138]:20182
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729195AbeJAHOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4AkqqxzNBPrAo2wGa/QuBtzEjq0R7EH+/WWSkSYxqA=;
 b=JJtvntIunJ7h8SFdoHCBhdBiF1xnvvIvhZUuo0pgptIipDTzlluBnXSdFn3H/r1iWGjI1047DNwtl0xPErAbn6rOr4yu83xtHV0sDqktrR+GX+0NS6r4bHUcjLrQrQoXgH8MDteB907A1O0RXjn51VEaBOgwCT9fI/UhDNRiqN8=
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 52/65] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Topic: [PATCH AUTOSEL 4.18 52/65] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Index: AQHUWR8VKkDk1Jc3oEK34aVDIg1gLA==
Date:   Mon, 1 Oct 2018 00:38:34 +0000
Message-ID: <20181001003754.146961-52-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:TJMBEaqsb1fGM0bn3rtjhcuL7nmWYNg34wA7qGjQs6Z8uRlf1jyxvQbC4BDjFTrrjy7p+61gsjnzlVFiRHhSm0F/EOW3aW/1TFkY5TetEG5t8noCeziLooJc1x7TKf5lkavZN+0l2OfMdd+wJSgoWTLT3Fqb04y/OMzgC3C18yFnI8SPIFF7vSRXiGssBx046PfIZ2XEgaLH3gX78+mi/s7W74q527vRTjm+9da2BnUVc58dTPjDD7JcuTzqv+XxmyqbtIYnyy+6l1SKRaAOnt5BvWifzYr9YBQlHhyB5DgZSxypI9zv9G+Lu6w+aenKFnK+RHrXyBZvIJpTsKKx0G3XWji7Z0s7r4y6mcJJd2UyCGGMkdh1ojJT64ztd2E3JQsmFSiHdIvU/S2li6wqR2Nepd31adrqftTaDKlM+4woHxyTESE6B+mgh/BimJj1vDP6QDOz61NuReN8QVvdeg==;5:Hex/G5J7EauG95KEMMQWKOBGDJb2A9WjG52odLKDqPqfCK9PnASIqeSore3+f1tpKPrSU9yOF2MqA8/jZEdqhnuaND9ojoo8kB8nWXgAdolXRWmj7qd7pOjQXApcgtMxfzjMg8cyeJhgLakPi37dtGj2v5jxqs1OmHQ3xbM3T+0=;7:E5LojVs42MaP7+DkBctwZ4GuVqSu49+uBx+3Y1k5FoLFuqE9zZtXiBMoPVnkWj+kcwBY5zt5Auq5WfGYXeZ9JXtlxKxAkWqbeDqtPjl9s7eR6QoS1kcsJLuzdAGu00EO89Dw2OJfL+V/momTr+9KvHJDmQWk9QtlYtbC2n6bbe1Nja6RqY+8NmGy/FCbxzbC4ojDILKo9QoviH91uyhDvJkJ/FxeeV/PfKjhBab4rg5LMc5tGAFCK9pkmd/4hUES
x-ms-office365-filtering-correlation-id: 55754560-f034-4576-9255-08d62736494a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0824297F3F5DBC33A10E0B55FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(14444005)(26005)(71200400001)(71190400001)(186003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: p9TCbFuc4uwqPd8bQYtZfaRWjkT6+1rAyllrNpH4iGSTiWLS1oQLKbWdHH0I4sT/0Y8OkV7mLdinm/fptK4WuNh9EPNG/pdxumixZ6nrom84UgpRZbN0ogRB9/lhMcmLe3wLUbBJG3dktNS3Q5IGaeNkYCXDmc0hwjKs11aeA6qwFcEHnL/hZYbkDzIeeICh0crfuyNlZtJ7vzyJzc7aMPijWHBfUPeISoJz1ZYLQbfXQMb7DehosIOMjTCbBcqHxzSzPBYWjtr6cTd88x7TPqTo8eUHUAUY9ETcCe1sZbsvw7+TFkOIK038b8wv4QBgdGJ3ozfTPp8QhCRhQ1rrkUPRs7A5hZHf9q2pxOD+Oc8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55754560-f034-4576-9255-08d62736494a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:34.4607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
index 77459df34e2e..7ebe7ad19d15 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -60,7 +60,7 @@ static void *hexagon_dma_alloc_coherent(struct device *de=
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
