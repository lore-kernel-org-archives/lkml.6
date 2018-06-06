Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 936FB606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeFFTNF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752053AbeFFTNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:13:04 -0400
Date: Wed, 6 Jun 2018 15:13:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH V4 1/3] kallsyms: Simplify update_iter_mod()
Message-ID: <20180606151300.27a3d72e@vmware.local.home>
In-Reply-To: <20180606185914.GJ24381@kernel.org>
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
        <1528289651-4113-2-git-send-email-adrian.hunter@intel.com>
        <20180606131302.GB12180@hirez.programming.kicks-ass.net>
        <20180606143727.03da2e26@vmware.local.home>
        <20180606185914.GJ24381@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 15:59:14 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, Jun 06, 2018 at 02:37:27PM -0400, Steven Rostedt escreveu:
> > On Wed, 6 Jun 2018 15:13:02 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > On Wed, Jun 06, 2018 at 03:54:09PM +0300, Adrian Hunter wrote:  
> > > > The logic in update_iter_mod() is overcomplicated and gets worse every time
> > > > another get_ksymbol_* function is added.
> > > > 
> > > > In preparation for adding another get_ksymbol_* function, simplify logic in
> > > > update_iter_mod().
> > > > 
> > > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > > Acked-by: Andi Kleen <ak@linux.intel.com>    
> > > 
> > > Both Daniel and Steven touched this function last year, let's also Cc
> > > them.  
> > 
> > Thanks for Ccing me. I tested the patch to make sure my changes still
> > work and they do:
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Since you said you tested the patch, may I replace the Acked-by with the
> stronger Tested-by?

Well, I only tested it against the changes I made earlier. I didn't do
any other testing, which is why I'm reluctant to say "tested by".

Perhaps it can be:

Tested-by: (ftrace changes only) Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
