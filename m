Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3FBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EDE219ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="a7RWzxVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EDE219ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeHFL0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:19 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47238 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726572AbeHFL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:18 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BDT2013912;
        Mon, 6 Aug 2018 04:17:51 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp0083.outbound.protection.outlook.com [216.32.181.83])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruyu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfhhlWDEe51mu+KAsSaXGEeUf1bWqLv68ctIe7rbXIw=;
 b=a7RWzxVVAIoH4fZPQ6nX4ZRMcHjV7Z1BUQzrlX6q7hpZYVYBEdkG+AR9ZCiLVvIcoxPqfqKc6pSYP5Ei7vmBjvmI+xu5Z16QI2ANPxT2FIHEpGcrlI1bTuoZrSIODmbi1wwnXjVmHfWFhJ9qAnuzz1UzTO3RWdWkVZ9vN/XuWh0=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 MWHPR04MB0976.namprd04.prod.outlook.com (2603:10b6:301:43::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:47 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 18E54302F61; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 15/22] Revert "block: blk-mq: Use swait"
Date:   Mon,  6 Aug 2018 04:17:31 -0500
Message-Id: <8ef3b21d6eae4978b052c3384bc205f355cc92c2.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: SN6PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:805::39) To MWHPR04MB0976.namprd04.prod.outlook.com
 (2603:10b6:301:43::37)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef12f059-fa0a-4ce4-4a6f-08d5fb7d79c7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0976;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0976;3:bvRQ07yE7k89J6t8timEx6q+77Nmj5fshh1wZFQ+aWuLg/rpghdw0L8Dnv0tJbUv0mduYrFcI4i9gQSG1uBsG3L2XNx823vPrdykNB/dl/xsFbve6DC4oXBOLz4iLnYgEJ0An1pfOUR4/G2j+f+rhvDFAboZrs6KX+D/R8IHrlhqSZjuaBBHgV4h3co25ZGqsF1eIP+CMnRmCKUBcCMOYF2eTnmy87Bfycd3dBBGqGOHn7o89/hlWRj0GfAh+cSM;25:q7fV334/ITCgXyA2//EJ+uVWZ2oy2TCMWllRFOkZPP9XV0PzX3r6eBsbGinR96I+FUh4d7Skju7C1Qeh/qJKWSnw4Fgs4LXnunrBsT+93YpxY/EccJc2qxaG5slNWwB2RoNnfkWQRPcD88E1/GUit6McDGlUB6NpzxX5Ck/P6qg1HV4jO4MnORTKd05IFEeEew5T7fpzkJ4X76AAStjGRZ5G+V8aJAr6frLYhyOjEb3t/OARF31OznBGnO/obsa//M55+edW7dZp4JWMk9MkkNMmiocOfLXi5YDQp0Nym0/8sxRmfBqc31+n8Y63zwRZtzBHAtFxDp2U7b1yhd1Xsg==;31:phXVil+fYsXTKlYOJzxoxE/L7uE2Qiz09ivhD/WllH9iuGhWa9FsfGQk5n1I/WrNyPemu0iiXuZN0n6taltqMWtx7TE/UtMqw3IVwS3xIoSY6fBIbicrISPcCvo+BcUpz2ihMn/SuyR1y9//wMynuyGqztqbZY7UVSQ5zMyixqpy3AROcxbBhnwvGEwmgVQt7/HFIq61IyNTWz/dIfqsm9b5f2w2NKmJDmTVSq38YYI=
