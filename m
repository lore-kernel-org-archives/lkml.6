Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbeE3WoI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:44:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753691AbeE3WoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:44:03 -0400
Date: Wed, 30 May 2018 18:44:02 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20180530224402.GA7303@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2018 at  5:20pm -0400,
Sagi Grimberg <sagi@grimberg.me> wrote:
 
> Moreover, I also wanted to point out that fabrics array vendors are
> building products that rely on standard nvme multipathing (and probably
> multipathing over dispersed namespaces as well), and keeping a knob that
> will keep nvme users with dm-multipath will probably not help them
> educate their customers as well... So there is another angle to this.

Noticed I didn't respond directly to this aspect.  As I explained in
various replies to this thread: The users/admins would be the ones who
would decide to use dm-multipath.  It wouldn't be something that'd be
imposed by default.  If anything, the all-or-nothing
nvme_core.multipath=N would pose a much more serious concern for these
array vendors that do have designs to specifically leverage native NVMe
multipath.  Because if users were to get into the habit of setting that
on the kernel commandline they'd literally _never_ be able to leverage
native NVMe multipathing.

We can also add multipath.conf docs (man page, etc) that caution admins
to consult their array vendors about whether using dm-multipath is to be
avoided, etc.

Again, this is opt-in, so on a upstream Linux kernel level the default
of enabling native NVMe multipath stands (provided CONFIG_NVME_MULTIPATH
is configured).  Not seeing why there is so much angst and concern about
offering this flexibility via opt-in but I'm also glad we're having this
discussion to have our eyes wide open.

Mike
