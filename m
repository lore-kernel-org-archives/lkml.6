Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C71C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0522E20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOdBfnnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0522E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeHaNeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:34:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39125 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeHaNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:34:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so5257792pff.6;
        Fri, 31 Aug 2018 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qTV40n+rSYlZyKHa6yjFuqHKCcM4VlQPYrEWY2e6GHQ=;
        b=MOdBfnnwLCAK+gpmfO8QeGMzuci1jLfKpGvKrvKh90uZVwcRbxuzhd5J6gL/t++v6R
         pboQwsUHgCVeqF4UboAnQtMypjI7dd8FZZCxdexmKzNZcVh7RobewRHbdQb5U484TEad
         oZJmKS/5HOcgz0WbtieLGHnQU1nXiCDX2N5VnndoBstH92fwxZN3+I9KFzncufgzepg2
         x/p/L9SAHSDmzUDnT/EkslAS62ysGgdxqQWxzO8aTmsTIOWp14tolY3jX55cAHwHBD34
         zNO5oLSeMkVhkHw6yFYvD3PDOQtz8P10y0iYGrQpocn+9Imr8KolAwQ8zf4tzSAHgrXg
         zv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qTV40n+rSYlZyKHa6yjFuqHKCcM4VlQPYrEWY2e6GHQ=;
        b=k2metH63uRfuipV/MMuCYs54+12nukrpkgZ0pa69kZlaTWi9zO+XLcYmCIUyqlrbQe
         itS6cL+crOLCXn99G/6g6qolBeZd4LrWnFLCvXFAHg31XXyGCeWh7XBu+OQ3OG2IIONN
         iD/Nty/Ab5opyVkkpASl540Pm3HLLswsjJyq+KjFYsxrHrpMHE4fgpwULsm1iqVM6AUO
         3u2LkwRPc35mM32+ooV0MJu1fvjc7zvvh2grrK6PC3pkZe0w/jGLyJYYQCSDp0X8c+As
         d1cZH0mUa6UfFYxXgLrCMXQMc/0GpNPM8pC8ZyehOkg84Y2e1Zah7fFsxIoxI4x7vkm2
         gdtw==
X-Gm-Message-State: APzg51CZkXhiqPbuhmNRPrmX7m7gLappWUkRXbslo4WQa9ycohjBfpIe
        nYjQgIVw3r1S8RDU7ycscw+LmXpSpFE=
X-Google-Smtp-Source: ANB0Vdb0n5Tv4Hqonq3jiEYy2+qsHxD9UJDnHcYDkgnF355LIfEFRGwtDr2jfNvz4yEz0im52EgBBA==
X-Received: by 2002:a63:9a42:: with SMTP id e2-v6mr13886511pgo.263.1535707649879;
        Fri, 31 Aug 2018 02:27:29 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id s14-v6sm20244808pfj.105.2018.08.31.02.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 02:27:28 -0700 (PDT)
Date:   Fri, 31 Aug 2018 19:27:24 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/rmap: map_pte() was not handling private
 ZONE_DEVICE page properly v2
Message-ID: <20180831092724.GD28695@350D>
References: <20180824192549.30844-3-jglisse@redhat.com>
 <20180830144156.7226-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830144156.7226-1-jglisse@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:41:56AM -0400, jglisse@redhat.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> Private ZONE_DEVICE pages use a special pte entry and thus are not
> present. Properly handle this case in map_pte(), it is already handled
> in check_pte(), the map_pte() part was lost in some rebase most probably.
> 
> Without this patch the slow migration path can not migrate back private
> ZONE_DEVICE memory to regular memory. This was found after stress
> testing migration back to system memory. This ultimatly can lead the
> CPU to an infinite page fault loop on the special swap entry.
> 
> Changes since v1:
>     - properly lock pte directory in map_pte()
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/page_vma_mapped.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index ae3c2a35d61b..bd67e23dce33 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -21,7 +21,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
>  			if (!is_swap_pte(*pvmw->pte))
>  				return false;
>  		} else {
> -			if (!pte_present(*pvmw->pte))
> +			if (is_swap_pte(*pvmw->pte)) {
> +				swp_entry_t entry;
> +
> +				/* Handle un-addressable ZONE_DEVICE memory */
> +				entry = pte_to_swp_entry(*pvmw->pte);
> +				if (!is_device_private_entry(entry))
> +					return false;

OK, so we skip this pte from unmap since it's already unmapped? This prevents
try_to_unmap from unmapping it and it gets restored with MIGRATE_PFN_MIGRATE
flag cleared?

Sounds like the right thing, if I understand it correctly

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.
