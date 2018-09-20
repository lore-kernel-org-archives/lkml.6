Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EB3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1792C2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A06jq5rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1792C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbeITXws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:52:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43376 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeITXwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:52:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id 38-v6so4715796plc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhBbcYIjWMAfcE0bX5sqVlG5FUKTWnKEZWytPAJUITw=;
        b=A06jq5rAZLo59KK26eml9lAgrX1M/6L9+SFxKcecxH+0xsqikiEzHPDfedA4XjXKYn
         4Cjo6W7pfCeEoZT5iTLaqzH2ZFC3X/RCJ6fT+oy9DLMugWJXOjbknG7YsHUe1pSlKkLO
         OJZjJ3a4RGJ6hCJfQnmnk8wCeAXxCO0Q6mrxrTvUS7uaNkATCkRRkLuJo0rU4B5kMdtt
         spQV/177YWr9vjSV3T1CGbh969r0hjUhPoXPlPDkY+x2NX6eA1aQ/ARR1eg1EonE/tXt
         WbNaEBz1GKtBJ/UVM8sJPmCW8nieuXT5iSoNzq/DrYHs+3M0KeuRbfkDMVhVFfVHr7if
         YTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhBbcYIjWMAfcE0bX5sqVlG5FUKTWnKEZWytPAJUITw=;
        b=tuYgUhF3jWFpEdWOI57/jtQ/yTEgBnjeg2JXxKrTmUAO6Wgvp42MLigiz+A6dlS3Rd
         Gj3oHXfB73iahQ12+LWqBRbZn+l2bMntaGK+5mxNQDP0n94UsZPYUnrXbQEE36tlAWlK
         zCB22ifog3wsrUoCTyErwdroGlOdnVIlZBXxQC2zd9MXyX36opWlP7ApovKLNkqwylBD
         NxNBty10JgOlJeQYyX5ysYCBLPV15E1YbG/obRCCOD2Eponfxr2D5KCag74lam3/FXRj
         N35lta7VDz9VAnLS+R0HyABQpIbPlVG31YsKmCXG3uXJD1JxlkDRtXEbzp01YA+dfzjs
         B5xA==
X-Gm-Message-State: APzg51AWgxuaNcp8Jpcxh4b8kgXDQbFMj8B09SA1yRMeNNE1aAKnZZKc
        mFn2/Cn+aVZ81BCDsYP00csX6JA+1gZMBNkrOqPtnw==
X-Google-Smtp-Source: ANB0VdaznTZy34HFm3rogaG8/cuxr2bVQ1QNYze5s6OL0TMb0Tfon2hhN5If2mES5Ue7ReCCj8Izo30zi19Uite0z6o=
X-Received: by 2002:a17:902:708a:: with SMTP id z10-v6mr41107122plk.229.1537466884304;
 Thu, 20 Sep 2018 11:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com> <20180920172301.21868-13-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-13-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Sep 2018 11:07:53 -0700
Message-ID: <CAKwvOd=0GZi5M3ZRxps+Y1Cvbk=h-VOMM4+cBzHx2-LGO1cLSg@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] Compiler Attributes: add support for __nonstring
 (gcc >= 8)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, adilger.kernel@dilger.ca,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org,
        mchehab+samsung@kernel.org, olof@lxom.net,
        konstantin@linuxfoundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        sandipan@linux.vnet.ibm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        paul.burton@mips.com, David Rientjes <rientjes@google.com>,
        w@1wt.eu, msebor@gmail.com, sparse@chrisli.org,
        Jonathan Corbet <corbet@lwn.net>, tytso@mit.edu,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>, asmadeus@codewreck.org,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:23 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> From the GCC manual:
>
>   nonstring
>
>     The nonstring variable attribute specifies that an object or member
>     declaration with type array of char, signed char, or unsigned char,
>     or pointer to such a type is intended to store character arrays that
>     do not necessarily contain a terminating NUL. This is useful in detecting
>     uses of such arrays or pointers with functions that expect NUL-terminated
>     strings, and to avoid warnings when such an array or pointer is used as
>     an argument to a bounded string manipulation function such as strncpy.
>
>   https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
>
> This attribute can be used for documentation purposes (i.e. replacing
> comments), but it is most helpful when the following warnings are enabled:
>
>   -Wstringop-overflow
>
>     Warn for calls to string manipulation functions such as memcpy and
>     strcpy that are determined to overflow the destination buffer.
>
>     [...]
>
>   -Wstringop-truncation
>
>     Warn for calls to bounded string manipulation functions such as
>     strncat, strncpy, and stpncpy that may either truncate the copied
>     string or leave the destination unchanged.
>
>     [...]
>
>     In situations where a character array is intended to store a sequence
>     of bytes with no terminating NUL such an array may be annotated with
>     attribute nonstring to avoid this warning. Such arrays, however,
>     are not suitable arguments to functions that expect NUL-terminated
>     strings. To help detect accidental misuses of such arrays GCC issues
>     warnings unless it can prove that the use is safe.
>
>   https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler_attributes.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index f0f9fc398440..6b28c1b7310c 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -34,6 +34,7 @@
>  # define __GCC4_has_attribute___externally_visible__  1
>  # define __GCC4_has_attribute___noclone__             1
>  # define __GCC4_has_attribute___optimize__            1
> +# define __GCC4_has_attribute___nonstring__           0
>  # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
>  #endif
>
> @@ -181,6 +182,19 @@
>   */
>  #define   noinline                      __attribute__((__noinline__))
>
> +/*
> + * Optional: only supported since gcc >= 8
> + * Optional: not supported by clang
> + * Optional: not supported by icc
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-nonstring-variable-attribute
> + */
> +#if __has_attribute(__nonstring__)
> +# define __nonstring                    __attribute__((__nonstring__))
> +#else
> +# define __nonstring
> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noreturn-function-attribute
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#noreturn
> --
> 2.17.1
>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
