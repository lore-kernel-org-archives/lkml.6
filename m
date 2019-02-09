Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C23C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07CD21841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqGTxI6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBIAle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:41:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37377 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBIAle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:41:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so2475814plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6xWTl4mp4zbl4vVPfLCeQM8pvz2X7ElhN61xgasB7Lw=;
        b=RqGTxI6PMWQJJsNIKsWpniiTI4aLk2ERHjlUWLweE+vd3du/k6Rzz/9UZCG9ijGe6T
         qdhcJj4Vo6YIWy6zPHE9ooYPiA2AEw0E94/BMxSLHD6XkTom8mgutems8aR+iSocCXPh
         3KW5/SOT7T6zxWtdecilUZevW0JsBcy2PrC/pN4b7qN6LllIGX8+qmDHIaXDx7EBLwKN
         q5R8T3ZTCvXrDLXotuzH4f/n17fs9OyTN8lrMAKs+jq6tuEKhys2/X+W+UjB4NIeHETV
         YVDN5T61NYFX9nHEZu3H9kndo0YTeD2cXFVtcKdVudVx4veA6jB8RibzLCcX3/dBlV8c
         aGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6xWTl4mp4zbl4vVPfLCeQM8pvz2X7ElhN61xgasB7Lw=;
        b=tfH+L2wdZD672WEB5tcLlpFIItXL2YRIxDzt7gsu/4ljOCeV4Djvu2klL+guUOmFE5
         h7v1WNbl4DrzS9vCqDxJUJyQ+1ckClD39mb0jWy2lyhT0IKscKAoTkdV4zhYms++kHc0
         LU8gzZgv0HIdnO2ia4IyTUrbaAOd4/0EBfNmWW6c7w1EV05Wy/cPD0603r2w3foscuQ7
         JrsDqysMTQFXtMOc7VwU9MyWkp0Ob6S44UDRZJ4XEQdxEqvc/eJwAU0ErC2k3UsOl3wZ
         xjtfe1kAYmpbks4MCZLT59A5ql97iSd1Igay2AHo7hcAcUrdj+nRO87NR62K/RDPWfqo
         d1Xw==
X-Gm-Message-State: AHQUAuaQ3nVai5FDrVppbVCVZNsSsfUHqkX7RuKhDo0636mGDMP6xu8p
        dfzmpG4bvDl8gLJaSnS0mwlrUkxOfKXuas+juQZKkg==
X-Google-Smtp-Source: AHgI3Ib3a/80vW8Ct1WC3qNW86o0lKpPoPHoKx7+2DE8VuXZXYJlg3zw3z7u8dAoCUELo6dBu9P2Joq5wxqjH6FVAqQ=
X-Received: by 2002:a17:902:4464:: with SMTP id k91mr26032490pld.13.1549672893345;
 Fri, 08 Feb 2019 16:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com> <20190209000840.11018-3-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20190209000840.11018-3-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Feb 2019 16:41:44 -0800
Message-ID: <CAKwvOd=hhSY9msLQvwWRjuYuqR7VtW8+Pr9+y-10_khzbtQ8_g@mail.gmail.com>
Subject: Re: [PATCH 2/3] Compiler Attributes: add support for __copy (gcc >= 9)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 4:09 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> From the GCC manual:
>
>   copy
>   copy(function)
>
>     The copy attribute applies the set of attributes with which function
>     has been declared to the declaration of the function to which
>     the attribute is applied. The attribute is designed for libraries
>     that define aliases or function resolvers that are expected
>     to specify the same set of attributes as their targets. The copy
>     attribute can be used with functions, variables, or types. However,
>     the kind of symbol to which the attribute is applied (either
>     function or variable) must match the kind of symbol to which
>     the argument refers. The copy attribute copies only syntactic and
>     semantic attributes but not attributes that affect a symbol=E2=80=99s
>     linkage or visibility such as alias, visibility, or weak.
>     The deprecated attribute is also not copied.
>
>   https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html
>
> The upcoming GCC 9 release extends the -Wmissing-attributes warnings
> (enabled by -Wall) to C and aliases: it warns when particular function
> attributes are missing in the aliases but not in their target, e.g.:
>
>     void __cold f(void) {}
>     void __alias("f") g(void);
>
> diagnoses:
>
>     warning: 'g' specifies less restrictive attribute than
>     its target 'f': 'cold' [-Wmissing-attributes]
>
> Using __copy(f) we can copy the __cold attribute from f to g:
>
>     void __cold f(void) {}
>     void __copy(f) __alias("f") g(void);
>
> This attribute is most useful to deal with situations where an alias
> is declared but we don't know the exact attributes the target has.
>
> For instance, in the kernel, the widely used module_init/exit macros
> define the init/cleanup_module aliases, but those cannot be marked
> always as __init/__exit since they some modules do not have their
> functions marked as such.

Drop "they" from this sentence if there's a respin, otherwise looks helpful=
.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Suggested-by: Martin Sebor <msebor@gcc.gnu.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler_attributes.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler=
_attributes.h
> index 19f32b0c29af..6b318efd8a74 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -34,6 +34,7 @@
>  #ifndef __has_attribute
>  # define __has_attribute(x) __GCC4_has_attribute_##x
>  # define __GCC4_has_attribute___assume_aligned__      (__GNUC_MINOR__ >=
=3D 9)
> +# define __GCC4_has_attribute___copy__                0
>  # define __GCC4_has_attribute___designated_init__     0
>  # define __GCC4_has_attribute___externally_visible__  1
>  # define __GCC4_has_attribute___noclone__             1
> @@ -100,6 +101,19 @@
>   */
>  #define __attribute_const__             __attribute__((__const__))
>
> +/*
> + * Optional: only supported since gcc >=3D 9
> + * Optional: not supported by clang
> + * Optional: not supported by icc
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.=
html#index-copy-function-attribute
> + */
> +#if __has_attribute(__copy__)
> +# define __copy(symbol)                 __attribute__((__copy__(symbol))=
)
> +#else
> +# define __copy(symbol)
> +#endif
> +
>  /*
>   * Don't. Just don't. See commit 771c035372a0 ("deprecate the '__depreca=
ted'
>   * attribute warnings entirely and for good") for more information.
> --
> 2.17.1
>


--=20
Thanks,
~Nick Desaulniers
