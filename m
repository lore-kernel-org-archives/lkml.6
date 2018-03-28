Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522238130; cv=none;
        d=google.com; s=arc-20160816;
        b=q06c640pfmnVUvMGzXSvrcYPUlaumzqVVFcKGtrqbYY50i0bboCwJji/XeQz8mt/lw
         3GlVq5ZFfKaY2iMABNptrpYhyJ0yktcwBf3wtx1zjrCNM+2XKEK8DLdkND8oXis/H9rq
         iTVxzN3dGVu59wZ1/0UIklAS8CK16VBI7QeJqrS7RJ4H1oQhdhmQO9R/0RG9Irp9mEtY
         lAOQuQWqh1Pkjyt0YCJpDEsLbpYMlpD1PTgR9I6ePXX2AO1evHTua8Vf/R7giDy9KJ5j
         kdRElnLlJVB5BpJZPYj3nwshROFgxJCG6BfcyKv3E6tEKstCGvWNIjtJ1EYRJ25cc+A+
         M5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=GJW2VHEs9UQJMdLtnJHspJ41w62j85LwRqRQbUZ7dw0=;
        b=Vws2+n/rUwy2h4qc5ZLHGlAR/RV8ikmWFVD8DiTsu9gInPH7ENSNiFuQsTbL2EGwRs
         RdF7jNf5gHdCoamBXDLDvqzZEd358mS/yY5mKkbBrTnIDoCytqye2/RhbhH4iJ+fobsi
         Mh6ZG+HRS9uGr/BQ+eqXS4rUTa0fe7wV1X6mPBOcBA1CCeY1JPay9EJANCVV4IY6mnQE
         wvQW5QC7z1HCsVj8Q09ZWyzhJxMdp2QnhE92NifZOpF82MaZlTnMlnxfPvzhQ9bJoutC
         HE+QQLx6KFr4/kiTM83lzfoisFbibp+IsS62W4KwEVsFL/Uu+y4yHhUlnw3M9R3DFmId
         y1NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=GEdrjVWJ;
       dkim=pass header.i=@chromium.org header.s=google header.b=Nctqf5HT;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=GEdrjVWJ;
       dkim=pass header.i=@chromium.org header.s=google header.b=Nctqf5HT;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+AJ76fr8MwJpvbh1+kom2Yd5N5nyLqXB52awvg4Q/wbOSa2xRIT7bt1QqQFGrhe3DD43M9WGOTMPKBBvVuZNU=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-22-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 04:55:29 -0700
X-Google-Sender-Auth: BmhAWYWzRsQLUThgzvJLbyHgG5o
Message-ID: <CAGXu5jJUp6GaDtEKwg7_nOoyDEumZx0MTeW4cr_NFSbNxxa06Q@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] arm64: move GCC version check for
 ARCH_SUPPORTS_INT128 to Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067581246942212?=
X-GMAIL-MSGID: =?utf-8?q?1596182369813697753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This becomes much neater in Kconfig.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Is there a reason this doesn't have a cc-option test, or was this a
silent addition to the compiler? (And as such, should there be a
comment for this in the Kconfig?)

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
