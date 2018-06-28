Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313B8C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7670273F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Gh9+maCa";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="KzduwyG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7670273F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935908AbeF1QuU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:50:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935792AbeF1Qsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:48:31 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w5SGiPIl021776;
        Thu, 28 Jun 2018 09:48:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hauErOPU9Ngex8QdOZKNN3FufCgW/7EA2hY09E2m0EY=;
 b=Gh9+maCa+KRf44pIkHSw1CKz/F51tPQHEcXCXxH5TQeOulVLb/qwoum5sZjxgfODcquG
 7UKup3c46DOcI4uV6exC4qWaq5FIv3u1CXqJPqd/lHU+/tHhogVouVqysTtAL+njMQmS
 2M6Stx4xYi8dGPOcmPHvbiFfaFrI5bqOGWU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2jw22p8ex1-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 28 Jun 2018 09:48:10 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.26) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 28 Jun 2018 12:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hauErOPU9Ngex8QdOZKNN3FufCgW/7EA2hY09E2m0EY=;
 b=KzduwyG9nuENM4QNB/HFOFsGbWciwaQpSAlz7VVikfe70y1/YicRpxzIB/V/6CQAaJLJNq3n0TAF6cnVJvE7q4YLVKOWW56kKEoeBu1ermCq+2xfD/pit9b1T4IDylmcLsCGkjA+4Jy456PSnLV+H+4z3rU3ZMEwf1AzGc1rr+E=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4716) by
 DM3PR15MB1081.namprd15.prod.outlook.com (2603:10b6:0:12::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Thu, 28 Jun 2018 16:48:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 09/14] bpf: sync bpf.h to tools/
