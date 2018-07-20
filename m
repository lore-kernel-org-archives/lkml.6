Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEBDECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2611920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p9PK5PpI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RyFz+upl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2611920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbeGTSgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:36:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38288 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388412AbeGTSgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:36:08 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6KHhh0u025812;
        Fri, 20 Jul 2018 10:46:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=yfQNPwrixdaFLklu1XukLvaBulPKXRb5WdJIli+pp/s=;
 b=p9PK5PpIqCaM4eprIx+ujEDiiQIGDrjcCZnB3P6LoO0cWDQLnKSR36//pMTLV+Pa84RR
 uYlHUQaz8v6sM6q48AYgKihlnRQvwSTPI2SOOvvy4fsiIL2zUm/vVeJFEM1JiCBeZFwX
 46GKhSQNtszXIaXF2qJB972KPQHK7kTDaNc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kbmbv80dv-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 20 Jul 2018 10:46:27 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 20 Jul 2018 13:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfQNPwrixdaFLklu1XukLvaBulPKXRb5WdJIli+pp/s=;
 b=RyFz+uplWOKY4wAtK6lDKGRgl9QRNGUx77Roueldl/ODdsMZ8idjg/iEQxMCZMNqT7GBC1lN8yy+CFn/Ka1YRV8LfAF7v02N4imi3NC0rMyu1UHslf2t6nxfH3btWcMZB/842PwckJp5eNUBkD0lBsNkdtHN1XI3CX1seTDCTOw=
Received: from castle.thefacebook.com (2620:10d:c090:200::6:ca05) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 17:46:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 bpf-next 09/14] bpf: sync bpf.h to tools/
Date:   Fri, 20 Jul 2018 10:45:53 -0700
Message-ID: <20180720174558.5829-10-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720174558.5829-1-guro@fb.com>
References: <20180720174558.5829-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::6:ca05]
X-ClientProxiedBy: MWHPR17CA0096.namprd17.prod.outlook.com
 (2603:10b6:300:c2::34) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a17a84b-bfae-4a9f-3924-08d5ee68b61e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:9EHpSsqM1QkcDFd62ntqxepIP+Sff7UJWVk8ndnjT5IkVbx5Gb4gu8ZPxJOH/pkcZcEMau754Ze5j0gS3avHYenVX06ZzTkrKuQK4dPLQh1wmjcvMMCHUoaTTDziC5HiBgn7UtV5HPvIXTC3V/9fcyfw7dONeh0IqWRdv7ns4YGi7SR9qfKNG2GQGv2B8PrScFZgei404dwrITvg58SWELJZcdqYrRzcaXkQe4RFM2XYN/J3s1Ac7/R5rdbzis8H;25:fwO4838E1PnnQu6CyKDAZz3v5XfS7Y4VFdxQVIFpCNzjrGEd37HFKgAdmTxq1S2JHje/kSvFG/RY4E5/ziIBlJQPKyPoTh8WS0Kpq0Ey7WiKfTSw1AReCEZag40lFyI/Y+acCnQhW8dRy9i2or7AAGCEKC2V6GS8wWWbHuUHlQNbWmtQC12vNth/TB7kBadg+efBATdaGzy4Y4ifTmvUZM7QftqPnpITdXLDVSUmo7eTwuCJlXQljRve4gviLz2jbGEHMY8OC7tz//hFlMhrEej7wvHRNp6hO3dLwsqiN0UPBpu3c7lDNp1cOkJQ7hTdGFZi4oAIe2fO0aiwl1bg+g==;31:mKOfgljmOrog3sIKWqx380A1vUYcZddQjBXD5IWOx5BX21kV38c6HYY6VP1FLQ9YO0a/XnyXSLCtvqpRzg2/RVFSlYTbcJasJdoA7y9lKooT93NXeCaxm05/FRSWWkZ60ruq79FpPZ0IfFQ60qN3nX8HECFXMws4kcIz6Hx4iupjpIpxf3AkRlFfT0viPPo6ZG5DxqdCs1UkIr7IUSoRlaBc/PdqYts0148SLfC9UQM=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:zWpHv5Y1yFalWjAlLozyII8jafe4OhgaFfe467uosh8azfKU3figCepwpkVWrX+NVFII7+Q+stc0A/sEy2N6A461CRLWiancUreY4htj3yaqyl1vLdagiYy/96JNujUYtUVNIiJnNo6l/AuaB5y419hC0bkaPMVI6etbrgOqJtijpHoq2Ud7Ts64SiTRCna2WHFeUWiBsG3W0AxUpCR+B69YS05K+CEbRvcAZ8D5VcH4gOU5Js1RWHd0i1wPAJp4BlcPv1zsUdrF5nMsl4MdOG48x0n3RW48Dx+qUW7xmy+In/1GP6PhYm6ENIL2D5xjNkBXB1Im49kIwesoPoYSz+uHhhuwLHMy9g4GUcpD7HkdlIPf6IfD2fhOYRg/ygk0qqszVV88dL92nKPFPycD+HrwZWkU4i/DXLGFq+ub4ei8hPcl8WkemxA+fgFUhQPWqiPyywBKpNV9u8hSSyKcRfj+hmA6PZ0zZ0TicKwzeCQ9Bxga28nkd0Oq7bUiCbo/;4:EWRDJ0OugtJfuggvuhcoLMfksSRoDV02csVKgjONUGawO1E/xVkOC9DzCbNxD+jJy9aV9kj840m/EmgoBSNjX6pTf4fWYYIymQWMqkZ/fNqgzXjuYXPcKpwYCz67F0M7oDiiW90WcOGq+A8LlSgL8vibFWs4UkBpRNHHzUDiXKprizXLyypvWqRWeBarRBwuEghZaKBJEoAvJyzf/iaSHJivdRz/dDow6xNoIh+Fd+5bbhyJWVyRQStOJTP2/Bf1DZe8cTmVInSyoTH5Ln2pBdBME0a8+xUCBPLQR/ZLKhseAOrBiCnDEd7yv/clU/kn
