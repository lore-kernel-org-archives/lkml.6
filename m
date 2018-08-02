Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A85CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA3A215E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NhwmxfY9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Y3RnGGQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA3A215E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeHCAlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:41:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49818 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726850AbeHCAlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:41:19 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72Mh9eq018633;
        Thu, 2 Aug 2018 15:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=bxz+gULqcOmohTRg2AyZGNwzQnEXx+rvbldUhdkpm5w=;
 b=NhwmxfY9aaTWLY/sjZk6rE3g4d0Ga+HejBL8OlKB8Bg6gNb3RTXwkvL0Zkmxs2TBGSKE
 aK8L4yN/bEbc+Gv72kSm2tI2pPoX5vc2guEBz1IprUZBy27UJjcXwjhzZS0esai/m0lP
 f9ijVPOlSs3mDgx01kzsMohDuhBet2UO/gw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kma0v05hn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 15:47:39 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 18:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxz+gULqcOmohTRg2AyZGNwzQnEXx+rvbldUhdkpm5w=;
 b=Y3RnGGQRl/ayEVCPAUf1M8hjauVJ2uCvjn2tbQr6Gr4pKS66uBUIEaIcn+34PCLIBpQBAdyun9l8vt8OVcMuMbZJTaTjqfQcOdrL2iA4Tklqe7OBF6sFB0QMX0FSNya842yJ5mMOr5YokrmSAeN2w7vJgtY1NwfFu0Ch6bCqyC8=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 22:47:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Arthur Fabre <afabre@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: fix a typo in map in map test
