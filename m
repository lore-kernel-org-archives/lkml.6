Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6420C04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65D12075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65D12075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeKTTNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:13:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbeKTTNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:13:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B915D811D3;
        Tue, 20 Nov 2018 08:45:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85CDF608C4;
        Tue, 20 Nov 2018 08:45:33 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 439FE1800533;
        Tue, 20 Nov 2018 08:45:33 +0000 (UTC)
Date:   Tue, 20 Nov 2018 03:45:32 -0500 (EST)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devel@linuxdriverproject.org,
        linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Kairui Song <kasong@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1747228.35250472.1542703532881.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181119101616.8901-6-david@redhat.com>
References: <20181119101616.8901-1-david@redhat.com> <20181119101616.8901-6-david@redhat.com>
Subject: Re: [PATCH v1 5/8] hv_balloon: mark inflated pages PG_offline
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.119, 10.4.195.20]
Thread-Topic: hv_balloon: mark inflated pages PG_offline
Thread-Index: WULPe0NX2lje8pHd8lwBzyMbSeWoFw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 20 Nov 2018 08:45:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

> 
> Mark inflated and never onlined pages PG_offline, to tell the world that
> the content is stale and should not be dumped.
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Kairui Song <kasong@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/hv/hv_balloon.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 211f3fe3a038..47719862e57f 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -681,8 +681,13 @@ static struct notifier_block hv_memory_nb = {
>  /* Check if the particular page is backed and can be onlined and online it.
>  */
>  static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
>  {
> -	if (!has_pfn_is_backed(has, page_to_pfn(pg)))
> +	if (!has_pfn_is_backed(has, page_to_pfn(pg))) {
> +		if (!PageOffline(pg))
> +			__SetPageOffline(pg);
>  		return;
> +	}
> +	if (PageOffline(pg))
> +		__ClearPageOffline(pg);
>  
>  	/* This frame is currently backed; online the page. */
>  	__online_page_set_limits(pg);
> @@ -1201,6 +1206,7 @@ static void free_balloon_pages(struct hv_dynmem_device
> *dm,
>  
>  	for (i = 0; i < num_pages; i++) {
>  		pg = pfn_to_page(i + start_frame);
> +		__ClearPageOffline(pg);

Just thinking, do we need to care for clearing PageOffline flag before freeing
a balloon'd page?

Thanks,
Pankaj

>  		__free_page(pg);
>  		dm->num_pages_ballooned--;
>  	}
> @@ -1213,7 +1219,7 @@ static unsigned int alloc_balloon_pages(struct
> hv_dynmem_device *dm,
>  					struct dm_balloon_response *bl_resp,
>  					int alloc_unit)
>  {
> -	unsigned int i = 0;
> +	unsigned int i, j;
>  	struct page *pg;
>  
>  	if (num_pages < alloc_unit)
> @@ -1245,6 +1251,10 @@ static unsigned int alloc_balloon_pages(struct
> hv_dynmem_device *dm,
>  		if (alloc_unit != 1)
>  			split_page(pg, get_order(alloc_unit << PAGE_SHIFT));
>  
> +		/* mark all pages offline */
> +		for (j = 0; j < (1 << get_order(alloc_unit << PAGE_SHIFT)); j++)
> +			__SetPageOffline(pg + j);
> +
>  		bl_resp->range_count++;
>  		bl_resp->range_array[i].finfo.start_page =
>  			page_to_pfn(pg);
> --
> 2.17.2
> 
> 