X-Microsoft-Antispam-PRVS: <SN1PR15MB0175EB03C6B9030C095E1224BE510@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(6666003)(50466002)(81166006)(53416004)(8676002)(48376002)(2351001)(68736007)(81156014)(106356001)(8936002)(25786009)(105586002)(1076002)(5660300001)(6512007)(6486002)(36756003)(478600001)(86362001)(69596002)(7736002)(6116002)(305945005)(97736004)(2361001)(16586007)(316002)(52116002)(51416003)(52396003)(446003)(50226002)(46003)(54906003)(14444005)(47776003)(2616005)(5024004)(476003)(486006)(6916009)(11346002)(386003)(76176011)(16526019)(53936002)(6506007)(186003)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:2ayUlEk0yNCBxSXkr8VzG86957Wt5q3W0PRqWpyIO?=
 =?us-ascii?Q?5nNVOO97ejBum+Kn73ssW7QVFn3uEkqHE5ws71WS2gKO9W2BcgFuGiJo9lGU?=
 =?us-ascii?Q?pVY8kojhwC520VuvdEm6noKWGAmFTLa5KloOxEmbHo7zVi7qPjvaoI5ObcT8?=
 =?us-ascii?Q?jttFYaimpZH4iZ4wH+MKcwo22g71XK6TH2ai3uW2sfKovNOSU9rbMtPYmujo?=
 =?us-ascii?Q?CB+rKdiT32OhYZ5sbef1wM5r7eLngjCiwwb8fj7q52dhiBk9oIb+O8HVyK6Q?=
 =?us-ascii?Q?c1O+3vazmg89qLEI/L5YxGtgHVZOzCFQ8mjwWY+UEHGKDlbN5bU5i52ikf72?=
 =?us-ascii?Q?sLS/tPrgqjxUO+/sDiDCgJ8FYhGR9lzqjNAp46van6r+EPmBEH+zVtUOraa+?=
 =?us-ascii?Q?LH4XYVKnjOKik7wdljKQunS+AXkK8EoCK//tVodXZXAhoB+041r5BNF2cQ3z?=
 =?us-ascii?Q?XLEkEj+afXbdSC7vbwLFQB9pDuGzit+MYeAe07m0mbzoezvLxq+e6AxT4imR?=
 =?us-ascii?Q?XnCx3a/qjGqhxm1aUhMKBv3Kt+AAsU3PHwW22CCfPat0Cqv//nP/Dwg86dTY?=
 =?us-ascii?Q?nrDqRDlmtM9cEpTMq7EikagiRRFkUiWFludMoCtABULcvetGHnF0+G+fU5vk?=
 =?us-ascii?Q?Fzg5YHt7OUDoDBeFwUGdqmkKjhM321dr7WQh2H2hHooqmfVYuS5ZFaqR5vuG?=
 =?us-ascii?Q?/tvMaLeZxeDlT6F7T3umUbiBk+cUzvueHekHxrAB/GYvmir+FOTgMK//gbt4?=
 =?us-ascii?Q?Sk2LRSCLpFD3QCGYwBYafTc+klA6DytwQQEMa6cH8vP8qrLSSv9FzvB2y50w?=
 =?us-ascii?Q?5kqLeOrazjJm7hgINYIWnFT5PYOOzWcQbMI5MSoFYhW5d/BGDn5I6XixFtJ1?=
 =?us-ascii?Q?VLM3WkoOzMknc/Nuy+nTkwcCrcEzcZ5DaDNO8LrWlKbWcj5hi0Jon3X8Ix5b?=
 =?us-ascii?Q?qnYn6+jDGIB4d4RC1Lv/cAwOjCUYS53/ra+voYC2gs5CiZcDyxAfSxm58YGa?=
 =?us-ascii?Q?4mFJpMdz149fBgIy5E1GrliEuDMbFjLqL7cKVNg4cKAub4kZDNTM/yns/M/i?=
 =?us-ascii?Q?Mjh+JALDUYXOCaHC03dCMiTZhoavAnk7WxmI7/43xTsC5xTGUsAJcFeMGJHT?=
 =?us-ascii?Q?Lc5qh+OxJOhfLCv+4v1AA7j0mwH74SiSrnx25aWkHiV2WKdKi1esdkZfGkWG?=
 =?us-ascii?Q?NGnu4sCg1IkR1ep2pdFjd7YBhT311WbBUUKuej94fAGSJnfMFDIvrZ8v8WjF?=
 =?us-ascii?Q?CGEM2w1u+YaFUu12JAS/5MESVj1km/n4kdYwdxXMUcDWP5bw5FzMQpV2+/NW?=
 =?us-ascii?Q?6B8wvHXDdirFf6I2jCy3zw=3D?=
