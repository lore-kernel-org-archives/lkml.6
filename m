Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CA5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C653208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P85GP3su";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PT8Rbxis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C653208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbeHBXVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:21:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727262AbeHBXVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:21:32 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w72LS1n4030187;
        Thu, 2 Aug 2018 14:28:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=CEOKcUFZGpGhEHi3JMHvbEOG9CE3U4TfGlKXBGbmyJI=;
 b=P85GP3suLpQymKdxuJTFBHRdU8FzPYcwAcjpwgXV8+Wvti2Z8Q30UbFFQwCxd1ELLYel
 JKO+7b2N7wbOQAAaoOX2IMMTRzV8qsJLVapHuYdEWRUAzhVGL3YkkUMdZ7/TYh2o2z0i
 RgqbIVf0oo4X+BahtHSpEpFiRj5xeun7zSA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2km6kmrnd9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 Aug 2018 14:28:14 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 2 Aug 2018 17:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEOKcUFZGpGhEHi3JMHvbEOG9CE3U4TfGlKXBGbmyJI=;
 b=PT8RbxiscZRFiphxPOlQtEbH5nHwigD1lZm9jqv1uf/PyNcCJDm8ZHmfpKnCKJKyjz3Mz8zjZe18L9tnOuhTGBIU67xM4SYcfMonxWbMSX60L9ph3liKyLxetaTgc9ltkfbL4RcXfxlKPnOTopjCfztY46TUG0riuwKrVAVZmWw=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:6653) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 21:28:02 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v7 bpf-next 09/14] bpf: sync bpf.h to tools/
