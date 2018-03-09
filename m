Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932401AbeCIRXB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:23:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:36429 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbeCIRW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:22:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,446,1515484800";
   d="scan'208";a="23354940"
Date: Fri, 9 Mar 2018 10:24:45 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@fb.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
Message-ID: <20180309172445.GC14765@localhost.localdomain>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180228164726.GB16536@lst.de>
 <20180301150329.GB6795@ming.t460p>
 <20180301161042.GA14799@localhost.localdomain>
 <20180308074220.GC15748@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308074220.GC15748@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 08:42:20AM +0100, Christoph Hellwig wrote:
> 
> So I suspect we'll need to go with a patch like this, just with a way
> better changelog.

I have to agree this is required for that use case. I'll run some
quick tests and propose an alternate changelog.

Longer term, the current way we're including offline present cpus either
(a) has the driver allocate resources it can't use or (b) spreads the
ones it can use thinner than they need to be. Why don't we rerun the
irq spread under a hot cpu notifier for only online CPUs?