X-Microsoft-Antispam-Message-Info: j+yttIzQFSJ7sTAkEDcnwllbqXaZX2vxiqqvV0TLLAGpPmZUEhRs+/KQjn4Zj+UD1dPzJ3x5Yagh+eUxRkcajp1sf2S1dOc5HNbLX6g7VVwKqItNlj3UvMfWlx/jdpVkTfcNbF6Hz3FwKjH5nKtKq43gp7tFX8HXzNMv/YOk6R8cNVE+q9ecsniqDofVNZVt+i31f48iNSceeRbYIbEARswlRZhanFDN4X6AnrGFWENlx9fYGGtnS5OGCFSPm9HRwvk4rcTjBXRo9F/3FvjhY/r7SWBzHSmBLCsALf4BGAYG5TWzDksHzygrG5Cl/dh6BOfRhNX0oP0ELb1sE3iXRDk2c8qBWBYoWLexXmnc0iA=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:jWneY5jdaA0gkOMm0sfxBtOatGd/WcdIusZC6v7FcRNk8ZYlXBnFsGU9aCMUol0Xx60sXPqJeKmuOThVGwSAPBX6CfeQ2ETQdv5/8apMWjqUD+ltZvqPHNKv0sGa8lAyB7qYdOK0/jhlySeP/Mwqzsl/XR7hOEBG8z8J/UrhWj+E13idZAny0hX33vBT2hNOdN6DepZwZmToEQG87761gfSpb/EQdbeiO8xCZPIuLznkXIwNQaZMhODP3FyBlSYYLl/ZKULUcFMJXX5MZ1D6Z3vM+bNpJogoP+wSn+I8hKTG5IyG7fJ2reUIdkVjMMm9pg7qIIv0kE4Dw8ZVyWZTOj2WF0jo3pnYXZfYBDFNa89fV0RhrfPfnf9ee8hiyVl0pdGbmtsHhp6ZYZumMGV0KXd3OixHwj2BVNMlpje8OQ05PeY0NKUMzZcsdNkDH263msBOBZWtTdEq9JOUkRyM5A==;5:cpA17oG4qYBD49ToQFln8N/GQKgL3Ix2NbD3vEGYP7xCrnHM4QyPuwwxjcrpcizCII9yD7gNzg9tuZCk7vpMSHUN43th3VLSriKUkp4f6qVKxW9F02eLyfd0XMKZ94wLA49gJXCxhl9X6tl+QUXr9Ko5SGOyB4yB022zAEiwU2o=;7:aldfsbDYAm7LrQpL4mpicT6d6moyNMCWZlCEY+18OfT/9ca++HQLo2MP1JnVGuAy+PJe5eY0qLARiuTI55JsNZhndWeYTUvA79Zx17jPVu3J/I2PEGWDV774wmKpkfb4RtnFWlZnIT0mpE5Y4bFCCFNpFpVT3QhvP/+MqC6K+rjInUfMWYMdMs2j/714d8uySB8+9fHN1X3+8VVgL2z/wOhYw5iBuGteTwHCShOrsbDeu8588lNjrc1OkoMY7Rpe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:o+cGurbdFPcx/NSyHCSe73AxdqdIA4u/nnRQcFjtX2LOzOZVwczAd+LXguWFk2MHh3wm6tUDLUz4XeDJa8HFLgpQIwQqeYIsK7Ilx2UuZjfvwnjSQVRxyWIvf7JSj1bhPkYVQglb5HtFn1Od2iA9/oLIja/9rOzNJNNIE1YGr10=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 17:46:23.2408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a17a84b-bfae-4a9f-3924-08d5ee68b61e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-20_05:,,
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

