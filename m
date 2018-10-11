Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65905C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241F120841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="V1yDxPZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241F120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJLG2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:28:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40505 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJLG2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:28:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id j68-v6so8443096oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 15:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJtgrdMIt5B2S4XIKnBe78Xf+qAbX4YZNj+zjUvyTzY=;
        b=V1yDxPZifZoR4YpF8N76DPyB5pYl931k7yBEW2N5VJHaNakxNoarE5vz3ZTGO5Y9F7
         mesy1HC2cwnk8a8toptvxnWX/nwrEpATMUV/8w4WeMIlg4tblnh2iGCty5ZENYbeMV0f
         iZwIohj6rS6Cv7+Y/PYQVVjybvTQDfISJsV3zIDy10s6KEk2U81u4t5AO8VMRjHsqmqW
         HlYsboLhQWqgvcwuAbf0OS88NlHbnX0pKp0oLp+ylt+i+loL4KVpqI9BhaSDPC0a4C8w
         vw9Y+39jNml3QAXM+5ocASEDKpBFopjV9cqUcyA+dUMVbOXFcKRV6DE+4uFBizH/vglM
         pUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJtgrdMIt5B2S4XIKnBe78Xf+qAbX4YZNj+zjUvyTzY=;
        b=HHbcyU2rJpOJlGVyzBahC4RHpxRwg2qzWjaX4vxAjCBsw9hMEG0o26fwelvMtxHxWm
         IbOe9g8nvQi0JCx5qqlTcYrqwVOfhYioe5x+p6eNIxTmxfhsZeMMEGnqoiT+ksphHIk8
         RnZKG9riWSu1BMu8cCHSUFxv5bBukTwQtaLQyNL+SVC7/SciKL0Eu8gEY68vNvTmINXW
         huGhJTc8FLJ6ay8zI3Qww7rSLZtc3QFapek5pyIULQ8mfg1qqix1+8XTW7wZ2xuJkRzP
         qRaG5Se2seHM416OQlfsY0HeeByltrzw2oYS0C+wjge37yEaEJa1DHxO4BmRSsHJNSrg
         wLUQ==
X-Gm-Message-State: ABuFfohyhaHXR6Whjk7QI+GZDgylIViAWZWB9n1WmRE31u46daeWyNzj
        2wCdoFDqXktf5nZeak8TyOAmMiykQto6+kepCu+xZQ==
X-Google-Smtp-Source: ACcGV63HX51w3QoxJEG3W0rJHM+nxxlhM8CYVe3Zte57aG3Vet2yvH/CO/dMaEw7bqVfV7RhQubceIsXOwM5EY2crU8=
X-Received: by 2002:aca:f512:: with SMTP id t18-v6mr2059647oih.244.1539298722948;
 Thu, 11 Oct 2018 15:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181011221237.1925.85591.stgit@localhost.localdomain> <20181011221351.1925.67694.stgit@localhost.localdomain>
In-Reply-To: <20181011221351.1925.67694.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Oct 2018 15:58:31 -0700
Message-ID: <CAPcyv4gw4YRJXZrXHunKwqbhXPekiNU6jsYkrpoBtznv0Py-sg@mail.gmail.com>
Subject: Re: [mm PATCH v2 4/6] mm: Do not set reserved flag for hotplug memory
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Miller <davem@davemloft.net>,
        Zhang Yi <yi.z.zhang@linux.intel.com>, khalid.aziz@oracle.com,
        rppt@linux.vnet.ibm.com, Vlastimil Babka <vbabka@suse.cz>,
        sparclinux@vger.kernel.org,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 3:18 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> The general suspicion at this point is that the setting of the reserved bit
> is not really needed for hotplug memory. In addition the setting of this
> bit results in issues for DAX in that it is not possible to assign the
> region to KVM if the reserved bit is set in each page.
>
> For now we can try just not setting the bit since we suspect it isn't
> adding value in setting it. If at a later time we find that it is needed we
> can come back through and re-add it for the hotplug paths.
>
> Suggested-by: Michael Hocko <mhocko@suse.com>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  mm/page_alloc.c |   11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3603d5444865..e435223e2ddb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5571,8 +5571,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>
>                 page = pfn_to_page(pfn);
>                 __init_single_page(page, pfn, zone, nid);
> -               if (context == MEMMAP_HOTPLUG)
> -                       __SetPageReserved(page);

At a minimum I think we need to do this before removing PageReserved,
to make sure zone_device pages are not tracked in the hibernation
image.

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 3d37c279c090..c0613137d726 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1285,6 +1285,9 @@ static struct page *saveable_page(struct zone
*zone, unsigned long pfn)
        if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
                return NULL;

+       if (is_zone_device_page(page))
+               return NULL;
+
        if (PageReserved(page)
            && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
                return NULL;
