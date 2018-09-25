Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17376ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC7220C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pYTrU2cK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TmXrR9dI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC7220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeIYVaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:30:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55112 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729708AbeIYVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:30:06 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PFJSSF031178;
        Tue, 25 Sep 2018 08:21:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ixQ1/NMiIrsWvx5DROYlbOmzRnL3ysOy8IplPprStEE=;
 b=pYTrU2cK2aH/rjXONN2NXRZfv/Ib+KBv+Ozxh4WcxE01HZ/2So88j/XCQSsI7XuSEU3G
 ZCa5cTnS4GvIDsagJ1wCDQO5ElMNT8JDA8UyKiIStSwokxnlJQ4gRM/toqy+ffg3PYVm
 oxDA7Iiae6U6FMRVm7JSJGJxdJQEBhNQBMA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqq0g86r7-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 08:21:47 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 11:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixQ1/NMiIrsWvx5DROYlbOmzRnL3ysOy8IplPprStEE=;
 b=TmXrR9dIlNHcqhLl5sH2Ih+RP9A0p+BY8EkdxfDCWHKymcjPvEoAstXg8qQcjWz338lIhvWb/4lTtu0teme2cPe68Q/EDNDlBXcMfr2dE0hEBoFUvpNk2sGftNr92MnG30skzjL/iDYzP1mXk+4VGVns/SYFwy7dh4UnPsTj0Zo=
