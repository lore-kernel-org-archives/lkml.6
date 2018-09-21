Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96746ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3992C21568
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3992C21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbeIUXHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388909AbeIUXHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:07:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LH9pFO118896
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:17:51 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn3jt3dvf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:17:50 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Fri, 21 Sep 2018 13:17:49 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 13:17:45 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LHHiTE43581530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 17:17:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7507AC05B;
        Fri, 21 Sep 2018 13:17:16 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A97C6AC059;
        Fri, 21 Sep 2018 13:17:16 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.79.178.146])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 13:17:16 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 6D74C2E2D93; Fri, 21 Sep 2018 22:47:40 +0530 (IST)
Date:   Fri, 21 Sep 2018 22:47:40 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Michael Neuling <mikey@neuling.org>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] powerpc: Detect the presence of big-cores via
 "ibm,thread-groups"
Reply-To: ego@linux.vnet.ibm.com
References: <1537464159-25919-1-git-send-email-ego@linux.vnet.ibm.com>
 <1537464159-25919-2-git-send-email-ego@linux.vnet.ibm.com>
 <d1cf1628ed2641140d3508d355cdc172d6b145e9.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1cf1628ed2641140d3508d355cdc172d6b145e9.camel@neuling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18092117-0064-0000-0000-00000351F5DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009747; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091619; UDB=6.00564045; IPR=6.00871643;
 MB=3.00023437; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 17:17:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092117-0065-0000-0000-00003AB90ED9
Message-Id: <20180921171740.GA12919@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On Fri, Sep 21, 2018 at 01:02:45PM +1000, Michael Neuling wrote:
> This doesn't compile for me with:
> 
> arch/powerpc/kernel/smp.c: In function ‘smp_prepare_cpus’:
> arch/powerpc/kernel/smp.c:812:23: error: ‘tg.threads_per_group’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   struct thread_groups tg;
>                        ^
> arch/powerpc/kernel/smp.c:812:23: error: ‘tg.nr_groups’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
> cc1: all warnings being treated as errors
> /home/mikey/src/linux-ozlabs/scripts/Makefile.build:305: recipe for target 'arch/powerpc/kernel/smp.o' failed
>

I couldn't get this error with gcc 4.8.5 and 8.1.1 with
pseries_defconfig and powernv_defconfig with CONFIG_PPC_WERROR=y.

Does the following the following delta patch make it work?

-----------------------------X8----------------------------------

From 6699ce20573dddd0d3d45ea79015751880740e9b Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Fri, 21 Sep 2018 22:43:05 +0530
Subject: [PATCH] powerpc/smp: Initialize thread_groups local variable

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5cdcf44..356751e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -809,8 +809,9 @@ static int init_cpu_l1_cache_map(int cpu)
 
 {
 	struct device_node *dn = of_get_cpu_node(cpu, NULL);
-	struct thread_groups tg;
-
+	struct thread_groups tg = {.property = 0,
+				   .nr_groups = 0,
+				   .threads_per_group = 0};
 	int first_thread = cpu_first_thread_sibling(cpu);
 	int i, cpu_group_start = -1, err = 0;
 
-- 
1.9.4








