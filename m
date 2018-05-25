Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935980AbeEYN6Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:58:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934496AbeEYN6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:58:14 -0400
Date: Fri, 25 May 2018 09:58:13 -0400
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
Message-ID: <20180525135813.GB9591@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525130535.GA24239@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25 2018 at  9:05am -0400,
Christoph Hellwig <hch@lst.de> wrote:

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

We all basically knew this would be your position.  But at this year's
LSF we pretty quickly reached consensus that we do in fact need this.
Except for yourself, Sagi and afaik Martin George: all on the cc were in
attendance and agreed.

And since then we've exchanged mails to refine and test Johannes'
implementation.

You've isolated yourself on this issue.  Please just accept that we all
have a pretty solid command of what is needed to properly provide
commercial support for NVMe multipath.

The ability to switch between "native" and "other" multipath absolutely
does _not_ imply anything about the winning disposition of native vs
other.  It is purely about providing commercial flexibility to use
whatever solution makes sense for a given environment.  The default _is_
native NVMe multipath.  It is on userspace solutions for "other"
multipath (e.g. multipathd) to allow user's to whitelist an NVMe
subsystem to be switched to "other".

Hopefully this clarifies things, thanks.

Mike
