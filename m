Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A940C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1391F218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B5qX3z+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbfAKTez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:34:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34021 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfAKTey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:34:54 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so13950054lje.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLJSAT9tUQzsVm07g1kVZQDg0TcBmJXqmI7ZVgOIiPk=;
        b=B5qX3z+c2tCNMDAgsNBYMRDMW3flrEONFkAR2cgZ9s2eU19BuGlpy+xT0TLYNR6l/5
         nop4h+IPtlb4mXPErEUMsPM1glKsmRIQF9sk8I42xfkRYPJw9UkX6cFV0kgqeXtFiur2
         +IDdtgeOzvqV6bpyguihgo2Ee/oh7HnintN70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLJSAT9tUQzsVm07g1kVZQDg0TcBmJXqmI7ZVgOIiPk=;
        b=TMpnJqVNZrYzs5tcVcczJotwcwZj61TJXiQClI1eRHExwIzIWGfzL2W5TZZ5UGCTbx
         ziFcI7fYgTl/rci7C8juyoEz1CjUGPfM2bM6jyqevLsTtZcUYAQQvEDVI7p4m5n4bqN2
         8EXtNVp4zOmRRZjhDR/8JTuYHsPsJMT8f+2wCz5S9UPA2hZclr/9XBqrFnnXA9rdaTn6
         D996p7WP0/f9WeJlR/xUPIwGdG19AlHSNdUsesryWC6XQ5KEhVpdm4gM6SDt4lnz3T2P
         p3UmrfvAqmAamIvkAGIpNrx3PNACv3+qiNzLEYiVkaAT/cm0IZqvRc4d3T4BHMBmAv36
         1lew==
X-Gm-Message-State: AJcUukcjPzaSn59EUP5oMsBOPFQ+ajrER3yjkr7TrNw/O8JLGdv0h+Nd
        cNaB5nDVWgirO8I2zZYN6X1RAgucnmc=
X-Google-Smtp-Source: ALg8bN4Ml1POCOz0h/gzIXGgv+sDCZwmwjZWfe/fGsJMmx/NbbgAcNim2JzQ4g2of7Zj1B7yIlLO1w==
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr8898370ljb.11.1547235292073;
        Fri, 11 Jan 2019 11:34:52 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id t9-v6sm15963872ljj.87.2019.01.11.11.34.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 11:34:51 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id z13so11594422lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:34:50 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr8412103lfj.138.1547235290376;
 Fri, 11 Jan 2019 11:34:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com> <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
In-Reply-To: <12578A17-E695-4DD5-AEC7-E29FAB2C8322@zytor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jan 2019 11:34:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQR1RfjA9V70cL-vTrhYBF9FWhPRaZahQuDaSazL+kAQ@mail.gmail.com>
Message-ID: <CAHk-=wgQR1RfjA9V70cL-vTrhYBF9FWhPRaZahQuDaSazL+kAQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Peter Anvin <hpa@zytor.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:24 AM <hpa@zytor.com> wrote:
>
> I still don't see why can't simply spin in the #BP handler until the patch is complete.

So here's at least one problem:

text_poke_bp()
  text_poke(addr, &int3, sizeof(int3));
   *interrupt*
      interrupt has a static call
        *BP*
          poke_int3_handler
             *BOOM*

Note how at BOOM we cannot just spin (or return) to wait for the
'int3' to be switched back. Becuase it never will. Because we are
interrupting the thing that would do that switch-back.

So we'd have to do the 'text_poke_bp()' sequence with interrupts
disabled. Which we can't do right now at least, because part of that
sequence involves that on_each_cpu(do_sync_core) thing, which needs
interrupts enabled.

See?

Or am I missing something?

            Linus
