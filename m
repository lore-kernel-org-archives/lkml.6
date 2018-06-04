Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeFDXYv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:24:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38090 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeFDXYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:24:47 -0400
X-Google-Smtp-Source: ADUXVKIpibBa2xgqGzYNKRhmwgAJFV7xreMDs9QPy8EoS/Ypa+AWS4Mdy5x5XQtQs6st+6x7gUkYuA==
Date: Mon, 04 Jun 2018 16:24:46 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Jun 2018 16:20:45 PDT (-0700)
Subject: Re: [PATCHv2 02/16] atomics/treewide: remove redundant atomic_inc_not_zero() definitions
In-Reply-To: <20180529154346.3168-3-mark.rutland@arm.com>
CC: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        boqun.feng@gmail.com, Will Deacon <will.deacon@arm.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: mark.rutland@arm.com
Message-ID: <mhng-0f8e5c80-72d9-422b-a905-cc49dde7976a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 08:43:32 PDT (-0700), mark.rutland@arm.com wrote:
> When atomic_inc_not_zero(v) isn't defined, <linux/atomic.h> will define
> it as falling back to atomic_add_unless((v), 1, 0), so there's no need
> for arch code to do so.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arc/include/asm/atomic.h     | 2 --
>  arch/hexagon/include/asm/atomic.h | 2 --
>  arch/riscv/include/asm/atomic.h   | 9 ---------
>  3 files changed, 13 deletions(-)
> [...]
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 739e810c857e..0e27e050ba14 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -375,15 +375,6 @@ static __always_inline int atomic64_add_unless(atomic64_t *v, long a, long u)
>  }
>  #endif
>
> -/*
> - * The extra atomic operations that are constructed from one of the core
> - * LR/SC-based operations above.
> - */
> -static __always_inline int atomic_inc_not_zero(atomic_t *v)
> -{
> -        return atomic_fetch_add_unless(v, 1, 0);
> -}
> -
>  #ifndef CONFIG_GENERIC_ATOMIC64
>  static __always_inline long atomic64_inc_not_zero(atomic64_t *v)
>  {

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
