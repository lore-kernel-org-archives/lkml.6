Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA2C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4086521ADD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4086521ADD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933753AbeGDG35 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:29:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933239AbeGDG2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:28:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w646O13d051859
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 02:28:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0q9x3jsx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:28:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 07:28:31 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 07:28:28 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w646SSTD28246212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 06:28:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3674E11C054;
        Wed,  4 Jul 2018 09:28:53 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97A9E11C04A;
        Wed,  4 Jul 2018 09:28:51 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 09:28:51 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 04 Jul 2018 09:28:25 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] m68k/page_no.h: force __va argument to be unsigned long
Date:   Wed,  4 Jul 2018 09:28:15 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530685696-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070406-4275-0000-0000-00000294F558
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070406-4276-0000-0000-0000379C7730
Message-Id: <1530685696-14672-3-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add explicit casting to unsigned long to the __va() parameter

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/m68k/include/asm/page_no.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index e644c4d..6bbe520 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -18,7 +18,7 @@ extern unsigned long memory_end;
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
 
 #define __pa(vaddr)		((unsigned long)(vaddr))
-#define __va(paddr)		((void *)(paddr))
+#define __va(paddr)		((void *)((unsigned long)(paddr)))
 
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
-- 
2.7.4

