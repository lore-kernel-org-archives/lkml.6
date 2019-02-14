Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7CA2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407580AbfBNP2T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:28:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50096 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfBNP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:28:19 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1guIvu-0002YR-Sj; Thu, 14 Feb 2019 16:28:15 +0100
Date:   Thu, 14 Feb 2019 16:28:14 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 15/22] x86/entry: Add TIF_NEED_FPU_LOAD
Message-ID: <20190214152814.dptm4edcpfn7vrff@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-16-bigeasy@linutronix.de>
 <20190130115507.GE18383@zn.tnic>
 <20190207114941.jzydrry5xpjngyiv@linutronix.de>
 <20190213093553.GC9683@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190213093553.GC9683@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13 10:35:53 [+0100], Borislav Petkov wrote:
…
> > + *
> > + * If TIF_NEED_FPU_LOAD is cleared then CPU's FPU registers are holding the
> > + * current content of current()'s FPU register state.
> 
> "current content of current" - that's a lot of c...
> 
> Make that
> 
> "... then the CPU's FPU registers are mirrored in the current thread's
> FPU registers state."

Replaced `mirrored' with saved:

+ * If TIF_NEED_FPU_LOAD is cleared then the CPU's FPU registers are saved in
+ * the current thread's FPU registers state.
+ * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not hold current()'s
+ * FPU registers. It is required to load the registers before returning to
+ * userland or using the content otherwise.

Sebastian
