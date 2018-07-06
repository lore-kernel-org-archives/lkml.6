Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAB322449
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rVjDATBA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cX5zhgrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAB322449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934379AbeGFSbA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:31:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933978AbeGFSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:30:57 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66ITpqf032745;
        Fri, 6 Jul 2018 11:30:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1faRT02EXoKrdCVdTvqZRHZgZASTZiFP0JdXY2sp7Yc=;
 b=rVjDATBApomk1odJPbyG4kJ0MY2mTimRyEwJ51ncx4nyYZVwdXJRDrvsPyS6i6CfVLfj
 Iui9uNuaqKOMGk9h1C5oh/iWU59GKfvKfoefb+jO/SsSgnJN+baoUJ4Gh0DrecYwD02o
 eMzTa+CfdCjUeRWTlMYbTUm3x6iImg9prVI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2bnqrdxp-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 11:30:35 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 6 Jul 2018 11:30:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1faRT02EXoKrdCVdTvqZRHZgZASTZiFP0JdXY2sp7Yc=;
 b=cX5zhgrYukRyS+Llr+yOHZWyJHxQWtds88PWjkCNxPwQomUYWM0x0bxk1Fyl3X2mfLLApcM0z539KSvv2nQDxk944p9k6bH2NUyVd7YCN68fQAWot8L6f7XzWWcwtRQSMqzMGbdMmWu7XSAptUXoNdNlq0RZp+bveYH8aIk0eLM=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:17d7) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Fri, 6 Jul
 2018 18:30:30 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next 2/3] bpftool: document cgroup tree command
Date:   Fri, 6 Jul 2018 11:30:11 -0700
Message-ID: <20180706183012.6475-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706183012.6475-1-guro@fb.com>
References: <20180706183012.6475-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:17d7]
X-ClientProxiedBy: MWHPR21CA0067.namprd21.prod.outlook.com
 (2603:10b6:300:db::29) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ffa137c-b67b-4cae-dd6b-08d5e36e8e6c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:GxO+lHbqRimq+0bmIjXvNQkc4u2ytTwiJ4G21Pz5QfPFgyn+YgF6U3T1rnhAcvDru7k/btP8A87YChBsI0yYXWD+dV8/QLhMjqGYbsO2dO7N/Bu3AGkGoQ6vloQ6JrEbEC3WimNgUf+p0g+oo/UFBniEy7bmLpT3MWn8CTEmCVeaNFAJBiNPKnIEQmaWQ5n63E2WMgO3X8likditlZZJl105o6RYsoy4zRiE2CFe7hA5xi+c3AdNvABGAY/r+tyE;25:Tsbyf3kFuO+Uz9VAWEWMqCo2a9BXdaTEMr2hYSRNdIJ6Q6hPUAo13+ix6m4pPsentMOUazgbIkUZaOZ4GdrGBr6CAOx4TPK+0L5GzjRdOyLXF4edzWI44mGvvOYUbYWNVX0HvSsJemJFr51C88GphVOPKjbZAtielXWoDaCckWykY2a6qz5Z1z95tqbEXQM+gVpFmiYMjnv/8W9Ak6eAQSp6xm9nFMWatMZrFUN3EqoZWvdaPuvx1SgxIFjrETWK6VU8wlZk5qQwWwdcwWpENDmWrKTgGc/lR4EP2teKup8iPK+4UaEUFiaI7bjkBTJGYBqeqizoKbd0ThN8G6pMCA==;31:cQNu4Uv/owp35C5e2leOf5rhs2k+LfD2Jc0QovOytEAwkoXPb40mxJ+/MYKRLaHTtUnFOd9dHTqV3qkKXnYaQ3DttJeDHFstDOLAu6UqTpyKgaB3hI3pYxqzAJcz3ctO+8q/fk3DxTBnaOJYZ9P0s0QnGcZUzeXmm4UWRFkmx0ktHFtUhv5nAPF2DzKW1zIFrmUKVkuA02Hjdyr/DM5lNqZd3zYTyM/uJEnh4GY3eOE=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:BPEu5ODfI2fPGNlEhst/J+g8JnQqkQ00P8/zi6TiM/mMj0zvIh7dQhDWWNMx6oHBjAwq3KLha6Wsav45fMEMehbdDuSB/XHFCTrOHImmU4ll26Y59Zl7LsaKicbrzwjgV90yPuiMsbFsGBudFEMvNuhMYC1z8t49JsFeGEbxnwMMQRr4h9LXvZE2U5IigZMvwhEwjMMz/PtfbQkfcd1J9zPCRQGqR9ywZKbHn2QydhEDbSbQrIxj1b/jXAXijvZTt1IFrZFocqvsl1icZ5sUG/iNhK6EjJEjpRCoPSxQfSXpLVNT+QLlR59PLyH3W01xqr5krUvvq4IsIcFulfrNq9ZMV41hXVN+JVfplcG2ZYsh2EeH2u+ssSGU7Y1iKjl0d50dLkPu25o1zwOGKDywWAEGGpu9RmsFabgfc8t0wgS8DWg/dCXZHg9xhhS6s0FFJX/j+pw7fCGpH4mZrcV9JKgxetUNYhgXjReiMmiQASF7SjrO9TRr2ZJke5uvI+FO;4:fml06Ffsgm+L3XEMVboCpWim+fs9OlX9Iy5QlVWPnv0UPRp5hBVoWrfdKGehSBu53P3a8WGX9zwEgmgoy//V1Elb8m3GA7wCgxx4f3dyQHo0dYSGCxwDZU2EabFlxNKKH7t82gq6MIncSVPthrVts1RGXN9XCvHQIiXysBd5Snk1+sGjynz1YEIM/UEiDn6bXN5/TH9o72vn4ORbMiv8rmsEGVXmSrDuiziYN9zkb8dvYPyurRPdSEfiRn3nJYf4Fgi5Nk7NqDUclg9fPAEgmDLPXV3FmjLBFFeef1iUJePnxPSntpTkvjvUY3x/wR6g
