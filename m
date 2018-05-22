Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeEVNeU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:34:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34770 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751196AbeEVNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:34:15 -0400
From: Roman Gushchin <guro@fb.com>
To: Shuah Khan <shuah@kernel.org>
CC: <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] selftests: cgroup: add test for memory.low corner cases
Date: Tue, 22 May 2018 14:31:06 +0100
Message-ID: <20180522133106.24306-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:18c7]
X-ClientProxiedBy: AM6PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::29) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:UegSgarqFiG7VJsH59sDr2XXtd9QVYX+NAAJBmmGkIO66aWouc4D3zWfSSd4T8lX87wuNGtvjX1wMAwpVhOhrvkwFp7oDZQ+gAt+hwijlRZhDviuwiNbSehBDcaoHlMXvtj1GBRL2iK0qA2LuLf7NoAe8bHtlX3EiKLNLvfgmkKU4e9t/xsReN7Zji0fnj4XEeg/dOPSgU7Cc4VpBoNd0lORe6XnJNPJUSByaDs2LrOgQewU9o4wZFGirQZAmgr9;25:n04KfcSfKyVOmrE6ijMNug1S31/xRBj76J2F3VffNeqcS2IIwZSyXg8GWFcz9stcM2aRRCjeWuq8pmTx9ByRLPqBXmMZR0qG8T7c4XaB7bO7HGldPx49nhRwHzHRjYsplT3OOG5tRxydcrqBgv31BHS1FATs3a9dV1l+bpdhU/nRTLFCi2anivBQMmLjoHG8e9ffx2te3+vQj3DC0TPUkHD04j1Uc5SvrXomD5nwAE5iavfdzGQnPI7wEodc7VIb/R+HBLlPLLdeLdeOcyceuAcCuLsYoKrTYHonlqyn9QGyON9ElxcQMghQzEGnAZrAJVmAxO27QXoMl1bMR6Ce5w==;31:wyBdrGG9RVKkFgw/WStF3flScSIZ+1LFpqzUku864Ea9N3gKayu6k1/kgHw1xyg2skhiu0amOEP4yp7z7G5+riX6gTS+boYCkyPSdNkbqWWW9hNuh9gILvCRWNrLuO1TM5g7heBnJJ2YASG5ZygPcZpuIDBGulZGzSg+x4H0wNSdTBl8kYQjNYCuh9JTBI9D5vkLWEjUumB4FMEKb4Dxb6zofS/bdR/nOtGm9nQJXiM=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:qXq0lK2Ft63J0CQvYy/67aR0hvSdi/n6XmSRhQPa8sv94b9uGmGo6o9MR6L4w9phtNubizx+ymc3c8lySUivkU+P/T22bYdXPOzsgSupAGlfet3RX0lzMvPT1G/Q/2p3zvukiCBqcAeT5GHL6TkAdEuQhWylkHTGfhMfNTrthqaPen8UBiETScaJ+Cyhkn1I2rAXATpWlajpBoVu1HADU3EQFLh8q3yUhtT5Wbv1vopniZ4RabSbEY3RW4wbiIYEd51jAuBCQk4vgX6xpamSEAL8mwoGab4i+IS2okOYqe+N0UrDCvmIRC+TDjUuCn8Mu0xoZxu5hMrebay2X2h2sBh7yTIrXGnSjqLGjm5YIJUAbmLXzavof94Q20Nk2IzyhB+fhV9OeKhBbVeq2Hfxz52EMcUvfuDYFoapHakDclhGNFr7DsrCLjnr4EThV5vP/RGMO32s34vja1SdIr6EUxPOJU22QRwbGchw817EGx0HbHnerZqSHLulwZ2xZ01Z;4:Gic1UezjqAvsKjGxmpqZnM87M1366/ine6ul7WAcQDpUOfOrFbt3bl4KlRevL3vr5PywlzeH3xR/ZFPYd2JX2Zdd6OAS5bSXDHJx2a2As309/1p3TrYx450nkxGE5Q/B4IIa81bA+R69ie9PFObTOpP6Qosv5143JzMR+1TPQRIBYBza4gcuGWpf0tYTJJsaVEoJ0LrZTzhhAHf01wr8k3MIni8WyjGhRoWhU0Ym0Ufb1pgey0ktV0btKYA0lr3HEhMK9gjNx/lZjWfySifZHQNjq7Wn+bzB4nkU+rkAWRTf+YtLHLhNw8SdNIRMRUiGBiGGjCwrP0xDqJJ6vxtVIUDl9/ON0N0qgelamuPAthy91aVuF/L9GvN9r93aLWNS6a64ZIttNYoh0yUtlY7f9AnmlXhn8vQwHL5uyj98qNw=
X-Microsoft-Antispam-PRVS: <CO1PR15MB10777538A2587F07B91DBE30BE940@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(199004)(189003)(39060400002)(46003)(5660300001)(8936002)(8676002)(105586002)(81166006)(81156014)(1857600001)(1076002)(6116002)(476003)(486006)(2616005)(68736007)(50466002)(36756003)(52396003)(48376002)(53416004)(4326008)(7736002)(305945005)(106356001)(50226002)(2906002)(25786009)(478600001)(69596002)(16586007)(54906003)(59450400001)(47776003)(6506007)(6666003)(6916009)(53936002)(86362001)(6486002)(316002)(186003)(51416003)(52116002)(386003)(97736004)(16526019)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:NPOg6Yw7Xs0PDUfjcs8PBu/06es17pDJ9I1KGNYzM?=
 =?us-ascii?Q?ZMUZJaLsOFJJtOn1Qfh5Zl9VnzMYpVrmvoICfD83HGzdmpr7h2PA5GS/9s9j?=
 =?us-ascii?Q?r/RrLsqReqy+T6nLYowgW6lxdrHQ3pqcAYMmvaYAW3+KMH/l53iNiArZDWDJ?=
 =?us-ascii?Q?vShbi4kVzjAFY1NpkZTqKeOhq44mVyuUIPqwhI4zeRC5YI/12XIPXvGXcZET?=
 =?us-ascii?Q?QHtxPJitRC/0UgRhQIh1ac2dTwJt0itPV9agHiTEGBVKKXTOFeqfgP444mgo?=
 =?us-ascii?Q?zxyCYrjFu7m0a8cCgTPlMIVoxJSBOMfpjWwa7Zq1Ce2YFqf0UK0rZyXPQfgt?=
 =?us-ascii?Q?DAjGQojr6SVAYV3zBp5J1Zpxldeju3dY1D4FxPKnYP7e+4jtXD2Eun2L0iOm?=
 =?us-ascii?Q?4Bjw+OffaiiI2Q9pCuyTwnt3xvonpOf/eUfJlchWvSAPFmMn5Y7H8wVi3rMB?=
 =?us-ascii?Q?1OjN6SiK5jM4WnO5NO7TPog5pJ6XS4LFC5VtJGdg0zQMO7P2goyhNrg4MnN9?=
 =?us-ascii?Q?ByzEt53MdCk82RzDhUpQMECtCrkwIgxubqLSBqKbQMJCkzaprkRX9FmZXId1?=
 =?us-ascii?Q?n7mYwg2jONYyc4OBrY7Ywn5HF1JzBvt6w9ckYi5FSIhWBt6h1/ltTzcmexlX?=
 =?us-ascii?Q?Cq4aHe+lRnvr/k3QPE+YaYSTIQSlRCp8okqJxJwpPI4OCfKtnN3kgBO//C5/?=
 =?us-ascii?Q?GHhBw/ZLuHJYgRnYObHEhIBj6RHUaLL4qZUFscU1yo1hc6U9lIP8ay25uEqD?=
 =?us-ascii?Q?EchhzWHjtwMSmjQvnyAU2JoR9I9harik6Ph0BQT05GcjbTce+LhkUIfo0N4V?=
 =?us-ascii?Q?xpiygoDqtB/XbfgnPag6qTUagEtu+5TDCdbsY/3kjimfX5mVNREdZPYcAusD?=
 =?us-ascii?Q?jyy9J5ZRcM/Rn8/rDJBxr8OHs+ybbNUSB+6KYSc/5kH9twsMXxlWtYfJbNQ4?=
 =?us-ascii?Q?5y5CoqqVbX0GJawwXaoxJ3diIes4ckdjbaEUvcHARwuyU1citmzgQRU36rfo?=
 =?us-ascii?Q?b6/hvCRe/U9iV2zlbAPQvJUSOL1zuHqNQ9cgtD8Mm2bN4TqOhg6sIh9DfLZP?=
 =?us-ascii?Q?CfpBKk4o4YxNp3bW9zBCzdDIWelipswH3G/1Qi/k1Noi+TDvgOzMCJxWGnAh?=
 =?us-ascii?Q?AaErB/SbBNrk/7HSN0JbOMNCYKRSndvFw050OOqAQxnvxEzFbJkGWnyi8ysR?=
 =?us-ascii?Q?KncWzIlx77Xkb7CRt1bWS27GYGhw8vQuXm/J1xMyjl9XhAVKF5o4TnhqpBhV?=
 =?us-ascii?Q?+whvLP95UgEaNL3JYLje0XIkwGHjs+1Gq8IwHj4?=
