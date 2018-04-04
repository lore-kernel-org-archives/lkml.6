Return-Path: <ndesaulniers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522860598; cv=none;
        d=google.com; s=arc-20160816;
        b=y0uSIqxTpydo3zoW/TTEhjyHnmh6eASVVROgLmqBI3/CKru/E/948Co+wNLz4hsvu9
         3euutFsMyIrhyCIHj9EOrvtacT+hjyImjMRtuppNBI6l2Qq917J/2dKNJm0Kle4XvDiR
         s0zdSdbuh/WnN9MeorgDzKV1CoR6CwJKbDjIj/sJgrzHhfQSK8tkFJUtR9Qro2sCCl+z
         /W9h9eYp34ZF9GIjV6LI+tp4VK8TPgShdNwWGWubTCVeRB7iHdI/bmlNXLPPeJTUxr1s
         8zgB8AJS2NlR3UQgTd9yglorVtNtacRZfpa8ZN3J/t/NaP9UaHTkgGP7S/GIxHWFJyYM
         MbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=HiNZoltzuWH0WbNKrbViAkzWi2wcZVYaLORNbvIsu6E=;
        b=Jhe0lMbSkSRuNC4j5ljYLEcH8m1ckBTypW6ylwWXEJVXpYdZ3oKUdTwnTia6MEU+lL
         T2tZo+niRSzK57ymvaHveCiAfFhHNfqj6ri1+Vq8rG2kSW7ITGyskZ2j8AQ9XvUMP0GL
         R1GjMXhsg53Ae04bcafmLEZc2zzCiKbUrmB3rTg5sNf+gTuPX0UVQezYDhok/XE/z8W5
         tK5wluTW4mj31LEY0gjlZJQAMe2DiHOzYpwyRHp7xfhHIP58hyRQnrTNRzxWT9ieEOqr
         fdFNaR0Mr132rji+lw1qRK2KTfyZQSvllZI8xZqiHu2Is6y4eG9ttM1ySGwNUloQh5fj
         iY5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OBnl2QwP;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OBnl2QwP;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48grceZZjWUCBwDQXqtg3BY7BYZ/DqmlbTzcuyvro+PYWTq9U4LU1q/YI+kM9Cp5pkJ/lBSKpnGSamu8nfeqXw=
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com>
In-Reply-To: <20180404093823.GC25996@kroah.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 04 Apr 2018 16:49:46 +0000
Message-ID: <CAKwvOdkjB2LGXGn-9chPDtGyVmw9JF1FZ1ZBjSKEtK7BqbwF2g@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>
Content-Type: multipart/alternative; boundary="f4f5e8066c6cfa92670569089cf0"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596835074722906843?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--f4f5e8066c6cfa92670569089cf0
Content-Type: text/plain; charset="UTF-8"

On Wed, Apr 4, 2018 at 2:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:

> There are known-bugs with building a kernel with clang right now (I
> pointed one out a few days ago about NULL checks being deleted from the
> clang output for no good reason, which really is scary for obvious
> reasons).


Is this the thread you are referring to?
https://lkml.org/lkml/2018/3/27/1286

It's definitely something curious that I'll need to sit down and
investigate more.  If there are other known instances, it would be good to
let me know.


> So while it is great that small subsets of the kernel can
> work properly (or hopefully properly), with clang, it still isn't ready
> to be considered a "fully supported and we can't change the kernel if we
> break using it" option, sorry.


> And don't tie _anything_ to a LTS kernel, that's exactly what those
> kernels are NOT for.  You implement features and things in the kernel
> when they are ready, and I'll pick a random LTS kernel out of the air
> when I feel like it.  Never should the two intersect and matter.
>
> So please, work on fixing up clang for asm-goto and other "features"
> that the kernel requires, and maybe when all build options/configs are
> really solid and working well, will we be able to properly consider it
> as a reason to implement, or not implement, something in the kernel
> source.
>

Acknowledged.
-- 
Thanks,
~Nick Desaulniers

--f4f5e8066c6cfa92670569089cf0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Apr 4,=
 2018 at 2:38 AM Greg KH &lt;<a href=3D"mailto:gregkh@linuxfoundation.org">=
gregkh@linuxfoundation.org</a>&gt; wrote:</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
There are known-bugs with building a kernel with clang right now (I<br>
pointed one out a few days ago about NULL checks being deleted from the<br>
clang output for no good reason, which really is scary for obvious<br>
reasons).=C2=A0 </blockquote><div><br></div><div>Is this the thread you are=
 referring to?</div><div><a href=3D"https://lkml.org/lkml/2018/3/27/1286">h=
ttps://lkml.org/lkml/2018/3/27/1286</a><br></div><div><br></div><div>It&#39=
;s definitely something curious that I&#39;ll need to sit down and investig=
ate more.=C2=A0 If there are other known instances, it would be good to let=
 me know.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">So while it is great that small subsets of the kernel can<br>
work properly (or hopefully properly), with clang, it still isn&#39;t ready=
<br>
to be considered a &quot;fully supported and we can&#39;t change the kernel=
 if we<br>
break using it&quot; option, sorry.=C2=A0</blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
And don&#39;t tie _anything_ to a LTS kernel, that&#39;s exactly what those=
<br>
kernels are NOT for.=C2=A0 You implement features and things in the kernel<=
br>
when they are ready, and I&#39;ll pick a random LTS kernel out of the air<b=
r>
when I feel like it.=C2=A0 Never should the two intersect and matter.<br>
<br>
So please, work on fixing up clang for asm-goto and other &quot;features&qu=
ot;<br>
that the kernel requires, and maybe when all build options/configs are<br>
really solid and working well, will we be able to properly consider it<br>
as a reason to implement, or not implement, something in the kernel<br>
source.<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,=
34);font-family:sans-serif;font-size:13px;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">Acknowledged=
.</span><br></div><div>--=C2=A0<br></div></div><div dir=3D"ltr" class=3D"gm=
ail_signature"><div dir=3D"ltr">Thanks,<div>~Nick Desaulniers</div></div></=
div></div>

--f4f5e8066c6cfa92670569089cf0--
