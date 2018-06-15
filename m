Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2931C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9894F208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO9TZTBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9894F208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756587AbeFOSdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:33:21 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50309 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756476AbeFOSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:33:19 -0400
Received: by mail-it0-f68.google.com with SMTP id u4-v6so3994642itg.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/8NAJmNYARFyNWzHn+uIP1sczZ2b6YDscWv813K097U=;
        b=fO9TZTBN7tYEYp4/OEn8xmbDPgfFgtnu5G2cL+bogZrSvXLhaw/Rqm2pk/xwXORtEY
         ius43RQRmf62BbZUlLv70226wJFjhwj1F+K7qB99BwKZ1xJ45upB1bgQxbKKUbF71E6t
         xjmu9OXM7GUegUaIIl0Enyym2MaPZWbQHirhzn6sPS+fryQFcrMU6+8I/BUEMy0LGaBu
         cLPbHC06jE79xWqL1ctl7RPHtspSTDfV3+91ESyHYfPf1Xwqm7++cQSeW520j/07k1po
         jPwzYjp0WBJK3lfh5J8hQcuIuEk5PQg+/V6+ae0skl5sfzt7Qyenlgq66k1Z75F0kJbF
         /NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/8NAJmNYARFyNWzHn+uIP1sczZ2b6YDscWv813K097U=;
        b=AzbLZXSI3ok0mCywtwJuoKkbIcP5JDcXoCC7Fcqul7gPIlcfa+GgbDFHjasMyrTN9L
         6EEa0mxdWPdZDp/aAMmNQVpqXhZHMS1P7FiJ5l8lYUvxh0LPJRqIba46HSK4VYuhAwWN
         GqiRNw7sA1Cjfc/BlmyGzCNocgvxWg5jWYbyPMsB9XjoNRO2deGIgsCuqpi/YvytdJgn
         IfXgZsDtFtEabivNNcs9vybw+ix008JRK3d/oda1z8tXOTGRjGuYomYQ7QTd749UVxwq
         skKsQLr0WIWmONZJ9SQigd5ZzMxRR/7fj15VDPEzu9d6e/P/ppOqwecvvyn3YW0EZCyk
         oPmw==
X-Gm-Message-State: APt69E2YMnAxIWjstTmne9aMPuW3YwN/W4zKQvp5FfLavyeiLm9yrh0X
        pwTDd1IJGbgj9oLRrLSoyz8qrcp7JftTTh7WWQ==
X-Google-Smtp-Source: ADUXVKJW1Be92EPwKeIH2NPjeuKmqO1Ajo9AlOlzVCzP3EAZcrxo0SqOlwWAfob2TzGZxsJpNU/Im9FXGVzi8mWk7jw=
X-Received: by 2002:a24:eb0e:: with SMTP id h14-v6mr2401507itj.69.1529087599004;
 Fri, 15 Jun 2018 11:33:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:b155:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 11:33:18
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1806151815080.1582@nanos.tec.linutronix.de>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com>
 <alpine.DEB.2.21.1806151815080.1582@nanos.tec.linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 15 Jun 2018 14:33:18 -0400
Message-ID: <CAMzpN2hMFioZR0ERS8B2cMy4DrNObQYcaO=q=B3HycA1qfvpDQ@mail.gmail.com>
Subject: Re: Lazy FPU restoration / moving kernel_fpu_end() to context switch
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:25 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 15 Jun 2018, Jason A. Donenfeld wrote:
>> In a loop this looks like:
>>
>> for (thing) {
>>   kernel_fpu_begin();
>>   encrypt(thing);
>>   kernel_fpu_end();
>> }
>>
>> This is obviously very bad, because begin() and end() are slow, so
>> WireGuard does the obvious:
>>
>> kernel_fpu_begin();
>> for (thing)
>>   encrypt(thing);
>> kernel_fpu_end();
>>
>> This is fine and well, and the crypto API I'm working on will enable
>
> It might be fine crypto performance wise, but it's a total nightmare
> latency wise because kernel_fpu_begin() disables preemption. We've seen
> latencies in the larger millisecond range due to processing large data sets
> with kernel FPU.
>
> If you want to go there then we really need a better approach which allows
> kernel FPU usage in preemptible context and in case of preemption a way to
> stash the preempted FPU context and restore it when the task gets scheduled
> in again. Just using the existing FPU stuff and moving the loops inside the
> begin/end section and keeping preemption disabled for arbitrary time spans
> is not going to fly.

One optimization that can be done is to delay restoring the user FPU
state until we exit to userspace.  That way the FPU is saved and
restored only once no matter how many times
kernel_fpu_begin()/kernel_fpu_end() are called.

--
Brian Gerst
