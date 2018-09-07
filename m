Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A1E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SWcG4VFC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DHKJ6+uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A1E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeIGVgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:36:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbeIGVgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:36:02 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87GmCJV001033;
        Fri, 7 Sep 2018 09:54:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+dBHRTpz2GYOsAmFvd6pHmFqMv0/LRIia3zdCyI1EhI=;
 b=SWcG4VFCToi8E4f1cWDh+vnC5cctez3Ef12DJyyuc7+ZMiYoOzddQ4fZmCSEDXFDjgo/
 QatVcOQH/BJZC7Qa1tCIGx6YXM/X1v1CBiwjSBqP0MzHYPbe4Z1yMa9eewQVifDxH3zz
 x7qhpjSvLhofsd88c/pkWFbG0COYnrc8LiA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mbv1wg7y0-10
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 09:54:12 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 12:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dBHRTpz2GYOsAmFvd6pHmFqMv0/LRIia3zdCyI1EhI=;
 b=DHKJ6+uuJ3ZsRwK4ReKsrsYIvI5Uky+Qy41kwUDaKeY6nyl86M0u7hWlMxXg17TLwl2yTQSAT87ERbE0ABT7fj6UtuL5Q7az+CJ0O3YImhXBURUWNHpg9/X5z952kk0yNao5LBFAMeCxxOXgb/w3VevMna26cRpqOQBGvyfD/4Y=
