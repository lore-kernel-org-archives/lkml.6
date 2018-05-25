Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936311AbeEYOu7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:50:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936200AbeEYOu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:50:58 -0400
Date: Fri, 25 May 2018 10:50:56 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Laurence Oberman <loberman@redhat.com>,
        Ewan Milne <emilne@redhat.com>, James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180525145056.GD9591@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525141211.GA25971@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25 2018 at 10:12am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, May 25, 2018 at 09:58:13AM -0400, Mike Snitzer wrote:
> > We all basically knew this would be your position.  But at this year's
> > LSF we pretty quickly reached consensus that we do in fact need this.
> > Except for yourself, Sagi and afaik Martin George: all on the cc were in
> > attendance and agreed.
> 
> And I very mich disagree, and you'd bette come up with a good reason
> to overide me as the author and maintainer of this code.

I hope you don't truly think this is me vs you.

Some of the reasons are:
1) we need flexibility during the transition to native NVMe multipath
2) we need to support existing customers' dm-multipath storage networks
3) asking users to use an entirely new infrastructure that conflicts
   with their dm-multipath expertise and established norms is a hard
   sell.  Especially for environments that have a mix of traditional
   multipath (FC, iSCSI, whatever) and NVMe over fabrics.
4) Layered products (both vendor provided and user developed) have been
   trained to fully support and monitor dm-multipath; they have no
   understanding of native NVMe multipath

> > And since then we've exchanged mails to refine and test Johannes'
> > implementation.
> 
> Since when was acting behind the scenes a good argument for anything?

I mentioned our continued private collaboration to establish that this
wasn't a momentary weakness by anyone at LSF.  It has had a lot of soak
time in our heads.

We did it privately because we needed a concrete proposal that works for
our needs.  Rather than getting shot down over some shortcoming in an
RFC-style submission.
 
> > Hopefully this clarifies things, thanks.
> 
> It doesn't.
> 
> The whole point we have native multipath in nvme is because dm-multipath
> is the wrong architecture (and has been, long predating you, nothing
> personal).  And I don't want to be stuck additional decades with this
> in nvme.  We allowed a global opt-in to ease the three people in the
> world with existing setups to keep using that, but I also said I
> won't go any step further.  And I stand to that.

Thing is you really don't get to dictate that to the industry.  Sorry.

Reality is this ability to switch "native" vs "other" gives us the
options I've been talking about absolutely needing since the start of
this NVMe multipathing debate.

Your fighting against it for so long has prevented progress on NVMe
multipath in general.  Taking this change will increase native NVMe
multipath deployment.  Otherwise we're just going to have to disable
native multipath entirely for the time being.  That does users a
disservice because I completely agree that there _will_ be setups where
native NVMe multipath really does offer a huge win.  But those setups
could easily be deployed on the same hosts as another variant of NVMe
that really does want the use of the legacy DM multipath stack (possibly
even just for reason 4 above).

Mike
