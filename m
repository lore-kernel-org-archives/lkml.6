Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754896AbeDWLoc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:44:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754710AbeDWLoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:44:24 -0400
Date: Mon, 23 Apr 2018 13:44:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com
Subject: Re: [PATCH v2 2/5] vfio: ccw: shorten kernel doc description for
 pfn_array_pin()
Message-ID: <20180423134419.630e7606.cohuck@redhat.com>
In-Reply-To: <20180423110113.59385-3-bjsdjshi@linux.vnet.ibm.com>
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
        <20180423110113.59385-3-bjsdjshi@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 13:01:10 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> The kernel doc description for usage of the struct pfn_array in
> pfn_array_pin() is unnecessary long. Let's shorten it by describing
> the contents of the struct pfn_array fields at the struct's definition
> instead.
> 
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 62d66e195304..e8fe7450702e 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -23,9 +23,13 @@
>  #define CCWCHAIN_LEN_MAX	256
>  
>  struct pfn_array {
> +	/* Starting guest physical I/O address. */
>  	unsigned long		pa_iova;
> +	/* Array that stores PFNs of the pages need to pin. */

s/need to pin/needing to be pinned/ ? Or "we need to pin"? Or even
simply "to pin"?

(Pre-exiting, but we can as well fix it up. Can also do while applying.)

>  	unsigned long		*pa_iova_pfn;
> +	/* Array that receives PFNs of the pages pinned. */
>  	unsigned long		*pa_pfn;
> +	/* Number of pages to pin/pinned from @pa_iova. */
>  	int			pa_nr;
>  };
>  
> @@ -53,14 +57,8 @@ struct ccwchain {
>   * Attempt to pin user pages in memory.
>   *
>   * Usage of pfn_array:
> - * @pa->pa_iova     starting guest physical I/O address. Assigned by caller.
> - * @pa->pa_iova_pfn array that stores PFNs of the pages need to pin. Allocated
> - *                  by caller.
> - * @pa->pa_pfn      array that receives PFNs of the pages pinned. Allocated by
> - *                  caller.
> - * @pa->pa_nr       number of pages from @pa->pa_iova to pin. Assigned by
> - *                  caller.
> - *                  number of pages pinned. Assigned by callee.
> + * Any field in this structure should be initialized by caller.
> + * We expect @pa->pa_nr > 0, and its value will be assigned by callee.
>   *
>   * Returns:
>   *   Number of pages pinned on success.

Otherwise, looks good.