X-MS-TrafficTypeDiagnostic: MWHPR04MB0976:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0976;20:fjYUM0iBKDGjGklKMq+przBvMm/lFrIAa+anW1tD+cBe9l7r+bUHvd2dAlBU1/CHP6+i4Pj9Shu5lXd/76RMbDEcxtAbIeNU3ZcapLx0lB2WRXkED0K5LeSBIDxcFlVfKrCSPMKiIRa9DKbp7jqlhoGA/Ey7S/aYsHh7ym6PYF9X/LJ84jtVb9N8x7+TTe8VN48g8L/sN/eyorjtrUog/7exY1qQ/ZE1b6tsnvptczAJxeP/xe54HOdD8LfMIp7vei3lNYCXm/KFUY7WgNldm0F3cmyCI29D0tiK/OY78j2JPSdFLimt/6pPg+eXEPPhyGo55I0NSmYM3DMIFaoMlgAAv2g0EtxPrTqbtgU6ArVSvtsapdcyZO6Ge54jvBYn86OxOMph8c+3pJL6u8QLW557TyPNrurtZ0L2ib7i8jRYfXahlKBjCJGCn7HCpVBAfKi4OCbqHUeglDCpm/hYLnds2xaViqKMdrnT3vW2OwMm359XpA5EJ90/SgEnV8k+sBpmCf9d3kPEwxoI9ZDo7eN4O8ihI5yqP8RTAv5pjPCmNMGEk+KnN4X8o3YF0tC7/xOerOk1rPsaCPaPEh+IKx8hGqf6dM37nUd6QbRvGL8=
X-Microsoft-Antispam-PRVS: <MWHPR04MB09764652CD901ED2F736EB3DF4200@MWHPR04MB0976.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0976;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0976;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0976;4:fGI0WuMt9OkfUl+jWWrXp4m8zOL0oAI2k+iHfPlM7+3t6V1J4CxnQkfCJN85OeySEQBWD1LLr8E7IIiAoKZwCAOjjm3m6DBl+k1AskBhKZdjPWu1GOY00nOdb8NKMwUDgAhuc82nmqtOuTRtjLbqabGn/oyKvU3nsbzqY7sof9OvId4kyznkIDAdIp5FBp1+H10/Nt9E0ym6HaYGES1FaZNNv8kRZomoSD6GMIpqmfdqZhwSfOn0RyocZEekGipmKlPqJePsfKw8Ov5cUvbvld2oiolxq3MsKQNcV5Oz0W2SIKpBX2kWvypocWPBOzl5ULQMj7KOrqIeJM8dP8c4Lg0kIqpg5zByWHV0fxk+bag=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(136003)(396003)(346002)(376002)(366004)(39850400004)(189003)(199004)(186003)(50226002)(50466002)(68736007)(66066001)(47776003)(26005)(478600001)(2616005)(446003)(11346002)(476003)(486006)(48376002)(122856001)(16586007)(97736004)(42186006)(6666003)(36756003)(54906003)(14444005)(81156014)(4326008)(2906002)(386003)(575784001)(51416003)(106356001)(305945005)(90966002)(3846002)(81166006)(53936002)(118296001)(6116002)(52116002)(5660300001)(6266002)(105586002)(8676002)(52956003)(7736002)(7416002)(8936002)(76176011)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0976;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR04MB0976;23:S11ZvizsI0tShkhfU8kaFDO8jzLbxbDvWbkugKOeF?=
 =?us-ascii?Q?FJokdgZBg/AtWvJowhK4l68IkuaJKoGrbjgQQTrTSRaaeKszeE81Zruc2WQS?=
 =?us-ascii?Q?L32yyeXiFpu+bkX1Eu2XrweeTw8ksuj2kJ0VsHbTNZGFovCLcRUHwghyxcqD?=
 =?us-ascii?Q?9mPygP1bi5VYmsmlk88qF7cQVd3WADIeDDJPXz+t+KHVqGmeDNc1+Sgx5yIa?=
 =?us-ascii?Q?Cq9s4yFZuYiYgbX5UQa+hbAfZkUexfZkbbo/KLXefd4euoLtykrOe+0N7ipK?=
 =?us-ascii?Q?onOLlMY00xoA9xcyrIZPmx83OY9Rxe+Ns8Pc+kdEDe69J4MCbbG/hKEgBomc?=
 =?us-ascii?Q?mjXHS9WMm6mTcwDR2mx1EODn56ZF6r5AaqlEATNKqPQhzyh4Tck+lZy2hgJD?=
 =?us-ascii?Q?Et5MJLlOYH6gJ85P5tH4vvfUV2zU9bg2YUS4DXzl8qyB8zEVIdWm4s9BacYB?=
 =?us-ascii?Q?6MDQjR/zsGV+JbqFv1r48FiQoKrWBaeyLS+ZAH4U6bqFslsF7qV7zeCoqhUU?=
 =?us-ascii?Q?ranpu9YDOlQS1yiCclWknOslu6HAKu4cTqf5KVSPfyj/Pea9opFb27iMDPDp?=
 =?us-ascii?Q?9aZA6gYFIy34oi56nZaxnDzbWErjq1RI2ESYH2ytmc0lk1Lm+PnrL9ZTV08y?=
 =?us-ascii?Q?VAO34cGkBICQ0y0R7JaNG+KvSy1kN2xruBCWatixfs0E2HzIDLTrREilhjer?=
 =?us-ascii?Q?m2N6/D+8elgVUk2i8RBkE40dBrwTLHcwjcNqfROLkHNJIztpjYmFS2J66MYi?=
 =?us-ascii?Q?X18ut8LIsSjUgb/ZfQhAhhxM6yksohm43G9CcgRx2if996pVSoZzMjkXhUFN?=
 =?us-ascii?Q?/EIjPs3jiUz0NJwnfl37vwtTlFr3yoFVTjIc7y5InEL6PP88MmN08tyHQV0N?=
 =?us-ascii?Q?LByrTqZfzSNJO+HgPnHQpUllAodEfP7Vb4dVbtcBz0AF3HT+iWswfjgKmVp5?=
 =?us-ascii?Q?IxqD3juJeh6n6DdKqo7seRVDdXHpWTTYPbj33NxzSVkkrNnKYKh6/I1isMeL?=
 =?us-ascii?Q?LaM/yzmmvKyf1bx4s5Dz6opJHY2yS7D4tw2Lm1L5i/0gNBKFtxkrKdWU15ms?=
 =?us-ascii?Q?/PpSoa+TnQGPdlBH/PGmKDKVQ79156VJ8d2RueZHDa93QQS56gzKDaOXoV9b?=
 =?us-ascii?Q?gWi0WKfIgwcDysfmoq3nGKrL0PB8Ibu0BZyZlejYBVAAa02ohif9G+ZzGVF/?=
 =?us-ascii?Q?3XUN2VIkmht/UYmr1HSPRaYi4KngJ+SrNETrwGGxqLGHjioRSNpf+oPq/Fdj?=
 =?us-ascii?Q?byGcYbD8j34YUT4XkA44djR7eN6C/2gO+7Y9wxhW+K6M6HCtuPJ73usx5RGt?=
 =?us-ascii?Q?C3yG/KYmKMuj9DYGBOVbIs=3D?=
