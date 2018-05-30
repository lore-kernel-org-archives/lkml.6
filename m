Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbeE3Ne6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:34:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56354 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753074AbeE3Nez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:34:55 -0400
Date: Wed, 30 May 2018 14:34:45 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: Re: [PATCHv2 00/16] atomics: API cleanups
Message-ID: <20180530133444.ovy3gtc7m6yoxcw2@lakrids.cambridge.arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com>
 <20180530112311.rwtbiqdpds75m4d6@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530112311.rwtbiqdpds75m4d6@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 12:23:12PM +0100, Mark Rutland wrote:
> -#ifdef atomic64_andnot
> -/* atomic64_fetch_andnot_relaxed */
> +#ifndef atomic_andnot
> +#define atomic_andnot(i, v)		atomic_and(~(int)(i), (v))
> +#endif

Ugh; s/atomic/atomic64 here.

I've pushed out a corrected branch.

Mark.
