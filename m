Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD243C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE4C2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KaOkZy6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE4C2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbeJAHQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:42 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbeJAHQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWzCyohR3CESmip/oNb0FPYDJtYZoJ27uMKA+8sykpE=;
 b=KaOkZy6acpZ7dLcsyGoHHcVP/MZt7OoXdlbte69wNsbfat0TwBSoZZYs0SNrPudklv6LzQ1WnkbBCg78UgoGC35Kj86r2t96EvDlUZrIf76qYXXQ7Hk2ejRnP3Gv/oM57yH7PadaXp4p9Wd29V3pid0eS99BMfb7pn0E6xGOYnU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 09/17] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Topic: [PATCH AUTOSEL 4.4 09/17] arch/hexagon: fix kernel/dma.c build
 warning
Thread-Index: AQHUWR9+UR1S/jZ7i0m6z0QuL0L6sg==
Date:   Mon, 1 Oct 2018 00:41:30 +0000
Message-ID: <20181001004122.147276-9-alexander.levin@microsoft.com>
References: <20181001004122.147276-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004122.147276-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:YnH1tdAuPqAlfkn3Hh2RrXxXVCDW5/9JDHQ8lPyKHPcbq5fJVMABeXl8/4mfLT5NEuSfn1gXeAajOT+OeznCY1IO8DBbdeFV2Fwg8lsz7u53NXO8AdFvBp4FNpjhUAyTHr3jvVqkdfDOQhb4QzH2yPkprB8mHhpl0hSVJfW3z3FKG27sMCIY59CT9XyHfz7rxhJePn8MpFEIM8Z1HrUh7S3t+tr0oQXQePHccaRLVbow8QXL1Jnj3y93lYUey3L8W+orf8ClcKAb05jwFDnAA3lqHi7Hjh5LdWYi/+tc1qVUlasr6wteeV+z01uRjXkqi8fUZKhV3uNnAk2EEuIUaWSrLPFZeXKU4CgMF3eYYpcd70sK3ns4c4XmpYijQyumkQVhJuvhkbt9+MOzKYbVPdqHe1dTLsG9MB7AcnVrB2N8Vaknl0/Fine6sllgf7ZI/moydECh7Nt3oelsHnTSTQ==;5:dgCUUkbIHJNvyqcRoXA29vvJmO5etiwH/4Tlyi9Hydx67aYf62xrfNHRz8a/5H++aMe5BaxH2aY9TMG0kqum1kyEIuBYznFCBxvBTVq7LEYv4xqqbUdq6coDDb1J5Afrws43/NY98MdKjC2KNir3M4LAs9r66OVrow+gdHuYdU0=;7:pzJ3KkfPDjUQuuQNsyq+5DeqBOYV+nMu+J4cej3cHfEtHncZJZVyCFgob1xO5qGl4wQtCE4QPPGnC0lJq1+8f4fvaibHeg4b2GPcVFCmEGuig+y7+FfP8pFTcJn6AbvwBcmyG1E04WOwp/oWY6UZq9r88+IwSczVF0Gwd7FZsmcxAYLvA0AtZlfWFmp49cZWpSJdTFDeS/5sjME9mGB5U1jyQrnAK5a9j+DFEsYT7H7MWxFZcaHRPcXQTpcI0dsW
x-ms-office365-filtering-correlation-id: 34d2fd49-0178-495a-8850-08d62736a113
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791BCEFAE731778A5B9EDBEFBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(575784001)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V9INegfkGoLxXsjyAbab9SYJE5R4Sj3RNB6c9MoDCm5a/tz+MpeYmfgPxdNj26hFmB0EHnglNZnEtFXaSMZjMnhbQ8xtHkwqFdcEeNAfpO3gf1k8pmXPvajt/ZmRZoAUYFJCynYTW5CJmwShOdj6Sh3MCrbhZ0N5eH9jsG1SqEy/G0UaEPRq6Ls9qYJRFdUhLzBy1se5rjl0eTksshtWmgKM+HrFIc71zjMPhtGWyhmAl1V2b4sQu0KSZ3suhWbZRDmPQoXybgRyAKUy7wu+6TiGud4+a+sfpPbysmSXAa7xZLxuG+yBdGY4VQnXlUrlZn6wLP/k0bWrY3X9Lg1Je+DZR8bfCLTPdNKUYE3LZoM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d2fd49-0178-495a-8850-08d62736a113
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:30.2111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
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
index 9e3ddf792bd3..2704e0b8de43 100644
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
