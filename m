Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeCLTyZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:54:25 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:48706 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeCLTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:54:24 -0400
Date: Mon, 12 Mar 2018 20:14:16 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 01/35] syscalls: define goal to not call sys_xyzzy()
 from within the kernel
Message-ID: <20180312191416.GB16666@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312072749.5kerpqmvmg4gjagh@gmail.com>
 <CALCETrV3gUrL3fpr5EEjMyoWtj5t64hpYxjO+qJfUVTq7z1rNQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 03:24:01PM +0000, Andy Lutomirski wrote:
> On Sun, Mar 11, 2018 at 10:55 AM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > +
> > +/*
> > + * The kernel should not use call syscalls (i.e., sys_xyzyyz()) directly.
> > + * Instead, use one of the following functions which work equivalent to
> > + * the syscall they are named for.
> 
> "Instead, use one of the functions which work equivalently, e.g. do_xysyyz()"

On Mon, Mar 12, 2018 at 08:27:49AM +0100, Ingo Molnar wrote:
> The previous sentence has a typo as well, should be:
> 
>   * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.

Thanks for your feedback. Here's what I will do for v2, unless you find more
typos or areas for improvement:

	/*
	 * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
	 * Instead, use one of the functions which work equivalently, such as
	 * the ksys_xyzyyz() functions prototyped below.
	 */

Thanks,
	Dominik
