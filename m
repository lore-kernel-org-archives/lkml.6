Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeEKGdl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 02:33:41 -0400
Received: from verein.lst.de ([213.95.11.211]:51287 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeEKGdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 02:33:40 -0400
Date: Fri, 11 May 2018 08:37:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-nvme@lists.infradead.org, alex_gagniuc@dellteam.com,
        Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Avoid use of goto in nvme_reset_work()
Message-ID: <20180511063724.GA8368@lst.de>
References: <20180510164645.19559-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510164645.19559-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

I think this actually makes the code much less readable.  The only real
improvement the code needs is to replace the "out" label name with
something more descriptive like "remove_controller".
