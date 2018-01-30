Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeA3IXT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:23:19 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33337 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeA3IXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:23:18 -0500
X-Google-Smtp-Source: AH8x224NVQapb4dcIo19LbH4G7vDxMXcRXIz7NKm+F16RYkcdYh1cz1y3YQ8t+07DQxE76poSXrocw==
Date: Tue, 30 Jan 2018 09:23:14 +0100
From: LABBE Corentin <clabbe@baylibre.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joe Perches <joe@perches.com>, dledford@redhat.com,
        hal.rosenstock@gmail.com, sean.hefty@intel.com, swise@chelsio.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/cxgb3: remove cxio_dbg.c
Message-ID: <20180130082314.GA12047@Red>
References: <1517152289-25052-1-git-send-email-clabbe@baylibre.com>
 <1517156662.765.10.camel@perches.com>
 <20180128210903.GL23869@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180128210903.GL23869@ziepe.ca>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 28, 2018 at 02:09:03PM -0700, Jason Gunthorpe wrote:
> On Sun, Jan 28, 2018 at 08:24:22AM -0800, Joe Perches wrote:
> > On Sun, 2018-01-28 at 15:11 +0000, Corentin Labbe wrote:
> > > cxio_dbg.c is uncompiled since commit 2b540355cd2f ("RDMA/cxgb3: cleanups")
> > > 10 years after, we could remove it.
> > 
> > OK, now you could remove the prototypes and probably
> > CONFIG_INFINIBAND_CXGB3_DEBUG too.
> > 
> > There is a DEBUG test and many uses of pr_debug
> > that would have modified behavior.
> > 
> > The pr_debug uses would only be emitted via a
> > dynamic_debug enable and the #ifdef DEBUG is
> > probably not necessary or useful as it guards
> > a BUG_ON.
> > 
> >  drivers/infiniband/hw/cxgb3/Kconfig    | 9 ---------
> >  drivers/infiniband/hw/cxgb3/Makefile   | 2 --
> >  drivers/infiniband/hw/cxgb3/cxio_hal.h | 9 ---------
> >  drivers/infiniband/hw/cxgb3/iwch_cq.c  | 7 -------
> >  4 files changed, 27 deletions(-)
> 
> Yes, can you resend the patch with Joe's hunks as well?
> 

Yes I will do

Regards
