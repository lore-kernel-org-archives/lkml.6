Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeCVFRo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 01:17:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:28737 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbeCVFRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 01:17:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,343,1517904000";
   d="scan'208";a="35832958"
Date: Thu, 22 Mar 2018 10:51:50 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: stm32-dmamux: fix a potential buffer
 overflow
Message-ID: <20180322052150.GB15443@localhost>
References: <1520960135-26575-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520960135-26575-1-git-send-email-pierre-yves.mordret@st.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 05:55:35PM +0100, Pierre-Yves MORDRET wrote:
> The bitfield dma_inuse is allocated of size dma_requests bits, thus a
> valid bit address is from 0 to (dma_requests - 1).
> When find_first_zero_bit() fails, it returns dma_requests as invalid
> address.
> Using such address for the following set_bit() is incorrect and, if
> dma_requests is a multiple of BITS_PER_LONG, it will cause a buffer
> overflow.
> Currently this driver is only used in DT stm32h743.dtsi where a safe value
> dma_requests=16 is not triggering the buffer overflow.
> 
> Fixed by checking the return value of find_first_zero_bit() _before_
> using it.

Applied, thanks

-- 
~Vinod
