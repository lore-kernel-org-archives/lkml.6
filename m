Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161448AbeBNRkt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:32974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161423AbeBNRkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:40:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96644205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 14 Feb 2018 12:40:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>,
        Juergen Gross <jgross@suse.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] jump_label: Warn on failed jump_label patch
Message-ID: <20180214124034.13d7d833@gandalf.local.home>
In-Reply-To: <20180214173407.guhytdurv4pmhzvk@treble>
References: <cover.1518626149.git.jpoimboe@redhat.com>
        <b8f1b55f17c346fba39d3f59a01251185e09e151.1518626149.git.jpoimboe@redhat.com>
        <20180214120112.43821b5e@gandalf.local.home>
        <a4ad6f69-8836-779b-f7e7-0e303885c7f5@akamai.com>
        <20180214173407.guhytdurv4pmhzvk@treble>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018 11:34:07 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:


> And in patch 1 the warning conditions need to be tweaked a bit to
> exclude the __init case.
> 

Hmm, I wonder if we could simply remove the references from the jump
label table when init is freed.

-- Steve
