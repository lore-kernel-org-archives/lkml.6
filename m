Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF13C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79802083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9eq72w2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79802083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeHaX1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:27:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36842 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:27:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id 93-v6so2103816qks.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xxsknbdg6ezpXaImPpBrSueOhH88nsn7E5TIwN+Fe+s=;
        b=B9eq72w2NAtUuzbtIervui6AGcftF8IdS3Mvf9gq0ThicAytuQBozYjhTVTuQwryUL
         siBsZPqqpAwwE5LSEEnghUR2G2fJF9E0ffjqaxNVdt9n0BIvei2WY3Z6eR7EOABO+T1Y
         XxO1316730nsz7z6KpUTqHUUkF5uffWkhMUkke3acW3D6Afwwg4xVEjvUlI4YjAUtO/y
         4pDYXn4tzfz2gzjpi/+0sl96JCj4QWHZsL4vIn9If1fc1/FMT6lCNBLTvw/vgshm7xxB
         KAiB9AszC+fQS79Bc/cuXod4yMiH0HV/ZKyMIyxCtrPIChF/YJYlobKDkqyxxvQubVqr
         JGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xxsknbdg6ezpXaImPpBrSueOhH88nsn7E5TIwN+Fe+s=;
        b=K5Op1rPbRqDDO7EeuabUE88vGFZt+MCrQdcI/egAHkawg6bnKeaNMPW8NE3YKN3Dki
         ZitZtaEtRhHr4HsWzqisx0lBCNZDEX97aXrtbtW1oexEenPsksZ7PKzeZQF/JMsTS4HD
         7ks5PZos2oC0CwUpAkWmVw+jMw/izPv8LEroU/5kad/mMUJV1d2pUB8WkLlcLr+OIdD1
         cIqptda33OvuTnWq7fZXJM75wsdNoTSGJpzcqOBw7nW+NsOqs0qfpare5z2+M4FWjx7d
         9R4J40g44UyNxXTVTaj1i4CZ691yqzdmNLTxF4qF/ls2QxlAsPnPGFOq046CyEnueeuW
         QQ/w==
X-Gm-Message-State: APzg51Cjl/oHgi7AdZ9IlsSSOmfWEeKFLYI3pBaM+s6JDvBn/UToLvdi
        G2eyJF7T/dR2E8Ti/CCSPnf+p04ZLrgmqYot2J0=
X-Google-Smtp-Source: ANB0VdawGLbFSERDgKn7JSD3UXqL4sSY7YqNjsKWRz9SN3aKPDEJLh1PmCrBAgLvrML1CjS8bDrbgkiGo8qaDWagxwo=
X-Received: by 2002:a37:1383:: with SMTP id 3-v6mr16352955qkt.129.1535743088604;
 Fri, 31 Aug 2018 12:18:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 12:17:48
 -0700 (PDT)
In-Reply-To: <CAKwvOd=M8H+95qh36-xMA6F7BD1TbOFO_cP8zrVhCBCyCy7e9Q@mail.gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com> <CAKwvOd=M8H+95qh36-xMA6F7BD1TbOFO_cP8zrVhCBCyCy7e9Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 31 Aug 2018 21:17:48 +0200
Message-ID: <CANiq72=UOrpFwDLetr8LEjEvPzisn4UvoLq+CuOUcu3zJpXmSA@mail.gmail.com>
Subject: Re: [PATCH 2/7] Compiler Attributes: use the no-underscores syntax
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, Aug 31, 2018 at 8:51 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Fri, Aug 31, 2018 at 10:05 AM Miguel Ojeda
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index 7c0157d50964..e0e55eb3f242 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -23,7 +23,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>>  #define __branch_check__(x, expect, is_constant) ({                    \
>>                         long ______r;                                   \
>>                         static struct ftrace_likely_data                \
>> -                               __attribute__((__aligned__(4)))         \
>> +                               __attribute__((aligned(4)))             \
>
> Can this be __aligned(4)? As in make use of the newly feature detected
> attributes?

I was thinking of doing this in a full conversion over the full kernel
tree in separate patch(es) after the 7th (maybe for v3?). In
particular, aligned and section have a lot of them:
  * 349 ((aligned
  * 66 ((__aligned
  * 76 ((section
  * 48 ((__section

As well as others like:
  * 218 ((unused
  * 14 ((__unused

But indeed, good catches! These ones I can do it directly here since I
am editing them anyway.

>
> With the above changes requested (or follow up patch added to the series):
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Also,
> Series looks great, trying to provide reviews one by one, just very
> busy today (and Monday off).

Thanks a lot!

Cheers,
Miguel
