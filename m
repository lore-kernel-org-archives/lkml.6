Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeFDGTY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:19:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeFDGTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:19:23 -0400
Date: Mon, 4 Jun 2018 08:19:21 +0200
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, Ewan Milne <emilne@redhat.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>, dm-devel@redhat.com
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180604081921.3cedecbc@pentland.suse.de>
In-Reply-To: <f4951571-d37d-73cd-1d6c-0ca84647d5ac@kernel.dk>
References: <20180525125322.15398-1-jthumshirn@suse.de>
        <20180525130535.GA24239@lst.de>
        <20180525135813.GB9591@redhat.com>
        <20180525141211.GA25971@lst.de>
        <20180525145056.GD9591@redhat.com>
        <yq1muwj45sg.fsf@oracle.com>
        <20180529030236.GA28895@redhat.com>
        <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
        <20180529080952.GA1369@lst.de>
        <20180529232718.GA1730@redhat.com>
        <f4951571-d37d-73cd-1d6c-0ca84647d5ac@kernel.dk>
Organization: SUSE Linux GmbH
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 13:05:46 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 5/29/18 5:27 PM, Mike Snitzer wrote:
> > On Tue, May 29 2018 at  4:09am -0400,
> > Christoph Hellwig <hch@lst.de> wrote:
> >   
> >> On Tue, May 29, 2018 at 09:22:40AM +0200, Johannes Thumshirn
> >> wrote:  
> >>> For a "Plan B" we can still use the global knob that's already in
> >>> place (even if this reminds me so much about scsi-mq which at
> >>> least we haven't turned on in fear of performance regressions).
> >>>
> >>> Let's drop the discussion here, I don't think it leads to
> >>> something else than flamewars.  
> >>
> >> If our plan A doesn't work we can go back to these patches.  For
> >> now I'd rather have everyone spend their time on making Plan A
> >> work then preparing for contingencies.  Nothing prevents anyone
> >> from using these patches already out there if they really want to,
> >> but I'd recommend people are very careful about doing so as you'll
> >> lock yourself into a long-term maintainance burden.  
> > 
> > Restating (for others): this patchset really isn't about
> > contingencies. It is about choice.
> > 
> > Since we're at an impasse, in the hopes of soliciting definitive
> > feedback from Jens and Linus, I'm going to attempt to reset the
> > discussion for their entry.
> > 
> > In summary, we have a classic example of a maintainer stalemate
> > here: 1) Christoph, as NVMe co-maintainer, doesn't want to allow
> > native NVMe multipath to actively coexist with dm-multipath's NVMe
> > support on the same host.
> > 2) I, as DM maintainer, would like to offer this flexibility to
> > users -- by giving them opt-in choice to continue using existing
> > dm-multipath with NVMe. (also, both Red Hat and SUSE would like to
> > offer this).
> > 
> > There is no technical reason why they cannot coexist.  Hence this
> > simple patchset that was originally offered by Johannes Thumshirn
> > with contributions from myself.  
> 
> Here's what I think - flag days tend to suck. They may be more
> convenient for developers, but they inflict pain on users. Sometimes
> they prevent them from moving forward, since updates are now gated on
> external dependencies. Moving forward with a new architecture is
> great, but proper care has to be given to existing users of
> multipath, regardless of how few they may be.
> 
> This patchset seems pretty clean and minimalist. Realistically, I'm
> guessing that SUSE and RH will ship it regardless of upstream status.
> 

Without it we're having a choice of disappointing (paying) customers or
disappointing the upstream community.

Guess.

Cheers,

Hannes
