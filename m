Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518033754; cv=none;
        d=google.com; s=arc-20160816;
        b=QIGvpAwUDOmlHABFAkuJqxN0x7Fqax6t/RtBK9SLsdqVn+t8U36R3c2MedJTL/pZ52
         LgwdrbEvgQQod1vZePVg4yjZN5s5m6o5szE75JN22pyoh3m/NEJCTJ70545X61yqszmk
         8giOCPLtMjI2/9E65mlQMG4os6MPFFEiRhi1shqHpK3X3ZIS+jPxj26W/3K76KoeqmGd
         lstbnA3Q4sD1xk8h0t9Q7DFejaWvjxzMiYXDRLuulOh2VNZu/1jWES7r5dn20Z+a5HAv
         44fpCrEw0jwkWK7MYNe86ssAbgR3C8H2hcsqurAnKEHhDk5/yarzW7rzm5ZdBTPvlUZJ
         O+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1hUN1ZK4gjBPx3r2Xwq1BdWZD+wBx0NNVJpdz8fw5fA=;
        b=W2aFltKly+BFAERCE0nxBiKW8VVQ3BtoK+BDVwl41RqoRkdxUs/oP+MkPnX/O8tv3K
         E/4KhoepwNNfVqARlZmEUAGbKNNU/SLrAYPyvLvxxhFUhokt6y6kQPtGiRSH1OuPekvD
         dQwBR9xXDdYvKwwubXvQX/mt4eTxBDdp256ZB9GtmN7L1NWWvanAbk0d5e7zTJ/PDlpq
         knwqlEjLgs2VQvbVFN3Z7sMWD8sjuWo68vgG0z7yNTomDN9FM07wbQK0rgsYPmkQ8HIV
         bRCFc52y4slrX5f+/Pi17NWapVgVSDKjlWRvu/yRxcsSJDwVyi+t0nmw2B+MuMsi4kp0
         HizQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eMsmYp9B;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eMsmYp9B;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x226nZn99O0sYiFyqXxpXPKbXFiBAHNA2y6D0kT8NYU7d6c/Uh0+lS99kkFWAGHcSBZcHfsLAZGl7d4DRkF4skJ4=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180207104207.GA25825@infomag.iguana.be>
References: <20180207104207.GA25825@infomag.iguana.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 12:02:33 -0800
X-Google-Sender-Auth: VKpDPZctYtuN6GtMQHr18WHDJgY
Message-ID: <CA+55aFzrcAgOykaLK6S34W-udn5Y0rAC6j39MEZFz9CRSSnpEw@mail.gmail.com>
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
X-GMAIL-THRID: =?utf-8?q?1591738502725673664?=
X-GMAIL-MSGID: =?utf-8?q?1591773761690753143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 2:42 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
>
> Please pull the watchdog updates for v4.16 from the following signed tag
>         git://www.linux-watchdog.org/linux-watchdog.git linux-watchdog-4.16-rc1

Thanks, pulled, since this now had the tag name and the description.

Two small further requests for next time:

> The output from git request-pull:

This was still broken, and didn't actually have the tag name. Notice this part:

> are available in the git repository at:
>
>   git://www.linux-watchdog.org/linux-watchdog.git

just points to the bare repo. And since that's the part my eyes are
trained to cut-and-paste (because this matches the normal pull request
format), I got it wrong at first before correcting my pull..

The other request is to just make your gpg key public, and hoipefully
get a few signatures for the future. I have your key since you sent it
to me in email separately, but nobody else can verify it since it
doesn't seem to be on any key servers.

So just a

    gpg --send-keys FA2CAD78625F46CA

should fix it for you. At which point maybe you can find somebody to
sign it because they can verify it (locally or perhaps over the phone
or other side channel).

                Linus
