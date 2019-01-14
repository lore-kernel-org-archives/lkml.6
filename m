Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3571C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B976620656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfANJzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:55:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbfANJzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:55:16 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0E9mWZt050523
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:55:14 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q0pskkn9b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:55:14 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 14 Jan 2019 09:55:13 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 09:55:10 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0E9t99e20119786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 09:55:09 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F76CAE062;
        Mon, 14 Jan 2019 09:55:09 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1C86AE060;
        Mon, 14 Jan 2019 09:55:06 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.106])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 09:55:06 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V7 5/5] testing
Date:   Mon, 14 Jan 2019 15:24:38 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011409-2213-0000-0000-0000033D1069
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010402; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146284; UDB=6.00597006; IPR=6.00926570;
 MB=3.00025118; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-14 09:55:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011409-2214-0000-0000-00005CF72F86
Message-Id: <20190114095438.32470-7-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=779 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 mm/gup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 6e8152594e83..91849c39931a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1226,7 +1226,7 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
 		 * be pinning these entries, we might as well move them out
 		 * of the CMA zone if possible.
 		 */
-		if (is_migrate_cma_page(pages[i])) {
+		if (true || is_migrate_cma_page(pages[i])) {
 
 			struct page *head = compound_head(pages[i]);
 
@@ -1256,6 +1256,7 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
 		for (i = 0; i < nr_pages; i++)
 			put_page(pages[i]);
 
+		pr_emerg("migrating nr_pages");
 		if (migrate_pages(&cma_page_list, new_non_cma_page,
 				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
 			/*
@@ -1274,10 +1275,11 @@ static long check_and_migrate_cma_pages(unsigned long start, long nr_pages,
 		nr_pages = get_user_pages(start, nr_pages, gup_flags, pages, vmas);
 		if ((nr_pages > 0) && migrate_allow) {
 			drain_allow = true;
-			goto check_again;
+			//goto check_again;
 		}
 	}
 
+	pr_emerg("Returning with %ld\n", nr_pages);
 	return nr_pages;
 }
 #else
-- 
2.20.1

