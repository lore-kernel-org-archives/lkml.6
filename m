Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19ACC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A673A2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A673A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJQCvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbeJQCvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:51:16 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A27022098A;
        Tue, 16 Oct 2018 18:59:26 +0000 (UTC)
Date:   Tue, 16 Oct 2018 14:59:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH] x86: ptrace: Add function argument access API
Message-ID: <20181016145924.6bde80d8@gandalf.local.home>
In-Reply-To: <20181015235646.2cbb7dc9bc4b7b54f900e0fb@kernel.org>
References: <20181011230021.0a7604fa@vmware.local.home>
        <20181012122641.3d87ed29@gandalf.local.home>
        <CALCETrXn9zKTb9i1LP3qoFcpqZHF34BdkuZ5D3N0uCmRr+VnbA@mail.gmail.com>
        <20181012155439.59f77556@gandalf.local.home>
        <20181015235646.2cbb7dc9bc4b7b54f900e0fb@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 23:56:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> This patch looks good to me.
> But if the concern is real, all regs_get_kernel_stack_nth() user must move
> onto _safe() version, at least all tracers code.

Doing a git grep on regs_get_kernel_stack_nth(), I think you are right.
I'll resend and make the _nth() function just the _safe() function. No
need to do it without the probe_kernel_read() call.

> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

-- Steve

> 
>
