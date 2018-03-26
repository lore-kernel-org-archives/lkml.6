Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeCZKE7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:04:59 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:47990 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeCZKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:04:57 -0400
Date: Mon, 26 Mar 2018 11:58:55 +0200
From: Mark Wielaard <mjw@fedoraproject.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Clifton <nickc@redhat.com>, Cary Coutant <ccoutant@gmail.com>
Subject: Re: [RFC PATCH 0/3] Salted build ids via linker sections
Message-ID: <20180326095855.GA9061@wildebeest.org>
References: <20180321014635.29113-1-labbott@redhat.com>
 <CAK7LNAQTf_tVvks==_wGsEeNs6Bpdcfy9k39fpzneFvVZGAOiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQTf_tVvks==_wGsEeNs6Bpdcfy9k39fpzneFvVZGAOiA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 26, 2018 at 04:48:11PM +0900, Masahiro Yamada wrote:
> 2018-03-21 10:46 GMT+09:00 Laura Abbott <labbott@redhat.com>:
> > In Fedora, the debug information is packaged separately (foo-debuginfo) and
> > can be installed separately. There's been a long standing issue where only one
> > version of a debuginfo info package can be installed at a time. Mark Wielaard
> > made an effort for Fedora 27 to allow parallel installation of debuginfo (see
> > https://fedoraproject.org/wiki/Changes/ParallelInstallableDebuginfo for
> > more details)
> 
> Is this a kernel-specific problem?
> 
> IIUC, the URL above is discussing packages in general.
> 
> Any executable from slightly different versions
> could result in identical ELF.
> If so, will you tweak link process of every package
> that needs parallel installation?

For almost any package it isn't necessary to tweak the link process
because the build-id can be tweaked if necessary at any stage of the
package process (the most convenient is during debuginfo splitting,
because the debuginfo contains almost all the information of the
build environment). The kernel vdso build is a bit special because it
embeds the executable also inside the kernel image (so it shows up at
runtime again not from the file system, but by being inserted into the
process by the kernel), where packaging tools cannot easily find it.

Cheers,

Mark
