Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbeFAEYq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:24:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750771AbeFAEYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:24:43 -0400
Date: Fri, 1 Jun 2018 00:24:41 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>, axboe@kernel.dk
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180601042441.GB14244@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com>
 <20180531163311.GA30954@lst.de>
 <20180531181757.GB11848@redhat.com>
 <yq17enjut3q.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17enjut3q.fsf@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31 2018 at 10:40pm -0400,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> 
> Mike,
> 
> > 1) container A is tasked with managing some dedicated NVMe technology
> > that absolutely needs native NVMe multipath.
> 
> > 2) container B is tasked with offering some canned layered product
> > that was developed ontop of dm-multipath with its own multipath-tools
> > oriented APIs, etc. And it is to manage some other NVMe technology on
> > the same host as container A.
> 
> This assumes there is something to manage. And that the administrative
> model currently employed by DM multipath will be easily applicable to
> ANA devices. I don't believe that's the case. The configuration happens
> on the storage side, not on the host.

Fair point.

> With ALUA (and the proprietary implementations that predated the spec),
> it was very fuzzy whether it was the host or the target that owned
> responsibility for this or that. Part of the reason was that ALUA was
> deliberately vague to accommodate everybody's existing, non-standards
> compliant multipath storage implementations.
> 
> With ANA the heavy burden falls entirely on the storage. Most of the
> things you would currently configure in multipath.conf have no meaning
> in the context of ANA. Things that are currently the domain of
> dm-multipath or multipathd are inextricably living either in the storage
> device or in the NVMe ANA "device handler". And I think you are
> significantly underestimating the effort required to expose that
> information up the stack and to make use of it. That's not just a
> multipath personality toggle switch.

I'm aware that most everything in multipath.conf is SCSI/FC specific.
That isn't the point.  dm-multipath and multipathd are an existing
framework for managing multipath storage.

It could be made to work with NVMe.  But yes it would not be easy.
Especially not with the native NVMe multipath crew being so damn
hostile.

> If you want to make multipath -ll show something meaningful for ANA
> devices, then by all means go ahead. I don't have any problem with
> that.

Thanks so much for your permission ;)  But I'm actually not very
involved with multipathd development anyway.  It is likely a better use
of time in the near-term though.  Making the multipath tools and
libraries be able to understand native NVMe multipath in all its glory
might be a means to an end from a compatibility with existing monitoring
applications perspective.

Though NVMe just doesn't have per-device accounting at all.  Also not
yet aware how nvme cli conveys paths being down vs up, etc.

Glad that isn't my problem ;)

> But I don't think the burden of allowing multipathd/DM to inject
> themselves into the path transition state machine has any benefit
> whatsoever to the user. It's only complicating things and therefore we'd
> be doing people a disservice rather than a favor.

This notion that only native NVMe multipath can be successful is utter
bullshit.  And the mere fact that I've gotten such a reaction from a
select few speaks to some serious control issues.

Imagine if XFS developers just one day imposed that it is the _only_
filesystem that can be used on persistent memory.

Just please dial it back.. seriously tiresome.