X-Microsoft-Antispam-Message-Info: FOoZSzlzKvgVwtcUJI/Ec+0jGqcy0XbAXcd5PCFWomKnL4Am7k/6tBefsj3ZzYe+48R3UaH2vu6RpUBHHo3kEru5fY5MCsdZY07pxJQg54iOxmXjb0Bkh7wKCmGSkrwmVgpV29yLgLsPVIwlU1y/ReBHRXDXUu1PfFOjwkYuNri2wmO1plvs4gEvq9MxJvZn
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:mwPLn7jgymZ0uf2jfpY9uPdayZ7K6sKOP0wXDTApPJzBaTlS2/OOeV/oWNVUHGDDhGKhwF4hfKqGrsEOVhNeedpjnjnFb43rvJfifjXoi4kFSUcpHnxO/fnHUVYXacIALPe2BpkBiKstwLPoCS07gR5UiTjS7vqC1dKC8PLw9zjKhnJg1iNQwDvX5U6vjsYrkttVI40Gk1Bya0gEpUTA0UW4Zeunvrsft6/8ZCGuArk9wl5S0c9EU3iBgDb+G+1k5XP5h0Wmcb3QtMQ598llvWH2Qj3ac2plB9213cIRM9Xlhxi6TYxbozrFH/Uu4fyDxnPhAJMdTz4tRgL3LPhXFZxNYGZmMIKKkt/V/4yC4Mhb4APVRIWUNk3lj8XMezcbQoBTbf6IuAKZE0Jm0UfbBIGyQKQzrfdsApMvQzt0m+NvJNGAhFHLcnJmK/SSOW5jo3oQ5zKXgjQHEaiEnIPYXA==;5:s/86dK9yJAr/gFjbCeRfNEEhqvi3cGANgUDU2WL3eC0LyFsxe68UaROnBQ+pIDubIQVDJcRWQQGaShpuS+F1AuPtQa6IH1+Fh6QNU+urD5fZw0d8R1LLHO98SCXrdMPuTlmKQZAkTsZni2d1epSw15KnJYAVNG5jfm87i5OeirY=;24:4jc7J82ZOTjo/YIoW7yzoVq2iKSpCw02je9+voWi0HVzc6I/yGIeqH5ZaRoG4njLTV+dY+9uafqlPpJeQBBgwfZy4XGLwUVPFk2yels5b2A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:641qeidAlCcBWVmcxJ9vpFD80QOaiJKuag0WdS1chhXbWhS9+9Yk8n7x+HpkDtZgFHF7068q4AIZJl6Q0oJPwwRgFgi0pVgIw9ll5l7nufrlTofENkJK/UkBvL5bhVM+kCzj1JkLFY2gHZzQC6EPr9qybvrlTuRUpFFQnDovRx07i6Euftd/Tn8ya8P8h8iCCTEZ/df+ae4k/+lc8F0SNRJJOzIgn3CwbgFZglAv35k9patLNoZoD7QuwPSOdMGc;20:a3Avs4RvQeVKoTyf2sgOi6fXUubaeRZcBIpBh1UWOdFX47viKEsDucso3BB+zaFiSqOMj/oPDYJ7342Ge9XTX/tYUPlBHJjjr7LzwoSfTKqAbTiWIJzenHiTrHvqEUBCSNMpCvOVOCaPqK35Emg03g/hdNwCQp1p5GUh4nf7piw=
X-MS-Office365-Filtering-Correlation-Id: a7ee7e97-401b-4701-8074-08d5bfe8a5ed
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 13:33:27.4597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ee7e97-401b-4701-8074-08d5bfe8a5ed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a more complicated test for memory.low hierarchical behavior.
It creates the following hierarchy:
        A memory.low = 50M
        B memory.low = 50M
        C memory.low = 50M
        D memory.low = 50M memory.(swap.)max = 200M
        E memory.low = 50M
       / \
      F'  F memory.low = 50M
          G memory.low = 50M
          H memory.low = 50M
          I memory.low = 50M
          J memory.low = 50M
          K memory.low = 50M, memory.usage = 50M

