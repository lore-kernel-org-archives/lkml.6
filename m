Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522208820; cv=none;
        d=google.com; s=arc-20160816;
        b=sA+vOFPAvA1V0M2yIfki00w52ryrkXN7NC64z0EJakuL4SDVIS/EwugH8/OfajrvBS
         U3Ua+DlyQC75FxnMWHxSgWnzAdMBA1QQt6ACxrHOGxWtkk9iVR61vUYnj/EGCbOBHdp8
         SE0LkexGRNFfOlU08I8H+39iMEJacyOaknDyTThy+CZG3qsejH6L3eEYYqMx9qfetSrQ
         oHjptIsaUH6C8AQi1UjdTtgrtAQThgjinjKMfGlHJpR01zbqplNFiYTfHIA2IWveK3MV
         7Vk/U1b4lyAUro8nFTpONtTIGA0dSGWePhJX0r2QMCy7ZjHuFKAvLYksz5FSrG8twIsy
         6JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=RtB6gPKZrdvEhAMNXViDt74UMgU4kdP8lBMrBgQwtMM=;
        b=H2EFTUBhRkNin+aXoGems8atrlRVDwcYmbnwcWXFwqJHnJ34RUzPsDBMwYlYgBTQ6v
         wTA3apWKLS+scXSULKi7W1vPW5wETo5KVEvigdz36Gc7YmTwc4402PdN6KDHPv7M7m6F
         3vIIrx2nkIuU8QCjwCwVlMR4MzxzarEb4i0tMCoGj4WV1kgHGMcYB2y1KkMzMCW1GXzI
         AerPmN6injuR7SBTy6A8loUMf3hKnJbIvmNCFRGF2ZYIiSBNxqi3HCQHecUh8/i+Ul1C
         4eKzTzDUGqoDK6s8iYA4w0opfpI81vioGziV/ivoX3jeSPdsQQ7hvBCmjXguF/7wcoRG
         ziVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=b819HHkC;
       dkim=pass header.i=@chromium.org header.s=google header.b=Sx++LcKl;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=b819HHkC;
       dkim=pass header.i=@chromium.org header.s=google header.b=Sx++LcKl;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49ymmwEZcWYr9dYx5Xe67Xf4tJwLTN79Va1S6M13ptvhJkZh3Ny34AZ90C6dkH19F1v1TAgGJga2KEByroN2w4=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-11-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-11-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:46:59 -0700
X-Google-Sender-Auth: -kBnscRl33FG4KiRmogqNSKQ_-w
Message-ID: <CAGXu5jLTSh5OHVBCCzZmafxueJH23ey2ELXD1Sn4HAc_DrHEMQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] kconfig: add 'success' and 'cc-option' macros
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537959344954?=
X-GMAIL-MSGID: =?utf-8?q?1596151635877932499?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 'cc-option' will be the most frequently used macro.  It evaluates to 'y'
> if the given argument is supported by the compiler, or 'n' otherwise.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>
> Changes in v2:
>   - Implement 'success' as a macro
>
>  init/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 0d6fe20..c456030 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -8,6 +8,12 @@ config DEFCONFIG_LIST
>         default ARCH_DEFCONFIG
>         default "arch/$ARCH/defconfig"
>
> +# expanded to y if the command exits with 0, n otherwise
> +macro success $(shell ($(1) && echo y) || echo n)
> +
> +# expanded to y if the given compiler flag is supported, n otherwise
> +macro cc-option $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)

This should be fine since most cc-option uses are quite simple. The
specialized per-arch and other-flag-dependency checks can just
continue to live in Makefile if we actually need them.

-Kees

-- 
Kees Cook
Pixel Security
