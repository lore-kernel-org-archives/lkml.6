Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933704AbeBMIE4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:04:56 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33678 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933606AbeBMIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:04:54 -0500
X-Google-Smtp-Source: AH8x2263qAY+Euhfu3bjL51Dr7QrfSCMm7mBzWnHmv4viMzKfSuerBWKHMYTZn/j1qsq0Ou+6KVYlA==
Date: Tue, 13 Feb 2018 09:04:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        karahmed@amazon.de, sironi@amazon.de, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH] x86/speculation: Clean up various Spectre related details
Message-ID: <20180213080450.7zll3nmn3iuxwg7y@gmail.com>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
 <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <20180211185057.rest4bf2ydx7slrk@gmail.com>
 <1518377119.6606.2.camel@infradead.org>
 <20180211194305.zg7tq3x3cxjuphyo@gmail.com>
 <1518449413.6606.99.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518449413.6606.99.camel@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> On Sun, 2018-02-11 at 20:43 +0100, Ingo Molnar wrote:
> > > And should these say 'Spectre v2' not just 'Spectre'?
> > 
> > Yeah, you are probably right, but I didn't want to make the messages too specific 
> > - do we really know that this is the end of Spectre-style speculation holes?
> 
> Well... if a new problem is also remedied by use if IBRS/IBPB and
> retpoline, I think we can happily call it a subclass of "Spectre v2".
> 
> And if it *isn't* addressed by those same things, then it's clearly
> something different. Either way, these messages should be 'v2', no?

Ok, fair enough - I've changed it to v2 as you suggest:

-		pr_info("Filling RSB on context switch\n");
+		pr_info("Spectre v2 mitigation: Filling RSB on context switch\n");
-		pr_info("Enabling Indirect Branch Prediction Barrier\n");
+		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");

> On the whole though, there are plenty of better things to be worrying
> about :)

Sure - nevertheless I fixed these while they were still hot ;-)

Thanks,

	Ingo
