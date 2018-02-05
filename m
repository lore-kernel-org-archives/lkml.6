Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517822447; cv=none;
        d=google.com; s=arc-20160816;
        b=VM3lz0rK5tfsnWvrZJP/vaR+5s7wwc+RP/Kl9fbXTPyr0QyY2gsU5CMQv6jtZ/RmbG
         2KvVdjw/AQ1BOOymlI1/4c+ahuZ4o9c41FcD7JCdfjleFisSIveFs1wYavu6XVWWmI+O
         Hn+T7CBhu0tIEwxjC1j8N1oGOcIE7Sg/eWjEYlVeZuflQptdoxnO1UPeEODebynqgnVa
         pcJ3Hp2r8sZT24HOUqEXi4Gb57v1OOIixl7ebRgEX3IHxMzyYaGrbsEHvCu8dYY0jfIG
         rz+zzZ3AGMh+UPUfUuCi0wSz/n0r17sNJG3iv7YSgpvFwNmom6c3dGTdwEH1d9PVyyMP
         mGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=XzqKUj2nCY5FpMngbVcEC6HBpkbWn2pEZB8dipNqrdM=;
        b=y831qfVL9kYOVBS2zLHHb22fOmQdr3YoqDXpYQ6Ha4PIWonRIMvBFU7SAQCzJopM/4
         pjd2S0gNvSdxEaUMBB7EbSVYjpX256fnMKK7nBi4oyCvE2zS4NnpopL+vnj7ZEBgCwGV
         NGIxvPkmNjFU08XynPym87ur7Z5bnlIL77uUtVvvLmtS29eDo8GIqSWRQO1Ews9CTPF3
         3iFs5g2xVupc3pG3Oh0o8gOs+I94QLvVWYHoHQa7PukBnJ/CsXxHzBsvqDFZ4tNtuGbW
         1o9GHUC0M0lMVwJE5WPCui0z8SqH8IUHNi8d+NugkxVd/CA5EsOqIwrBDqA/YFM2JHWM
         SvIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=NVvKi2Qs;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=NVvKi2Qs;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x227TxgGm7O7kOrxWNXjqnfhaY2uF2ECc/8ddXlLQaOJUL8e+/KjDcmA2uPRuhwOnvZrKlx4CtXmEbF71yPTDgwo=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzhp2QW9JeMwV6=W4skf0CW6E+Zg4K90n3Bo+yZmz485Q@mail.gmail.com>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com>
 <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com>
 <CA+55aFztiKehjo7OQQFboAEfe_BrxJQG_5wxak2a_GdNBEFiMw@mail.gmail.com> <CA+55aFzhp2QW9JeMwV6=W4skf0CW6E+Zg4K90n3Bo+yZmz485Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Feb 2018 10:20:46 +0100
Message-ID: <CACRpkdZGABVtdF1HWHfx-5JPyaEhtt+Q_sjM=bkJu6cZ5WfPCA@mail.gmail.com>
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>, Julia Lawall <Julia.Lawall@lip6.fr>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591552189930583494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 3, 2018 at 1:51 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Feb 2, 2018 at 4:44 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Stupid patch attached. I don't know how much this helps the insane
>> dependency hell for <linux/pinctrl/devinfo.h>, but it's bound to help
>> _some_.
>
> Testing it, that patch definitely cuts down on recompiles after
>
>      touch include/linux/pinctrl/devinfo.h
>
> a lot.

Hey very nice. Sorry I was offline this weekend and didn't provide
much feedback.

Indeed it is smarter to forward-declare struct dev_pin_info.

I rebuilt my platforms with the mainline and all is working just fine
of course.

> It still ends up rebuilding a fair amount of odd drivers, but now the
> files it rebuilds at least make _some_ sense.

Yeah :/

I guess the lesson learned is that when I push stuff into device
core like this, it needs to be done as exquisitely as cache-aligned
structs because of the overall impact on the build systems.

> One odd header include down. Ten million to go.

Sorry about contributing to that :(

Another thing that comes to mind was Paul Gortmaker's tedious
work to remove #include <linux/module.h> from drivers that cannot
be built as modules that happened in the last few months. My
subsystems had a few of those and it visibly impacted build
time. As usual clean and consistent code is code that compiles
quickly...

We definitely need some better tooling to find these things,
using Ingo's head and your occasional frustration is not going to
scale.

Julia: do you have ideas on tooling that can loosen #include
deps and advise on when to replace #includes with forward
declarations of structs (etc) to bring down rebuild-triggering
dependencies?

Yours,
Linus Walleij
