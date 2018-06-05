Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeFEW53 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:57:29 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33460 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbeFEW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:57:28 -0400
X-Google-Smtp-Source: ADUXVKKN+eez47jtwDJG9YfKoWYtZYQdzx3pY1hRznjgm/ISDiUKZa3G8v2Cmmi1s17dWVtTaaEen0pnuiuZ5rWXObc=
MIME-Version: 1.0
In-Reply-To: <20180605044222.GA29384@lst.de>
References: <20180525125322.15398-1-jthumshirn@suse.de> <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com> <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <CAL1RGDV0eT4juuMwHWkjqc2oTsk-CHRJ0A90veXxLsVZYa5esQ@mail.gmail.com> <20180605044222.GA29384@lst.de>
From: Roland Dreier <roland@purestorage.com>
Date: Tue, 5 Jun 2018 15:57:05 -0700
Message-ID: <CAL1RGDWvxcz7zAoEa-Ukhmsn=Vuj6O07X666BK+vJOdkA7qwNQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The sensible thing to do in nvme is to use different paths for
> different queues.  That is e.g. in the RDMA case use the HCA closer
> to a given CPU by default.  We might allow to override this for
> cases where the is a good reason, but what I really don't want is
> configurability for configurabilities sake.

That makes sense but I'm not sure it covers everything.  Probably the
most common way to do NVMe/RDMA will be with a single HCA that has
multiple ports, so there's no sensible CPU locality.  On the other
hand we want to keep both ports to the fabric busy.  Setting different
paths for different queues makes sense, but there may be
single-threaded applications that want a  different policy.

I'm not saying anything very profound, but we have to find the right
balance between too many and too few knobs.

 - R.
