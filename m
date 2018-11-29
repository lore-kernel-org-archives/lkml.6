Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5712220868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DJSfdFoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5712220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbeK3ElZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:41:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46852 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbeK3ElZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:41:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so2047103lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxTotULv5EqGMkW2xeKCdTtPj3sONi0p+WZ1ZNgSDTs=;
        b=DJSfdFoTUZqDJ51bHvWUKqyQRvhblc/lbU6czVs/zIALcktFBMxDjS44XfWQ2k9utJ
         qWWYTR96+QaUFDfpnjY2A56mjCmjToJhVNQwFJhVheiEf5iOjoeFPobFiGmCEqzda/W9
         xkgjmvOZLykug/D3CXG2uYtXaErPHQNsLOosw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxTotULv5EqGMkW2xeKCdTtPj3sONi0p+WZ1ZNgSDTs=;
        b=ZLwyitclCScA/Xk1V0xgWYZkk4B1//neSAUUnnWgVXGm0OZeCj9MH0p7lE8xbHwNE2
         zdOccp2EAJtXtkrwbUVvb0dtLzKS5rnxxGEw/W7xw8lwJc6zZ4xWfBYJt05qykCZ7iou
         FFpOMSNXsHhw2mSuzlqy8dyKN2V9cN+K/kI72az22t02ljuRI8TKt9zTWAFv7dNg7saa
         8KBw7S4wm2S003n5SckjtH8mja5VNdab+yG3BuFOHnPuzlouf4ffgvqjnR+md3WROeu6
         h3g6pl1mObZSrTmd9ECJRN0dPTNPv+K0HKGethWlFIuQJdjFBym0RFf7o6qovqSxCuPX
         dJtg==
X-Gm-Message-State: AA+aEWaO11xaaB5IjnSoYNNDtLB1KRllLt1jhcvTmVtc1fvw2BbLzUWg
        pOj4WOQdQ2+x7I3NLYWsAgVadYew/dw=
X-Google-Smtp-Source: AFSGD/Uip/yADr/g6kzjlN/oC7KmSpaQPa6NNYazUQvtQPTRgpIEyDVHMmpuoIpjDqwoWq6VZ8WXFg==
X-Received: by 2002:a19:5349:: with SMTP id h70mr1620074lfb.50.1543512915344;
        Thu, 29 Nov 2018 09:35:15 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m77sm410107lfg.3.2018.11.29.09.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:35:15 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id z13so2059840lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:35:14 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr1532106lff.16.1543512605768;
 Thu, 29 Nov 2018 09:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20181126160217.GR2113@hirez.programming.kicks-ass.net>
 <20181126171036.chcbmb35ygpxziub@treble> <20181126175624.bruqfbkngbucpvxr@treble>
 <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble>
 <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com>
 <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net>
 <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble>
 <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com> <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
In-Reply-To: <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Nov 2018 09:29:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgoeXuodaDkKNneiQmU3mxkt2C1MeyPF5_0NX1VSQV=XQ@mail.gmail.com>
Message-ID: <CAHk-=wgoeXuodaDkKNneiQmU3mxkt2C1MeyPF5_0NX1VSQV=XQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call
 implementation for x86-64
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:02 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > - just restart the instruction (with the suggested "ptregs->rip --")
> >
> > - to avoid any "oh, we're not making progress" issues, just fix the
> > instruction yourself to be the right call, by looking it up in the
> > "what needs to be fixed" tables.
>
> I thought that too.  I think it deadlocks. CPU A does text_poke_bp().  CPU B is waiting for a spinlock with IRQs off.  CPU C holds the spinlock and hits the int3.  The int3 never goes away because CPU A is waiting for CPU B to handle the sync_core IPI.
>
> Or do you think we can avoid the IPI while the int3 is there?

I'm handwaving and thinking that CPU C that hits the int3 can just fix
up the instruction directly in its own caches, and return.

Yes, it does what he "text_poke" *will* do (so now the instruction
gets rewritten _twice_), but who cares? It's idempotent.

And no, I don't have code, just "maybe some handwaving like this"

               Linus
