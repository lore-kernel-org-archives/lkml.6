Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBZKgF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:36:05 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37999 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeBZKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:36:00 -0500
X-Google-Smtp-Source: AG47ELvGGPmhPf35+n/+9XcrYtyJklKeR42xbO9NLDCgQjfpihalWhuFYjGQ2O3bGIvvcNDjmxgmUg==
Date: Mon, 26 Feb 2018 11:35:52 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] riscv/barrier: Define __smp_{mb,rmb,wmb}
Message-ID: <20180226103552.GA9138@andrea>
References: <1519121848-28582-1-git-send-email-parri.andrea@gmail.com>
 <mhng-438aa1d8-2507-49a6-93d4-8622b6018ffd@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-438aa1d8-2507-49a6-93d4-8622b6018ffd@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:14:52PM -0800, Palmer Dabbelt wrote:
> On Tue, 20 Feb 2018 02:17:28 PST (-0800), parri.andrea@gmail.com wrote:
> >Introduce __smp_{mb,rmb,wmb}, and rely on the generic definitions
> >for smp_{mb,rmb,wmb}. A first consequence is that smp_{mb,rmb,wmb}
> >map to a compiler barrier on !SMP (while their definition remains
> >unchanged on SMP). As a further consequence, smp_load_acquire and
> >smp_store_release have "fence rw,rw" instead of "fence iorw,iorw".
> >
> >Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> >---
> > arch/riscv/include/asm/barrier.h | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> >index c0319cbf1eec5..5510366d169ae 100644
> >--- a/arch/riscv/include/asm/barrier.h
> >+++ b/arch/riscv/include/asm/barrier.h
> >@@ -34,9 +34,9 @@
> > #define wmb()		RISCV_FENCE(ow,ow)
> >
> > /* These barriers do not need to enforce ordering on devices, just memory. */
> >-#define smp_mb()	RISCV_FENCE(rw,rw)
> >-#define smp_rmb()	RISCV_FENCE(r,r)
> >-#define smp_wmb()	RISCV_FENCE(w,w)
> >+#define __smp_mb()	RISCV_FENCE(rw,rw)
> >+#define __smp_rmb()	RISCV_FENCE(r,r)
> >+#define __smp_wmb()	RISCV_FENCE(w,w)
> >
> > /*
> >  * This is a very specific barrier: it's currently only used in two places in
> 
> Thanks!  I'm going to take this for the next RC.

Thank you, Palmer.  I'm planning to post more changes to the file,
but I'd like to build on top of this change: could you point me to
the appropriate branch/repo for this?

  Andrea
