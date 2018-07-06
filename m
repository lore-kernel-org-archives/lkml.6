Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A5C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC47924011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cqCUL4Re";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TzVU34Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC47924011
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbeGFBGC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:06:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753404AbeGFBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:05:59 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6614qTq024164;
        Thu, 5 Jul 2018 18:05:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ax8vpgPtrJJ0sBealIoqo7/hn4XQDzSm4RVR2IJKFDU=;
 b=cqCUL4RedVRXlpyZhNHqqFVypSEu26m5gl+RpGzUpFHMxecoflZ+4A1miqukwPtkLWgl
 vNXO01+IUI3kMCdQJTq1YmDwJ+NwYSp24LPR24e5huXp3+AXL4+HlNuKAJuCn8pvKpaB
 1kQ7UAd+YXUkzCv0BOL26SULf+I+ZNcZ9Bs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k1u9f0d4k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 18:05:44 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 5 Jul 2018 21:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax8vpgPtrJJ0sBealIoqo7/hn4XQDzSm4RVR2IJKFDU=;
 b=TzVU34Ir0b912eTWcojIqmdCW4LIBZsC2v5BWjqRKVNSyKKGp2iJbCF7OMWInBsDaMJoo2lfBIIDaLcNvQh9mbn5tb9gz+b2ixRnM8kcsMDLBiJkVF0obvrvjYadBqaiAtDe6brE5v37Odm4IDg3G9jnshax0JSgZAJ2LzWEFe8=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:4fc0) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Fri, 6 Jul
 2018 01:05:38 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next 2/2] bpftool: document cgroup tree command
Date:   Thu, 5 Jul 2018 18:05:21 -0700
Message-ID: <20180706010521.23097-2-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706010521.23097-1-guro@fb.com>
References: <20180706010521.23097-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:4fc0]
X-ClientProxiedBy: MWHPR2201CA0096.namprd22.prod.outlook.com
 (2603:10b6:301:5e::49) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 423d020c-7c34-45bc-bb02-08d5e2dc96b7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:JRozN0634BmZQkWVP15y17EkgNaYuRohYLv4bvEZr8rYnU9NavnRHxWwL2Se4RlqshpgYEIWvn+eG2PDSkgL3hKGzH43bMq5uJEkqlCM1iBNf11NXZ3E/FjJ0nJ1q5u9STmp3wwCWQDe0iXMptIrhbhMp4n+uwRTVdbKkxuOvyu7rDKCMRNN6WukEuEY/q7dmrqhTbPbTJ8F4typjyz9kjB4AH7NjDsNr5XcLEByE/cHqE7dbZeEc0SxvlzzQIeo;25:8ADBx4uR0+CjV2g/pCPV1knRO1JyKIte62KWK+fTxotXSTGRNX4J1Ot50X5cmghHprRRjG/rYnBE6Y+LrgtPrhlupbpS6FbVoWLK0eA5pIeGp0IXGPtpq4Itxx5bm8I7StWu8SRQ0pa79ClEyR+v17FwV5cVn5QZNIMo7GsPPwXd7ydyZBf5vdDusGk7F/I5nnYiSNHlcYDaOOPt88wcamceRAIpXzNwZhrmD6sfZAnuWLYfd1u/XCjGdHuxYXu62EyG+Dd7iD2tnhQEfo5LN9mNe4CEy3HSTQgrCxa9+a6bYKgLnVr+PP2/RxlX4aA8wZaH2/dunr7aa9JXTwhKEQ==;31:KObyDo7iCu942gnMyGeBeICD6ZK68bcSwxcrWXokWDY0bIs6H5haHlcjpEn/2sMGUnZ0BfLJnwruO2gYqYuaPh522J7qTsTLoq4s/9NLQGKs5+y5jpyVCnMYJlloBAFq50ysSczDxJQft8APPabR91oP4AAkNZQWrRafJ24nf66TiPs4Tkgc7klCqeUNzBWjNYNESHteTcONrljJSF4eVOF4HawioN2p5EYRo+PL4kY=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:iH7CRuJcP6mqrYHBbTFmIy8qmdsU+RgPjSNWeEZKVChqPT5MR1FzlPqqPxf65V4/6vSk/YIa7Sv42yvOR8HfWFHAyymyDThta4RgBE3Aq0gxo8jgUpLxEMfG88Rw4pRT6xRr1Wxhc83tH4lyFSO8vVAK1rYmIepQxvWxt+lfhJGSvoq9NMW7+xgXpcov8RmtKLA9Bkz0/PJ4CLpUmrc8cHZCVTqKEGpkZUxCh4+ILP3W592WCxnMihyswmKawlZH01XWZoAtJnikDzwydFTJiwKW+RyyXPtBjXKSKrqBYcoPXxLulcBfchY6evKsEInKt3T5mM5vaEe/Yb2e1tKzIpA7SRkbSJ5D/rBbfV6OOhWKQGzNvnko2M0HHO2c/I1sOuMYFbKS2f6EoV6+Vx5sSRJ8GnHa8JVNMRW525NKNyQ2wgvNz45GhbfboIwZb07c9X2ghPTk0Jt9kG/sGr9mnYQjCzE0e2aGB/+WNUy1piq8KqaIoLhVaJN5qkJHG3mN;4:kM5XVdt+ODoPCgux4MbbLXz5GYip2rQYRN5aYISqZvq+eV7+ckAdEMvBDwZAvhHnaOleYwkmP6jWfz7dC6v4FDmMRaltqYO8CzhbQcHBoqxnz+eOFlp3ie6uJPmB6wGgrFJhCOlJciH0dc/tHBNcS9CJoDYtcM0QvHBTGaW+8wqLUB+szkC+V6xNdtGXcsc1tS0gDQBQHJIfgn/F2aCXIzPzs36Dc1pf76H9yMbw6ndrKzCdBr7g4nwtCkwMuomQ7Ptx3aHUOgvz38Ns9moQ9qXQYRZNNkbgH60MF2u6BvOv23TCshbdz3D7WRGxHYRy
