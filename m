Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935053AbeCHHmW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 02:42:22 -0500
Received: from verein.lst.de ([213.95.11.211]:33799 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbeCHHmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 02:42:21 -0500
Date: Thu, 8 Mar 2018 08:42:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq
        and ioq0
Message-ID: <20180308074220.GC15748@lst.de>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com> <20180228164726.GB16536@lst.de> <20180301150329.GB6795@ming.t460p> <20180301161042.GA14799@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301161042.GA14799@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 09:10:42AM -0700, Keith Busch wrote:
> On Thu, Mar 01, 2018 at 11:03:30PM +0800, Ming Lei wrote:
> > If all CPUs for the 1st IRQ vector of admin queue are offline, then I
> > guess NVMe can't work any more.
> 
> Yikes, with respect to admin commands, it appears you're right if your
> system allows offlining CPU0.
> 
> > So looks it is a good idea to make admin queue's IRQ vector assigned as
> > non-managed IRQs.
> 
> It'd still be considered managed even if it's a 'pre_vector', though
> it would get the default mask with all possible CPUs.

Which basically does the right thing.  So I suspect we'll need to
go with a patch like this, just with a way better changelog.
