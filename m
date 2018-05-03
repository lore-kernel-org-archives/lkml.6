Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbeECQaj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:30:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:21599 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751419AbeECQaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:30:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="225557884"
Date: Thu, 3 May 2018 22:05:22 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Frank Mori Hess <fmh6jj@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        r.baldyga@hackerion.com
Subject: Re: [PATCH] Revert "dmaengine: pl330: add DMA_PAUSE feature"
Message-ID: <20180503163521.GZ6014@localhost>
References: <2484918.HKVQc3yJkt@bear>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2484918.HKVQc3yJkt@bear>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 05:50:58PM -0400, Frank Mori Hess wrote:
> This reverts commit 88987d2c7534a0269f567fb101e6d71a08f0f01d.
> 
> The pl330.c pause implementation violates the dmaengine requirement
> for no data loss, since it relies on the DMAKILL
> instruction.  However, DMAKILL discards in-flight data from the
> dma controller's fifo.  This is documented in the dma-330 manual
> and I have observed it with hardware doing device-to-memory burst
> transfers.  The discarded data may or may not show up in the
> residue count, depending on timing (resulting in data corruption
> effectively).


Applied, thanks

-- 
~Vinod
