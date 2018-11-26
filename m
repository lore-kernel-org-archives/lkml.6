Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72BD20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YirTg33k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72BD20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeK0AY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:24:57 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33918 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeK0AY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:24:57 -0500
Received: by mail-wr1-f51.google.com with SMTP id j2so18939416wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3pwXUAdXwdR7kd+Opke3gS4I74otyMDz3C1+gtm+9s=;
        b=YirTg33kSmi5ULNsjIqVGjIi0dtXm6hR6xo50Bm3l1Tk5/mo1ehOyVXAuaVboIVhHL
         s5VyxC6fqKVUUUxJPzKUfkXCa4vMm7Y0YAHGacG2DuPzwaPJ/vmRlmmSJkbQTHqq1usu
         AxfVZ0u3kcRKYg/99eDabDzlBZ6rH1Lz17yWWsNzP9FNq5CcXaVwjT1cw1/LXSpCm6CS
         QACP8dJmoZJTXuaXBdmwp7VL/Hnf2uYoIQaYi/en0MSbU2IaLzl0Zk1rHesoA93YTpCA
         bW9aeYhHYHU1tfHi/+2mQbNpXclVtXvGna4oOiBDCi9QOPjq4HiIepM9bdMyiWEAoQLO
         FUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3pwXUAdXwdR7kd+Opke3gS4I74otyMDz3C1+gtm+9s=;
        b=hBJmIe8yo+4fRg14VcdtuHAyXR70resHnDpmD/BHLBKhxV4Oc9KhSoG87JbPrUxRbJ
         zgPncCqFp1yhdwCmVe1T1QJ+ZW78M+dbwIo7FbOuafc71Yer3q6iVJ0sGKv74OoJR5yz
         5OXkb8vn2ty0oDJkr/UIVOOPme6dB5QyWWTVn1/gck3Stbhb1Q53EDYVd6FRdmkvVM1O
         1P7jHAHj4N9tpUWt5p7NYNuavdvK5SbgN9wen5i2f4BCG+aGwyCDP4PCb25kG6f7QINi
         UkbmkALYsmTxjYF8YJ9xDgSLLu9NmuSwS9FnkmT7efO1eI01sqj26wpCOY57x817YXz7
         OEtA==
X-Gm-Message-State: AA+aEWagJb0FO/+w3fyqaUCcxEMxPz3bX9X2YKIEWn8cNjPae1N8j6NH
        AX89xYtCUSsWKR/hNWVRrpA=
X-Google-Smtp-Source: AFSGD/Xr5yvEhC3Wq/9sO4EnkkfdD4h6lZYWyk0GFyUNQYU15M8DNroZnWPOL9GOQ6PYitXjgU9Izg==
X-Received: by 2002:adf:e08c:: with SMTP id c12mr22370047wri.199.1543239046924;
        Mon, 26 Nov 2018 05:30:46 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e16sm354312wrn.72.2018.11.26.05.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 05:30:46 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:30:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
Message-ID: <20181126133043.GA108014@gmail.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185006.051663132@linutronix.de>
 <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com>
 <alpine.DEB.2.21.1811252321300.1684@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811252321300.1684@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, 25 Nov 2018, Linus Torvalds wrote:
> 
> > [ You forgot to fix your quilt setup.. ]
> 
> Duh. Should have pinned that package.
> 
> > On Sun, 25 Nov 2018, Thomas Gleixner wrote:
> > >
> > > The mitigation guide documents how STIPB works:
> > >
> > >    Setting bit 1 (STIBP) of the IA32_SPEC_CTRL MSR on a logical processor
> > >    prevents the predicted targets of indirect branches on any logical
> > >    processor of that core from being controlled by software that executes
> > >    (or executed previously) on another logical processor of the same core.
> > 
> > Can we please just fix this stupid lie?
> 
> Well, it's not a lie. The above is correct, it just does not tell WHY this
> works.

Well, it's a "technically correct but misleading" phrase, which has much 
more of the effects of an actual "lie" than that of a true description of 
it.

I.e. in terms of what effects it's likely going to have on readers not 
aware of the underlying mechanics it's much more correct to call it a 
"lie" than to call it "truth" - which I think is at the core of Linus's 
argument.

> > Yes, Intel calls it "STIBP" and tries to make it out to be about the 
> > indirect branch predictor being per-SMT thread.
> > 
> > But the reason it is unacceptable is apparently because in reality it 
> > just disables indirect branch prediction entirely. So yes, 
> > *technically* it's true that that limits indirect branch prediction 
> > to just a single SMT core, but in reality it is just a "go really 
> > slow" mode.
> 
> Indeed. Just checked the documentation again, it's also not clear 
> whether IBPB is required if STIPB is in use.

So I think we should clarify all this.

Thanks,

	Ingo
