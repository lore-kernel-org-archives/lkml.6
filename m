Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F79C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9823208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9823208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbeGJU0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:26:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37709 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbeGJU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:26:40 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fczCi-0007wD-Dm; Tue, 10 Jul 2018 22:25:44 +0200
Date:   Tue, 10 Jul 2018 22:25:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joerg Roedel <joro@8bytes.org>
cc:     Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH 0/3] x86/pti: Call pti_init() after mark_readonly()
In-Reply-To: <20180710131959.GG13903@8bytes.org>
Message-ID: <alpine.DEB.2.21.1807102224250.1588@nanos.tec.linutronix.de>
References: <1530618746-23116-1-git-send-email-joro@8bytes.org> <20180710131959.GG13903@8bytes.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018, Joerg Roedel wrote:

> Hey Thomas,
> 
> On Tue, Jul 03, 2018 at 01:52:23PM +0200, Joerg Roedel wrote:
> > Joerg Roedel (3):
> >   x86/pti: Move pti_init() code out of __init
> >   x86/mm/pti: Call pti_init() after mark_readonly()
> >   x86/pti: Call pti_clone_kernel_text() from pti_init()
> 
> Please ignore this patch-set. It turned out that some code in the kernel
> executes user-space even before /init is started. I just ran into a
> problem where request_module calls usermode-helper and then
> triple-faults when it tries to go to user-space and finds the
> user-pagetable still empty.
> 
> I need to look into another solution for this then.

Thanks for the clue. I was about to stare at it.

Thanks,

	tglx


