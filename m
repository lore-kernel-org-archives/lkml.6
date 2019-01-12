Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91917C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 23:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558F220880
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 23:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547337280;
	bh=t0r0aXUvIl8mMcbhKbl3RlhOozK/J15cc2VqQbgLfAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vc9jzTjFu5H6S5iCZFqBoMm1LujGQc9JDV4SwY6V/GHrsrRsdnq1AA4NidG9GLgg3
	 c2HhTSM8AnW+hQsFHPYrL/EN1oOqF5/veZLIt6uuddigSmDAfX/ZAapt2BMnmRBqvC
	 s48ufaCT6nOxpr55ckUEFBXwSZCY3xVXGmBlagVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfALXyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 18:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfALXyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 18:54:37 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9DD22133F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547337276;
        bh=t0r0aXUvIl8mMcbhKbl3RlhOozK/J15cc2VqQbgLfAg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mtIUJO8WuCITsn53lljn42bB+ycg0IxLKMfZIK8BEkX6l+4IFLI1NnXRr3Vo7aPUW
         GbCMJ6KhpQruIBEKMU3eYJo/5ps0IRByQ0hrO0eMHeKa0EWN9OGpt6xc52Gw4qanpV
         U32khLctJQh1/FYtskqWbwVqKieYNN9s4QtnIuVk=
Received: by mail-wm1-f41.google.com with SMTP id y8so5552874wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 15:54:36 -0800 (PST)
X-Gm-Message-State: AJcUuke/DshnF3BVDOqRp3orTG7M8gLFTMZ77dfF75dHYK6UJBoFIwCw
        ojDBFe9StUzKVZXm6xc4riFwLHeIL7nNyHvPw+pavQ==
X-Google-Smtp-Source: ALg8bN7SlgJZVyGxzwIf9rEL9wq4NztBgz4UHl6lqQ8a3mAOrOYkd9IXL9JRBPPA+6Sv+DFkrcNlGNKPFXglYn+s/xo=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr6782839wmd.83.1547337275055;
 Sat, 12 Jan 2019 15:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20190110205226.iburt6mrddsxnjpk@treble> <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com> <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble> <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble> <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
 <20190111212210.veyfn5vvjswcwacm@treble>
In-Reply-To: <20190111212210.veyfn5vvjswcwacm@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Jan 2019 15:54:22 -0800
X-Gmail-Original-Message-ID: <CALCETrU4BLNRxHWv3+8_4+0d1XQmRxhhRfWpn0jNnXBn+YJedQ@mail.gmail.com>
Message-ID: <CALCETrU4BLNRxHWv3+8_4+0d1XQmRxhhRfWpn0jNnXBn+YJedQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

On Fri, Jan 11, 2019 at 1:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Jan 11, 2019 at 12:46:39PM -0800, Linus Torvalds wrote:
> > On Fri, Jan 11, 2019 at 12:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > I was referring to the fact that a single static call key update will
> > > usually result in patching multiple call sites.  But you're right, it's
> > > only 1-2 trampolines per text_poke_bp() invocation.  Though eventually
> > > we may want to batch all the writes like what Daniel has proposed for
> > > jump labels, to reduce IPIs.
> >
> > Yeah, my suggestion doesn't allow for batching, since it would
> > basically generate one trampoline for every rewritten instruction.
>
> As Andy said, I think batching would still be possible, it's just that
> we'd have to create multiple trampolines at a time.
>
> Or... we could do a hybrid approach: create a single custom trampoline
> which has the call destination patched in, but put the return address in
> %rax -- which is always clobbered, even for callee-saved PV ops.  Like:
>

One think I particularly like about the current design is that there
are no requirements at all on the calling convention.  I think it
seems fragile to add a calling convention constraint that only applies
when there's a race.  I'd rather do a longjmp-like hack or a stack gap
adding hack than make the actual static calls more fragile.
