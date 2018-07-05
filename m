Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D09C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5898F23FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="InCcNxX7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Q1KtyX/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5898F23FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbeGEUxu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:53:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754351AbeGEUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:52:43 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65KmMgp015406;
        Thu, 5 Jul 2018 13:52:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=iNUAcdpdDdrMSp1qsYR2m7c7pdvONetxmafQt7CrUg8=;
 b=InCcNxX7hUPyiT9PddzruNpGmlRgdr582xAFQ2gJxMED8NndLRstVF/8evqkmLHDDwDf
 HZDUEvyYDay76V60/w8v2pjcMLRaFSFTnGODjBXDUzot1gfCeP0n30kqnNblbsdBpGir
 gdnXa39tLYXtFmFjiiouaP3XCfZzQvJL3jI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1r3m0eus-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 13:52:21 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.19) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 13:52:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNUAcdpdDdrMSp1qsYR2m7c7pdvONetxmafQt7CrUg8=;
 b=Q1KtyX/Bx7u7Vz+TKSLuVJw7P/66vgRxlxjS+iAY2OALV+oSQpMXBcFhnVqD+KBHysa73oESrq0+jfPyM10yJg6w8fXDz9FPOZqKLjcUZcdPTYVkTe5Fa7RRlBPzlHKbEAPnkTz6rqv40GWkcezm3NyOKzfiFsozsY/Ar8BG/FQ=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:9a3d) by
 BY2PR15MB0166.namprd15.prod.outlook.com (2a01:111:e400:58e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Thu, 5 Jul
 2018 20:52:16 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 bpf-next 09/14] bpf: sync bpf.h to tools/
