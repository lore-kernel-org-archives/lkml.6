Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D54C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A66208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UJmpPae6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfAJXKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:10:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38255 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJXKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:10:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so11265096lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u50w8boiNftTwFOQnBwDE2vr4tMTPEPc+OhoF2hUl3g=;
        b=UJmpPae6tx6DFCOpaz6hn0oqaollZO2kxdvdtj/qdojKf1lKYyh9D9cqvqcNLiDs1A
         rYu4saDT69SrH9uB/8FLKuMJ8URdgPatiFgwaUgQcAg4fuG8Tj+6yG4eGKUu0ueoxK7N
         PPstmOrn/VP6YbHAfE9sMxx74zcavq4f0CC+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u50w8boiNftTwFOQnBwDE2vr4tMTPEPc+OhoF2hUl3g=;
        b=kSQeZZYpJOJngwEklxnpdfgaBcljYeR7USTRlr/pzJ1BimqVlsN8fRNmuMRpmG9vjE
         boTgI6zLNm8/Tck3JJl4Djc6qaTGt9uxZupvJbUVEiOBkrUVT7r2e740cVa4n5Dn4wzT
         sB94PiMK146Tnc6x20W3hA+2oxDrhr97s/AVIlh4h1R3FzYy1RH43e8Y8hbV1iX+nvhB
         aD42H+1vsJwsTkdH4FXCwDgx+DUx8XpprfDIw4Y3z4ZGJaXJ6IpI0nBdWmOvhLInM3XR
         kZNT7tPX3uu4u0VpG+7gRP48OtDXnnB4p2xJx9ov06Awy/4yG+PZGx6Xtw44dR/1mS2d
         OlTg==
X-Gm-Message-State: AJcUukchFEe82ftelT+zMaUOiplqj7WnSHkenDWx9nTXFz22qfEIP/F2
        vSncD6c/ZgeiJmxglSiHOILmktnGrJAu4w==
X-Google-Smtp-Source: ALg8bN4l6TdDgDG/jTHYsWG2JxqdCvYhNpNvuXsSft7ai0IHregYjDUD1sZjknExQPIOhQH0tZauzg==
X-Received: by 2002:a2e:851a:: with SMTP id j26-v6mr7025561lji.163.1547161842650;
        Thu, 10 Jan 2019 15:10:42 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 10sm11847073ljr.4.2019.01.10.15.10.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 15:10:42 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id k15-v6so11234815ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 15:10:42 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr7173902ljs.118.1547161358642;
 Thu, 10 Jan 2019 15:02:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547073843.git.jpoimboe@redhat.com> <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
In-Reply-To: <20190110205226.iburt6mrddsxnjpk@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 15:02:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
Message-ID: <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Static calls
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:52 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Right, emulating a call instruction from the #BP handler is ugly,
> because you have to somehow grow the stack to make room for the return
> address.  Personally I liked the idea of shifting the iret frame by 16
> bytes in the #DB entry code, but others hated it.

Yeah, I hated it.

But I'm starting to think it's the simplest solution.

So still not loving it, but all the other models have had huge issues too.

                Linus
