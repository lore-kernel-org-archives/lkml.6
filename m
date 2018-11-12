Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D77C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437C5223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 22:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437C5223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeKMIv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 03:51:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeKMIv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 03:51:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E967A811C0;
        Mon, 12 Nov 2018 22:56:40 +0000 (UTC)
Received: from treble (ovpn-121-1.rdu2.redhat.com [10.10.121.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F0235D739;
        Mon, 12 Nov 2018 22:56:38 +0000 (UTC)
Date:   Mon, 12 Nov 2018 16:56:35 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20181112225635.yw7ympmp2wehbpki@treble>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
 <20181109144501.aqhcv3vdjuqlp7pz@treble>
 <20181112050241.GB28219@gmail.com>
 <20181112053055.hdcv5x7md47ehunv@treble>
 <20181112120334.7526ce24@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112120334.7526ce24@vmware.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 12 Nov 2018 22:56:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:03:34PM -0500, Steven Rostedt wrote:
> On Sun, 11 Nov 2018 23:30:55 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > > How much of that slowdown is reversed?  
> > 
> > In theory, it should reverse all of the slowdown, and actually may even
> > speed it up a little.  Steve is working on measuring that now.
> 
> When I'm able to get it to work! Hopefully that last patch snippet you
> posted will help. If not, I'm assuming you'll be in Vancouver this
> week, and we could sit down and work it out.

Sure, I'm already in Vancouver.  Just grab me if you see me, or ping me
on IRC/email.  Or feel free to send me your patches if it's still giving
you trouble.

> That said, I don't expect a 100% improvement. Because the retpoline
> causes slow down in other areas than just tracing, which is not being
> fixed by this. I'm expecting a substantial improvement (which I see
> good improvement with the unoptimized static calls), and hoping for
> much more with the optimized one (when I get it working). But not 100%,
> as stated above.

Ah, ok.  Makes sense.

-- 
Josh
