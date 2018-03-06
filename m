Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AG47ELusFLtkCS8e2dX2CBlxB1xlqxSugaeZOh0q14PY0bv6MJ/iu09pjr1DQpZaejqYzt+vis+4
ARC-Seal: i=1; a=rsa-sha256; t=1520358249; cv=none;
        d=google.com; s=arc-20160816;
        b=x/mefr+42N+OYWhhsog6Arw20Co9aA5cap8aJ/XIcQR3fxGSLBccne8u+AhDH5/RfC
         i4PPLDi8Skv6FYLowH/oxb07KtjI/FrS8J8wrlJBdGaXitR3dZx6GyBkyGCKOfEK+NnW
         NYHiFJP12SUPg3yk2Gclm4WYKo9cTOpoJh07Lk7RpGKSpGR585ooaq6y8cMDCPo0X45c
         tyz4IbLIqxyYX1RjdCRsuW0GkQCK+qNJ10wnplvUyUY0UJot0h0vmRC2n/1QfYlrsUgC
         FqrfKnJ265wGIu4mJSHcleFUtWNyRgxbIiJGPf7jE+6TxO8030xB3gwOXbxCvpt8PXX+
         0CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=O7kE3j8T45clfU2nHMzIW7CAn6Zetq54RLLQRatnQl0=;
        b=T/NPt+j8OO1XGBAbW1jQDabQle7+ZgRvjZwJiQ4SuHLliTs/qVeIJiCuXQ5RLMfUTg
         GkJnMIfCr8wGk1q3SqWo43upVPhKZ5cJm+ZguQW5/BaTmRyDdXP0v76Z2nW3bn3fApkS
         TG3xcTVornNlP9wtWRl1ZS6D/HQmdsLD4Zfnbb7LGj1gO5GtGUfcOYhrA6dWTSDzcvPT
         Xnj1GMjTE5X+l+ouLz4lryZoMGTW5bf1WoPn49sDUjuoBz7Gex/mFfjIyAvnYYG7KHD6
         nv4NLVLLhAKzCZt2twg8LM3lmoiWpiwrZW0PHI7NOOIo0kTnqIlEcLDdOW6mDGVH5fMT
         Rwjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=IwyWFFoh;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.70 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=IwyWFFoh;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.70 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	roy.pledge@nxp.com,
	laurentiu.tudor@nxp.com
