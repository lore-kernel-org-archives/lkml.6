Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DAAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0786F219ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="enzGcVBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0786F219ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeHFL02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:28 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48068 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729667AbeHFL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:27 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BF7F009124;
        Mon, 6 Aug 2018 04:17:51 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp0117.outbound.protection.outlook.com [216.32.180.117])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn85wc4ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5CuCWdPyULqZlreVHSpmw85rUGeTGjsMSqMWnnoXNs=;
 b=enzGcVBYJxTrjvPRzJ/wu6L3Fp+ExJBBTeaNTT+/mVZSS54aO8BfbxyBmxJEyMWtCEevovK5hPo1Mzcl/Rk2C3eD+dF5eQYCZ5utLKjLlUDDTl4NMwIk/n472USGardYvTu4mU4cX1UrPNv/E9Y0SmBp6KqB8FQtTqELtjVKAuw=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 BN6PR04MB0964.namprd04.prod.outlook.com (2603:10b6:405:43::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:48 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 45F8A302F68; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 22/22] Linux 4.9.115-rt94-rc1
Date:   Mon,  6 Aug 2018 04:17:38 -0500
Message-Id: <3e5ba359bcc4ed2dad6a3a84fa78c8a05d6a0fd9.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: DM6PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:5:f8::48) To BN6PR04MB0964.namprd04.prod.outlook.com
 (2603:10b6:405:43::36)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac337509-3854-45b8-00a2-08d5fb7d7a5b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0964;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;3:+mo5PFan/L2oBsqZ62BXhxTPCHMr/kG7e4SVMpCt1M27fzRV4Sm461ASSXyFNQijIdrif6ctHkuoQWHdJ/4muEJKvPTGrcxH3NL264e5UdKkqdupn6KsZbPwYvU+2DLJEOG4UiXAIG1dtEKGz58KhBQwZaLp0V+9on2kKrwnEU/FSshca0TvAf1964gT0cXy09ngAeTWpowRXL5FRDRduRdvK1PxNdO2CTtlzBpsjIA7Rcwth3XV+l2gQjbziWZc;25:+Jp/Z3jOtUlbiVlRgs3xyVLHGGE58ZZVEz4ZnwUPknN6TFHW33R0MjCa9Wz2lm8taq/c5xWBWBG+/wNh7K1NEir/Vr7dUhd9wsMkYFDiUr+4g6yqnz2MkhFteSD/CUsLxKTu+z74vIHJfYRLtPTnz+DaRt5s8owaZfrFymIInoR6jWigOAojw1bI4t07zulTom1tu3oBxO6AlUX58aEiLrrvHMwmIJA4JNkw4AhiVrfdVxbqijVBeuDcAl+LTkRfcPJLLa03nhMgTzWba3mQlOkEsCmedxy0YmVdhn1vw4d784Sq7jcvxVvMgVZuRopsBhNflTyr2EMx7ZYJF1XXlw==;31:Wn/9/4UXA+ImA8kqY8ZuN14aKhAeQsmRrX3qWGJ2uZhC6Fb8I2gkKJPtgO6mi5k8WHORHDbklf/Va0B8YHuHeDKJyRCAwOttMedHMJEi2hOeki2BQZ8W1PghQG65aGaiOSWvvAZBONvpB2tXI/VTULcgGxmacdb089LMlb0CcjW1xToC+MwvF36ZglEbq8I1Ip3Uo1U8cng/aEe5axHXebd2VZzo26EAONKPry86ePk=
