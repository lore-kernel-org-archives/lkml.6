Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966390AbeBNBMl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:12:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49342 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:12:38 -0500
Subject: Re: [patch -mm] mm, page_alloc: extend kernelcore and movablecore for
 percent fix
To: David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
 <a064d937-5746-3e14-bb63-5ff9d845a428@oracle.com>
 <alpine.DEB.2.10.1802131651140.69963@chino.kir.corp.google.com>
 <alpine.DEB.2.10.1802131700160.71590@chino.kir.corp.google.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <21f97b8f-993a-dcff-c72a-1dad2d5c9c4f@oracle.com>
Date: Tue, 13 Feb 2018 17:10:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802131700160.71590@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140009
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 05:00 PM, David Rientjes wrote:
> Specify that movablecore= can use a percent value.
> 
> Remove comment about hugetlb pages not being movable per Mike.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: David Rientjes <rientjes@google.com>

Thanks!  FWIW,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
And, that is for all of patch 1.
-- 
Mike Kravetz

> ---
>  .../admin-guide/kernel-parameters.txt         | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1837,10 +1837,9 @@
>  
>  			ZONE_MOVABLE is used for the allocation of pages that
>  			may be reclaimed or moved by the page migration
> -			subsystem.  This means that HugeTLB pages may not be
> -			allocated from this zone.  Note that allocations like
> -			PTEs-from-HighMem still use the HighMem zone if it
> -			exists, and the Normal zone if it does not.
> +			subsystem.  Note that allocations like PTEs-from-HighMem
> +			still use the HighMem zone if it exists, and the Normal
> +			zone if it does not.
>  
>  			It is possible to specify the exact amount of memory in
>  			the form of "nn[KMGTPE]", a percentage of total system
> @@ -2353,13 +2352,14 @@
>  	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
>  			reporting absolute coordinates, such as tablets
>  
> -	movablecore=nn[KMG]	[KNL,X86,IA-64,PPC] This parameter
> -			is similar to kernelcore except it specifies the
> -			amount of memory used for migratable allocations.
> -			If both kernelcore and movablecore is specified,
> -			then kernelcore will be at *least* the specified
> -			value but may be more. If movablecore on its own
> -			is specified, the administrator must be careful
> +	movablecore=	[KNL,X86,IA-64,PPC]
> +			Format: nn[KMGTPE] | nn%
> +			This parameter is the complement to kernelcore=, it
> +			specifies the amount of memory used for migratable
> +			allocations.  If both kernelcore and movablecore is
> +			specified, then kernelcore will be at *least* the
> +			specified value but may be more.  If movablecore on its
> +			own is specified, the administrator must be careful
>  			that the amount of memory usable for all allocations
>  			is not too small.
>  
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
