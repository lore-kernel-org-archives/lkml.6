Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 291066070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeFFJnP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:43:15 -0400
Received: from verein.lst.de ([213.95.11.211]:36718 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932415AbeFFJnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:43:14 -0400
Date: Wed, 6 Jun 2018 11:50:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
        Roland Dreier <roland@purestorage.com>,
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
Message-ID: <20180606095029.GA10439@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com> <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me> <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com> <20180605044222.GA29384@lst.de> <4203e888-df87-efd6-f61a-24b43fb710e2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4203e888-df87-efd6-f61a-24b43fb710e2@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 12:32:21PM +0300, Sagi Grimberg wrote:
> Huh? different paths == different controllers so this sentence can't
> be right... you mean that a path selector will select a controller
> based on the home node of the local rdma device connecting to it and
> the running cpu right?

Think of a system with say 8 cpu cores.  Say we have two optimized
paths.

There is no point in going round robin or service time over the
two paths for each logic pre-cpu queue.  Instead we should always
got to path A for a given cpu queue or path B to reduce selection
overhead and cache footprint.
