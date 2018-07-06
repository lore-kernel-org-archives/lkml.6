Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E160C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C680422B59
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AD44MeJc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="U1LFfe9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C680422B59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbeGFV3s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:29:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932778AbeGFV3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:29:45 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66LSo3g020755;
        Fri, 6 Jul 2018 14:29:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=1faRT02EXoKrdCVdTvqZRHZgZASTZiFP0JdXY2sp7Yc=;
 b=AD44MeJcYj75rChe2orr4YTajH2wg7nJObSByfqhOSl0LovsC9tiIKkr2rhsf6JrtfS9
 INBSGfU4hdLqY6rXJ2er9SxLwHKiyoQFcBkH09Yd9WgNwT1Qb/OYxAZ1r+pkJn/jlf3N
 1v0f/QVuQQGninrJBx+9SZBN52JHtNUA2RM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2cy58fr8-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 14:29:22 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 6 Jul 2018 17:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1faRT02EXoKrdCVdTvqZRHZgZASTZiFP0JdXY2sp7Yc=;
 b=U1LFfe9FfFrjjy0GSnVoXJad/j0BLkab5AOJRUISMWAMBoR0Vkp8K/BiDjEvuhW6ckhfZldFLHVm+I4TXfbUaFlR2a3/9/J7fYIwvJ86P7AQCml/nBgdHA0XaNVXDlWFTV5c4AWp4yuWyPiNKWRzkM73kTjTienPQm8izCWhkH8=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:3096) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Fri, 6 Jul
 2018 21:28:32 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 2/3] bpftool: document cgroup tree command
