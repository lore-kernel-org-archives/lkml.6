Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874ECC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1944220870
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TX34LYfE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UVjQNFZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1944220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeIGVjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:39:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50630 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbeIGVjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:39:40 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w87Gv08F030359;
        Fri, 7 Sep 2018 09:57:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=xuxpRF/Rv0E1kY6bUug4snKsiwREGkY0cskBrnT/g0c=;
 b=TX34LYfEkqUyQ2BXs60GxTFNaI87AWvCXGCy0p+7+J4ngwPTqthV+nybDnXRQYPS88FJ
 Qf3lxlt52XVtdP+fC9siaDLGIF3qK4t5yLn7sZyPYTVEfmLy8PxAMTc+MMGw7nZaRtuR
 YtHWztN+KHHNi9tMqcikwrnwoprF1GQeMQQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mbu868d20-20
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 07 Sep 2018 09:57:49 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.21) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 7 Sep 2018 12:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuxpRF/Rv0E1kY6bUug4snKsiwREGkY0cskBrnT/g0c=;
 b=UVjQNFZjF5GK4OQ+u4BEHP3V3pMGOt+JFu26uUwlZ/SW44QGG2TrQOVAAC/00tIHqDzOwILfAwzhIx8p04Ws990rqSlaTbKxwSDLHtXsRxuf2UWcw5jajxExvDPkuEiNFk6PxoGYiLISgKVI7KOUH7ApkIFvn/Zd7vQ1MkOF9vU=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::5:168f) by
 SN1PR15MB0175.namprd15.prod.outlook.com (2a01:111:e400:58cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 7 Sep
 2018 16:57:27 +0000
Date:   Fri, 7 Sep 2018 09:57:23 -0700
From:   Roman Gushchin <guro@fb.com>
To:     <jgkamat@fb.com>
CC:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, <jaygkamat@gmail.com>
Subject: Re: [PATCH 2/2] Add tests for memory.oom.group
Message-ID: <20180907165723.GB572@tower.DHCP.thefacebook.com>
References: <20180905010827.27743-1-jgkamat@fb.com>
 <20180907164924.13789-1-jgkamat@fb.com>
 <20180907164924.13789-3-jgkamat@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180907164924.13789-3-jgkamat@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::5:168f]
