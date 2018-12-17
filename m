Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCF7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414DF2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeLQKe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:34:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726755AbeLQKe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:34:28 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHASrnJ112077
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:34:27 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pe84fd5un-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:34:26 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 17 Dec 2018 10:34:26 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 10:34:22 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHAYLEl23265378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 10:34:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D326A04D;
        Mon, 17 Dec 2018 10:34:20 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99CA36A04F;
        Mon, 17 Dec 2018 10:34:16 +0000 (GMT)
Received: from [9.85.72.89] (unknown [9.85.72.89])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 17 Dec 2018 10:34:16 +0000 (GMT)
Subject: Re: [PATCH 3/3] hugetlbfs: remove unnecessary code after i_mmap_rwsem
 synchronization
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>, Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20181203200850.6460-1-mike.kravetz@oracle.com>
 <20181203200850.6460-4-mike.kravetz@oracle.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Mon, 17 Dec 2018 16:04:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181203200850.6460-4-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121710-8235-0000-0000-00000E39CC17
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010240; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01133031; UDB=6.00588966; IPR=6.00913170;
 MB=3.00024716; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-17 10:34:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121710-8236-0000-0000-000043BC3621
Message-Id: <b6d50644-7d0c-2c1e-2781-2c6cc81ddc80@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=952 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 1:38 AM, Mike Kravetz wrote:
> After expanding i_mmap_rwsem use for better shared pmd and page fault/
> truncation synchronization, remove code that is no longer necessary.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: ebed4bfc8da8 ("hugetlb: fix absurd HugePages_Rsvd")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   fs/hugetlbfs/inode.c | 46 +++++++++++++++-----------------------------
>   mm/hugetlb.c         | 21 ++++++++++----------
>   2 files changed, 25 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 3244147fc42b..a9c00c6ef80d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -383,17 +383,16 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
>    * truncation is indicated by end of range being LLONG_MAX
>    *	In this case, we first scan the range and release found pages.
>    *	After releasing pages, hugetlb_unreserve_pages cleans up region/reserv
> - *	maps and global counts.  Page faults can not race with truncation
> - *	in this routine.  hugetlb_no_page() prevents page faults in the
> - *	truncated range.  It checks i_size before allocation, and again after
> - *	with the page table lock for the page held.  The same lock must be
> - *	acquired to unmap a page.
> + *	maps and global counts.
>    * hole punch is indicated if end is not LLONG_MAX
>    *	In the hole punch case we scan the range and release found pages.
>    *	Only when releasing a page is the associated region/reserv map
>    *	deleted.  The region/reserv map for ranges without associated
> - *	pages are not modified.  Page faults can race with hole punch.
> - *	This is indicated if we find a mapped page.
> + *	pages are not modified.
> + *
> + * Callers of this routine must hold the i_mmap_rwsem in write mode to prevent
> + * races with page faults.

Should this patch be merged to the previous one? Because the changes to 
callers are done in the previous patch.


> + *
>    * Note: If the passed end of range value is beyond the end of file, but
>    * not LLONG_MAX this routine still performs a hole punch operation.
>    */
> @@ -423,32 +422,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
> 
>   		for (i = 0; i < pagevec_count(&pvec); ++i) {
> 
-aneesh

