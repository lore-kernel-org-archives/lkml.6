Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCB8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9282082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="aUzNJhui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9282082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeJKEhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:37:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbeJKEhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:37:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so7265446wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8A3UipERG3NT0ECb7Z+ZqIoiaKdw+Gx0wMsxByRRS0=;
        b=aUzNJhui/U7FOOPMqzgdsx+n+Dr7tuJH9MHkftWeMfhFHYYq554bxT+e8AHEOpdAsw
         au6J0Vg/eLfDLNNiQIfsnKbSmTM5v9AgtJzhtRaS02qt74Bgn58g+6lUqdaF/0tIGAee
         nSnR9AKz/kKErEbxYBnKt0KDm8oXuXR1PRA4g5Qg8Dz3cJiug22lysRY1uf5yqQpZVl8
         vbtRVmoK1KFUg9U2kj2vSPQCa3VBjuk8O8ajdxWHdwWeQVUaQhBTSbJ8o9SPr1LuYDqa
         NtJBNrBITtG2B/H4qLC++8WUCs9LTetK+FftNgraaa4cx/omQz/tJqptdH8EVm9YCjIO
         ImJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8A3UipERG3NT0ECb7Z+ZqIoiaKdw+Gx0wMsxByRRS0=;
        b=ON4H74hdmf/Boj1DvpqacOoBqGVX8KueCMPAw+eyaXrk1usfCuksl5TWWN/6JkBunm
         +baDYYsDU8zNxj7grLC0zzYwCMOctxflKKW45bR5DA4+9jJwh8W2iDTC4XLUtzZXRzWE
         8J94LKvnopUBKvMByj5pANLMZl9OA2MWczwj7WIo+wCUvdOVKsidEgWhw6UEccfPV1zG
         /CpgofwhgTmHO/nnPdfKRw+/6cTceFcFUWxqj8/IQzwwD/RUX7za35Uj0EkzkKdNMtUP
         /61s7ve/jcIgcbWwfHXB4e5mCvGro4XPtMo7UVfVrg/1JGtke/cODtLMwqipgZdQKVM4
         XPIw==
X-Gm-Message-State: ABuFfogSY2woxYCAKyZ8d/N+pHDkkG46TqGqfoT2JdTtpWsaUx/BQQ6S
        uMvrJAxsFQj3uBB0GDatbmMcylSWTC6zYV9XK4O3yQ==
X-Google-Smtp-Source: ACcGV63oSePDOUpSpUL1LsAucohPWCGyCpmc2T2woXMOBpS/IGZEn/pbUA1PDXgB5S1eSB109GQKYjC06ouJw9d3veE=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr23853652wrc.131.1539206014436;
 Wed, 10 Oct 2018 14:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181006093905.46276505@vmware.local.home> <20181008072134.GB5663@hirez.programming.kicks-ass.net>
 <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net> <20181008155757.GC5663@hirez.programming.kicks-ass.net>
 <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net> <20181009021710.qwt5hpntyeps44h3@treble>
 <20181008235750.59da83ae@gandalf.local.home> <20181010175237.e7m3sldcu2maoqcq@treble>
 <CALCETrUOaJ1dAsuX9bQO_+B4G6y5-FAb0=ZYA8QbtAEBZ6MxKg@mail.gmail.com>
 <20181010181605.arsyjxwdztztrjih@treble> <20181010181741.lc4l7kjvcmoxrw5b@treble>
In-Reply-To: <20181010181741.lc4l7kjvcmoxrw5b@treble>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 10 Oct 2018 14:13:22 -0700
Message-ID: <CALCETrUZMmTDOh5-Mzyj1rk7Q82DgdQLinOfbzF4Sb7OC2aYMQ@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:17 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Oct 10, 2018 at 01:16:05PM -0500, Josh Poimboeuf wrote:
> > On Wed, Oct 10, 2018 at 11:03:43AM -0700, Andy Lutomirski wrote:
> > > > +#define DECLARE_STATIC_CALL(tramp, func)                               \
> > > > +       extern typeof(func) tramp;                                      \
> > > > +       static void __used __section(.discard.static_call_tramps)       \
> > > > +               *__static_call_tramp_##tramp = tramp
> > > > +
> > >
> > > Confused.  What's the __static_call_tramp_##tramp variable for?  And
> > > why is a DECLARE_ macro defining a variable?
> >
> > This is the magic needed for objtool to find all the call sites.
> >
> > The variable itself isn't needed, but the .discard.static_call_tramps
> > entry is.  Objtool reads that section to find out which function call
> > sites are targeted to a static call trampoline.
>
> To clarify: objtool reads that section to find out which functions are
> really static call trampolines.  Then it annotates all the instructions
> which call/jmp to those trampolines.  Those annotations are then read by
> the kernel.
>

Ah, right, and objtool runs on a per-object basis so it has no other
way to know what symbols are actually static calls.

There's another way to skin this cat, though:

extern typeof(func) __static_call_trampoline_##tramp;
#define tramp __static_call_trampoline_##tramp

And objtool could recognize it by name.  But, of course, you can't put
a #define in a macro.  But maybe there's a way to hack it up with a
static inline?

Anyway, your way is probably fine with a few caveats:

 - It won't really work if the call comes from a .S file.
 - There should probably be a comment to help de-confuse future people
like me :)
