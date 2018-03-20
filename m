Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeCTDhM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:37:12 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47367 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750968AbeCTDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:37:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05462646|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e04463;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.BNB.r7C_1521517016;
Date: Tue, 20 Mar 2018 11:36:56 +0800
From: Guo Ren <ren_guo@c-sky.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Subject: Re: [PATCH 14/19] csky: Misc headers
Message-ID: <20180320033654.GA21731@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <9cb4cf158b8c73325dc524cba8d575e41647131f.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a15wbEmejpiokATLW=Cwe-XHZEdgU8fNQY-opjbjuU3-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a15wbEmejpiokATLW=Cwe-XHZEdgU8fNQY-opjbjuU3-w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Mar 20, 2018 at 12:11:24AM +0800, Arnd Bergmann wrote:
> On Mon, Mar 19, 2018 at 3:51 AM, Guo Ren <ren_guo@c-sky.com> wrote:
> > +++ b/arch/csky/include/uapi/asm/fcntl.h
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +#ifndef __ASM_CSKY_FCNTL_H
> > +#define __ASM_CSKY_FCNTL_H
> > +
> > +#define O_DIRECTORY    040000
> > +#define O_NOFOLLOW     0100000
> > +#define O_DIRECT       0200000
> > +#define O_LARGEFILE    0400000
> > +
> > +#include <asm-generic/fcntl.h>
> 
> This should just use the generic file without overrides: Please don't diverge
> from the generic syscall ABI.
>

It's a stupid copy from arm/include/uapi/asm/fcntl.h and the csky/bits/fcntl.h
in uclibc-ng and glibc are also defined with:

#define __O_DIRECTORY	 040000	/* Must be a directory.	 */
#define __O_NOFOLLOW	0100000	/* Do not follow links.	 */
#define __O_DIRECT	0200000	/* Direct disk access.	*/
#define __O_LARGEFILE	0400000

So may I keep it for a while?
(I will let glibc uclibc-ng csky/bits/fcntl.h include the linux/uapi/asm/fcntl.h
first.)


> > +struct __old_kernel_stat {
> > +       unsigned short st_dev;
> 
> Same here: no need for __old_kernel_stat  or the headers on new architectures.
>
OK

Best Regards
  Guo Ren
