Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeEDM15 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:27:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53275 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:27:55 -0400
X-Google-Smtp-Source: AB8JxZoWQn55TauI56QCwbIbaqvwMPX1pdLDtOqUrjYrEBNCzXBMQASJdZ7pA5K7z6CB3S5Kq8jTuA==
Date: Fri, 4 May 2018 14:27:51 +0200
From: Robert Richter <rric@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Huacai Chen <chenhc@lemote.com>,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, oprofile-list@lists.sf.net
Subject: Re: [RFC PATCH] MIPS: Oprofile: Drop support
Message-ID: <20180504122750.GE4493@rric.localdomain>
References: <1524574554-7451-1-git-send-email-matt.redfearn@mips.com>
 <20180424130511.GB28813@saruman>
 <5e464a40-4e4d-dde4-b5b5-ceb637dc5f38@mips.com>
 <20180504093002.GC4493@rric.localdomain>
 <dd951d1e-206d-78dd-49ae-3a16cad9ebcc@mips.com>
 <20180504102600.GD4493@rric.localdomain>
 <294858af-9164-f0c3-62d3-d6b643e89e09@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <294858af-9164-f0c3-62d3-d6b643e89e09@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.18 12:03:12, Matt Redfearn wrote:
> >As said, oprofile version 0.9.x is still available for cpus that do
> >not support perf. What is the breakage?
> 
> The breakage I originally set out to fix was the MT support in perf.
> https://www.linux-mips.org/archives/linux-mips/2018-04/msg00259.html
> 
> Since the perf code shares so much copied code from oprofile, those same
> issues exist in oprofile and ought to be addressed. But as newer oprofile
> userspace does not use the (MIPS) kernel oprofile code, then we could,
> perhaps, just remove it (as per the RFC). That would break legacy tools
> (0.9.x) though...

Those support perf:

 (CPU_MIPS32 || CPU_MIPS64 || CPU_R10000 || CPU_SB1 || CPU_CAVIUM_OCTEON || CPU_XLP || CPU_LOONGSON3)

Here is the total list of CPU_*:

 $ git grep -h config.CPU_ arch/mips/ | sort -u | wc -l
 79

The comparisation might not be accurate, but at least gives a hint
that there are many cpus not supporting perf. You would drop profiling
support at al to them.

If it is too hard to also fix the oprofile code (code duplication
seems the main issue here), then it would be also ok to blacklist
newer cpus to enable oprofile kernel code (where it is broken).

-Robert
