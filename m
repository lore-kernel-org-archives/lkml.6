Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82384208B0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OTL4urov";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IPLDNbda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82384208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbeHAXZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60992 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388481AbeHAXZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:35 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71LWbHk007722;
        Wed, 1 Aug 2018 14:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=CEOKcUFZGpGhEHi3JMHvbEOG9CE3U4TfGlKXBGbmyJI=;
 b=OTL4urovIs6vo84fwYlklL2VhwwO1hCTqCxowWCoQyDVerjkjn9vHATY4qo2nTlQhgqN
 bTzrFABAmL2z0pv95CVXnxT2FZoQMT2aqQ4X/vYBM3gSvkSyy29qyhPG2LemFvOiqZij
 n+1eviKczWCTyYevSCqrn72RWoRAUStoyWo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kkgjvgsx6-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 01 Aug 2018 14:37:26 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 14:37:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEOKcUFZGpGhEHi3JMHvbEOG9CE3U4TfGlKXBGbmyJI=;
 b=IPLDNbdaO/OJzkV2VhRRysrKuVEdkv1TJtQY/eJO+e8GaBrWVefbdSiKAdGr2zJrSJht/BD4ekCQov2N4e4RykPllaEvBuEb5t1wpdTjblSTCV8v2sKaEPHKaWE/hPpLEUNFwxJyA+xtL4luHyKf9S7s2IYi4MLMpiBUugtZhmY=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:18d2) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 21:37:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v5 bpf-next 09/14] bpf: sync bpf.h to tools/
