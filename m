Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966578AbeEJQ6w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:58:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:6338 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966305AbeEJQ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:58:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
   d="scan'208";a="44880216"
Date: Thu, 10 May 2018 11:00:39 -0600
From: Keith Busch <keith.busch@intel.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-nvme@lists.infradead.org, alex_gagniuc@dellteam.com,
        Austin.Bolen@dell.com, Shyam.Iyer@dell.com, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid use of goto in nvme_reset_work()
Message-ID: <20180510170038.GA4556@localhost.localdomain>
References: <20180510164645.19559-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510164645.19559-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 11:46:33AM -0500, Alexandru Gagniuc wrote:
> This patch started as a challenge from Keith relating to code
> structuring with goto vs return. I think the final result improves
> readability on two counts:
> First, it clarifies the separation between work struct and nvme_dev.
> Second, it makes it clearer what error is being passed on:
> 'return -ENODEV' vs 'goto out', where 'result' happens to be -ENODEV
> 
> CC: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Ah, that's just wrapping a function that has a single out. The challenge
is to find a better mechanism than 'goto' to unwind a failure that has
multiple outs, like nvme_probe().
