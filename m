Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeE2Jys (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:54:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932517AbeE2JyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:54:22 -0400
Date: Tue, 29 May 2018 05:54:20 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, Ewan Milne <emilne@redhat.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180529095420.GA30702@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <20180525141211.GA25971@lst.de>
 <20180525145056.GD9591@redhat.com>
 <yq1muwj45sg.fsf@oracle.com>
 <20180529030236.GA28895@redhat.com>
 <20180529072240.np5c62akbr7jqelr@linux-x5ow.site>
 <20180529080952.GA1369@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529080952.GA1369@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29 2018 at  4:09am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, May 29, 2018 at 09:22:40AM +0200, Johannes Thumshirn wrote:
> > For a "Plan B" we can still use the global knob that's already in
> > place (even if this reminds me so much about scsi-mq which at least we
> > haven't turned on in fear of performance regressions).
> > 
> > Let's drop the discussion here, I don't think it leads to something
> > else than flamewars.

As the author of the original patch you're fine to want to step away from
this needlessly ugly aspect.  But it doesn't change the fact that we
need answers on _why_ it is a genuinely detrimental change. (hint: we
know it isn't).

The enterprise Linux people who directly need to support multipath want
the flexibility to allow dm-multipath while simultaneously allowing
native NVMe multipathing on the same host.

Hannes Reinecke and others, if you want the flexibility this patchset
offers please provide your review/acks.

> If our plan A doesn't work we can go back to these patches.  For now
> I'd rather have everyone spend their time on making Plan A work then
> preparing for contingencies.  Nothing prevents anyone from using these
> patches already out there if they really want to, but I'd recommend
> people are very careful about doing so as you'll lock yourself into
> a long-term maintainance burden.

This isn't about contingencies.  It is about continuing compatibility
with a sophisticated dm-multipath stack that is widely used by, and
familiar to, so many.

Christoph, you know you're being completely vague right?  You're
actively denying the validity of our position (at least Hannes and I)
with handwaving and effectively FUD, e.g. "maze of new setups" and
"hairy runtime ABIs" here: https://lkml.org/lkml/2018/5/25/461

To restate my question, from https://lkml.org/lkml/2018/5/28/2179:
hch had some non-specific concern about this patch forcing
support of some "ABI".  Which ABI is that _exactly_?

The incremental effort required to support NVMe in dm-multipath isn't so
grim.  And those who will do that work are signing up for it -- while
still motivated to help make native NVMe multipath a success.
Can you please give us time to responsibly ween users off dm-multipath?

Mike