Date:   Wed, 1 Aug 2018 14:36:44 -0700
Message-ID: <20180801213649.30751-10-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213649.30751-1-guro@fb.com>
References: <20180801213649.30751-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:18d2]
X-ClientProxiedBy: MWHPR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:301:73::30) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c5a1aa4-f4a2-4ebd-08a5-08d5f7f6f593
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:trKuoSDq52dAMkgjkGxA/PYGe28FIdpMhxcGxHJ9KwXy/EaS3ugd9FIbafzutjDFi9mNHB9CyCtGojxg7uyKOdEuwnvyQxQ8kftaQtPValVT8hjGGczgSlACK3xK+i7oA7d7KZ8MeOM+7OSMbV/pG9wPIwf62L7LKf3a57gscuXCFSRHJ/P37LfKms+aFUD9HXxlfNsknPT1UD7twOzudminDgjXNyENH1DyUsGrklw4zTZTihX0nRPGMTK9BfwU;25:chx1mLB6cuoiyOjqcrWNVkmC0V9wzuQMwOTeJ5ddJPTaYeJgCRbWq23bfM4SiYEHLGuV+TNdxWtbRc/Qh6fMi86qjG4OzG/35HH7sHwvc/nX+mu0/gdX5QMBIMAiZ1C+93YQVhKz92uHPLLuFsenKXn/sQ1r7XX8rqkXZvQ8Zn35BcQ47Gwng6/DT2xyuWWEdivggm9DuMdAsdKIUAQsMensNF9iyk5+MZziHZd7oOBOeV5ZxPPuBIuaTz7Fm09awaMW+14KdjZqgqDoGAxQaeBDqi6geu7DQn/Yl5S9RvZEtY60P09ALebayJN+WzUkN8zfdHGGRr5Eq7kUq4ft3w==;31:4MNjc4a4tozSUhbXxU9jChQGjAMmwBtwAK7QeIjj9ZWy2g+7B1oRfguZfnJKr/8BWtGL2VMGHhdsDi4npm1OAJWJ4zNAbRhCMbpsIFJyzlBIXrfCNi5gb2gT6j6OaWO0PWybK2zrUoYe5/qrBTZkiTKBgPBoAtmFGF9LkM5iFAc3be8Q/ZqiIqeMIBbLzOPn3AKbiub2Q3WV76pLU67OYriBznEW9jmbOfZ+LHD6B8Q=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:Oyw9gCuRl0o7jqHhkYm3yfONHMC6CaUjaPgj/ncJ8sSdOQIHCqVPObLflt72zc6p6WSI6iJ/5+Jf19LEjd9iYuWrM88syWMrOtSl09kKc+XFfPTMxetluZG6CiLVh/U3nR7n4AcvSTtdk0lyhIlsUR1IXU9xN87Dr03XuDzawz3roEu6r4sl03+AijNY+uEb0/m0ZiA+iAUg0UuEtr14cr/hkf4v3ChOeQGG+mymgTWxSwOWcmHelGGcSDqjc0c4aBn9MVCJ/muFYyPPPWZdRN4AXVpY9uOKuChlp8Do7JjuG8M+s0eZP6U0WSwzDIq2at7GRJ8RgpqUcD8W5eGIFqtYiXWOI/aDw+IH2POm6YyQKPUzDTLTb5B7JDbIjxEGtDDEajFSPjN/PjfBPKSHvmZAoWP/lMjkrdGNxvPRwC6/R2fbZqBkkIaQakW4ICe0IsPKlW/0b74J1WQTep8rIrPia34fV5yPKbSZlB06JgTjxvcySUsafVHfq22PKYPw;4:w4n9q+PwXTlLyIQJ0eLFdms5eyPCe5OyZCzKjxv9AUFd2CMo53wGGPd2+xOQ+udOqfjZUYFvU0Mv682wfTKbgU8hIalJosxW678k1D3aISvSVCD6+kW7JDuwy4ittc45ltN6lGGVeSbmrJ4MFPCYL5krywNye0LuFRsHstglaRHIcWZ3TDGBJngZjkZZSrdGCfw5y+LTNi6zKdC56FRvd+iCXMKgc6MHLwwJYAM7uOCWReO6IoaOzEj/wncdk1MfFZNmMPpTXzJRRLcGwQc7WFVxZwzlOkHmKmikIyw9Hk5xge/9AxA8No3mMoCZGCbv
X-Microsoft-Antispam-PRVS: <BY2PR15MB01672E3D91064053F89E58BDBE2D0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(25786009)(52116002)(54906003)(36756003)(16586007)(50226002)(68736007)(53936002)(316002)(51416003)(76176011)(6512007)(6486002)(52396003)(50466002)(5660300001)(6506007)(386003)(4326008)(478600001)(186003)(6916009)(1076002)(8676002)(305945005)(476003)(6116002)(11346002)(486006)(2351001)(6666003)(7736002)(2361001)(97736004)(8936002)(48376002)(446003)(2906002)(16526019)(53416004)(86362001)(47776003)(46003)(5024004)(69596002)(14444005)(106356001)(105586002)(81166006)(2616005)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:O0c7GCzOswgPv0rPZSw1leM0J5R1ADM+k277Wh+Sn?=
 =?us-ascii?Q?TbpVcv3q/HgICrJXecu/5ikkTkLsRgHlFr8jkpYNrh9sPum5okBfNlHY3lMg?=
 =?us-ascii?Q?yIE3B0AMvHVb1R9P/zhUGFMeQGvF52RlRKEMGg39JsBY3y5gVzN5Bgc1MSmf?=
 =?us-ascii?Q?w5wk+/E7oHhnkydOdHHu/S2ITPQ8GrZ8bH5gmK7DBii3J20EPU0a1yceaFIR?=
 =?us-ascii?Q?7+OoCm1OhqSMJ/bVbg8ZP12VHPNxm/lh6BQcAlAhwmoazqa5ac9J7pUtmJ1X?=
 =?us-ascii?Q?RBRrni9VYFYYb5I78CNr/cmj1OA2X1+boSTlbzP3wn1HhB+LjaUYCHHgGWmA?=
 =?us-ascii?Q?zSDkXI5yHRMtKhsOTIJdEwxvM83d2H/wXlNbk1XKEBfDfU02nbdxrhqATbny?=
 =?us-ascii?Q?GRgCkFDgJWd9Ba8ZXFAZkfw03BJeWBshRNmdrPpYhKO+P2warTwT0mQpsaAu?=
 =?us-ascii?Q?jDlKi+QIekPvDrOXSF7qEQNSTKW6ho322YKNUtI4Jg3O9zIupKn31PVajpJR?=
 =?us-ascii?Q?gPUXrV8P8Ti1eZsBeDnnT/dqtX9ASgOzV88Ujk3yvC0o3QSZNmFhMRSsGKRY?=
 =?us-ascii?Q?yv2JhxktUe9BmiO+y6fcvPDl7pwRoaGTHwGBHi/x6jgr+ue1KmQh6nN7jFhB?=
 =?us-ascii?Q?ooY5ubUSqr7napMX+5udfq1TvfrYjGtv/vKsouUGZ5WVtYmCNWjrinMN5+oI?=
 =?us-ascii?Q?YK6+at9xoUMJGDy/T71S5+7rJwEaezLRXHUUAxFuGn/x8UJYESeDpiT8nrwr?=
 =?us-ascii?Q?7rs+j0b6sCrptTATAHlVj3awouy0IahLw7jedshN9s2hHWQe+buBioOTjf/6?=
 =?us-ascii?Q?19h/JXzgRPc9K/ZZc1C+yDh7DeFRIkhsbGKpFgIBeC240bdTQMIuQ7oEmyk5?=
 =?us-ascii?Q?2kOSCCFfE/jrvnMV6Icf2rpryi3+ibfTyns7jDtMFSpPG+mHmgZalbKZuJZ6?=
 =?us-ascii?Q?7TZaM+wg8LbKcffoACnrfDjYGBxcZ0hrjaK41gL0ULqYJyjvG5t6T0N9kilg?=
 =?us-ascii?Q?1TxevjSV7Yd075lP2LD9do1TgfirDOMsaVHtCWqDhxDFhcs18R1iX0/7sSba?=
 =?us-ascii?Q?AiXmlX9euQEGfzUGctjgOwnMO1sH+uq094qJt89//LwSiWsiYUoGj1agsDi+?=
 =?us-ascii?Q?VYOLnsC99eLMhuokXpm7UUVcpTa+zpMVVVft2dhA6v+itVrYLFSvOVfzDQul?=
 =?us-ascii?Q?Fkd08zph2n30WmG2JxaqmgmgEclWuKDnwlIcMotTaWj5AWlJLRsJ1BbhRLyh?=
 =?us-ascii?Q?R8IL1WVUmgMM4CHr4bGU5lmm7+XiITiaEqkMbdBcxIQm1kz5oKcfTHbLAf+m?=
 =?us-ascii?Q?HmrHfPyIHk8p0AQwEcSWhI=3D?=
