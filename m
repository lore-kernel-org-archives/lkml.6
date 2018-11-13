Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8026FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D272250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D272250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeKMLpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeKMLpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:45:09 -0500
Received: from vmware.local.home (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99182223C8;
        Tue, 13 Nov 2018 01:49:20 +0000 (UTC)
Date:   Mon, 12 Nov 2018 20:49:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     kernel-hardening@lists.openwall.com,
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
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] stackleak: Disable function tracing and kprobes for
 stackleak_erase()
Message-ID: <20181112204918.2ba39252@vmware.local.home>
In-Reply-To: <1542056928-10917-1-git-send-email-alex.popov@linux.com>
References: <1542056928-10917-1-git-send-email-alex.popov@linux.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 00:08:48 +0300
Alexander Popov <alex.popov@linux.com> wrote:

> The stackleak_erase() function is called on the trampoline stack at the end
> of syscall. This stack is not big enough for ftrace and kprobes operations,
> e.g. it can be exhausted if we use kprobe_events for stackleak_erase().
> 
> So let's disable function tracing and kprobes for stackleak_erase().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