Date:   Thu, 2 Aug 2018 15:47:10 -0700
Message-ID: <20180802224710.29662-1-guro@fb.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:300:115::15) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41b98f4e-e45f-4eb9-f467-08d5f8c9efd6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:UO9EFTtnBq48Oz3QFfyr2kOtmh51hGrtZmYv7eXkkUb+COo+HrZ7R30dUbReNgmlluL9WfEn3Vwq3IgggtLe7BTvAeqd2Ziqc/4n/xl3T+9fr3yvDBQR+KuaOmOz/KLIsyeVp31yUInmZSvUMBKAO66iQp6VtrYNc+fG7iAi+EQUtkuXX7/z5KfNtZhoyXWYvdLiz1tk6SWD8kAE/sBXS7OBM+BRn13mfTFUsyTw+0BovzgECJB4xYJyS1UJ5hWs;25:d+HcQFvS8RwuKKNiNCViG7an1WeHUKHy0nuQIwU3ywNJL3Fsn5iDM9xFDaxm8YU3q1cpsVEA20b9JODxT9uugCu72Y/V5eRcOS2glNqYbVvFK3xN9Dtgvh8Pj+5BfmiijLEOXSKjTrOL38hL4cEseh0Tz0lrRnyvB6d3QdNN/kuo1rvB8sqo3XowG2tFvNBaRUsyXtSh1417fbKXqfAzYA5KcGL8tKjSH80jDipRjcC7DYOWkumd+YyW3mB2eR70D3u+X8BDT+CQbMDVpy8uV9keT8HuTLneWfZw4oI1jLR3po+w+xSDn9RDCihQU159qizBIVgXQrPZiSfhM/VYuw==;31:tza5L5N2bLDwjSvBsMjo+wcJLPKqODIhXYggthHTAb/UptFqm0sHk6muzf8ijl5uFXMj1GF5IryFgIcPY7k2k2rSebAlPobsCjDo6jpxT9wXhcQ1YVpNmBYRRz0pLiQdOClb+aTX2ki+wcx7mZ7brXn3tP/VFWLodcpak2Y47yavUqmtuPIq6jGzV2JWn8hLSbXQky2kSXdIOqIsQoC6/hsflwHz7D0LnJb8kKpUE9o=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:8ZvOsGaLmShC3ztX/RSoiZbtFV5s/PPMoR/BmmG2qZxXQysnrTvJaFLv7UWTrUeI/tQMCHF6eRonEedLDV7fNg1fQlKGVIJ31H16HJNRFVKQTv/78Ql9GMHBrOy1aFnecZDo5IZp7+sZp8Bv3fKYn5MIgUgtXRSvRH//UiWHwIQuk3OLsV0PkE8anigDLiiL7abGtF0lfHPW9SegiXmN2BrG15VFnSzlTmOc5TB3skg3jHJXnMWxTOfT/q2PS9S/wPAmIZjOIXeoM+baVwnCWu94bDzAOP31H3h0nhFlKZvAvC/poD9dEn80jTlLnweGVU5tGIMIUcjroYe7FliAK8m7JNARrAS+YWeWrpnRUoy5XjuzhL2xGQOw1DUndA1KdBhd2dIWbEAmAVjLVf/WNMk+jGL4EgREvxAVQnoduB2PFgcZn/H3QTLdCQ2zpi9WoyrYm+s1VuTbflYy0jqnR9XYwOKL6bJ21lbkXCHWEyfk5ZEIgzDR/Kf+ydmV68j+;4:up8/w8iLjO8N5FeNp0TbL9ky5umAjPKlSdnghhE+/LOGfNSaXa/1zQ+b16ZY6PAbdYS64p4YZDuL4QDUpweeTCcCwM2V0wlHFaE2Fx+adyQDp1mH/jEXR+9HGqcLITcLhe8hThgsXXyzQdA9N7nIU6MhTl5wwf+ovS5GSeeSU3vZpZuTFHsJTv0d/lm88tPkS8HJr5T8N/V4IDybCgOVoZjYvky6sESGf1hpZOM9glrf1laAnbw02QvlUBCXqNlleypIxO12zj3/H4octPprO1Q8PQHHWaSSWGXoDMavteqh9QvUT/4L77tr+2GfGdgw
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167B9893E4BBDF9FE173ACDBE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(366004)(376002)(199004)(189003)(48376002)(97736004)(1076002)(86362001)(8676002)(305945005)(186003)(8936002)(2906002)(6916009)(7736002)(486006)(6666003)(6116002)(476003)(2351001)(106356001)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(69596002)(81166006)(46003)(53416004)(47776003)(36756003)(316002)(51416003)(4326008)(52116002)(50226002)(16586007)(54906003)(68736007)(53936002)(50466002)(52396003)(386003)(6506007)(5660300001)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:TRNLyzMhNJJxvPhTi/vC3bl7qR9tdJH+aUZexR523?=
 =?us-ascii?Q?LkZmIsG2gSGtBLIKiHN7z2NIixCOZHhdnAbOW7qTqNt8qJXYl8AttRMil2VS?=
 =?us-ascii?Q?vOVx63/A86QOjA9aj2Wb54z1U39xmrgDMFn1rprgCLM0U0Ji/xH6emiH7+CC?=
 =?us-ascii?Q?/Iq0WGKrn0NVESvbkKCFBf8S3hSEsXfARQosuCCIitfvn7CRo1bHxM4sYIsz?=
 =?us-ascii?Q?Tschew0bjmj2I+PP+SyHp+9MzfvFbRiVAXUU3cheCBo9kGQB2n7ONNdXMW6B?=
 =?us-ascii?Q?gOgtRrYuER1AHAPq+nFHZbJEBmEokHCbChz/4UEBXrIiQWXMOlG83V3mASek?=
 =?us-ascii?Q?2nJpkb+OcZmn14CKJR6dQpLxEifmmJBcpSDkjz45mVybSPMuI9zC51dqhRkP?=
 =?us-ascii?Q?zaS+A1UePb7C/9zv+6qqvqLT8afNVBb8hNM5YPmiYKGpPr+cFui78rsnIuOp?=
 =?us-ascii?Q?zPhn0X2gZ/OkQ6qBhdePwAapBQprr7jY5MzDQuXn/S8GsotcUfNbqKou8jfX?=
 =?us-ascii?Q?dBPcPve9ICMvkzHmxel9KKdrbsfSb6mzJ6qTX1MUoHxWuNFeXIgXNiO6AGkD?=
 =?us-ascii?Q?ho5jDivo4uoC2tA6W92ftkXI/bZkqxqZ1ffxWIYi3Vsp4ztDJC8Jq8rt8zuU?=
 =?us-ascii?Q?AkOV6drcelan1OBT73+NJ3gsTcpYj9WQwqzffWoQFmr+ydhaT5JCSbb5k65J?=
 =?us-ascii?Q?e/3rOzSBt1aL2qjFq/qoJe/fje8fd+Li/HT8LZzS16aa5PzUPvQT+1f+O8X2?=
 =?us-ascii?Q?HDxBaFTDcdr3QmB429+GGQ6DZ901eijbY3mnpKF6OrW5elpXIWI4QgCOPm/C?=
 =?us-ascii?Q?GBCUXBlPpxveMF5E49+JqZ6PSYkGYys3jNM8CHHmetCiS0/ReptcR8qV5hGC?=
 =?us-ascii?Q?iRVyV0oQ0t2uZMNwyAqZpXpyIJjz4ibFSlRfFq3vmZt3ui/pAnOIKpHbQcTs?=
 =?us-ascii?Q?puVX6urpEv6Dwi3gMVBYYHfoOZh5G+FjaG+teEOBAYExIdFcXy7IL4XSGFh/?=
 =?us-ascii?Q?49W3IYs+G2RGD535wh9dYeRjgav6QKV9jxAvcSsNuOP8HKVKjguvJsbgM1pH?=
 =?us-ascii?Q?YkTOoUb0unSeJe8LxO83JA37pJ7UeByBP9ghYvNCApJpqaDy+0E7Iafi94iz?=
 =?us-ascii?Q?djO0thn2kYwMJvbgiWECEJJThTOudadMvdINXI87+BouBNuOS4CmiYmNLK3u?=
 =?us-ascii?Q?slHi98/bDbuNHGpdNM65XfjrMR8tT/R8xM7QeYtduHaOD3DnewAYN7s1A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: uGmWR+nTOne/T73HIqie/VuhlS18im0Pd2jkRmokLNucf8xvpmWye3e+hessclHzN4AjbH37stBdzYSI506GpaJAPQrNxeQz8rOCHEOBpX5FFflPMfYxBzCensRyVADuOscKXGR2RnCVGlCpevzF35tDKwUqV8L05D9wM7DtotZvfpd7sxcPOwoIeAKzkPzz7/aHbS92nSZzjgmI0y7qOPFa4UAZEWI3cz9/Nw86NOop32iW/pJOh7INOMDGXm2/a7lQNjAnXd8nsTETo+r32oRCmEnlO+n2z6PL1XMZM/ANlp/yxrTtw5AZGXpeiCL+AvBZpcxvheLGfcIElKXW2ad5MXMUu2ctEJqaiaop5ug=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:ygNAlK2DBbcfi3fMmDF6KQtJbCVT9hO5OxiTwxEx9c3kebCiwaZA2oiRUkoJsHreuZf+IL4oJscRPYu+VQDdrUDC31xwc0zcfCnoNIsIsvSXk6pJDBDj6DYzVQFqfn7rGvHXLjXvg4mI8J9hEp1M9wJ5dBNeKMaKbDfKPx7ucu9RNzRlDfvu3XPA21GHx4e1mCjeMRzRD5wgsnxZmlbFx89mB5VVG74w4ID/8W76KjWZ/7CeCxkgk3K0EkEdeJc0yryFh5Wev4cRUCT1yffjkAvie48BNe/i+YEOVQlEOdNnKXyqaKr+6X2CIcEBQu0YZSqb3RGJvQBxGA8eWI32H5w7ZIulGL7Vur5c+2PLraIpHvkjF5h67tdUe1mf4ZVlmxkoW8Xt8Yoiv3wam6FcEbglV76wiSX92hFzYH8ue1zzeS1l/pmKsRiNsjtQcT7X3lAqsxkkyyX0eJEEdFLchQ==;5:DUukdQwBSqM9QZSRYFUxXNIhY0Td7ECOP6PQOc91tx5O5DoqQEgrl5LroZb5i1dMre0FT5RItTqbGTDXcjxloRWchLUtq1PYXaRhtwq1u/oTXlKobJkG4c0UScg0v7M5xl06OBM+RgCtm+ARjcDk0i1YO8C2A5YKc7ipQg7F13Y=;7:JcAIYsN+ryEZWHx3opIHZZQ8EsNxX18b7jtRNKY8Xn9YTIu0R6zumGWGq0WrzepisdnSCK+Vz4UT6QBbu7FKjasMu/DMA50G0ccTU4PyYHbttlRakHetZgRuuYcbhFsXeM9Sccc03uLQaFtbEdcFIOSrnb2HA/AOFcG1FZGRGjeY/UxQofTVuK+IbIrWRabSOTdk5qUNHMXht/qGZ1BG34qSyYdsF4ekJLFh2eUngDCpDcR6MZwHJGX0WxL7JLXC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:dwAQGNNKcKzZDkXZLV4hLAE1ib9kfn6JJBcaUqai9ldixVAwGImpbp33VepIkMY0wjCS1cAAYQiqBudCx6rgEkhaJTVZ/eLbAevyPFVLvW3XuYWZemBoNS1XuJA8VaFhcNhtck0MF0RbjM2h17ql2lGGjDZg+4NiWWWav2AdRig=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 22:47:33.3144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b98f4e-e45f-4eb9-f467-08d5f8c9efd6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fbeb1603bf4e ("bpf: verifier: MOV64 don't mark dst reg unbounded")
revealed a typo in commit fb30d4b71214 ("bpf: Add tests for map-in-map"):
BPF_MOV64_REG(BPF_REG_0, 0) was used instead of
BPF_MOV64_IMM(BPF_REG_0, 0).

I've noticed the problem by running bpf kselftests.

Fixes: fb30d4b71214 ("bpf: Add tests for map-in-map")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Arthur Fabre <afabre@cloudflare.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 4b5e03c25204..ac281ee771dd 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -7113,7 +7113,7 @@ static struct bpf_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map = { 3 },
@@ -7136,7 +7136,7 @@ static struct bpf_test tests[] = {
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map = { 3 },
@@ -7158,7 +7158,7 @@ static struct bpf_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
 			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 				     BPF_FUNC_map_lookup_elem),
-			BPF_MOV64_REG(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
 			BPF_EXIT_INSN(),
 		},
 		.fixup_map_in_map = { 3 },
-- 
2.14.4