Received: from castle.thefacebook.com (2620:10d:c092:200::1:f4c5) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 15:21:40 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 05/10] bpf: sync include/uapi/linux/bpf.h to tools/include/uapi/linux/bpf.h
Date:   Tue, 25 Sep 2018 16:21:09 +0100
Message-ID: <20180925152114.13537-6-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925152114.13537-1-guro@fb.com>
References: <20180925152114.13537-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:f4c5]
X-ClientProxiedBy: AM6PR06CA0025.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::38) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0428a87e-a7d5-466b-86fe-08d622fa9831
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:KKKHku0JP7zGhxPCH2MFpNksD+fI57MhXURT1OwGRn3ffQjqwVFXpGjiJVSix7lz3T/54uf1N0Wg7wrhFNQphWUsMslXfa5fRiasCo0EtOqBUHzjm0NFMyGLicaMDzMvkWu6WZNy3sBWsTrxyEG/YZx/ojbRj7qOjwC1pVirjFhe4v80QiYIjbgJpQ/4oVgSCw0IEfQ821Cl4I8BNaZtXtvKFiDyVAG8ZY9n33lY1KiTULzwwxzZ5H3LrZXus8H9;25:96ppVAWNLG9f/rR4W9kIWGec46KuxtHN7hFvzOdExaUWtxLXRjTsIumQw1Ml3fCtgR3KpwSdF6goIYBRz6TSEGwrux/GVWwLtQiYiXhNCb22SSEpe9iU6DnOn9CYbp8jzSHiuWeVkLAByGNZOjjUy2RKlSPz4kQClKGSdyzEb5Qc8cwUWJdsNJQfjjSNCl8jcw4HSMDtv/mC4Wk6JMFXZz7lnfImdzOFeEdXwSWJVLaKJBEJdvXfadjHyaPlUiUOMI90T5tOy+EiB0R9XtGp4JUCev4s5WUyaNuV/A5LVvxtuKSYeAvx/qMzh6cnn5iia8Rkg9FsYzIwYYA5QLyiFA==;31:pqUhvnX1+5SwoVRK0wPDjN/jREg+ey2iEFJvBzypio8wH36TbgZuCTnKKgbvOvFWwaQmJcnGRBeCVhtyv1DUfBs/fZU85zVpOy/+toMx4VndoRM94iqxMWdq7e3q9UnhBqhA73Boekw8rPZIK2B5aTfTUqSMXWqU6s77NqBexjTZE2h1YtkMXwI96D7rfbvm4wYH7EiMi85e/PATR/HYmlmFUnFCzxfcKTEjcogiT64=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:kOTQddtY1G6zPVo5yGhdDiENlaqVrKnXDWqJrcYpm3MuHXfN57uwWIUgeIbBz5iNLGbsGgsSHAgNaUZKl6E/JYPteYxZyfocsb6ZgwKF0Zp9AunRgnUdDEJV6oU0XwdgwIaNAAvpd9ixhx/ZWcolWL4+1pDOUqLLrDhqUDX23lKm2OaD2MLFRqdJBpBRx7k3NfvCbtIhxJawhE2KH7SwWlnajsDfalXduWiyuT/xSDYqnNhaFWRYNXP4Q76eIy0OYvh2NA/UmW6JaDOiVp6EeCrQEcrJKRy5BngqmjNXeeTmIl62XhyQgUdHhknClwfhhjvNxCBBgDPYFJMmPzrv2ffuRQ5ZntnUL/6nOsCZLn5r8VyydfjUpGUE+JNlZciuJvFxWVpC0oJ29k5xpSlMT4hTTo0GBix1EoS33YxddNk1nY7MWOW7oHSbbYA76CSYBKb4EI5OwxDWPMFuhKypveRnkMkHn7H3M45N7n4x+VvEuQP1vEVTn37sU21oX7a+;4:2LjuBhgfvb0AlIw11nhXFd6N7qBCZpERAJ+iNLuFPT2RWnl88WiLFLjX//jq9V8vV37oDF2nn4uiOB76/cZG59vPTuyE/g7LM5oNr06cQlSrY+iQbP11VSudD7aV7OqT365VlHcKe87iAIRF0kmuh4UQ6R67PqKPyEg3Ql/z6ABqSkt9iDOO3EY7I7NJbACsSk8ZaeXPx3YqS+1RUsBQpm9A4dlzXMkmAfibutu1Mcws8VH/MqxyNcvnnUKp5zDKVeOiL2JeLOxiFyFzxRgw0UmA0hGgIIcY0/L+iIO63kAgmIWUDAbGQ33ap70T4a7T
X-Microsoft-Antispam-PRVS: <BLUPR15MB01638C78D0F5FF75BC9651D8BE160@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(39860400002)(376002)(189003)(199004)(106356001)(105586002)(16586007)(2351001)(36756003)(6116002)(53416004)(7736002)(1076002)(305945005)(2906002)(4326008)(6666003)(186003)(16526019)(54906003)(47776003)(6916009)(50466002)(53936002)(48376002)(6512007)(316002)(5660300001)(51416003)(52396003)(486006)(446003)(52116002)(476003)(2616005)(76176011)(2361001)(6506007)(46003)(386003)(68736007)(11346002)(97736004)(25786009)(6486002)(8676002)(81156014)(86362001)(478600001)(50226002)(81166006)(69596002)(14444005)(8936002)(34290500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:T2hu7q8FpuQp+x1JpIepqW2Hjq3jCyXtDS9W0sC3z?=
 =?us-ascii?Q?pv7DqTIwpI0y+s+sqcGWzsUDgcDg62xvekA3AbGP1tTPk08QNn+yAZFXHMZ+?=
 =?us-ascii?Q?PDEN7HBN63kVQA+iJKPJ9ucXd6b0wyrvvYCprvWzSojO9fP8HCd3FkRVjxcX?=
 =?us-ascii?Q?6L1ETwMB5iP9Y7hVVv0x/XwfZaBTO50NZfoE4Jy1Ydf9+0vCqWrSQkeO11oY?=
 =?us-ascii?Q?8KzJf+wAWvdhGuV1pnOjeq4BYozP4f9Tx+L347qk5Rwj3vdv9RRUlqCTb+IP?=
 =?us-ascii?Q?tGKH3a0R0jZj41sjrAlITrxNNHeozAPqss5SNMh8lUEgMGichaW3pbvFieoW?=
 =?us-ascii?Q?aDMCiRK8W77kMnGFylXxhI33+h3aJkb4akk5H3nVKAXWUL26Ct0ceh9/zNFm?=
 =?us-ascii?Q?ieVjeZBbcEdOocBbp3JM3tUlu9Glk9VyRxRwJg1aqUggieagD+qn92kvOA0+?=
 =?us-ascii?Q?Bkzr38mu/U+zMNa7KCH9r6Uxn2eB3B1bOKXXfu7olEkZUilrdSyqBhUQyjGo?=
 =?us-ascii?Q?RibxSJRrGFj17t1+RTICBigPxz4ELstytpFsyH2ujLXp1TWjZiqvSEMW677M?=
 =?us-ascii?Q?skFylEdNnU540mhaasM+sFPvco1tOCy824AmX2ni9rl+HPvdxu/oUdlP2eI8?=
 =?us-ascii?Q?gO382YD3sdeW7m3VUldfnFzGsGHnLCaCnRFWD4pTdWgojMz7PaS8XwCBr+U0?=
 =?us-ascii?Q?Fof95l2Rruvyh0zDZDlv4tQK3OoCA45+FsQcHiZJF3I88JsWlpJUU0mg+UAI?=
 =?us-ascii?Q?a8ic97Vmq/n9zP/32Nqg9hQ9Zw/AANqYZNbNQUBR+K9kZbNd9vgzoH0iVjK6?=
 =?us-ascii?Q?OQSdsRsA+NbE8ve8kmm8gkDsauqJ4qpSsY0ZjR3xwFfScx/FrShhZc7Zs06x?=
 =?us-ascii?Q?H6vili/4E6kb5paSomL4hUQA2MAVgJZ5H4B06wiMwqwODlKlhSLIe0T8yrgA?=
 =?us-ascii?Q?MDuHbi2uWxeRfHH8WnrRpIF8vREPgfcq6AiILljiP/v+9ku/hXRvdK6foj2L?=
 =?us-ascii?Q?pECW11h+fgMa7Vu8IozJwExDlzAS15xQQ1DeYrK8bIRM+NXjiC1lXpjGry1o?=
 =?us-ascii?Q?3UyjZF6bLSTd0Yuvf8kqHmAWHd3edWRkWup0A2wHovOy/s3ZLCFZNPJFxUkZ?=
 =?us-ascii?Q?KmB8rL/NgEGz5ShNRZSwHGVswM6toim0RWE2JFJGdc/cSM/PhcpAC8QbIJeL?=
 =?us-ascii?Q?rbv1fwCcG4f/Qz8VRtI/cJzorYyDMR7/VQJ0b3e1EM3UNbDGGh8YcBZea1jh?=
 =?us-ascii?Q?PBZLfE0KWRsqJsTwirZlrG8VtOBkwYRQa+Mi1mUyKRBA0GxSJpiAElRT+LNu?=
 =?us-ascii?Q?p7R2d+IdXqR+NSWj0yTZHY=3D?=
X-Microsoft-Antispam-Message-Info: wRI9/v7GdFhZ8ttuK4CyYUSZjWKdKG6Ji6oWEcjMYE3ScqRyT3dpnbEcBZ8ZWz5S3h17OG8m1APh/xtyxx6SVlU8jpXvpkccOxr7CPR4Q2b3oU2O5BZ9N3PooIS+oK+BnUmc/de9khFbgEtebiyHhJweY+WioU4VOkmtyVmHc1n1XdYIS5GQ/yBBaLQupFlamGnU9nBrDWvlwMM38wS4zOtIe2JH1hzlo8XUYP7wNjM+zUAkDY1pv7bttW8xfU7DjWTXjYhLQrzJcFnlPhbyWr06H/iGQ6eKb2TSgBsM5nI6q/FI1elYihzqVfSOzyKFpMRgSMtrGZiC8wzOCjTM6fI9UcQFSJZsAy/DrogVBew=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:X1016bf+eozTWn78l219Xwf58Nk+x5IdmJIv3LMEHcwufquS3EhTkGXGKL9tTBG3Mf/+EVUcEOHY84c8OnzSpnymiTE9zBma/Da8xTFeQIDv9goUoPSzWebRanyThBhcWrWKNvya7JmZe4uWVOJ2eXHUWsfw7mz4Wu0li2/phvdAifa/OD8DU1hMvIYS+EX8ydWXMGXXH2l1FwRnpUG7DWO4jabfTmRJuBkS3/0TKg9KDaCtKtU60BHUHtR2EXlBRsY/dJMkK2BQO41yVROyZJEZYU+CwadK/fuW7yJVPTtZiz2DXozo9ozoQyq4Iovo7fMs+D4NVbCSB5EDtO4F+bvHhqxJ/ymKm0pxQbkHC3uETeah9udqJTDDg04dpQ/2oYDyXveM7iuQh2l/1QdqI1wdnM+5xI/2v3zxWw/k7sKRGzKQyWSvjwqg4NODm9mnL8TASUHA/QKPQryDLhg0sg==;5:BPO07xc+Td6Y+8Yq2n4hbdH4NNKjqiBHxy0XG+s5MaEx+DEbGqRVYzRnYXhDqjXbpAuPa+HNFRfyPyuz4eUDt1DX/L4PWHE9CVbGMoCl4X7Hyzhqh6+0VQAQocHWwGKbOeidNirwh7eFGhCyLalsPzo24Liqp7dzbQD7SznSi3Q=;7:XaGEG+W9Ph8513u6qLC49e7PBDyHd4rb/b/alZBH1G2nqDTzFiPrRF3nZzeBp5FYxfPemu2S7pq8nWRhC0viKoFzaUT8Y5r1MKA2sw9O7QPcCvtwb4uiJUgznEyfmGDuaDwLDwulDwTZXxapu+G75Nk1RPZlEn2SuMAewqPxyd0sp2xw+Bh5pveHfNNdXRrDzh1t6aA2AKM/IJI7+JPXqYQVK02Yt/jzmOy+C/sqWC4Jsz0fteArGNh96AvQpMbr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:iyYKQDhcQsuE+ywiWIARPbEcoA3vQYOa9b5A2/RZ0qXIyUZ2h3jSCHt415r7UiG3a9BjBQPj/CbLMh9D+AU1s0TeDE6So8HYmRhndGRd3kZo+sjJUh80OVt9Py5dKGprKOyOCxC7coWt2sLaY43ApWK8nWiyKvwXfGO0dehUkSU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 15:21:40.1406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0428a87e-a7d5-466b-86fe-08d622fa9831
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync is required due to the appearance of a new map type:
BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, which implements per-cpu
cgroup local storage.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index aa5ccd2385ed..e2070d819e04 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -127,6 +127,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_SOCKHASH,
 	BPF_MAP_TYPE_CGROUP_STORAGE,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
-- 
2.17.1

