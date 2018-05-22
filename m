Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeEVJOM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:14:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38537 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVJOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:14:11 -0400
Date: Tue, 22 May 2018 11:14:08 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <gleep@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86: UV: raw_spinlock conversion
Message-ID: <20180522091408.nt4fodr4f5ikk5ow@linutronix.de>
References: <20180504111459.24825-1-bigeasy@linutronix.de>
 <20180504111459.24825-2-bigeasy@linutronix.de>
 <alpine.DEB.2.21.1805061225550.1685@nanos.tec.linutronix.de>
 <1525604359.28142.3.camel@gmx.de>
 <20180507073928.shmtfpqyhgxya53b@linutronix.de>
 <1526738996.5365.1.camel@gmx.de>
 <20180522065051.xy42nwvcxz2nekti@linutronix.de>
 <1526977462.6491.1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1526977462.6491.1.camel@gmx.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-22 10:24:22 [+0200], Mike Galbraith wrote:
> On Tue, 2018-05-22 at 08:50 +0200, Sebastian Andrzej Siewior wrote:
> > 
> > Regarding the preempt_disable() in the original patch in uv_read_rtc():
> > This looks essential for PREEMPT configs. Is it possible to get this
> > tested by someone or else get rid of the UV code? It looks broken for
> > "uv_get_min_hub_revision_id() != 1".
> 
> I suspect SGI cares not one whit about PREEMPT.

so it is broken then. I leave it to the x86 maintainers but on the very
least it should depend on !PREEMPT (if not server).

> > Why does PREEMPT_RT require migrate_disable() but PREEMPT only is fine
> > as-is? This does not look right.
> 
> UV is not ok with a PREEMPT config, it's just that for RT it's dirt
> simple to shut it up, whereas for PREEMPT, preempt_disable() across
> uv_bau_init() doesn't cut it due to allocations, and whatever else I
> would have met before ending the whack-a-mole game.
> 
> If I were in your shoes, I think I'd just stop caring about UV until a
> real user appears.  AFAIK, I'm the only guy who ever ran RT on UV, and
> I only did so because SUSE asked me to look into it.. years ago now.

Okay. The problem I have with this patch is that it remains RT only
while the problem it addresses is not RT-only and PREEMPT kernels are
very much affected.
The thing is that *you* are my only UV user :) If you suggest that I
should stop caring about UV than I do so. Please post a patch that adds
a dependency to UV on PREEMPT so that part of the architecture is
documented.

> 	-Mike

Sebastian