X-Microsoft-Antispam-Message-Info: o5EOPec6WmajoTD7fbIL5OC4dXVeNY79PSzjWuVfB1KQLaHZLaDlaGx4cHydlXYTzflHx22a8BP70FIoFJ8gesFmnjqNl7g0npLryLKZeanzO7Eu5bYwfoK4QaMpGG6Vu9Tq4309TFVE9PS5Ip1GAz+ypU1tOZuJ/VDef90hjCC/1h61g2lmdav8lHg6VFJIUm7ElW8aDQD9ZRWHgKRyDPbGtNlT41p9myl5nED+Ke6lZx8Ef2+mjUjWmBgSl/B2BiLea/777k4E2ur7/TKsDsDfkyO+VcSrxvfqKhEgfJUuSW1+zdh8Ac+Sp3nRY04l6aMnDNJW1U/Bai/LVxWOTL3ko61eO9HfJdtUYBHK/Ww=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0976;6:Y1sHxjfubXdgOBrJBzuQBRG7Dc/JKGaVfmTXmHszprmkzDwjZKpj6wb8Ultq3U/l5LcKv7V0XnV+HF1I6DLeaL0gZd1XteujQm6Rhc8xfSPq8ObYEn9nYC15JTyi0QC6Ax3W+8xZsSe6txJ0wXrpm5SoLRyHu5U9aLUA+8WFyuKpKKULsdpXnTo91EouiDJhfuq5TSJv1pKg9iAYLIbTB2MEyckElBuxu5nViRCTzrT0fFZJh/J5y1Czp3GCVA/0C6+hn9RSjvBpmmgP1Nsn4gY47ZmBlXpEYYe8XBwEeUBimkJjrWeHnl0jy1KgollKgchF5hyD6Q2Qrzj9teKYeUWqzfZov6ZV8ZnEky0HICoB3RBibYJ9zLaCdsrNgTCWY3yrpZQszINotxTxkUW0Qu90V5Pzw3sk9cGKr0rTIxCo1RncaCY4fxbUxEf/+Y6HE4IJpoNbfCyCtW12JY543w==;5:v2demibujqwB24rK3hrzea11wn9asKrXgovpxUhgHDSPPpHHHeiL4k9pXhhBA9CSPzlOuTsPojQfXpJ0U/aXlGzKm/v0E465NTNIsctjxAqeS3q2eoS88m4n7EMJZSS57xIMDn8OPm94kSx3L33afoOLCIbv7xmmZ/1F7GR92cI=;7:L7VzEqfzG19VpgvpyHEa2OnLV4xKiUzRHJ2F7QZH7nqLb6O0hUodU8i2D0zX+6+O+pF8Sd6kjEoG9wuKJkP8j5HW4ntrKQqxBmSnxz7Ss57st8yiC4ygvUN9wUWqgcSLIB0wNDtdzkuxHIbCBKw+m4ZCm9TwZOShCq4dTVHkK0QayIT07i2DPqS7rQC/GpMswL0c+SLB0ZYIQuxX7VeS3wEfkeNX0j9B9L67rhHjgFd5oOMpUqz4flBinI0r88vq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:47.4720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef12f059-fa0a-4ce4-4a6f-08d5fb7d79c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0976
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
This reverts commit "block: blk-mq: Use swait". The issue remains but
will be fixed differently.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry-picked from ca3fd6cf836739fd59eac2f7a9b0261365e818bb)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 block/blk-core.c       | 10 +++++-----
 block/blk-mq.c         |  6 +++---
 include/linux/blkdev.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e4ac43392875..87d3e0a503e5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -662,9 +662,9 @@ int blk_queue_enter(struct request_queue *q, bool nowait)
 		if (nowait)
 			return -EBUSY;
 
