Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522235984; cv=none;
        d=google.com; s=arc-20160816;
        b=QJ482olDSfJ5lAiC/1dN1pa8HQ2OQbrzyUawVXAP94e8+CD1iEeTVPo19MJPjyp4OF
         aVzZjnqsyAHor/0mQRekDjh20l4o55z4+FsataOu0SLtpuqc4TvAyAKGjQxMNnI5SUeB
         nrdv3A5E023Zt6JbOpezMl1FygM/nLLHWAoZmBqpoJQqSflXSiEMjX6294DarleAfzru
         osIT52Aq6jk/u9aYRvBh6Dokht6KUGc085a2ZX5F3Lad7+5WeIYZPPPVZ/9a4VZlJTDI
         48VMI2X+mFJ65n9J1pwOKuDP1xODZ2dcdWSH5/wEuPih4b7q96itf65l92gwolvyB9wK
         Ivuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=u1pfetNgdy4mhj/7KjRU2aaYhzIRrWjsj+8XMYRaRT4=;
        b=LZQBBtDryHHpAXYzTmgpW3efW1EqPB1mvZkmuPNb+wDPv1dT6t71e/W+wd7NMp0sIq
         ukbzfeJQXiZir0xJ+RPZtCukKGFn1XwUNQHEIbyyWOH4UNUNGp/iyW4VcIYvnWZi6fm0
         tRpVOsqzKVbcHgyi6y8yTC8OL7Cefvc+BG2moZpaYL02BJwbrg03biCJv5YqyPIdAlV5
         zRMtllQ2DAIUj0Ee/twFRKJQ0RAzC2f+quln3LuUw7+L+izosV1whCZCAH0eavjdbSw6
         V2JWLean+66x0bSeKu8v71J1YFzhvWxGpJ5ND6ksfQgKyAz42CGUTzAUWY9x1tYYT20K
         zX3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Grb9DyoS;
       dkim=pass header.i=@chromium.org header.s=google header.b=fIz+ltyq;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Grb9DyoS;
       dkim=pass header.i=@chromium.org header.s=google header.b=fIz+ltyq;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/Kf1UHhL7x0dlAc5WAGmzVyWwcwxC6v/buPm80SLw1k00H/hIkYVRHVrS7QkYvLALI5zzDTZ9ZOK4Jro2GiV8=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-14-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-14-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:19:43 -0700
X-Google-Sender-Auth: FRsRJRfGvguVZTplyF_CQgXwElw
Message-ID: <CAGXu5jJp7ZF436QrXBgFzHJKQv-MTiCmsq8fBn12avs1-Fqbkw@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] kconfig: add CC_IS_GCC and GCC_VERSION
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545516785753?=
X-GMAIL-MSGID: =?utf-8?q?1596180119264634583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This will be useful to specify the required compiler version,
> like this:
>
> config FOO
>         bool "Use Foo"
>         depends on GCC_VERSION >= 408000
>         help
>           This feature requires GCC 4.8 or newer.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
