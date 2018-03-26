Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeCZDZn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 23:25:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:15734 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbeCZDZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 23:25:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,363,1517904000";
   d="scan'208";a="42130183"
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "huangzhichao@huawei.com" <huangzhichao@huawei.com>
Subject: RE: [PATCH v29 3/4] mm/page_poison: expose page_poisoning_enabled
 to kernel modules
Thread-Topic: [PATCH v29 3/4] mm/page_poison: expose page_poisoning_enabled
 to kernel modules
Thread-Index: AQHTxK5iK61oAF7ciky/ImA628viDaPh1G9A
Date: Mon, 26 Mar 2018 03:24:00 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739485741@shsmsx102.ccr.corp.intel.com>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
 <1522031994-7246-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1522031994-7246-4-git-send-email-wei.w.wang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjU5ZjdiODUtZmVlMS00Y2EyLWI2OWQtMjlhMGZkZjYwZmZhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImZOdk52YVR5SllKc25kbUJDUys4VytNaEJmOU5PXC82ZVVwVXVabDVIS3BjPSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 26, 2018 10:40 AM, Wang, Wei W wrote:
> Subject: [PATCH v29 3/4] mm/page_poison: expose page_poisoning_enabled
> to kernel modules
> 
> In some usages, e.g. virtio-balloon, a kernel module needs to know if page
> poisoning is in use. This patch exposes the page_poisoning_enabled function
> to kernel modules.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  mm/page_poison.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c index e83fd44..762b472
> 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -17,6 +17,11 @@ static int early_page_poison_param(char *buf)  }
> early_param("page_poison", early_page_poison_param);
> 
> +/**
> + * page_poisoning_enabled - check if page poisoning is enabled
> + *
> + * Return true if page poisoning is enabled, or false if not.
> + */
>  bool page_poisoning_enabled(void)
>  {
>  	/*
> @@ -29,6 +34,7 @@ bool page_poisoning_enabled(void)
> 
> 	(!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
>  		debug_pagealloc_enabled()));
>  }
> +EXPORT_SYMBOL_GPL(page_poisoning_enabled);
> 
>  static void poison_page(struct page *page)  {
> --
> 2.7.4


Could we get a review of this patch? We've reviewed other parts, and this one seems to be the last part of this feature. Thanks.

Best,
Wei
