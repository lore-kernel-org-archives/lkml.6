Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeFEEfS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 00:35:18 -0400
Received: from verein.lst.de ([213.95.11.211]:58119 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeFEEfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 00:35:17 -0400
Date: Tue, 5 Jun 2018 06:42:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roland Dreier <roland@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180605044222.GA29384@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com> <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me> <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 02:58:49PM -0700, Roland Dreier wrote:
> We plan to implement all the fancy NVMe standards like ANA, but it
> seems that there is still a requirement to let the host side choose
> policies about how to use paths (round-robin vs least queue depth for
> example).  Even in the modern SCSI world with VPD pages and ALUA,
> there are still knobs that are needed.  Maybe NVMe will be different
> and we can find defaults that work in all cases but I have to admit
> I'm skeptical...

The sensible thing to do in nvme is to use different paths for
different queues.  That is e.g. in the RDMA case use the HCA closer
to a given CPU by default.  We might allow to override this for
cases where the is a good reason, but what I really don't want is
configurability for configurabilities sake.
