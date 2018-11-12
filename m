Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDCE214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abe6gUvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDCE214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbeKLOyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:54:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46725 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730939AbeKLOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:54:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so7775297wrb.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aCPzndRLoGXrQBUqefife/Sscs/jdXGFkYHMfyL/hAE=;
        b=Abe6gUvmaY2QzJohV3wDVG9LDVdGGsDYfeaLmAvN5CamRKuC7G6gMOulOw0NzttvZw
         VNVI5HIbLUib7Wv4SB5vVAjetilDriojysKZI+MHk/xYOdoLubIkF09Jjk0tzm737DuG
         jhIKAExfzTPr4BGWwyhO7yKQ5mlSauONQnZwarrTVpG15EGNvuocKua5B6mngisSwd4z
         PCVwLlY36UG170R2eQzv6HzRj3o8RGy4Qhx3ImgWXurapwg8DzxaN5KYLbufq6+jTalC
         Hrym03dQ7PkpiuQPC5PMjsUHhjWMhS8VG5LfivK/2ciDB1sHd3Xn7dZCGmAjF1Yp0JQ0
         e/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aCPzndRLoGXrQBUqefife/Sscs/jdXGFkYHMfyL/hAE=;
        b=rabvgDjZYe1uzEUbdK7hItavRm7vWDPzN7gTeriE9Hoq/i94Qa024A4OPvNbKlr07i
         EgfWLLooEbhB1OL3+qdWSIhWSV7z+6Ie3H2Zhqqkal3ewEJpXieGLPQcFspn2nIAiqqF
         o4UqYwnVYY1HwHr/6xJQimHXBGXFH4tQMG32kWNth83+N91ISYMLrlEXLo7Qpui9iFcH
         OUfcVXhvbVBr6+392jFKwpchvder2e2qMurl6j7Y/wu5yQcmccXxiXiJZhhXbLBveGgD
         4hEtti86SGhN6oDCzewHZipVJHREQ1MtcpNhYoglGOPb6FFMdzvf3dfxCPVGpr/k2EfI
         8SbQ==
X-Gm-Message-State: AGRZ1gK/qSDjOhBHOwjhR2nDKw3/XRzHWSsoB4giaegPh2O0pCzsyeps
        V0Zzqh8U5WQpmUOPV/dqkJc=
X-Google-Smtp-Source: AJdET5fBoJivJikcPV4EponuxitgYb5vdis12Yin9K/w5jMmEzWvB/ZSaZIHhSua7mCgh5SNsnDIxw==
X-Received: by 2002:adf:a20a:: with SMTP id p10-v6mr15199180wra.249.1541998964672;
        Sun, 11 Nov 2018 21:02:44 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j129-v6sm8855439wmb.47.2018.11.11.21.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 21:02:43 -0800 (PST)
Date:   Mon, 12 Nov 2018 06:02:41 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH RFC 0/3] Static calls
Message-ID: <20181112050241.GB28219@gmail.com>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
 <20181109144501.aqhcv3vdjuqlp7pz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109144501.aqhcv3vdjuqlp7pz@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Fri, Nov 09, 2018 at 08:28:11AM +0100, Ingo Molnar wrote:
> > > - I'm not sure about the objtool approach.  Objtool is (currently)
> > >   x86-64 only, which means we have to use the "unoptimized" version
> > >   everywhere else.  I may experiment with a GCC plugin instead.
> > 
> > I'd prefer the objtool approach. It's a pretty reliable first-principles 
> > approach while GCC plugin would have to be replicated for Clang and any 
> > other compilers, etc.
> 
> The benefit of a plugin is that we'd only need two of them: GCC and
> Clang.  And presumably, they'd share a lot of code.
> 
> The prospect of porting objtool to all architectures is going to be much
> more of a daunting task (though we are at least already considering it
> for some arches).

Which architectures would benefit from ORC support the most?

I really think that hard reliance on GCC plugins is foolish - but maybe 
Clang's plugin infrastructure is a guarantee that it remains a sane and 
usable interface.

> > I'd be very happy with a demonstrated paravirt optimization already - 
> > i.e. seeing the before/after effect on the vmlinux with an x86 distro 
> > config.
> > 
> > All major Linux distributions enable CONFIG_PARAVIRT=y and 
> > CONFIG_PARAVIRT_XXL=y on x86 at the moment, so optimizing it away as much 
> > as possible in the 99.999% cases where it's not used is a primary 
> > concern.
> 
> For paravirt, I was thinking of it as more of a cleanup than an
> optimization.  The paravirt patching code already replaces indirect
> branches with direct ones -- see paravirt_patch_default().
> 
> Though it *would* reduce the instruction footprint a bit, as the 7-byte
> indirect calls (later patched to 5-byte direct + 2-byte nop) would
> instead be 5-byte direct calls to begin with.

Yes.

> > All other usecases are bonus, but it would certainly be interesting to 
> > investigate the impact of using these APIs for tracing: that too is a 
> > feature enabled everywhere but utilized only by a small fraction of Linux 
> > users - so literally every single cycle or instruction saved or hot-path 
> > shortened is a major win.
> 
> With retpolines, and with tracepoints enabled, it's definitely a major
> win.  Steve measured an 8.9% general slowdown on hackbench caused by
> retpolines.

How much of that slowdown is reversed?

> But with tracepoints disabled, I believe static jumps are used, which
> already minimizes the impact on hot paths.

Yeah.

Thanks,

	Ing
