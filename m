Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5B0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D14620842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="USYYqPQ6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GSecQYCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D14620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbeG0XSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:18:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389985AbeG0XRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:17:22 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RLiNiv014649;
        Fri, 27 Jul 2018 14:53:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=yfQNPwrixdaFLklu1XukLvaBulPKXRb5WdJIli+pp/s=;
 b=USYYqPQ6vLAHMXfLAjSEGc8i2HrWTpeWLMcZ9GCJUVqz2pA51Si8uB5kevjJaU9UBMhp
 L77WKrePioQZmx86ayLUfoBkfabK52WbHxIYblHATPjKqxufssrPrpxMeiojwnbs2pOl
 pdOdj3GuDuc7JeNCabjwDn+tv/ByLMq9KUE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kgb59g2nd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 14:53:12 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 27 Jul 2018 17:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfQNPwrixdaFLklu1XukLvaBulPKXRb5WdJIli+pp/s=;
 b=GSecQYCwK+3RmjNXJEoAiELTyWiVwXMK9uRPG6zLuZmdL7p3hmsHEXb1uSPtbSvbND5peeE//LqG8r2wRTkT72eGLNgGBwXml2gHh2DrPLA97AebRuJRfizBGgy8Jv9hDVdqcbH656reGHWFLUUYnrJqIxyMojzELzeEAo4hwFM=
Received: from castle.thefacebook.com (2620:10d:c090:200::5:fd07) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Fri, 27 Jul
 2018 21:53:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v4 bpf-next 09/14] bpf: sync bpf.h to tools/
