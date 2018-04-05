Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752849AbeDETB6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:01:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752398AbeDETBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:01:54 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/4] mm: treat memory.low value inclusive
Date: Thu, 5 Apr 2018 19:59:20 +0100
Message-ID: <20180405185921.4942-3-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180405185921.4942-1-guro@fb.com>
References: <20180405185921.4942-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:c820]
X-ClientProxiedBy: DB6PR0601CA0040.eurprd06.prod.outlook.com
 (2603:10a6:4:17::26) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0aef898-857a-441a-cb28-08d59b27694a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:stRybsPO9K3dQePb4CXwwW0qxIlJ+5ErVc+DuAXiM3apXHVayMuwZ19hW6dMQCaI9hAEa9jn/+3oXg403GBKbIQMzZBbqlqoB4LEMCVVHhLknHTXtmnhi/iOw24QvokGg2Xi664jzScLS+OJCDvzQF+RSHHK4MvaewAGMauPx/qUb3fRu15Y3fWbztCwyHQyUxVVwfrAFx2jGyJdY8lU4QQLmz1A89AUon2itHPDk08OUpR97oJ48nCRjGtTz0Dz;25:k6gy/xJzG/ryB6gGBnI0/Mro2Cs22ZR5uNm31N/jRk1SovZ8gE/i8baZ7Cv92N5BGPlkjFGN/WH1f9O93dPKTsBfdMCLR9eWn+1O6ayiC51t/u+9pALUQISQZV+UhK+fTFtyzkdS0xhJwgjl6xg2FphLKjlr/ahS6V27OhHkJ9k+nQNJMYMlUWr4DjozjgtbL9xWRELewk0f1oqso5wJnlb8MESwRFfbsN15q5G0aBT5mVPykt2DtpjOFEvboG935aZllLTlfsDnkCT8Fn4G4e6bAXTseN7KunPHC9L1/rieyb0L2fancCpRNA+2VU14gvBED3pgH0ltK0y2FscFyQ==;31:RTHnCp/oryDNnveEHGzeCZDjiYypXYAYRyQC8ny0I9Sp07dtlW1CteOHdJuny1tILDN8zwIlJJdC0eTnliIxp94Y3qI9QLvHxuHhzT8klc58o2Eh364JM9a+/Mjcr/6ldkJJomwbnXv1UWLEXEx23gi2e57lx4k155ykwkEZdzNzmMrzIZ60SspxIeiWl5wUOJSQJ255MOPz+2rq/HK5uMKRJa6PJa9ibonPr6c+hvM=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:QaMHgv3O6PQspBncF8pETqeuxl37Vpym18DdEG3PIl9bWwO+hQzeq7pMAjXy7oeGBb+TRo1ek6ujeU6nbE9mH3Aa2VF8j1tnD4G7OyPDZ+lXEI4p45cpxH/lDYZFlUkrco2fTzImiiMOqnaDHLriGBKAr7qubIHgCYgzUQE1lyV+K6S7OWCnSYIyOjlyf4/cbAMb2pnAI4Sc8/QOZ1ZsxSYDIhoh+hW6txJncLpR7EHcrVJFGVLes42GEZ/1e0l1yU/9UBim9dkNachuFpRQCJaEUkxnpKqzLWd/Z7l9FHFQILl2Fo8eyzPv0dl9LiUH7kGw7kftuMcncp2VoQkJMCVy/WWu+eJSiq+oNl6lztmpi6JghFWWfn6jPRCrQSeP0MNukzXlad9Yypw7WzQ3qEWf8npOQ8XlvZyUffCTpM2djNBd8rSr+i2D98975QLq8lxeyRbloOF+EbxRTZV1Hk3nUByOLV4O9LOO/oO+GRKqkLXiKo/YTCUoH6U3hBgK;4:ViAjl9hy/wkRfy3rsqgq1f3/pS7SYIDmItvJ9v05IMhBOeQIeDoCEDcpJJUjfJnO1kdHdImTY+cQ+ujauWSUJE5DdGrBm0b1DQPSiWZfPQ1oqPQVygHPUCJKyfJa+4jfm0/nw/IQdcZ2cnNQOyeJ6K59b703rsg57XgvgPLwFzh9YBzvmVN0uH2lNRYgRUJnkuB5wr5g5LdZCXc6JKhnUWSrVxYYlOaDyKQ1e0pnFcKVbxzXAPThydpmdn4KrIaqoo7xrhfNmoLloihX7x4XvCPlkE5uL8Ts8yfNAO002Y4qqQ75yyvemN2gPE0JBcD2wvwbxnB7hmKEgXYHhkZLYLoxMJKhCWEgQTjJAx3iLDoLW8esUo+kHsh5ZmjuKNpn
