Return-Path: <jyknight@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518622298; cv=none;
        d=google.com; s=arc-20160816;
        b=h9yAgz1afeIAo/ipzvt1f9BYtUtftxUd8/whiiOD87wD82EyfYtivXwsTcY3gOQaWB
         pIqN9Tead98Eu5r7fQDCEtChof3Fr/6lODZqnV025+7ig4FqzAJWALheeFIXiyW7kz+i
         MgQCsLDhf9v2WQNQiYvo4EjUcy8vmdl/9ie7EJ8YftNPM8lMNbga7OAoOl+44Bm2MKVq
         hGQXoTQCwHqv/AD/FtXL8rLo/H2Gu2Fdqm8b1SZGjNnLNVPgFkE5n7PwGEEF0Uo4j8Rc
         CWY++DmSTk2OkVz/fU5H+/eEr+wNzq5yMWnvOlBORgTAe2IFi2L4F+4J+rG92+tUkZNz
         +dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=n2TqC/hwqlg8u0iPkTqJHv16zZ0bubbUMYb0i8VW2Rs=;
        b=hsN69Atp3b1BW3VBozlkTrTZSou7q3hRcrPsNKOE6c8Kv/AzVS3tomOFMW4Q2h3pef
         90zizfIwqTKVwPWTBKAOF/KJVKXvRlvEI40bzKvt9EJP/gOzPR3/LzmR54l5u8PD8+ek
         UK+FnLZM6o/Ey8v0TzUHYovtHZshOU6fJ7wFXJhNEn29JVqLzv2NHTJ7caIdGgRAwOQo
         peu8+jkfHB02iErubFS2BOAY9oeMbkFUobI79ea0hZNS3jcdA3ickA+UOQF+klqPOpgE
         MqcmbxBW3jx9RzusOgyo+S18pLMnlFv+nOSzKfTJutw09BdpDF3H0ymN+N974PaCCW4S
         K6gw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E4VXTVUT;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E4VXTVUT;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x227b+LELEhZGnwHylU4j8dd3uVsWltoGqhlHcize3v1+jX8oincdKbmCjDBjiLnlpLFyUoAB8KKLXUWDAczc0cQ=
MIME-Version: 1.0
In-Reply-To: <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
From: James Y Knight <jyknight@google.com>
Date: Wed, 14 Feb 2018 10:31:36 -0500
Message-ID: <CAA2zVHqxQeZRdQtfhL-QRjqE5W94g+NU9E9Lx8RwwjDof36M_Q@mail.gmail.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
To: "Yatsina, Marina" <marina.yatsina@intel.com>
Cc: Kees Cook <keescook@google.com>, David Woodhouse <dwmw2@infradead.org>,
	Chandler Carruth <chandlerc@google.com>, "Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>, "ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>, Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>, Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592390895257869053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'd be definitely in favor having clang support asm goto. I wouldn't
want to exclude having other conversations about how to more directly
provide compiler features that the linux kernel could use, ALSO, but I
do not think that conversation should block implementing asm-goto.

IMO, inline asm is, generally, a valuable feature to provide in the
compiler as an escape hatch, and asm goto is a relatively sane
extension of it. Supporting outgoing edges from an inline asm block is
a reasonable thing for users to desire, and as far as anyone's said so
far, seems like it ought to be fairly easily implementable, without
causing bad side-effects in the compiler.

Of course, we generally do want to minimize the need for users to use
inline asm, by providing appropriate compiler support for the features
people would otherwise be forced to implement using asm. But I don't
see that as really any more important for asm-goto than any other
inline asm. There will always be a desire for escape hatches, to do
weird and unique things which aren't supported directly in the
compiler. (Also, the kernel is a pretty special case in terms of its
requirements, it seems exceedingly unlikely that we could ever provide
enough compiler support to let it eliminate inline asm.).

On Wed, Feb 14, 2018 at 3:33 AM, Yatsina, Marina
<marina.yatsina@intel.com> wrote:
>
> Hi Kees,
>
> When I raised the question of whether we want to add support for "asm got=
o" in llvm I got some feedback from the community that "asm goto" might not=
 be the best solution for the problem it was invented for (optimizing suppo=
rt for tracepoints), so I stopped perusing this issue.
> I'm CC-ing the developers that participated in the original thread and a =
few developers that might be interested in adding support of "asm goto".
> I'm also adding the llvm-dev mailing list, in case there are additional p=
arties interested in voicing their opinion.
>
> I hope this will give this issue a push forward and we will find a soluti=
on that will not prevent llvm from compiling linux kernel.
>
> Thanks,
> Marina
>
> -----Original Message-----
> From: Kees Cook [mailto:keescook@google.com]
> Sent: Wednesday, February 14, 2018 02:29
> To: David Woodhouse <dwmw2@infradead.org>; Chandler Carruth <chandlerc@go=
ogle.com>; Yatsina, Marina <marina.yatsina@intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>; X86 ML <x86@kernel.org>; LKML <li=
nux-kernel@vger.kernel.org>; Alan Cox <gnomes@lxorguk.ukuu.org.uk>; Rik van=
 Riel <riel@redhat.com>; Andi Kleen <ak@linux.intel.com>; Josh Poimboeuf <j=
poimboe@redhat.com>; Tom Lendacky <thomas.lendacky@amd.com>; Peter Zijlstra=
 <peterz@infradead.org>; Linus Torvalds <torvalds@linux-foundation.org>; Ji=
ri Kosina <jikos@kernel.org>; Andy Lutomirski <luto@amacapital.net>; Hansen=
, Dave <dave.hansen@intel.com>; Tim Chen <tim.c.chen@linux.intel.com>; Greg=
 Kroah-Hartman <gregkh@linux-foundation.org>; Paul Turner <pjt@google.com>;=
 Stephen Hines <srhines@google.com>; Nick Desaulniers <ndesaulniers@google.=
com>
> Subject: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add cl=
ang support)
>
> On Tue, Feb 13, 2018 at 4:10 PM, David Woodhouse <dwmw2@infradead.org> wr=
ote:
> > We also need to resolve the asm-goto thing.
>
> Yes, this is becoming much more urgent, assuming we'll be raising the min=
imum GCC version soon and drop support for lacking asm-goto...
>
> Do you happen to know who the right people are to include to move the dis=
cussion forward? I know various kernel folks that are passionate about it, =
but I'm still getting to know who to talk with from llvm.
>
> I see an earlier thread here:
> http://lists.llvm.org/pipermail/llvm-dev/2017-April/111748.html
>
> It seems to end there? I'm still coming up to speed on it, so I'm likely =
missing other context.
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
