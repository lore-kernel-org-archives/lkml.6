Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523462943; cv=none;
        d=google.com; s=arc-20160816;
        b=h2mms4INXBVvhiKazB4a51BME4GdYAy5yNESuCYQRp3+RLpmebhBdYD9VipPJVmbf/
         4rgLNPR1ggGD/baNO9m2JBZB3AKZsJ3D3CCso2BsbBtGconieXIphfZzOGUxEiTpS4Ly
         KOhUmXYUrIAkb1ECyqTWG/gGsuB/VTTw/KdjoxpA4vY7Bund1C8inBFCSI8mL0wsHs/A
         8H1n7ZKn/u2l58SsYIJ8uYOA2iQD+VG1IuOsqPRa3TJpBU7BDWglw2CSfDo6ASdbdvGU
         deNlDL4ej0z4X/CvtpPedNNlNm+LxrgQr+o7ms0up12Xr8OIMYpPP0JXUkmg61e6XuYK
         UzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=cP/J5Jkw/bZZWKAGPNrJzLQaOw6YbWSt/NEdgxx/ZrQ=;
        b=02P1uYcxQhhrF1QUTaS06oPfkXN6Ku7W/kqH4lm8tKmr5NZNvvcr3cBk9WV8EaV8N2
         HGADAWFjTbBHH5j0/ARyIcgg4uw4stkVrWpODpN3qkw+J9/Lch687R/MWizMrF9o37NW
         1gKbtOvYnFDYo545GN+1cMmlMBBLt35KmaSotevSpiNBhJTcqAlxhu45riDfZaLAP/7P
         ZEZYTGJav2b325pEjXnsardihXW7OULY5ZqXb5x5BQdSmvBW97bkIEOQtddiVGteBEgl
         3z5EWmn2xIUh1PBArsMGNOq8VgLfJmMwxLHrseVc4L1odeqvwc6xpnQOUWkje1O4cpok
         /cMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SC/gjGKm;
       dkim=pass header.i=@chromium.org header.s=google header.b=Ckx92gJN;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SC/gjGKm;
       dkim=pass header.i=@chromium.org header.s=google header.b=Ckx92gJN;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+t+S11NFoQv4eTmttgdLphhzb1lfeeg3oQOlsiMm1Td9AzvNDG/7Aqy3myhd4enXPB2RrsDUpsKAg2arPk5KU=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAK7LNASerehkH2391jHcXoqysiw-PWuxHsAgqHp+7vp04q+tYA@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-20-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5jJB3AKMC8U--H61eUkFJeMogLMq00dBUUrfg4n2b4FbOQ@mail.gmail.com> <CAK7LNASerehkH2391jHcXoqysiw-PWuxHsAgqHp+7vp04q+tYA@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 11 Apr 2018 09:09:02 -0700
X-Google-Sender-Auth: clfSe22GyYsYgoYzkGUxH2KEpDM
Message-ID: <CAGXu5j+8OZ6cfQ9km1Y0Lgb3_vVCvgpqdacAPHDikvH_S=gnVQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] gcc-plugins: test GCC plugin support in Kconfig
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067545439308966?=
X-GMAIL-MSGID: =?utf-8?q?1597466680087879988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 8:55 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> No.
> There is no problem to use a compiler without plugin support.
>
> If a user does not want to use plugin in the first place,
> why does he/she need to be bothered by such information in stderr?

So, I don't think it's needed for the first version of this, but it'd
be nice to have a way for end users to discover _why_ some option they
want is unavailable. Having them dig through the Kconfigs, edit
scripts to see stderr again, running those by hand, etc, is really
unfriendly. If, instead, stderr was visible from the menuconfig "help"
for a Kconfig, it could serve as automatic documentation for why
something wasn't enabled. I don't mean for stderr to get sprayed out
during a regular "make"; I agree: that would be ugly and pointless.
I'd just like some way for the reason behind an option being disabled
to be discoverable in some way.

-Kees

-- 
Kees Cook
Pixel Security
