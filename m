Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517619066; cv=none;
        d=google.com; s=arc-20160816;
        b=hiTZUNP77jFxK+54QbLco/m3ji5fg0vPErqluNSYvpIOUvjOBFNHxSnwpv1b99QQfL
         vbGqLGgDRK20zPQkkwMlK3/qzlKkE4df0Y9SGEL3V8D/4L93aiiHOlcfrw4xm+PMZQLQ
         7yyVikeAi06jV/Osxd2vgryKGbgOVL9XhPqF4xV78W6vY9NGKtW/AH4RMG8d20NZUDwA
         gFxZcYbot62i7Wt1e2wd3xbEBlIvtfwm5IQ2KQoJ+ntWAJYMGOhMcz77dRFIMhjmKAeE
         Oto4YqpOSy6JfuWRpNys5dmtap1GxR6mQx7gNb1IdE2264f/yvPu/EmGuKVhEtNr8OGX
         5ufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yC1Nj+GPhc/F4IEcNLmOHPVNtf9pu3WjHxtT1GexEcE=;
        b=LGmaDBldEJn18LuKcOuHvRTZyy2PXCy6lY5ciGx/LSr9pk5yJF4eBDKMmDP2XGrCz+
         RFQybs4lKMldLPE1sdvajgNEuJp1hL1hoECLW/bvRYNnhxQf2y6q5SYdvDrantjEzEtr
         ggOfud8bn5zApt6t4tFm+6l4ZHzUu6PEnihke7U7dkG85m+WmECXieqIgbuEOWd9nvh8
         FFrUIBHHeA+rq5G5Q9rxjAbwDWn6/piqaLywR3X3msJqsjogfkMk8Fv5g4uql3TguqoG
         ZsAxI11F4qi2d8bDPdZq3bG4Y/Tu3RhaEr0kyyFNUCT0OGaULj9NOGRXsC4OimGWQwer
         tvrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SadcUdwu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SadcUdwu;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x2241U2hmfovtY7EGxPDOBOnXtc73C9VS1/FBpX2AOcNNKigiDUlRTa2PCzWYoLPQrPKDFpxwsAtZDLQ5McDGUBo=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFztiKehjo7OQQFboAEfe_BrxJQG_5wxak2a_GdNBEFiMw@mail.gmail.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com> <CA+55aFztiKehjo7OQQFboAEfe_BrxJQG_5wxak2a_GdNBEFiMw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2018 16:51:05 -0800
X-Google-Sender-Auth: xsh9nVoO-B46_6AkGSeUmtrZCnU
Message-ID: <CA+55aFzhp2QW9JeMwV6=W4skf0CW6E+Zg4K90n3Bo+yZmz485Q@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
To: Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591338929907796133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 4:44 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Stupid patch attached. I don't know how much this helps the insane
> dependency hell for <linux/pinctrl/devinfo.h>, but it's bound to help
> _some_.

Testing it, that patch definitely cuts down on recompiles after

     touch include/linux/pinctrl/devinfo.h

a lot.

It still ends up rebuilding a fair amount of odd drivers, but now the
files it rebuilds at least make _some_ sense.

It used to really rebuild just about everything (because pretty much
everything includes <linux/device.h>). Now it rebuilds various snd/soc
files,gpio stuff and mmc/mfc stuff.

I'm sure it could be improved upon still, but I think this is already
a fairly noticeable improvement.

One odd header include down. Ten million to go.

             Linus
