Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031678AbeCAPDs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:03:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031664AbeCAPDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:03:46 -0500
Date: Thu, 1 Mar 2018 23:03:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
Message-ID: <20180301150329.GB6795@ming.t460p>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228164726.GB16536@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 05:47:26PM +0100, Christoph Hellwig wrote:
> Note that we originally allocates irqs this way, and Keith changed
> it a while ago for good reasons.  So I'd really like to see good
> reasons for moving away from this, and some heuristics to figure
> out which way to use.  E.g. if the device supports more irqs than
> I/O queues your scheme might always be fine.

If all CPUs for the 1st IRQ vector of admin queue are offline, then I
guess NVMe can't work any more.

So looks it is a good idea to make admin queue's IRQ vector assigned as
non-managed IRQs.

Thanks,
Ming
