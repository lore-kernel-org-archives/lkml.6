Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754865AbeE2HS7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:18:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:36964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbeE2HS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:18:57 -0400
Date: Tue, 29 May 2018 09:18:55 +0200
From: Hannes Reinecke <hare@suse.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180529091855.27e6042b@pentland.suse.de>
In-Reply-To: <20180529030236.GA28895@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
        <20180525130535.GA24239@lst.de>
        <20180525135813.GB9591@redhat.com>
        <20180525141211.GA25971@lst.de>
        <20180525145056.GD9591@redhat.com>
        <yq1muwj45sg.fsf@oracle.com>
        <20180529030236.GA28895@redhat.com>
Organization: SUSE Linux GmbH
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018 23:02:36 -0400
Mike Snitzer <snitzer@redhat.com> wrote:

> On Mon, May 28 2018 at  9:19pm -0400,
> Martin K. Petersen <martin.petersen@oracle.com> wrote:
> 
> > 
> > Mike,
> > 
> > I understand and appreciate your position but I still don't think
> > the arguments for enabling DM multipath are sufficiently
> > compelling. The whole point of ANA is for things to be plug and
> > play without any admin intervention whatsoever.
> > 
> > I also think we're getting ahead of ourselves a bit. The assumption
> > seems to be that NVMe ANA devices are going to be broken--or that
> > they will require the same amount of tweaking as SCSI devices--and
> > therefore DM multipath support is inevitable. However, I'm not sure
> > that will be the case.
> >   
> > > Thing is you really don't get to dictate that to the industry.
> > > Sorry.  
> > 
> > We are in the fortunate position of being able to influence how the
> > spec is written. It's a great opportunity to fix the mistakes of
> > the past in SCSI. And to encourage the industry to ship products
> > that don't need the current level of manual configuration and
> > complex management.
> > 
> > So I am in favor of Johannes' patches *if* we get to the point
> > where a Plan B is needed. But I am not entirely convinced that's
> > the case just yet. Let's see some more ANA devices first. And once
> > we do, we are also in a position where we can put some pressure on
> > the vendors to either amend the specification or fix their
> > implementations to work with ANA.  
> 
> ANA really isn't a motivating factor for whether or not to apply this
> patch.  So no, I don't have any interest in waiting to apply it.
> 
Correct. That patch is _not_ to work around any perceived incompability
on the OS side.
The patch is primarily to give _admins_ a choice.
Some installations like hosting providers etc are running quite complex
scenarios, most of which are highly automated.
So for those there is a real benefit to be able to use dm-multipathing
for NVMe; they are totally fine with having a performance impact if
they can avoid to rewrite their infrastructure.

Cheers,

Hannes