X-Microsoft-Antispam-PRVS: <BY2PR15MB0167FF5BF60FB1FA88BEC08CBE470@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(2906002)(106356001)(186003)(6486002)(36756003)(575784001)(76176011)(86362001)(53416004)(386003)(52116002)(50466002)(52396003)(51416003)(48376002)(50226002)(2616005)(11346002)(446003)(16526019)(476003)(7736002)(6506007)(105586002)(25786009)(305945005)(2351001)(4326008)(486006)(53936002)(478600001)(54906003)(81156014)(8676002)(39060400002)(6116002)(16586007)(316002)(46003)(6512007)(1076002)(5024004)(69596002)(8936002)(2361001)(47776003)(5660300001)(81166006)(68736007)(6916009)(6666003)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:Lj13cs8VQRyweiH6lnUBrG5ICcynl1qtFZBRWmjDp?=
 =?us-ascii?Q?75Xi/7i0d96+Vs42fBb6qxNQLE0Bnjb/N1WhM0lIJERDqhykRpGrk1nmkqmV?=
 =?us-ascii?Q?nQyhUO4eE689NBaaT7RH4EgdCgKiB4mv/wzS7Fze6vLM5xtXUoXOMIKCODJd?=
 =?us-ascii?Q?dVGkufomF06Q7QqEj0dm5AqQVdgpUVNbzxz1pguFPTDsZcc85L5uA/PF/4Wz?=
 =?us-ascii?Q?rwm6gEp3+rhIyl1vylYRSbs14A0IrXAiTkWfBLBLl9Atew2bVpTulGx+ScB1?=
 =?us-ascii?Q?dlEJmhQfeWbedJY/4HZ1XJHZAQ2TZTmC9j29naTTdv/ybNL4ZLlKC/284CIJ?=
 =?us-ascii?Q?5LJbXVh7bQe+oWHMWoF3AeWjooGu/86KTunslS9WcNaXmFgOoTMQfZL0h9eE?=
 =?us-ascii?Q?xEBxekZcEOSkog48xMMM2Kt+4f87YoAJhrCzcUwc/AvrPrQ/Oed/GcITFyhM?=
 =?us-ascii?Q?aaDjdP+x4Za1uzBPFmhC+azD1EnDc/mV+eUp3JjKNOGccWJJbAhNIP3DVbR6?=
 =?us-ascii?Q?P+QY8SAb1DB+U8K8WWb4jM/oNWQMc8n+yMJA/X2dJ0Vkaz6F/DAA52KMnbk8?=
 =?us-ascii?Q?VvcVxeUtH67GjXEDuw1br0v4dDweH0gGZnGHANEpYeCILyHVfXQnw7SpJiUV?=
 =?us-ascii?Q?TzlWtilV6/0hCexWVbsJgqFW0KfJqNVk7TqXYy+hrb9S5NPoUzr+lUbNOooP?=
 =?us-ascii?Q?kEIiwTCOExJaWXtKBWptV2dckCciDTvOKZ/a/UEiT3rjiDnq479tScESrNRE?=
 =?us-ascii?Q?xMXgYj86uqjziMEkpa6dmxftzI6BblBbUjTrpec4lFEpNYYIC7SU9/TRXgSG?=
 =?us-ascii?Q?cJVimE/a+MAUJlVxKsSZ/IpcoJn68flIF8wlQAUKjxOM2VfAWQ+tWGGJMsph?=
 =?us-ascii?Q?DMlRIasq9+5BQEzSKYV6SHdt6gFC2YjCKHdY/5K13rJ4R3ZitqYF5GAXuLjo?=
 =?us-ascii?Q?yvNHcDDlmz8m/qvJjtrBuf3zbt0MazyIKGet1F6eqOc6esgJ8lM0yB0E4ObG?=
 =?us-ascii?Q?ArPGeqPVOb8+hsxckbWUGTEs0THyrsGN3mxC6C39s1ptiokWFRDvutvPN5Vv?=
 =?us-ascii?Q?IPQtR6KmEI8HWcilveCnGbsEuTH+c/j8Kc7AvCAWOtAoxD1QX8mB0+SR7GO6?=
 =?us-ascii?Q?fKqtaUYm3pdFUOKYR10CUrkFFM5phsPX5i0dsokVYP6AUR9uVAXRbH+gO+3E?=
 =?us-ascii?Q?yWQLgP0Vv3hF9gNFmjMKEM21W9ZJg6xImzAy8WlokEsJYGO35F208varMWcQ?=
 =?us-ascii?Q?15x3mDEjV4p3YnOlhYjXGIl2uvzrHDfnyrSP8Aekq75ZpWKI46xCR4WGmKPI?=
 =?us-ascii?Q?MFzpkH3p+W8gu3I7+vRqjsBscwZMy/qU4iUuO5PAVH/?=
