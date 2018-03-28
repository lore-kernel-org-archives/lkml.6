Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522207572; cv=none;
        d=google.com; s=arc-20160816;
        b=bzm8+6MohkXQIZzbVp45eFTL1FwX7Kcg0k6NtIQf151WxVzOnf9RJrjvJgA9se/z6t
         glM/9d14RK1u6tln93/SfDDmTcWtbH3bhlTCsHJZ3noA2axSXKL5C2DueFfMPce1WUan
         TyZcWvmGOlQhw72li4WtNlm1kXjqei+8bWufrRJ1tOEW63SEl0gUxx7pQQestLpEehLr
         WNcBNRoEqsbWNhY0ummM18C0G0FlWspuQZ3RPRSztrYKwA2EhtxpkVRi31qKB40Niy1w
         0kXg2LEGJu+qwXyiA/mbzDmD83fNAHVFSzeLmGUZUX4+an+zO2GLET8xWC53idqO5yQF
         vLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=UMVv6GxFs/bxqjQb9cNcWMjQpkflX8Ywh2T7fUcm+6Y=;
        b=ncqE26g2ZjxgZ08djgFKukE0UHl1+j1tAm5va8TuZU96umQrqv+4SOZcNwqBIesZOX
         8ZcSLXJ96J7OClIaNiAH52bf6kk/kLJfPEwhuz13lQkUn6dFBq4S5vOOEVHT/ekBDD2J
         ZzVZoQybkxb9zhHdfZ7xkUGtmkc6ZyApUkWy4z1XdRs1G1I8FHNOMvVZRTCGReC2bSGy
         yCQdoe/PUoMh7RoEeOUNZsRIZfpJnxex18/OKOWifXm5noLTaQlHbClGp7TqSl58ZDXN
         +McvzTTFIZp+R3+ouusMjfaBwyjApw6Nnc0uv1MI7ZtzYBXC9JtC0I70Yf7K0D5167zR
         6lBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=A7/QXX+A;
       dkim=pass header.i=@chromium.org header.s=google header.b=VxMq+yNN;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=A7/QXX+A;
       dkim=pass header.i=@chromium.org header.s=google header.b=VxMq+yNN;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx48ZVC2P2QDG10V1YPOKVw+kptzhPlKQtqy4MIDm0rSrhJJSvScyGP+zIWYf6+O2hTy8i9m4dwsAjio7LnA2pY4=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522128575-5326-13-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-13-git-send-email-yamada.masahiro@socionext.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Mar 2018 20:26:11 -0700
X-Google-Sender-Auth: hnyWyUJ4m0wIqNkKLpXztGa9Pwk
Message-ID: <CAGXu5j+runDn9cZ8SCMYQzWr3twBvQPt=sRP+UNJfjxv19a4Yw@mail.gmail.com>
Subject: Re: [PATCH v2 12/21] kconfig: show compiler version text in the top comment
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537912515581?=
X-GMAIL-MSGID: =?utf-8?q?1596150327019040951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The kernel configuration phase is now tightly coupled with the compiler
> in use.  It will be nice to show the compiler information in Kconfig.
>
> The compiler information will be displayed like this:
>
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- config
>   scripts/kconfig/conf  --oldaskconfig Kconfig
>   *
>   * Linux/arm64 4.16.0-rc1 Kernel Configuration
>   *
>   *
>   * Compiler: aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011
>   *
>   *
>   * General setup
>   *
>   Compile also drivers which will not load (COMPILE_TEST) [N/y/?]
>
> If you use GUI methods such as menuconfig, it will be displayed in the
> top menu.
>
> This is simply implemented by using 'comment'.  So, it will be saved
> into the .config file as well.
>
> This commit has a very important meaning.  If the compiler is upgraded,
> Kconfig must be re-run since different compilers have different sets
> of supported options.
>
> All referenced environments are written to include/config/auto.conf.cmd
> so that any environment change triggers syncconfig, and prompt the user
> to input new values if needed.
>
> With this commit, something like follows will be added to
> include/config/auto.conf.cmd
>
>   ifneq "$(CC_VERSION_TEXT)" "aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011"
>   include/config/auto.conf: FORCE
>   endif
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I like seeing this in the config. Good idea!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
> Changes in v2: None
>
>  Kconfig  | 2 ++
>  Makefile | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/Kconfig b/Kconfig
> index e6ece5b..99ed4b8 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -5,4 +5,6 @@
>  #
>  mainmenu "Linux/$ARCH $KERNELVERSION Kernel Configuration"
>
> +comment "Compiler: $CC_VERSION_TEXT"
> +
>  source "arch/$SRCARCH/Kconfig"
> diff --git a/Makefile b/Makefile
> index 5cadffa..3dc9eb8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -450,6 +450,8 @@ export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
>  export KBUILD_ARFLAGS
>
> +export CC_VERSION_TEXT := $(shell $(CC) --version | head -n 1)
> +
>  # When compiling out-of-tree modules, put MODVERDIR in the module
>  # tree rather than in the kernel tree. The kernel tree might
>  # even be read-only.
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
