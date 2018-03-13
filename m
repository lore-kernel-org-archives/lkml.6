Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCMRi5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:38:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:7823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751534AbeCMRi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:38:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,465,1515484800";
   d="scan'208";a="33512766"
Date: Tue, 13 Mar 2018 11:40:53 -0600
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] nvme-pci: assign separate irq vectors for adminq and
 ioq1
Message-ID: <20180313174052.GJ18494@localhost.localdomain>
References: <1520935088-1343-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180313104452.GA8782@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313104452.GA8782@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:45:00PM +0800, Ming Lei wrote:
> On Tue, Mar 13, 2018 at 05:58:08PM +0800, Jianchao Wang wrote:
> > Currently, adminq and ioq1 share the same irq vector which is set
> > affinity to cpu0. If a system allows cpu0 to be offlined, the adminq
> > will not be able work any more.
> > 
> > To fix this, assign separate irq vectors for adminq and ioq1. Set
> > .pre_vectors == 1 when allocate irq vectors, then assign the first
> > one to adminq which will have affinity cpumask with all possible
> > cpus. On the other hand, if controller has only legacy or single
> > -message MSI, we will setup adminq and 1 ioq and let them share
> > the only one irq vector.
> > 
> > Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, applied with an updated changelog.

Not being able to use the admin queue is a pretty big deal, so it's pushed
to the next nvme 4.16-rc branch. This may even be good stable material.
