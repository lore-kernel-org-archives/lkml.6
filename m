Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522550426; cv=none;
        d=google.com; s=arc-20160816;
        b=QRq4pWM9UDeThKhn2Xv9uNcc9oDRom30M1w8/VwQsv7FId51l6mB3h2yglzTMm7Zi9
         kM2X6bPUmcTUTzNaVZw16zRkxWPKFRBzGeliZ5tRrSwGqy+8PYtb+ZDl2laYDautp8n0
         D2b3i0BO4i+FqJ3vqDgqJeSPki2L1h5DN7HE40IBj36k+D0ekUb6EoT6F1cyqd18dRbw
         WOQ9v24KSIunkYi8dGmvReeckxDVRE7S0W0RrrhJXVBmGtO6PnFYr6SZisCPGCXP1t4u
         voYFS+HudsQRZP6q5/waCXALWP29n4/FSiI8rPiuyj+E6c+EJZM4l3tticrrtPPvu0XA
         0Erg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=R9fYEhfCGCglElNGkvPHE9RvcB7t08qfJgf/E7oElJ8=;
        b=f5SEPbig87USL/3zJYzCQTf+URD+m7xi566Xy9k1NVMrxXFrL6+OTc8TUXyjmwMSDn
         g6AgJwjyuWCmYEnxPuMcbjFiuUxEhxG3e8Ed3DC5wJeKZuqLXt1X8yufvF4oc2N6bzWp
         gj66dywPzGasApPAxrknveAmq8QlJ8HYgGhg3IVSx0J/oYUxS8QCeJWUscFK0noy63kg
         xKigYtZVZ4aQrp/Q5wGN7dacr1jzMjlcO65F1457qASfUxA55e7pPKOXJXXEShbnFxCW
         TB+i6VhC3OWVehnlFuT+Uio4O1sA7YXpHJZTdulRecXB8pNG891v6jmmnBJRoRXfn3UR
         95Uw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TUxFw13d;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TUxFw13d;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48ZY7EJ9B4XyGcW02qmBixaiBFf/fuN3s7kWiPF2H4qO0mDGSG+x2pmQK3SFlOYxD5kpwgGXXac7WVDb3CRDYc=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KTpTXPzNpe6L33_a4YJ=DD0pwz+iEjvm-c1gVeCJGn_6w@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-5-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KTpTXPzNpe6L33_a4YJ=DD0pwz+iEjvm-c1gVeCJGn_6w@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 1 Apr 2018 04:40:25 +0200
Message-ID: <CAFkk2KSn9goBN5nngwXbePDEohgqzL19V_1m62sgCfej=W5iyw@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] kconfig: reference environments directly and
 remove 'option env=' syntax
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538224428128?=
X-GMAIL-MSGID: =?utf-8?q?1596509836085598473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 1, 2018 at 4:27 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>
> AFAICS, we only need the following functionality:
>
>     1. Record referenced environment variables along with their value
>
>     2. Go through all the recorded environment variables and write
> dependency information
>
> For (1), I think it would be better to simply have env_list_add() (or
> some other suitable name) add the variable to the list if it isn't
> already there (like a kind of set). It is always safe to get the value
> of the environment variable from getenv(), and that seems less
> confusing.
>

env_list_lookup() could be removed then as well.

Cheers,
Ulf
