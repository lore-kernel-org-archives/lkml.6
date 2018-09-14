Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74742FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E9021479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TFEkchhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E9021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeINSTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:19:31 -0400
Received: from mail-eopbgr50114.outbound.protection.outlook.com ([40.107.5.114]:60592
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbeINSTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGWIsdMYSRMGAa6McwfrhtqK3K80zd7CYPsxJRYuGVY=;
 b=TFEkchhF6x/0IjbM3mSEh+dHsmbb+LkggoC9+Hs/LmIlbYKc/G6VED0dC6oE9TE3l9p04qnMBZcG9S0aJzzUHvGT/d+IwoZpNLr6jgE9YYqx++QLaHaKzqYn5tbLfD9KQGdujGww3r5FBJ/5NGCdM9EdQy8kVvExwdF/FVQhbKs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 VI1PR08MB3261.eurprd08.prod.outlook.com (2603:10a6:803:3d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 14 Sep 2018 13:05:02 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 1/3] kvfree(): Fix misleading comment.
Date:   Fri, 14 Sep 2018 16:05:10 +0300
Message-Id: <20180914130512.10394-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::23) To VI1PR08MB3261.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fecbcbb-020b-4764-56c5-08d61a42aee8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3261;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;3:0byODzHccb4EAAuQ1SDZ/BCymPA13IjEFyAjqx3jGPP4OdaE3Yo2P2zWMuXYywbe1CCHIbMtqH5yyyGvUu1REHUIYAy4qi+TSiVBqMT32pbrNARVTe55uoKwnKdYRpXdaiJuITjyh8jhosj0nJ1yzIxqg7nnc5XRiJBxBpNz0nKIVldRgnWLrqZoxQR/9FDYps9nTgD7N9RnsKAXmEABOxuPzRCnhllCBxKKhAmUEULEkXMwZ9LSiOyTDVu8++W8;25:NBvljTs6Z2rJj60URvXHuB3Tzc67HLu1kNeCB5pPaVV9DRo6opmwNmfSCRnNJk0kk0AWjaKuhwpSXjGC82JgyJSIZthC4jqyeN40hz+GS2gsk47SEs26FomoQzTUasq+hJEbuzU1JS3oWT+T98WrwVuTjUk04CCncM6tTDtvkl5v/VTidvZXtraLgdVG253MXHFcqlvgko3gfLt2LIv0mCgU2bQxcSzBmHL4CIOVhJLyMatUOzQMfIIzFfOSbiv1Kchm4xxfsaksHh0SmAlZ+oofY2EmBR6SguRpkM5aEpIyyWm2Md2l5S+nQHAIoTOUBfLLwrcxzGCoF3NULP8T/Q==;31:SKpbSpcuyPNaRv5kNIMD7vXM7/i2fUnZpYdKUJqIYTc0QQI4b91KVAA3yQCzKpRfYOX1/SKuCc8cj9RHNAHD2YrXzDLHdo4NqWlT7JYOC/vMMCCu+nQsD67k7TsyQ8xP35uiukDdP9MuggrbgjFYsZki6WFhGG9kvEKNF2z9GeKpLXlZCSRkge+qb2Gxo+Y5GCMwTh6zQZAchyJrSMasPMBzx/Ob7Niv0jIe//CpBjA=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3261:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:c800JX/k8gikjUcqJPRWxcmiovmKeCk4Je6bRvO+MTO1JGH7DF4lqSw8MIbviX3POEuhODEiwXj3bpjVX2afsnuqbyEexRti4QUnwxr4kXPfcVmiU5fUd0OhViynX6ecVLl/FuEIUlK4WOO+5wd6VVcxnDKDfXZdDAsUAfdEIMqoxtMqZJHLnUq8gBCMPFWS+1ETHbw5I2BOvoTS3HSHMRrKvqe/fbn+G1RnYIWX1gxjtPcyYwYYz/djETqzod22cy8u5UvFyWBWiW57MDw6w7ZGfdK0k32GSVkJ0aFmsO16z9C0BWvBhgGrburfaA/tGw1Gbxb8OkVkbXfVlGNIGBWD8uVqkaza4U/2Uv18kalQJnOuCd5I7HThJUFvwYWBZOC92FlEJcyi6q1LrKA86yGWu2W6JS8VJbmLBE+SU2mWlWVwoL8oqwtY1lbsmyfXasyEVfmwU8zWmC+g2EMkg4nOLdcSVO80ywqjOt2HdM13Q3OnMsm9ipI2DUGPKYVc;4:3Gf/MRfpCiIEvwdDz1r6QvYo+F8SOwl8Q2ZsMGeaWfnLutYdkuXtttO4V1o0SYyqE4ashdD2Pc6k0rX5V7QTAnHHGl8gOcU37Fs0h0OCovLIc/+TnJSIkFRE0WXk4QRVucmYW+xk7aMWwYiOBVUSW9LAww86Puf3YZT3rtdPilHfNxYCOz1RAxtHH55dAvFgk6AieAntlIA9acFbyuFjqMdIlUyF4C+t+I0MJVgz5IDMOBwLByFtrSKDUhV0EuzZ6vr4E5mQwuHtA8+vKZAFPg==
X-Microsoft-Antispam-PRVS: <VI1PR08MB326169FA715CB4AA17F2408CB0190@VI1PR08MB3261.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:VI1PR08MB3261;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3261;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(396003)(366004)(199004)(189003)(107886003)(52116002)(51416003)(66066001)(478600001)(14444005)(81156014)(7736002)(305945005)(25786009)(105586002)(50466002)(5660300001)(106356001)(53416004)(6666003)(81166006)(6916009)(2906002)(53936002)(6486002)(8936002)(50226002)(386003)(956004)(1076002)(3846002)(6116002)(16526019)(4326008)(2616005)(476003)(36756003)(48376002)(16586007)(6512007)(6506007)(186003)(486006)(97736004)(86362001)(68736007)(8676002)(316002)(47776003)(54906003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3261;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3261;23:NfUYbdX7j4gCFCVTtRVVoU/xTlLuF7uzaAvVIMXTz?=
 =?us-ascii?Q?JqDUr8ou45mcScSvpOtQ22xqyNQlazcGcgFQl4gGv3pDYH16jRBXbsepOb3e?=
 =?us-ascii?Q?zIDlSsAQEHzdR9H3jTPmKPCNd9ZSYrCDtuVIw/Y4xnWdLbwunDZ7wiQEbMsK?=
 =?us-ascii?Q?NJn9ElJI+DKOlJF945YSN9I/E5qUrkkG7qGJejIfLdgC9LbWHlaCVaaW3/pv?=
 =?us-ascii?Q?RoUO49fVYXqY4qA2pzuVM6Lz1qOk++g3r15t9WTq00SUXKnYzYxnYvsTFzQ5?=
 =?us-ascii?Q?p1ViSviSrzLCymQdhJrWtRaXSRg496lk7CmXWq86ABPfHlFK++BwT4dRMfbI?=
 =?us-ascii?Q?wzPU6lGOAjdky1+ttteI/TQWxD1fbF/EefLOhpZRnUMVeQu4Qm/e6Z/HiekN?=
 =?us-ascii?Q?m4vOJRqn+48NvyFQKpfynI0Pay+I9bC8XxgiDKrbwaD+ldFN8SYepxNfhtnV?=
 =?us-ascii?Q?vX4p+tm9tW7xD3AAhDiGiFUdnmvdqA547joWFF8MbmzDCul8f0ECdVcuA0dL?=
 =?us-ascii?Q?qk/Oj1NMTaPEw+1fWPFOg8Lgx0AB3hVBOgsMFVxV/eYND0eBtpxmFHAqfXn2?=
 =?us-ascii?Q?HNImKsYrCOviHP3+y4UVXY5bJ5eH9dTaUNmu7CCfgR/soWBFqthW2meTsblo?=
 =?us-ascii?Q?dxTkVUCM0Qpf+pi1ZXIGDbxDWaLVLMbJXejTnhBiaMqA1CiLs/cV8C/PwaKB?=
 =?us-ascii?Q?cNFeFRZBgoZQN5z3mGgaOwt81L8Abn8XYnhmQdJuoYL3nwwnBkSE7cdaM7xI?=
 =?us-ascii?Q?swEds8aA1dbhb7/SQO/cSg1aT0ibp7azC8xXD1zSLEf8m5Hh5RYDmBEXE9YD?=
 =?us-ascii?Q?WljPIA+OOI0XtSNqzuFOJQ5XJs5p72NGGL+WR1vVaCl+4yOWwZDUdY3K9PQ7?=
 =?us-ascii?Q?1sdJUf8rvvc4PBRyh8sqtFCj/AYoNMm3bVADl7DmoCt2MU8LX9z0mrGE8vfS?=
 =?us-ascii?Q?J3L6GD1uuJ8jpRoasRrXy4rk/oCnSRQNGDLL/WMXUqlY4trXO3FMDneGhEOH?=
 =?us-ascii?Q?iQ+UhqnIPS9lSr/M79obmO/Cdk+lYeB+EBo/+/fh1N+OsmKkRYE6AHrhbXgm?=
 =?us-ascii?Q?dRSjyx3ZCGLusKwComvoqr0+VRFUg2cUzianRxrAKtbu+GeSzoJ3qTG1p2sK?=
 =?us-ascii?Q?QnMMMQ4vDVrnovfEZ8AqQgAQ2cnhD/w/NJc7BfviOZDvtgc8+FNhtT+AxPBe?=
 =?us-ascii?Q?0yK8KUIpgGXfAJE2y345ME7FWnPHJEilTP1?=
X-Microsoft-Antispam-Message-Info: gUeCjAZPmwih4y8k/q3cYw6K3+YNhbZewPROA0MaqQAnoBs2HUEWeK4tiMkF8HM8Roe0TCmT2f78GT2sXYwHWjpFunGJ5GjfvTZrchJj56/NkuuIQOESwJlasTeH3imTePChPM/oYhJei7rfnQUBdl+er+yfeMwfJ72LUloOK61EG8NdpAJft79zwsWNCdu0+7sxulVr5/XyusXuj0g+bAZdNrECA4enfTe9PTot89fxkZjtnPKKHCNStlTlWhrvtK360qRDfQqs8NVfodgjkMOLt8hIAxzOIt3lVBlsxfbLfD0bbDCq4yaBPn76wbFBIgXZCXB5XXounAQGCwr9zSgb15TVkp2THOkYgnhfjNQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;6:I5LoxijUjW1YAI71ym7ONGWULE0Gz57NMREx3xod587eF8G2BAbbOCGtKmwuOQGVZGojc0Jy7EjOh9g38Owhiyji7M05btNyK8H++Q9TZ99HpxjqEmVAl+TliJBe7p6Icq8yDb6OawjJcIH6X0xX1ILfU5KsjySjc8YZjnBQase0GtAF/iLKR0G9m4Hdn8o4C0NeNsUBH/wLyp0A5H/BEXU5/KuqU18RNesA+OC6Jh2Y7GhzcD3+Agg+VnLh8EPdbomhHhG8unwGwQNCQqPlRO5NNu19g5poa/pBn08OMLXzMKULx+cUDEFCP/CIku/Vxciyb9wn2UynKf5dWuB4g31TmzP+CpNB88rA5OYudj2AjNMS5J5RIuWKfy/+aboe6HpAcWaTLZAkgEyQw8cPg8Dvxvgyd1ALvq9ijmLvfvHoNpCJIvE8SDFVnCIroZp0CZ+P7IzSk4dpyeG9M/ZB3A==;5:gKEzKTRia5WvlWlj+watzrZgQfdKZjClho7lKnsWEDf1TH+6VZY6Ptj4fLhgWmIsLGdTCdlo5L68g9QdhiTxxvA+Fp7YUQO7COfzX1AMBseL01ZTShNvNIG57VrAjRuHauGTQBrZ/Dy0dmoabwAPD0gEZd2Hq6EyCXR/+2svc3s=;7:TmgikvZfPe7ma8+6b9qjBJuQ036tuaAnOdsy1goPg8sre8n+x1Ik5qqyTavSCdyouLquVtzXyrX5eSxqc9XoI+by/icqrxeV7H/3tdMm0Jzzlmv1fo4+re3kev1GZjlwwKLPG5CVShumFIz/2BUXwN+eeTHiQ/CtB6Oqd8KU2vqs1yYXCPR8x/kYlNdj/YXfYLKy+P7IgjgWxb3KQpcDyu6xnmlzqHihN27sfbc+ezDflFHMPRl31jW9ctLAQb/9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3261;20:sNt8s2XWDxx4f+cf/hlQcmHWGshyTLsKbK8CiAkMVWXH7dOcMVS8JPZSrimox/Gw7km+vnKqRSPhmuX+4wAe20Eil0pOFaKRcioKObJ1ytbQuEbDYUKoiu2twVTkkzzPyIQPHLESKUJdrI+P+bsGqgKRjpMAmpSz2Vw8Us5W0js=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 13:05:02.0067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fecbcbb-020b-4764-56c5-08d61a42aee8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfree() might sleep if called not in interrupt context.
So does kvfree() too. Fix misleading kvfree()'s comment about
allowed context.

Fixes: 04b8e946075d ("mm/util.c: improve kvfree() kerneldoc")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index eeac38a64290..7f1f165f46af 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -442,7 +442,7 @@ EXPORT_SYMBOL(kvmalloc_node);
  * It is slightly more efficient to use kfree() or vfree() if you are certain
  * that you know which one to use.
  *
- * Context: Any context except NMI.
+ * Context: Either preemptible task context or not-NMI interrupt.
  */
 void kvfree(const void *addr)
 {
-- 
2.16.4

