Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE8CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F42824B84
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TR1O7p1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F42824B84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935175AbeF1J3n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:29:43 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40763 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933194AbeF1J3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:29:41 -0400
Received: by mail-it0-f67.google.com with SMTP id 188-v6so11515374ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 02:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NH94xwzrezkfWmL9k+/At6t18Sqs0bQxFsELdUFZX3o=;
        b=TR1O7p1wqsFVhmxDOdFvYrGzjSIGGSLL+Vo1jpZGzt7OimN8J6zu/QnzrmEy4ODGG1
         OFGuxJoxJFypJyIETXDdWVn6AGkvZ5EKOuYaBkuaoYUTafV798Bi7Xe9RIvplFEQ3Sfj
         E21Fd2IOdsjoew28d41mwdw9y0d4ILDlWcHLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NH94xwzrezkfWmL9k+/At6t18Sqs0bQxFsELdUFZX3o=;
        b=p5jtuRRYO34nlw2Dn6oOZp9LVkMsZKitfSnVYv0lCq+bmjfKgUtdaA6Un8GP6b4DJH
         VtqutFS1ddx+o7uHjI2R5XqOVvL77xO8sH7OVysnt1GZnuyCr7ySfRgPMtXFX2eBD4xo
         c5M96Vz+MQzcg1iP4QOmmz4JSIVNzC84qAR3IIS4TWNm4/ZBKP9nElljgSkieKDVgbTS
         vHeyng9JDuV7+rKIHnCZtmRpjQjfHErseesb056rKVq+VMN/EP2M4UyB0gAVzSf5s5yd
         jYzoyajm6popPbAfrV/NQr6H0kCChEnoQzmFuJWlSvOGKYj7Hc4W8QAEXZ4UjQJ2C9v9
         TjYg==
X-Gm-Message-State: APt69E0IaLCg+x6LUxnzfk3kDdKywczviy7aZwW1c3JGnjfctKynf/3F
        I6jnJQ1iU6tcycq8+bi3otpzxO7zIx46kT9zBABLmw==
X-Google-Smtp-Source: ADUXVKKHJHRvYgs3kDo+9B2XPaGCIQChgQ9Z+oWe7eVtPnQDl6ZBxfF+JXNEkEXP9ocOm7nLd0gUAjytp0EtOakwhA8=
X-Received: by 2002:a24:6196:: with SMTP id s144-v6mr7792751itc.68.1530178181051;
 Thu, 28 Jun 2018 02:29:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 02:29:40
 -0700 (PDT)
In-Reply-To: <20180628092504.GC2494@hirez.programming.kicks-ass.net>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-3-ard.biesheuvel@linaro.org> <20180628085003.GA2494@hirez.programming.kicks-ass.net>
 <CAKv+Gu87DmGLG7N8X8+V7LppXm72SJUmCcEpaehCE5Rt0Z4FNw@mail.gmail.com>
 <CAKv+Gu-xPR6UEiP0NT0zYXKRYXqwFCXP=nf0cC87PZdDYBZB4A@mail.gmail.com> <20180628092504.GC2494@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Jun 2018 11:29:40 +0200
Message-ID: <CAKv+Gu-bL0neh61=1B=Dja7+tsH_ong731t2Xp17h4E1fjavjA@mail.gmail.com>
Subject: Re: [PATCH 2/5] kernel/jump_label: implement generic support for
 relative references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 June 2018 at 11:25, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Jun 28, 2018 at 11:04:45AM +0200, Ard Biesheuvel wrote:
>> On 28 June 2018 at 11:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >>> @@ -56,7 +72,9 @@ jump_label_sort_entries(struct jump_entry *start, struct jump_entry *stop)
>> >>>
>> >>>       size = (((unsigned long)stop - (unsigned long)start)
>> >>>                                       / sizeof(struct jump_entry));
>> >>> -     sort(start, size, sizeof(struct jump_entry), jump_label_cmp, NULL);
>> >>> +     sort(start, size, sizeof(struct jump_entry), jump_label_cmp,
>> >>> +          IS_ENABLED(CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE) ? jump_label_swap
>> >>> +                                                           : NULL);
>> >>>  }
>> >>
>> >> That will result in jump_label_swap being an unused symbol for some
>> >> compile options.
>> >
>> > No, and isn't that the point of IS_ENABLED()? The compiler sees a
>> > reference to jump_label_swap(), so it won't complain about it being
>> > unused.
>
> Ah, ok. I hadn't figured it was quite that smart about it.
>

Yeah. I could use a temp variable to make the indentation less
obnoxious, but since this is an opt-in feature, I'd like to preserve
the NULL (*swap)() argument for the existing users.

>> > Meh. I thought IS_ENABLED() was preferred over #ifdef, no?
>
> Dunno, I just reacted to the proposed code's uglyness :-)
>

I will try to come up with something that rhymes, ok? :-)

>> ... and it means the sort() routine will unconditionally perform an
>> indirect function call even if the arch does not require it.
>
> Yeah, not sure I care about that here, this is a one time affair, very
> far away from any fast paths.
>

Fair enough.
