Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeEDM4b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:56:31 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:42836 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeEDM4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:56:30 -0400
Date: Fri, 4 May 2018 14:56:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Robert Richter <rric@kernel.org>
Cc: Matt Redfearn <matt.redfearn@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180504125601.GA30595@linux-mips.org>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
 <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
 <20180504102600.GD4493@rric.localdomain>
 <294858af-9164-f0c3-62d3-d6b643e89e09@mips.com>
 <20180504122750.GE4493@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504122750.GE4493@rric.localdomain>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 02:27:51PM +0200, Robert Richter wrote:

> On 04.05.18 12:03:12, Matt Redfearn wrote:
> > >As said, oprofile version 0.9.x is still available for cpus that do
> > >not support perf. What is the breakage?
> > 
> > The breakage I originally set out to fix was the MT support in perf.
> > https://www.linux-mips.org/archives/linux-mips/2018-04/msg00259.html
> > 
> > Since the perf code shares so much copied code from oprofile, those same
> > issues exist in oprofile and ought to be addressed. But as newer oprofile
> > userspace does not use the (MIPS) kernel oprofile code, then we could,
> > perhaps, just remove it (as per the RFC). That would break legacy tools
> > (0.9.x) though...
> 
> Those support perf:
> 
>  (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)
> 
> Here is the total list of CPU_*:
> 
>  $ git grep -h config.CPU_ arch/mips/ | sort -u | wc -l
>  79
> 
> The comparisation might not be accurate, but at least gives a hint
> that there are many cpus not supporting perf. You would drop profiling
> support at al to them.

The grep results are a bit missleading.  We have many symbols such as
CPU_MIPS32_R1 which describe a particular architecture revision supported
by a CPU.  Others CPU_* symbols are describing particular features or
options so in reality there are far fewer CPU to be supported.  Also
many of the older processors or embedded cores don't have performance
counters at all; for yet other cores presence, number and a few other
details can be configured when synthesizing the RTL so relying on the
CONFIG_* alone won't help.

> If it is too hard to also fix the oprofile code (code duplication
> seems the main issue here), then it would be also ok to blacklist
> newer cpus to enable oprofile kernel code (where it is broken).

  Ralf
