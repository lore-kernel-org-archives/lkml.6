Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeEQMSE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:18:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:58449 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeEQMSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:18:02 -0400
Date: Thu, 17 May 2018 14:17:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ima: Fix pr_fmt() redefinition
Message-ID: <20180517121759.r6tqw3mj43morfwu@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20180517104702.24689-1-pvorel@suse.cz>
 <1526558695.3306.11.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526558695.3306.11.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> On Thu, 2018-05-17 at 12:47 +0200, Petr Vorel wrote:
> > Previous definition was too late and caused problems in powerpc allyesconfig:
> > security/integrity/ima/ima_kexec.c:18:0: warning: "pr_fmt" redefined
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

> > In file included from include/linux/kernel.h:14:0,
> >                  from include/asm-generic/bug.h:18,
> >                  from arch/powerpc/include/asm/bug.h:128,
> >                  from include/linux/bug.h:5,
> >                  from include/linux/seq_file.h:7,
> >                  from security/integrity/ima/ima_kexec.c:13:
> > include/linux/printk.h:288:0: note: this is the location of the previous definition
> >  #define pr_fmt(fmt) fmt

> > Fixes: 3dea0d93d257 ("ima: Unify logging")

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

> As the original patch hasn't been upstreamed yet, I'll squash this fix
> with the original patch.
Make sense, thanks!

> thanks!

> Mimi


Kind regards,
Petr
