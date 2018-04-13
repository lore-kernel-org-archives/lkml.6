Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753623AbeDMDew (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 23:34:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:65378 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753469AbeDMDeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 23:34:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,444,1517904000";
   d="scan'208";a="191147358"
Date: Fri, 13 Apr 2018 09:09:18 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
Message-ID: <20180413033917.GH6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
 <20180411093634.GC6014@localhost>
 <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
 <20180412093735.GF6014@localhost>
 <CAMz4ku+i+zA0_5U65vc3h3tO-hzWvtCOFDeFU94h3Rm6sJUuKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4ku+i+zA0_5U65vc3h3tO-hzWvtCOFDeFU94h3Rm6sJUuKQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 07:30:01PM +0800, Baolin Wang wrote:

> >> > what does block and transaction len refer to here
> >>
> >>  Our DMA has 3 transfer mode: transaction transfer, block transfer and
> >> fragment transfer. One transaction transfer can contain several blocks
> >> transfer, and each block can be set proper block step. One block can
> >> contain several fragments transfer with proper fragment step. It can
> >> generate interrupts when one transaction transfer or block transfer or
> >> fragment transfer is completed if user set the interrupt type. So here
> >> we should set the length for transaction transfer, block transfer and
> >> fragment transfer.
> >
> > what are the max size these types support?
> 
> These types max size definition:
> 
> #define SPRD_DMA_FRG_LEN_MASK GENMASK(16, 0)
> 
> #define SPRD_DMA_BLK_LEN_MASK GENMASK(16, 0)
> 
> #define SPRD_DMA_TRSC_LEN_MASK GENMASK(27, 0)

They are register defines. How many items or bytes do each type of txn
support?

-- 
~Vinod
