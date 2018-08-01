Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A88C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F87F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JjD8JYsI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JL7h0zr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F87F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbeHBA0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47196 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732419AbeHBA0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:50 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71MXgZH023937;
        Wed, 1 Aug 2018 15:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=2f2oZ5nTFhXCCxmD98z07ydS7myVbDZ2bdmu5+ktmlM=;
 b=JjD8JYsI/338pY7Pd22JggF1LYDryAnYheiKRCTGtk4P9KDg+RbgOsA55lVokXDWzNTC
 Y991daLiB+SJ0IHclwd81RWoTivxtNBMkn26xwq2LW45pDrq1PAv1KWEMaLiG3jcyoAC
 H1jKWVUki93vDP1KV31dFRPzXPeCQaTPi2A= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkkjercbh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 15:38:24 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB10.TheFacebook.com (2620:10d:c081:35::19) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 1 Aug 2018 15:38:23 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 15:38:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f2oZ5nTFhXCCxmD98z07ydS7myVbDZ2bdmu5+ktmlM=;
 b=JL7h0zr0hPlW7w/nrNGrpT4g8VKsYuUqFtVMyIM0YZB9logzmdpI59+SQi8OlvztBjs5U3ZIFcoxYitr1nZivQVNggI6uk2euFxcd2fS8gGD0a9Cdf9Qh9VuVo6ri61GIiAthPWaDt1Kk9IauT1eACa7tQkWt1NxhloKqXakV38=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:7cca) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 22:38:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v6 bpf-next 06/14] bpf/verifier: introduce BPF_PTR_TO_MAP_VALUE
Date:   Wed, 1 Aug 2018 15:37:32 -0700
Message-ID: <20180801223740.11252-7-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801223740.11252-1-guro@fb.com>
References: <20180801223740.11252-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:7cca]
X-ClientProxiedBy: MWHPR1601CA0016.namprd16.prod.outlook.com
 (2603:10b6:300:da::26) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 008168dc-882c-4671-282e-08d5f7ff7ba8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:hvd2ZEk0OAOuEHfPRM5DENM9zJeMHUvvlc3DINiWtDB1ygnf8YpC4SBMNg/lfmh6wgM6htwrG6W38fws+u9FFgFLFNRwfnHmYKadpYtOdbGP5EC4H8fb92OdLoxfaDrWfxoJLp5m3I3+f/lHkDAlDIA4UZLEBXIiq0rRutjDQd/L2W1+UfZ6+bFa+12iOqb+pixVf+xdXtnqiEWW6lWWA+A7QMCPU+h6iMtUVgz3f0rBJ75rsGj9ffSegrRWw+jV;25:UnHE2TbHcSKWS12f1ARw+fWf/Takxs2shWQApFHYeSuqfWv+ueHiZCUSBy2908jTJLQgGam4n+FqK2ylpyIPHMZ9RJp7KAgkP4y7u0tqnOfigFP+s+FCJEE4oDclRbX/76qDVrV9LIgzeYSEUtScPA/E3imSlfyxkY5UO5/C7p7dGRIe3K2cRAe7CnyjP9MFVQwM4jfhW+2RjprcAgJ8Rhag6fycrkPdqf2qoXK48Jey99nBqE7OX/1LO2VMIvZfqkWQBKNRbyKGi+HRXYCE3eqOsm+Hbqy8CEmgF2A+r2WQfgC9VpywOIr/iHBlKK+1SstDbN+5yq4KNYQC9B4VkA==;31:ojb4PFhOx/n0sgiXZtpDB2j6WH8UGRL/vvieim52zNvB4hC8y0ggGhfjvfmiAOvDOXpZRkJolwr0sc1ggOWYAyw0Wy6L918DbKJxlxjWdhwdlY9G20EKhrN98jAUGOo4Amxnl1H31GPm9iy9ZPnaUBdWUXsXKfJLia9NcJwnIa1Mc2PY1SwZy0vAFQFWM4VczJPgKnCPUtlVAFiKpQOldiezx/ZRPLyxapIaR/Mdzzk=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:6HY/46VdXI48ZJcYnwNykRybOEx+rTcNUerIynMHpk8kaPVIuH5e92fz/DL2JOU4Q7IgoWkpHei61GhCWOka+iLpPOLJWn7NWYHnQWry6avsic0AJajZzeXSSk5PthwHj8nKGE6UHqL4o13Msb1E4R+QP2G5OVI2tnvik7+7OOnCr4Y/yu2UVMRZLHmS+WlQv3lozG8AnAx2TgHNDi70UCnezTm27eiqc0xvDbbwRXjJCX16JqfhXfA8IgO/xUEB83pdei01mC4JZBQJk/W33uMUNh3wakGdu11B1AVrx+QigriZjTiK3U6OxqLsBd3HCpJNsGgp75/azIQ41b/CsncsH7CGkftJ3Oo46WPXAb1HRdKAiRtLpEaYl6ZPa/PZCLC2jm518SmzC1U+cDI8E04T8/ZPr1eb3n4XhPV29zjENB7CsvhkU70gAemQzphMTWfAv5K5i7aGQiHOpU6nMSCQ7g9GL9S8yqR30/+w9dZi9n+QgmP3xGwd5+TqDEoI;4:zmauyTW2jMFRHtz+5nzV3KGyKeFhND9xRhfj+eECXHVXAFYdcvc/nLyYPjb82s27BJKAkSZOGC5WiDWGZCYYXKW/DLeOnU2nPblLQYfgrQhzDnw4tBk6+DdtVR3pklwaCFPfvrKTaZU9tDcPIZDRWhCsRvsXO5XZv5eNuVjeQfo6aKdjtkMecutcbmeBxieskl1XWe12RSWZIRP9eNjJxWnHu/Zo/EnJDjd5zGbrAeot2jx1Ka8QNY/srPO99Pchcr7AS4bsklNRg9vAxbI5I24BMDdviIcrjuqaMdaq0fT0oRMf1KczANm2x7pVQOVM
