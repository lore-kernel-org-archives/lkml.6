Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521654020; cv=none;
        d=google.com; s=arc-20160816;
        b=WKDFPQfKq4pqvT23oMntX9r1XGAYZfItk04nvO8ylv75kulvwNrRR0ZshOp0N63V9w
         cLqBamPqDwPCS0yYvj+2xOY66nix18+uLFuwjyt/Niut08AtzKI92eVU2/8CXF9z9Y6r
         zflFlJNu5dUkxOhop+9xDlrqidXJkNXfvGbuLMGOr78W5K8pGKX/Ko9HErky7svlH6yQ
         snRhDspqljqT7FIulCR4XVMgGM4lVkCzLVXzV/LheV3thn/utI1Ad3/GAvOy1QWBHzt3
         V1O03eEmmapCe9Q4X/Xk4i4GbySvCsBUkD5zvPSYlXcajUkGB4fxxBLlwtGutD/BDxq5
         NUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ngyNN2hyjrw4TGPRn4ULbS+XQ8fgpIlslVDNg6klWlY=;
        b=mtIoUfrsvuIJF+kAW5F/t76pDudaz9cEIlLBZUuFTzxpBOoy5JTE+SHpm182RsSt0o
         NrpD7EbjSNneFSf1+xX5ZU21tsJlnQlznYxL+AOSYBWucLaV6c2dCNnT0BaCN8wa4bv2
         vUyV28cBXewx/UXbSKFu8PwUCKHvYpXVMp1CWmXxXF0UCCWs7Ff1jy28wmWyHcZkFJHJ
         SXlOItwu+Fp72XOoikKp6g4YhBLgINYK3NL21G2nrr6ZbBN2FN5/8Qm4Vr33P6aVGHaj
         sZvN6VUb7WfSnqEwN99p73O9QgLiEvLXxsdcHmauaFBDlMUmYlCy2b9UZUlTb6L9XMdT
         wO/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gb/ujxMj;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gb/ujxMj;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvgPb2ptihOyjOEqgeHw2QpdSjzHRCfUefjR4DCfg32BLLiPRDtAXj971f3yFhwcBMKTa01syvglfbYK1BsdVI=
MIME-Version: 1.0
In-Reply-To: <20180321163745.12286-1-logang@deltatee.com>
References: <20180321163745.12286-1-logang@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Mar 2018 19:40:19 +0200
Message-ID: <CAHp75VdjiBvAROe_rkqqWVZUPSnXQgrURZ0CUq1gxss+vJge3Q@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] Add io{read|write}64 to io-64-atomic headers
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565960791638927?=
X-GMAIL-MSGID: =?utf-8?q?1595569886688822178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 6:37 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
> This is v13 of my cleanup series to push a number of instances of people
> defining their own io{read|write}64 functions into common headers seing
> they don't exist in non-64bit systems. This series adds inline functions to the
> io-64-nonatomic headers and then cleans up the drivers that defined their
> own copies.
>
> This cleanup was originally requested by Greg after he reviewed my
> Switchtec NTB code. And I hope someone can pick it up or at least give
> feedback on it soon as it's been around relatively unchanged for a few
> cycles now and I'm getting a bit tired of resubmitting it with little to
> no interest.
>


The first patches that I didn't reviewed before makes sense to me, the
rest (at the end) FWIW,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Thanks,
>
> Logan
>
> --
>
> Changes since v12:
> - Rebased onto v4.16-rc6
> - Split patch 0001 into two and reworked the commit log as requested
>   by Luc Van Oostenryck
>
> Changes since v11:
> - Rebased onto v4.16-rc5
> - Added a patch (0001) to fix some old and new sparse warnings
>   that the kbuild robot warned about this cycle. The latest version
>   of sparse was required to reproduce these.
> - Added a patch (0002) to add io{read|write}64 to parisc which the kbuild
>   robot also found errors for this cycle
>
> Changes since v10:
> - Rebased onto v4.16-rc4, this droped the drm/tilcdc patch which was
>   picked up by that tree and is already in 4.16.
>
> Changes since v9:
> - Rebased onto v4.15-rc6
> - Fixed a couple of issues in the new version of the CAAM patch as
>   pointed out by Horia
>
> Changes since v8:
> - Rebased onto v4.15-rc2, as a result rewrote patch 7 seeing someone did
>   some similar cleanup in that area.
> - Added a patch to clean up the Switchtec NTB driver which landed in
>   v4.15-rc1
>
> Changes since v7:
> - Fix minor nits from Andy Shevchenko
> - Rebased onto v4.14-rc1
>
> Changes since v6:
>  ** none **
>
> Changes since v5:
> - Added a fix to the tilcdc driver to ensure it doesn't use the
>   non-atomic operation. (This includes adding io{read|write}64[be]_is_nonatomic
>   defines).
>
> Changes since v4:
> - Add functions so the powerpc implementation of iomap.c compiles. (As
>   noticed by Horia)
>
> Changes since v3:
>
> - I noticed powerpc didn't use the appropriate functions seeing
>   readq/writeq were not defined when iomap.h was included. Thus I've
>   included a patch to adjust this
> - Fixed some mistakes with a couple of the defines in io-64-nonatomic*
>   headers
> - Fixed a typo noticed by Horia.
>
> (earlier versions were drastically different)
>
> --
>
> Logan Gunthorpe (10):
>   iomap: Use correct endian conversion function in mmio_writeXXbe
>   iomap: Fix sparse endian check warnings
>   parisc: iomap: introduce io{read|write}64
>   powerpc: io.h: move iomap.h include so that it can use readq/writeq
>     defs
>   powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}
>   iomap: introduce io{read|write}64_{lo_hi|hi_lo}
>   io-64-nonatomic: add io{read|write}64[be]{_lo_hi|_hi_lo} macros
>   ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks
>   crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64
>   ntb: ntb_hw_switchtec: Cleanup 64bit IO defines to use the common
>     header
>
>  arch/parisc/include/asm/io.h           |   9 +++
>  arch/parisc/lib/iomap.c                |  64 +++++++++++++++
>  arch/powerpc/include/asm/io.h          |   6 +-
>  arch/powerpc/kernel/iomap.c            |  40 ++++++++++
>  drivers/crypto/caam/regs.h             |  30 +------
>  drivers/ntb/hw/intel/ntb_hw_intel.c    |  30 +------
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  36 +--------
>  include/asm-generic/iomap.h            |  26 ++++--
>  include/linux/io-64-nonatomic-hi-lo.h  |  64 +++++++++++++++
>  include/linux/io-64-nonatomic-lo-hi.h  |  64 +++++++++++++++
>  lib/iomap.c                            | 140 ++++++++++++++++++++++++++++++++-
>  11 files changed, 409 insertions(+), 100 deletions(-)
>
> --
> 2.11.0



-- 
With Best Regards,
Andy Shevchenko
