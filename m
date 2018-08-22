Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95390C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4015A208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4015A208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeHVMyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:54:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727396AbeHVMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:54:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7M9TnUn009061
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 05:30:27 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m107mjfra-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 05:30:27 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 22 Aug 2018 10:30:25 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 10:30:22 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7M9UL3344499008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 09:30:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEDF2AE056;
        Wed, 22 Aug 2018 12:29:59 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 118E9AE04D;
        Wed, 22 Aug 2018 12:29:58 +0100 (BST)
Received: from skywalker (unknown [9.102.1.235])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 22 Aug 2018 12:29:57 +0100 (BST)
Received: (nullmailer pid 16601 invoked by uid 1000);
        Wed, 22 Aug 2018 09:30:18 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Haren Myneni <haren@linux.vnet.ibm.com>
Cc:     n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
        mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
In-Reply-To: <20180725200336.GP28386@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com> <20180725200336.GP28386@dhcp22.suse.cz>
Date:   Wed, 22 Aug 2018 15:00:18 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18082209-0008-0000-0000-0000026515E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082209-0009-0000-0000-000021CD57B5
Message-Id: <87bm9ug34l.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Michal,

Michal Hocko <mhocko@kernel.org> writes:

> On Wed 25-07-18 13:11:15, John Allen wrote:
> [...]
>> Does a failure in do_migrate_range indicate that the range is unmigratable
>> and the loop in __offline_pages should terminate and goto failed_removal? Or
>> should we allow a certain number of retrys before we
>> give up on migrating the range?
>
> Unfortunatelly not. Migration code doesn't tell a difference between
> ephemeral and permanent failures. We are relying on
> start_isolate_page_range to tell us this. So the question is, what kind
> of page is not migratable and for what reason.
>
> Are you able to add some debugging to give us more information. The
> current debugging code in the hotplug/migration sucks...

Haren did most of the debugging, so at minimum we need a patch like this
I guess. 

modified   mm/page_alloc.c
@@ -7649,6 +7649,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		 * handle each tail page individually in migration.
 		 */
 		if (PageHuge(page)) {
+
+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
+				goto unmovable;
+
 			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
 			continue;
 		}


The problem is start_isolate_range, doesn't look at hugetlbpage and
return error if the architecture didn't support HUGEPAGE migration. 

Now discussing with Naoya, I was suggsting whether we should add a
similar check in 

modified   mm/memory_hotplug.c
@@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 				return pfn;
 			if (__PageMovable(page))
 				return pfn;
-			if (PageHuge(page)) {
+			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
+			    PageHuge(page)) {
 				if (page_huge_active(page))
 					return pfn;

One of the thinking there is it possible to get new hugetlb pages
allocated in that range after start_isolate_range ran. But i guess since
we marked all the free pages as  MIGRATE_ISOLATE that is not possible?

But then it is good to have scan_movable_pages also check for
HUGEPAGE_MIGRATION?

Complete patch below.

commit 2e9d754ac211f2af3731f15df3cd8cd070b4cc54
Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Date:   Tue Aug 21 14:17:55 2018 +0530

    mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is not supported.
    
    When scanning for movable pages, filter out Hugetlb pages if hugepage migration
    is not supported. Without this we hit infinte loop in __offline pages where we
    do
            pfn = scan_movable_pages(start_pfn, end_pfn);
            if (pfn) { /* We have movable pages */
                    ret = do_migrate_range(pfn, end_pfn);
                    goto repeat;
            }
    
    We do support hugetlb migration ony if the hugetlb pages are at pmd level. Here
    we just check for Kernel config. The gigantic page size check is done in
    page_huge_active.
    
    Reported-by: Haren Myneni <haren@linux.vnet.ibm.com>
    CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4eb6e824a80c..f9bdea685cf4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1338,7 +1338,8 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 				return pfn;
 			if (__PageMovable(page))
 				return pfn;
-			if (PageHuge(page)) {
+			if (IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION) &&
+			    PageHuge(page)) {
 				if (page_huge_active(page))
 					return pfn;
 				else
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15ea511fb41c..a3f81e18c882 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7649,6 +7649,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		 * handle each tail page individually in migration.
 		 */
 		if (PageHuge(page)) {
+
+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
+				goto unmovable;
+
 			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
 			continue;
 		}

