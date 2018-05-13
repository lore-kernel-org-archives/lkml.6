Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeEMS4V (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 14:56:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeEMS4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 14:56:20 -0400
Date: Sun, 13 May 2018 20:56:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/boot/compressed/64: Fix moving page table out
 of trampoline memory
In-Reply-To: <20180510173806.4332-3-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805132045150.1582@nanos.tec.linutronix.de>
References: <20180510173806.4332-1-kirill.shutemov@linux.intel.com> <20180510173806.4332-3-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018, Kirill A. Shutemov wrote:

> top_pgtable address has to be calculated relative to where the kernel
> image will be relocated for decompression, not relative to position of
> kernel is running at the moment. We do the same for the rest of page
> table we use the stage. It makes them safe from being overwritten during
> decompression.
> 
> Calculate the address of top_pgtable in assembly and pass down to
> cleanup_trampoline().
> 
> Move the page table to .pgtable section where the rest of page tables
> are. The section is @nobits so we save 4k in kernel image.

So this is supposed to be a fix, but the whole changelog talks about WHAT
the patch does and not WHY. Darn, we need proper description of the failure
which is about to be fixed.

It's not that hard and I'm really tired to tell you that over and over.

>  	/*
>  	 * cleanup_trampoline() would restore trampoline memory.
>  	 *
> +	 * RDI is address of the page table to use instead of page table
> +	 * in trampoline memory (if required).

Do you really believe that you understand that comment 6 month from now?

Thanks,

	tglx
