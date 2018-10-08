Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A788EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3DE2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="erCO+C8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3DE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJIA6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:58:22 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52491 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJIA6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:58:22 -0400
Received: by mail-it1-f196.google.com with SMTP id 134-v6so12586701itz.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p0ihHib7JrwgiKR6WGeZIF4tHJvBv5wG/tIjCcHeYes=;
        b=erCO+C8UGdUZ8CzkG6azwSF/Xx+EZtJxlF0bxE2kh5UEU4vS+ROE4elVcrVSD6y+lb
         7GpAlZHfIxEy0p+AfXaZtmVAc8S/SEGgz8iZtnkG4D0S0XesH3sbP9m7IfxZ0VfrIJwu
         Y+6orr3VA3tookEe46WKv2bkNjHwLuLD6Ung8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p0ihHib7JrwgiKR6WGeZIF4tHJvBv5wG/tIjCcHeYes=;
        b=ujR1bzpDRqAXLxpj+464XMxUkSOGsPeBPxpO7DcqraUqpEJX/WhMbYj9OdeSbxdV27
         Z3Vp+7PPLcIGDbbqCrcJn1zeUphAVecawu/+qenLVpbTEcEcyJuEIzrycIMM5YLVvAYY
         i7C9U9MPdc9nClnkbPvkpYwzBCm8LgnY+ZoxA2xcu2ar1mH1Zkic0Lsz4wrUQkFeSVci
         T1spLgoYdub9djZuI1OLW2vXpOE2lR+pBdcB5kx5nGLsXGwQzgFsUXd+UhwIlKEPIfLK
         ojCyQpwaRTt7tFQfsx/PRZ68zm2LPi6zSuYMAYut3B0E1xKQHib7C4POTzuBUAqeYM2c
         gCjg==
X-Gm-Message-State: ABuFfojG7axx+mdoPvp18T2s1fhMYBPHlfKrskK6JgoSBWFzWo13/Z2C
        pBBStudlIJpmjWtUNrGKmO0brw5bA2GX8iHEsP27Ng==
X-Google-Smtp-Source: ACcGV61FSPbxu0wNdvVUmHQDstM7JItXVhsAvL4HtlGaeAx3tTLZPW+dhkTnbNLUCn4yN1YglkZjmJN8vgIZyO8eBwM=
X-Received: by 2002:a24:e08f:: with SMTP id c137-v6mr17648540ith.71.1539020732146;
 Mon, 08 Oct 2018 10:45:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 10:45:31 -0700 (PDT)
In-Reply-To: <nycvar.YFH.7.76.1810081944030.14430@cbobk.fhfr.pm>
References: <20181006015110.653946300@goodmis.org> <20181006015720.634688468@goodmis.org>
 <20181006121211.GA5663@hirez.programming.kicks-ass.net> <20181006093905.46276505@vmware.local.home>
 <20181008072134.GB5663@hirez.programming.kicks-ass.net> <A9379DDB-3210-407C-8157-8DA980944F8C@amacapital.net>
 <20181008155757.GC5663@hirez.programming.kicks-ass.net> <F36C6419-7D92-4357-BDB1-D8B90DE09889@amacapital.net>
 <20181008163953.GD5663@hirez.programming.kicks-ass.net> <CALCETrWuGh=1n2bEE9B0eeyzvnaD4y_Sx6MB+r9B5aFXzg8qBw@mail.gmail.com>
 <CAKv+Gu-08i6QEahyYhBtCBmpOYNuxirgdsgGvRw+Y0DX3+DVNQ@mail.gmail.com> <nycvar.YFH.7.76.1810081944030.14430@cbobk.fhfr.pm>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 8 Oct 2018 19:45:31 +0200
Message-ID: <CAKv+Gu97y1vrqWa-mACkMveJTqP23FJUy2M21Fv8-ZUAkbuqRQ@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] jump_function: Addition of new feature "jump_function"
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 October 2018 at 19:44, Jiri Kosina <jikos@kernel.org> wrote:
> On Mon, 8 Oct 2018, Ard Biesheuvel wrote:
>
>> Does that mean that architectures could opt out of doing the whole
>> objtool + relocation processing thing, and instead take the hit of
>> going through the trampoline for all calls?
>
> There are architectures that aren't [currently] supported by objtool at
> all anyway.
>

That was kind of my point :-)