X-Microsoft-Antispam-PRVS: <CO1PR15MB1078C4A82EFC8E2334A1C9B2BEBB0@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(199004)(189003)(2361001)(2906002)(316002)(5660300001)(76176011)(69596002)(51416003)(52116002)(446003)(52396003)(106356001)(47776003)(11346002)(86362001)(46003)(68736007)(305945005)(6116002)(486006)(478600001)(7736002)(16586007)(59450400001)(50466002)(39060400002)(1076002)(48376002)(36756003)(6916009)(2616005)(6506007)(53416004)(50226002)(6666003)(4326008)(8936002)(54906003)(476003)(97736004)(186003)(25786009)(6512007)(53936002)(16526019)(2351001)(81156014)(105586002)(81166006)(386003)(8676002)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:3QOIsjS2mbYIEPT+2qVl+4NYIsM4oaAG94AHSIzKb?=
 =?us-ascii?Q?+7rX5Yd+fauCR9UEENhIEej60kmIoe0ssVtoKEWuYB+OLNFzhaOpwOavPBRD?=
 =?us-ascii?Q?LqKqebksfQPXF1xoEDoqAPrNEcTj5ClGDUZutaXFU1rLk8er04ZM7Fza1//2?=
 =?us-ascii?Q?ktCmDVvFWr79PqiLkuMDdMiI+ioSML/jt/54HwT04CSCgwAAlTGGmtD7BpBC?=
 =?us-ascii?Q?RxgvyFKO2cL6c9ZzW861Ll71WRtY/CZZ0nBWcCQJOibHTxAqrbetSA/CYk28?=
 =?us-ascii?Q?Mqdih4Ub6gjiQnA1GbzBrCfjzPs6IdGrouV0+ee/6tGBEAjMjJj9X2293i6I?=
 =?us-ascii?Q?g4pHS+Q45rKVQ7ruzcgKdMDG4YndWZaowIx4IBW6GPm6W/1nGG9htIqArozb?=
 =?us-ascii?Q?skUSIZSwn4OYLKmogRNN+ALWLgYxSL+UG/Nh163Eya7ugPE7tfN0D53A4yNi?=
 =?us-ascii?Q?q0k+eUhqTadB5HsZCf0A7nSuVPrntmfu/lVYnD2swIgiajaT4Lbq0cQdMBUM?=
 =?us-ascii?Q?GggQnkT2QEbWDZv8E6s95h8pXY7CaO3QmaTI/kvGOtdESMqMm/tuOTwVLc0w?=
 =?us-ascii?Q?q/7LtuPfLBEKBLSu+A7n1reLpoqpeeJPNEBxDgQraPe/hixAN6rqw7qQpUM4?=
 =?us-ascii?Q?XOhhrIilktfZJfuAXS9/9k0GVbZnqx5fJW5GEF133ZYIR5hnJXw++ZV5IraA?=
 =?us-ascii?Q?EKtKKG6FUaPOY1mOm0zSxUb1QZgSoKFbIRJa5cBqktVpBpxgSPic4RjuABhj?=
 =?us-ascii?Q?3gPw8h9pKclY4Wai+3/24utKeMvitJ8qlHg7YhQN65NdaLX/lHZq7isR3wW8?=
 =?us-ascii?Q?PnTazBqm68deG00wTxeMJ8ZdABvOJiXwv3V4yG1zY5F66TS8NOgu/V/SyqSn?=
 =?us-ascii?Q?FLQrZI4qem5/QbZI1iR8AP0Btn9Rp6WY5///SmAjqhAZs68fODArPfJLW9XQ?=
 =?us-ascii?Q?ALt6YgfzfKHkia8YwhjKdqiKwUIiE4iHGVDdlyhY9Rj0hIfMY5U8gPYaANL4?=
 =?us-ascii?Q?TU+oBaH6a06Q3O9Es9BsggzugXxvMv9780jXsmNlXmOnK/lEfU/GIf5t30VX?=
 =?us-ascii?Q?zUQWCkwHcyz9nWAyGJNDJR5DbQWPNMc7lfYYpviG1KCTUrigWbbuIDbkWiiU?=
 =?us-ascii?Q?SAw2o+EOXGq8PhTEGpPhhEI4dt4tVfDGXOdswCGoT2GuVsbUPuCF8U7kJAMW?=
 =?us-ascii?Q?I3yjQtjybRulMuWyUH/osmqsCnBOiFmorJ7sxzAtYtD1IbJXbXazhlRx9/x4?=
 =?us-ascii?Q?KKmpHrePKrodxNIkesuYCc2P7PeKcuZQJ2VAfkBLmerbPA0IvezcyUf0Wfwo?=
 =?us-ascii?Q?UoXdycTmbUlrK+Y07vUtGxpjuYkQ8wa2Aae+qpfDEip?=