X-MS-TrafficTypeDiagnostic: BN6PR04MB0964:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;20:tNXAFOLDHQgW0jSq04BiTt1sGuZZOlqVoTLU23cs4Ky+ouzH+IH2mvyvAU7+hMJ0fJI128QLHNXEaxRWauTyYdURBUx1TCM8NJsl54mniqKXQghHB9jLT7BSJwISTTWIc1yHlvxBWBJC2xqP0vFT1o1B4uuApmjlajYu+Br8YkWE6LemjvOYt1E9w+5Is03mAovu+2QLD8amOeCYrL9R3iUtVfq797NLtRFZQEPHy8X5d6DCfr2sHIOsyVrDTEIVCCw4y+sgoXNeHR9vkCmJzW8AvpiJFcDmxVo02qPqO/RXOsKyRFVsUZyiyZgH0OQdQIMQH/8j7k39708Dd+jSF6fToA6oVKoj2IKO8yXLSBmHummqMSwOeuKbbE9HYGk3iXvfAg2J0jreMq5jpgxtwYxnQ8wKxuRo3w49FWNd8b0p0yWGexAcZtbYpvJGQyvXUp/Xsr5pQITLN5sWUv1/fB1mIYSnz2pOvAjsuN7P9FyyRhTQZKBgGzYrt7edRS2CmtQJ4ZQCku4ltu2M30eZG0BQu2J7Njz9vUVWtwZ3RkthwmbgDvunQGkwdzXlpglXoAg+N+Yr5RmLfCXpd9xT18bmHxEKZSgcjW4vHSfo8bo=;4:rioHS4bOn09AiCLSqy0pyXIcB3h381DoNVYqiu6n1z6Vwqgw4H/u8UOBfRnEP4b6ikYXSP/7V0hM+GJHBnh7oU6R7Rqzq2VKsyR1RhrGXh3BFPhn8pImI5AGGCXgMJgQXrfgRQENazBAW3ITYVhkpwtEA+Vc85KoIo+LP4yayw1qciz8TmeOM78V+CvSjAZOHsUSenDPOhfS7XXjTmOl2igpEdVnXYG/ks6ITkbqUqbkQsT9r5wZc0lcvgsFEGg3cQCHo3wmw33xpkZfKxjDHg==
X-Microsoft-Antispam-PRVS: <BN6PR04MB09641B4B75C8048B21327FA5F4200@BN6PR04MB0964.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR04MB0964;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB0964;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39850400004)(346002)(376002)(396003)(199004)(189003)(118296001)(76176011)(81166006)(446003)(6116002)(305945005)(7736002)(8936002)(54906003)(386003)(316002)(53936002)(52116002)(97736004)(50226002)(51416003)(81156014)(105586002)(8676002)(66066001)(47776003)(16586007)(106356001)(42186006)(36756003)(6266002)(11346002)(90966002)(4326008)(5660300001)(14444005)(3846002)(122856001)(476003)(2616005)(7416002)(68736007)(50466002)(48376002)(26005)(2906002)(186003)(486006)(52956003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0964;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR04MB0964;23:t2aVqkmEj1b78PgTyKCDPE+0KFV3FAogdhyE1fxnO?=
 =?us-ascii?Q?aJGlWemunbn2FC/xj4j3mI1ksM3AMKk6qAvTtACFM0nPdqUCEVX9kGth5IZ4?=
 =?us-ascii?Q?XEiWWI7E5k55Tu8g+YE5Ri6tn2g4oubCjvqsDpKZ3O8oXDGC0PCQx3V8Zyu4?=
 =?us-ascii?Q?Wwki9I9jWIuyOFMui0XIOmcGe0OiLuTLMHm5CtpkLGB6wGj1tqxmd5QzMYzD?=
 =?us-ascii?Q?gVN8EYxhBxbnfP9+CgzZ09l02YyQxGBUqPOBnUtSEg5d7K+TD8g3vLP92m3K?=
 =?us-ascii?Q?1d8N28ULe15dpguOflsZE/J4dCjpUvjHM5M/62ayA0g+VahxDYcZU9jDlNkE?=
 =?us-ascii?Q?GufEVIqAoftfeoc6IhO02+tJ9sRE1Jw39xJtI4Vln/zhd7qOsNJ6X/lVB4wX?=
 =?us-ascii?Q?GTrzsoJoVkrPV7rQUl1sYBE93iqWU96xo+22BsNwzMan1W2eLe+sliCsbEt9?=
 =?us-ascii?Q?aSkI4sn1fnM9OeBQEKUAVT/PUWCEC6MOSZOIsqniug9UHUUpQAeKQews+Xvo?=
 =?us-ascii?Q?Kq6+ruFQcwOp33XVBjkOEyOgCkgksVwMsVuCwbCMkaMtl+hqGvygsRIkELHs?=
 =?us-ascii?Q?cXVIOlaDBu92UxV4BdWNlskDZcEShleMyxcecm0H59pcDi+7ZPEV1dsuDJUF?=
 =?us-ascii?Q?wQ8e2QBe7YC+9ZlMDVa4hJZB8sA3Qm3ygi5KNK/vAxZ2MGl6RLpToLg69/Jd?=
 =?us-ascii?Q?SRgXahy3xmbhO1wn5/deOE2rG7B49BTr8Ln7dmTJ6vyT9VlTnDbsPQAtwh8V?=
 =?us-ascii?Q?nv3nciW30NuBqKtzbGk/fkNcJbv+KMn64e0cExN7kuKL9lEqeeYICpTJzsi0?=
 =?us-ascii?Q?ztbHIwUvVtoP0Zmv3lIGdIMOZhWVT2Bx3Av5PuzeSRY2yxL9Wdb8gnKPLbXs?=
 =?us-ascii?Q?TlcjRG069r5mMOjSj1qC0Eathm7Eys1emlMy8+nFVL/jcVEWOxe2AQ/7EFX7?=
 =?us-ascii?Q?5Tb0q8R4Ca8OWHyX9hs75qeAdBzHu0sHmGArDpkaZCNv+H1q0hBUnJqA3EA8?=
 =?us-ascii?Q?LqpUJunaxU4e3wnsAb67epZB6lDwZszCkbV8Kb2elOEDNcyylp+YS2sg6Ga3?=
 =?us-ascii?Q?uE6eM60jegOR3y0qcIQvGM76bzZ/QQfs15pawHa+ZI8b61DBMChY2WHVjGlr?=
 =?us-ascii?Q?y+jU9RcKzLkU2Hg57ns5VOxpT9HlJj9rZEH428MlboGVQimRdp6Dn1Oq2Yym?=
 =?us-ascii?Q?AwOH9C0j0Dv+kc=3D?=
X-Microsoft-Antispam-Message-Info: iCWoM1QHpz0Bs9npFJ5K/BIhQ6O8ehorYcDP8JDFkdLkdWMndBq5iTil/rv2O/Vtc3Lz6y2Dylgo0dBoX9cp+e22FZnL/TDff8wHPRPbsqVhbZIPCYG21hh9ZaoG8Fv40KwvaS4VxKzwVBIcUIimpY7II64EkaGuxj4wB4RpmOvTBs2s/QKwJS0APgd+g37mnRbZuXXcVMM+yj8DccnYK9uo/7Kye1Ouw/NonDe1hYTZLj8prAuHXz1iZz18v7HNMBnaKGYvLTPZYl5CB5VCBntrF67vl3+sHq1gHWk4a2TioTupEQmnIalBCDxYQVUShg3piGiLA64FMNviYZm4HY2kAGlQkUFPAoIQ7vUvGC8=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB0964;6:vLBJs9nI0yIksjYyMFTVvdS+sBAOb8e5FcTW8sM6R5PZyOLABW0hb+KDOpNSQP1Y6HYPeBXu3M33s/yCQ0GpJNHvo7rFuoKoWul3VUjgBznwtiJOGsfYdfUHNMTsFBHfjAXSgRcKANurAC+yP5atmar0F3YsrN2Jhmu/v+Jer4yNuTThjcv/+1n1WJnHQhThIHZW7L8EA4fAQNhRt5+jCitXaKkYgCjK0q/9UZFqJhiOYVV2kORJXFmf9nJXH21NMICPYWpV501BtPkgPGJZ85tFd/5pCdZark+OgfCoyhiDYIauNXElBoZgNVE+yxVTYEy/l3stZb6FOQmEbLcB33N6LpAzghzkOzkqoCCw9qeCEZ+PLp0CuOWjoa55KG5Ei9wGC8JOcr+lTOBiTmIo1eLUujGuOvYbvV0LaBrnqdPfQkVp5CVGFTbRlAGIrMXx/LemcIS+pszL4P8VUYrZ1w==;5:+U+IDw6MxaoJXGHiYg5FEW1pjDeyOgKnp/BqSZ26nYu3e75UKU7dnRFjqYTKmqjwH9fM6/Gz2N4FtA7GmSJdhqyP5jNbgzi2TfrN9cL9B8ZeBHjHhw/rhbBFTvgBoavgzLVHS9AHhmiGdPrxHuz5iD2ckoMAqU5X1YULko88BGQ=;7:Z8a1jYkHns5QOhHOiVCIWYf5/FkdukxxYLVGg7r0bg0hRwUJcCaqcnRc8cC0DShg1cVy3InCYSKCiuf+HPUjSGd24xGZwwLZLdSTs8UeKt7tP3UVRFBozosPqmHaBa05MW0Ft840FHhmw2brlSgICmPUgb8cf8+jqjv/a9jP57i9isyEIvmq8QxAu7cdLj84/FXRVlkxrEigz5W3Vb9pHpbsZ7/X7/KhEqtzOM1fLCb4AB4mqnsy31qKQIPXUPFI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:48.4436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac337509-3854-45b8-00a2-08d5fb7d7a5b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0964
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=615 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index e98a1fe050bd..dcc2fd2ca155 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt93
+-rt94-rc1
-- 
2.18.0

