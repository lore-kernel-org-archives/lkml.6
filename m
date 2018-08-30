Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B5BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5DD2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSYZczYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5DD2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeH3SIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:08:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32805 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbeH3SIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:08:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so3951722pfn.0;
        Thu, 30 Aug 2018 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fptreHptAAOohSZmFgomIuC4PZXLD7LeMRAOT0hZG/4=;
        b=qSYZczYdDY6y6fq9E7SBzY1NbQeTzxoVJOnCVCWf7RE0KIh4mEx+K8L8eZ7lxDBojA
         KyjrBVyvVi8M/JHsPyKcUKKSdzVOwniolCxt0T+fHFAbB1oBfGMSAyKf3bkhZoHQ6lqy
         Pu7Kr/YptYBynlTQ2WiAY8e3y5Nj/SdCo88qLAg/WrXg4j1U76ign7TDyMhvMNHuQHIf
         GYEZFvHTk+HOUpZSWbwMIJKAstxCJIs7Tcr2ZyjdOARHFiEePOU0p3V+KAmWmxgbF0Zq
         MtbnUidplDh2c6YhIqhAqHttiXUTePniGtcR79UslkY77bvdFW4t+Uciz0pIdNNzaROF
         Ec/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fptreHptAAOohSZmFgomIuC4PZXLD7LeMRAOT0hZG/4=;
        b=sTU5Okp298Ujm39BzbqiqXjUTEC6AC4TWTnv80/1ETnG05pmb8lwi9v93rms+iBqd5
         xrzhnfm4EP7MPgJQz+fG9al8hjpXT2tn8507+1jTVGrgZaL8sKYNDARVR+I2xJqTq51p
         socI6Ls5v9urMdh4pUUkCHAhCshIWGfkq1vsy/whOBoF2Lb+GTZIyDYGtRF6kkhk3DfB
         x/Ql0wiSACWIqumxti+N4MVt4tA8spFSN46gCsvXHCFS1f4Yq3/bQqLZjp0+OxUdvBD7
         MmB0EqKhBS/O6jDvTCyeDczqrdMfB7vD5Jw2M42JAq92fo/ZiZJDNY+hfKvI9Fo0COVL
         mOpA==
X-Gm-Message-State: APzg51DHByjreSeZptTNzwmaT7EqcyBnx4Cd7SJt+yYy0GUoLur1LL9m
        SCd7L+W2vcN/5rgMiV7ENvs=
X-Google-Smtp-Source: ANB0VdZthBDSk1b5hbz/ylW0QOLM+Xm12I1bUosVDw+fB8RNkqUrK0qIqiQJ8a4xnywKrrIPHz+1sg==
X-Received: by 2002:a63:dc17:: with SMTP id s23-v6mr10058330pgg.40.1535637942461;
        Thu, 30 Aug 2018 07:05:42 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id i20-v6sm9975345pfj.82.2018.08.30.07.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 07:05:41 -0700 (PDT)
Date:   Fri, 31 Aug 2018 00:05:38 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/7] mm/rmap: map_pte() was not handling private
 ZONE_DEVICE page properly
Message-ID: <20180830140538.GA28695@350D>
References: <20180824192549.30844-1-jglisse@redhat.com>
 <20180824192549.30844-3-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824192549.30844-3-jglisse@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:25:44PM -0400, jglisse@redhat.com wrote:
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
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/page_vma_mapped.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index ae3c2a35d61b..1cf5b9bfb559 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -21,6 +21,15 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
>  			if (!is_swap_pte(*pvmw->pte))
>  				return false;
>  		} else {
> +			if (is_swap_pte(*pvmw->pte)) {
> +				swp_entry_t entry;
> +
> +				/* Handle un-addressable ZONE_DEVICE memory */
> +				entry = pte_to_swp_entry(*pvmw->pte);
> +				if (is_device_private_entry(entry))
> +					return true;
> +			}
> +

This happens just for !PVMW_SYNC && PVMW_MIGRATION? I presume this
is triggered via the remove_migration_pte() code path? Doesn't
returning true here imply that we've taken the ptl lock for the
pvmw?

Balbir
