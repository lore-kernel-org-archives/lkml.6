Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AH8x2257AwU9e2g5U2+M/9A6HVC31SkOWMbiB6eStzvrnneHoAynPuJlSO9aQKYdsvuvyv9H76wD
ARC-Seal: i=1; a=rsa-sha256; t=1517822867; cv=none;
        d=google.com; s=arc-20160816;
        b=D0LUDTA/xNF1Sgg9COuOszp4j0GG1ZLv8WDu5hoGD9RDtYrxu3EhXdY58xwvHjDMLr
         +RVd/AwV7WQe3gHeRQp7xmOcv1b8Vz9rfxb1AtcM5Zvm9O1rcGi/2zfELMB2Wi0cpWu/
         bqI+XOJmmJMwNvMuA9aKjTPKmWIdVPx2nDx2/sLqUZ0EjW2y0WViaAO8/QJ5IllYBTHE
         tgP9hXypzywbIqg/giCirlh4OvqLPNvpYsYQ8AB76t/Kpasu5fQEhoQ34hvs+R3aSLKc
         gvJdsXz1FMgARPvl7hai5uVHOCRvy3NXRn7evexFFwCJk8bvxrkPQg6Yqrch/BH9fenF
         VRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=HDrBoYxBHmF5txXR+VWmgHBfyh3CxzmasYWy+TdnFHM=;
        b=eGiC9v6mNldn5sKtul3y7b8cEiDZ0ZIGt8eydQihvDNNg2NTtduI/aFtIGeJwW0GfB
         7JffpECsEfGptymwOSoTeMWQm12HOL8vgtBEOo5lK2gH3PnfP9aVn8LedieAGBxVy766
         HpH4lZmaPDo8/5FgSflKht2kfFP2tlbfi85EjJhqLOpFm7mh0i+oHWBFeK332yEQEhfO
         S6QoGRcyk3fQ47cxOijwFsZcRWx1tDpZi2OpOB8shB+SgA4Up5Klo1dmjVBSBLOn9lIm
         L433BTvqN6px7YTXUAvvADZxMky5fJeW8VDaLUqCr4EMZDg1V36MI6U1xHXqm1lh21p0
         sRuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.46,464,1511823600";
   d="scan'208";a="312051156"
Date: Mon, 5 Feb 2018 10:27:43 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Linus Walleij <linus.walleij@linaro.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>,
    Paul Gortmaker <paul.gortmaker@windriver.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Ingo Molnar <mingo@kernel.org>,
    linux-kernel <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org
Subject: Re: [GIT PULL] pin control bulk changes for v4.16
In-Reply-To: <CACRpkdZGABVtdF1HWHfx-5JPyaEhtt+Q_sjM=bkJu6cZ5WfPCA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1802051023540.3292@hadrien>
References: <CACRpkdaTv4NBrRXeJE6dVi4W88+LZdsTCSzTHi0vdcKMW3Qfmw@mail.gmail.com> <CA+55aFzMBptQt-QHMR0MM9MA3=1rxcf8ca5qHxrf4Mm0ZobE_A@mail.gmail.com> <CA+55aFztiKehjo7OQQFboAEfe_BrxJQG_5wxak2a_GdNBEFiMw@mail.gmail.com> <CA+55aFzhp2QW9JeMwV6=W4skf0CW6E+Zg4K90n3Bo+yZmz485Q@mail.gmail.com>
 <CACRpkdZGABVtdF1HWHfx-5JPyaEhtt+Q_sjM=bkJu6cZ5WfPCA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591331743286572652?=
X-GMAIL-MSGID: =?utf-8?q?1591552630996711365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Mon, 5 Feb 2018, Linus Walleij wrote:

> On Sat, Feb 3, 2018 at 1:51 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Fri, Feb 2, 2018 at 4:44 PM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >>
> >> Stupid patch attached. I don't know how much this helps the insane
> >> dependency hell for <linux/pinctrl/devinfo.h>, but it's bound to help
> >> _some_.
> >
> > Testing it, that patch definitely cuts down on recompiles after
> >
> >      touch include/linux/pinctrl/devinfo.h
> >
> > a lot.
>
> Hey very nice. Sorry I was offline this weekend and didn't provide
> much feedback.
>
> Indeed it is smarter to forward-declare struct dev_pin_info.
>
> I rebuilt my platforms with the mainline and all is working just fine
> of course.
>
> > It still ends up rebuilding a fair amount of odd drivers, but now the
> > files it rebuilds at least make _some_ sense.
>
> Yeah :/
>
> I guess the lesson learned is that when I push stuff into device
> core like this, it needs to be done as exquisitely as cache-aligned
> structs because of the overall impact on the build systems.
>
> > One odd header include down. Ten million to go.
>
> Sorry about contributing to that :(
>
> Another thing that comes to mind was Paul Gortmaker's tedious
> work to remove #include <linux/module.h> from drivers that cannot
> be built as modules that happened in the last few months. My
> subsystems had a few of those and it visibly impacted build
> time. As usual clean and consistent code is code that compiles
> quickly...
>
> We definitely need some better tooling to find these things,
> using Ingo's head and your occasional frustration is not going to
> scale.
>
> Julia: do you have ideas on tooling that can loosen #include
> deps and advise on when to replace #includes with forward
> declarations of structs (etc) to bring down rebuild-triggering
> dependencies?

Could you explain more?  Is the point that you want to remove an include
but it has one declaration that you need, and so you want to bring it down
into the .c file?  Would the need for that actually indicate that the
include file is designed incorrectly?

Can one assume that each include is self contained, ie it includes the
things that it needs and does not rely on the .c file having included
other things beforehand?

julia
