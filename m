Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728AEC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DBA2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qh0/rviA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DBA2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeIAQYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:24:10 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37361 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeIAQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:24:10 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so17409717qtl.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sMr3dAP+bUmWzlY9z8YGxCFK8ma18tf1A6rP6051FgU=;
        b=qh0/rviApsYIFuZigGI8KmW801ttK6MI5foNZCZ7A3dRpporwplZez7fxw0zn4r/aE
         r2foeHjYUIEFlTo3wiiAeQSUsUjADMTpg7OP6wWrXalVSenAw9CaOFwIuLpDgUWJ1h6C
         OjAnTmpT+g+3z4xbGvm+DuGtBvVB4fJAzCztIMR1VXyVtboF8EXu5T4auQY1XushhzNp
         4EB9+OuqQvZElZy8JQCHeguYFR0eJT7JgKTsyPnIhSlOv98phjbcGxb2uQxc/18iWfPi
         RGWZ4S8+9WBmFPyiXuoob+bW+oE6gF1rEGdWyVrTfPOps5l3juSNdy8kAe9Dvvz/Tgik
         BEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sMr3dAP+bUmWzlY9z8YGxCFK8ma18tf1A6rP6051FgU=;
        b=tTsm6eRNtzi0dH56OH2k/vBHzMs2VDrcgYFnrLx9Pih3pzr4iGOIOAwJlbEo0p/40J
         o9O7gjwX2qlSIgxLNaVwFmg8UUqETlrIIK8ezOd3VPEJX3nQXJyJ4Gd6Mcdwy3iuhslz
         unn3CUpGkJ3iiP7WiDUBFS8sya9QDvhnHPM93OqnuUV+8JBOZnlrQPmV0RgaAYxzCVh4
         vPTvXw+D7xXo4O4hLmIGegj1X9li5D3N//5tarrt0jRw0nFLOFdTX3KMkEuWY2GVG+I0
         lJXlh0KTlsAMsDnJviFkYyBHMopCPwjLkJWQWxjiWDbZGoUTkiMskJxkNKuB9Ff95ZIz
         NeTA==
X-Gm-Message-State: APzg51DhgbQ4buBhUmKBIP9OssrDfIL+cO/nlSjx+BbJU98odtDbHk/e
        A7LwnBEip42vnECZsEH5xSEUjNE6uug1qkBsgos=
X-Google-Smtp-Source: ANB0VdZSseOl4S+DSPQM22bE8T4vshlZyXfrvNsdBZOoJtSH8Jp+ou8F4suKQgWBhVUyb25mxwEmmVRIOCZX4KEzi88=
X-Received: by 2002:ac8:4304:: with SMTP id z4-v6mr19022501qtm.295.1535803939607;
 Sat, 01 Sep 2018 05:12:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 05:11:59 -0700 (PDT)
In-Reply-To: <20180901091738.73dzegdenvla5crf@ltop.local>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-4-miguel.ojeda.sandonis@gmail.com> <20180901091738.73dzegdenvla5crf@ltop.local>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Sep 2018 14:11:59 +0200
Message-ID: <CANiq72mErSGjR4aLRQdKfUEWX8rDsnaqkb4Cse8gjxs-5PzBdw@mail.gmail.com>
Subject: Re: [PATCH 4/7] Compiler Attributes: homogenize __must_be_array
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Sat, Sep 1, 2018 at 11:17 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Fri, Aug 31, 2018 at 07:05:11PM +0200, Miguel Ojeda wrote:
>> Different definitions of __must_be_array:
>>
>>   * gcc: disabled for __CHECKER__
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index e0e55eb3f242..e4a702f99e50 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -357,4 +357,11 @@ static inline void *offset_to_ptr(const int *off)
>>       compiletime_assert(__native_word(t),                            \
>>               "Need native word sized stores/loads for atomicity.")
>>
>> +#ifdef __CHECKER__
>> +#define __must_be_array(a)   0
>> +#else
>> +/* &a[0] degrades to a pointer: a different type from an array */
>> +#define __must_be_array(a)   BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>> +#endif
>> +
>>  #endif /* __LINUX_COMPILER_H */
>
> You can also remove the #ifdef __CHECKER__ because:
> 1) even ancient version of sparse don't have a problem
> 2) BUILD_BUG_ON_ZERO() is currently disabled for __CHECKER__
>

Nice catch! Will do.

Cheers,
Miguel
