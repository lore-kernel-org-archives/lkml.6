Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1827E21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfBORU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:20:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfBORU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:20:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 719D121925;
        Fri, 15 Feb 2019 17:20:27 +0000 (UTC)
Date:   Fri, 15 Feb 2019 12:20:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 7/9] x86/alternative: Batch of patch operations
Message-ID: <20190215122026.3642d5b7@gandalf.local.home>
In-Reply-To: <23408225-1768-d01e-4fd6-24289ef673ae@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
        <84e6b00634085f0fca721e4e7e5aaf43cd062564.1549308412.git.bristot@redhat.com>
        <20190214125330.GB12467@zn.tnic>
        <20190214090620.1ee73a36@gandalf.local.home>
        <20190214143030.GB4423@zn.tnic>
        <20190214094011.6e8a22eb@gandalf.local.home>
        <23408225-1768-d01e-4fd6-24289ef673ae@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 17:00:49 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 2/14/19 3:40 PM, Steven Rostedt wrote:
> > On Thu, 14 Feb 2019 15:30:30 +0100
> > Borislav Petkov <bp@alien8.de> wrote:
> >   
> >>> 	void *trampoline;    
> >>
> >> Well, it ain't a trampoline either. It is a "temporary location to go to while
> >> patching is going on".  
> > 
> > 	void *detour;
> >   
> 
> The comment on top of text_poke_bp() defines:
> 
> handler:    address to jump to when the temporary breakpoint is hit
> 
> so, how about tmp_jump_addr?
> 
> well, detour works as well :-)
> 
> thoughts?
> 
>

"detour" sounds cool.

-- Steve
