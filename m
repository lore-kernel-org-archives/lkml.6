Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeESIsI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:48:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55234 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeESIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:48:04 -0400
Date: Sat, 19 May 2018 10:47:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] x86/mm: Mark p4d_offset() __always_inline
In-Reply-To: <20180518103528.59260-7-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805191047430.1599@nanos.tec.linutronix.de>
References: <20180518103528.59260-1-kirill.shutemov@linux.intel.com> <20180518103528.59260-7-kirill.shutemov@linux.intel.com>
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

> __pgtable_l5_enabled shouldn't be needed after system has booted, we can
> mark it as __initdata, but it requires preparation.
> 
> KASAN initialization code is a user of USE_EARLY_PGTABLE_L5, so all
> pgtable_l5_enabled() translated to __pgtable_l5_enabled there, including
> the one in p4d_offset().
> 
> It may lead to section mismatch, if a compiler would not inline
> p4d_offset(), but leave it as a standalone function: p4d_offset() is not
> marked as __init.
> 
> Marking p4d_offset() as __always_inline fixes the issue.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
