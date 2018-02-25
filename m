Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeBYLAR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 06:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbeBYLAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 06:00:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D9821777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sun, 25 Feb 2018 20:00:09 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BUG] arm64: Build error with gcc 6
Message-Id: <20180225200009.80ba37b7837f9f1fb34f64fb@kernel.org>
In-Reply-To: <20180225051440.7d4ab5ajbb7lhdcr@sapphire.tkos.co.il>
References: <20180225115037.5613c91f061163dcf1d36023@kernel.org>
        <20180225051440.7d4ab5ajbb7lhdcr@sapphire.tkos.co.il>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2018 07:14:44 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Masami Hiramatsu,
> 
> On Sun, Feb 25, 2018 at 11:50:37AM +0900, Masami Hiramatsu wrote:
> > commit e1a50de37860 ("arm64: cputype: Silence Sparse warnings")
> > introduces "UL" suffix to a hex number, but it causes a build error with gcc-6 series.
> > I've hit below error with 6.2.1 and 6.4.1. Of course this is resolved by the latest
> > stable gcc-7.2.1. But from the compatibility point of view, should we revert it?
> > 
> >   AS      arch/arm64/kernel/head.o
> > /home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S: Assembler messages:
> > /home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > /home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > /home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: found 'L', expected: ')'
> > /home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: junk at end of line, first unrecognized character is `L'
> > /home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: unexpected characters following instruction at operand 2 -- `movz x1,:abs_g1_s:0xff00ffffffUL'
> > /home/mhiramat/ksrc/linux/arch/arm64/kernel/head.S:677: Error: unexpected characters following instruction at operand 2 -- `movk x1,:abs_g0_nc:0xff00ffffffUL'
> > make[2]: *** [/home/mhiramat/ksrc/linux/scripts/Makefile.build:425: arch/arm64/kernel/head.o] error 1
> > 
> > I've checked with below 2 latest gccs.
> > 
> > http://releases.linaro.org/components/toolchain/binaries/latest-6/aarch64-linux-gnu/gcc-linaro-6.4.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz
> > 
> > http://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu.tar.xz
> 
> The fix is pending:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=fixes/core&id=04c4927359b1f09310bfee92e7187c9022be3e00
> 
> This is in Linus' tree now, so should be in -rc3.

Great! I used linux-next tree and hit above bug, so I'll use linus tree.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
