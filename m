Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeDJBK0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:10:26 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:41492 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeDJBKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:10:25 -0400
Date: Tue, 10 Apr 2018 11:10:10 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] block/swim: Fix array bounds check
In-Reply-To: <CAMuHMdXC3d84tJLsr=mZx20qsF6ddvmNMSFOCY-xHmzqDF3qhQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1804101102420.8@nippy.intranet>
References: <cover.1522546571.git.fthain@telegraphics.com.au> <e5bd38c0bd81236e11fd391ec3339d3bdf3c29d5.1522546571.git.fthain@telegraphics.com.au> <CAMuHMdXC3d84tJLsr=mZx20qsF6ddvmNMSFOCY-xHmzqDF3qhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018, Geert Uytterhoeven wrote:

> Looks like amiflop.c:find_floppy() needs a check, too?
> 

AFAICS there is no array index bug in floppy_find() in amiflop.c. 
The 'unit' array's size is FD_MAX_UNITS which is defined as 4 in 
include/linux/amifd.h, and the array index is drive = *part & 3.

-- 
