Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2DBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2846218A4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eA77T5rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfAKVQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:16:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41121 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfAKVQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:16:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so11787342lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVPQ+uc2pT5ysrroM87Ozt7Y7jD9G0mxwnFLeDtmFoQ=;
        b=eA77T5rqo34wHH7TnPy6G6LcAvd0iElkdh9JnxnMWk0Zu08fi+Mss1o0AzgP/VHQDe
         dlnvX0hcn05gOMxAHo+kDApRxUk88AispuN60fMZc3ZFCcFqWQ9hzaSCnoIRtNRNg0q3
         oXakvuV3YGtBd9AjJ0RsUSM6p7pUV+RkcDBTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVPQ+uc2pT5ysrroM87Ozt7Y7jD9G0mxwnFLeDtmFoQ=;
        b=oyrbRc+kHbCNBtdNiQOl+E4OH8zWGoewxDtX2Mwqk7d9U9VXsCr2ol++D641Ntt9mn
         pMiBrQ1k4Sy0myk5b5erTZBhB8hvcUfi79xuDu4/J+1xmjteNV51LvMKJBLWlbfMrf6u
         EKVFpZr4r0YdibrtvVKT5TwF+PHJtmZ08UPlXWsDNkZCh4xLexHGkJS5N+JYIOc6yR+E
         cE1lOCHHYqgrl0B/03TSbxnyna8yghxRA7TQBPiuKiA5enu0bxwfSSDg0iLeh0KWeLFX
         JN4RUUwS1JpiT6u+RV4RXmutsA3ApGXf+8g7bXlrNcIDKAy8E/iN+CnDbN2LJES8oW2A
         wN7w==
X-Gm-Message-State: AJcUukeVZ4Sl4lOP+XkYrfCvvq+/aNW54u7vSZE6RoOhk7b9Y3TAI5xv
        BaBgf6nqJUkLL/b5bWjDryygfJHJDkU=
X-Google-Smtp-Source: ALg8bN6G0almGry2UnBGVNHkeIitRZWJV37xcYzJB/oyS1VOfawjqBP8Xn36yriLXid0ZX8voPWuIQ==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr8866728lfg.13.1547241389793;
        Fri, 11 Jan 2019 13:16:29 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u26-v6sm15827468lji.22.2019.01.11.13.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 13:16:29 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id a8so11790326lfk.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:16:29 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr9444235lfg.117.1547241063794;
 Fri, 11 Jan 2019 13:11:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble> <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble> <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
 <CALCETrXZdzNS=Bbv=qyM8iBC82QWOQqcfN1GFfcn6UHvePatHQ@mail.gmail.com>
In-Reply-To: <CALCETrXZdzNS=Bbv=qyM8iBC82QWOQqcfN1GFfcn6UHvePatHQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Jan 2019 13:10:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=whQJ-gj2M4ZJj8LnZXBK9k3fiRVjAXD9+M5D2Ja+N2mug@mail.gmail.com>
Message-ID: <CAHk-=whQJ-gj2M4ZJj8LnZXBK9k3fiRVjAXD9+M5D2Ja+N2mug@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>,
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

On Fri, Jan 11, 2019 at 1:05 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> > Yeah, my suggestion doesn't allow for batching, since it would
> > basically generate one trampoline for every rewritten instruction.
>
> Sure it does.  Just make 1000 trampolines and patch 1000 sites in a
> batch :)  As long as the number of trampolines is smallish (e.g. fits
> in a page), then we should be in good shape.

Yeah, I guess that's true.

But let's not worry about it. I don't think we do batching for any
alternative instruction rewriting right now, do we?

             Linus
