Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeDJDDu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 23:03:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56378 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeDJDDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 23:03:49 -0400
Subject: Re: [PATCH v3 3/3] mm: restructure memfd code
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180409230505.18953-1-mike.kravetz@oracle.com>
 <20180409230505.18953-4-mike.kravetz@oracle.com>
 <20180410014153.GB31282@bombadil.infradead.org>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d5bfc82f-9331-fc0d-abbf-acc0a80b2c4c@oracle.com>
Date: Mon, 9 Apr 2018 20:03:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180410014153.GB31282@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=772
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100030
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 06:41 PM, Matthew Wilcox wrote:
> On Mon, Apr 09, 2018 at 04:05:05PM -0700, Mike Kravetz wrote:
>> +/*
>> + * We need a tag: a new tag would expand every radix_tree_node by 8 bytes,
>> + * so reuse a tag which we firmly believe is never set or cleared on shmem.
>> + */
>> +#define SHMEM_TAG_PINNED        PAGECACHE_TAG_TOWRITE
> 
> Do we also firmly believe it's never used on hugetlbfs?
> 

Yes.  hugetlbfs is memory resident only with no writeback.
This comment and name should have been updated when hugetlbfs support was
added.

Also, ideally all the memfd related function names of the form shmem_* should
have been changed to memfd_* when hugetlbfs support was added.  Some of them
were changed, but not all.

I can clean all this up.  But, I would want to do it in patch 2 of the series.
That is where other cleanup such as this was done before code movement.

Will wait a little while for any additional comments before sending series
again.
-- 
Mike Kravetz
