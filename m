Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1DBC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C642C2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C642C2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJLKcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeJLKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:32:05 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02D620835;
        Fri, 12 Oct 2018 03:01:52 +0000 (UTC)
Date:   Thu, 11 Oct 2018 23:01:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH] x86: ptrace: Add function argument access API
Message-ID: <20181011230151.25ba36f3@vmware.local.home>
In-Reply-To: <20181011230021.0a7604fa@vmware.local.home>
References: <20181011230021.0a7604fa@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 23:00:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>   A while ago I posted an RFC patchset for dynamic function based
>   events. But Masami pointed out that this could be done with kprobes
>   with minimal changes. He posted a patch set back in March
>   http://lkml.kernel.org/r/152049860385.7289.14079393589900496424.stgit@devbox
>   I've pulled this in locally, but haven't had the time until recently
>   to look at it seriously. I even plan to talk about these changes in
>   my talk at Open Source Summit in Edinburgh less than two weeks away
>   (talk about conference driven development!).
>   Anyway, the one patch that really needs external approval is the one
>   that creates a new architecture dependent API to retrieve function
>   arguments from pt_regs if the ip is at the start of the function call
>   (via a breakpoint or ftrace fentry). That's this patch.
> 
>   Anyone have any issues with it? If not, I'm going to start doing some
>   serious testing of this code and try to get it into the next merge
>   window.

You can also play with the full repo here:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

 branch: ftrace/kprobes

-- Steve
