Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8495C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18D720870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfAVQP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:15:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbfAVQP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:15:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07CAA58E33;
        Tue, 22 Jan 2019 16:15:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6CA8A5D9C7;
        Tue, 22 Jan 2019 16:15:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Jan 2019 17:15:55 +0100 (CET)
Date:   Tue, 22 Jan 2019 17:15:51 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20190122161551.GB9745@redhat.com>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
 <20190118211401.4komqsnvuof7563p@linutronix.de>
 <33f0e144-1eec-b1a1-8858-58f20d5e477d@intel.com>
 <20190121112117.GA32538@redhat.com>
 <20190122134015.GI26587@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122134015.GI26587@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 22 Jan 2019 16:15:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/22, Borislav Petkov wrote:
>
> On Mon, Jan 21, 2019 at 12:21:17PM +0100, Oleg Nesterov wrote:
> > And in any case I do not understand the idea to use the second
> > in-kernel struct fpu. A signal handler can be interrupted by another
> > signal, this will need to save/restore the FPU state again.
>
> Well, we were just speculating whether doing that would simplify the
> code around get_sigframe() et al. But if that is an ABI, then we can't
> really touch it.
>
> Btw, where is that whole ABI deal about saving FPU regs on the user
> signal stack documented?

I don't know... tried to google, found nothing.

the comment in /usr/include/sys/ucontext.h mentions SysV/i386 ABI + historical
reasons, this didn't help.

Oleg.

