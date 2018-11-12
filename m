Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA18C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37389224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37389224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbeKMC5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:57:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbeKMC5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:57:42 -0500
Received: from vmware.local.home (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34D522419;
        Mon, 12 Nov 2018 17:03:35 +0000 (UTC)
Date:   Mon, 12 Nov 2018 12:03:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181112120334.7526ce24@vmware.local.home>
In-Reply-To: <20181112053055.hdcv5x7md47ehunv@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
        <20181109072811.GB86700@gmail.com>
        <20181109144501.aqhcv3vdjuqlp7pz@treble>
        <20181112050241.GB28219@gmail.com>
        <20181112053055.hdcv5x7md47ehunv@treble>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 23:30:55 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > How much of that slowdown is reversed?  
> 
> In theory, it should reverse all of the slowdown, and actually may even
> speed it up a little.  Steve is working on measuring that now.

When I'm able to get it to work! Hopefully that last patch snippet you
posted will help. If not, I'm assuming you'll be in Vancouver this
week, and we could sit down and work it out.

That said, I don't expect a 100% improvement. Because the retpoline
causes slow down in other areas than just tracing, which is not being
fixed by this. I'm expecting a substantial improvement (which I see
good improvement with the unoptimized static calls), and hoping for
much more with the optimized one (when I get it working). But not 100%,
as stated above.

-- Steve