X-ClientProxiedBy: MWHPR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:300:ae::27) To SN1PR15MB0175.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c01234f-765f-4aca-bb7d-08d614e2fe8a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;3:BsiwgPsdAn0JWMXSasdgLqdDW8rsmmdrXhdKNqcRTe8SqE/pDmwFhtnRMfXHbr4wDUWxXIFQpBJXeu9NEhDXysxiaWou13YaA7h3Y2tNPbGZASuUy8RtaAKVUH6/jU6js1THEL3aPtvEWJPa1L1Ih+dZIpSBzzX+NMAv8XvLyhaFpMS94LT+YVKfB42ohui4AaYvh9xTKGpaEApkhCVnaWobERzqabxXaMAExEnnyoVkqZt+guJ/3ITU2zuWzXfn;25:gLAQmYMoiEpSkW7gYN2+sd2zkhSAdsJKIX51nm/ZpQAG+raVoSMpBc4Ww9A2oANDM+hiUnk3NAt+mzc0Bc11Ba7A48T2JwCmY764+LW+9JxY+s+AhUzanBC2PVCmwf1C2ojmSqEUM5U+XdoYnR+3oS29TsZHS07UyVSJqKPaUS5jW+g/S8SaRqk8OfVsKBG9ksSs3uX+NpKiKLLHVtzG4mnehuYizcIHI0xvqTybrVxumHD5NwusfGtMCxyEvdH49xIinkJNQu88r4vSrK5EmWVj8aUUG2nZdP6KFFgLVfEXujBKJp1l6D5nobDj5TqhZAbNiIVLoIohumZmxJeUBA==;31:fPn0LyAVwWNL7MY8iytDDimbsBWVIWa22FZ14A7NFQkcKtKgEUJHSS5sltq3INQnQENM02MDmVQYCMjxHywYl2OndDTeZmVD2MXVj+FXxHDbPt5r/WIil6wW/Rwigo8WECl683lf1GJjgoqIwB//gJKvQxrn5us9xXHnU0JG7V0yflSJmFZV81AgjpboioB2TFnJeVryptajfooGUCeO74FizVKEbo2b4KdMadOqf6w=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:491W41yolB3/ZdaxxphiABEV+8VDDZ+6UDyEUAA4x4RHsbPdmY+XTn/Ionbx+1w0ojgr7VhGKFf8BbaEAPEBG6mx7lBvvgeVKC2CwVFVL6JQSB2Vzefyiq9QQKT1QtAIM1S0huhskp5rOzdi3G/AUvasF71NY+1FVmoizZ9qZYPKQvVmoya3Q1Z1tajdY/ghaj+muVqo/Qiabbe48qROaCgZHZpPE8hBvcx29x3EGZF9nz15O1XhIDdxZRf0hVaEyoj8XHIsK7+YjxOn/6UC820O9UATY+UcCAsjBMPZYPLVOy946yA22S26rY5g7mdDqVLsDttvjWuZQiQygA+9+lNvvf/5W1K5Xk4UOynhB889Z798nWinJ+D1a3pbmZ9Uf51x78EsO+7NSmvwkPbCtgAPzWjEOfJ3Qz4kikd432Zk9OD7IDf22zWvRu8o6o5afGF66L0NCsskM/XeXoEe5W7yW81MjcpEw+K63kYdEpzzbMjG6jY8AC8/0K1WRjmM;4:+2UuZA6VcGTNjSUnwULNIWSo2bNK2DEQ7Np5iVtm7F41QKE7m5x2bAt92ZmJ/qjABwgvEmaxraSlvQ6TCV+yd2YzZyGLgmKTecv3zZn6zsIIvj3/d88gxpiHFnZ5+hsJlIbax3jqiIoLIAXacwCFa/8t2E+Wbqpd/HHvTr4ZYXOEPU4lIhGIhsOIq8OPot7jhDfZChVNCfr8jZruqktJYmrGveQsRKtxTXpVToXnCZSIfO9KblbxGJxPgpYJjxx2y4CA3HIBPlLqfj9uooMNPHiasC0+tVxY20k3tthKJzs+yIhjYXCbLDFUtRh7ZIfC
X-Microsoft-Antispam-PRVS: <SN1PR15MB01750EBEBD041E2E9CD2F691BE000@SN1PR15MB0175.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699050);SRVR:SN1PR15MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0175;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(199004)(189003)(446003)(486006)(50466002)(11346002)(86362001)(2361001)(476003)(305945005)(46003)(8676002)(316002)(53936002)(6666003)(81166006)(16586007)(6636002)(81156014)(1076002)(55016002)(5660300001)(105586002)(9686003)(58126008)(7736002)(25786009)(68736007)(33656002)(6246003)(4326008)(76176011)(229853002)(16526019)(2351001)(39060400002)(2906002)(52396003)(7696005)(97736004)(52116002)(106356001)(8936002)(6506007)(386003)(6116002)(47776003)(23726003)(34206002)(478600001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0175;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0175;23:EIbzoOxZRubXCZCdZCSjQHclF78dQX1hDSWT8sGs7?=
 =?us-ascii?Q?c9UVGEadVQCVwiryDWzWXwjdgJqEeHXfTftphPMCD/W2iIacq4g2ordzuk2g?=
 =?us-ascii?Q?1SvBPvQlMiGRAaM1z6iPDYDGuYsTtbK3ePsDPn4aOb7+dpb0KR/fs1FC0SNy?=
 =?us-ascii?Q?pFP2Ni1YAKTY/KmYZVLh7SSM3l2NnD6u2PHdEtonR+lPz50Tl2JLc5TaqpUp?=
 =?us-ascii?Q?EVbIe4y1kkdtURPDUM9BEIW/d7EnUURdc6tdC4GBix6kc0GFT4oiTUj2rU+R?=
 =?us-ascii?Q?pkbdM17RI21++Y6Q6V06EI4AkE3yvnsz9gIb7y8N/0v2ZwzDM+/eehGLOu0E?=
 =?us-ascii?Q?28e7EwFa4xhx7ueUfYGLDAfW6Rn63iC1bZ5jkPdaFdH1j2QHcPvoRKeiYBgF?=
 =?us-ascii?Q?ZWBUWgE+H76/lTg6ubA3ITWoOmuY/s7K1caL5GoTM0uvPZcFR/W++uCtr7P3?=
 =?us-ascii?Q?c/cYukjayaj+8pZYIaPS+oVjxP28bVTVdpKgAvI7NjJk+Aow8GELjax8gCAJ?=
 =?us-ascii?Q?QqpIyySnRSUgmu4MkIYbR447gD9JmJUcqdjjF1pSKsHvDavCQRIC6UifnU8r?=
 =?us-ascii?Q?xezCO2QJJm5rEj5lMW7tAQabUxbtSCjxROLkpwIrMt2/bE4o+PRNg/vUMZ5m?=
 =?us-ascii?Q?l4mPVPGd50MbBfdGqXzL2YAhtNmdKdd/hm3dsNiJx9U7r/kXlBCf1dxkYKs4?=
 =?us-ascii?Q?uCJiGMqDYQCMK2teHpiApotsGlqAENoxq2oHSIX5Kp+pM+dS4nA3R1XZp2a5?=
 =?us-ascii?Q?whN3NpFoOf42lU9cQS6OqJcC1XM1WjDXPhBsMJ9YHKsHKbA/jrnNpwNx9Cpk?=
 =?us-ascii?Q?UyrkSWg4vabRIcGTmkY6pGbrr8vFx7sNULEjbOXsg/4xmhbPur28N1ze9FI4?=
 =?us-ascii?Q?CkwcinRk35eV8KfQlPGUfXhe742dzw2If+NN2coOcsbf9Juskwh5cdgltIyZ?=
 =?us-ascii?Q?n6VhmYfsoDgB+cIjBR0E/9DbLGGoAR2Zm7vUe/MlIfjIi3bkxAwBjvWj4Dze?=
 =?us-ascii?Q?kJ8fj6ihsTgx2q19gS6a7Cjk+tzC1q2ZEsMK+PdgarBWgKVrKi1d19ocsWDB?=
 =?us-ascii?Q?uSK61jpMkOAXOtSwIwnhEVtLpr4GDmkEDNovJy2OKMssWDipln10pyi5rKH1?=
 =?us-ascii?Q?7yjAN+/XWponAZl16ZsFigVGd5VKjrr5Fgb/NlHrk7+zrs4CtCImF3648eOr?=
 =?us-ascii?Q?9AIN7ZtPsb+pX72N2Y8aPuytKcV3km6/E8scYP7voEVXyb4OIfFxb3Kb0UWY?=
 =?us-ascii?Q?KpfTpsVMBvFfkM3877a23sSEdGPLFTO4e1V4gajdAr8eWJFhvKkIyDUyxGKB?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: bFugqlI/oxg19RCUHxw56/Tc+8kz4bqMwulmqBn0Q7+aWYWVqu09ThNYZRAcDLbC+XdwOmdeVv1fNKDBEhQREXo3/U9S1eDv3k/LuB9eWI+QCbOwNCemGu/8kA34q8QK/iWr7vVNAtfwFTfLRsPPJE+/Kromvcn6CByduJuuT58P1a3di/an0BV26FHJIQNVR0cehDt/VXjtYkbKgb6GOS9X7U+YO6NyvK8PtovmddA7aSo4T4kuQnfkuP2zMMvNvDM33y77IY6qG9CJmEYYAelyujDXTDgjGGavw2qbZy+ZoF8V30Oe6aZ5SFNpMbJZepppTK6SVfHVUYBh9bSTXNSc6XQo4qtQdEi31r58gZg=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;6:VG/lsVHpsvvqqzAiZf7XuenqgDs8Y3HRJkzriLB4lNsqqwqB0Y4rjFuAeuyDwLtQzU+y3DUeqBnLEU0ciB2BxO14mK+z1BNt//wzv1YPUoTGPOpRRiAAFKGmziw6XGu+N/3/E/mFbtbUWKK1GtZhQGhXurBGxyNk+1bc14CYZRAN4bZC0t+36w2mDaG524rtARh7ZLXMafuebE1dB735BQYU7KyTySsmAW6G54P82QkHUo+pnuGdqsQ7wcTSRgLIWsuJGh0f8YNi/j/iMKXVUqPYvdSLWVwVhWBUJSc7rVR4Khypmxl8tnkT7Mr+vm77a62NIOM+TsKswq28kD/uekUWutNsbM8XCJZ2yfRo5ePWyQcqx2SgRTwd7cVM6qEiwZqdrrW+UzB73+mCG/7Ad4tMDsfrtsDJmg+QGYoYljC90quDUMenXoPmr7T+FNDs7LllIq9tx1o//x+OxLZo5A==;5:hiu8DQ4/P59cI3reS7u6NQj8CZVKUdVwCswbBb0tmI6vLWruxk4zrOeUqVmMIe+Gbpg1evIj6EvAyxzDT8bAEtPNw+q6vWqLo4O1+TUbuajGr8JD8jquARLRolUtXXhPVjLT6IWHvNdChFUQxtXP2aeUNmD6felgcqIW/dzqSQg=;7:5K72jZknZc+GxPbKcJK/6+8vBf0F7c+zht3xQeR7A6J8mp2P++/6O8Lq/S/DWUsAalkCyJuIjlo2pPUK6RpX/vzuOFSnetzXnr8yHqXLO7Mx4M1r6+qM0DclJbjB4vCPCEKS1s+s3QXkVOTEHX6v9UM+NrviZ47MA8gnlnpfH+q4cVdXEZqmaE1gq3osvbNG2p5BXrDPBTYT1KjAGyw6ffN25RshyFACGL9NiCky/+wBBtYWnLC2Diahnn7yoeHb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0175;20:R5EcJrvwJLFhUnnIvN/8M5QcrX2+7gS1/Rhj7piR0TgVoyRNA9MZzRFJ9Hf4xToaTIEgNQAn2xnsjLG9nSGG4yDOTNxbmZVB8Qh62uerAXYKzPdFhyQRvvmWs1vOvBKFhu1kS1I2/twN6AyKyzzR/j9HXaz6NaW8SF5ew3WQA8M=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 16:57:27.7767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c01234f-765f-4aca-bb7d-08d614e2fe8a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0175
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:49:24AM -0700, jgkamat@fb.com wrote:
> From: Jay Kamat <jgkamat@fb.com>
> 
> Add tests for memory.oom.group for the following cases:
> - Killing all processes in a leaf cgroup, but leaving the
>   parent untouched
> - Killing all processes in a parent and leaf cgroup
> - Keeping processes marked by OOM_SCORE_ADJ_MIN alive when considered
>   for being killed by the group oom killer.
> 
> Signed-off-by: Jay Kamat <jgkamat@fb.com>

Acked-by: Roman Gushchin <guro@fb.com>