Date:   Thu, 28 Jun 2018 09:47:14 -0700
Message-ID: <20180628164719.28215-10-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180628164719.28215-1-guro@fb.com>
References: <20180628164719.28215-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4716]
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9228aef1-0d19-4b36-39ae-08d5dd16ec3a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:DhRFIHn+WAnFqk0yDZdqc8Ay4BG3Gg6xLbTuF4P2n/Kj1sbSTCjZkXyDzmAXXdCaqRXrdFaMtPe96vT2qEXV+izlticNMoEbpsMXW2bQtiastxlOHULlyDacVVsasNvW1yyPISu7jdO4sxh7a4Wb3BVivwtMrFtkRjIR4Ap1EXTrVBbAojvC+rM21LKfFZ08+b/zyNaazVsmhWGaCqT57UTI0q66thuZAnBYBS02p0vB2lkR1y5tUjDYJ4Enhh7i;25:n5QS/FHYSJjR/5x3mcb2SaQV1ONHWD7ZaIAaRA3hqj13YFAN2LIv/61p/QTHb7QcarYw0xAWJi3dddYTiKQYjIB2IYQOS9bqFp9MDGw9oejA9DDSZn4GeO0ZF2RcMcflWC7dZb47UfEi4+VG0gezhmJtkHE7eSK6e31q1VrL9K61mQ4hrPS5KTq3MpOtXhJU8E1qNMkCfwC8X+3JzOBKV9Ij1N99TVvBWtxzhaz7Yxz2ku4LDKfMCslPhfEgKq4Zc/0wgfUiijiTj0elLuq4CKN8ep6bv68ci253HzcGKF7pL/TvTV/orQKsxAIBo5IQg7LROeIyJ8+xgnfzqGiOLA==;31:+vhRvrVRIzyoaAG0AL14BleyAsLptqVGjIRNji1xti53eHbWjq8Z4qqI+mWbAbQrFhXo8uVgDPtuhELYFe5DeqZsk4U9fyVQ3ZG6FyoK4ZmuiwEG319f0zkbBpicur0WBPMcGw3xHXyhQgHdhTtQxCDNZOQ+O7d2GdaXqIp6zpmKEsYwY88lc67/sGP84MMdH2LyH1AQP6buFTtYXdc0QmhRmHenzfnoIVkMacChg3s=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:wPsdCJ+w0FjOCdP8tgsOYBL3A5WXRlHND8ZuNw6hsKh9eYHSWgGHxnIpFZYCt1p6I30EaC03vBxKhtjcsk5VJAzZFaENIowA/VQuqh/g2amToi08ZfN4ytKKrXpdAkOG1rkBOfewbfd/EGo89xCVkgPxLNjnDvIlrYcTIzIaEkRBg/Vh3vre+ZxBe/Oro68+yE66VHnmlVKDua+/WAVd6+vZpSRmB8AG+2fgdpCZoT2/V6XYco2tZrYhL70h9Uko0mxifJwEXb9Bh6gvUyvVrqd45SxATZvfiRnCRis5lGct/tgGl64ctav6Z0mu5I8532dQ3noLmL35geAK1bLozoyP2NZugwSdTiA1A94ur7YFrkdG0x2pk0PkQuF2Zj59k26S8gHeGqkSe7YRJtvhu8sDJviYJK/msNHGm7u2OVBblOAqCYF2Fd6hpOVROgebufy/06XAUpqw42+0EsJ9ohmhlxA3ItoX9vhJ7B793vlr3vxFAIydhF59/aVkyOrO;4:9zoZrmqwg0BQjR9F3C9oMKYWnX5bTPn6SA63vA7G7p+Akeu0xpRaqE595cWLRFvZ27IQekx1kqvImzCZXPuSSlOR5hKamdPRM2W18J/aqwov8MwIvlYeFh0JF+BrP31YyJxVaoLKc+CfduJAqPn32yPTZZd/I3Wj5GSsa18SjSmGgKszpcddN81Q8LRnNtnwB04b8rx521y22MKk42R6HxDbtT6rEg35sp9AgYEqO/VVZbw4z+8XMoSxrO9VHKocgz2SjyceR207ehhWrxP/+sWU24DI7yeV2iulejZ3UvRRzOI1aY19oWqG4T9Lr7UA
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081FA03742E05B126006600BE4F0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(8676002)(6512007)(4326008)(81166006)(81156014)(69596002)(97736004)(52116002)(2361001)(51416003)(8936002)(76176011)(305945005)(53416004)(186003)(16526019)(6506007)(386003)(106356001)(105586002)(2906002)(25786009)(36756003)(52396003)(7736002)(68736007)(50226002)(5660300001)(6666003)(53936002)(6916009)(48376002)(50466002)(478600001)(6486002)(1076002)(47776003)(6116002)(86362001)(575784001)(5024004)(14444005)(16586007)(54906003)(46003)(476003)(486006)(446003)(2351001)(11346002)(2616005)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:pKLdKsU9z/FmJpGDyG+skHsTEqcVL3mFiO261QzsU?=
 =?us-ascii?Q?nZQ6p/re0XJtj9+2GdiqxKqAGi+q0OV4CscNWlssjhduNpLGBwFARDKtLSmX?=
 =?us-ascii?Q?bioepu4ncoKg5bOisgDFokK4Gu43AbWUTqu3J04aHFebUR3TRYZnodJRfIQv?=
 =?us-ascii?Q?fF8+8S+NisboC55UtBHu0pfsEWZcWZQKc/Kt9/tINEtGA7m9LyP1t6jhmQzD?=
 =?us-ascii?Q?NiCAG1X0wKT7decZQLjTvW+0/nJMNPO9zxYEqXVZ1t6ZiIw13GaN+MpoYFZN?=
 =?us-ascii?Q?BMK5myHkghCJFjLhSjC3uzDGTOCcHw+6bt3uWpnuR2OG4y7zOEQxpZyfdY78?=
 =?us-ascii?Q?mq0VDATqpIZvMc0BhMpgzIf8VLiwiJkv+7K3eUHl/woFxXd4jy+UfGlrtBFG?=
 =?us-ascii?Q?+4np3pvFDQvIU/rTsn3Ctyl/KbDg6bzO5sM4kYsRD8PzK7Nr+4i78MpNFXj8?=
 =?us-ascii?Q?MPSnrAQugU57SfESI0bNAf/Cn8wjUJj671SCD0+16SPEvNh04GeQn4sPLoYV?=
 =?us-ascii?Q?WLdbTKAwmhatMnpBw9O36ppKys3mAc73gByHK6yf6LxCVaFjOjxDjhHbod/7?=
 =?us-ascii?Q?VF2f3joCaQa9y2KHgLO4zgyNZISqI0vzx/ydIyXNvP12LCqzx9Zn9MUyOTPp?=
 =?us-ascii?Q?ZVBKDmUq22IuCDnrc1FCc11RA03rsXayyEqgIl1NNAN8h6lHJl4fwuHrJLMw?=
 =?us-ascii?Q?C7r4zJXxd+5O/syM8KsLTB4D4bqjjKaUSnrskrzL3P6DbbDQGTcK0oZ98ziQ?=
 =?us-ascii?Q?PmmYNb5EPQHHGB2GYZdfhl5+BUgt4/6o6KNYyBZUO5x+YumlkEa1kSWngEA6?=
 =?us-ascii?Q?cEACO/Xxlh5oSAVbbQv2+dLui+6pErnt1DlETaVxY+r9ftEwC90zbO+CQAe5?=
 =?us-ascii?Q?HbfFVIhJ4PY1pbK49NmYUMO3syPM9CF04HR5lx9kradGKFpRORCLPtVFAtwl?=
 =?us-ascii?Q?fWYwAsfl3G7/MY3dgamGHbCqqWJ79N7S2AAyT63Cemk9lruWx7P7Hi1xD40n?=
 =?us-ascii?Q?beVorHHjE3CBwKOcAFS4fXhbRBIS+P9Xbr8/qPApmLq6CLStZ2vtz64qQoXs?=
 =?us-ascii?Q?oi3kerrSQ2HmLFId/lA40mTL8UVIC+y8ld0yTsTHOD+B/Yqs8M6z73KQd/+a?=
 =?us-ascii?Q?lUm2Tj2/I0rqfHmr5nGNBche0mXqeHVF1SxLeuKgYdEqCj3Ulql/x6cuJWhH?=
 =?us-ascii?Q?+vL8JdP++k2p74JBX56cmzBpBdCsN4GIHEfnUtuV9+pHmIRzAgXGtq9ZyncM?=
 =?us-ascii?Q?gRkFmq2E7xskaDrfhPtSb7ULzj5mUr+S/GKwu0ICmLY0FMn3pz4tw38QK2Bb?=
 =?us-ascii?Q?kov9Kb4CO1+h/Zh4vhLyqNH63VqGQYy63Z6RawZs77A?=