Date:   Fri, 27 Jul 2018 14:52:38 -0700
Message-ID: <20180727215243.3850-10-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180727215243.3850-1-guro@fb.com>
References: <20180727215243.3850-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::5:fd07]
X-ClientProxiedBy: MWHPR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:301:1::30) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a11314c-a59b-4ac7-7625-08d5f40b56c9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:w1XkiDEj/RH1k39I/91x99cAtxfUsJJw0n91Jtpv2TuTVdESn4ATVBhkNlmCiw6dlfg7Hs9VxX9X3ZZYGg028pVr3YSZwoI5fW887y2t+Mhkn4xk5wZyOc0FU5pkqj0xzyH03RIPByAeogmm+x60ON4Do1UsLiGN5ris68Nd13NrnO3fPSNahACaIbgoCQUCr052rL+tvfAdIu0hskdU7CINbEpazXLNMv3hBoBXW53yIjXQHvRxWAeGhOPCMgSe;25:ZeEZA5ktEHa8rl5kC8rwgR9tgqNuyTvLPdZipt/1aaccgZxQx5ERpu+Tc0oeJZSiKiJL7YwQl+UUkpjPzvEBX+WW4/lkHCAWQNQZWpd6Ir5g6yDoxFcZxdjNQFIpVJp4huXnyu1KpIkbETyMXMEzR339XQBL/uOlV/j/qTQ9C8k3QEzoXdgcXV4/k7qmcLyXPkA9lLY4pKwrP/oAXcX6QsihV3sKUmgL/NhIPARpWXkqFKblImKrpp5/RH81YvpNogyOBxiFgQqJ2D5XkbD6/zAd1zTOcPH6xEwdFI9kEU7V3rZgAwQm70sha0MszgaPt+T5nWfu6o5R4K99Ig/5sQ==;31:v3agXvVMeqdt6bhMJAIwdsLiLcM3MHKWF6FG61xuC519ez18z8ssbo0ByH069sgNG5OppyGKyvp6tFA1f2gboxoQt6wdsXemli5p40LbOUvcW5oab0TfUlXlWdF1eS+syZ43/2v6OFzMD0zkjm4fD8BdRtns7XMjoz2zZxyVptanSk3HVBmLz7Kk07F9bSE8maHApvJxqC1+YfmN+PkxCzEGLZFgf7DAVVDb9baSOOg=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:+BxG1KaLyQ+Zj+ZOYZ1iXXvPREtjdo84qsGIJQUsEIMZv90nnt/jutbMvlFHvIxqKCFFzy4F1tGfFov8171j+g+pBc4nettV/eZL/UZ3GLlYtXcFUlqpX9VJIxeOQhl35Q3+K8cl1b8FFcQAeFxJ6js+MZpxSGjsMUjSEmfjVL3mc0GQCEugShIASjZs2tPhDnkc8z0xg6dziE2F3hMbjJQQtP2NuKOf3p8joHJpfdW6FtZuB3ojBrFHlAFJ860nw9wcaJwm8+kAzNkg9/s3pv1fBJiA3KilqtdauSen32Qw9BP8wjlYwJMe/ChlXRPq0+U6QuBRPNh3uwRIENIeHCv2mmD5dxly0CdJv6qoJ7nYRBFV9U98FpP0PcPQ4csscrvb+MHYGQHLQQ3HXc7xOkvIFs//M22sBUNuS0i4o9IstLWDQtVscgjjvl9jFHGhS+totLbMkMUvLELPIp43Vp4hXooYtLgUq6WMqmZkZSNZZ8n8fPCq8RAKM9/F4qWx;4:hkJHe63yGgqlSDqPkaVuAuKDuqJlrA2TJAckgMx/e09Q542RE79bkkdzC/N397M4c9vLISuFbF8SBHoUjpA7PWLevksy3W9vADpR/Z5cLUx/lG5QMruCJHcfqdi4zSrU3TO3LbKjqW0NNtoZMbwpHQSSDSB3MiX3UrKAclXYmv7B8wfy0woYhuNnIVSCORGTSrnKF+CW7cXD142YRgEFcz8dei74rUhmGUU4ErYZSdFXHw39+CUv+8/Eqr0LYgqTucFrzKziGjSgMNc5GQWjrwJtdnPoby/6l+qgUedHhFdJhu0AzFldbpHUOsedwzhT
X-Microsoft-Antispam-PRVS: <CY1PR15MB01717B871A4C4B2EB30F1236BE2A0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(478600001)(36756003)(52116002)(76176011)(106356001)(52396003)(316002)(50226002)(53416004)(51416003)(6512007)(68736007)(50466002)(48376002)(105586002)(2361001)(4326008)(53936002)(25786009)(16586007)(54906003)(2351001)(97736004)(6506007)(386003)(305945005)(7736002)(11346002)(446003)(46003)(486006)(2616005)(69596002)(6666003)(186003)(16526019)(5660300001)(47776003)(476003)(6486002)(6916009)(8936002)(5024004)(86362001)(6116002)(14444005)(1076002)(81156014)(8676002)(81166006)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:d86NcPzJhv9eb8LVYUhCV0QZaQRI40+7wHG5Z3BSr?=
 =?us-ascii?Q?Pg3LAifUfWzmtmOPB5FGTiBsCM89U1P7+WrOaERBz3uypJec+pO2dU8Xh/oK?=
 =?us-ascii?Q?MIoFHqruc2aJjk0hBMdhdT/roKmCUFMkaVRltgjlNAbeiuFfbfASJ2jXXNLo?=
 =?us-ascii?Q?hap6485ynQaHvyBF6sM0FldHyfloW3XnEcqq6BL8pUq4zdMg1tmDh/ddU5O6?=
 =?us-ascii?Q?Kre3szxMrXHtNE//NI1qYsXNaeRfjadhzKvwkY5y48gDRQ5VcV8hho8HL4dQ?=
 =?us-ascii?Q?JzjwkDHPJeSbFPR8QsyKe1pXCpXY8c1ptb4c38iFQLUgPUfKa3q1SzAhGWQj?=
 =?us-ascii?Q?WhL5RbZdoWYlpHNqq9Ditrz5woWY4gUY4Cm6SROrMREFeHXwRRzAOjXORZLJ?=
 =?us-ascii?Q?H78E6eWydk4gEKEk0B/3tLr9Tdgv5xE79CgDT9EB+4CfqFB60HQGIV4i57ka?=
 =?us-ascii?Q?1ueY7p+AB0QRE6ZHAXsrdw8U/EO8YE1mvWl2BaDKDM4mgIatGgPJ8CzJEdkn?=
 =?us-ascii?Q?PASEGbBH0jBUjLSmkQIUtkjIadrKo4RLpxLAyaeSY+oWObQfo/jmFfmk+NZd?=
 =?us-ascii?Q?MPJI5Pz8FSM8TzBJMNTJ4ChPKnQr5OyhwRJOMNNU0HCaZdEtfaInWD9ECszg?=
 =?us-ascii?Q?Qxa62QOcejVXvtkDWmVf0/gbzAlOuF2uRFMioBYRxBFFKXqll7Rjg/Ld5jmU?=
 =?us-ascii?Q?nex8cDtQTPoMtY3V5PfZ+u6+EGOOBcsgjg2mQCgAFC0o7ZIb3BYwKzegADWr?=
 =?us-ascii?Q?ZGSpZdfZ8p5TyXUkkCa3Ql/U6GHatgLd6UQzAMF4NGi1fPnO9NIpkSLigqaw?=
 =?us-ascii?Q?6qbSo6HMv/K11jmmpJStmn2dJ3CpO+VNITZrjWbsu/x82VwSyiKS/lK+3wzz?=
 =?us-ascii?Q?yCbGeImSHw1ZOLvzo0kyPxTG8JNL2xWgUrr4I3sn3MzyzF4/I2+RUWo6qyKx?=
 =?us-ascii?Q?m3AOY9gEzXIRDDFmvokT9l2b92n0r5QiR1RjVE8P0Hn7N9ORAV5VuYUyj4UC?=
 =?us-ascii?Q?/OQcWjMo4k0E8yz/DsY34lqW5n1lN3TG0eiNlRu6RKvdCAU4T9YLm/eBkrIm?=
 =?us-ascii?Q?H+0xGeAbLyQBet8FG2VJ5BJVWFX5gusUI+DSAhcoJZ+/J5KGOtkOqLGbRidu?=
 =?us-ascii?Q?apJoY5eyqDCwjMuRczhhSGog/ps+n69+YUUpTO+4RJrIl4bMxiWCPV3cHvRr?=
 =?us-ascii?Q?Xc8eOzW451po46sIzGixRxphGOInfSGJkCrKL6dVcEAz4aJGcg8zd82TJBOU?=
 =?us-ascii?Q?DqTETS3VVeTtkTCqDF6giWp7s9lUIXUK8g0RyUn6MdxOhsbV4blqAz1XR7gr?=
 =?us-ascii?Q?7Wj1I+4BvdUSFGkgv+hrKA=3D?=
