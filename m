Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeEPGDA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:03:00 -0400
Received: from verein.lst.de ([213.95.11.211]:45666 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbeEPGC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:02:58 -0400
Date: Wed, 16 May 2018 08:07:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/2] arch/*: Add CONFIG_ARCH_HAVE_CMPXCHG64
Message-ID: <20180516060722.GA24855@lst.de>
References: <20180515225124.20428-1-bart.vanassche@wdc.com> <20180515225124.20428-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515225124.20428-5-bart.vanassche@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config ARCH_HAVE_CMPXCHG64
> +	bool

64-bit architectures must support this as long is 64-bits wide.

So this should have a

	default y if 64BIT

which also means you only need to explicitly select in on 32-bit
architectures that support 64-bit cmpxchg.
