Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbeCPKie (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:38:34 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:49092 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753735AbeCPKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:38:32 -0400
Date: Fri, 16 Mar 2018 11:25:06 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Zhang, Ning A" <ning.a.zhang@intel.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2 00/36] remove in-kernel syscall invocations (part 1)
Message-ID: <20180316102506.GA769@light.dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <1521190870.1367.33.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521190870.1367.33.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 09:01:11AM +0000, Zhang, Ning A wrote:
> 在 2018-03-15四的 20:04 +0100，Dominik Brodowski写道：
> > Here is a re-spin of the first set of patches which reduce the number of
> > syscall invocations from within the kernel; the RFC may be found at
> > 
> > The rationale for this change is described in patch 1 as follows:
> > 
> > 	The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
> > 	and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
> > 	through kernel entry points, but not from the kernel itself. This
> > 	will allow cleanups and optimizations to the entry paths *and* to
> > 	the parts of the kernel code which currently need to pretend to be
> > 	userspace in order to make use of syscalls.
> 
> I think this is really bad to change syscalls one by one, to do_*
> 
> why not change SYSCALL_DEFINEx to define kernel wrappers?

Basically, for two reasons: First, only a subset of all syscalls require
such wrappers -- only about a third of all syscalls are called from within
the kernel at the moment (rough guess). Second, and more important: We want
to reduce the amount of such usage; see, e.g., the messages by Christoph and
Arnd in this thread.

Thanks,
	Dominik