Date:   Fri, 6 Jul 2018 14:28:15 -0700
Message-ID: <20180706212816.3760-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706212816.3760-1-guro@fb.com>
References: <20180706212816.3760-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:3096]
X-ClientProxiedBy: MWHPR01CA0047.prod.exchangelabs.com (2603:10b6:300:101::33)
 To BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4371273-6336-40bf-77a9-08d5e3876d24
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:JGbaBuNW+aT6lGRF+QWcu++5gn34lc41Lu+jxcnSK/XZ+6M6UvyD/VcMhCrwtgXlRjfkixVKO2pV1yxPJ/ovupS47eWSp5Kr0XdINMk7HSqsvYWbdatW9cU9ih0FazmbIRvgLWH2VQ9N4tyjP7RCLUCRUpjdK9jMbA3kK7Qpv+xlAaWhKaKt/M3orD4XULzzSaQYkErMPK752qRygc75M2ZOQJA40O/LQDyRBgXqqMzur8KfzDysqO62jnB0BSR+;25:qFWAOjSX6Dfefe42532+wbAdvZOiC1eGhYRVWFOYkZCZhZiFtCmPZoGknaNu3IzB32gytqF0IiVUxgwlA1PhRq6MdvvedYOWtVoFC9CeJ4JB4dSZUa5MMrW7AFiT3/jpBSh4w4bXW/PgozMlgp6POXuAx795+SB+yi1TPR08v0rpB0aLzoaQJlEbpGgSSXXo+pZ38seRUoEjS90Tb262ruRL9VP8qcY2M0lV46S4UMtP2yTMTkf/pAn95qRORejA/VY6W8fZfSFjEsu9c2Plrj3CNmUDGW7c0mhhrmKRq+kCT5NZxt5riDXkKQ/yT2kkT93dUNjYm+WgeADp1KPESw==;31:PmJwmZtHByhBCiTW11LGZiZBO+HHBBCKeSJqA96oyW1LvnFD2a3K4k92waCI5N13qFFT3JZ6qR1r/2pBhYoyFkbRodPYaDviwBvkS0rQGRuwVGCAdEyQtqP5JiTeovcT877kMCaVljtaNs3kWU2VRyU1eoXIuHHwVQI+xjWrzzTWzNPTmpk57mXWV5Esc+SUV4qnVKPo+R/30eJKtmhq2DBLXlBMYiJnQTcc4oum3i4=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:FOb/kpAlH1z25bkHTWX0+c3BSX1FnPDSse4Zb3G+Hy7ni7cVNnBIgCZcBXQLb+xnYeTwL3t9k/ePFGlN3rSY0yI7o6DYkA19eUkS8/wwcywsD16nx269fzsqIY8S+umCzOJ54RzU8n0RTgs875vw8R87ABRe7wmR7ZZrb8xVk4QUVlhVdGditGKkXPxs+M+mAwLtzbMUgcyR2mxZnfcWt9L9PYLa194gTxWlFduEm9g2YvwymBdTnDaQJugxX/193ew3TDSs8qEmPz7cfmhAhzQzvp/ChevqNyIOwNX/9HzuGcKBRx36AZFAq6gAZkhmcghhD9uhvaBBTtH80BYVx2v4vPUxI6MHYtsCCBt28aQ6EQPMqN21RbCTYjXU9zvef8HflCVDSpkw+TkTxuqqIqXklZ0RRhzjDOM8vYJPenaTjgR2kZ53DDg+NLasYoDWpXm6TL1ACPtkSn2S/ptpoEyG6qH3Ab2rz7PWIRICi1ovioC7pD2J4BgCX//oUOzc;4:vlZiB1xps2ez/04urD0hVXixbsuOPFUIlTrWLpntCo2+3slczvDNnTocR/EMjaqi5taEf50sw9IIGx7OSBKz/B+B+ZFIW32ibteDTuI1VeX8UN/+kOs7OgrhSNNewfwi4Yk/0zirwWnlbmwgKHfwBGA/EcvcU/eJE63ljOr81HGJg6Z4M5YpoW76Ct7+BZ1FR2QGfjxkV1Hcb7V4wZ0gq9Ptc4KRwcrxpxoei3P0n0LQ3nmtA7xkMYbQm5UVgA0WPfCTtyUE9SColFDSeZsjrVYsjHOm1Fg8bwbDO+DlhVoS+rss8idIxfA31CMmdWbT
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167429823A9EF50C90954A0BE470@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(105586002)(446003)(86362001)(575784001)(11346002)(2616005)(486006)(476003)(50226002)(8936002)(2906002)(7736002)(305945005)(81156014)(81166006)(2361001)(8676002)(316002)(69596002)(16586007)(68736007)(53416004)(54906003)(106356001)(36756003)(5660300001)(6916009)(6666003)(52396003)(51416003)(52116002)(6486002)(6506007)(386003)(76176011)(46003)(14444005)(5024004)(186003)(97736004)(16526019)(47776003)(48376002)(50466002)(6512007)(6116002)(39060400002)(25786009)(4326008)(53936002)(1076002)(478600001)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:DilzezqwJs9kRADQgvrqcK1OriK0xJijkMkldWy4N?=
 =?us-ascii?Q?tH9nFgUsmc3GGA04Kd6YamuLyX/eqvb9C1h5xYIYRFASdRLm33g7m2qQkFaz?=
 =?us-ascii?Q?hVQixMMZnbyFHrroGhj5I2db3OJOKzzdsxWsam+DVXvk80vmAaEZ+cIQtEVC?=
 =?us-ascii?Q?Onkutjr5CwrWITXjk/RZACmTrbfan19e+ppMRBIRpwswKzfX9PrXpdpQaCgI?=
 =?us-ascii?Q?oRR5/DXHdldKhohR737Yv492AAZmO+81q0jpW485D8sCWJFlKKh24MEKba7L?=
 =?us-ascii?Q?aoGb5F+2MAwchp97iuq7b/6Pma3EdW2vtFmHa0+NfZE2fT2pCfPyeXZ397iv?=
 =?us-ascii?Q?GqInD8aUB0SueNxOjoL8L/YmjxPxMOHFhzvwOOrQGaDxrLwazthJAE7gZsBi?=
 =?us-ascii?Q?i+9z9nxc4/tRRo0459bj9qlytU+nhi8TFi/4HVsqtLa6yjm2tqWY4V37PfSH?=
 =?us-ascii?Q?VCsmi8lD2NgDCeDlEnMoodc6mw7Jbr0qifCNkTSNchjRfcuqtrTSUxPbV6N3?=
 =?us-ascii?Q?PA16CcE26ctLJYcG7YKqc6GWhQX4nxk0mxd4Qsb150jUS/Te1VdJwoTMW1XY?=
 =?us-ascii?Q?z4MmwOpBGJjZSwr+OxnN2NOE3xRNbTqhVLcFvSnlpSO78JeFZoUjDlSTzSn1?=
 =?us-ascii?Q?o/YT1z3XTVBqtx78kGkXDgmrnu/MNChKXDIgWFjJDU1UbtRDndzJKf+K6hnq?=
 =?us-ascii?Q?USYP0GKMXHznYJ2cYwPv/+9lHo1BA49hn+q5HK21WycrK3/yH8+AvR45Rqa6?=
 =?us-ascii?Q?GHVaTA6FPoGR6xIe/UUTH6vbQE5CfQkO7/RKz6b5O5oIUWrBdPORUYuk7HFv?=
 =?us-ascii?Q?TVzY5HsVzh4vpWqLEiY4EHo/wx9+q/FRmPu+xofytKSxKeyuzl/UQCg2AeFa?=
 =?us-ascii?Q?76ZpAKSQXmXPOzZTrZi12sQ/ano/LW+LKIJctMDOgknetd7JrmBpMJiDYtx7?=
 =?us-ascii?Q?bKghydxLYCVA6jqGUFRisejSq2vDMdiALmTkEvjN9rUQtWQ22yNx/k1S2Bjd?=
 =?us-ascii?Q?m1FFpPmNyvY/iVSTN76604vbX3N2va6DD67sp4mO1BD+nKxR4k1VYds9U411?=
 =?us-ascii?Q?Z7KSCLhaes2ZSL+GYv/JVefNAgvX7FwTY3wPa/Mm4iOfrMYnGJ10kGro1BJ4?=
 =?us-ascii?Q?BSVzP3HX6wEiidwYl8mCmhANQ6Qq9GmUm4kHjuNniYOiOSHhJJ/SVNAS8ugG?=
 =?us-ascii?Q?YSzMFuYp93pOW8DJMpoWwdAbdLaeZhS8BHlhZ/dGHHl9AJLc/AvJye2lwNMu?=
 =?us-ascii?Q?tdHhj8688/0tH4v7w+Uz/7QNXVXu/KSsUnjnKrDMwIMGsRrphnsi63GvAdsO?=
 =?us-ascii?Q?/4lXyHgB1S0lpuAuwmNWxzEiB5KNiHBu7b6GgRY9jCegXKwWbBv43pW22EKo?=
 =?us-ascii?Q?mLxVA=3D=3D?=