X-Microsoft-Antispam-Message-Info: Z3lBR9CG7dxjr0yzCUJ1GtxB33GWXeJFfRZsLxp771nVCR4fL0Bh/e0xg27Y4M0RQLh5UoyR9uuRolrncwWnRDkJlnoGqBUlBMEmXED+kg9Smf7+W8DlWIbbAJjo/nLJyxbbSe4m4eNfMarIc8xZmPbhAFoip3d0se8KheI9lqzUDm6a2oF7yCai1HHOxcHn4YU9a6uA6pmtIZBD3a/tDDrSYn0kmi0+thDknYl59VMuso3bG63IXsrgC0Rp4vRR0VoB+WOgIbTE6aIPVbJJB/ir7vEi8Q5T6WQLDWf8ag/ODwnxEgO96GkAO99MGgG43DWduplEnelhkxgdmcyL30cLQokk1jY2/jpVy3cYbgg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:eU1Xffp+rxjBlx7grHz1kueKal2wKwOF6A8q7cvAJpvo+bv9GPWjTuVyNkJLssMb9RBFpidBK5KLeFjXrs6Y0dhTRWTIuTcYxWjh8ZGar/1MOE6y3G+0zzQEvkVnrm+yWJjV49I+aSPpW9b2QLyIkkLFmYWf7NbEapop9sk91XorCenkrawvKFYtY3p/i1Yysqst8LfeLHHx8AiNKjK1YGGd9fo47fJwG60cx7Pw3S+hN8Xi8WF170aB4Y1c7XIHzzwJjI3DwQT3cr4VarXzZRDYgB+CrOjRZ/DEF6xC5RxGVfKfOpsKPC5VthdhtYq3uYxxmye/Z933qe9EsrjyJ6Shz2n3A72sLuRQ98yuOY6Ud2JU/E6ZUkmQ+qp9XV7CuandCoxvhgtVZPj7W/jgLU1EQBLLxzgkMM4or96KiFSD3p/L2jiLoC1XpRJl4gMhc/JEEQIyOu8TyysJ8rx/cQ==;5:oxgmsZgiBhgQievwZe1PJ2qcWzsOwnguPDIFU25ts++GB5L4K+P+ZaJDjxC4AyssEzOHtAhOekIOddeOV2ZnunMEvLzTVVc4DKecga2S154yB45td2X8CiuCBSsQ3b4+GKo6UW18SofJwQ/S4xj0p6MLAhyrY/iXRl+9QgHQEtw=;7:yFu7tVCJhUUhJGcFP65QxGrMlVcm4r6FOCZcvYiIXH0A096iP0c/ZOMlYlxyaGiFfKwodW3lUVI4ryHunS/zG1pBgBkIf48Nw4iCNw05CgSZt6mnVpCIk+3ELNJ/cXQU3boy6/4s9vGYsYmo1Jn2FM2IByoyHfxXJnbI3qBe5BeBeY4fg9U2SQCzBMpYm+RvuPOMEbI4gDvKAUyd1WIdPJTKIEC9mqtt4DzN+RSW6hIG/Xd82K6FRaNcriQZFn9n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:1sU3bYxWBtSYJgp++USSGNn/mhjeObzVx49eju2091rgnMm+GcdNSwpBY2MZzx0LGTe4lL8FI+3iwHlUEfwqMx2Y/4+5QQKUjOYBkIwDsY7bH1oWhm8/rayON0r5VTBUc04jlntFbAgMDpkW2gAz57EnDspmpm8MY4i37oyHSCs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 21:37:19.0767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5a1aa4-f4a2-4ebd-08a5-08d5f7f6f593
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync cgroup storage related changes:
1) new BPF_MAP_TYPE_CGROUP_STORAGE map type
2) struct bpf_cgroup_sotrage_key definition
3) get_local_storage() helper

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 tools/include/uapi/linux/bpf.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0ebaaf7f3568..dd5758dc35d3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -75,6 +75,11 @@ struct bpf_lpm_trie_key {
 	__u8	data[0];	/* Arbitrary size */
 };
 
