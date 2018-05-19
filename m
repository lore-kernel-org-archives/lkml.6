Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeESIrm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:47:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55225 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeESIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:47:39 -0400
Date: Sat, 19 May 2018 10:47:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] x86/cpu: Move early cpu initialization into a separate
 translation unit
In-Reply-To: <20180518103528.59260-6-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805191047040.1599@nanos.tec.linutronix.de>
References: <20180518103528.59260-1-kirill.shutemov@linux.intel.com> <20180518103528.59260-6-kirill.shutemov@linux.intel.com>
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
> This patch moves early cpu initialization into a separate translation
> unit. This limits effect of USE_EARLY_PGTABLE_L5 to less code.
> 
> Without the change cpu_init() uses __pgtable_l5_enabled. cpu_init() is
> not __init function and it leads to section mismatch.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

This makes a lot of sense independent of 5level changes.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
