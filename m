Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeEGH7Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:59:25 -0400
Received: from 8bytes.org ([81.169.241.247]:58644 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751940AbeEGH7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:59:22 -0400
Date: Mon, 7 May 2018 09:59:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Message-ID: <20180507075920.GA18595@8bytes.org>
References: <cover.1523304324.git.digetx@gmail.com>
 <f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
 <20180427100202.GO30388@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427100202.GO30388@ulmo>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 12:02:02PM +0200, Thierry Reding wrote:
> Joerg, I've gone over the git log and header files and I see no mention
> of why the TLB flush interface isn't used for mapping. Do you recall any
> special reasons why the same shouldn't be applied for mapping? Would you
> accept any patches doing this?

Yeah, the reason was that we assumed that only emulated IOMMUs ever need
flushing in the mapping path, and there is no reason to optimize for
that. Especially when a call to iotlb_sync() in the mapping path would
hurt most other users.

Does the tegra-gart actually need it too?



	Joerg