Received: from vall.thefacebook.com (2620:10d:c090:200::4:cd5) by
 CY4PR15MB1223.namprd15.prod.outlook.com (2603:10b6:903:10a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Fri, 7 Sep
 2018 16:52:32 +0000
From:   <jgkamat@fb.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>,
        <jgkamat@fb.com>
Subject: kselftests for memory.oom.group
Date:   Fri, 7 Sep 2018 09:49:22 -0700
Message-ID: <20180907164924.13789-1-jgkamat@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905010827.27743-1-jgkamat@fb.com>
References: <20180905010827.27743-1-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:cd5]
X-ClientProxiedBy: AM6PR06CA0004.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::17) To CY4PR15MB1223.namprd15.prod.outlook.com
 (2603:10b6:903:10a::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a5c478-9361-484c-6d4f-08d614e24fda
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1223;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;3:Q+mAAkkBaIsbkEdSxdIDiAWpJbxwOUyhc0zgr+PmxNntZQZDUqoYdFXig7mNi3n9Nq3bDSCyiZTcxEOZM5zbpx8QUxV0p+iBZhBLHHsf+Lef6GrvoRLq7fcsRwp1DkP8t4N+KXh6qUL0Hj2MZCg409dCgFrqp8C06t0LlSJMRWotCTRmb7EJuozP+nnPWOe0AbdI4b0Twd1ZZ0MxqJrIk74KrSv6VpuVxVYoVV17WVe94Wx7hVxftBn4YMahwGvl;25:vGrEO2/krfPIw8JGLQ6nZX1oKNPRGfkHToD2Oa9Du0J5m9pczIQfWVo1suXKr3VyOsA/gdXW3VOTplpAyB6sCUPhVxk11T5Bc6tT29PnjRgbH4MNELiJgAvjGnlr+wbK7tfOwWv5US01PSmNN78hRqo9D9jK4a6Jv2en4YRtTBohg53QgYxEG0/wMxQeZ6sQa0XPCG2yXyjrDnqpb4eXYjyLkDA+KKXVDgdT27sHJZ/Os+m3Yw1G2vtJiRyDku8bg/F3yveL6DLzQolw+94sGq9Ejr3nN8tb15VtTLf1fWC1HhfUvzoAVQvBTctvD2ELr+JghTYhJ1L4Xi978ba69Q==;31:N16F/gve7Lp75oJ+XU5J5458vxpp16uhaF6JEDjr2lr7NCvNvY0vRcmJTmoiBWm3KdnHr221G+05t9RJbeqwILyEaLGQVTiv9zdEAuOhh/vGpXpzdMZbPUp/tZq1sA5Br1k293d4jzKOWgWVvR0ex187keI8D2q+vL4Fe3y07wLzuieXMq1/qN33sz8GuRb3Kwzamo1Q/leaxrHKI04At4IWEQnADUOhrxF/rTlB4NA=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1223:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;20:Ui4HkVRV9EvJsMjH1DwfLJBtLcBhQ61CfAkCaQ2yevv4chGk3nn0HlALRVV5SJ/najDasCBXvdqtLtSQYAWoyxbZywdiioRTEpk/JnBo8OzOHgI0MJOD2GZAbRN9z/ytJeGwnoDSKInEp5+Yxorrjkxt+IOYoeleFowLtQeHdyyARKa/xNCtKyKl5o4B8MYgCmrDM6+0zMye2nOndog8YIVbI9cp9u/7aKgXw8ZUEdmq3y6FyvOcXfmKkvXUBrptmp5RMOurM10pQ6NiL10Y7PQreXE5LP1TOMcZiKBGJ5YW2gq5BdGd1lBytODuP9TwVAQEC2GpLi7H1QNJYx8QBGO64b7gvrBfWPyGp8aOJ0QHTOZwUWKdL7AZSs79Y72+uyuaJrtNcINtEYpB6cDBBwCptnef0Nei45Ds/EEKiJa2840lmEzDwMpeEhkYGWsLrmK5S795uM65tL56OtfN1k2JbgvKOwxjaNxbySByfvw8qqd8W96mkzIuzs595NMJ;4:6faPvL44SqOSoGq1aIGWIbf3S/tLDPFw9cfz6p/13ZrJH0sEe9lMo/2t9rTjAOfuREn9vByayVxvxl5863ZUC3wSoYw0rKSIhpyQsHJiieng3Rn9qkVH9tBxPy4ZzMMsG2bPznSg6eBJotNUubThzNRcahUAAm7ZsqeWP2Uzv/xtY3PLSV9Tkv7kGYflim4Nd8iwsBunw23FmYLwGWDSbTLx1hpn1/u6pE7S8ftf06GR6ySQmEFMAG93xnOiJngZcLPhDWAWzU+l8Ubl4dwcow==
X-Microsoft-Antispam-PRVS: <CY4PR15MB12234316C7E005360FEC8C31CE000@CY4PR15MB1223.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:CY4PR15MB1223;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1223;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(189003)(46003)(11346002)(97736004)(446003)(53416004)(5660300001)(6486002)(7736002)(85782001)(6512007)(9686003)(52396003)(105586002)(305945005)(106356001)(8676002)(476003)(186003)(86362001)(52116002)(53936002)(16526019)(1076002)(6116002)(2616005)(51416003)(36756003)(69596002)(386003)(6506007)(48376002)(33896004)(2351001)(25786009)(47776003)(316002)(50226002)(76176011)(68736007)(50466002)(54906003)(4326008)(16586007)(2906002)(2361001)(486006)(8936002)(39060400002)(478600001)(81156014)(6666003)(81166006)(6916009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1223;H:vall.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1223;23:bfrqNTlP+Lmk15zLTqboN41qVFZh+L+SHeyLUew+R?=
 =?us-ascii?Q?29GrPGfW5Cw0TMxMU3sYJ7q367MBMn/AYM9Y0JRZINeVRpRt+hGa5NJCRfXM?=
 =?us-ascii?Q?7iSQuwTSNnpWWvAargcZMzH5JXafr4dxUI0SnUgoZsdqVUj+/JIm5zhluW//?=
 =?us-ascii?Q?hCXl6kdJpBDrM94uD8V4sVDt1MOmpMu+bIQREy0LkI8hLG5PZAxI8aM4QHvf?=
 =?us-ascii?Q?cd1lnGHRA/eVnrA+js7R9hb1cPb58vGuYMH11wEk2epJXoyMgDFZ8X88GM3O?=
 =?us-ascii?Q?Q/6fMKStXdQeKLIVdCJ42CoTtOJH29zWHR7e4SMQzEQ1Yw9wIMKokgUjM825?=
 =?us-ascii?Q?ECHxuIBCsM9HJlOOqjtpnXbtmZrS4FwxEyxUJSEF9MViO9I7QCsWx36d1Svn?=
 =?us-ascii?Q?gayOFz0oGmbbk1JH9THBp8AvoAwIIoNUFEg6UlH2siZtg7OddoHO/Mop5aTT?=
 =?us-ascii?Q?RsQ1MP0fsB/6PruCIuma2I2MR/A3LnY4MttRUsD/aSpX8Ey8v/UUJApJG9bA?=
 =?us-ascii?Q?FQwI5TPkobZqugRZaF22tM72LgXy6uYcO8l1q2lZgajcjXkoEanw0im70rTb?=
 =?us-ascii?Q?DCiD2F6PFYu9GNigM4Dm7PTVV1c6mf3Erkh7N+gdMsgxfkml7jMT0eOBi4kL?=
 =?us-ascii?Q?xMuu59GDMq/eCGpszVNbKxUQxI1/Bwi5Ezr9uT0bTcm7cc4eK+XPPvI0I1tI?=
 =?us-ascii?Q?nRaTrnVBwTLMPXF6/Zt9nYq4pIPqsOtnljVSbFqGLW3bqVh4Vfq2L7Ld5Rks?=
 =?us-ascii?Q?R74rAWYc8TeYy2kv/qGkLifgUU3aNyFvWKXTSh1EZG59HBVLuGBNJWw9+pnU?=
 =?us-ascii?Q?jf2XoUbYWq+R2xvn5ycANERWg5qNUKhyXbHt/KOm6NaHjU2POpf8ohujzQMZ?=
 =?us-ascii?Q?+XbTRWgL7MyiS/WDQMCxZ0xFt/S2weTWWbA/qNTdjzVBQjRQEp2fqjfbW30U?=
 =?us-ascii?Q?/vuXTN6d2WgdXqAiB7i44voc8yyO208qOrVo0iEkcaaul5LClxDQ6YRV0ilu?=
 =?us-ascii?Q?mqWYQ9i/+zkTz2MNoDmi5TlFuQOFonpCJR/ZBDyNRsrprhoj53D0kCMD5Hzv?=
 =?us-ascii?Q?9N8bgE7yOvneHV1q1M3zdzEjxrylGRXOY62A50fzU3ns1PG4qW+31v1YQtlm?=
 =?us-ascii?Q?prWXzPlwYPhqt9MY3FL2QlXePZ4ZMsbPgdj/R73ngtS5gtcSaXGOUI/PiUN6?=
 =?us-ascii?Q?XW5mVITFFrIaHPYIEb0Yt+wFdpJaavOc9jciD3Slr11YquGQZpWH2CGKDnZK?=
 =?us-ascii?Q?MrjBRUe5JQWTIELsBYj6Z58Km3JoVLpET2Hyg7OOSI28j0uuDMqpNB8VPkE3?=
 =?us-ascii?Q?+iAvEIr8JndveoBrYnZ9t2U/8oCbYfQmudeOgyf2tOVmDB3JUFr/j5SrctnZ?=
 =?us-ascii?Q?Q87ag=3D=3D?=
X-Microsoft-Antispam-Message-Info: LecBnKRWegn8JJhGq6tVSGo8+VmRRzWxwGU9s11OwAg62PUgM2gtRW9ii3LpDjf22aifJZHVK9ELymEQrYyNeCmyZHlK0RPMimnwSrnwIbYyCS8pscvpbxpgsBhFCGngWe3TCXRBsJEmF7mcar3bE1A731ILK/oQH+fKFiCJ5s0t8PXPWngpLpdy4cfFjr18Q2oSSBkxE7c/8UtsxrPeowFq2RuFHDCxdsluosCbaac846zojQ8AzuRgqnBJt3xQN1jyFO4pwtFoLuVCCo6O/GK0BLaXShGgNAGBIxr1c9YvVvXbcuPK8LMBBNEEObbAR5XyxZYFvDndGv9R5bpxb5ydC/5MwkQBQquccJ7GR5w=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;6:sklmu8odGVfWSraQsoP/TO8Z4XqZgeLxREWW1pnAriI3VquNJPRfDL8VctxWEmLhapvzT+k8KeKhorsyKWiTu/9Ab9OyFQ6qfkac7J4/SBSYagZqdczP0tBm5drWx6Ay+OdEjhlrPTXieccMX2vSZgBKBGnr+MCsPYaSR6zdXbHcgOZKph9GvCZk/m++wDfdpzBOva77XmPmU+m6f4zjzI1N+Bt/b2HlAKLOP64UKhqWhY0zorwCgtYNVPDBXhw5K+Camm7+WgUcWvC+LavTrMqucq3yibY8b4LiCjybGcOKW1PAPaYV+VciV6bv/rGUIXr2kPEJMxx/Fbw3ZQb/j6blaQewqsjYEW64DZqjvFFpCFt0xxUKP0ZGaqBPae84nSJZxqt7RR6vyrkmqe9IoEHxFCf5JUGQrBXk5a1/tg2mC0XYzNOLB+LGkLRND97Laffu/Hd9PAW7AVyqRzzUDQ==;5:pqvPWejTBUWFgB9sPPa6Jy6pOmzKNh4W5zjydWcZctMzoXpLlKAp+CbwQ3/xYErW2WFfwGGuCJSRjOQpUqBA74XDqHXGxCZFwwUhm9zZNNuxqObIANlBapvvJ6D+oAvyO70h8B87KGOpP6WoYOVes7eErZ0LkQlHlDMeTs71NJo=;7:sI5zyEaoz5B2PopKS/OlwALP3p4hX6d+cmYG8yuRPBEHD1ZcJXu/RsgeJQZFL/a2DwwTGxMvPqzDQaAfXYLO8ckKYqaQyiijS4BsVOgPODvFzgfn1IuvPncf8Zluzdvw/Iy0LM/beXlOLDPeIN29J65SCpA7wBA7qnn6D5x5l0ft3b0hA5sFA1ojch5LWCDL02bxZpIwI4+jqQrET+7Id0SxcP7t3LN9nBaEd3rI/xk60mOG4IqVuIuoXi6HrALU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1223;20:M4YIPmP4iu/JZ/s9lcZ4zGLQjc++8E5F5gZb686DkYnnPDpSXNa5rNDNxiRpej4KEob6bXwKOvMOdvHNKNH33IklnG4X6jxLfBJJfVqgSwWPRfjlEACRqDfkkvcz6cXSxNGwVRtSGE+OnwMMU06wNTWqZ811Q0kQnZhlcsZx+G4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 16:52:32.4908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a5c478-9361-484c-6d4f-08d614e24fda
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1223
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an amended patch which fixes those issues.

Please let me know if you see anything else that could be improved.

Changes since the last patchset:

- Use if statement to check for empty string in cgroup_util.c
- Cleanup and return properly when failing to kill process
  in test_memcg_oom_group_score_events

Thanks,
-Jay