X-Microsoft-Antispam-Message-Info: vumF/pNLIzul/AqWb7qi8K/3nzfRI8fBEO3IXX32OgAc7HO7uNIBe/O4Wv3WoP7VW8pD2MN9pRDc5AeWTLQm6rk/8R9xp4uMiCdk9YulHZ713IWgPZ9NbT8aQQM/oISe5ZgD6zEQgEtuVL8eRH+t2XS5LVm/AubVbWTI5QhOvpCcuZP8dVC+S8EjWtGPne79
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:ZgLW8xyQaKYX49FPlaCM1H3gpgMLInyVZUweCAgJRNlQhTtD3OdpfWj3gr5jxhk3FwfeIfSTBZ8U8aCnFUvoHGFDjqmy6lSpYu0gVTDJ1Bm6n3yB/RkLWafswgkPRT2wQBTP2CFHGHUrcYtpl1zg1PL5TJ2kAnPSRYr1+543nGr4zGGmAk/girx08/pyfsZtpbAFFZCPRdmnocei3wPnIITYPntBK95L7uAjWKWIOlhTM2FZvP4hC9U+b1HKVBmZmmRjxWdhQoD5MaAh6agYsZkmOLscAiBSwISHd6RyXxqdnDc5D5P2TPrQkAfuFe9RW25ddNGcVp6/Q40mRtmWttTVBPRslh3Sf6bmQeYrn/owNuTxjg9ADxQ96bg9UePwtVgQmeDCO0BpI/M341ktKzzIs60FfWK1lIsDpSqME5y8Y+lMsRGSLlRr/wcY3zP6aoik+b7InHq+lO+bOvPADQ==;5:Esk9sBRoUlc1MMhjWzzwIMQ1qH5OYUSP2Yz7jgLQMxt2L73jzvPTqsz7WeQAJ1rFgxIkIc0RwJc/1b4Rt26U9DC7y5mP0A0+Ho0te2+4iRx0FJK3AVxkpt5j9GBK6Xz1sKPSE0nPuj48o8AYMKImrbvYPuuCwotdgtWEyNAIsU4=;24:oCB7C+wdHtuvkAsw0xPx6sE+TaXZdhVVT2whlIoiAGiZVIr2RWTLIvfZ5doCEQvNE4NEoF4wSBPa01WXoUWewTfzvPwY1jIxK0K+hQmYFwk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:vnVZVi+GF4w62zmP1Mm9gHCJIjzw8gTIe3hazTipLgaogNKWrGfp30s6u79B4EidKiuh9RMD9GLYgdsv3t9dUnOBAU8utIjrK0mm9GIXuJ6yMJuBpt14qxOi303adXmxelkvl+YEiIO+8iR4V/9fAycAPgJD5Mc+bmI2xW6PptHRwr23IgxDjYTcesJPCiWZL+px0IzdSgC+5NA+C/28S1dnJFK+X+Wm8g70cjCht1Z5yLrrQop/7gl/71/va9c1;20:XXhyDVNlk6VFcymuKnc3mq5lI9ngSrcn56hRXZYhioCp+qXua41gOulja1gX+8LUW1pxkZFM748h7gcEUWDb8ld9NFKct4DdjSvP2LDxrJWJdcqPZ9WKF5CGHscv0DMyI6UacPg6WCOpR8Qlj50gb7V8NBEySKjaF/wkwHPJZrU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 18:59:47.7675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0aef898-857a-441a-cb28-08d59b27694a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If memcg's usage is equal to the memory.low value, avoid reclaiming
from this cgroup while there is a surplus of reclaimable memory.

This sounds more logical and also matches memory.high and memory.max
behavior: both are inclusive.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 78cf21f2a943..1cd6e9bf24f2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5608,14 +5608,14 @@ struct cgroup_subsys memory_cgrp_subsys = {
 };
 
 /**
- * mem_cgroup_low - check if memory consumption is below the normal range
+ * mem_cgroup_low - check if memory consumption is in the normal range
  * @root: the top ancestor of the sub-tree being checked
  * @memcg: the memory cgroup to check
  *
  * WARNING: This function is not stateless! It can only be used as part
  *          of a top-down tree iteration, not for isolated queries.
  *
- * Returns %true if memory consumption of @memcg is below the normal range.
+ * Returns %true if memory consumption of @memcg is in the normal range.
  *
  * @root is exclusive; it is never low when looked at directly
  *
@@ -5709,7 +5709,7 @@ bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg)
 	elow = min(elow, parent_elow * low_usage / siblings_low_usage);
 exit:
 	memcg->memory.elow = elow;
-	return usage < elow;
+	return usage <= elow;
 }
 
 /**
-- 
2.14.3
