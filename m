Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89198C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBBA217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="V0pIXRfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeLWWB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:01:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41439 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeLWWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 17:01:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so2142201edc.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 14:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kLl/eFnlXQ43zaYa8lyBXmlyuNJOKF0LsdnpVSqWcbk=;
        b=V0pIXRfhNnCDox5Cgj28XBRHs3Uij+PizCbBfyilG72IgjU2qVlQESkb4UwUt4ZZGK
         qzQg86NKK62z1urHI6tIh19EiNkvLqbJDlTiVCa6+sR+Aq/wuCQHx4sZF4dTp6mpWO8/
         z/zvN4mgZApvLRkxearNz3x2qwxPlthHs3OYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kLl/eFnlXQ43zaYa8lyBXmlyuNJOKF0LsdnpVSqWcbk=;
        b=e8vlfJlLK0XMAFl0+MMNLLc2bHk7+FxGlN4WodKwxhDniNckfn9FsR7Y9T891zeZY5
         75HRhHjy6cRoyYanzCT3YaQnzj78MxLfwoQlbY3bDbdsZUta9mMc/fxW4MO01McNC9ur
         bGcY6mqJ7NSV3zs0sXN9VpNE5SeN0us//cUrb8nXcH9gwQaxWrScSRz6EheH9Q6zF75S
         JixHoAqezJOgrFv5qkrHDFCcbdMPEatQ1akQUPadC08ZPwiNrfOgLs4Sew2pQm2IkMeB
         ceHqdD/dDJy96nafUOgOWi7rbfSOLEs5kA+M9AztNYwsV0pYEyssnyqEaipjHyWmTcHP
         iGyA==
X-Gm-Message-State: AA+aEWauK5AqRPWWWqnTykMIFki+fq61OQ3x3Qd6Z2Fn3kGI/lvQGu3V
        5+pLYq2qBzm/CnQFaafLM27hwg==
X-Google-Smtp-Source: AFSGD/V8eNSHMplqb3Qol4bgdP2DXHUXO2DHyf6XK/VerDRiV/zUSn8G1DLk6uIJLKPzkJxMrYjmuQ==
X-Received: by 2002:a17:906:914:: with SMTP id i20-v6mr7343950ejd.225.1545602514929;
        Sun, 23 Dec 2018 14:01:54 -0800 (PST)
Received: from [192.168.0.189] (ip-5-186-119-68.cgn.fibianet.dk. [5.186.119.68])
        by smtp.gmail.com with ESMTPSA id x10sm8744539edb.58.2018.12.23.14.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 14:01:54 -0800 (PST)
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
To:     Joe Perches <joe@perches.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <098d7abf-5b62-6a01-a370-97d96bece299@rasmusvillemoes.dk>
Date:   Sun, 23 Dec 2018 23:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <84199633fd49db573c9ba71f1992936422e907d4.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2018 23.20, Joe Perches wrote:
> On Fri, 2018-12-21 at 16:08 -0500, Steven Rostedt wrote:
>> On Fri, 21 Dec 2018 21:58:32 +0100
>> Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>>
>>>> Well, perhaps I can just remove the ending ones. I get paranoid with
>>>> macro variables, and tend to over do it so that there's no question.  
>>>
>>> Why not make it an inline function?
>>
>> Matters if that removes the strlen(const) optimization. I could try it
>> and see what happens.
> 
> Using
> 
> static inline bool str_has_prefix(const char *str, const char prefix[])
> {
> 	return !strncmp(str, prefix, strlen(prefix));
> }
> 

We already have exactly that function, it's called strstarts().

commit 66f92cf9d415e96a5bdd6c64de8dd8418595d2fc
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Tue Mar 31 13:05:36 2009 -0600

    strstarts: helper function for !strncmp(str, prefix, strlen(prefix))

Please don't add a copy under another name.

As for converting existing users, go for it. FWIW, I ran a cocci script
a few years ago to find suspicious strncmp() cases, and there were some
(e87c3f, ca957b6), but fewer than I expected. There are some
confused/confusing ones that apparently deliberately do strncmp(a, b,
sizeof(b)) instead of the equivalent to strcmp(a, b) (e.g. 'strncmp(str,
"hwc", 4) == 0')

Rasmus
