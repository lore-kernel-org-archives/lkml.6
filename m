Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeEQP5T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:57:19 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:51740 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeEQP5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:57:18 -0400
Date: Thu, 17 May 2018 17:50:21 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: tj@kernel.org, torvalds@linux-foundation.org, carlos@redha.com,
        luto@amacapital.net, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] better visibility into kworkers
Message-ID: <20180517155021.GA5480@gardel-login>
References: <20180517074202.GA3091@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517074202.GA3091@avx2>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 17.05.18 10:42, Alexey Dobriyan (adobriyan@gmail.com) wrote:

> > The kernel APIs for all this aren't really good
> > though, and I always was reluctant to check for PF_KTHREAD, as that
> > flag is neither documented for userspace, nor available in any
> > userspace-accessible headers. However, I wanted to tighten this a bit,
> > and hence we now define the flag in our own code, as it appeared to me
> > otherwise there was no chance to ever make this fully robust.
> 
> PF_KTHREAD was introduced in 2.6.27 and its value appears to be stable
> since then. I think it should be retroactively declared part of ABI
> otherwise people will continue to rediscover that all other means do not
> work.

Yes, I agree. And it's exposed to userspace after all, though not
symbolic, but simply as flags value.

> Empty /proc/*/exe is second best option for systemd and it's only one
> system call.

That doesn't really work for us as readlink() on that requires
CAP_SYS_PTRACE, and we need something that works unprivileged, which
PF_KTHREAD does.

Lennart

-- 
Lennart Poettering, Red Hat
