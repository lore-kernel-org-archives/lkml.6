Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2279raQASPSaJTg76iFH6/MvxzapYS/tOkELEuDabcj8uLkQs3ixlGmArMA4cu3Dra59gZLy
ARC-Seal: i=1; a=rsa-sha256; t=1518111629; cv=none;
        d=google.com; s=arc-20160816;
        b=LOnx+NgET+J1Ye7xQvkDtM4vzISfkwVHHnChqIpVhUKYirGUyzu65JykFOBjekXI7g
         FfiO2MuhYBkCz1yBKEZFVXVdJ1AUkvkUZtDKZMKc1iHBONpfuOTwi0SM0n8Qp6nsi5+3
         Fr81xtFbZq9fcUNHCnPhPhUZSn3NAmKfgklzbd39LtSet9boVBFbXc1TWadvp6luRgIi
         pH6ncvTcd4u2Z9+LYty+71HifSV6WdDZokDaoBddfpOudTTqm/w3/l+0f3F2b4CJwcyU
         85wCm4XX+0L430tuUaQ/uUUWj/pB8hkYD2C4kLat3x5trtvdCyPV3q38qdaoyyM4zdI2
         rE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=Yc0aCgI+26UQeoElgzw2tLXbxYgiIJQfrl1vnkczKA8=;
        b=fwCXEfPS1Lq6doWKtNgUbQCtzQuljoi2M4zjUcrvO3shEp7w/N9I5aDPx2izk0EvgW
         KCj0CWraeyZj6EfZZ2aoY2Q/JRS4R/R/9TCSoc/GTSkIyAmrEwKqLWKrlBEzpxs3b2vE
         0HjvPQNfgY5Humu9VQTXe8hlFWbpPOxaGpFBWAE5rVmPSA5AsbdZGFuQH/ROJL6Rw97H
         jDXvBBzYmif6r1bi19gSBJ3h7d+6Ehr8Pf5tfeEdCiw6sOA5GCCohk53KwyHYjye5sz+
         MBxkvBJqIrQIwD/PIhVAxiRtO8j/Bi2YpGGWbaGzBycYFzfk5b5hugmfsyqYdtMmp3Xn
         AXoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=gCpwkxFy;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=gCpwkxFy;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w18HeBjY026420
X-Nifty-SrcIP: [209.85.213.44]
MIME-Version: 1.0
In-Reply-To: <CA+55aFxpxAGkCTvugOAXp+izb8O1C5YD+ExMQ27uYVU3-97P1A@mail.gmail.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com> <CA+55aFxpxAGkCTvugOAXp+izb8O1C5YD+ExMQ27uYVU3-97P1A@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 9 Feb 2018 02:39:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6K6B=SXKdEwhgY8sBvdTAE-=BxjSm2z31qLsG6XoehQ@mail.gmail.com>
Message-ID: <CAK7LNAT6K6B=SXKdEwhgY8sBvdTAE-=BxjSm2z31qLsG6XoehQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Kconfig: add new special property shell= to test
 compiler options in Kconfig
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368430758875?=
X-GMAIL-MSGID: =?utf-8?q?1591855419472262366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

2018-02-09 2:19 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Thu, Feb 8, 2018 at 8:19 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> This was prompted by the email from Linus today's morning.
>
> Thanks.
>
>> I implmented this in a rush today, so there are still many TODOs,
>> but I put it here to start discussion.
>>
>> I think it is working, but as you notice, it is tedious to repeat something
>> like follows:
>>
>> config CC_HAS_STACKPROTECTOR
>>         bool
>>         option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
>
> Yeah.
>
> I do think we want to have the "shell" thing as a generic escape for
> other things too, but *realistically*, the primary target for this is
> compiler flags, and I think we should target that specifically with a
> shorthand.
>
> Doing some statistics, and looking for
>
>     flag = $(call xyz ...)
>
> patterns in our makefiles (ignoring single uses), it really is
> cc-option that dominates:
>
>       2  name-fix
>       2  try-run
>       3  __cc-option
>       3  grep-libs
>       3  strip-libs
>       4  flags
>       4  get-executable
>       4  ld-option
>       4  logo-cfiles
>       5  as-option
>       5  cc-cross-prefix
>       6  cc-ldoption
>       6  cc-supports
>       7  cc-option-yn
>       7  tune
>       9  cc-ifversion
>      30  as-instr
>      48  cc-disable-warning
>     239  cc-option
>
> so I think that's the one that we want to special-case.
>
> If we then have a _usable_ - but perhaps not wonderful "shell" escape
> to do any random thing (including scripts etc), that will take care of
> the rest, but cc-option is so common that I think it's worth making a
> special Kconfig syntax for them. For all I know, the others aren't
> even worth Kconfig options at all.
>
>> I was thinking of something like follows:
>>
>> config CC_STACKPROTECTOR
>>           bool
>>           option shell="$(CC_OPTION -fstack-protector)"
>
> I think we should go even further, and just make it be
>
> config CC_STACKPROTECTOR
>           bool
>           option cc_option="-fstack-protector"
>
> and actually have the Kconfig language itself have this special-cased.
>
> And obviously that "option cc_option" would be *implemented* as just
> "option shell", with just some stupid string substitution. So it
> really would be purely a shorthand for readability.
>
> What do you think?


OK, I will try this way.



> And btw, the patches look nice. What I like in particular is that they
> don't even seem to add a lot of lines: the new shell option code is
> almost balanced out by the Kconfig script simplifications. And maybe
> it's just that I read C a lot better than I read GNU Makefile magic,
> but I think it's more understandable too.


I am glad you like it.  :)



-- 
Best Regards
Masahiro Yamada
