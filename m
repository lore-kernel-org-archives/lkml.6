Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E90C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DA82089F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="s/IeIS+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DA82089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeHYVwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 17:52:24 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:43835 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHYVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 17:52:24 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w7PICJ1N005521;
        Sun, 26 Aug 2018 03:12:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w7PICJ1N005521
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535220740;
        bh=hPNncrKMMUJXxQijnVB+vE1EpNTe4lpWroTOfNX9Do4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=s/IeIS+N+nTL46FqrwBPNx6Ov2vvbnamFxwy81rGuyKk7JxPrqpDZOoFiO4+vc5Hk
         S1neJI9tqBwLkeZMHAJyx+HEswxGHGUNHk4PdyPUEeDxnSSuEAqYpJ9LxSdtISO0i0
         Sx6aBnSj1G57fk9Oo6ZpoQBPfcsEUn3O9FlWss4yW+bXSh5iJvKhbp7Mge7RIl6C4D
         3OI2AcNL79ie/OM3rvI0mVWyJOtEBrraoNMuHhYkoCkfX/ShQbp3huqvKPMSoMvV1f
         Mr+8dSj9oGdiavVCQ95gHUvrfFs64TpIpxJgaIA1YZjmM8Mz3Bj1aCJkkCg0xqDh19
         PHgpO+WTePWIg==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id g18-v6so7270441uam.6;
        Sat, 25 Aug 2018 11:12:20 -0700 (PDT)
X-Gm-Message-State: APzg51CHkGx0SMcybj/lTunCXxQPdfV6Z3mGRmOMet9P4VCEH2H/0RaJ
        /VxWc6qJxpzfRhNvNP2kiSR9CTGWOv/EQ4XzzKM=
X-Google-Smtp-Source: ANB0VdabvPXthE1qEgQY5AGg6Y249FohVYsj8K0i6KUmzuvbzNQbdT+HFPGEZzZaBoKc9NYThrXTPNy3kOTa/AnQlmM=
X-Received: by 2002:ab0:30ea:: with SMTP id d10-v6mr4259387uam.58.1535220739302;
 Sat, 25 Aug 2018 11:12:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Sat, 25 Aug 2018 11:11:38
 -0700 (PDT)
In-Reply-To: <6b25ce92-7ffa-9fdb-c114-e7aa8f987b06@pobox.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com> <6b25ce92-7ffa-9fdb-c114-e7aa8f987b06@pobox.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 26 Aug 2018 03:11:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-i0T7sZBg5baFTXEwekbhWVLDSfOKCmHmNX-gHd5JHA@mail.gmail.com>
Message-ID: <CAK7LNAQ-i0T7sZBg5baFTXEwekbhWVLDSfOKCmHmNX-gHd5JHA@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
To:     Daniel Santos <daniel.santos@pobox.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Joe Stringer <joe@ovn.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        George Burgess <gbiv@google.com>,
        James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,


2018-08-21 17:11 GMT+09:00 Daniel Santos <daniel.santos@pobox.com>:
> On 08/19/2018 03:25 PM, Nick Desaulniers wrote:
>> + gbiv who wrote this cool paste (showing alternatives to
>> _Static_assert, which is supported by both compilers in -std=gnu89,
>> but not until gcc 4.6): https://godbolt.org/g/DuLsxu
>>
>> I can't help but think that BUILD_BUG_ON_MSG should use
>> _Static_assert, then have fallbacks for gcc < 4.6.
>
> Unfortunately _Static_assert is a woefully inadequate replacement
> because it requires a C constant expression.  Example:
>
>     int a = 1;
>     _Static_assert(a == 1, "a != 1");
>
> results in "error: expression in static assertion is not constant."


You are right.




I tried diagnose_if from Clang:

static inline void assert_d(int i) __attribute__((diagnose_if(!i, "oh
no", "error")))
{
}



Clang is silent about

       int a = 1;
       assert_d(a);




But,

       if (0)
              assert_d(0);


is error.

Hence, it cannot be used for BUILD_BUG().







Anyway, I will just try to rebase this patch and send it to Linus.



> Language standards tend to shy away from defining implementation details
> like optimizations, but we need to have completed a good data flow
> analysis and constant propagation in order to do BUILD_BUG_ON_MSG, et.
> al.; this is why they only work when optimizations are enabled.  As the
> optimizer improves, new expressions can be used with BUILD_BUG_ON*.  I
> did an analysis of this back in 2012 of how various types of variables
> could be resolved to constants at compile-time and how that evolved from
> gcc 3.4 to 4.7:
>
> https://drive.google.com/open?id=1cQRAAOzjFy6Aw7CDc4QauHvd_spVkd5a
>
> This changed again when -findirect-inline was added -- i.e.,
> BUILD_BUG_ON could be used on parameters of inline functions even when
> called by pointer, although the caller needed __flatten in some cases --
> a bit messy.
>
> Daniel



-- 
Best Regards
Masahiro Yamada