Date:   Thu, 5 Jul 2018 13:51:34 -0700
Message-ID: <20180705205139.3462-10-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180705205139.3462-1-guro@fb.com>
References: <20180705205139.3462-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:9a3d]
X-ClientProxiedBy: MWHPR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:300:95::11) To BY2PR15MB0166.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c667543-56a2-4d55-a72b-08d5e2b9315a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0166;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;3:wi3sMXo2sYujVFGLcwk+7+Dnxfyj2COA/dkG1U8gQc7UiWpUdtUGwoYOPM8aZtiu7n/ni5Qky0feJdFOJ48FS1ctuTrM4zLJfKvEMKRwhQVNUXAJpVloVHnXY4LiIFvBu4vbm4csMt1QCV3PDQAHDh7YmK9dLMM7f3hnDzqI8tmDQEQ9KTF7cMbHbc0vYwDaTxZDESujmxuqg6P14/VNBeK2+skI9lbit4cB/nYFDmVMd+4GR2kjHEQ/eI98mcS1;25:B+biqH13kPxjdPAeyYn2alUFgMSCieI9Mhbq3H8f0S/uEw5v7Kpdi3OdpZf8qAu72Qqi68GQqPxTbbnmSINkoGF9c320Y1ZY+RMCnaUh8EvsEQ6FV1kfJFEjYQ7lc6BzzXU8G1mzko+qpOjwx8W4HEvFCtHpsiUnOTZBwsbZlqZF1LreBQ+16zTT2kTiy8SI6b9JmTD+n4QgMJtKayrYvAAAt6saoaa4uP4G4fxe0nW8O1euDYdO1johEp4dj4BzxRr2WFIbZzSAvXA0CbktUXigQOT3bIjlqOjwv+zuRCauKNsNx+W0aPYXRDrTM5r+w5aNs6VZv7LsRJ1vweiKsw==;31:5NRXUJqOxXPHl+KR+GDhsd2CjNxB6swIKFpLEk1K3rOx9g9tEX3iUgdzK8koDcVsZMmppneWg6+6usZ3s+Fuo48A/LtHUNqsda8ZWZvPqlDMbMT6HkJ5nhQihmvHuMyA7Q3+aKXNS1tnKDmfyTuhh/iE5uvVe+slGrfSgLranyJrlOJf2L6vwrTSMkZf8FFUkwPVeqsXP9DPCgQzdrkukbOjlZlPL59eKnPGJlUbAKg=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0166:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;20:URG5djpI7MlHmJk4O8FHy1kwq25BhdPIKgmtP4BlW4uNDrx3KToZswrlKXt+/3b3nMMxgkynrzWsEg6c+GsZwSKfQPGh7w19jg7HA0UtPsxhx+48TSKUKRjTQdEStt77SjTHrnSg1+wVEbaxHZfks2bGmGS8ZUGIa7ue9ZqxW/94aX516DBKcI0X70KONRYMUo6v0XLBRbulke07q6sjMzKRaH9lIltV8x1QZi1l6mLFsuCd3Du4VsCR1nZoavWpfG4eDNdTmJaGZ4uWJwQtg3VFwbJvwvyX7S2qtYoc6PVTxjQpUluPeWGo0U6Awbqc0dcTJSNP5y1vHKxfCjBhq0H8+FGHl+/bPCEeIuO5mox6+pOUdtbxvC4b4efdga7qHJ4bFq57Uvvi74qURs+TfB3v62A72aSrsS7IXt5x926jIAuIwaXrrL8RqA73r2JOeNPnYfsAVrJ86iQG0aDuCqS+nlorpYOYS197iqMoNzSHPj/YysIDvOUI5BYdNfIf;4:1+PHOjfpQ3t7+idRebOBadEpW8OiLnJo7waPew45rKGxuaArcapJIJlAr3fkUjpzTLCBog4zsbeS5DfT6wNjdr8hCA5P5WnBfB72tVd5xoddZOd0QZ06GtBDEu2v9s1H87hHCPbCMG/gJX6IlNShiP4F75XW6s/tykBNw7iPQosMTp8NUSMTwy6UDB7X7LnRYpwsizIbMF8PeJJ85dtRXd/CREPj8J9XePIJ9uYmWLzBfzE8YJ3uNY2vZopyC4FxXU0llaJsp+7z7J3Hz/AXqMosSGzYR4F4S9cibQzvWZ6HukD+S7OR5+C+BmOOB3eq
X-Microsoft-Antispam-PRVS: <BY2PR15MB0166E5924F5B8F0907548053BE400@BY2PR15MB0166.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0166;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0166;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(11346002)(446003)(5660300001)(25786009)(6512007)(4326008)(53936002)(6916009)(6666003)(6116002)(7736002)(16526019)(50466002)(8936002)(48376002)(105586002)(53416004)(486006)(316002)(54906003)(68736007)(1076002)(186003)(16586007)(47776003)(476003)(2616005)(478600001)(106356001)(81166006)(5024004)(69596002)(8676002)(81156014)(305945005)(14444005)(97736004)(51416003)(86362001)(2906002)(46003)(2351001)(50226002)(6506007)(2361001)(52396003)(36756003)(6486002)(76176011)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0166;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0166;23:du87Cp8Qqok9jbAA99J8crWuV8ze7wBYsCAcOgwTq?=
 =?us-ascii?Q?jAk+KCnZNEPBO0G4vhLnMPzXjvXEkJY6EfsFCy0ydsRdbpt0UR0cuzEpkY+X?=
 =?us-ascii?Q?zb9UcwqKl5Y/NbRUXDH/EfO7V5MEKL/66ksg9lQJ/V7UMsu1nAUXcl5M8rAM?=
 =?us-ascii?Q?4Qd8/wMgf67E71yNrKT3wHuPsr4tuCIv35iPbG5CH5DCxm0+zESxTJcXrcl1?=
 =?us-ascii?Q?iyEdo/NV2TkwlmZVPnR3exJIPHuqKGrfPQEnyDTtiqBAsJntd35o3zBcjW13?=
 =?us-ascii?Q?0r9m5kwseBt2A25BXfnSaW9U0vKTTVxXxTxXhUwSMoSqxw9rz/pECqq+57g1?=
 =?us-ascii?Q?5tFVNJgZ+tLPeZS+lCpj2dQKLPcjX6PnbAvgH/1N3cCXFIRIZeiyxLTTl07H?=
 =?us-ascii?Q?BNSWlts1xr+n5Qn46xMbxkZwJP9V+Ti8opkP7pFG24bcCtMerc7R0kNEpwX1?=
 =?us-ascii?Q?/DeSCB8snHon8quOCWYxVBOS+Vv2VAMEalKikOyDvnbQo3u9rHzXk2SG/oqd?=
 =?us-ascii?Q?qJYTfrRXVk0qOBvrsK5feEvFukAYNK2PPNqF0zTMqBYprgbVps2sgDAGscpZ?=
 =?us-ascii?Q?TQ/CNM9pzMcibaIcwRPApf0rS2dmzmSNKvzcARm8fAOEu/9cdTgsSdA5sNws?=
 =?us-ascii?Q?orrYRlWZ38tGcaNMlAZrx7T7fPVrfYo8Gfn0/oOAg+L0BIdS6EhtIbjwa7o3?=
 =?us-ascii?Q?9+OtRVmvab7tN06BKTArwJcTz7nMlMqoYVSnK/fQXxTlFxKxxhGDLdWPwhxH?=
 =?us-ascii?Q?4AshUPmMnzdwCaWly51d5W+PrnM3x9WhbJ47/aEaBnz44URD41C9fBnGtWyY?=
 =?us-ascii?Q?bpsn02moQaTyHDKjhJliXZ7WwV2QB8TOU8nZQnAu/aCK0aZRfz6TIA1aBtjM?=
 =?us-ascii?Q?rk6+9kc7tOu//HC2EySYHxZMkrB4sijRyYfJTuJ1D7dFYp+5o4t53Wl/3Swk?=
 =?us-ascii?Q?0P57dafatpCFRgfYf6TogSGn8+EPYRVGGBIfWZX9VwnQ4RKAYhTp/BY78ZU1?=
 =?us-ascii?Q?nurPuIw55JYmsuqjRtxKbwaTs5Bps/emP6L5mpZLVlxoVJQb+b3ZtYKKzai/?=
 =?us-ascii?Q?NRYb7LKgenqd30DHNs9qjt4Rn+IuJLRuOPtyVu8U2Hp1taXBMAx+HxzK3Lep?=
 =?us-ascii?Q?ESwge1lVBh7a0bH3YQpnEbnv/aMvyEPX1Ix+5/FeH2YvU68p/W8hQSbv85cQ?=
 =?us-ascii?Q?EKnDoq1ToNsOLTw/PRw8qLcJKYE00VXIH6y3x6//zxVoRTBcfnlPyvVF7p9D?=
 =?us-ascii?Q?xhpuk/Brp4OdteIDOAEz4DpsGwYCEWsyIJIllITMDBvE9bPYFScsGufOTa9u?=
 =?us-ascii?Q?k7MP0L2XGTfsCHpVUNB3is=3D?=
