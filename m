Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B7FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDC720892
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDC720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeJOSY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:24:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbeJOSYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:24:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FAeAuY125126
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 06:40:14 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n4qggvrst-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 06:40:10 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 15 Oct 2018 11:39:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 11:38:56 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9FActx06095274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 10:38:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AAFA5204E;
        Mon, 15 Oct 2018 13:38:26 +0100 (BST)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.133])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8765F52050;
        Mon, 15 Oct 2018 13:38:25 +0100 (BST)
Date:   Mon, 15 Oct 2018 12:38:54 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     hughd@google.com, aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mhocko@suse.com, rppt@linux.vnet.ibm.com,
        imbrenda@linux.vnet.ibm.com, corbet@lwn.net,
        ndesaulniers@google.com, dave.jiang@intel.com, jglisse@redhat.com,
        jia.he@hxt-semitech.com, paulmck@linux.vnet.ibm.com,
        colin.king@canonical.com, jiang.biao2@zte.com.cn,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] ksm: Assist buddy allocator to assemble 1-order
 pages
In-Reply-To: <153959597844.26723.5798112367236156151.stgit@localhost.localdomain>
References: <153959597844.26723.5798112367236156151.stgit@localhost.localdomain>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101510-0020-0000-0000-000002D43540
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101510-0021-0000-0000-00002123381F
Message-Id: <20181015123854.5a22846d@p-imbrenda.boeblingen.de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have objections to this patch, but I wonder how much impact it
would have. Have you performed any tests? does it really have such a big
impact on the availability of order-1 page blocks? 


Claudio

On Mon, 15 Oct 2018 12:33:36 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> v2: Style improvements
> 
> try_to_merge_two_pages() merges two pages, one of them
> is a page of currently scanned mm, the second is a page
> with identical hash from unstable tree. Currently, we
> merge the page from unstable tree into the first one,
> and then free it.
> 
> The idea of this patch is to prefer freeing that page
> of them, which has a free neighbour (i.e., neighbour
> with zero page_count()). This allows buddy allocator
> to assemble at least 1-order set from the freed page
> and its neighbour; this is a kind of cheep passive
> compaction.
> 
> AFAIK, 1-order pages set consists of pages with PFNs
> [2n, 2n+1] (odd, even), so the neighbour's pfn is
> calculated via XOR with 1. We check the result pfn
> is valid and its page_count(), and prefer merging
> into @tree_page if neighbour's usage count is zero.
> 
> There a is small difference with current behavior
> in case of error path. In case of the second
> try_to_merge_with_ksm_page() is failed, we return
> from try_to_merge_two_pages() with @tree_page
> removed from unstable tree. It does not seem to matter,
> but if we do not want a change at all, it's not
> a problem to move remove_rmap_item_from_tree() from
> try_to_merge_with_ksm_page() to its callers.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/ksm.c |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 5b0894b45ee5..005508c86d0a 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1321,6 +1321,22 @@ static struct page
> *try_to_merge_two_pages(struct rmap_item *rmap_item, {
>  	int err;
> 
> +	if (IS_ENABLED(CONFIG_COMPACTION)) {
> +		unsigned long pfn;
> +
> +		/*
> +		 * Find neighbour of @page containing 1-order pair
> +		 * in buddy-allocator and check whether it is free.
> +		 * If it is so, try to use @tree_page as ksm page
> +		 * and to free @page.
> +		 */
> +		pfn = page_to_pfn(page) ^ 1;
> +		if (pfn_valid(pfn) && page_count(pfn_to_page(pfn))
> == 0) {
> +			swap(rmap_item, tree_rmap_item);
> +			swap(page, tree_page);
> +		}
> +	}
> +
>  	err = try_to_merge_with_ksm_page(rmap_item, page, NULL);
>  	if (!err) {
>  		err = try_to_merge_with_ksm_page(tree_rmap_item,
> 

