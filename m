Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeESIoK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:44:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55186 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeESIoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:44:05 -0400
Date: Sat, 19 May 2018 10:43:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] x86/boot/compressed/64: Fix trampoline page table
 address calculation
In-Reply-To: <20180518103528.59260-2-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805191043480.1599@nanos.tec.linutronix.de>
References: <20180518103528.59260-1-kirill.shutemov@linux.intel.com> <20180518103528.59260-2-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018, Kirill A. Shutemov wrote:

> Hugh noticied that I calculate address of trampoline page table wrongly
> in cleanup_trampoline(). TRAMPOLINE_32BIT_PGTABLE_OFFSET has to be
> divided by sizeof(unsigned long) since trampoline_32bit is unsigned long
> pointer.
> 
> TRAMPOLINE_32BIT_PGTABLE_OFFSET is zero so the bug doesn't have a
> visible effect.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Hugh Dickins <hughd@google.com>
> Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
