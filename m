Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeBVXOy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:14:54 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44036 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeBVXOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:14:53 -0500
X-Google-Smtp-Source: AH8x227vu0GU3HXqh57QEBAxHH5nSlBO9LVRm0gG4buMDSMO3RUowpM2/5WO16NdpF8PkrmQ2JBN8g==
Date: Thu, 22 Feb 2018 15:14:52 -0800 (PST)
X-Google-Original-Date: Thu, 22 Feb 2018 14:58:37 PST (-0800)
Subject: Re: [PATCH RFC] riscv/barrier: Define __smp_{mb,rmb,wmb}
In-Reply-To: <1519121848-28582-1-git-send-email-parri.andrea@gmail.com>
CC: albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, parri.andrea@gmail.com
From: Palmer Dabbelt <palmer@sifive.com>
To: parri.andrea@gmail.com
Message-ID: <mhng-438aa1d8-2507-49a6-93d4-8622b6018ffd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018 02:17:28 PST (-0800), parri.andrea@gmail.com wrote:
> Introduce __smp_{mb,rmb,wmb}, and rely on the generic definitions
> for smp_{mb,rmb,wmb}. A first consequence is that smp_{mb,rmb,wmb}
> map to a compiler barrier on !SMP (while their definition remains
> unchanged on SMP). As a further consequence, smp_load_acquire and
> smp_store_release have "fence rw,rw" instead of "fence iorw,iorw".
>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  arch/riscv/include/asm/barrier.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> index c0319cbf1eec5..5510366d169ae 100644
> --- a/arch/riscv/include/asm/barrier.h
> +++ b/arch/riscv/include/asm/barrier.h
> @@ -34,9 +34,9 @@
>  #define wmb()		RISCV_FENCE(ow,ow)
>
>  /* These barriers do not need to enforce ordering on devices, just memory. */
> -#define smp_mb()	RISCV_FENCE(rw,rw)
> -#define smp_rmb()	RISCV_FENCE(r,r)
> -#define smp_wmb()	RISCV_FENCE(w,w)
> +#define __smp_mb()	RISCV_FENCE(rw,rw)
> +#define __smp_rmb()	RISCV_FENCE(r,r)
> +#define __smp_wmb()	RISCV_FENCE(w,w)
>
>  /*
>   * This is a very specific barrier: it's currently only used in two places in

Thanks!  I'm going to take this for the next RC.