X-Microsoft-Antispam-PRVS: <SN1PR15MB0176BB450BD08582FA64470EBE2D0@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(11346002)(6486002)(6512007)(50226002)(6916009)(2361001)(5660300001)(53416004)(68736007)(6666003)(386003)(106356001)(6506007)(76176011)(105586002)(52116002)(51416003)(86362001)(36756003)(486006)(2616005)(8936002)(81166006)(16586007)(54906003)(478600001)(50466002)(316002)(81156014)(6116002)(2351001)(69596002)(7736002)(1076002)(52396003)(14444005)(16526019)(46003)(8676002)(4326008)(476003)(97736004)(47776003)(305945005)(446003)(186003)(2906002)(48376002)(25786009)(53936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:WHcVYQfaa+qzY4iH7R8c/gKNGcBd8QAlyi35pa250?=
 =?us-ascii?Q?h7sC0W1rBssenq+cMpCG4p3CbA56UljlAUSKuniqnBBoAEn2SpgXlL7UEE/n?=
 =?us-ascii?Q?C2+YDemOLx+PYcAd6JwWvmKn34aKLHNm5dWN7mk3SEmQhuR4PkDSPfzwGHA8?=
 =?us-ascii?Q?+AIsT6hwStQV65WWDeVfEtVnOBbhKFDpW5QImSkyazgDLNxE5cMa7n/6jWHE?=
 =?us-ascii?Q?LlcpJnzWPoTmzzuuAUkSFSnwS+UARAep3IynqMdBa2sN14ZBNmwftChXoDsE?=
 =?us-ascii?Q?dBMdw3GG7YreKtwovDbhfnrBRBo3gi3lYJ/KZcAhfKw/bpIIgurAfV8Cu0my?=
 =?us-ascii?Q?lTVU9KMWLQ8oJ54vefI7zw7Eh8ZGJDgY3YGxZCsoZRAK6Rn1wiTrWkdIgX3g?=
 =?us-ascii?Q?Bfh/sWgwK9U7zUz5/aYGBU+JOrhFjwef/ZNh+oE3ikrax5oC5+JWkOOneTsh?=
 =?us-ascii?Q?JZD4eA3tPJabF6XlouxGiOdw7VO9Rt/5lcyIc1lKQsFkWqFPMJY12YYK9RCj?=
 =?us-ascii?Q?QABGtyD1SylTVpkJa8GtjHEtkQ4S7sjcCGDO4heu0OAWDa67PYLNmJkr2W17?=
 =?us-ascii?Q?SEfUqFmavdYhIoDkZkcZqCkDjzx+k3tPOb5Hy95/LM8tz1+Q89/JvzjYJhJj?=
 =?us-ascii?Q?desOZgEfE7/CR/LLKe4G8t3AIsPbP+KWUDdvYX5heQrTpjSb5NLJut2s/AmS?=
 =?us-ascii?Q?E6Y/q6+ndSG7eW2nVnXIniU6K7GmAtc+3jk9Up1bf18Cl4ls30ummX03wV/c?=
 =?us-ascii?Q?6369NyYqUBoSyfRLtpqYyOkj8HysZrbYvfIxJQ8YlfhNfO8offul56Xs66U7?=
 =?us-ascii?Q?rClaHR2g21/W2gd0Pcgnq6X81iiwIAFgGYjYbRTIaXCSySm8URg9VGpkDnE3?=
 =?us-ascii?Q?ta4shgojiWnTkKjBT92bpWHNshxrkoWj0rx1w1Y/FA1hhUDpVV2Gbde3ZFuq?=
 =?us-ascii?Q?PK3sWjHlvcdCx9ux3dyUUNBLQnWGBVTLrHf0PWV+FGqBdJOA8qLAj4tgQvNR?=
 =?us-ascii?Q?teqBWdSbgBjVo1/PlV0T59xseFPcEF7FbzI3RvhSZ6gp/7Gvl4EVLgpBbSpv?=
 =?us-ascii?Q?dfjJ64qpVKYl8W//BZI43WOF9ik3hHP+q0uYDS2WujCTL4MP/V37MWMkoCwr?=
 =?us-ascii?Q?ho71fvwW+RPVCBgtoEpqQOSustnk7MXF2lXKDdBAwA0gJZAdAp5aVu0PZCQs?=
 =?us-ascii?Q?cV3uHs0kOE3ooujd59ts9tQQQxgJvSyuSqsgXi6rw1nxG0Oik07tOopRmQR6?=
 =?us-ascii?Q?7EemiqneK2UcB/jM34di+46lSln0rEcdMX8k1MgHi8kY3/m2BC4DLyhYTbtz?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: UMRg7JeSPowEtIuN4jc2er6uSjXpt8YzBZVXXH0dH+PdQv1WdGF5oa+RgQwDRNuMr8hZmss8u83bqjHBk8ZGXORaRZsAl3oHXcPIP9qgv6ZPo6FCzXuG1j1w3jTiSQN1PDsv6pi7gNIEXr1W5Gz5PoPqfjewXTP/53zpv8mhvFZZNNMa7jNopT49TAvS7akiLbrlHvHF+a6P5XjwNSH7iKEAt3WoJhP1cBMSreUkGRGK6TZmH6/zZl5VNJZkd3QnJFCAlwhpjNKsfG8YzeGzOgv5XVyQiyq9Y1AUv9M6QKPLm4zcaRS2w1IposzED/sKY4KUpvaK6gAbUaAdyZHl8zKyzyXwtYJZRRYbq4HTSFo=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:2oBZeTBGjt4rhDQKpdjMhugWR//lYnFEF/I+V2rMRC7gPX3VX8azjP8dGbo7Zp749cI3L5j34LJcNi0FGahxcuPQH8NIlqSPd8FOED6yVnMoDdcW5frp7Oa9TztmgjDHbHHF4371hgVTB5GvEcOqb2qTEXU8pZ8FxJXes1TBdquwNaECEXfV+noS+F9+RilO5vdu3qBr8aHphKqOUklB2GDewc7CJxcVi7/I7hl1Cj1Sb+esw5Ec2UOVdwU8XO6t0A4e8A/E1BxM6RoM8WQbQ7cqX56FkPKhF63DCj20SY29TQ5qPaSAx4PYyDnpMY4dg/pJQL06DkBpQd12dc5NcDeEDLVwo2Xt3Act1xDl9Zo2QD66HHMEHVIEN0JN157pJ66KW6t9JuiS7AyK48UJGZcQZ2+NGiFDtFtBRHEgdu+Ua+SBCNwRsMTcVkcG2CtdELB4cZnK+IZN2bjdscSu8A==;5:PN7sm5+ibv+oI75I2kn5mYnh2WzMuSkSnc2DcuoxZoHd06BR6qBu8JrkNjXQL689ige7MZ11U97YLOVK8yE1TDkWCzL5CuAUyEhb0rG9ckUKWwuGy0CCwEr++slymBygyu9JHt8DrJirmD0m8Z/ph9iRusZSAusfS6Nik+4LLuY=;7:o1JuFzD3tnj7DX/QK2BaX0Ux9KOAFlU7hPQrB9AIhRU8rzTBe4gg1rJ9WSCKc5gy0BxqU955zuCVHDH87ZFL8kCVG21cR+/Ar8UslgLeblW4HytJSFhRe6wWUnDCyrkjkY7SJNRjqkcJlFUjR8Lt2BtPPumteotNbGGlFVmF8cEwHAA4fgpgS7iNCWGtQBriS3u7Lb0KdLMUW861sZVDXozm0i0ZhtFvryQl8pS6JryHUSvg0B9n+RDXqgkCfAcM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:ohK2nUd9WOu3x3EqrY5QZvktPs7ziCOgYMIceDLh3N4W4Dhdx6F10q1A1bdbALCZDi8l5QtskthQ6bBwEQKZ07P5VIfRD4NMFpnc8Pe5Fm5LNn/y0j0tLJlaXjEmLwd3JHiTJ07oGnKfFFY6vc3T/KVWzPKHBasDjBmjM8KOBok=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 22:38:19.8725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008168dc-882c-4671-282e-08d5f7ff7ba8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF_MAP_TYPE_CGROUP_STORAGE maps are special in a way
that the access from the bpf program side is lookup-free.
That means the result is guaranteed to be a valid
pointer to the cgroup storage; no NULL-check is required.

This patch introduces BPF_PTR_TO_MAP_VALUE return type,
which is required to cause the verifier accept programs,
which are not checking the map value pointer for being NULL.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 16be67888c30..ca4ac2a39def 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -155,6 +155,7 @@ enum bpf_arg_type {
 enum bpf_return_type {
 	RET_INTEGER,			/* function returns integer */
 	RET_VOID,			/* function doesn't return anything */
+	RET_PTR_TO_MAP_VALUE,		/* returns a pointer to map elem value */
 	RET_PTR_TO_MAP_VALUE_OR_NULL,	/* returns a pointer to map elem value or NULL */
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7e75434a9e54..1ede16c8bb40 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2545,8 +2545,12 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		mark_reg_unknown(env, regs, BPF_REG_0);
 	} else if (fn->ret_type == RET_VOID) {
 		regs[BPF_REG_0].type = NOT_INIT;
-	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL) {
-		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
+	} else if (fn->ret_type == RET_PTR_TO_MAP_VALUE_OR_NULL ||
+		   fn->ret_type == RET_PTR_TO_MAP_VALUE) {
+		if (fn->ret_type == RET_PTR_TO_MAP_VALUE)
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE;
+		else
+			regs[BPF_REG_0].type = PTR_TO_MAP_VALUE_OR_NULL;
 		/* There is no offset yet applied, variable or fixed */
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].off = 0;
-- 
2.14.4

