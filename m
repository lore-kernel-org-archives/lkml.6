Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F5BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4EC21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCBd34nN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4EC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJIBAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIBAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:00:14 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40CB214FA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539020844;
        bh=8D+awCa3qqzmyCe4kPPrdC/Oz1P+gaNIc4Pgm4R8TQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WCBd34nN0x3YGlpO1ZgJ32kG4QMgmPDHbdWNHtjYMsRXQOPIjyuuhKJMk8TBcjAjV
         pPQYVHZd7KUFQ4yLBHM1ApoXsNrSmqaKLh+Ns7gxfJ3k9F4z0s6xrfXGcsqMFJlFus
         QXjdrAJkJ2etQzXJFV9vXMsNTcIeVO6CS2Zg3Gxs=
Received: by mail-wr1-f41.google.com with SMTP id e4-v6so21796336wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:47:23 -0700 (PDT)
X-Gm-Message-State: ABuFfoipC9uynXpZRHJSCDN8s4Xkd6DGXzPnSJVR/5U2vfYaiC6Eff10
        +5tJukHF1rKk2dYfIl9G4OUYialgFRy7yP7+PxeVgg==
X-Google-Smtp-Source: ACcGV61PJYsT03GZuICP/A2bwvvB6W7CcgAsB4Iyb2LU+PXg4nOjcqMhdRAK3qb9pyy7Qxae1rnQkxuClLQv1WEch0A=
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr18167234wrb.283.1539020842298;
 Mon, 08 Oct 2018 10:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net> <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net> <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181008163953.GD5663@hirez.programming.kicks-ass.net> <CALCETrWuGh=1n2bEE9B0eeyzvnaD4y_Sx6MB+r9B5aFXzg8qBw@mail.gmail.com>
 <CAKv+Gu-08i6QEahyYhBtCBmpOYNuxirgdsgGvRw+Y0DX3+DVNQ@mail.gmail.com> <nycvar.YFH.7.76.1810081944030.14430@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1810081944030.14430@cbobk.fhfr.pm>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 8 Oct 2018 10:47:10 -0700
X-Gmail-Original-Message-ID: <CALCETrVHRV6nVANL7i1qGBY3vp9kfY_S1tvnhiL+iowr5RDzxg@mail.gmail.com>
Message-ID: <CALCETrVHRV6nVANL7i1qGBY3vp9kfY_S1tvnhiL+iowr5RDzxg@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mhelsley@vmware.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 10:44 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Mon, 8 Oct 2018, Ard Biesheuvel wrote:
>
> > Does that mean that architectures could opt out of doing the whole
> > objtool + relocation processing thing, and instead take the hit of
> > going through the trampoline for all calls?
>
> There are architectures that aren't [currently] supported by objtool at
> all anyway.
>

The the credit of most architectures, though, the only reason x86
would want to use objtool instead of digging the results directly out
of the relocation data is that x86 has an overcomplicated instruction
encoding and there's no fully reliable way to find the address of the
instruction that contains a given relocation without fully
disassembling the binary.
