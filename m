Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeBTIfR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:35:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60753 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeBTIfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 03:35:16 -0500
Date: Tue, 20 Feb 2018 09:35:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Woodhouse <dwmw@amazon.co.uk>
cc: karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jmattson@google.com, rkrcmar@redhat.com, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com, mingo@kernel.org
Subject: Re: [PATCH v3 3/4] Revert "x86/retpoline: Simplify
 vmexit_fill_RSB()"
In-Reply-To: <1519037457-7643-4-git-send-email-dwmw@amazon.co.uk>
Message-ID: <alpine.DEB.2.21.1802200935050.24268@nanos.tec.linutronix.de>
References: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk> <1519037457-7643-4-git-send-email-dwmw@amazon.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2018, David Woodhouse wrote:

> This reverts commit 1dde7415e99933bb7293d6b2843752cbdb43ec11. By putting
> the RSB filling out of line and calling it, we waste one RSB slot for
> returning from the function itself, which means one fewer actual function
> call we can make if we're doing the Skylake abomination of call-depth
> counting.
> 
> It also changed the number of RSB stuffings we do on vmexit from 32,
> which was correct, to 16. Let's just stop with the bikeshedding; it
> didn't actually *fix* anything anyway.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
