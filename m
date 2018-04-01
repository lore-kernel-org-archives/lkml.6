Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522551565; cv=none;
        d=google.com; s=arc-20160816;
        b=o4GRCtFeHW8Bn/fu1uzzVrSWb4e7TKOmA1uzrSXwedWLRLgJmePTqvy29kJiGQstqq
         c2IwbeiygnmD54R8xUFeUecNLja2yPa5Y9SpCRHXdyvR+HWBtZ7W09B1AgxMg0z6lrmP
         pvT/OldOtQfcqDkEOifYh1ZQg1m0Fa3CHLOM5udi9+qdsC3G4qRYHZKnKSZpTOozf0jy
         VALq87/KjrnHb6f78GDp9ddEemSIIXrpaH9t57SP3ryhl8mfgdAKYvQOVp6avWzkv9di
         bNF3cUx8PSjog2vbEzlxoBM+r5+eBd1qhG7M+ry81ElXcAmwu6s+YGRpDbGcb6hGitP0
         Jw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=dmrQg8TCmssfH4GbTIAmTJVRau0M7jUcDiNRKiMAb7o=;
        b=DQTJklr0cCqLbtBSCz8vTqzUHnMOKaBTz1+W7F1D8HaMQAdJbgMqqb0yDdOw2Byzf/
         Nwxqarjxanc4ZqNlSJoN6zFtX4f3mxh3fA7W5qh5HFTHVaTFILMkWAI4r2RVLE2BdBxd
         EMjM+nXr56PwQaSeSysve8t31AsHanEXix3xwfqPQRAKisCeydv298exak+I/C6TWvEa
         Gn08oyLqG+hu9AlDZslrUmsCnxjpyaXuw9yP2nUZHtjc24X2/UY9ARBa51CCbs5ot5YR
         k3MjpmMOhiV++j6t0jfIV0qQ7aCPvgbFXq240dPVFbwdV9JZitTklN2oJaAeG7gCN9s3
         tkzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cUm//OP3;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cUm//OP3;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/37gKgBe56KxMy89ensPErDVw2qNTwEXxfub39XOJopcTupFTWUvXJh+cKfq5cRZijlYFPuwiDJLXv4h5+4UE=
MIME-Version: 1.0
In-Reply-To: <1522128575-5326-7-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com> <1522128575-5326-7-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 1 Apr 2018 04:59:24 +0200
Message-ID: <CAFkk2KQK9vV+Xr=AvM09gEmEtSHsihpx_CYA6Qys6Gs7OrpbuQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] kconfig: remove string expansion for mainmenu
 after yyparse()
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537936435253?=
X-GMAIL-MSGID: =?utf-8?q?1596511030227415455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 7:29 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Now that environments are expanded in the lexer, conf_parse() does
> not need to explicitly expand $ARCH and $KERNELVERSION in the mainmenu.
>
> The hack introduced by commit 0724a7c32a54 ("kconfig: Don't leak
> main menus during parsing") can go away.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
