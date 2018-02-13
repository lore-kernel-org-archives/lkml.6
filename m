Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933409AbeBMDZF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 22:25:05 -0500
Received: from ozlabs.org ([103.22.144.67]:36593 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933361AbeBMDZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 22:25:03 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal Hocko <mhocko@kernel.org>, Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>
Cc: linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: samples/seccomp/ broken when cross compiling s390, ppc allyesconfig
In-Reply-To: <20180212133731.GE3443@dhcp22.suse.cz>
References: <20180212133731.GE3443@dhcp22.suse.cz>
Date: Tue, 13 Feb 2018 14:25:01 +1100
Message-ID: <87r2ppvaeq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:
> Hi,
> my build test machinery chokes on samples/seccomp when cross compiling
> s390 and ppc64 allyesconfig. This has been the case for quite some
> time already but I never found time to look at the problem and report
> it. It seems this is not new issue and similar thing happend for
> MIPS e9107f88c985 ("samples/seccomp/Makefile: do not build tests if
> cross-compiling for MIPS").
>
> The build logs are attached.
>
> What is the best way around this? Should we simply skip compilation on
> cross compile or is actually anybody relying on that? Or should I simply
> disable it for s390 and ppc?

The whole thing seems very confused. It's not building for the target,
it's building for the host, ie. the Makefile sets hostprogs-m and
HOSTCFLAGS etc.

So it can't possibly work with cross compiling as it's currently
written.

Either the Makefile needs some serious work to properly support cross
compiling or it should just be disabled when cross compiling.

cheers