X-Microsoft-Antispam-Message-Info: Ii+SsCpfmCC+x26KQeLOy70CUMMZROsyY9q+2F4vGyf1q0lz6ndJ64UH7sedNlwpKKlQykliRC+KBqm8vFw/UmKnaNYEdUp9/17mTQiy1tcM6EQ5ZoUKT7X9uJDOmZFnusKaFaTMycHQujFReLejCxBYYg9SwGG46TmNmaxBnlGVb7nhh4x7dsaekhtZovrxX2wkpEsn/RzkDimJKj9pktdKHm5MTGCqCfvv5GkeyWC4ejVuEzneUUfUF1LefSTupLUfIPJPYgVxdq9xamsYlqCWrPfo0Oe17xXBt0LisH8xFnadhoMbZYdsRdMI6XWadhsabP0bn+8XwiEiSpwyAvQ0TJmLfPcIxORIJbhMhAQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:c8dIfg0OmknIm3UoRYaWI1QtMKQnqAIdZlPYaFmakuSHhWHBne8eeZvo9wa+SaTr4nIRPmihUJSn+oxc6RV0To/xmu0cevin2gBR7rImpZcOdcrwOo8Hc4xZLYceVfS4CZ9wCMjDLHorjVS9gSzwbaS0QruKGY3kki4800zTv/6Wgk5OVUQdIDOE6pqv11g+5+TCksAGwq4D3bYMB9T00mZpsZT657syW36ZMlMoLe0e9lYYwtZy8LaKfwBnnE1OuTR3/zvEUS2wLed0IjnVOq0OGXByE/gvmUOm3pSbrNZmssY4g9gobk8rUNVni1YfYb7USFx5ImCGmRvkWj3acY0d8G5brPSRSsh/J7GiJhLndExptjXSH8DlUObf5Rm5kb7l4mKHWMZKCy0BZMYMVCBiOtbJA2O25MFWoc1l+Apes76Xn6+DlA47L9p1LezvxtWO3CZFfaRD7h5uemZu+Q==;5:IWjI7TFlvvjqe68F8AuPTQKmVTLl0GlzTfVemCs0LSwT38TRWGYi1X2MiLpVoVm8G464DN5DQa1hmlZ7EvHnQclDPSkkk9b0r5antWwP15map6XS8jSs1LtulVghdg3Fmv8LffhVEUodP1MKYPqGFlHbbEVPU1bU8GoPCvxgf8I=;24:KJezOWIMHPjCHfnZt/IqDVoVcpMIL4N4E3Z6wb4P/8TMv0uwSj+omosdfvuw0Zanp0i9uUW1DS68zNbRDyrfuMoNjFdIjVdDbrua3y/qGMM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;7:A0vNLyV1CypOjAcKk7UzL2TASf6VJHJrlymtoStkGHpK2MH1lJWuXl6TGyC3XTjqayUSnnK7Q7AFSi11OpBAz2RE4WEIx9gan/ScTC0QcfQ94igYwBAJiZ2SvJ0SrQc6ZSgp8EoGqgfD4COQrY/1E4bGUN5TYQtHHHc7nKI02fcNdnI5VGZcWHkCMDpN65firZr4R2W2UH+YobyT5duiHeJXTi6thB86CdnhMe1ccG71uFp3Go2sOOytLTlw/WYD;20:UycDXIurGuNEWepIExAKPFeU7FWxfeFcjvhq4yk4AyzO4IdDVs+1BBa/OQ+6gYqCeqf5P94uF0uJT9lF788mmiz+wmIiD5SpoH35daZrJhF/cFFq5eQbEO2/zrDDbT+jsip2sBvUmiu0JrdWNJ45lSpmhRf4WygHIE2Xd6m/ivQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 01:05:38.3231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 423d020c-7c34-45bc-bb02-08d5e2dc96b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe cgroup tree command in the corresponding bpftool man page.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
index 7b0e6d453e92..3b3d6c534317 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
@@ -21,6 +21,7 @@ MAP COMMANDS
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

