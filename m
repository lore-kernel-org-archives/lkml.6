Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225/pVp/YY/qrkIEH9nN+ufVHpgOoW09f+gvwSJYdkiDuXpJXyjx50+hk5p57likleQ2Yz30
ARC-Seal: i=1; a=rsa-sha256; t=1517587323; cv=none;
        d=google.com; s=arc-20160816;
        b=ITFQioCRFxm5nnTZmxbMLk9Om4NGaE7q1GU+sY3O2wYFQlf1sL2bIlii1DBwNXOIwB
         APlBxxPPlbJDV1l8NEHcohiGjCOymYxwbMxfBP5nlw5l280EyHpdO/gqyeAk07GewgNb
         +5fLj7AbNI9jGORjDpPHARJRZ+trhR6+DFiyiNXOdFS+Q9jGUrIlr4KDVD/5xaqD5QUf
         v6aWEc1W+lEwwZlIRDcSO2X1A3R08CnCj9qfcKg3NE5GAm6mxC34opFHSqbO8Vi7rP7O
         pv+6Pyn5Uf0g1svbnOttAFqc9fQajXEHi/gncYRUDnfZalZvXZEcwj/wFtCnp8PjWGFD
         rjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=OAh46fA3mfN3c5X54vn6Xq4CKX7QdhfBzvJ/5HdT7RU=;
        b=TJMUN0DRacw3hm0VZDXpo6NZNntEe930z28w37KbJ7xfgQmKnUv+Tu/kqD6BDkJNSC
         Woam/J99CXfkWZDfEcP1dwWVKgy+KATFzgugSauEkRNEk12c/+D5nRW68AxfxGyqPfS8
         1z7bBnPeKnw+FzRw/dAqgN2c9E17SvQKclnx/D5GPpzRE9vZsMbhPtq50y33wTcAjOdH
         DVdS7C+iGz9zsxLv9zQwl6NxPMrDvTPuncbrgGr2l1avwuY8HT87BTlfxfOVw/2Uoj+l
         NVuWq/WV4NWAVDWTXcUkPNwcunUivN/xJIaijZhyMuo9iaus+AZ4p2ni0IedhRAyeYl2
         x7cw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=oMNrEypR;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=oMNrEypR;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w12G1fKn032318
X-Nifty-SrcIP: [209.85.213.43]
MIME-Version: 1.0
In-Reply-To: <1517245680-3361-1-git-send-email-psodagud@codeaurora.org>
References: <fd6fdda6c0080e72598eabd2c88d7df6@codeaurora.org> <1517245680-3361-1-git-send-email-psodagud@codeaurora.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 3 Feb 2018 01:01:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ1d5t5-UHsF1ZJ9tNLpGgbMGnDoHdht9=wNy5kLDVyxw@mail.gmail.com>
Message-ID: <CAK7LNAQ1d5t5-UHsF1ZJ9tNLpGgbMGnDoHdht9=wNy5kLDVyxw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: clang: Disable -Wunused-const-variable warnings
To: Prasad Sodagudi <psodagud@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        segher@kernel.crashing.org, Greg Hackmann <ghackmann@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590705328423377998?=
X-GMAIL-MSGID: =?utf-8?q?1591305644825380733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-01-30 2:08 GMT+09:00 Prasad Sodagudi <psodagud@codeaurora.org>:
> Currently -Wunused-variable warnings are disabled with
> clang and with gcc -Wunused-variable warnings are
> enabled, with this setting all unused local variables
> would be warned in clang as well.
>
> Disable -Wunused-const-variable warnings instead of
> disabling -Wunused-variable warnings, So that in both
> clang and GCC -Wunused-const-variable gets disabled.
>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>

The code is OK, but I'd like to make the log even clearer.


The commit subject
"kbuild: clang: Disable -Wunused-const-variable warnings"
sounds confusing.

-Wunused-const-variable was already disabled for clang
because it was implied by Wno-unused-variable.


So, this patch is effectively enabling -Wunused-variable, right?


How about something like follows?

------------------------->8---------------------------------------
kbuild: clang: disable unused variable warnings only when constant

Currently, GCC disables -Wunused-const-variable, but not
-Wunused-variable, so warns unused variables if they are
non-constant.

While, Clang does not warn unused variables at all regardless of
the const qualifier because -Wno-unused-const-variable is implied
by the stronger option -Wno-unused-variable.

Disable -Wunused-const-variable instead of -Wunused-variable so that
GCC and Clang work in the same way.
--------------------------->8--------------------------------------


If it is tedious to resend, shall I reword the log locally?
Let me your thought.







> ---
>  Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 339397b..4b6c8e2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -698,7 +698,6 @@ KBUILD_CFLAGS += $(stackp-flag)
>
>  ifeq ($(cc-name),clang)
>  KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
>  KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> @@ -716,9 +715,9 @@ else
>  # These warnings generated too much noise in a regular build.
>  # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>  endif
>
> +KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS  += -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  else
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
>



-- 
Best Regards
Masahiro Yamada