Date:   Thu, 2 Aug 2018 14:27:25 -0700
Message-ID: <20180802212730.18579-10-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180802212730.18579-1-guro@fb.com>
References: <20180802212730.18579-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:6653]
X-ClientProxiedBy: MWHPR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:300:94::20) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7aa949d-1038-4ae2-bda1-08d5f8bed487
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:R0jd+9/VZaCwCjbLNHYFnL7+xwNC/YG9i9Vf7dDP1sM4qdwHkQGN95flFvs9NroOhKk2F2rtKab5xrb+g1fdKhbCOaHLq9sEByOHA0ND0EKyvUeTXOMUPkAbBIFpMmfLpthsrTV54M1ai1f7mZ2HAWqPjpNRkw3N0sjJ5iTZFtRCfSFJO52DGVoRrqlgvlD+FV4RULYv30FMwm+RqpyCuFGNjDgh4HbVf2ZSRCBoJufdriRfb/RjyCNy9DpRKrhh;25:chqNJ1FahZpFzab+4M3UhK4tXrXCxdsnOh3BbK0XVYbBWEIgjlR0qnHv1YAeyuIIPtL2E3dL980ODVv0enpISfRCvareNUY+XNOQ8wyn/eE9edtGU3oJLJH94KQqMfLFZzCB/SEpWUyUMIMqpqjgYj0vteEk32bzWy8Xi2gwEYYLYoqz5XfdaP3wK1hwsGRyNEtGTPbNsZJ5DSJIt6oClCROSL5f+g4yH+ti1cPMeMDjHVgSWZbLN/6IhUHdtGd+3dKgmuELN3UiTDSROKzp5kEnHiv7aqU1se1GXdk/Oinstcy5tiajur68Psal7brm1NNIhnbHkhZ5jlrtuMQCfA==;31:8QvPi2fVK/5WW7RL1s9WY/1L42DkKlD7x1ABmaviDzsWpsnQBnB0BSQRve1MgMRgvZnF9c1I6W7Ipj7Uo0jPztHp2A1JquX4hN8fFAQ+1dCNrP0zIFrav7NQ8brXTsRwXuamd9u9eoTou0hqXsZGzP64Q25YG1Lur/dBOn97Yq/CiqExTrK53Ru+HsqwvoAmL+OzfvL/e2BgMAiUOpCJUexeHU9D9dl3BQ0TYM+n1C4=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:iQ12iKRUvGVCEr9Vl+j7aU+O/Q6fzdjawkVXosqgfZVa4AFn+Zv1/6D87EC9HLlsGwJwSb7aGp89U3Jrd94ZC0YptYywEKnK+1gWik2AauBn4rBRQGdCTH0/l3qK5CPuPRq2zhx7auAoqs5gCmMyVHOJAz9K05oLugroRxIux+oVLnW3L/1LLkjJ0QQhYITTbl4XmVHfTi2CTzfSpL/pPUaiiQ+Iid+bSEg9iTtJiWyz6YHCNr8UVBtEVSjm8odMHbn/RdajjCeH/B9/ecV9IV2+qVYwphY6Pla66+1ynrpiWZwSPGhwtzRUwv02eLRrObyGHGV5elmuydqBtq1ZbmpjUi14RCS13IUSWyGT4dNEHuEV1VJgVERVaTdN7REibcXMM2HpZrtZEr1VqDvvzsks3rA2je5upiCK0sTrZxDmInCYcx5Q+Stj7nSFx27uPNg7EZdAV+9APdJCyrFrp8arozG7b1TEWNYiCDdlUhHLSLQWglRq5EqaRcidQ03l;4:ZfUVoGJEbbjr5uAr/Y5alg37KXf7CWTsz/bIurzQ8fncN0swz+UrjNvb1L998j6DNiOF8y9gq/s3l63U3HNzKHIMW6It6zjgt2NaNyIr3LHQ16RByaqrHo8lKOsBZyuFxPxN2iIro26AxbExUUdCI+MkANaFEza6MnskCLJNrSkS9pa2DfoWsjLjue37xkoWRjfKXZBD2jupyJm5bwQXUnnTtrZumBzPQDsCfQBJBkau2Q2R1fJRDF/hSgCmZLaIdSZU9Lgs3F4lmtoXO1FbQJB3YwidNPGGlAR37vWXeoUPO4yPNaMPEhwz1cZEimFo
X-Microsoft-Antispam-PRVS: <BY2PR15MB01671A9266FB59C57CF4ED1FBE2C0@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(446003)(48376002)(2906002)(97736004)(86362001)(1076002)(305945005)(8676002)(186003)(8936002)(11346002)(6916009)(6666003)(7736002)(486006)(6116002)(2351001)(476003)(14444005)(106356001)(5024004)(81156014)(2616005)(2361001)(105586002)(16526019)(478600001)(81166006)(69596002)(47776003)(46003)(53416004)(36756003)(316002)(53936002)(51416003)(4326008)(52116002)(50226002)(16586007)(68736007)(54906003)(50466002)(52396003)(386003)(6506007)(5660300001)(76176011)(6486002)(25786009)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:+s5XojPv2f+uB2SD7ylGSqzHBVwgqfOMpyVvAjXZ0?=
 =?us-ascii?Q?zYVI1whyRHYsLY4E8rFpjGfFJDYurECoC+M6D3jGHkvifu4AW/lKU0kg5GeV?=
 =?us-ascii?Q?WW7aVrI56ud/NQ30ExGNkC47osADPnBdMJ9gXcshmHcsMzaSX6VTSdOk2WHX?=
 =?us-ascii?Q?hGKx1dKhCyAdgdRBhUt+SjpCAG/2hiiPZD2KxRw7Hm8JNwk5CNMOg4c51j2w?=
 =?us-ascii?Q?LAHR48E4fyDMO7rFDotiWI9SzCSqSllOPfC+PziFP7gUWwRiqDcRTEvCNFAb?=
 =?us-ascii?Q?GlfHGTNyC80d4g0WxDMWSMjroRzPva7yxVZK7QQ07AmtdoAI4b/5iTa07pLf?=
 =?us-ascii?Q?Vsv+0Ggvd8+XG7t+Nf4HA0Gy4cTUVk8Ajm1ahhz3D81qGoZEDHvbiKSbbl7K?=
 =?us-ascii?Q?2YnU30CaG5at+FDz7h2mgztfK8pGXizY4C4YsmCLKxfbfHKVmvMxH6DCLIeW?=
 =?us-ascii?Q?2LZf5pQKDzPktTxpkgMM912n1uIjtMYd9go/mpRlljw8nn/apUiU6mSQH5Ho?=
 =?us-ascii?Q?zRxj3Rn8LU4pZ5iKNHBKVJh522qVQcscLCCc7i3UBuEGYkxbUw2gLofiF2RX?=
 =?us-ascii?Q?N2t4fpeSCEJCbbS5OJtkckJHcbKeHdzeC5Vjn72jLvAIMN+rtYNC+U86JtV2?=
 =?us-ascii?Q?Sm9ntKym/Z/AuUGGfsd8SSi2Wx4msZXuP1gWKY4PdYB4GpmKOh63ntH212n4?=
 =?us-ascii?Q?VouO8yTS1Y1AWlUHjjVEES7EJLHc8x7HKsHAk5lMhYtqxeCZvBNMERn4bcgL?=
 =?us-ascii?Q?Z6hwmuxjOoaruEKAoeLw/ab0IFpgIhDHHOLfl6cuvqfgGfBM71sSWDJhHV3E?=
 =?us-ascii?Q?kvodf2sG/WZbsY7smABL/TPEGbS/jSYQgTJ9jnBXe/WIRBU6ywDg3oot8kx3?=
 =?us-ascii?Q?092MYweDb9JTWkFx1FPb6J54AgOEElA7dWuXtZ6iU1LuLJfqN9MFrISAQi34?=
 =?us-ascii?Q?raYhOvJcUfuEaKcTBh502RaosA9ltF3RvDys7mK5RTrrEOSxL/POrOnz+8w+?=
 =?us-ascii?Q?07MvBULujFnWaQSEEx+6L+Gh1zxlawfsq7o/qOZ+SVYFbl5xp4CZg5xiDazM?=
 =?us-ascii?Q?vf1CuAFVhAGWxeB80qasGcGKLrUI8Sntgc6oc8S+1c8TxjBtuQxpDyfdK1RI?=
 =?us-ascii?Q?ayGnsuconjpO0lXckDd2DoCYxwYaGOfJZC+LLRr4Eu6dFVtIuIYhCb3VCJUc?=
 =?us-ascii?Q?UMbpd7FFr+zGLo2jq8f3gynXc0/ONOSKkZ6sydEx0PAsJTdjUj+F2xSj3fX+?=
 =?us-ascii?Q?TC9C6ZYDu4VtFc3gmSSks5PICndIbVPfqXzXVDn2uXDQQwk5RRdkty/GfMAP?=
 =?us-ascii?Q?a6FbtonTbncfhS0Lz9sJek=3D?=
