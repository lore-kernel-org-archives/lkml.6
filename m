Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7xpgE4CDGVt6GwAAmS7hNA
	; Thu, 07 Jun 2018 19:25:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5C4E56089E; Thu,  7 Jun 2018 19:25:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MRc1Z02U"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AEED46063F;
	Thu,  7 Jun 2018 19:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEED46063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeFGTZN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:25:13 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:51113 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbeFGTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:25:12 -0400
Received: by mail-wm0-f42.google.com with SMTP id e16-v6so19938458wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AvR1kqhfs22TZmd8HUK/0h1P3g4Q4p3Bkf2ew2AhBbw=;
        b=MRc1Z02UfdeAd1aPqiTHWb0L4gScFciekJ8ytDxUVqrgTpnaEtkR+WcrvZQIZASjQg
         Bk3Tk57kSh+MlnbVwFnGkjCkAgGOrogGVFQS2KIp7ywPVC6qdmW86gdC2KMHRA0Rkg9h
         QKgmzY0/QugYO4gGI+ranqwENzJnynJfGctOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AvR1kqhfs22TZmd8HUK/0h1P3g4Q4p3Bkf2ew2AhBbw=;
        b=go0dBK2+etqPAdC7tcIdrJ8QiAFqudyRk5kDPIzI+IjtQhb8P9H4i9IFzCJvT0IeY+
         gm7EBW56RWZKysllwnl0HPP+B0AqVluIOapjaNNXf3xTFB7DU/5EHVAirt8wTs70CSGN
         iC1KYagiANNpXqkGl3fVZ/t8VxujTLZJ08EY1Cf1U5KM7GsdhdFhptDuJg7SbQQVNnQL
         6IEjirNdsT8YiAXfh/gsjPDaMVMbGzOy+I/3VPWj81mjbtKbfs5haHLt1hXLj9DNYWl+
         3poC99n0mc4owg91U2g0jICCV9erABH7QMlyhSGBJHeHJevAsICcyMjP5xC5QrfyjrJo
         ypLw==
X-Gm-Message-State: APt69E2Ec48xnogObKnfHz13kQslmzmDuqYFKfxdPtnb3EkbDVvfDgzX
        mm0bIuIHVVoUP+3bxSoGYpcfzqyEOko=
X-Google-Smtp-Source: ADUXVKKWBjr59BsBl/V/7hxlUqkmYqRKaJ8ogOPmr49XeRVV15cPnz+kIXIUJfcRyzWjvDiUdsy3VQ==
X-Received: by 2002:a50:b0c3:: with SMTP id j61-v6mr3784921edd.249.1528399510941;
        Thu, 07 Jun 2018 12:25:10 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-126-104.cgn.ip.fibianet.dk. [5.186.126.104])
        by smtp.gmail.com with ESMTPSA id s38-v6sm6262383edd.2.2018.06.07.12.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 12:25:10 -0700 (PDT)
Subject: Re: sparse warnings in overflow.h
To: Kees Cook <keescook@chromium.org>, Miroslav Benes <mbenes@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <alpine.LSU.2.21.1806071258310.7958@pobox.suse.cz>
 <CAGXu5j+XFR7BtYPU6G4CeLFREWevN+GC1FPX1hPAYA1LRBM9Bg@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4d2aaa98-1655-3ab8-8ce8-bf4b9c7d2dbc@rasmusvillemoes.dk>
Date: Thu, 7 Jun 2018 21:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+XFR7BtYPU6G4CeLFREWevN+GC1FPX1hPAYA1LRBM9Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-07 20:35, Kees Cook wrote:
> On Thu, Jun 7, 2018 at 4:01 AM, Miroslav Benes <mbenes@suse.cz> wrote:
>>
>> Hi Kees,
>>
>> sparse (make C=1) gives me this warnings today...
>>
>> ./include/linux/overflow.h:254:13: error: undefined identifier '__builtin_mul_overflow'
>> ./include/linux/overflow.h:254:13: error: incorrect type in conditional
>> ./include/linux/overflow.h:254:13:    got void
>> ./include/linux/overflow.h:256:13: error: undefined identifier '__builtin_add_overflow'
>> ./include/linux/overflow.h:256:13: error: incorrect type in conditional
>> ./include/linux/overflow.h:256:13:    got void
>>
>> This hunk obviously fixes it, but I'm really not sure if it is a proper
>> fix.
>>
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index f1a7492a5cc8..15e55b89e952 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -344,6 +344,6 @@
>>   */
>>  #define uninitialized_var(x) x = x
>>
>> -#if GCC_VERSION >= 50100
>> +#if GCC_VERSION >= 50100 && !defined(__CHECKER__)
>>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>>  #endif
>>
>> Any idea?
> 
> Hi! Yeah, that's probably the correct approach. If the checker doesn't
> have it, the builtins need to be disabled. :)

IIRC, the problem is that sparse pretends to be the gcc sparse itself
was built with, which is obviously entirely unrelated to the C dialect
that that particular sparse version groks. Sigh. Ack to the fix above.

Rasmus
