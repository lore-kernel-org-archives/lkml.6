Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37928C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C52177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M8yx8CLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390696AbfAKUMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:12:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388788AbfAKUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:12:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so11651340lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/45zICDjw0ekmJ13lUuG5Az2jUPs8RRC0mdZikz3nv0=;
        b=M8yx8CLMSaa+tX4DwXY7gV2PjXNFKxBNkXslbdhrPIl1tXPG3DKO31MBAN1uXbz92B
         YELXCXkdf2f0jQRi23Gz6cmWbCDhOWx9ytx4xoCDJ6F2YanQD+iTokQTlQhk8EfhVQJN
         xZ7YT3PNusw3/FnuPC3IwSofuzF9MZCz4rmkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/45zICDjw0ekmJ13lUuG5Az2jUPs8RRC0mdZikz3nv0=;
        b=kQehWXOEhqJzh9R7/trU1pxCFkwqlDwpYsvm5pcxpspQJQ5hq+DtbzLKgctql9namP
         Z+3CnMHGWQhR6MUUzxNPRUJ2YKAeT3rQV6qF2muGMEyHnPXb6eHqIkjJiEzUOKQ9vqG6
         6FMpzxsV9R5VtHShWMOa8H4H4ktX8ofu5XL2enAyqcsppcwuEN8j6NicoPceFDyBSLNp
         z/ArDq3UuDR2GRCSi1C2CB1m2FJ9gJ+/lO7roGNv5unKmEoIJemUt68M5Opar2h9Cgf7
         67mot9DxsWGJMNzWAUYl78Pt3DAR7tFsyQGN1Udpj+FXPpFEddDx47UbheBWlLyskmmV
         2zFw==
X-Gm-Message-State: AJcUukcQZhRUELMKJCvUnWW/GGUJ9jIjRJAafdtfZRRcOWnlBCJ756Vs
        R5hYSIv5dgyayIZqW7OyPYAPoWo+PFk=
X-Google-Smtp-Source: ALg8bN5+m/on/haA+afbgR+Do+S63tLQfb1KZVB+miGbmQDewZ37WSrW/AOgXh3oOu+Nsr93Db2J8g==
X-Received: by 2002:a19:c801:: with SMTP id y1mr8499582lff.53.1547237568155;
        Fri, 11 Jan 2019 12:12:48 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e5-v6sm15728230ljj.91.2019.01.11.12.12.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 12:12:47 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id e26so11684011lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:12:46 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr9500440lfc.124.1547237566319;
 Fri, 11 Jan 2019 12:12:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com> <20190111200420.qtyffayxceysoarf@treble>
In-Reply-To: <20190111200420.qtyffayxceysoarf@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jan 2019 12:12:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
Message-ID: <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:04 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> But really, to me, having to create and manage all those custom
> trampolines still feels a lot more complex than just making a gap on the
> stack.

There are no "all those custom trampolines".

There is literally *one* custom trampoline that you generate as you do
the rewriting.

Well, two, since you need the version with the "sti" before the jmp.

It would be possible to generate the custom trampoline on the fly in
the BP handler itself, and just have a magic flag for that case. But
it's probably simpler to do it in the caller, since you need to
generate that special writable and executable code sequence. You
probably don't want to do that at BP time.

You probably want to use a FIX_TEXT_POKE2 page for the generated
sequence that just maps some generated code executably for a short
while. Or something like that.

              Linus

             Linus
