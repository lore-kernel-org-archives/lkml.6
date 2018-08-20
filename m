Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A28C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387AB21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387AB21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeHTKoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:44:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54539 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeHTKon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:44:43 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fredc-0007bs-E4; Mon, 20 Aug 2018 09:30:08 +0200
Date:   Mon, 20 Aug 2018 09:30:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Rian Hunter <rian@alum.mit.edu>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bpetkov@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dmitry Safonov <dima@arista.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/process: Export start_thread()
In-Reply-To: <53141AE9-7192-432B-8A27-25986CF442D4@amacapital.net>
Message-ID: <alpine.DEB.2.21.1808200927550.2151@nanos.tec.linutronix.de>
References: <20180819230854.7275-1-rian@alum.mit.edu> <53141AE9-7192-432B-8A27-25986CF442D4@amacapital.net>
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

On Sun, 19 Aug 2018, Andy Lutomirski wrote:
> > On Aug 19, 2018, at 4:08 PM, Rian Hunter <rian@alum.mit.edu> wrote:
> > 
> > Commit e634d8fc792c ("x86-64: merge the standard and compat
> > start_thread() functions") removed exporting for the start_thread()
> > function in what seems like a typo. Add it back to
> > arch/x86/kernel/process_64.c for parity with process_32.c and other
> > arch.
> 
> What for?  Perhaps 32-bit could remove it instead?

No. start_thread() is called from various binfmt implementations which can
be built as modules.

Thanks,

	tglx
