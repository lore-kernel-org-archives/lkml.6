Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965542AbeBMSdR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:33:17 -0500
Received: from 8bytes.org ([81.169.241.247]:43064 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965344AbeBMSdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:33:16 -0500
Date: Tue, 13 Feb 2018 19:33:14 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de, alex.williamson@redhat.com
Subject: Re: [PATCH] iommu: Do not return error code for APIs with size_t
 return type
Message-ID: <20180213183313.cu7nsjauuhvorzg2@8bytes.org>
References: <1517827553-81034-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517827553-81034-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 05:45:53AM -0500, Suravee Suthikulpanit wrote:
> Currently, iommu_unmap, iommu_unmap_fast and iommu_map_sg return
> size_t.  However, some of the return values are error codes (< 0),
> which can be misinterpreted as large size. Therefore, returning size 0
> instead to signify failure to map/unmap.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> 
> Note: This issue was previously discussed here (https://lkml.org/lkml/2018/1/30/873).
> 
>  drivers/iommu/amd_iommu.c |  2 +-
>  drivers/iommu/iommu.c     |  6 +++---
>  include/linux/iommu.h     | 14 +++++++-------
>  3 files changed, 11 insertions(+), 11 deletions(-)

Yeah, I am not happy with this, but the alternatives aren't any
better... So I applied this one. Thanks!


	Joerg