X-Microsoft-Antispam-Message-Info: t23DIXpwM97stqu0gJzDjWgM3UC1RJoXcY8jCRbQWjgCgA+yU3IVU5NWwXymC0rBo543yE37E2WM9WB4E0K9Bp7uaxLs0hJ7GIUu2gNsjKLII6ebeH0cMstJiFn0Gm67ZfmUt/bKzvu6WjLUsHucpjLCR8it70lQM2l3fKosy9fe5eqJ2wD3j/baMmFwOJ0zi1OK3UC9vo2RMt4TvOZSR1VY7rzqImrw08Vrsbseq5gyAUHHheBdDSf3vX0jLNweY52yvQq8v8Dx8sKN6JIhqdqLau42lRDeW6Wfteqy/Vulboev+nuCIZFoIYYnRKYgWuUrvUQHssLelIipo/XDLf55ZOwIbDh+ojSOWoF8nSU=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:4RdTo5lIkHYwdjtzhpGQnOgtkgSMPJSv9Tje+cUcSrK6JVeBaMJoPqzmeNbZO3FelsjC8ShKzb48bE1H19qEJqjrok5i+AeAgi66lh18pvb6R294Tcy19D5T0nBIeGYSlI0iXhNyfg2Txq62xLQgqv/4eTj0bETtvUg9U2m6N5hKVVLMKXVWjUPXkFiCp4I1yYxj1cc87qytAvvS3d8cy7TGfZH2W56FyoUH02GR8WDey7hqrAUFr6YI9Ii/Sj7yi0YH3AWqBgT2eX2GA/ICf3vVNlfBj4EPeNZ4UDxEpGawOexKxd7KYl5Jt85fljIG2gpYZdEBepmviIvVtGG8ywGMZv1tn2x9p4tGCsFs+jCkxRt3NIUKlD0exxMnmaVKlMdpOWh84YBrNtGQWmptcQWh4hDIlc5aK6+4TazWwQHhRS/DZ4Zy7Okt3HWYCQjw54oQ8YKprnpWRj4kNOsLZQ==;5:o512Ke1UWbEGIseNTFyn2KiYRUptL2Rie5gaB4tSiFYEdV1hAHaboTd75jUj3mSdHK6zkqCGibHN6vIAepP8k8zO+MTOtl37bFObSzFEVr9z71vEUKqm3V9aWMwtZnWnga8+2MedDzLp/e6sD1onGeQ2HwpztbEMFJcAd3XcgJo=;7:Hwxjmcm+M7dhzi7InkCASZgLu7IlrKjbxqSjKXl/QJIfwYTpW/z76rABKtvr9zWTsSXRV9xr8DuW9v8IKNDT+qWq+31246MT38lZYWgiFXrICuQ30I+2Z4bf/AXbeBnPrFivSreP0pVNmJF1CBRvkm1ljQVELlYg1M/72p0iUl394hSFOloMe3Pt09EJSQ995uNwT8a0g/YzSSGotpBMnQisP2TDHWqiJ09uUOQ1SkkV52uROCXpXHSvi/Kgi/v1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20://traIVCHePcrzdiOGg52uaU6VW9OpCwdDtByZDC2kGqIzoTGfvzPeXPYEcPTiaBTw6dFeUrjTu8oqNj2LAWXSapUO9mId0a16okosoWmCw59lcTIcCSQxnOm5wb/Qv/K4D96yfKz9f0N0tM7Nh9PCEgOPR6Y1N9EDXkbWMEl68=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 21:53:07.6180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a11314c-a59b-4ac7-7625-08d5f40b56c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_09:,,
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
index 870113916cac..05583cec3a16 100644
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

