Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA02A217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 23:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TaFMD1vW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbeLWXwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 18:52:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35831 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeLWXwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 18:52:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so9046742edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i9YIMAFeh7qv+am2vg/TEw3E+8x98DBXojDGkNaNmCs=;
        b=TaFMD1vWecALSjayVF/bSQYdYUYmsDQlLlE7JWZYJMJxvhs3zMkXStKTtDhvo6CXZ2
         ojRYCjblHOnTFtITBqEbB9LrK2j3ZBAhlt5DBco1Gm4fFBCXb79FW+K39LlU7tGbhSrT
         MI3/h2CKmwyzOJtNghkeFkSwt9MzxLtRXRCdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i9YIMAFeh7qv+am2vg/TEw3E+8x98DBXojDGkNaNmCs=;
        b=R1jkFfNIVn7OftrUWdy9lnG7m3O9VMGuk0p578b8SyVrmylXkZzO17vehktYwTG3Ny
         63c/PPZEQVlvgbJGdW2RM+92gesAAE8FYdcu0PmY0A5lv9M0qSf6j2YRQsB1PyXInBQN
         0T1t+ddIRJv1HGwc+3hKQXUbdEXSp4xTjR9x0H6Ypj7e/wPyvYD3obovUHObVnAz798K
         lLLi+CsG0KRQEe6BwbCqErHJj64J00p6NcD+U8Vkw5GkvgexKfWSyMk4D37GLB2i/HT/
         bLEZL1RjfwOENqLyHtQmVhSXhEwvfgfVA8lnpHa/hiow4JT9vhH7BUZ6OtX+UxqJwj8R
         8n6w==
X-Gm-Message-State: AA+aEWb8QUZZhLb0Rhj2GOm73c12IbldlehiGrhpcSI0V3D2Msn32S9M
        cgWueq0EEqkFsQ/voA0bSc+Nog==
X-Google-Smtp-Source: AFSGD/V4c1eecV0r1pkgP19O5WtY2m270cF/Qgfg/8JPZoNVVpXzJGubJMpvaX0ljwOGqEoyBMa3Kg==
X-Received: by 2002:a50:8863:: with SMTP id c32mr8555922edc.156.1545609135678;
        Sun, 23 Dec 2018 15:52:15 -0800 (PST)
Received: from [192.168.0.189] (ip-5-186-119-68.cgn.fibianet.dk. [5.186.119.68])
        by smtp.gmail.com with ESMTPSA id t24sm8664472edb.7.2018.12.23.15.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 15:52:15 -0800 (PST)
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Joe Perches <joe@perches.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181221175618.968519903@goodmis.org>
 <20181221175659.208858193@goodmis.org>
 <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
 <20181221144054.20bdeb33@gandalf.local.home>
 <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
 <20181221153526.5e6055ca@gandalf.local.home>
 <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
 <20181221155435.38a9a221@gandalf.local.home> <871s6ad2br.fsf@igel.home>
 <20181221160826.34c544e6@gandalf.local.home>
 <84199633fd49db573c9ba71f1992936422e907d4.camel@perches.com>
 <098d7abf-5b62-6a01-a370-97d96bece299@rasmusvillemoes.dk>
 <20181223175621.4e4d958c@vmware.local.home>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4daf3688-ea36-627a-cd8a-8f9bc6cabc56@rasmusvillemoes.dk>
Date:   Mon, 24 Dec 2018 00:52:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181223175621.4e4d958c@vmware.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2018 23.56, Steven Rostedt wrote:
> On Sun, 23 Dec 2018 23:01:52 +0100
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> On 21/12/2018 23.20, Joe Perches wrote:
>>>
>>> Using
>>>
>>> static inline bool str_has_prefix(const char *str, const char prefix[])
>>> {
>>> 	return !strncmp(str, prefix, strlen(prefix));
>>> }
>>>   
>>
>> We already have exactly that function, it's called strstarts().
> 
> It's not exact.

Huh? The str_has_prefix() I quoted is exactly strstarts().

> 
> Well, one thing that str_has_prefix() does that strstarts() does not,
> is to return the prefix length which gets rid of the duplication.

I hadn't seen the patches containing that version of str_has_prefix().
Anyway, I just wanted to point out that strstarts() exists, so that we
at least do not add a copy of that.

> Would it be OK to convert strstarts() to return the length of prefix?

Dunno. By far, most users of the strncmp() idiom only seem to be
interested in the boolean result. It's true that there are some that
then want to skip the prefix and do further parsing, and I can see how
avoiding duplicating the prefix length is useful. But the mathematician
in me can't help consider the corner case of 'the empty string is always
a prefix of any other string', and having str_has_prefix(str, "") be
false seems wrong - obviously, nobody would ever use a literal "" there,
but nothing in str_has_prefix() _requires_ the prefix to be a constant.

Maybe 'bool str_skip_prefix(const char *s, const char *p, const char
**out)' where *out is set to s+len on success, and set to s on failure
(just to allow passing &s and continue parsing in elseifs)? That would
make your 4/5 "tracing: Have the historgram use the result of
str_has_prefix() for len of prefix" do

  if (str_skip_prefix(str, "onmatch(", &action_str)) {

hoisting the action_str declaration to the top, replacing the len variable?

Rasmus
