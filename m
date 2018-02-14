Return-Path: <chandlerc@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518603487; cv=none;
        d=google.com; s=arc-20160816;
        b=RSajUKhpMkUOnGAfhPhXpzzYdZhtfBBF7CiJFVo3PwMoFyktoCRcWnm+ipTHmzMVJj
         Tre2lgNZdKXCBoH2KqoE0U22/tTK1o5T/UT6xspEKOzRk7lr2XNkwJnfncqv0eVXwT46
         yClBQANd9jUuJlV1ZrYds4Adg6T0UQHJpJvpvM39rp8yrV/K86x0vHZVKMU2tSHVDIr6
         Bb55jzZq9gRBC0HtRZywW+jDtsJV25M497jSr/2WISdUS/h6NzktOpwYxS8XyDdNHmIM
         1EmRqRHt8SsQB7ffAN4vCn2Ax1adRSesfrZoYdCILUMA5qAGk0XQfwz44dwken9ie6h4
         Jv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ZkKJcUXZ4RihIhXmdbkGXooNwaD4htNoLko7F+AFCR0=;
        b=LEZ8rg5oBwr+DLuU8g6puyTgclO9ON2h9ZlER580qwPUAOuMlvuiA8WUeQNGMtBaxg
         bQ2J4fpHbT8bt1okuFQl+2uTlebdJEBZjbf8Eg3GeXbbBm34Wt4Yil7sc+ZpTJ2wKONC
         F+OkKPRNsTg6AYgNFf1bhPl7DGuwY9hL4pkrz63OkDR5bIGfDJgBCrSkTFxk36KrhDMf
         c61ywfDqjTGV3f1I6JDAVy3jAlKZlOgZnfshlmzfe9548BqOEOxfhAnw2lbwRsS/GUVM
         TXmhGaxBoUOU9Y7lA2GUUkxYDg+RvpS8cxrZWul+dYmCBESNu/D7NDjuHPiq5wx0KgUD
         oMAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Xq200BSA;
       spf=pass (google.com: domain of chandlerc@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chandlerc@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Xq200BSA;
       spf=pass (google.com: domain of chandlerc@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=chandlerc@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x2247B1P9WIcAcfNU7sPVl1HKTVk1kYK6Xn6BtfEAH4JJDr/Y8qMuGqdtjHjM78j4Fo4ab5n0i/KqFEy5poX3dRs=
MIME-Version: 1.0
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <CAGCO0Kj01tAXdzRrL_p+LrTLK6-k-1-BFPm97jQMuJSPH7PTJQ@mail.gmail.com>
 <20180214095308.GA16956@kroah.com> <A3D6595E4CE1DA4A80538CC077C51A2B84771946@hasmsx107.ger.corp.intel.com>
In-Reply-To: <A3D6595E4CE1DA4A80538CC077C51A2B84771946@hasmsx107.ger.corp.intel.com>
From: Chandler Carruth <chandlerc@google.com>
Date: Wed, 14 Feb 2018 10:17:53 +0000
Message-ID: <CAGCO0Ki4FDQDqSdDiQtsNf3b3haV5kE59MS5aN29yi3yPAqYfQ@mail.gmail.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
To: "Yatsina, Marina" <marina.yatsina@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>, Kees Cook <keescook@google.com>,
	David Woodhouse <dwmw2@infradead.org>, "Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>,
	"ehsan@mozilla.com" <ehsan@mozilla.com>, "Tayree, Coby" <coby.tayree@intel.com>,
	Matthias Braun <matze@braunis.de>, Dean Michael Berris <dean.berris@gmail.com>,
	James Y Knight <jyknight@google.com>, Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	Paul Turner <pjt@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: multipart/alternative; boundary="001a114d78445cc9d30565296db5"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592371170282648396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114d78445cc9d30565296db5
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 14, 2018 at 2:11 AM Yatsina, Marina <marina.yatsina@intel.com>
wrote:

> I believe we do have the infrastructure in llvm to implement a working
> patch.
> The "asm goto" was introduced as a solution to a problem (optimizing
> tracepoints/ nop patching).
> When we started the discussion in llvm about adding this feature,
> questions arose if we can design a better solution for this problem than
> "asm goto".
>
> You can find a more about the discussion in the llvm community here:
> http://lists.llvm.org/pipermail/llvm-dev/2017-April/111748.html
>
> * This is the middle of the thread, and there are more messages later on.
>

FWIW, there is very strong interest in the LLVM community in working on a
feature along the lines of what John McCall suggested (as a significant
improvement to my initial idea) later in the thread:
http://lists.llvm.org/pipermail/llvm-dev/2017-April/111755.html

If this feature as-is or with additions / suggestions / improvements would
address the kernel's needs, we're all over it.

I think the concerns are already in that thread...

But as I said in my original email, if a different approach is needed I'm
happy to try and get folks to understand what would be needed and where a
reasonable compromise is...


>
> Thanks,
> Marina
>
> -----Original Message-----
> From: Greg Kroah-Hartman [mailto:gregkh@linux-foundation.org]
> Sent: Wednesday, February 14, 2018 11:53
> To: Chandler Carruth <chandlerc@google.com>
> Cc: Yatsina, Marina <marina.yatsina@intel.com>; Kees Cook <
> keescook@google.com>; David Woodhouse <dwmw2@infradead.org>; Kreitzer,
> David L <david.l.kreitzer@intel.com>; Grischenko, Andrei L <
> andrei.l.grischenko@intel.com>; rnk@google.com; LLVM Developers <
> llvm-dev@lists.llvm.org>; ehsan@mozilla.com; Tayree, Coby <
> coby.tayree@intel.com>; Matthias Braun <matze@braunis.de>; Dean Michael
> Berris <dean.berris@gmail.com>; James Y Knight <jyknight@google.com>;
> Guenter Roeck <linux@roeck-us.net>; X86 ML <x86@kernel.org>; LKML <
> linux-kernel@vger.kernel.org>; Alan Cox <gnomes@lxorguk.ukuu.org.uk>; Rik
> van Riel <riel@redhat.com>; Andi Kleen <ak@linux.intel.com>; Josh
> Poimboeuf <jpoimboe@redhat.com>; Tom Lendacky <thomas.lendacky@amd.com>;
> Peter Zijlstra <peterz@infradead.org>; Linus Torvalds <
> torvalds@linux-foundation.org>; Jiri Kosina <jikos@kernel.org>; Andy
> Lutomirski <luto@amacapital.net>; Hansen, Dave <dave.hansen@intel.com>;
> Tim Chen <tim.c.chen@linux.intel.com>; Paul Turner <pjt@google.com>;
> Stephen Hines <srhines@google.com>; Nick Desaulniers <
> ndesaulniers@google.com>
> Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
> clang support)
>
> On Wed, Feb 14, 2018 at 08:41:43AM +0000, Chandler Carruth wrote:
> > Marina, Kees:
> >
> > I think the combination of LKML and the LLVM developer's list is
> > probably too large a set of folks to have a (somewhat) lengthy
> > exploration of options and how to go about this and find a good path
> forward.
>
> Why is there any need to discuss "options" here?  What is preventing the
> implementation of "asm goto" in llvm?  Is it the lack of a working patch,
> or something else?
>
> thanks,
>
> greg k-h
> ---------------------------------------------------------------------
> Intel Israel (74) Limited
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
>

--001a114d78445cc9d30565296db5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Feb 14=
, 2018 at 2:11 AM Yatsina, Marina &lt;<a href=3D"mailto:marina.yatsina@inte=
l.com">marina.yatsina@intel.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">I believe we do have the infrastructure in llvm to implement =
a working patch.<br>
The &quot;asm goto&quot; was introduced as a solution to a problem (optimiz=
ing tracepoints/ nop patching).<br>
When we started the discussion in llvm about adding this feature, questions=
 arose if we can design a better solution for this problem than &quot;asm g=
oto&quot;.<br>
<br>
You can find a more about the discussion in the llvm community here:<br>
<a href=3D"http://lists.llvm.org/pipermail/llvm-dev/2017-April/111748.html"=
 rel=3D"noreferrer" target=3D"_blank">http://lists.llvm.org/pipermail/llvm-=
dev/2017-April/111748.html</a><br>
<br>
* This is the middle of the thread, and there are more messages later on.<b=
r></blockquote><div><br></div><div>FWIW, there is very strong interest in t=
he LLVM community in working on a feature along the lines of what John McCa=
ll suggested (as a significant improvement to my initial idea) later in the=
 thread:</div><div><a href=3D"http://lists.llvm.org/pipermail/llvm-dev/2017=
-April/111755.html">http://lists.llvm.org/pipermail/llvm-dev/2017-April/111=
755.html</a>=C2=A0<br></div><div><br></div><div>If this feature as-is or wi=
th additions / suggestions / improvements would address the kernel&#39;s ne=
eds, we&#39;re all over it.</div><div><br></div><div>I think the concerns a=
re already in that thread...</div><div><br></div><div>But as I said in my o=
riginal email, if a different approach is needed I&#39;m happy to try and g=
et folks to understand what would be needed and where a reasonable compromi=
se is...</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
Marina<br>
<br>
-----Original Message-----<br>
From: Greg Kroah-Hartman [mailto:<a href=3D"mailto:gregkh@linux-foundation.=
org" target=3D"_blank">gregkh@linux-foundation.org</a>]<br>
Sent: Wednesday, February 14, 2018 11:53<br>
To: Chandler Carruth &lt;<a href=3D"mailto:chandlerc@google.com" target=3D"=
_blank">chandlerc@google.com</a>&gt;<br>
Cc: Yatsina, Marina &lt;<a href=3D"mailto:marina.yatsina@intel.com" target=
=3D"_blank">marina.yatsina@intel.com</a>&gt;; Kees Cook &lt;<a href=3D"mail=
to:keescook@google.com" target=3D"_blank">keescook@google.com</a>&gt;; Davi=
d Woodhouse &lt;<a href=3D"mailto:dwmw2@infradead.org" target=3D"_blank">dw=
mw2@infradead.org</a>&gt;; Kreitzer, David L &lt;<a href=3D"mailto:david.l.=
kreitzer@intel.com" target=3D"_blank">david.l.kreitzer@intel.com</a>&gt;; G=
rischenko, Andrei L &lt;<a href=3D"mailto:andrei.l.grischenko@intel.com" ta=
rget=3D"_blank">andrei.l.grischenko@intel.com</a>&gt;; <a href=3D"mailto:rn=
k@google.com" target=3D"_blank">rnk@google.com</a>; LLVM Developers &lt;<a =
href=3D"mailto:llvm-dev@lists.llvm.org" target=3D"_blank">llvm-dev@lists.ll=
vm.org</a>&gt;; <a href=3D"mailto:ehsan@mozilla.com" target=3D"_blank">ehsa=
n@mozilla.com</a>; Tayree, Coby &lt;<a href=3D"mailto:coby.tayree@intel.com=
" target=3D"_blank">coby.tayree@intel.com</a>&gt;; Matthias Braun &lt;<a hr=
ef=3D"mailto:matze@braunis.de" target=3D"_blank">matze@braunis.de</a>&gt;; =
Dean Michael Berris &lt;<a href=3D"mailto:dean.berris@gmail.com" target=3D"=
_blank">dean.berris@gmail.com</a>&gt;; James Y Knight &lt;<a href=3D"mailto=
:jyknight@google.com" target=3D"_blank">jyknight@google.com</a>&gt;; Guente=
r Roeck &lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@r=
oeck-us.net</a>&gt;; X86 ML &lt;<a href=3D"mailto:x86@kernel.org" target=3D=
"_blank">x86@kernel.org</a>&gt;; LKML &lt;<a href=3D"mailto:linux-kernel@vg=
er.kernel.org" target=3D"_blank">linux-kernel@vger.kernel.org</a>&gt;; Alan=
 Cox &lt;<a href=3D"mailto:gnomes@lxorguk.ukuu.org.uk" target=3D"_blank">gn=
omes@lxorguk.ukuu.org.uk</a>&gt;; Rik van Riel &lt;<a href=3D"mailto:riel@r=
edhat.com" target=3D"_blank">riel@redhat.com</a>&gt;; Andi Kleen &lt;<a hre=
f=3D"mailto:ak@linux.intel.com" target=3D"_blank">ak@linux.intel.com</a>&gt=
;; Josh Poimboeuf &lt;<a href=3D"mailto:jpoimboe@redhat.com" target=3D"_bla=
nk">jpoimboe@redhat.com</a>&gt;; Tom Lendacky &lt;<a href=3D"mailto:thomas.=
lendacky@amd.com" target=3D"_blank">thomas.lendacky@amd.com</a>&gt;; Peter =
Zijlstra &lt;<a href=3D"mailto:peterz@infradead.org" target=3D"_blank">pete=
rz@infradead.org</a>&gt;; Linus Torvalds &lt;<a href=3D"mailto:torvalds@lin=
ux-foundation.org" target=3D"_blank">torvalds@linux-foundation.org</a>&gt;;=
 Jiri Kosina &lt;<a href=3D"mailto:jikos@kernel.org" target=3D"_blank">jiko=
s@kernel.org</a>&gt;; Andy Lutomirski &lt;<a href=3D"mailto:luto@amacapital=
.net" target=3D"_blank">luto@amacapital.net</a>&gt;; Hansen, Dave &lt;<a hr=
ef=3D"mailto:dave.hansen@intel.com" target=3D"_blank">dave.hansen@intel.com=
</a>&gt;; Tim Chen &lt;<a href=3D"mailto:tim.c.chen@linux.intel.com" target=
=3D"_blank">tim.c.chen@linux.intel.com</a>&gt;; Paul Turner &lt;<a href=3D"=
mailto:pjt@google.com" target=3D"_blank">pjt@google.com</a>&gt;; Stephen Hi=
nes &lt;<a href=3D"mailto:srhines@google.com" target=3D"_blank">srhines@goo=
gle.com</a>&gt;; Nick Desaulniers &lt;<a href=3D"mailto:ndesaulniers@google=
.com" target=3D"_blank">ndesaulniers@google.com</a>&gt;<br>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add =
clang support)<br>
<br>
On Wed, Feb 14, 2018 at 08:41:43AM +0000, Chandler Carruth wrote:<br>
&gt; Marina, Kees:<br>
&gt;<br>
&gt; I think the combination of LKML and the LLVM developer&#39;s list is<b=
r>
&gt; probably too large a set of folks to have a (somewhat) lengthy<br>
&gt; exploration of options and how to go about this and find a good path f=
orward.<br>
<br>
Why is there any need to discuss &quot;options&quot; here?=C2=A0 What is pr=
eventing the implementation of &quot;asm goto&quot; in llvm?=C2=A0 Is it th=
e lack of a working patch, or something else?<br>
<br>
thanks,<br>
<br>
greg k-h<br>
---------------------------------------------------------------------<br>
Intel Israel (74) Limited<br>
<br>
This e-mail and any attachments may contain confidential material for<br>
the sole use of the intended recipient(s). Any review or distribution<br>
by others is strictly prohibited. If you are not the intended<br>
recipient, please contact the sender and delete all copies.<br>
<br>
</blockquote></div></div>

--001a114d78445cc9d30565296db5--
