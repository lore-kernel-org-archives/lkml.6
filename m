Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbeEOCy2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:54:28 -0400
Received: from ozlabs.org ([203.11.71.1]:47239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbeEOCyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:54:12 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
In-Reply-To: <20180514184634.2160-2-bart.vanassche@wdc.com>
References: <20180514184634.2160-1-bart.vanassche@wdc.com> <20180514184634.2160-2-bart.vanassche@wdc.com>
Date: Tue, 15 May 2018 12:54:01 +1000
Message-ID: <87lgclpr1y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

Bart Van Assche <bart.vanassche@wdc.com> writes:
>
...
> diff --git a/Documentation/features/locking/cmpxchg64/arch-support.txt b/Documentation/features/locking/cmpxchg64/arch-support.txt
> new file mode 100644
> index 000000000000..65b3290ce5d5
> --- /dev/null
> +++ b/Documentation/features/locking/cmpxchg64/arch-support.txt
> @@ -0,0 +1,31 @@
> +#
> +# Feature name:          cmpxchg64
> +#         Kconfig:       ARCH_HAVE_CMPXCHG64
> +#         description:   arch supports the cmpxchg64() API
> +#
> +    -----------------------
> +    |         arch |status|
> +    -----------------------
> +    |       alpha: |  ok  |
> +    |         arc: | TODO |
> +    |         arm: |!thumb|
> +    |       arm64: |  ok  |
> +    |         c6x: | TODO |
> +    |       h8300: | TODO |
> +    |     hexagon: | TODO |
> +    |        ia64: |  ok  |
> +    |        m68k: |  ok  |
> +    |  microblaze: | TODO |
> +    |        mips: |64-bit|
> +    |       nios2: | TODO |
> +    |    openrisc: | TODO |
> +    |      parisc: |  ok  |
> +    |     powerpc: |64-bit|

I think that is correct for powerpc, we don't have a 32-bit
implementation and there's no fallback it seems.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -150,6 +150,7 @@ config PPC
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAS_ZONE_DEVICE		if PPC_BOOK3S_64
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
> +	select ARCH_HAVE_CMPXCHG64

So shouldn't this should be:

+	select ARCH_HAVE_CMPXCHG64		if PPC64

And it should be sorted alphabetically, ie. above the previous NMI entry.

cheers