-		swait_event(q->mq_freeze_wq,
-			    !atomic_read(&q->mq_freeze_depth) ||
-			    blk_queue_dying(q));
+		wait_event(q->mq_freeze_wq,
+			   !atomic_read(&q->mq_freeze_depth) ||
+			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
 	}
@@ -680,7 +680,7 @@ static void blk_queue_usage_counter_release(struct percpu_ref *ref)
 	struct request_queue *q =
 		container_of(ref, struct request_queue, q_usage_counter);
 
-	swake_up_all(&q->mq_freeze_wq);
+	wake_up_all(&q->mq_freeze_wq);
 }
 
 static void blk_rq_timed_out_timer(unsigned long data)
@@ -750,7 +750,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	q->bypass_depth = 1;
 	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
 
-	init_swait_queue_head(&q->mq_freeze_wq);
+	init_waitqueue_head(&q->mq_freeze_wq);
 
 	/*
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e0a804ab5420..3a49552974ec 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -72,7 +72,7 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_start);
 
 static void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
-	swait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
+	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
 }
 
 /*
@@ -110,7 +110,7 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
 		percpu_ref_reinit(&q->q_usage_counter);
-		swake_up_all(&q->mq_freeze_wq);
+		wake_up_all(&q->mq_freeze_wq);
 	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
@@ -129,7 +129,7 @@ void blk_mq_wake_waiters(struct request_queue *q)
 	 * dying, we need to ensure that processes currently waiting on
 	 * the queue are notified as well.
 	 */
-	swake_up_all(&q->mq_freeze_wq);
+	wake_up_all(&q->mq_freeze_wq);
 }
 
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 34fd1ed9845e..fdb449fe3ff7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -468,7 +468,7 @@ struct request_queue {
 	struct throtl_data *td;
 #endif
 	struct rcu_head		rcu_head;
-	struct swait_queue_head	mq_freeze_wq;
+	wait_queue_head_t	mq_freeze_wq;
 	struct percpu_ref	q_usage_counter;
 	struct list_head	all_q_node;
 
-- 
2.18.0

