Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165372086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgWNlcXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165372086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKJDG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:06:57 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36604 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbeKJDG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:06:57 -0500
Received: by mail-it1-f193.google.com with SMTP id w7-v6so4410293itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9aGMBaqfHr5+oz0GStiUC20Z8K8nSZZh//9q/PC4HTY=;
        b=GgWNlcXHDfun5IlXKHNJ/saWyUR3Wk61IZwk6LPbtCnrA0mHZEH4DkH/rp5dD4/FSY
         d5HPh5d+kbeSeS4GccboLBgegucqZwk2jBo1bMFO/wezkngg2km1l4muizNZEBf4lEiZ
         gNLkaVDMxgzhyVt8peKl1RO5nQ30RFw26qjPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9aGMBaqfHr5+oz0GStiUC20Z8K8nSZZh//9q/PC4HTY=;
        b=jLcwXvJcj97qGD3xezwARwaZtYrJO01u//zkXCbYjbXlh0hTfNJYZ9ce+o1Y8P6qXC
         QqSvJovQiwP31PbiKEgm4JHodsKjH84cdGiKESLuWv5MY/zUez5U0HNzXls+BUcUcSSL
         l+/MWwhLw4XJxI4HXTOlGLVR1nea5kL2ADiPAM6IdRaBWpKirB74/BJI3LLq4IPWh/EA
         qDIz6a+YF2CIuOJ0mtujtDfFWIpfN37gbUC70WQbTdoNAYk4ZYudN0ZtAko77eBSbsYr
         t5Im9WyPDUK9wW+9pON2PIaLJTsuJQkz0nEUhl56eoUzTB2/UN843izbzpSBNN7tX3hr
         MkTA==
X-Gm-Message-State: AGRZ1gJQOr6CrW8TGd8jYZFCfwq6Wa+GhZS1ICRqM/Mte1Cus0HHSMPB
        zjsLYVZhWK2GdoypGRnvG35H6TTMDnITk+o3lm/atw==
X-Google-Smtp-Source: AJdET5cKHVONnn76fUFak8ZplS/m+niHiw7DNLGpX4DQuL+9u75tRNaSf8gF2i3rYY+oXbI8QPsiGj3ZDHZk5feq0zs=
X-Received: by 2002:a02:9f85:: with SMTP id a5-v6mr8696367jam.2.1541784325233;
 Fri, 09 Nov 2018 09:25:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 09:25:24 -0800 (PST)
In-Reply-To: <CAKv+Gu_J1b30+pMNRF0icEpyew4TM_VP3ShG=4HkLnk=fRL9zg@mail.gmail.com>
References: <cover.1541711457.git.jpoimboe@redhat.com> <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
 <CAKv+Gu9bMkFEx_GxH3uLm0gveQurp7ELDi6C5NvpugufPFMbRA@mail.gmail.com>
 <20181109151028.faifw66enzye32gg@treble> <CAKv+Gu_J1b30+pMNRF0icEpyew4TM_VP3ShG=4HkLnk=fRL9zg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 9 Nov 2018 18:25:24 +0100
Message-ID: <CAKv+Gu-DOW2WT=h8C0x5igbCDAc2bp3mTRM6U_wTJST+RnVicg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 November 2018 at 16:14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 9 November 2018 at 16:10, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> On Fri, Nov 09, 2018 at 02:39:17PM +0100, Ard Biesheuvel wrote:
>>> > +       for (site = start; site < stop; site++) {
>>> > +               struct static_call_key *key = static_call_key(site);
>>> > +               unsigned long addr = static_call_addr(site);
>>> > +
>>> > +               if (list_empty(&key->site_mods)) {
>>> > +                       struct static_call_mod *mod;
>>> > +
>>> > +                       mod = kzalloc(sizeof(*mod), GFP_KERNEL);
>>> > +                       if (!mod) {
>>> > +                               WARN(1, "Failed to allocate memory for static calls");
>>> > +                               return;
>>> > +                       }
>>> > +
>>> > +                       mod->sites = site;
>>> > +                       list_add_tail(&mod->list, &key->site_mods);
>>> > +
>>> > +                       /*
>>> > +                        * The trampoline should no longer be used.  Poison it
>>> > +                        * it with a BUG() to catch any stray callers.
>>> > +                        */
>>> > +                       arch_static_call_poison_tramp(addr);
>>>
>>> This patches the wrong thing: the trampoline is at key->func not addr.
>>
>> If you look at the x86 implementation, it actually does poison the
>> trampoline.
>>
>> The address of the trampoline isn't actually known here.  key->func
>> isn't the trampoline address; it's the destination func address.
>>
>> So instead I passed the address of the call instruction.  The arch code
>> then reads the instruction to find the callee (the trampoline).
>>
>> The code is a bit confusing.  To make it more obvious, maybe we should
>> add another arch function to read the call destination.  Then this code
>> can pass that into arch_static_call_poison_tramp().
>>
>
> Ah right, so I am basically missing a dereference in my
> arch_static_call_poison_tramp() code if this breaks.
>

Could we call it 'defuse' rather than 'poision'? On arm64, we will
need to keep it around to bounce function calls that are out of range,
and replace it with a PLT sequence.