Subject: [PATCH 1/5] staging: fsl-mc/dpio: Fix incorrect cast
Date: Tue,  6 Mar 2018 11:43:44 -0600
Message-Id: <20180306174348.26095-2-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
References: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:404:8e::23) To HE1PR0402MB2700.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92511ad5-78d4-40de-5393-08d58389dc58
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;3:XK3r5n8LoSFz4C/JUTrAIgMpXBfz7Z00TZIlfbcPYBSY5+3pn6PAlhLSth8IAe8JXCuxiKvvsalFeV1O+iAw+/CZeW4EIZ9SDIZJLkz599yn5mcHg1zUJOZi15gklOMTJztsng6Mam18BiVgbCLBMchppcLGOe6vXfLWlgs4ODefqC2UaPav4BbzKRpg+nzXTDFAItxPt4DPtSFxGpotIJQOSU/MtIfgRZ5H8lpqLAE1YCbB/VLWZSjReFypKY03;25:NIv9L+aKum9H6/coCmnyWgUbe/lAZPoq2+GrSSRoTpUMYAvj2l9aOpXzPNza+fq/ZNhuiWM9M1STVug+OePgVBeYx3siP/NKYzMqWotc2GjIZZdAJrLg4r5o3mEuqnAFqWLb0f4O18hpODYOXDXRp8bf8pgF4n+rLnTzn0XJWgobJmS8AAZDKQBeeU9/Iolp/IzK0sDNXUnEVCGg1pSqk3NnwxEe5CdkQZFYhvM0cVHqiVvtz6DlxSUcpFuQ+7d2Xeu0DV7Zry+nPg5lyYuLS1CW1vqNfmbhAsoDdRc/iZfBnApjsDtsbDq3GyVvpz+LZLI3VVDcMz2BhjbAn7HAoA==;31:TaecCO+UWxUwcAVdgFFleOHsfJOf25ob+sLXULUCsFUQZOXo8g4ILEoiPDpBYSXRH0VS1pskG+0RcCcU5knQZPZ62/66YbCH4jWL9qNNftpTS4FK447Zcl+GDLchee58iGCgnVw7yk8PNeR6Fgo8qvVDKoC1TJuE929Y/IH3ofSIKqoWbByHSxYnT/CE1xU79/q1q+YCy19TXgkIGHv9COjCtVYhKMTO1OWFc+K08zk=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;20:Hjh8x/HFqQzZB5YX8ExitD9Xq9dyZDedHLwEMJ54iqrfD0aCMMoQvLhmTr892LUAVgdsAAlPjDbRUwxolP5a9CD3iZz0Zdse+UJbnrJbG194VOWIhZny7Oz4YmQvwK4q3k+BBmcckAIOLOBBvGm4kGq/LLDxXO+s1UuRJqurZ6ddFxvxPQAHEbluXqknPmf/9kiV69HiqnisiIgmJew1+QPtaici/t4KErHxyckjg7q4DaR1eC/Dh2UpH4eIq5KkP75g7WlbCo6LOy9TVWKGGnDssN+sOi/RzJvoalCBHvoOOAKLnNK8I+QDHZtTcvvwh0ThFfCxVaRZR5MCMKccchdWZXqJfqZgRBrAsn9414TK+0tC5ygvynsZoOpB52MQGrVU/cxPZ3QtOkVQRG75bXPplRIDKzGbvtglITw0LjdA7DmJbcx7PvSr9KSNNfiHcbcxQ2AKwnJwsm3/2TrNmm1cjIr36GBRVqe3sbD/i1fcK+FO825fegeq/6DFwZiq;4:bDkuQSyxQIU+pvD6eYz/bvXefGg0NRwrmjqq9Hp1pTrzCeLOotUYUbq5tjGCVj/VqIG90Yu6VkelUfrISoqYenn2+uXAQjDV8qlQ82orsHuro5EG68J91LaGkk4cDEJbcJuHxs0oveKTf+8hoDJFd14pjWhK0OnvyoCi9AakM1KaLccoVDFQnksMrJxsI68Mh7Gzz0cz59GlTdcb195wnXzSqtjEbZYc+NClCznZ/j945w9U6XkH6dow8bK+1ZQNwznsTwRFA0g8M2mIx/Tx/B9Y7SGqLKBh5FdI6+JF+Qykn9JnMFk7x2LhmeZzayV/
X-Microsoft-Antispam-PRVS: <HE1PR0402MB27002993BA768D98E575CA1D94D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0402MB2700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2700;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6916009)(106356001)(3846002)(48376002)(68736007)(53936002)(6512007)(47776003)(2361001)(66066001)(7736002)(97736004)(51416003)(6116002)(2351001)(52116002)(8936002)(478600001)(76176011)(105586002)(2950100002)(316002)(26005)(8676002)(81156014)(5660300001)(50226002)(2906002)(4326008)(6666003)(50466002)(81166006)(25786009)(6486002)(16526019)(16586007)(6506007)(1076002)(305945005)(186003)(86362001)(36756003)(59450400001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2700;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0402MB2700;23:MG0NlS6B9CT4vUI9o9dp0joI6Qf+g9Cxj48IzIF?=
 =?us-ascii?Q?hXfX67TMkAciV8biEFL1Rl3VoZGDYP27yL53njfFXLOzCxEx09gNTm5umsoh?=
 =?us-ascii?Q?RXGD+UnGXfMg2rtq3xXOdoofR5efR9wWvImAQ47a3CNoRrHg3xYaz+RWtKso?=
 =?us-ascii?Q?YRQVbQKBZDmaWMwZAazyyMkaroI81viPzq+hILvmlo+wIgf3TKh/Y1CKKuRg?=
 =?us-ascii?Q?R8SH3jdn2AamthrgEsJhxw918qIjugMAbqLFTNZcG0Bcjdy+V3YgtzTBe3nB?=
 =?us-ascii?Q?cFYmW7tnncpQnq/C4IcHl3J6hp4oaAbpizh8wQCP8SjysudqsCM3MHHdRsxx?=
 =?us-ascii?Q?aMHe/c6xB7/Hi8nqOxgipv+d3vqvz0yZAo6KlXTCw+D43CDfKvPas2oXlyV3?=
 =?us-ascii?Q?B46MQ+CGdwiaowb87DIANiRUbQbKiSnTSN8MMa9tVxHT7lDlgEYHN4SKKiOh?=
 =?us-ascii?Q?7NOtUrMgidJIE483Gs9ub834nho0Qk2r7QOJ9r3q7hqubM7zFtsutk13OAkh?=
 =?us-ascii?Q?NNL5atzFeO5RTza3hPb+vP/YE9Ec1MuqpwRYMqrUMHvObXbBnI2exd5z+bt8?=
 =?us-ascii?Q?waGNaWQeWJGkGZXgNr3Jszs0qIH/hJPGJJAvUboEs0ZfO03+Ev6Fcl2q7QWu?=
 =?us-ascii?Q?9ZcWRgVIc7tcCuzLYrkmFJIzYqOVR9ojBmNgW/u18Jm5sMCUbUJnLT4uysYx?=
 =?us-ascii?Q?oOIC+rf4o+Jv+1O2oGXprUVvKdBMdodGRZR5LU7KQ22pvu5qtjx7GhBF8KJv?=
 =?us-ascii?Q?w3cCN+LCsmF3tNaVMIxWv8YTFewHlY12FvF2w+X33N5F1W/zCvBwB/4IfK8o?=
 =?us-ascii?Q?jB+mCINNjIHWg1x5sbK0hbL+/7f7sD77jJc1hkL39USmTpSiSW47YryY1/f2?=
 =?us-ascii?Q?NueVQaLil7c6OSso2oSccN8Dh7llf1OfPQ+8nvwc8azZGHp7f+ttkUtOLZe3?=
 =?us-ascii?Q?xH1J2UtCdyH1MR2ciEI92t6171fTtloSeBm/aew1FMlAW1EUBb1coahup6tf?=
 =?us-ascii?Q?bZLSMbToi34yCO1ngmpfhtRiT/YBrTmDdecEtaTT9PhlpG/010hkhLG9a29O?=
 =?us-ascii?Q?OhHPaJWi+Mhl5aRyofewu4sd+hZhNG3m2Q8xzX/1gdipY2/feCnTzNWqyhAE?=
 =?us-ascii?Q?WT1rLNC7+VQK82wIvDeuK+cjDnsC2cv5MqSNvAX7jKjR5melTqsfuZ++obA9?=
 =?us-ascii?Q?P2vhHaTKMF2yQv/g=3D?=
X-Microsoft-Antispam-Message-Info: h0PNV7LrBBZaFksxwxjGhcQzeyM9fqidnwuqWmp1banVtVOU6MOVcAD2HJz3krTJdlKzqAtA3E9zK/Gm2sOtKNTeO+ECkWmdyPxuwwzitS93M/qCOgySNNEkimpdtkzv0uvjO0L4lyKeSQqpYmf9hAza5R8QGQF1pJtGL4AMACoeI6BX3WQgvbxt3n44hD6G
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;6:+bhhB1hWyAEipZLNMlbjOxjJxb6CK9e3S3z0jnX437RsxV5CXegPe1nkJIzovtZ54RcSKzwOp3GV92nHpx1e0+ep8w3feTvocMTqNlPJrDpkII5X58PPbnmb1Ds8ic47Ww7OsA2q5U3h34usm8f97zq+RwMshynVErBnIm7sYAiowjUm7SlFZHct8iJ9hT9FZWG+o2yFF1GU6oV3hNd+L4GeRp4zjSc2aTGisoN0bTlQe/XXdM57OMfCrbFwmvnw6OKjQP+oVHGeI3wMM+Ns0OXu/uG1kzzluhQbUbRa2VJrPHeS3xCUQWPtcxBshhmQ9toteWUw41mKrNqIbDtni/G4vbv5jjN+FCNn1Yrt+no=;5:pS5+CnYxTLcZdvDI4WqC4YYwmS3nBwug3MG2XIVUWv594Mcli18vo7nPPoidnAzcHe+/SzSLy3A0aRqpdGkJpNM9OkUoZb3Sqp9CRkpM0llrNZkSoDb7sAEacdJeAb0VAPnmwNgUfFoihOxy+YDzx/XULuELn7CP5BXuR5fapO8=;24:A7k5dAuwFqHOiX7u8eO8jhWrTE95VA+FZREtjI08lultelJxJTVzvCbqS3S06c1os/yZ3fKgWyC4a6qjH3dKD8g05lxNEJekRy2qXBDd/4Q=;7:BPiD3irPa0xXHjcueOB8OAwEx0vVsG89I2CjBrVjZfkagHGWFg5yJ3FD2LrU4PEM9so6FnReWpWQc+OTEWwr1dAYP0AvPMxVFFULG4DhboLKUixUVtLD2IO0zLUm8h/w7kLiVU04qm2idxCwf0tkZ0vVv4uTyl/SUPj/zQ2157XZkshcIVdtKvVkVK0+bwvFFMI/XH9pHOrn3TiANm0m1NnAhQM/iw3mrO3aW5WpvmcSUBD5gF+qZh64zNPpd2Q0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 17:44:05.9264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92511ad5-78d4-40de-5393-08d58389dc58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594211171543041638?=
X-GMAIL-MSGID: =?utf-8?q?1594211171543041638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the cast in dpaa2_sg_get_addr() to the right place.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-mc/include/dpaa2-fd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/fsl-mc/include/dpaa2-fd.h
index 3e02200..70501d7 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h
@@ -287,7 +287,7 @@ enum dpaa2_sg_format {
  */
 static inline dma_addr_t dpaa2_sg_get_addr(const struct dpaa2_sg_entry *sg)
 {
-	return le64_to_cpu((dma_addr_t)sg->addr);
+	return (dma_addr_t)le64_to_cpu(sg->addr);
 }
 
 /**
-- 
2.7.4
