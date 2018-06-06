Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2775E60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932627AbeFFJoQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:44:16 -0400
Received: from verein.lst.de ([213.95.11.211]:36730 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932415AbeFFJoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:44:15 -0400
Date: Wed, 6 Jun 2018 11:51:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Roland Dreier <roland@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>,
        Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180606095130.GA10485@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com> <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me> <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com> <20180605044222.GA29384@lst.de> <CAL1RGDWvxcz7zAoEa-Ukhmsn=Vuj6O07X666BK+vJOdkA7qwNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1RGDWvxcz7zAoEa-Ukhmsn=Vuj6O07X666BK+vJOdkA7qwNQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:57:05PM -0700, Roland Dreier wrote:
> That makes sense but I'm not sure it covers everything.  Probably the
> most common way to do NVMe/RDMA will be with a single HCA that has
> multiple ports, so there's no sensible CPU locality.  On the other
> hand we want to keep both ports to the fabric busy.  Setting different
> paths for different queues makes sense, but there may be
> single-threaded applications that want a  different policy.
> 
> I'm not saying anything very profound, but we have to find the right
> balance between too many and too few knobs.

Agreed.  And the philosophy here is to start with a as few knobs
as possible and work from there based on actual use cases.
Single threaded applications will run into issues with general
blk-mq philosophy, so to work around that we'll need to dig deeper
and allow borrowing of other cpu queues if we want to cater for that.
