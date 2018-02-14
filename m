Return-Path: <chandlerc@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518597716; cv=none;
        d=google.com; s=arc-20160816;
        b=wxZR6JP/BI9cBVASw4kox1s3gtXelKnKXuEcIeCEQ5PyoNyeQBJDA+Isrq4RGAipUN
         fdlt0vltH41nhJBTbaOyB7IHSQjIAUgoO6T694RYounWnMjz58yxCNKC7BQQdiCLT2qq
         UAqdiAwwwroVNKH/Y8HQqsj0eY8/08JwGANsYL3hhi41zijJjjMTWdYBdG/Pb9yyVOOb
         CpWBMzykucKpo/1N45Mv7bP4rfHOE2TKHrT1neGrKzF8CB7bdOYmc99BygDoPfUom9+W
         Lq8rz8I/Ad/7aKdk591U+pjPYttnB22sF2Lf5VVpmcymo4IIpapC2Zcf0V8ORAny3UIk
         1NmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=uBiQtDeKskRkkQ9zwpGyfUs80WcOZHO4Ovl3B1sAOrQ=;
        b=ZIph2mLpXpOpSLc2gJnlbr/RKD0QoYD9fb28tTEiBLBUGHLw5BjqV/LqIzLqtcyP5l
         30xj9ZdlAR1I+ttw/r5NYTQeYVdKM+xy5k9iWfDXs3wqope/MPg18BxBxMxfrA8vn5hW
         dRB4Tq8hgYGesDHddRKiFGO6Gpu/kp+2EufLVXteanF2lyynD7B5qjLf8l7cljatO0kT
         TRwMO4UdMJosXyLQ5upzxn9oW2DhWZkDKP4xptQ8AQFSUQHpA6oVNnLfwYmHNuG48HM/
         e9RSKw69c9c2NeG+jCYYkv17bXpSAAc/cPf3FzcMav5cZULMnmyqi/vCfEFiaG6UU/5O
         NP4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=AUJ8/iFL;
       spf=pass (google.com: domain of chandlerc@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chandlerc@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=AUJ8/iFL;
       spf=pass (google.com: domain of chandlerc@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chandlerc@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x224+k6T8KIfTSJPGzmM3yhkmjxwn55KSkDOplPR11MYj7IaiwnCOWW2frfaaZqNeHHP6TKRFovU4nh6cL08HGGM=
MIME-Version: 1.0
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
In-Reply-To: <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
From: Chandler Carruth <chandlerc@google.com>
Date: Wed, 14 Feb 2018 08:41:43 +0000
Message-ID: <CAGCO0Kj01tAXdzRrL_p+LrTLK6-k-1-BFPm97jQMuJSPH7PTJQ@mail.gmail.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
To: "Yatsina, Marina" <marina.yatsina@intel.com>
Cc: Kees Cook <keescook@google.com>, David Woodhouse <dwmw2@infradead.org>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>, "ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>, Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>, James Y Knight <jyknight@google.com>,
	Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>, "Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: multipart/alternative; boundary="001a113ea40666a5ac05652815af"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592365119551511920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a113ea40666a5ac05652815af
Content-Type: text/plain; charset="UTF-8"

Marina, Kees:

I think the combination of LKML and the LLVM developer's list is probably
too large a set of folks to have a (somewhat) lengthy exploration of
options and how to go about this and find a good path forward.

Could I suggest a smaller group of interested folks from the Kernel
community and the LLVM community connect (over email, or however else
works) to talk about this instead? I'm happy to participate and help ensure
relevant folks from the LLVM community are involved. Perhaps you can find a
good group from the Linux Kernel community?

On Wed, Feb 14, 2018 at 12:33 AM Yatsina, Marina <marina.yatsina@intel.com>
wrote:

> Hi Kees,
>
> When I raised the question of whether we want to add support for "asm
> goto" in llvm I got some feedback from the community that "asm goto" might
> not be the best solution for the problem it was invented for (optimizing
> support for tracepoints), so I stopped perusing this issue.
> I'm CC-ing the developers that participated in the original thread and a
> few developers that might be interested in adding support of "asm goto".
> I'm also adding the llvm-dev mailing list, in case there are additional
> parties interested in voicing their opinion.
>
> I hope this will give this issue a push forward and we will find a
> solution that will not prevent llvm from compiling linux kernel.
>
> Thanks,
> Marina
>
> -----Original Message-----
> From: Kees Cook [mailto:keescook@google.com]
> Sent: Wednesday, February 14, 2018 02:29
> To: David Woodhouse <dwmw2@infradead.org>; Chandler Carruth <
> chandlerc@google.com>; Yatsina, Marina <marina.yatsina@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>; X86 ML <x86@kernel.org>; LKML <
> linux-kernel@vger.kernel.org>; Alan Cox <gnomes@lxorguk.ukuu.org.uk>; Rik
> van Riel <riel@redhat.com>; Andi Kleen <ak@linux.intel.com>; Josh
> Poimboeuf <jpoimboe@redhat.com>; Tom Lendacky <thomas.lendacky@amd.com>;
> Peter Zijlstra <peterz@infradead.org>; Linus Torvalds <
> torvalds@linux-foundation.org>; Jiri Kosina <jikos@kernel.org>; Andy
> Lutomirski <luto@amacapital.net>; Hansen, Dave <dave.hansen@intel.com>;
> Tim Chen <tim.c.chen@linux.intel.com>; Greg Kroah-Hartman <
> gregkh@linux-foundation.org>; Paul Turner <pjt@google.com>; Stephen Hines
> <srhines@google.com>; Nick Desaulniers <ndesaulniers@google.com>
> Subject: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
> clang support)
>
> On Tue, Feb 13, 2018 at 4:10 PM, David Woodhouse <dwmw2@infradead.org>
> wrote:
> > We also need to resolve the asm-goto thing.
>
> Yes, this is becoming much more urgent, assuming we'll be raising the
> minimum GCC version soon and drop support for lacking asm-goto...
>
> Do you happen to know who the right people are to include to move the
> discussion forward? I know various kernel folks that are passionate about
> it, but I'm still getting to know who to talk with from llvm.
>
> I see an earlier thread here:
> http://lists.llvm.org/pipermail/llvm-dev/2017-April/111748.html
>
> It seems to end there? I'm still coming up to speed on it, so I'm likely
> missing other context.
>
> -Kees
>
> --
> Kees Cook
> Pixel Security
> ---------------------------------------------------------------------
> Intel Israel (74) Limited
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

--001a113ea40666a5ac05652815af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Marina, Kees:<div><br></div><div>I think the combination o=
f LKML and the LLVM developer&#39;s list is probably too large a set of fol=
ks to have a (somewhat) lengthy exploration of options and how to go about =
this and find a good path forward.</div><div><br></div><div>Could I suggest=
 a smaller group of interested folks from the Kernel community and the LLVM=
 community connect (over email, or however else works) to talk about this i=
nstead? I&#39;m happy to participate and help ensure relevant folks from th=
e LLVM community are involved. Perhaps you can find a good group from the L=
inux Kernel community?</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Wed, Feb 14, 2018 at 12:33 AM Yatsina, Marina &lt;<a href=3D"ma=
ilto:marina.yatsina@intel.com">marina.yatsina@intel.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi Kees,<br>
<br>
When I raised the question of whether we want to add support for &quot;asm =
goto&quot; in llvm I got some feedback from the community that &quot;asm go=
to&quot; might not be the best solution for the problem it was invented for=
 (optimizing support for tracepoints), so I stopped perusing this issue.<br=
>
I&#39;m CC-ing the developers that participated in the original thread and =
a few developers that might be interested in adding support of &quot;asm go=
to&quot;.<br>
I&#39;m also adding the llvm-dev mailing list, in case there are additional=
 parties interested in voicing their opinion.<br>
<br>
I hope this will give this issue a push forward and we will find a solution=
 that will not prevent llvm from compiling linux kernel.<br>
<br>
Thanks,<br>
Marina<br>
<br>
-----Original Message-----<br>
From: Kees Cook [mailto:<a href=3D"mailto:keescook@google.com" target=3D"_b=
lank">keescook@google.com</a>]<br>
Sent: Wednesday, February 14, 2018 02:29<br>
To: David Woodhouse &lt;<a href=3D"mailto:dwmw2@infradead.org" target=3D"_b=
lank">dwmw2@infradead.org</a>&gt;; Chandler Carruth &lt;<a href=3D"mailto:c=
handlerc@google.com" target=3D"_blank">chandlerc@google.com</a>&gt;; Yatsin=
a, Marina &lt;<a href=3D"mailto:marina.yatsina@intel.com" target=3D"_blank"=
>marina.yatsina@intel.com</a>&gt;<br>
Cc: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blan=
k">linux@roeck-us.net</a>&gt;; X86 ML &lt;<a href=3D"mailto:x86@kernel.org"=
 target=3D"_blank">x86@kernel.org</a>&gt;; LKML &lt;<a href=3D"mailto:linux=
-kernel@vger.kernel.org" target=3D"_blank">linux-kernel@vger.kernel.org</a>=
&gt;; Alan Cox &lt;<a href=3D"mailto:gnomes@lxorguk.ukuu.org.uk" target=3D"=
_blank">gnomes@lxorguk.ukuu.org.uk</a>&gt;; Rik van Riel &lt;<a href=3D"mai=
lto:riel@redhat.com" target=3D"_blank">riel@redhat.com</a>&gt;; Andi Kleen =
&lt;<a href=3D"mailto:ak@linux.intel.com" target=3D"_blank">ak@linux.intel.=
com</a>&gt;; Josh Poimboeuf &lt;<a href=3D"mailto:jpoimboe@redhat.com" targ=
et=3D"_blank">jpoimboe@redhat.com</a>&gt;; Tom Lendacky &lt;<a href=3D"mail=
to:thomas.lendacky@amd.com" target=3D"_blank">thomas.lendacky@amd.com</a>&g=
t;; Peter Zijlstra &lt;<a href=3D"mailto:peterz@infradead.org" target=3D"_b=
lank">peterz@infradead.org</a>&gt;; Linus Torvalds &lt;<a href=3D"mailto:to=
rvalds@linux-foundation.org" target=3D"_blank">torvalds@linux-foundation.or=
g</a>&gt;; Jiri Kosina &lt;<a href=3D"mailto:jikos@kernel.org" target=3D"_b=
lank">jikos@kernel.org</a>&gt;; Andy Lutomirski &lt;<a href=3D"mailto:luto@=
amacapital.net" target=3D"_blank">luto@amacapital.net</a>&gt;; Hansen, Dave=
 &lt;<a href=3D"mailto:dave.hansen@intel.com" target=3D"_blank">dave.hansen=
@intel.com</a>&gt;; Tim Chen &lt;<a href=3D"mailto:tim.c.chen@linux.intel.c=
om" target=3D"_blank">tim.c.chen@linux.intel.com</a>&gt;; Greg Kroah-Hartma=
n &lt;<a href=3D"mailto:gregkh@linux-foundation.org" target=3D"_blank">greg=
kh@linux-foundation.org</a>&gt;; Paul Turner &lt;<a href=3D"mailto:pjt@goog=
le.com" target=3D"_blank">pjt@google.com</a>&gt;; Stephen Hines &lt;<a href=
=3D"mailto:srhines@google.com" target=3D"_blank">srhines@google.com</a>&gt;=
; Nick Desaulniers &lt;<a href=3D"mailto:ndesaulniers@google.com" target=3D=
"_blank">ndesaulniers@google.com</a>&gt;<br>
Subject: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add clan=
g support)<br>
<br>
On Tue, Feb 13, 2018 at 4:10 PM, David Woodhouse &lt;<a href=3D"mailto:dwmw=
2@infradead.org" target=3D"_blank">dwmw2@infradead.org</a>&gt; wrote:<br>
&gt; We also need to resolve the asm-goto thing.<br>
<br>
Yes, this is becoming much more urgent, assuming we&#39;ll be raising the m=
inimum GCC version soon and drop support for lacking asm-goto...<br>
<br>
Do you happen to know who the right people are to include to move the discu=
ssion forward? I know various kernel folks that are passionate about it, bu=
t I&#39;m still getting to know who to talk with from llvm.<br>
<br>
I see an earlier thread here:<br>
<a href=3D"http://lists.llvm.org/pipermail/llvm-dev/2017-April/111748.html"=
 rel=3D"noreferrer" target=3D"_blank">http://lists.llvm.org/pipermail/llvm-=
dev/2017-April/111748.html</a><br>
<br>
It seems to end there? I&#39;m still coming up to speed on it, so I&#39;m l=
ikely missing other context.<br>
<br>
-Kees<br>
<br>
--<br>
Kees Cook<br>
Pixel Security<br>
---------------------------------------------------------------------<br>
Intel Israel (74) Limited<br>
<br>
This e-mail and any attachments may contain confidential material for<br>
the sole use of the intended recipient(s). Any review or distribution<br>
by others is strictly prohibited. If you are not the intended<br>
recipient, please contact the sender and delete all copies.<br>
</blockquote></div>

--001a113ea40666a5ac05652815af--
