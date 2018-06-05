Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeFEVPF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:15:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47062 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeFEVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:15:03 -0400
Date: Tue, 5 Jun 2018 23:14:41 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: vfs_timespec64 merge into v4.18?
In-Reply-To: <CAK8P3a2M9RBKMXikFW2jZYwQnWXDjOJ6mzD6Jt85SVOnZkbXnQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806052312330.1584@nanos.tec.linutronix.de>
References: <CAK8P3a2M9RBKMXikFW2jZYwQnWXDjOJ6mzD6Jt85SVOnZkbXnQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2018, Arnd Bergmann wrote:
> Hi everyone,
> 
> As I discussed with Thomas on IRC, I'd still like to try to get Deepa's series
> merged to have 64-bit inode timestamps in VFS, as a prerequisite to fixing
> the individual file systems for y2038 as the next step.
> 
> The orignal tree that I've been testing with is in
> https://github.com/deepa-hub/vfs vfs_timespec64 (see description at [1]
> Unfortunately this was never in linux-next so far, so it's definitely
> against our
> normal rules, and if there are any objections (or new issues getting found),
> then we should defer it another merge window.
> 
> Until very recently, the branch worked fine with both linux-next and 4.17-rc,
> but with some last minute changes to the NFS and Overlayfs trees, it
> gained some nasty conflicts.
> 
> I've merged Trond's NFS branch and Miklos' Overlayfs branches into
> it, fixed up those conflicts and now uploaded it to my tree at
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> Obviously this will break if either of them rebases their trees once
> more, in which case I assume Stephen will drop my branch from
> linux-next.
> 
> Once those two are merged into mainline and nothing unexpected
> has come up from linux-next testing, we could either send a pull request
> to Linus for the merged branch, or regenerate the flag-day patch in it
> using coccinelle, which should result in identical contents.

I think there is no point to drag that out for the next merge window. The
whole thing needs to be done in one go for the core changes which means
that you're going to play that catchup game forever. Let's get over with it
towards the end of the merge window.

Thanks,

	tglx
