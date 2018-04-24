Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeDXORe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:17:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54284 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757906AbeDXORd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:17:33 -0400
Date: Tue, 24 Apr 2018 15:17:29 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64: support __int128 with clang
Message-ID: <20180424141729.r7wfnos3p2kdt3ez@lakrids.cambridge.arm.com>
References: <20171223004323.1986-1-Jason@zx2c4.com>
 <CAHmME9otwT+14LhmebF8Osna7m_u6xvFEi7pMq2v1-k9WD5Lpw@mail.gmail.com>
 <20180424133527.GB24599@arm.com>
 <20180424135608.m5uxhmclhnljpbau@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424135608.m5uxhmclhnljpbau@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 02:56:09PM +0100, Mark Rutland wrote:
> I belevie that currently it is not possible to use a released version of
> clang to build a working kernel without additional patches (at least
> 5.0.0, there don't seem to be any 6.0.0 binaries that can target
> AArch64). Issues include:
> 
> * Released versions of clang don't support the 's' constraint used in
>   some hyp code.
> 

> * Released versions of clang don't support 'rX' as a register name, as
>   is used by some workaround code shared between arm/arm64.

This case will apparently be fixed for 6.0.1 (and presumably 7.0.0):

https://reviews.llvm.org/rL328829
https://bugs.llvm.org/show_bug.cgi?id=36862

Neither have been released yet.

Mark.