X-Microsoft-Antispam-Message-Info: a1rbNaEWA9IJlPxhHbvKmNOBiMC5umldq2IkeV1ap1DShL8rtNHmvwvPwQ8d0I3FCz0jTjw1XFBbK7FvQpGgBfYZWYfLxPmHFACl3OCA9HfAy58prYxRfIicYpE71pAuzn3/KH/oQBDBc8rch9AE9XoPM53cW7cvStPbvcHi9zADpbcTs7snoperagiil7UQ7dinRgIGsbpcYNC+7g16WoYrCRU+XzPEmzEyE4OmpTaZduuxSKG2qQnbQR2D1DCp0sjSWZ5ceRg34FQ6tmhAW0+4NANP6rGXS2sm7EQPLNnjM3UV/WfySvLgyWiyR5tiXCUsKLWZexCuGEgF75ZlMXB2LenwM8hqpjmpV+OEwEE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:jqfHdJf/u5PgX9bc7v2Qs4XtO77jb9aVPhnU7dzfNcGrcTs0O7AXrmRiCe/U/NYgH0M36VZPpANLBT8d9aGhuHJB3h62Dx5CRksXij0/QK69SXNRp1MCYYs6CI0y5WPMvcC0XXyPU7TZ5RJz/Mn2yhLbdmIY4c6uaV1J5afUmxCXdEETiUl+iXCRqZwbeKi4/N7ksrM7R+m1sn2a+8pklXYbpwOrADnT18o3DD/1/El6K0DaU6PIiDhyRToXsL3s5KHADWqliBBJuFmCmZNTXT1ZrvIz5ioDAscrqCtiva42XWd5kgg/idQhaCCNCEmrBQTv0OVepTjBTFtWySE6FdEUJOUQPBEjdEa6AR5J5Yl8KcY3MY7nYmMNMbilpYYIowC+GKi9G32sS9KJHDV6F6pzzz/A5izL9uiqB1xU4Ygkn09k7+IG+9qVIMFHy1g4cD+Db2pcIYcVKTttZfd1ow==;5:d5NPrkxSAGV6cR54VZHWK0/XlV9jNJ3wss7FQIr/POJXP+j3VjiskuwnXLFaYmHBe1yjJTFauvu1tt/XGzZC/pMuT8MRY+JAF33fRiO+3aYO/4mt/9DuPBWR0pr2Y6Onm3zWGdc1xeiJi6kYpVA58XwLfM+8qLFcXIS12rIiR3A=;7:lkKu0osbiirYLiWSPMor2u8fpLIW30Ta5mP8FO2Q2U5UfZumKtK65MtPhwEJnpVuour30QhY4ThJKKwWifS3qBVmV+q7GkKWSvKTWB3S98sOj9qrIbTxl9tgAYlswdYIvrHA/+rDBTQ3DzgvsU7neTPZr3hRlKMXmuDG/AZfTlqJubjV+/SvNuClIOuyvPorRX5sLfA6V5jZ/vN73+tP8zzY+iaz1Q7sgpaBm7rPUIPAmcKzwwqxojaSEp6Ejas8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:slCkYtXxBpkuCx+QO7xIzDzmaDiR9ASHe4/E0BY+HYvTJFM/ne1ms75sCcz+JkqBDcoxE6hdFrQm55JHxaj6Cx7OTIIbVNBZjNYNxhsHJQ2OXLHirBWusT6083UZsMN4VH7plrch6qSrouraGHRrMgRNXQ3YqurN72jWqqsFOpI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 21:28:02.4252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7aa949d-1038-4ae2-bda1-08d5f8bed487
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

