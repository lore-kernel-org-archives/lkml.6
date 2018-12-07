Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C06C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBCE20700
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="glwMdhZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBCE20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLGDaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:30:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGDa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 22:30:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so1067235pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 19:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hpNQ2iOCkUhflXr3maJR4vnVkMbwllAH+QRJ/N70D7c=;
        b=glwMdhZOqx9sHbb5ux1RoaJMM1BzfpIWq7L6wTDMlfE+jFwz28SCqgAIbCZimjg95Q
         B0BVHMh9a/rtiBgTP301KmfhECks/2Tir2aj2+ChdH3eF99XNqm3pMO7E8ZFEvnga6q7
         Q3b8nopwrX7770EIBo/nKOL7rN8O/NJQTgfVhlEK6pJ3lAkJE/zcBht5Y5nSCUle9eGb
         Uqdkk0FeESe/nx3bike1LzFUQ/MZCxy2TXaJK6DRKksm434TlIARCX9xBnwJ76Q3jMIT
         pdki+hslgnPyj9AzmDSK4uvCdNwAjJortmVSbOrpEh7Egd9vDKgBf+jdGpWz+7nfZJXg
         yoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hpNQ2iOCkUhflXr3maJR4vnVkMbwllAH+QRJ/N70D7c=;
        b=YfKuWaWGhtR8gCEn96kZ50LIy0O9t2iScjyTVTz7SFCGl+SK8D+UGVUZUK+v0EapfH
         HVzjqQYL5Wf/Bfptvw5AyXGpx6Y+CQ4FA5l1+QA9GB9nZZiZJnhq8rK51Uwf4Vd9rBbq
         nlM+d9AB1w3qVbPsxuZsc+yubwEzDF7FCLyh3tXvJjqJGftMPR772tt351ELwCvVILL+
         QDA0Omk93d0XhrDMdZxH0OxEfDmN+Pxh21X/1lRRig3eZgGB0G7kmjKNc7rNanMupbKD
         rknDHS4t0EUbRALnzNhSi0wpPQA9tGRBYHoZ/oOs54rKORSU/WD8nCXUfvHyJQg/o5gv
         Ow5g==
X-Gm-Message-State: AA+aEWbJXo47YMHK0xMRqcajgD1ljX4i9V2V3SRnl3CwZoDDh+yemoUR
        EnNm/3TCX3+2PwOjdSus+gwoIw==
X-Google-Smtp-Source: AFSGD/XdhNocVzFs6+8gPW2HnEWvT/c9mxKwMTjtQy1jh0xs22PMznADzNTJrHLF92Kzkcq9MTnknA==
X-Received: by 2002:a62:1043:: with SMTP id y64mr659005pfi.78.1544153428979;
        Thu, 06 Dec 2018 19:30:28 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id s9sm1800591pgl.88.2018.12.06.19.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 19:30:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gV6qR-000736-AC; Thu, 06 Dec 2018 20:30:27 -0700
Date:   Thu, 6 Dec 2018 20:30:27 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <zwisler@kernel.org>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/mmu_notifier: use structure for
 invalidate_range_start/end callback
Message-ID: <20181207033027.GA20236@ziepe.ca>
References: <20181205053628.3210-1-jglisse@redhat.com>
 <20181205053628.3210-2-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205053628.3210-2-jglisse@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 12:36:26AM -0500, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> To avoid having to change many callback definition everytime we want
> to add a parameter use a structure to group all parameters for the
> mmu_notifier invalidate_range_start/end callback. No functional changes
> with this patch.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: kvm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 43 +++++++++++--------------
>  drivers/gpu/drm/i915/i915_gem_userptr.c | 14 ++++----
>  drivers/gpu/drm/radeon/radeon_mn.c      | 16 ++++-----
>  drivers/infiniband/core/umem_odp.c      | 20 +++++-------
>  drivers/infiniband/hw/hfi1/mmu_rb.c     | 13 +++-----
>  drivers/misc/mic/scif/scif_dma.c        | 11 ++-----
>  drivers/misc/sgi-gru/grutlbpurge.c      | 14 ++++----
>  drivers/xen/gntdev.c                    | 12 +++----
>  include/linux/mmu_notifier.h            | 14 +++++---
>  mm/hmm.c                                | 23 ++++++-------
>  mm/mmu_notifier.c                       | 21 ++++++++++--
>  virt/kvm/kvm_main.c                     | 14 +++-----
>  12 files changed, 102 insertions(+), 113 deletions(-)

The changes to drivers/infiniband look mechanical and fine to me.

It even looks like this avoids merge conflicts with the other changes
to these files :)

For infiniband:

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

I assume this will go through the mm tree?

Jason
