Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeBEFey (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 00:34:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:6032 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbeBEFer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 00:34:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,463,1511856000";
   d="scan'208";a="27299684"
Date: Mon, 5 Feb 2018 11:09:25 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Zi Yan <zi.yan@sent.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] dmaengine: avoid map_cnt overflow with
 CONFIG_DMA_ENGINE_RAID
Message-ID: <20180205053925.GQ18649@localhost>
References: <20180108155050.7387-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108155050.7387-1-zi.yan@sent.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2018 at 10:50:50AM -0500, Zi Yan wrote:
> From: Zi Yan <zi.yan@cs.rutgers.edu>
> 
> When CONFIG_DMA_ENGINE_RAID is enabled, unmap pool size can reach to
> 256. But in struct dmaengine_unmap_data, map_cnt is only u8, wrapping
> to 0, if the unmap pool is maximally used. This triggers BUG() when
> struct dmaengine_unmap_data is freed. Use u16 to fix the problem.

Applied, thanks

-- 
~Vinod