+struct bpf_cgroup_storage_key {
+	__u64	cgroup_inode_id;	/* cgroup inode id */
+	__u32	attach_type;		/* program attach type */
+};
+
 /* BPF syscall commands, see bpf(2) man-page for details. */
 enum bpf_cmd {
 	BPF_MAP_CREATE,
@@ -120,6 +125,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_CPUMAP,
 	BPF_MAP_TYPE_XSKMAP,
 	BPF_MAP_TYPE_SOCKHASH,
+	BPF_MAP_TYPE_CGROUP_STORAGE,
 };
 
 enum bpf_prog_type {
@@ -2089,6 +2095,24 @@ union bpf_attr {
  * 	Return
  * 		A 64-bit integer containing the current cgroup id based
  * 		on the cgroup within which the current task is running.
+ *
+ * void* get_local_storage(void *map, u64 flags)
+ *	Description
+ *		Get the pointer to the local storage area.
+ *		The type and the size of the local storage is defined
+ *		by the *map* argument.
+ *		The *flags* meaning is specific for each map type,
+ *		and has to be 0 for cgroup local storage.
+ *
+ *		Depending on the bpf program type, a local storage area
+ *		can be shared between multiple instances of the bpf program,
+ *		running simultaneously.
+ *
+ *		A user should care about the synchronization by himself.
+ *		For example, by using the BPF_STX_XADD instruction to alter
+ *		the shared data.
+ *	Return
+ *		Pointer to the local storage area.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2171,7 +2195,8 @@ union bpf_attr {
 	FN(rc_repeat),			\
 	FN(rc_keydown),			\
 	FN(skb_cgroup_id),		\
-	FN(get_current_cgroup_id),
+	FN(get_current_cgroup_id),	\
+	FN(get_local_storage),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
-- 
2.14.4

