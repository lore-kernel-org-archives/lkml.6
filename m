Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB4DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A1C2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A1C2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeKMDQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeKMDQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:16:00 -0500
Received: from vmware.local.home (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E57222419;
        Mon, 12 Nov 2018 17:21:49 +0000 (UTC)
Date:   Mon, 12 Nov 2018 12:21:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] stackleak: Disable ftrace for stackleak.c
Message-ID: <20181112122148.0fab4c7f@vmware.local.home>
In-Reply-To: <31b45d77-7b49-3984-a1e5-17993f50eee3@linux.com>
References: <1541887530-16610-1-git-send-email-alex.popov@linux.com>
        <20181110183011.2290fc20@gandalf.local.home>
        <eeb7f5ee-1e2e-d37b-cca2-e0a29826e8eb@linux.com>
        <20181111205351.1874bb1e@vmware.local.home>
        <20181112115058.39e98750750c91eeb349cfdf@kernel.org>
        <31b45d77-7b49-3984-a1e5-17993f50eee3@linux.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 19:51:00 +0300
Alexander Popov <alex.popov@linux.com> wrote:

> By the way, are there any other tracing/instrumentation mechanisms that should
> be disabled?

ftrace and kprobes are pretty much the only ones that currently do self
modification of code all over the kernel. Kprobes even more so than
ftrace.

-- Steve