X-Microsoft-Antispam-Message-Info: eebcqtBYukopbI/CKtRI1oZ5fvE+3dbMfRkKcSlAkQnKwhH056PmUPA4HWz1yZ4OnNZwPa2ZcStpBfoOK6D1QmkIRLyr0GgkZHtxf4qBuKx3Or1TtfkJOX0A11xdhqTXYxzo1kZ0pFOQiIodIHG2Duh8f5MfrN9SfxX5+0DK+wnKrjNDXCaJ3r/Fd6X4//ZupNCqAZhha/vGVsjo3Fw72eRkDFw9RqiCyBiCVog02Ywfjs4D+njP/at0f/NMhI0fghktdahEZJKOEsLPabazUH2zYLPH5zeqHCQ7xMPOkn0JI9hpKjnCWOBu+UZN9Osg3AOeXDUZthOd4me7DTpL3Aeoo75uYpjjMzfruBI0FsE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;6:WJd3EawOzz1I3M2g7taOWVb3IrXx1ijbHoe/E0ftG9H/81BFS+Qe4Z89czECBPKrk8iafJKlVyQ0tUOmHvCj1a/Wm2ThfGQcbkT8AfGle7IK1jzppesVe7nxcpwplgFM2y+Ert1Mrws+g1Fl0VEUjErxv7Rk8WDXe6fdJP1ioWXr8AsIhy+A2dRFtWMPbhy0p3YNvVqL3T8ffVxwgXcQTuw1ddMSKziYsqDi1sghsf7j7Ntwn5CY7KID1mjCA7ozoa+ErriFzQQ21Pe0l6HA3LsNYkzr8i0U4eCm03zBmnZAKC2d9UM7r6MExAKe2eTsiQjQTg8pLZKDgfThl4BW1204LJVzfdSy9n9aSA8ARj0KvzC7TK1tuKptKwUE0xHJcrqw8pPovQLpsxii7srSk9mcst8pqULWuPx6Ihw1x3aPpXFESjN30gaUzWmJqaKCqqsFyoCq7DO2mNGems4ZhA==;5:4Nuz0WCjSsPATOFifkAVlxyr/55KRefILbC47KnU/Uy0yTNZ64woNeTqRP8pDY9gnJeSIr9KA+vuTKOfE7/VV3Lp+ULIZB5XHqTLrgfYReKPgBT2tf9Jcoqx5seJZbuOv0sgG9unduic54fgjHxDeSSo7Ect94TtD/IflQto+G8=;24:v5lJR+GZguFu258guSJM9+zy0ap2UDTOVi6HGDwpXXwOTBbe/iandHA9j/EWSVicnqh+4CSjgSdt1lVovA7XCKT4LwqtGQr1M8hf5cHQ3E4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0166;7:hcPhj55OSpDsQDv0C3GTCIur1gpe/no9AU+NPF5wrciWd1GAcRBwFVdEBctAqeHi7kuDvzAV2S5d5Qe510VldmlDfNA6bv0p6uUXCtIhgr80g2d6q2Kgdp9aW+6OkllwAg+qA0ZfhgaKbBb8c4HJr67r2oPM95hCbP/hJ2THLLURoV/aaPREie+l0TfbXuFFc/yl+IK7amZUYfS9ZssvUKffhkTDe19UeRULB+oZtn2exZxg95CSMnd4ZGk8/JUO;20:0NeuOvJL/SsaDcIdfsp3JFJZJVVD9OEZwLkCGPGhnIWtL8VZWYLH3ldnYclcOVK4MKY3Swv6aCG4BYJQji7T+yihqKPAYtV0xnkVQeuLucg9v/TOLHFqbkP++XM5qPtHlKqpFWH8O9+1TCqeE0/AAtpV8yy3u6XCS0euemFY+6o=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 20:52:16.1299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c667543-56a2-4d55-a72b-08d5e2b9315a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_08:,,
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
index 59b19b6a40d7..84480330c607 100644
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

