Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755775AbeEaQ3f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:29:35 -0400
Received: from verein.lst.de ([213.95.11.211]:38968 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755705AbeEaQ3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:29:34 -0400
Date: Thu, 31 May 2018 18:36:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20180531163603.GC30954@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com> <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me> <20180530220206.GA7037@redhat.com> <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:37:20AM +0300, Sagi Grimberg wrote:
>> the same host with PCI NVMe could be connected to a FC network that has
>> historically always been managed via dm-multipath.. but say that
>> FC-based infrastructure gets updated to use NVMe (to leverage a wider
>> NVMe investment, whatever?) -- but maybe admins would still prefer to
>> use dm-multipath for the NVMe over FC.
>
> You are referring to an array exposing media via nvmf and scsi
> simultaneously? I'm not sure that there is a clean definition of
> how that is supposed to work (ANA/ALUA, reservations, etc..)

It seems like this isn't what Mike wanted, but I actually got some
requests for limited support for that to do a storage live migration
from a SCSI array to NVMe.  I think it is really sketchy, but if
doable if you are careful enough.  It would use dm-multipath, possibly
even on top of nvme multipathing if we have multiple nvme paths.
