Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5412C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD162184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547240735;
	bh=Zfh6D1RVrQv4DRV5bo3WWyY1KTMtcG+15xMjCS8Rc1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e0voUsWzULUmNX+Nf9hrn9d4oFptTlSNC2CHlebm5fI84DW3omKkPVOGvCYVeoY6S
	 zU8QHyzuFhFY1bEpj2E6ebkIeMnFVqBeLilTAWQ0TmSBjN3SrmAFUCFUk+hzBWgWJ0
	 3WzM+7vQQE475Loo7Z2qiGH8+2wl60/X2JP+LlTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfAKVFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:05:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfAKVFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:05:34 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AB812184B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 21:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547240733;
        bh=Zfh6D1RVrQv4DRV5bo3WWyY1KTMtcG+15xMjCS8Rc1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NmoVqAxN8PA48VD4j1Nounlg6GNvlN9s1qUcv2Gvvccms9UnDou3KOEogYX1o9Jd1
         6xiBgn0R51czFlpENF6dEWF4ht4bvsKskoOa95KxU2ZrnxliI1k+Nyf/KicS29nOR+
         eTz/AcOvRvkFKe5gSYa3ovMFIKSMgBNinXJYdH9g=
Received: by mail-wm1-f48.google.com with SMTP id f188so3630726wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:05:33 -0800 (PST)
X-Gm-Message-State: AJcUukcW/d2nYL2zB5JIh/gC4v589j6LfY01qNFi14Crnn7/YucS1Ho4
        cznOwOh7p8j/gcMujj9BQe0HpYtA8G1FqU5SirlE5g==
X-Google-Smtp-Source: ALg8bN7LRmOrqa+eG2wAFXhgYNqYfPuD7LbT7m0PEBelrczx355yOdMzIa3pGBi3cThev3jApJSrctGvkoenCXZVTeE=
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr3875879wmk.74.1547240731783;
 Fri, 11 Jan 2019 13:05:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble> <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble> <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
In-Reply-To: <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 11 Jan 2019 13:05:20 -0800
X-Gmail-Original-Message-ID: <CALCETrXZdzNS=Bbv=qyM8iBC82QWOQqcfN1GFfcn6UHvePatHQ@mail.gmail.com>
Message-ID: <CALCETrXZdzNS=Bbv=qyM8iBC82QWOQqcfN1GFfcn6UHvePatHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jan 11, 2019 at 12:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > I was referring to the fact that a single static call key update will
> > usually result in patching multiple call sites.  But you're right, it's
> > only 1-2 trampolines per text_poke_bp() invocation.  Though eventually
> > we may want to batch all the writes like what Daniel has proposed for
> > jump labels, to reduce IPIs.
>
> Yeah, my suggestion doesn't allow for batching, since it would
> basically generate one trampoline for every rewritten instruction.

Sure it does.  Just make 1000 trampolines and patch 1000 sites in a
batch :)  As long as the number of trampolines is smallish (e.g. fits
in a page), then we should be in good shape.
