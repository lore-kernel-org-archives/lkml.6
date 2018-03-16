Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbeCPLPH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:15:07 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:51028 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbeCPLPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:15:06 -0400
Date: Fri, 16 Mar 2018 12:13:04 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Jiri Slaby <jslaby@suse.com>, x86@kernel.org
Subject: Re: [PATCH v2 13/36] x86/ioport: add ksys_ioperm() helper; remove
 in-kernel calls to sys_ioperm()
Message-ID: <20180316111304.GA5302@light.dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
 <20180315190529.20943-14-linux@dominikbrodowski.net>
 <20180316084308.GB4151@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
In-Reply-To: <20180316084308.GB4151@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 01:43:08AM -0700, Christoph Hellwig wrote:
> On Thu, Mar 15, 2018 at 08:05:06PM +0100, Dominik Brodowski wrote:
> > Using this helper allows us to avoid the in-kernel calls to the sys_ioperm()
> > syscall.
> 
> Why not do_ioperm or kernel_ioperm as for most other syscalls?

The newly introduced ksys_*() functions/helpers/wrappers take the same
parameters and use the same calling conventions as the "real" syscalls, and
are made available through include/linux/syscalls.h for (at least temporary)
in-kernel use.

Contrary to that, do_*() are mostly kept internal to one file or subsystem,
and seem to be more flexible with the calling convention. Same for
kernel_*().

But if you prefer the do_*() or kernel_*() namespace for the
in-kernel-syscall-equivalent for fs/*, I'm fine with that, just let me know.

Thanks,
	Dominik
