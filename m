Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeCLHwI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:52:08 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:33898 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbeCLHwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:52:05 -0400
Date: Mon, 12 Mar 2018 08:52:53 +0100
From: "Alvaro G. M." <alvaro.gamez@hazent.com>
To: Rob Herring <robh@kernel.org>
Cc: Michal Simek <monstr@monstr.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bug: Microblaze stopped booting after
 0fa1c579349fdd90173381712ad78aa99c09d38b
Message-ID: <20180312075252.GA15895@salem.gmr.ssr.upm.es>
References: <20180309125106.GA1644@salem.gmr.ssr.upm.es>
 <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLenrLARsjHvkkL3ByuXARPShz-VAEBDE2FukJc=vD+Sg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 01:05:11PM -0600, Rob Herring wrote:
> On Fri, Mar 9, 2018 at 6:51 AM, Alvaro G. M. <alvaro.gamez@hazent.com> wrote:
> > Hi,
> >
> > I've found via git bisect that 0fa1c579349fdd90173381712ad78aa99c09d38b
> > makes microblaze unbootable.
> >
> > I'm sorry I can't provide any console output, as nothing appears at all,
> > even when setting earlyprintk (or at least I wasn't able to get anything
> > back!).
> 
> Ah, looks like microblaze doesn't set CONFIG_NO_BOOTMEM and so
> memblock_virt_alloc() doesn't work for CONFIG_HAVE_MEMBLOCK &&
> !CONFIG_NO_BOOTMEM. AFAICT, microblaze doesn't really need bootmem and
> it can be removed, but I'm still investigating. Can you try out this
> branch[1].
> 
> Rob
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> microblaze-fixes

Hi, Rob!

This branch does indeed solve the issue. My microblaze system is now
booting as it did before, and everything seems normal now. Thanks!

Tested-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>


-- 
Alvaro G. M.
