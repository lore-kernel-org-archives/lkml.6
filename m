Return-Path: <marina.yatsina@intel.com>
X-Google-Smtp-Source: AH8x225Fb9dabayk+aIED9eYNiDkIzVfglMw0n5qC7heHaiE0hiny8ajk1t7EuAY+LWhikb0x4Q4
ARC-Seal: i=1; a=rsa-sha256; t=1518601987; cv=none;
        d=google.com; s=arc-20160816;
        b=DVlKmezpBrCWG7ek6PqUtzytJfAETyspOeNudvvO6m5Yf7su6kNKN/supq0GHT0Hey
         Xd/+EadeIu+cmppER6m6FWePziqFY8MNdSRHaIsGg7wEuLh5uESNnt3by1JXnVHneQ7e
         fCVXf+UbuDrIykzx4F+8lgEnu/rXqcQglXg0nGfs/9fSHY2HmPWoqNFVldoq2mTKH9mQ
         PYYVF7XbRchmuIkm8ScdhTtKj1ZKWiOyAMMn/rbGBkIrvN1uPaj9aDvgIEcJCUncqlYL
         qYmp25awEWEOrHBZ75q0tjAhVxzKyRcGB52HrDCl4K5JOl/N8ksl/txL3kE6dix8sfmm
         yOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=svaSGqEBBSLEuX7eV/o9swTP4e9YNxfssaIdKhXfJG8=;
        b=arDJTyZvbZuF/inOQYfDP8PSluNQYy/jDt/PxRFPvNhpzMZh3XSTWgwCJUZb+uSUb8
         SAlan7aiHoP7FujGXPT6ahlyyAQgYqnL+f23FOSbgEkifwbulrmFNyv+moBnG5UnI1/e
         ma1A2yPrM8WKszDUlq7McKQqUUIGUyQX2JA1NY8dblzFVvrUqhdrFeueubvWnvu7rU9Z
         BOhgey0z/BdMpHHGhpxxMqq1IlIux7Ga/uwNdBXeWMWQsduz65P27RQRz3oeXR8XqiSK
         qBAf/2NUfSdWRmOHFzVNw1icutSLm0GwOJPBLnUKSheb9UpF3N/g3/HDX7vjJnH3VtL5
         tHxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marina.yatsina@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=marina.yatsina@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marina.yatsina@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=marina.yatsina@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="18011999"
From: "Yatsina, Marina" <marina.yatsina@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Kees Cook <keescook@google.com>, David Woodhouse <dwmw2@infradead.org>,
	Chandler Carruth <chandlerc@google.com>, "Kreitzer, David L"
	<david.l.kreitzer@intel.com>, "Grischenko, Andrei L"
	<andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>, "LLVM
 Developers" <llvm-dev@lists.llvm.org>, "ehsan@mozilla.com"
	<ehsan@mozilla.com>, "Tayree, Coby" <coby.tayree@intel.com>, Matthias Braun
	<matze@braunis.de>, Dean Michael Berris <dean.berris@gmail.com>, "James Y
 Knight" <jyknight@google.com>, Guenter Roeck <linux@roeck-us.net>, X86 ML
	<x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox
	<gnomes@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>, Andi Kleen
	<ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>, Stephen Hines
	<srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Thread-Topic: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Thread-Index: AQHTpSrRc0Tf36QxBkW6ZxMIE0y/9aOjiI5w///ycYCAACPfIA==
Date: Wed, 14 Feb 2018 09:52:59 +0000
Message-ID: <A3D6595E4CE1DA4A80538CC077C51A2B84771900@hasmsx107.ger.corp.intel.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <20180214090851.GU25181@hirez.programming.kicks-ass.net>
In-Reply-To: <20180214090851.GU25181@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2Q5ZjUwNzItNzU2ZS00OTZlLThhNzMtMjhhZTNkMjcwNGZjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiIwZm1jT2RxR05RUU9YbHRxQ1NvTjVibnU0U1VTZmVnSWg2bVQwazhFeG5ZTDVcLzJQWklPYVFxS0E3YnNQNlFKVSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.185.126.126]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592369597630464156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Peter,

When I started the original thread last year I was in favor of adding "asm =
goto" and didn't understand why it wasn't done by that time.
The feedback I got is that this feature (optimizing tracepoints) is very us=
eful and that we do want it in llvm, but perhaps there's a cleaner way of i=
mplementing than "asm goto". An alternative suggestion arose as well. =


I'm sure you can provide a lot of background for the decisions of why "asm =
goto" was chosen and which other alternatives were considered, as you were =
the one to implement this. This may shed a lot of light on the alternative =
suggestions that arose in my thread in the llvm community.
I think that including GCC folks in the "small team" discussion Chandler su=
ggested might be a very good idea, so if you have some contacts, please sen=
d them to Chandler.

Anyway, I think we should consider the alternatives and not take "asm goto"=
 as a given, even though this is the implementation of this feature for the=
 past 7 years and it works well.
I'm not saying linux kernel needs to rush and adopt an alternative solution=
 ASAP, but we cannot ignore that it exists and may (or may not) be the dire=
ction of the future (for both gcc and llvm).

Thanks,
Marina

-----Original Message-----
From: Peter Zijlstra [mailto:peterz@infradead.org] =

Sent: Wednesday, February 14, 2018 11:09
To: Yatsina, Marina <marina.yatsina@intel.com>
Cc: Kees Cook <keescook@google.com>; David Woodhouse <dwmw2@infradead.org>;=
 Chandler Carruth <chandlerc@google.com>; Kreitzer, David L <david.l.kreitz=
er@intel.com>; Grischenko, Andrei L <andrei.l.grischenko@intel.com>; rnk@go=
ogle.com; LLVM Developers <llvm-dev@lists.llvm.org>; ehsan@mozilla.com; Tay=
ree, Coby <coby.tayree@intel.com>; Matthias Braun <matze@braunis.de>; Dean =
Michael Berris <dean.berris@gmail.com>; James Y Knight <jyknight@google.com=
>; Guenter Roeck <linux@roeck-us.net>; X86 ML <x86@kernel.org>; LKML <linux=
-kernel@vger.kernel.org>; Alan Cox <gnomes@lxorguk.ukuu.org.uk>; Rik van Ri=
el <riel@redhat.com>; Andi Kleen <ak@linux.intel.com>; Josh Poimboeuf <jpoi=
mboe@redhat.com>; Tom Lendacky <thomas.lendacky@amd.com>; Linus Torvalds <t=
orvalds@linux-foundation.org>; Jiri Kosina <jikos@kernel.org>; Andy Lutomir=
ski <luto@amacapital.net>; Hansen, Dave <dave.hansen@intel.com>; Tim Chen <=
tim.c.chen@linux.intel.com>; Greg Kroah-Hartman <gregkh@linux-foundation.or=
g>; Paul Turner <pjt@google.com>; Stephen Hines <srhines@google.com>; Nick =
Desaulniers <ndesaulniers@google.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add =
clang support)

On Wed, Feb 14, 2018 at 08:33:39AM +0000, Yatsina, Marina wrote:
> I hope this will give this issue a push forward and we will find a =

> solution that will not prevent llvm from compiling linux kernel.

That solution is asm-goto. We (linux kernel) are not going to support somet=
hing like it. It's going to be asm-goto or bust. The feature is over 7 year=
s old by now, deal with it.

If you ever get to the point where it makes sense to build a kernel with LL=
VM, then you can bike-shed with the GCC team on new features, until then to=
ugh luck.
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