X-Microsoft-Antispam-Message-Info: w0h0yetd+tXtZYvZnmoR3L1KaEnH8h+mpmMUhXQYcSWBCQi0Oc8+hsZ8LMV4voaNCF+JVqPR3z1LNTOff2dFXT/grjpXKRJzvNyRiY3puHdDKCHO3lneKlXmM9FUZ909SAk5hIRG+Ve5wvc+qPpS8HCPFm8kosrSx4kFtx+gJESeS/Sz7+0tLFBtdTu/XCBqFnVz8/4+hIrcFZhVE80pfYws/t91v6EgR7jZAOwhdDFS/AOWCbDM1AKE1HMhre561DHa5ceqD+A/E4ChgPArXnZMmJ5exXF1wm2v2zOLSnV3f+ftvhsTREBrmmH0el47xk4LpIiKb2CZcgUfllSiW5WhwlrDhMVSp4OgJcDxMMk=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:UU2Bc0j7xT5hxydbenAkKEef1vY3+5nnukVRZUt54eRIyqa9RZZxuZNleb7/yMWgJEQwU1pecOL2Ljudwnp8PaaLU0mP0aXCIHAHg/59mcdzK3jE0XSl82M9TRBQST6TQ/aq1kJXcoryIl0QxU/AvDm4U69pO83Yry8RxS+HG/7uAkvF3jU4tYqGNAHdJOb+3/3MYLQeuqJKApydCrvidmoxEjOjPtJo2lm+b1GVwPx1En2IgOcmRl6G72qxSgJ/Kp4j7u0+ArFEt81i51T7ofd81sH2UNPd8KkffUjGQzpOQ0JVjDc/SvomM9hZOEDIVuXZYhaclIZ9B1FVbB2nXKJjZ5Ogm2r4uG4fdPLU/kIraG488JlHSwDHjBeogqjOEsP32TIYZ5z5L55iwFBEa6O1yG1x21zo160YdPQuwbGnQcoeZExXg2H/WlmU2+zFtHzsr4ILppB51hC6lAxvnw==;5:ghnPn2dWkrqety6sesVDFT+7pA5LVs4CCi6wChuYpSZnyotQhAAb7zxTW4B09uDYr2xOfgIVXRJTfQVBD9i4K1xylobV3r0b6q9sOJZG+JwJgA9ioDxt0RgHNzpnp4wyUgedNZofpTTFFqqj0sEJOBg1+z4BDmFGkr+kUzpyJAQ=;24:MJIXxQO7Xzm4dLZhSlH/yMDRv9/mcgRcNMMSnEtz07vnaE76vgtt/XqT6u931iAGnaQaD87AKY4WB0q00Oxtnl1gy928jTaCHhJwwLonSYw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;7:1QgNVGxfYJE6l1ZnLVs8/Vugsj4DjaN3rjHCpkNIX2vuhWra/Jsax5bHB1w6bosl8CRdEC7+EOpUm9gQXE5dllX9c8Ha0KGiZILq/0P/YN0vp7G2n0oDfMl+kfL2YGfOEJZgl+mkEeK4vhuX+4gFQvqvB2UTRgmiixnMRQD+WP2TJQ5gPnl/+vXPC4tT1aR4LV2ex12eEpnblXdWO3cJleC0hYYxydrgLLLVuu3vJmUNXbkwap1hxGqtSWQvUF4Z;20:D90wLrMX6KC/zDVnKLS/q/rnd5/V0fA1qfuCG5Yy7cB0eRfCqwX174zEfwUt3un+D9PN6IeElDvPlE6j1BfJuqXG31WNaz9mYTnjZActcISVC+c7Ac3p9FXWN01rx0O4aejHFWOeQV2jQBAGPtUnYjdLdVqL/cr7LbAWpsdH6EE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 21:28:32.8284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4371273-6336-40bf-77a9-08d5e3876d24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_06:,,
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

