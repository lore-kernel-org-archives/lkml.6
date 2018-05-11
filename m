Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeEKPzH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:55:07 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:53964 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEKPzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:55:06 -0400
Date: Fri, 11 May 2018 11:55:03 -0400
From: Rich Felker <dalias@libc.org>
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SH-Linux <linux-sh@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] sh: switch to NO_BOOTMEM
Message-ID: <20180511155503.GS1392@brightrain.aerifal.cx>
References: <20180511134559.13464-1-robh@kernel.org>
 <20180511150224.GR1392@brightrain.aerifal.cx>
 <CAL_Jsq+kp07T6YOzYOJ+hwMf1FobG8pwbMsKVxTuxq43Ocw-vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+kp07T6YOzYOJ+hwMf1FobG8pwbMsKVxTuxq43Ocw-vA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 10:37:42AM -0500, Rob Herring wrote:
> On Fri, May 11, 2018 at 10:02 AM, Rich Felker <dalias@libc.org> wrote:
> > On Fri, May 11, 2018 at 08:45:59AM -0500, Rob Herring wrote:
> >> Commit 0fa1c579349f ("of/fdt: use memblock_virt_alloc for early alloc")
> >> inadvertently switched the DT unflattening allocations from memblock to
> >> bootmem which doesn't work because the unflattening happens before
> >> bootmem is initialized. Swapping the order of bootmem init and
> >> unflattening could also fix this, but removing bootmem is desired. So
> >> enable NO_BOOTMEM on SH like other architectures have done.
> >>
> >> Fixes: 0fa1c579349f ("of/fdt: use memblock_virt_alloc for early alloc")
> >> Reported-by: Rich Felker <dalias@libc.org>
> >> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >> This is compile tested only, but similar to microblaze and h8300
> >> conversions. The additional complexity for SH is NUMA support (which to
> >> me looks like an abuse of NUMA support to map a small amount of
> >> on-chip? RAM to NUMA nodes).
> >
> > Thanks! I was just reading the corresponding microblaze commit, and
> > think this approach makes sense. I'll test it now with both DT and
> > non-DT sh systems and let you know if it works. If it's good would you
> > like me to send it upstream via arch/sh? I already have 2
> > regression-fix patches to submit in a pull request asap.
> 
> Yes, please do.

OK. So far looks good. J2 works again (DT-based) and I'm now doing a
new build to test under qemu (r2d board) for non-DT sh.

Rich
