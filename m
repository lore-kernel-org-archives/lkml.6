Return-Path: <marina.yatsina@intel.com>
X-Google-Smtp-Source: AH8x226/DilbcCwrvKuIqMRTgFPxMk8yRcbAN1BR3zJ3oRE27fWISyEZj3ZJo+U+zJ63koFh9KqO
ARC-Seal: i=1; a=rsa-sha256; t=1518603061; cv=none;
        d=google.com; s=arc-20160816;
        b=GyRy2u1rBUdbryOYOpLJi3oLGuBloFIjlMcq2/GBQZHd2gKDEmQqk4q+JinAp0yMH1
         s9Ue2ZoeHJp4VJ5mnRAkeQMZOYRK3nRsSozH+BQj/fzofiAYquxWHk32Duuml+QC4XMn
         F86ohs39dpuk5DepyxkXj3sipNOYeNiLE5kWU0JbnJ1Qpnr+9HGqcTJC2MKZfH1XltIE
         S4tFNXuP1gXAgBmb1nch4E6Q+nmsODGJa6EQVdc78SlYz0BXAM6lpW2Rxeh9tgY9FPNa
         +UogNSRzfbS+w+irdlEPNWRmskLfozsUvrrVvupIjhUDuEZ1kZH1i8eMCQ0gdc/W0rcG
         Nq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=95L/EWeHy1ZOe/5nzg0XRh4xKhMYRznp1CXqRbp1abM=;
        b=vbsMaZeZoW0LV/ofd4k/jEmJA8aB9EXRzhCBdlZwnlEAYClSp2XMI5osPqK3hbYLCt
         cI68iswb0HDjaZQssBhrpQJm9ejZCXeiI09APRxhr8vqkUqVhGOneRkVWn9V/WJXMke2
         I6zLXF13FeboSIzZad8th/zrDM9QT+fJBGBKq+xpvaJlaxbRYEBhUQHBc89bpYvs/7sb
         PJ+98nY7jKnsIeMxkmRyqsC5hN8sUw0HNDLDLoi0etT8ja9vac4kwMkMkNqmnEZtHNVi
         3kVb2aM47Wpnradgojy/4mTPR+3heP88kqNWZ78LUtNrj2w+KmtLkQeY40kQAxYCc7T0
         Mnkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marina.yatsina@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=marina.yatsina@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marina.yatsina@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=marina.yatsina@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="34591952"
From: "Yatsina, Marina" <marina.yatsina@intel.com>
To: Greg Kroah-Hartman <gregkh@linux-foundation.org>, Chandler Carruth
	<chandlerc@google.com>
CC: Kees Cook <keescook@google.com>, David Woodhouse <dwmw2@infradead.org>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>, "Grischenko, Andrei L"
	<andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>, "LLVM
 Developers" <llvm-dev@lists.llvm.org>, "ehsan@mozilla.com"
	<ehsan@mozilla.com>, "Tayree, Coby" <coby.tayree@intel.com>, Matthias Braun
	<matze@braunis.de>, Dean Michael Berris <dean.berris@gmail.com>, "James Y
 Knight" <jyknight@google.com>, Guenter Roeck <linux@roeck-us.net>, X86 ML
	<x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox
	<gnomes@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>, Andi Kleen
	<ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Peter Zijlstra <peterz@infradead.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>, "Hansen, Dave"
	<dave.hansen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Paul Turner
	<pjt@google.com>, Stephen Hines <srhines@google.com>, Nick Desaulniers
	<ndesaulniers@google.com>
Subject: RE: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Thread-Topic: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Thread-Index: AQHTpSrRc0Tf36QxBkW6ZxMIE0y/9aOjiI5w///q3ICAABP0AIAAIjUA
Date: Wed, 14 Feb 2018 10:07:43 +0000
Message-ID: <A3D6595E4CE1DA4A80538CC077C51A2B84771946@hasmsx107.ger.corp.intel.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <CAGCO0Kj01tAXdzRrL_p+LrTLK6-k-1-BFPm97jQMuJSPH7PTJQ@mail.gmail.com>
 <20180214095308.GA16956@kroah.com>
In-Reply-To: <20180214095308.GA16956@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjg4NTU0ZDAtOTA5Ny00Njg5LWJhYjMtMGRjNzUzNDIwYzRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJGb1NzMU1raDNTYWZrejFybzlRTkF5b1kyQUpSVjJMYTFjZkJGQzhPUGowQkNEUFwvRDRhNFJqN2hFblhKVndodCJ9
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
X-GMAIL-MSGID: =?utf-8?q?1592370724326040649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I believe we do have the infrastructure in llvm to implement a working patc=
h.
The "asm goto" was introduced as a solution to a problem (optimizing tracep=
oints/ nop patching).
When we started the discussion in llvm about adding this feature, questions=
 arose if we can design a better solution for this problem than "asm goto".

You can find a more about the discussion in the llvm community here:
http://lists.llvm.org/pipermail/llvm-dev/2017-April/111748.html

* This is the middle of the thread, and there are more messages later on.

Thanks,
Marina

-----Original Message-----
From: Greg Kroah-Hartman [mailto:gregkh@linux-foundation.org] =

Sent: Wednesday, February 14, 2018 11:53
To: Chandler Carruth <chandlerc@google.com>
Cc: Yatsina, Marina <marina.yatsina@intel.com>; Kees Cook <keescook@google.=
com>; David Woodhouse <dwmw2@infradead.org>; Kreitzer, David L <david.l.kre=
itzer@intel.com>; Grischenko, Andrei L <andrei.l.grischenko@intel.com>; rnk=
@google.com; LLVM Developers <llvm-dev@lists.llvm.org>; ehsan@mozilla.com; =
Tayree, Coby <coby.tayree@intel.com>; Matthias Braun <matze@braunis.de>; De=
an Michael Berris <dean.berris@gmail.com>; James Y Knight <jyknight@google.=
com>; Guenter Roeck <linux@roeck-us.net>; X86 ML <x86@kernel.org>; LKML <li=
nux-kernel@vger.kernel.org>; Alan Cox <gnomes@lxorguk.ukuu.org.uk>; Rik van=
 Riel <riel@redhat.com>; Andi Kleen <ak@linux.intel.com>; Josh Poimboeuf <j=
poimboe@redhat.com>; Tom Lendacky <thomas.lendacky@amd.com>; Peter Zijlstra=
 <peterz@infradead.org>; Linus Torvalds <torvalds@linux-foundation.org>; Ji=
ri Kosina <jikos@kernel.org>; Andy Lutomirski <luto@amacapital.net>; Hansen=
, Dave <dave.hansen@intel.com>; Tim Chen <tim.c.chen@linux.intel.com>; Paul=
 Turner <pjt@google.com>; Stephen Hines <srhines@google.com>; Nick Desaulni=
ers <ndesaulniers@google.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add =
clang support)

On Wed, Feb 14, 2018 at 08:41:43AM +0000, Chandler Carruth wrote:
> Marina, Kees:
> =

> I think the combination of LKML and the LLVM developer's list is =

> probably too large a set of folks to have a (somewhat) lengthy =

> exploration of options and how to go about this and find a good path forw=
ard.

Why is there any need to discuss "options" here?  What is preventing the im=
plementation of "asm goto" in llvm?  Is it the lack of a working patch, or =
something else?

thanks,

greg k-h
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
