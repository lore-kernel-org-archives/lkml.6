Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755751AbeEaQ0o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:26:44 -0400
Received: from verein.lst.de ([213.95.11.211]:38950 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755735AbeEaQ0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:26:42 -0400
Date: Thu, 31 May 2018 18:33:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20180531163311.GA30954@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com> <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me> <20180530220206.GA7037@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530220206.GA7037@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 06:02:06PM -0400, Mike Snitzer wrote:
> Because once nvme_core.multipath=N is set: native NVMe multipath is then
> not accessible from the same host.  The goal of this patchset is to give
> users choice.  But not limit them to _only_ using dm-multipath if they
> just have some legacy needs.

Choise by itself really isn't an argument.  We need a really good
use case for all the complexity, and so far none has been presented.

> Tough to be convincing with hypotheticals but I could imagine a very
> obvious usecase for native NVMe multipathing be PCI-based embedded NVMe
> "fabrics" (especially if/when the numa-based path selector lands).  But
> the same host with PCI NVMe could be connected to a FC network that has
> historically always been managed via dm-multipath.. but say that
> FC-based infrastructure gets updated to use NVMe (to leverage a wider
> NVMe investment, whatever?) -- but maybe admins would still prefer to
> use dm-multipath for the NVMe over FC.

That is a lot of maybes.  If they prefer the good old way on FC then
can easily stay with SCSI, or for that matter use the global switch
off.

> > This might sound stupid to you, but can't users that desperately must
> > keep using dm-multipath (for its mature toolset or what-not) just
> > stack it on multipath nvme device? (I might be completely off on
> > this so feel free to correct my ignorance).
> 
> We could certainly pursue adding multipath-tools support for native NVMe
> multipathing.  Not opposed to it (even if just reporting topology and
> state).  But given the extensive lengths NVMe multipath goes to hide
> devices we'd need some way to piercing through the opaque nvme device
> that native NVMe multipath exposes.  But that really is a tangent
> relative to this patchset.  Since that kind of visibility would also
> benefit the nvme cli... otherwise how are users to even be able to trust
> but verify native NVMe multipathing did what it expected it to?

Just look at the nvme-cli output or sysfs.  It's all been there since
the code was merged to mainline.
