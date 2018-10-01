Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C318AC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0EC20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KH9BejJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0EC20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeJAHUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:20:22 -0400
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729062AbeJAHPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrHE2WTS3GiE6luncB9L/CxknaKpSzyEuJgGoU18kO0=;
 b=KH9BejJtlo/AprDLR4XzKu+LpZIzfKHSZ8nY9b9RiOESZCtv9hcs10KKWoaVwqXHp925chjomQWUq1C8JCCbrf9/jnS1aoliqmeAR+l1BE6aIMPs9+ZkD1HPIGinzhQ24WiIGDevbUv9+OznDABFmC0/muTdM4b/wSsUUGc0YyQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.5; Mon, 1 Oct 2018 00:40:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 17/26] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Topic: [PATCH AUTOSEL 4.9 17/26] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Index: AQHUWR9gD27rNSumOkiixfwIHvp8Aw==
Date:   Mon, 1 Oct 2018 00:40:39 +0000
Message-ID: <20181001004026.147201-17-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:CNLv1Px1uBaMqnwt/UnNxFKcrdzYAtg/6S4eD4j3NCdU7pYS6JCo/hNjp4AU6oClIZfSHvfSg/KaWzhh/aOy2eyCZ093THwTFG3GPUf9ENNQhqLewtG2xA6GbWLziYlYvr7LLDBCKFm68nD13g04vBQXTBS0bdQVNDTZQbSHFBNehkde5bP2aX38sJ6Ab6kfO2ejVhxyy0+fSgxyQnziPZySOg+Z9gfv7oQuS1y6AowuXm6d+DajTJY3v43XwahHvEkbKtN8xw9JXv6pMZzkxhyswic9XvqRWl7CvJTacfM55q1mON0lHb5xbn37mazNffpNgip111CxZItlCJHsyFKpsRoK4JSlDfHr1vh0P0wIH2D1/dmeasjdWJ2GJ3a9OwH0bQbIRjThRcMzeQY7oUygXZNGr6EceRBP9NPH3zYENDvyZ8lTLOWco7+mrVdysmPXxnl1fpDXYe3cnyGwUA==;5:IiI6Q2Hmgwf4zfbtkXuUQtkmmOMTBb6wH3kiK9UFOMmIokQRJW38XQHRhErMoPDg4j3LpZ3NWNrBJzEvu77Ypjdqca1KV6RjnStdOeJMJsLAgIq/BcXvZMsqbIFJ0ZLEWWoPzL6T7xAc42MOZkxurCRqBheEHuLjonoh5ryVZkE=;7:feo/UzTTYAdYC1wWI2FKKySUsISZE0JyYevRB9BXs/Y5d7thxd/PFNgVSpzSXERGNdqpr0wqSbIxeRyRDGxmdiDGTBTRo0ySPrJtqXIX1hG6qW0z0+9eV7K5Rt0g/E+pZZf3yRdo5dFRPyZ8mTFg277nHqKyZfTAPC5Copr3Zeh8yFiKJ+NnvUqn2csmFZioBJs45ZsY6CY6ruaSIh2vvZsKUR9LTX3Pw9pEueRB3dvDvUfKRae4gRPDxo/v4l+i
x-ms-office365-filtering-correlation-id: 7cd7cc96-011b-400f-1e2a-08d6273682c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB016532CB041203ED855EFBE1FBEF0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(476003)(2616005)(256004)(217873002)(486006)(6486002)(575784001)(1076002)(11346002)(446003)(86362001)(97736004)(2900100001)(3846002)(6116002)(2501003)(110136005)(478600001)(54906003)(2906002)(5250100002)(6436002)(8936002)(316002)(53936002)(14444005)(81166006)(81156014)(68736007)(5660300001)(99286004)(8676002)(10290500003)(26005)(6346003)(4326008)(86612001)(6506007)(305945005)(106356001)(7736002)(76176011)(6512007)(72206003)(102836004)(25786009)(105586002)(107886003)(186003)(14454004)(71200400001)(34290500001)(71190400001)(22452003)(36756003)(66066001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: rHXuT+w8n+uBT+WjFBaTiZGd9b4IA64uDE4Mht086LrvTiHi7oQ/zOpVsfznged/eryO9fSkcBIoyyvKEcNzPm27FB5sJbvDd3+DfENe25uLYxcbrx6t1mCGkJT73Eh2xsUT+qn7gJGEVFna7tD0ndaDVSHlJNavWT4DtNiDJ/Z3DBtfq0/r3MSwZnHXyerc1tA75udO4RabzWP9cy8QOxNlmT/zJ5ECDsUO7qPatMEhi3PAI39Vlvsblcj7jHOm/QeiB3y6gf3JpySlnjgPEtMuGpF8dHs0m8kfUW3rctJw4PtRpFkN3gSpO/KLEyjx7gWpmeGezUUl5JrdDf9AheKbi8nqpZpmpGhl6zTMhbI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd7cc96-011b-400f-1e2a-08d6273682c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:39.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
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
index b9017785fb71..0e2be48dbf07 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -68,7 +68,7 @@ static void *hexagon_dma_alloc_coherent(struct device *de=
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
