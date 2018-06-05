Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeFEBSz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:18:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34075 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeFEBSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:18:52 -0400
X-Google-Smtp-Source: ADUXVKJ32cOxhL9slSc/8RK8OB5BdRHP6Pg/Z/tnW5ifWnkBXpVrkiYIjqeHcV+66QjVdyHbvJStGQ==
Date: Mon, 04 Jun 2018 18:18:51 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Jun 2018 18:18:23 PDT (-0700)
Subject: Re: [PATCH] riscv: add riscv-specific predefines to CHECKFLAGS
In-Reply-To: <20180531154201.48618-1-luc.vanoostenryck@gmail.com>
CC: albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, luc.vanoostenryck@gmail.com
From: Palmer Dabbelt <palmer@sifive.com>
To: luc.vanoostenryck@gmail.com
Message-ID: <mhng-82ddb68f-98e3-422d-9828-8bff3ee48512@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 08:42:01 PDT (-0700), luc.vanoostenryck@gmail.com wrote:
> RISC-V uses the macro __riscv_xlen, predefined by GCC, to
> make the distinction between 32 or 64 bit code.
>
> However, sparse doesn't know anything about this macro
> which lead to wrong warnings and failures.
>
> Fix this by adding a define of __riscv_xlen to CHECKFLAGS
> and add one for __riscv too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  arch/riscv/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 76e958a54..6d4a5f6c3 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -71,6 +71,9 @@ KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
>  # architectures.  It's faster to have GCC emit only aligned accesses.
>  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>
> +# arch specific predefines for sparse
> +CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
> +
>  head-y := arch/riscv/kernel/head.o
>
>  core-y += arch/riscv/kernel/ arch/riscv/mm/

Thanks!
