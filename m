Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936204AbeEYOWU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:22:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:47867 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935949AbeEYOWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:22:19 -0400
Date: Fri, 25 May 2018 16:22:17 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180525142217.zedv7hz6ov6s45qk@linux-x5ow.site>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180525130535.GA24239@lst.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 03:05:35PM +0200, Christoph Hellwig wrote:
> On Fri, May 25, 2018 at 02:53:19PM +0200, Johannes Thumshirn wrote:
> > Hi,
> > 
> > This patch series aims to provide a more fine grained control over
> > nvme's native multipathing, by allowing it to be switched on and off
> > on a per-subsystem basis instead of a big global switch.
> 
> No.  The only reason we even allowed to turn multipathing off is
> because you complained about installer issues.  The path forward
> clearly is native multipathing and there will be no additional support
> for the use cases of not using it.

First of all, it wasn't my idea and I'm just doing my job here, as I
got this task assigned at LSF and tried to do my best here.

Personally I _do_ agree with you and do not want to use dm-mpath in
nvme either (mainly because I don't really know the code and don't
want to learn yet another subsystem).

But Mike's and Hannes' arguments where reasonable as well, we do not
know if there are any existing setups we might break leading to
support calls, which we have to deal with. Personally I don't believe
there are lot's of existing nvme multipath setups out there, but who
am I to judge.

So can we find a middle ground to this? Or we'll have the
all-or-nothing situation we have in scsi-mq now again. How about
tieing the switch to a config option which is off per default?

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
