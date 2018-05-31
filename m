Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeEaGeb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753760AbeEaGea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:34:30 -0400
Date: Thu, 31 May 2018 08:34:08 +0200
From: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "'Davidlohr Bueso'" <dbueso@suse.de>,
        "'Joe Lawrence'" <joe.lawrence@redhat.com>,
        "'Andrea Arcangeli'" <aarcange@redhat.com>,
        "'Manfred Spraul'" <manfred@colorfullife.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.4 011/268] Revert "ipc/shm: Fix shmat mmap nil-page
 protection"
Message-ID: <20180531063408.GA7744@kroah.com>
References: <20180528100202.045206534@linuxfoundation.org>
 <20180528100203.357731085@linuxfoundation.org>
 <005601d3f888$37f266f0$a7d734d0$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005601d3f888$37f266f0$a7d734d0$@toshiba.co.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:36:46AM +0900, Daniel Sangorrin wrote:
> > -----Original Message-----
> > From: stable-owner@vger.kernel.org [mailto:stable-owner@vger.kernel.org] On
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > commit a73ab244f0dad8fffb3291b905f73e2d3eaa7c00 upstream.
> > 
> > Patch series "ipc/shm: shmat() fixes around nil-page".
> 
> Sorry for being a bit late (the pace is really fast here).
> 
> I have found a regression from 4.4.133-rc1 to 4.4.134-rc1 using Fuego LTP wrapper.
> 
> 4.4.134-rc1
> 	tst_test.c:982: INFO: Timeout per run is 0h 05m 00s
> 	cve-2017-5669.c:62: INFO: Attempting to attach shared memory to null page
> 	cve-2017-5669.c:74: INFO: Mapped shared memory to (nil)
> 	cve-2017-5669.c:78: FAIL: We have mapped a VM address within the first 64Kb
> 	cve-2017-5669.c:84: INFO: Touching shared memory to see if anything strange happens
> 
> 4.4.133-rc1:
> 	tst_test.c:982: INFO: Timeout per run is 0h 05m 00s
> 	cve-2017-5669.c:62: INFO: Attempting to attach shared memory to null page
> 	cve-2017-5669.c:67: PASS: shmat returned EINVAL
> 
> The culprits should be one or both of the two last commits to ipc/shm (one of them a revert).
> 
> - ipc/shm: fix shmat() nil address after round-down when remapping
> - Revert "ipc/shm: Fix shmat mmap nil-page protection"
> 
> I need to investigate the concrete reason, but for now I just wanted to report it.

Thanks for letting us know, but this was reported already.  See the
emails on lkml with the subject:
	Subject: Re: [PATCH 4.16 000/272] 4.16.13-stable review
from Davidlohr Bueso
	Message-ID: <20180528213039.yy2madue67njkmw5@linux-n805>

where he discusses that the LTP test is incorrect and that the kernel
change is correct and that LTP is going to be fixed because of this.

thanks,

greg k-h
