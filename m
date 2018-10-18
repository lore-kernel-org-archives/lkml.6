Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CC9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4BC21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4BC21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeJRVWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeJRVWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:22:09 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806472145D;
        Thu, 18 Oct 2018 13:21:07 +0000 (UTC)
Date:   Thu, 18 Oct 2018 09:21:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86: ptrace.h: Make regs_get_kernel_stack_nth() not
 fault on bad stack
Message-ID: <20181018092106.5e66b8b8@gandalf.local.home>
In-Reply-To: <20181018154846.8d055466316359525b94a87a@kernel.org>
References: <20181017165951.09119177@gandalf.local.home>
        <20181018154846.8d055466316359525b94a87a@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 15:48:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 17 Oct 2018 16:59:51 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Andy had some concerns about using regs_get_kernel_stack_nth() in a new
> > function regs_get_kernel_argument() as if there's any error in the stack
> > code, it could cause a bad memory access. To be on the safe side, call
> > probe_kernel_read() on the stack address to be extra careful in accessing
> > the memory. A helper function, regs_get_kernel_stack_nth_addr(), was added
> > to just return the stack address (or NULL if not on the stack), that will be
> > used to find the address (and could be used by other functions) and read the
> > address with kernel_probe_read().
> > 
> > Link: http://lkml.kernel.org/r/CALCETrXn9zKTb9i1LP3qoFcpqZHF34BdkuZ5D3N0uCmRr+VnbA@mail.gmail.com
> > Requested-by: Andy Lutomirski <luto@amacapital.net>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you,
> 

Thanks Masami,

I plan on posting all the patches later today. They already passed all
my tests :-) Well, it hasn't broken anything, as I haven't added tests
to test your code yet.

-- Steve
