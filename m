Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeEOJ6U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:58:20 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36818 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeEOJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:58:16 -0400
Date: Tue, 15 May 2018 11:58:14 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 13/18] kernel: add kcompat_sys_{f,}statfs64()
Message-ID: <20180515095814.GA14007@isilmar-4.linta.de>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-14-mark.rutland@arm.com>
 <20180514171427.qyietn3fhilwokb2@lakrids.cambridge.arm.com>
 <20180514203414.GB26773@light.dominikbrodowski.net>
 <20180515095351.lw5gxap4ii5iobtb@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515095351.lw5gxap4ii5iobtb@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 10:53:51AM +0100, Mark Rutland wrote:
> On Mon, May 14, 2018 at 10:34:14PM +0200, Dominik Brodowski wrote:
> > On Mon, May 14, 2018 at 06:14:28PM +0100, Mark Rutland wrote:
> > > On Mon, May 14, 2018 at 10:46:35AM +0100, Mark Rutland wrote:
> > > > +#ifdef CONFIG_COMPAT
> > > > +int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz,
> > > > +		     struct compat_statfs64 __user * buf);
> > > > +int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
> > > > +			  struct compat_statfs64 __user * buf);
> > > > +#endif
> > > 
> > > I've moved these to <linux/compat.h>, so that they live with the rest of
> > > the compat syscall stuff. That should avoid build failures the kbuild
> > > test robot picked up where compat_size_t wasn't dfined.
> > 
> > Please add a comment there, similar to what is in syscalls.h:
> > 
> > 	/*
> > 	 * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
> > 	 * Instead, use one of the functions which work equivalently, such as
> > 	 * the ksys_xyzyyz() functions prototyped below.
> > 	 */
> 
> To make the kcompat_sys_* naming scheme clearer, I've added compat references to
> the above, i.e.
> 
> /*
>  * Kernel code should not call compat syscalls (i.e., compat_sys_xyzyyz())
>  * directly. Instead, use one of the functions which work equivalently, such
>  * as the kcompat_sys_xyzyyz() functions prototyped below.
>  */

That's what I meant ;)

> > Once you have done so, feel free to add my
> > 
> > 	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> I hope that this still stands with the changes above?

It does. Thanks!

	Dominik
