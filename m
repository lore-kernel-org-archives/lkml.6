Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB64218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z64i2Vju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBKQV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:21:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38221 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBKQV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:21:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id 2so12801891qtb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WmCNf7rvKJSQnW9RFkoPMXwPQGmfM4LeYjbt0HhbnLI=;
        b=Z64i2VjumdUleeM2Cw+0TjR6drqFJrCOMpUQkhTZJiZF7gru7mOGdX2S3culi6CZ4f
         2ritUMLGoGRtaHD17s8jlWuWuvVOFQrz6OUWsqM+sYktaOLyD4oBKemFVUQ1BUfnEb5Q
         BXuLOf1spPBdcIjXXz3GSFcO3dVHELIJL+XXvyh/CjozYetDEjG/GuoSffRtaYzQ5vf3
         h9C9oLsh94EFWb6auZ5pBl+2ilbv2aX73UGjI2e9vnilJOw0kHiJOQ/ER+5kJAmSQGNM
         cGkz7CCU8vNc+Qd+GMf79jVgEib5SGTMvLSYdc8P1ZoM8/Za0f5ot0L8vzhtL819K5XZ
         xthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WmCNf7rvKJSQnW9RFkoPMXwPQGmfM4LeYjbt0HhbnLI=;
        b=GC6e10mZu5B4DUgUen3IhHBGLpqnBnOSbTflMw7uCmvjk3UDyNKuINbVmtVRl+wX8p
         Um0vGUHP2JVA9WksTbmJ1QXfTtIHtXdc8kOQ7zPWPKRZid6tcjjTh5AmAMWrWH4x9wmc
         claAcyDDi6OCRKjlDRqfxzxaWw+SEqWhkeC85O+jw4E8cttc6vGT82uZ7d4H6AjO79/U
         ZFQVm/7QPQyF5oW3swXFJ+SLvuJY8ex9N9WnwTmoxAXDLmZAV2KSpBL2LYqAYp3Xtfyf
         7yq/bazVNgEpdA6eji9BAq7F24RXeQnTQAEHdbJlj7x2IEeszpks6HshSKyoStV3aLvV
         EU4Q==
X-Gm-Message-State: AHQUAubKoogJrD7XEm+Jkh9S/4Pi2Os/EDFoNqXNQnVR+iQ0Y0Xs0cKe
        zD1Gu4ajhOTqqi03rndW3xA=
X-Google-Smtp-Source: AHgI3IY9ZU2eiItsMJ3CRuL3TLNOBqL/eABXTSM22AsbWKk/LgrL1UrjES4uHxk/t0M6xt/COwaoAA==
X-Received: by 2002:ac8:372b:: with SMTP id o40mr19617770qtb.73.1549902084690;
        Mon, 11 Feb 2019 08:21:24 -0800 (PST)
Received: from [192.168.0.106] (174-16-97-54.hlrn.qwest.net. [174.16.97.54])
        by smtp.gmail.com with ESMTPSA id v31sm8404667qtc.62.2019.02.11.08.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 08:21:23 -0800 (PST)
Subject: Re: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>, Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
 <CAKv+Gu83rXGH5hVdHXM=65zQkc5FtG86xMccT7WByUFy9BmXkQ@mail.gmail.com>
 <CANiq72nf2qyNxJ2Z9nypzqUC99-v5+WC_f3o98P-zoMqy+5sLw@mail.gmail.com>
 <CAKv+Gu9a=W6Fg+ai_W-HB1gL5oUg=FKcGdLk_15CdbHLWt6gMg@mail.gmail.com>
 <CANiq72kZouVeaJ=NnyYqedCvz9A0K_GHEwuGXkgBbg5R_NRJTw@mail.gmail.com>
From:   Martin Sebor <msebor@gmail.com>
Message-ID: <47895935-0619-fb4a-e74e-a8b029ba8504@gmail.com>
Date:   Mon, 11 Feb 2019 09:21:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CANiq72kZouVeaJ=NnyYqedCvz9A0K_GHEwuGXkgBbg5R_NRJTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/19 5:31 AM, Miguel Ojeda wrote:
> On Sat, Feb 9, 2019 at 12:26 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> On Sat, 9 Feb 2019 at 12:19, Miguel Ojeda
>> <miguel.ojeda.sandonis@gmail.com> wrote:
>>>
>>> It also affects the optimizer in two different ways AFAIK:
>>>
>>>    * For the function itself, it gets optimized for size instead of speed.
>>>    * For callers, the paths that lead to the calls are treated as unlikely.
>>>
>>
>> That seems reasonable, but that still does not mean it is necessarily
>> a problem if you apply 'cold' to one but not the other.
> 
> Indeed. As I said, it is likely that you missed the attribute, not a
> sure thing (i.e. that you didn't do it explicitly).
> 
>>> So GCC reports it because you would be (likely) missing the
>>> optimizations you expected if you are using the alias instead of the
>>> target.
>>>
>>
>> I see how that could be reasonable for extern declarations that do not
>> match the definition, since in that case, it is assumed that there is
>> only one instance of the function. For function pointers, I don't
>> think this assumption is valid.
> 
> It sounds reasonable to have another warning for
> declarations-definition attribute mismatches too. However, I don't see
> why you would warn differently. Even if you have one instance of the
> function, you may also be using the declaration to explicitly avoid
> the unlikely treatment.
> 
> Now, whether the warning is worth or not or at which "level", it
> depends. I guess the rationale behind having it under -Wall is that
> they expect people to have missed copying the attributes, rather than
> they are using aliases specifically to avoid a cold/... attribute.
> 
>>> In our case in patch 3, we do not want the optimization for callers,
>>> which is why we don't mark the extern declaration as __cold (see the
>>> commit message).
>>>
>>
>> You did not cc me on the whole set, so I don't have the patch. But in
>> any case, GCC 9 has not been released so we should still have time to
>> talk sense into the GCC guys.
> 
> I only CC'd people on the relevant patches according to
> get_maintainers (but yeah, 2 & 3 are related, I could have merged
> those lists). Anyway, using the lore.kernel.org server makes it easy
> to see an entire series when you have already one:
> 
>    https://lore.kernel.org/lkml/20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com/
> 
> As for GCC, Martin (the author of the features) is CC'd, so he can
> chime in (and I am sure he appreciates the feedback :-)

I do very much, thank you.  I think you've fielded all the GCC
questions here so I don't have much to add.  Just a comment regarding
aliases with different sets of attributes than their targets: it is
possible to come up with use cases not just with attribute cold but
others as well, including mutually exclusive pairs such as const and
pure.  But the uses cases that drove the design of the warning were
those where the set of attributes is meant to be the same, and we
are yet to to come across the others in practice.  If it turns out
that there are others in common use we can tweak the warning logic.

Regarding function pointers, attribute cold only applies to function
declarations (and labels) and is ignored on pointers, so calls to
a cold function through a pointer are not necessarily subject to
the same effects as direct calls to the cold function.  (This is
inconsistent with other attributes such as const and pure which can
be applied to function pointers, so I wouldn't recommend relying on
cold not changing to match the others.)

Martin

PS For reference, the built-ins that GCC implicitly declares cold
are __builtin_abort, __builtin_trap and __builtin_unreachable.
