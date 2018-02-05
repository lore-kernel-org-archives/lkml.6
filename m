Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517853055; cv=none;
        d=google.com; s=arc-20160816;
        b=ceCEZIzFSW/n3PltIYZpMShBZlV7z2IGogZL/ez93J74PqKQZGJxngDNJSEQt2oc78
         G0PIgpAVgsT6AI+kd3Ix3IJoNoKHJEcrVuGnGISMCrrKhw2PWMvh0TUC1ekNJYa3dDHk
         XOGCFcqvMdfef4rVaLnUnMj/5TtgqAGtsrC4fLNbtTohI4pW/GmZ8HcHOmwRRlepskZ0
         H+8fUi+bjXbIGAtqCaSxv1uh32/2NMaXqGH6OJZN/H/b0n3sqSk3Ih9xX53BgVUjRKVC
         VRTeHQSEqKh6Oxw7AzQiYEGJEkLZ789Quql05NbCYDbOGiXP66JD2SRE/yX8nbq7ECM4
         15Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=VMfPw/8oMD6FhYDLRQH7too53IBmDj/35hO6zB4cEIM=;
        b=GeKTLfKummR1eE7gvs0C37pJXCZga3Y4pXJkkkrzXCaPufMh4t7rxIhuN5xWTt1OLk
         wGgj90k0gM+peZD3S9bpbK1khRdELnDUFYcvsXGWjibqR4Z8FD4SDYgNZTFZgzJ4gn1Z
         PtON9tl59bYiQzI34on7XtzjIr/8Fq53RzzZMh6eYRxsV5EWmtgkAE0FjcFv9/xahnTp
         rcKC4O7beyE4C5EGuX2gB1QKgNEFWkg/mCRe5htss2eMXvj1YiWkN3LmxHH28eC6Nbc+
         UZzf37vCXVMwOig7w/nmasBO66zpVFwXypOPt29dTM39IVzLZC+fHERSs8BrACQDvrer
         5CIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pcewTlHZ;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pcewTlHZ;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227aT0VHaZq4vbDl+KsH3KJay2/GdScGCtOv5o4yl/4vo2MczO8oIGfNc6ORGjrBUigqjKg8fNVt17o6FK2Z4Us=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180205102056.GA470@infomag.iguana.be>
References: <20180205102056.GA470@infomag.iguana.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Feb 2018 09:50:54 -0800
X-Google-Sender-Auth: fcXyY5pYF9zGOKM4wfxE4CNCdO4
Message-ID: <CA+55aFwX9dqdRghD6sMECf==fdw43u_0Sqm+_cxLp2EPCyLX3A@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.16 merge window
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <git@andred.net>,
	Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Christophe Leroy <christophe.leroy@c-s.fr>, Corentin Labbe <clabbe@baylibre.com>,
	Corentin Labbe <clabbe.montjoie@gmail.com>, David Lechner <david@lechnology.com>,
	Eric Long <eric.long@spreadtrum.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>, Jerry Hoemann <jerry.hoemann@hpe.com>,
	Linus Walleij <linus.walleij@linaro.org>, Martin Kaiser <martin@kaiser.cx>,
	Mathieu Malaterre <malat@debian.org>, Matt Redfearn <matt.redfearn@mips.com>,
	Michael Grzeschik <mgr@pengutronix.de>, Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Radu Rendec <rrendec@arista.com>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tomas Winkler <tomas.winkler@intel.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591555975700214144?=
X-GMAIL-MSGID: =?utf-8?q?1591584285035848134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 2:20 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
>
>   git://www.linux-watchdog.org/linux-watchdog.git

Hmm. I really want to know why I should pull this. You have the
shortlog and the diffstat, but you don't actually have a descriptive
blurb about _what_ I'm pulling.

Please give me a summary of what this contains so that I can have a
good merge message.

            Linus