X-Microsoft-Antispam-PRVS: <SN1PR15MB01769B9274CDEF8AEFF8DF61BE470@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(189003)(199004)(476003)(53416004)(316002)(186003)(2361001)(2616005)(46003)(386003)(6506007)(8936002)(11346002)(5660300001)(16526019)(68736007)(1076002)(7736002)(81156014)(48376002)(69596002)(97736004)(8676002)(478600001)(50466002)(51416003)(486006)(52396003)(52116002)(446003)(81166006)(6916009)(2906002)(6116002)(106356001)(105586002)(6486002)(50226002)(47776003)(86362001)(76176011)(6666003)(2351001)(36756003)(54906003)(6512007)(16586007)(25786009)(4326008)(53936002)(575784001)(5024004)(39060400002)(305945005)(14444005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:zhqv89mOC+2Kpcix/PuHuH2Ia+vTJg4xiXkeK+34O?=
 =?us-ascii?Q?/FM5nMG82VA46gO+dDp5irbxtyW9eXsM7W9C/552ATcQMcdKjZLeP12RlDzu?=
 =?us-ascii?Q?JKpK9bRQdb+YQ4a9fti+Ls4sr2jGtPjzF1oPEnLy2Z8DrvCSsBlwSK5aKJjk?=
 =?us-ascii?Q?+l7/pS485CFuiphtf7x5gcJRWP33kq7pq/R4GC+lCScIpWTyiPqEDtQMr1FZ?=
 =?us-ascii?Q?2HE1zsCkI4mMlJhTaGcdDwqij+EBzMeJim3AIwAbGrHLPZ7U3Rp/BeTUl4VF?=
 =?us-ascii?Q?qZbf2L+Gkjvrv65VpRMZ2gRsEM9+AJW5SnXaD2HUlJQ5U51NhqSkjzssExHf?=
 =?us-ascii?Q?gG0A1jGSuGZo86k9PRkonPp9h051D4U2aRmdXSPDW+3GtYhFfZav05MBkwKN?=
 =?us-ascii?Q?aC9x2nB9Am2btTMURsMlSUjbON09jv6bqWuGLk3EmGZHN9Yyf/o4NccLWKO1?=
 =?us-ascii?Q?A6Mh+6coygmO9YtMGUK5j0q25G7eeSJX4THObSlyvomD/PbQ0Bqc2Dg4zftG?=
 =?us-ascii?Q?3Ymd3bipgeCCygXNOIIfSxs2rj5tzMINO9xYvCqtdvV+bAfPbmuRPrG5W428?=
 =?us-ascii?Q?HzLClFa9QMkNjbbFAzXgn82XQ+tsaVEVuLSFVA26YMfH1pCDtGGo0Mcao6DH?=
 =?us-ascii?Q?007MHE7SjXYh29I4jy5LgWpSd8PGaIGAPrzUomJX3kb/UB6PKALvR/rxlTS0?=
 =?us-ascii?Q?Dz2stJAYWOnaQ34uCSwhRFxcwg9BekytfsYlJT4jxSHdQBeZsAE5LSIHK5oU?=
 =?us-ascii?Q?VfZ7ujM1i03T5xqnfdLVv+asq3g8/HJ9SsDv9ycFLTqh1BIfxpjOSR0lnX1F?=
 =?us-ascii?Q?gdb19Mt8+LGZplS2FC4wGyvNwlyXcss3MO8jlPf3yXFewMEcallUaZOsUaNL?=
 =?us-ascii?Q?blSKExD1c3jJ7XxEjKNQEfwGG02bHezI10/OJsOktYDOAA9pzEJXEIupFUR8?=
 =?us-ascii?Q?EO6pVEFVt9/ZijP/Fcq7oUyI+LXW2MHNhBFSoUTsvHDXD1wNPZx0h17r1+jA?=
 =?us-ascii?Q?j7Ub/4t1fY74iWumAn8xnZ7DeyLQinl0F2bAq/c5FNow9M8MlLPCHEZd/iVr?=
 =?us-ascii?Q?dlxE441zpHFN1yWa0tnkWYh98tlGAcMLDdowYA9bqyUFTqA3ABSBiKsJqbyu?=
 =?us-ascii?Q?UFUlnqr9YJCkPoSp5dVm26twJY70yi0066YTPz6Ur0a8ubLZqPFjVns7g7Oq?=
 =?us-ascii?Q?8ek97CJYCaNZFdsjN9Rsc/HKOSB9Z7hNEOk5WtKWsVdQIFeiqqbnb8E7lE2a?=
 =?us-ascii?Q?zajKWzCxzaJtX09ahtGUy8cDCJprcZWc86iwkI5RUe+W3UPEAg0L/XgMS4t0?=
 =?us-ascii?Q?WNwmIy5R4U3lZ7cYiHBaNaahyi4Y753U5yTKEfhvCZbBIobwUqnqbIyu2wsS?=
 =?us-ascii?Q?Varow=3D=3D?=
X-Microsoft-Antispam-Message-Info: IUf8Nw3wwhkap4isi0i4QFi2Z7vruoDVoGppscyjfrpd6lmKVPRM/VeNVdLMQhPqv79eIC3x+8FBS9KFYqwL5a6QjDj2+nmqe4CXwI9qGz5uxUwO10Pm8d0eLjKw+Pyi6tW8F8hBOG7gi327t+QfQoSDIcCw/mpyyG05KahPPnicQaXG/cnrPxablREVAlXhe19n5s69Ai9R1Ff2mjrQrcQ8IsOmQ6PxT31pLjxXpJkQDpqP6SY/UUr6+aOsWiJP9/AnxWoCV1abnl5UDIXV4pY5e//2tuJ0x6sNJ+FuylZ55typj0rjPzEn6J9cr1palPZLoLt4BMVY9X5E6bqui84P1dhfAh6TALS87U1RW0A=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:Q3EvZUgiVTVJ3ibHOwJOovDMKouvXd62NZp6YeLfvL5K7sWdS/iJTQBK+gmFXcSySIgiCk/jHho+rEJYiDn4adqhI4rPUXtieMPdZ36O/YqHYwc3qFPVatvIfMtAETySzBGCjU3ckOW6nkDtSyG6v5FtAuPv+wF9hKR1Dn0dKQlEtTmLCINc7ps6KgK7krL1ROv/gFQoxPJB7fTeaI3nJ1w2Px7MBTqhgLTpGiBR7Y4BwLc9eBmbW+y9JE+xR31wyvUrqP4fc0ZOmsxBaviQ6cPEpziPIJWp1HWRmAMn3obwxM6HdHyQbLECbnhqYddvrbavYTuJ3HBLf71PpIGDEbvadsthmAFVbittrLH7W5G4kYv++q97VZgTEYBBRvtDuhCZX1PStFBFvmSMSfzXttHDnReTBsNn4hgVmZgVVabLWK1d3lHw+38UvxrZJDpVZR+f7GoZXq0JcrL2FIKKag==;5:viPi/e5GpRYDTIyFtqXpyV74MJ0LbE7wXBlrR9XoSnoj8JUmlYkvV5TBMe6oaU6YHr/74TJVyahUMNoHDbHT2vgCnAlpBjccvaDijPNsoprz+Ghix6NCLb4o+8plSrghl5qzYmGPUDNo3F5voIWTS2Q92D7zf/8R4/MewBYySm4=;24:sGAH0/Ci6lQeo/Kmobdm7gzeQ1p/PnQ2oTzhu24AZxUCH/iXyAi56ZGi7k9VDQtjZtQeFXVcwftbm+lmnnRpkb9ZTD8Fwt2HkL/v2rdKmY0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;7:QQ7tW/eUuMERwFRHv2Q1k3Qy6ablBsn0vyD2ioxAykKqpCMA5H5GVfI8u2VfG5ZgoHNedFhfU5zDWn+ZB4vjkqeBWQ39IwxNlymmrBwYcpq8a3xQFT35lrGFQBFzsCg4aeWIr60vcFkQgNLfavMgjSjLmDnF9anCVWBQs0eEVN2o914nYJUQ1GEGvSXBVa+jfvRI2gCPIBeHeEWRBIc4tiUzaDc/yQtAAoCKENkubz7tWUeBVOGXI68F9+oiM6uz;20:rpGCTx6UURdNnZleOg0z25+kq8jcoZSbDzO9QK+6oqeBiLkYyDrAxprpKUdf7HPdZlq7oExADO83t64+1bAXVZlZ2Vw3i08n12jzFAJG6jPtVxBAZc0oFkFmozo8C8fbvZ+4V3Tvfvf+FcmkCsyRSMp/fMF/ahzo4tzRjffxdSU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 18:30:30.7040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffa137c-b67b-4cae-dd6b-08d5e36e8e6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe cgroup tree command in the corresponding bpftool man page.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index 7b0e6d453e92..edbe81534c6d 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -15,12 +15,13 @@ SYNOPSIS
 	*OPTIONS* := { { **-j** | **--json** } [{ **-p** | **--pretty** }] | { **-f** | **--bpffs** } }
 
 	*COMMANDS* :=
-	{ **show** | **list** | **attach** | **detach** | **help** }
+	{ **show** | **list** | **tree** | **attach** | **detach** | **help** }
 
 MAP COMMANDS
 =============
 
 |	**bpftool** **cgroup { show | list }** *CGROUP*
+|	**bpftool** **cgroup tree** [*CGROUP_ROOT*]
 |	**bpftool** **cgroup attach** *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
 |	**bpftool** **cgroup detach** *CGROUP* *ATTACH_TYPE* *PROG*
 |	**bpftool** **cgroup help**
@@ -39,6 +40,15 @@ DESCRIPTION
 		  Output will start with program ID followed by attach type,
 		  attach flags and program name.
 
+	**bpftool cgroup tree** [*CGROUP_ROOT*]
+		  Iterate over all cgroups in *CGROUP_ROOT* and list all
+		  attached programs. If *CGROUP_ROOT* is not specified,
+		  bpftool uses cgroup v2 mountpoint.
+
+		  The output is similar to the output of cgroup show/list
+		  commands: it starts with absolute cgroup path, followed by
+		  program ID, attach type, attach flags and program name.
+
 	**bpftool cgroup attach** *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
 		  Attach program *PROG* to the cgroup *CGROUP* with attach type
 		  *ATTACH_TYPE* and optional *ATTACH_FLAGS*.
-- 
2.14.4

