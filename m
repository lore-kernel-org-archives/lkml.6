Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936229AbeEYOZU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:25:20 -0400
Received: from verein.lst.de ([213.95.11.211]:37246 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935949AbeEYOZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:25:18 -0400
Date: Fri, 25 May 2018 16:30:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180525143058.GA26391@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de> <20180525142217.zedv7hz6ov6s45qk@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525142217.zedv7hz6ov6s45qk@linux-x5ow.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 04:22:17PM +0200, Johannes Thumshirn wrote:
> But Mike's and Hannes' arguments where reasonable as well, we do not
> know if there are any existing setups we might break leading to
> support calls, which we have to deal with. Personally I don't believe
> there are lot's of existing nvme multipath setups out there, but who
> am I to judge.

I don't think existing setups are very likely, but they absolutely
are a valid reason to support the legacy mode.  That is why we support
the legacy mode using the multipath module option.  Once you move
to a per-subsystem switch you don't support legacy setups, you
create a maze of new setups that we need to keep compatibility
support for forever.

> So can we find a middle ground to this? Or we'll have the
> all-or-nothing situation we have in scsi-mq now again. How about
> tieing the switch to a config option which is off per default?

The middle ground is the module option.  It provides 100% backwards
compatibility if used, but more importantly doesn't create hairy
runtime ABIs that we will have to support forever.
