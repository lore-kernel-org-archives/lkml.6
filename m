Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965252AbeBMQoX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:44:23 -0500
Received: from 8bytes.org ([81.169.241.247]:41470 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934828AbeBMQoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:44:21 -0500
Date: Tue, 13 Feb 2018 17:44:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCHv2 0/6] iommu/intel: Handle DMAR faults in a wq
Message-ID: <20180213164418.x7pcjaveorx24rgz@8bytes.org>
References: <20180212164825.22421-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212164825.22421-1-dima@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Feb 12, 2018 at 04:48:19PM +0000, Dmitry Safonov wrote:
> Dmitry Safonov (6):
>   iommu/intel: Add __init for dmar_register_bus_notifier()
>   iommu/intel: Clean/document fault status flags
>   iommu/intel: Introduce clear_primary_faults() helper
>   iommu/intel: Handle DMAR faults on workqueue
>   iommu/intel: Rename dmar_fault() => dmar_serve_faults()
>   iommu/intel: Ratelimit each dmar fault printing

I applied patches 1 and 2 because they are nice cleanups, thanks. For
the rest, I am not convinced that work-queues are a good solution for
the soft lockups you are seeing. Please consider the approach I outlined
in my reply to patch 4.

Also, please prefix your next patches with 'iommu/vt-d' instead of
'iommu/intel'.

Thanks,

	Joerg
