Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeCFLsD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:48:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:12543 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeCFLsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:48:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="22923714"
Date: Tue, 6 Mar 2018 17:21:54 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Qi Hou <qi.hou@windriver.com>
Cc: dan.j.williams@intel.com, fmh6jj@gmail.com,
        fmhess@users.sourceforge.net, jassisinghbrar@gmail.com,
        rmk+kernel@arm.linux.org.uk, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: fix a race condition in case of
 threaded irqs
Message-ID: <20180306115153.GS15443@localhost>
References: <1520298817-19870-1-git-send-email-qi.hou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520298817-19870-1-git-send-email-qi.hou@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 09:13:37AM +0800, Qi Hou wrote:
> When booting up with "threadirqs" in command line, all irq handlers of the DMA
> controller pl330 will be threaded forcedly. These threads will race for the same
> list, pl330->req_done.
> 
> Before the callback, the spinlock was released. And after it, the spinlock was
> taken. This opened an race window where another threaded irq handler could steal
> the spinlock and be permitted to delete entries of the list, pl330->req_done.
> 
> If the later deleted an entry that was still referred to by the former, there would
> be a kernel panic when the former was scheduled and tried to get the next sibling
> of the deleted entry.

Applied, thanks

-- 
~Vinod
