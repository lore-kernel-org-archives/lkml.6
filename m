Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520252266; cv=none;
        d=google.com; s=arc-20160816;
        b=jUYiIhU3Um/kaM1MOPLQXTvUfEZmnI5RwNRi8IduOvVMMKcSeDRrQjjJLgHGMiKnuz
         jfixxhk63GH74/mWL0C0bH/DDiEwNEUe6mGd15niRqa1+s1sjSANTX5QFt+H9hxS81io
         FMZeJGP/UYn0CIEDGC6jLVHKfprVugp3OmEUeEWTK7bBZSB6RBMbcuOqiKODmghFzs4L
         TNmYaIntNVXbgJOEBWnnu2y1H+PyL74IdM6IDna6VFkjGYJelG3KQi46MnG4GdOK7HWB
         wjRrAalzgDEyvBseH/SUvXPjXmc072kGXqHe6G+r8IgJD0wkRUqHp9Gs83W7MtDR4QqR
         R/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=w/VtJME5JIv5jUzQsd5HrqgGWPCUG9GFCiNW6OZ/7wg=;
        b=tO7MCr1uV+ct0/Ms3FIHmNgjMIxWmW7qIW3dL2Idmh3No9iIsuwJ8InGMPdbpZswU5
         dWHIGR9mGSaUsxH9gVcDO09bIcAizl5yva5TWq4+qa+1mJZXfouiN0IfvkA+XPtY2WtS
         CmO1kdAeq94SnqzXkGVATwS0zgV5S2g8cBy2fmlPENZFHOkS9eHmnOYdM8piMOlhZEFs
         5cm6D5w4osfJXsXYSiRp5Dsr1aQvwkw1ZnZhoQsqKqUCXxpl0InDXvXAYygJeDTGOcaG
         co62TOlxu0UXnKvkYqLgSn7K/iB7DY94V7ylON0vt1EOLG/fWM1j+c+X5Ccojucvv/iT
         vS8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gz/zXeWt;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=CpNaQ7eX;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gz/zXeWt;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=CpNaQ7eX;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELta2tQq+8UIf2uXBjKOCIZLVCtwZfYK7dSRRFmgoQ9EtzF8NWuITq6EyDiAgJwQoxvUE2WU+0gyDVe9O41pDaU=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1520245563-8444-8-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org> <1520245563-8444-8-git-send-email-joro@8bytes.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Mar 2018 04:17:45 -0800
X-Google-Sender-Auth: dPBKPPX8GHA9odPtoKsuw0KidzM
Message-ID: <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Peter Anvin <hpa@zytor.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	=?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, "Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>, Hugh Dickins <hughd@google.com>,
	Kees Cook <keescook@google.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>, Joerg Roedel <jroedel@suse.de>
Content-Type: multipart/alternative; boundary="001a113a427e4596020566a950bb"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594100040554132385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113a427e4596020566a950bb
Content-Type: text/plain; charset="UTF-8"

[ On mobile, sorry for html ]

On Mar 5, 2018 02:26, "Joerg Roedel" <joro@8bytes.org> wrote:

From: Joerg Roedel <jroedel@suse.de>

Restoring the segments can cause exceptions that need to be
handled. With PTI enabled, we still need to be on kernel cr3
when the exception happens. For the cr3-switch we need
at least one integer scratch register, so we can't switch
with the user integer registers already loaded.


This fundamentally seems wrong.

The things is, we *know* that we will restore two segment registers with
the user cr3 already loaded: CS and SS get restored with the final iret.

And yes, the final iret can fault due to CS/SS no longer being valid,
either because of ptrace or because the ldt was changed.

So making it be a "rule" that segment registers be restored with the kernel
cr3 active seems bogus. It just means that you're making a rule that cannot
possibly be generic.

So has this been tested with

 - single-stepping through sysenter

   This takes a DB fault in the first kernel instruction. We're in kernel
mode, but with user cr3.

 - ptracing and setting CS/SS to something bad

   That should test the "exception on iret" case - again in kernel mode,
but with user cr3 restored for the return.

I didn't look closely at the whole series, so maybe this is all fine. I
mainly reacted to the "With PTI enabled, we still need to be on kernel cr3
when the exception happens" part of the explanation..

      Linus

--001a113a427e4596020566a950bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">[ On mobile, sorry for html ]<br><div class=3D"gmail_extr=
a" dir=3D"auto"><br><div class=3D"gmail_quote">On Mar 5, 2018 02:26, &quot;=
Joerg Roedel&quot; &lt;<a href=3D"mailto:joro@8bytes.org">joro@8bytes.org</=
a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Joerg =
Roedel &lt;<a href=3D"mailto:jroedel@suse.de">jroedel@suse.de</a>&gt;<br>
<br>
Restoring the segments can cause exceptions that need to be<br>
handled. With PTI enabled, we still need to be on kernel cr3<br>
when the exception happens. For the cr3-switch we need<br>
at least one integer scratch register, so we can&#39;t switch<br>
with the user integer registers already loaded.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">This fundamentally seems wro=
ng.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The things is, we *k=
now* that we will restore two segment registers with the user cr3 already l=
oaded: CS and SS get restored with the final iret.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">And yes, the final iret can fault due to CS/SS n=
o longer being valid, either because of ptrace or because the ldt was chang=
ed.</div><div dir=3D"auto"><br></div><div dir=3D"auto">So making it be a &q=
uot;rule&quot; that segment registers be restored with the kernel cr3 activ=
e seems bogus. It just means that you&#39;re making a rule that cannot poss=
ibly be generic.</div><div dir=3D"auto"><br></div><div dir=3D"auto">So has =
this been tested with</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
=C2=A0- single-stepping through sysenter</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">=C2=A0 =C2=A0This takes a DB fault in the first kernel ins=
truction. We&#39;re in kernel mode, but with user cr3.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">=C2=A0- ptracing and setting CS/SS to someth=
ing bad</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0Tha=
t should test the &quot;exception on iret&quot; case - again in kernel mode=
, but with user cr3 restored for the return.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">I didn&#39;t look closely at the whole series, so mayb=
e this is all fine. I mainly reacted to the &quot;<span style=3D"font-famil=
y:sans-serif">With PTI enabled, we still need to be on kernel cr3</span></d=
iv><div dir=3D"auto"><span style=3D"font-family:sans-serif">when the except=
ion happens&quot; part of the explanation..</span><br></div><div dir=3D"aut=
o"><span style=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto=
"><span style=3D"font-family:sans-serif">=C2=A0 =C2=A0 =C2=A0 Linus</span><=
/div><div dir=3D"auto"><br></div><div class=3D"gmail_extra" dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div>=
</div>

--001a113a427e4596020566a950bb--