First, it creates local memory pressure by charging pagecache to F'
and checks that K's memory.low actually works (usage ~= 50M).
The it sets C's memory.low to 0 and repeats the test to check
that K's memory.low is not working anymore, despite
that memory.low is disabled above the cgroup with memory pressure (D).

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 115 +++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index beae06c9c899..45168a845a5d 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -512,6 +512,120 @@ static int test_memcg_low(const char *root)
 	return ret;
 }
 
+static int alloc_pagecache_500M(const char *cgroup, void *arg)
+{
+	int fd = (long)arg;
+
+	return alloc_pagecache(fd, MB(500));
+}
+
+/*
+ * The test creates 10 nested memory cgroups with memory.min set to 50M,
+ * with 50M of pagecache charget to the leaf cgroup.
+ * Then it sets memory.max and memory.swap.max to 200M on the 3rd level,
+ * and creates memory pressure on 5th level.
+ * First it checks that memory.low actually works:
+ * expected usage on 9th level is 50M.
+ * Then it set memory.low on 2nd level to 0 and checks
+ * that memory.low stopped working:
+ * expected usage on 9th level is < 20M.
+ */
+static int test_memcg_low_nested(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cgroup[10] = {NULL};
+	char *cgroup2;
+	long usage;
+	int i, fd;
+
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(cgroup); i++) {
+		cgroup[i] = cg_name_indexed(i ? cgroup[i - 1] : root, "cg", i);
+		if (!cgroup[i])
+			goto cleanup;
+
+		if (cg_create(cgroup[i]))
+			goto cleanup;
+
+		if (i < ARRAY_SIZE(cgroup) - 1)
+			if (cg_write(cgroup[i], "cgroup.subtree_control",
+				     "+memory"))
+				goto cleanup;
+
+		if (i == 3) {
+			if (cg_write(cgroup[i], "memory.max", "200M"))
+				goto cleanup;
+
+			if (cg_write(cgroup[i], "memory.swap.max", "0"))
+				goto cleanup;
+		}
+
+		if (cg_write(cgroup[i], "memory.low", "50M"))
+			goto cleanup;
+	}
+
+	cgroup2 = cg_name(cgroup[5], "memcg_pressure");
+	if (!cgroup2)
+		goto cleanup;
+
+	if (cg_create(cgroup2))
+		goto cleanup;
+
+	/* Part 1 */
+	if (cg_run(cgroup[ARRAY_SIZE(cgroup) - 1], alloc_pagecache_50M,
+		   (void *)(long)fd))
+		goto cleanup;
+
+	if (cg_run(cgroup2, alloc_pagecache_500M, (void *)(long)fd))
+		goto cleanup;
+
+	if (!values_close(cg_read_long(cgroup[ARRAY_SIZE(cgroup) - 1],
+				       "memory.current"), MB(50), 3))
+		goto cleanup;
+
+	close(fd);
+	fd = get_temp_fd();
+	if (fd < 0)
+		goto cleanup;
+
+	/* Part 2 */
+	if (cg_write(cgroup[2], "memory.low", "0"))
+		goto cleanup;
+
+	if (cg_run(cgroup[ARRAY_SIZE(cgroup) - 1], alloc_pagecache_50M,
+		   (void *)(long)fd))
+		goto cleanup;
+
+	if (cg_run(cgroup2, alloc_pagecache_500M, (void *)(long)fd))
+		goto cleanup;
+
+	usage = cg_read_long(cgroup[ARRAY_SIZE(cgroup) - 1], "memory.current");
+	if (usage > MB(20))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (cgroup2) {
+		cg_destroy(cgroup2);
+		free(cgroup2);
+	}
+
+	for (i = ARRAY_SIZE(cgroup) - 1; i >= 0; i--) {
+		if (!cgroup[i])
+			continue;
+
+		cg_destroy(cgroup[i]);
+		free(cgroup[i]);
+	}
+
+	close(fd);
+	return ret;
+}
+
 static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
 {
 	size_t size = MB(50);
@@ -781,6 +895,7 @@ struct memcg_test {
 	T(test_memcg_current),
 	T(test_memcg_min),
 	T(test_memcg_low),
+	T(test_memcg_low_nested),
 	T(test_memcg_high),
 	T(test_memcg_max),
 	T(test_memcg_oom_events),
-- 
2.14.3
