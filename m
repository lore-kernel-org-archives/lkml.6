Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeECN5K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:57:10 -0400
Received: from 8bytes.org ([81.169.241.247]:55262 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbeECN5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:57:09 -0400
Date: Thu, 3 May 2018 15:57:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/amd - Update the PASID information printed to
 the system log
Message-ID: <20180503135706.nypxlwlt7jhqhhum@8bytes.org>
References: <152520429853.30928.9793486018349326103.stgit@taos>
 <152520437211.30928.8410126837908568791.stgit@taos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152520437211.30928.8410126837908568791.stgit@taos>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 02:52:52PM -0500, Gary R Hook wrote:
> @@ -567,7 +567,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  	}
>  
>  	if (type == EVENT_TYPE_IO_FAULT) {
> -		amd_iommu_report_page_fault(devid, domid, address, flags);
> +		amd_iommu_report_page_fault(devid, pasid, address, flags);

According to the spec this could be a domid or a pasid, it would be good
to make that visible in the error message, depending on the value of the
GN flag in the event entry.

But that can be done in a separate patch, I applied these two, thanks.
