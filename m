Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeDJB2F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:28:05 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:41986 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeDJB2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:28:04 -0400
Date: Tue, 10 Apr 2018 11:27:51 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] block/swim: Don't log an error message for an
 invalid ioctl
In-Reply-To: <CAMuHMdWe6pWFd0977n4FoGsPuvhS-yYKSBVfYDR8Y8gBEej3Eg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1804101119060.8@nippy.intranet>
References: <cover.1522546571.git.fthain@telegraphics.com.au> <803fabab1f0349bafe52b5589eff3edc077eee2d.1522546571.git.fthain@telegraphics.com.au> <CAMuHMdWe6pWFd0977n4FoGsPuvhS-yYKSBVfYDR8Y8gBEej3Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018, Geert Uytterhoeven wrote:

> On Sun, Apr 1, 2018 at 3:41 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> > The 'eject' shell command may send various different ioctl commands.
> > This leads to error messages on the console even though the FDEJECT
> > ioctl succeeds.
> >
> > ~# eject floppy
> > SWIM floppy_ioctl: unknown cmd 21257
> > SWIM floppy_ioctl: unknown cmd 1
> >
> > Don't log an error message for an invalid ioctl, just do as the
> > swim3 driver does and return -ENOTTY.
> >
> > Cc: Laurent Vivier <lvivier@redhat.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Looks like amiflop can use a similar fix.
> 

Right. I'll prepare a new patch for that and send it separately.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