X-Microsoft-Antispam-Message-Info: Rj9P2xc8SRhIeGb0c6aeMxOllubEX++Cwh2QkYO7T0M0zV7n/Auxa1RVWpqB8Lo8tiz8bpmbMk7rZbUbxJ9UR037OVAr5M6RaYh2nvLh3WlAZ5wBB3cZHR86Rxihpov6gEfnbqhkHu6AA4ehc4NIfHOhaQqpprNKzNSbSs89HFoZRW4qFs3ejxEpQMeeS++zMwuKH/f2CA3lghjwkR47gZR8/3R+kTZBSLxU0khDZRmi/tuP8PE2svUDy+bm/FYreX31rBkxT4NdemeiI2Ya4PIDO3SYNHMo8xw8Xl17LhXPBMJfaV+ZgK7HprJcMkU6+t2Lzb4wylYRKAPt+QFaOLCoRl/ZkCxkHZTp5buD5Nw=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:yDkLSrfunUEI9nnEja6VMd/K246zJVU33atK+jV6Aa7TcETPnAFhsLZUrAgI0XcmDtLCHnW7UCZ1Ju0hu7wTt6mw72WQ+FZ7ao+39J/3PHDnsAOA/IEXpS8WA2X2Ic7cLCsT+K/CIpxnhRQVPeqXShCdeN24gg/nOeda71bVTE0n7dOcjTNgGApuDzVgntaMbYHFvE70BctTvsKNukH1AdtUI02U5sNfIlw2s0z1mvF/mkCQ4bRFgIsvyKA9wHJB3zQaStZQTXbzV8rgUDEUizlpizxpB48PKXbLktafe+Ez/BWrO66pirqFefIaOvL+DYliAbse6aD2iNfYltKgg8Ud0JOAocaBn9Lj5nQkqDUxgyK2fmjc/xLCYSG0kMGJPndUY2qDAXnstO0fr+OCgAiQZ8mJCXytKl0jCaH6YM2kgnwZ+ZFoAERR4DYhlIcxsfAwFO6+FsWN3iGt/vbpTg==;5:BeRY5o+tC8tZ1PSIx3DkWRqsgTSgfH/T31isOBIVzihbRD2g6T2ePXpWCZFkOGbJTWO4kL3A9mByJTCYqOupxbcp7bd4IYFo17FsZu968qV3ZnjwZKfgv+dd1D2FYDKF6UG9r8+0teKE2tK23m+HSHcnDv37iLM9gz7PKQA4hsU=;24:B6lGKT+Ay+Qgz6321TwgFZhLgouYh7b139t0mkYVWToRnmZmQHxgON7nYQmkzbbeSUx10J6l8KNIOxolctZ6wGmk/Zj9DfnBFSop1apO80M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:K8nkNNi9C4rH99xSSe/zeLHai1opBBROiHSN/0aUUszXj90hEfPwcxmaotkq2otWervPUlZLndZH70sHgbsGQvyxk3xlKljCShCH5GjfQO+WEP2UgJpj9xRkMyMemsUK1kGqihkIp2McAFieJUPmWP2W+r0AKtGrFODR5vdkuKwtTO/d2gYVIC7D8PmP20nQN1M/Ag4Odn5sfBq4vcHmpUqBe5YeE6GPN2MhurDS270J52VCvw79/eWT2GhLFcvv;20:Nx87mFCiFODXQj+wIsKcEozT5VwkrCIcU60mcsMyK1hKj7aB3kRlEs/GAbArgwtvcoRh5KhtWZRhiDUDTmscrfr5PLbFNmasNLmnY3u2ekcAHQIUBrkHfGdK4FrJ7iJQgQwlkr2uwONUv9kCHoPZNMEf+RHCGF/f3Y08l/1F++E=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:48:05.6769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9228aef1-0d19-4b36-39ae-08d5dd16ec3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
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
 tools/include/uapi/linux/bpf.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0b06784f227..06e111181dda 100644
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
@@ -2157,7 +2163,8 @@ union bpf_attr {
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

