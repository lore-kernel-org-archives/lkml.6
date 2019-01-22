Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B92C282C5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B9B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YFRpSOcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfAVNkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:40:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40712 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfAVNkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:40:23 -0500
Received: from zn.tnic (p200300EC2BCBD900846DD624DCCF3A9E.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:d900:846d:d624:dccf:3a9e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00F1B1EC072C;
        Tue, 22 Jan 2019 14:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548164421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PyM7CbA0hfWFqe8nBcyRd5MK+VJCiClt78A1zbWGC+s=;
        b=YFRpSOcdIbVVUv1tNvvtSlMnk/BsTDwjAurWXuBj9HSKqPOlsqt1tRdVebO0v2rcXx7Ghn
        8F+nnZsRUv5s40ANj0j4ck6XEPU6GDlnf+3YNww69i91UkfZ5YzSBH2lH+2+VcEEklSnnU
        CEgaHKAILdy+ZfsCmkTsocWiT+eOxZA=
Date:   Tue, 22 Jan 2019 14:40:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190122134015.GI26587@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
 <20190118211401.4komqsnvuof7563p@linutronix.de>
 <33f0e144-1eec-b1a1-8858-58f20d5e477d@intel.com>
 <20190121112117.GA32538@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121112117.GA32538@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:21:17PM +0100, Oleg Nesterov wrote:
> And in any case I do not understand the idea to use the second
> in-kernel struct fpu. A signal handler can be interrupted by another
> signal, this will need to save/restore the FPU state again.

Well, we were just speculating whether doing that would simplify the
code around get_sigframe() et al. But if that is an ABI, then we can't
really touch it.

Btw, where is that whole ABI deal about saving FPU regs on the user
signal stack documented?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
