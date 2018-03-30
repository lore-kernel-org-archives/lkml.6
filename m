Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeC3Sbl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 14:31:41 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:48970 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeC3Sbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 14:31:40 -0400
Date: Fri, 30 Mar 2018 20:31:17 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        viro@zeniv.linux.org.uk, x86@kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, luto@amacapital.net
Subject: Re: [PATCH] syscalls: define and explain goal to not call syscalls
 in the kernel
Message-ID: <20180330183117.GA11444@light.dominikbrodowski.net>
References: <20180325162527.GA17492@light.dominikbrodowski.net>
 <20180330093518.3d8a92f3@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330093518.3d8a92f3@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon,

On Fri, Mar 30, 2018 at 09:35:18AM -0600, Jonathan Corbet wrote:
> On Sun, 25 Mar 2018 18:25:27 +0200
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > As there have been multiple inquiries on the rationale of my patchsets
> > removing in-kernel calls to sys_xyzzy(), here is an updated patch 01/NN
> > which I will push upstream for v4.17-rc1. I will also include a reference
> > to this mail (and therefore to the explanation below) in all related
> > patches of the series. Any improvements, hints, suggestions, spelling
> > fixes, and/or objections?
> 
> I have no objections to the text, but I do wonder about the placement.
> The "adding syscalls" document isn't about *invoking* them; I suspect that
> few people will see it there.  The coding-style document isn't quite right
> either, but I wonder if it might not be a better place in the short term?

Well, most of the existing instances where syscalls were called in the
kernel were common codepaths for old and new syscalls or native and compat
syscalls, and syscall multiplexers like sys_ipc() which got replaced or
superseded by many new syscalls. That's what lead me to 
Documentation/process/adding-syscalls.rst . I'm happy to move this text to
Documentation/process/coding-style.rst (as new section 21?), or even to
Documentation/process/do-not-call-syscalls.rst . Just let me know what you
prefer me to push upstream.

Thanks,
	Dominik
