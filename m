Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeESIo5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:44:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55194 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbeESIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:44:54 -0400
Date: Sat, 19 May 2018 10:44:47 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] x86/mm: Unify pgtable_l5_enabled usage in early boot
 code
In-Reply-To: <20180518103528.59260-3-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1805191044350.1599@nanos.tec.linutronix.de>
References: <20180518103528.59260-1-kirill.shutemov@linux.intel.com> <20180518103528.59260-3-kirill.shutemov@linux.intel.com>
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

> Usually pgtable_l5_enabled is defined using cpu_feature_enabled().
> cpu_feature_enabled() is not available in early boot code. We use
> several different preprocessor tricks to get around it. It's messy.
> 
> Unify them all.
> 
> If cpu_feature_enabled() is not yet available, USE_EARLY_PGTABLE_L5 can
> be defined before all includes. It makes pgtable_l5_enabled rely on
> __pgtable_l5_enabled variable instead. This approach fits all early
> users.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
