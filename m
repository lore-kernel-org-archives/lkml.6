Return-Path: <jyknight@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522968717; cv=none;
        d=google.com; s=arc-20160816;
        b=RJsE1B8VH5EMdCXLR/M1hhcKqp+UDEJr8eHbjlKi85gBHoujPAKZLu+P2M6R0J1OYa
         s89jP/ONwQMrkCnJvDW7vE5CKECc7eOMPltwHDGYlMXfY3T+RV1xKa8gW35ow8/tr3wd
         tGXUFTEFFFmpP74irHlU26rWTHxVmBfG264IXWEtaedDpYzZaNXPPbNkRkIxeVv02vke
         07bLFKQuZrnwGQPgTDKI3MGK7Q/ywLCx5dMJM9qQ0t9SY/qkXYyYWOkXPWwXyyFigu5n
         khdM/zuNpS683hO6jTkOVRIKTXr1SbBySvZDXnkG7uYqdi3MdE9dVOI27hirNBkYYJ+r
         xsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=qE1M6AmQFjgNABMwGC/loA+R5NiFaqYwjUR90uESRFY=;
        b=uzvqfxaFjhsBmM42Nm+LhxHDp/iK0cGuuQKVs2GY6uvcGP9BxYLwnKlDstqAAQ/z3H
         tvj7lg4on2mcMGvzD20dizjYZOe9/zDe7hKfBOvcdiEAmoE4NcFssKjhNbMp1MxWcZWr
         Rt1Sku7TxH74aL86qaE1qcgQ5qeOVk2MIBlyPOaGTUPmtWgXTmc6S8VFeZGiAzU66EXP
         SWR5Tkw15ySDIJO6tLqU7fA/gwdqbnxsTvXpLL4al1tboxYoiWieI1hlVpjBMwEncTS+
         kPFlt7fxrznw4dLihRR9TwlzJNANlrXkFf0qYolVeyesNprPPPoidJP75YCW40+rIRrM
         GW3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ebf/xPa+;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ebf/xPa+;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49biKa2CuwnKUy5dZssRs/u4gWBocgVyl6iW5yXascXSGUsJW47qhcTnnnaQJ43sfo9eFfIUBCxXcgsYdDkfJo=
MIME-Version: 1.0
References: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <20180405072017.GN4043@hirez.programming.kicks-ass.net>
 <CAA2zVHraWtmmW1yFvVH+kUbih5wxiDLuM=wArnQanrWN9NF=Xw@mail.gmail.com>
 <CA+55aFwrZU-VPa9HShikNDkvuOvFXtO2vw8sDeRRTCU_hV7dWA@mail.gmail.com>
 <CAA2zVHrF+teb3SwigH_sDqkWfKDg4itq4TkefYXUXw2RF9+4qw@mail.gmail.com> <CA+55aFz3PUE1mSM+yFeb55ca3EZAYHHqTyHjktiW1FVfK-tP9A@mail.gmail.com>
In-Reply-To: <CA+55aFz3PUE1mSM+yFeb55ca3EZAYHHqTyHjktiW1FVfK-tP9A@mail.gmail.com>
From: James Y Knight <jyknight@google.com>
Date: Thu, 05 Apr 2018 22:51:30 +0000
Message-ID: <CAA2zVHohAdM3v4WVsePPbCB1iC6OFOW9=Pxiqe=YYUTkxUNcwQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mka@chromium.org, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596948445856847518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 5:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And btw, I hate how stupid gcc is about "constant size arrays but acts
> as a VLA because it wasn't an integer-constant-expression size"
> things.

> Your code generation example really is a sad sad example of it. A good
> optimizer should have generated the same code even if the stupid array
> again syntactically was VLA, because it damn well isn't in reality.

Unfortunately, that behavior is required by the standard, it's not up to
compiler optimization to change. Note that the optimizer in my example
_did_ determine that the VLA had a constant size, and generated
constant-size stack adjustment code. And it knew the result of the
sizeof(), and put the value "4" straight into the return register. The only
difference in the codegen from a non-VLA is the difference which was
required by the language standard -- the useless call to "function".

Note that the return value of the call is unused. And in fact, there is
literally no reason for the expression in "sizeof(expression)" to ever be
evaluated -- the result of the evaluation can _never_ be used! And, yet,
the C99 standard requires that it is evaluated, regardless, when the
resulting type of the expression is a VLA type. I have no idea why....

 From C99 6.5.3.4 "The sizeof operator", paragraph 2:
"""
    The sizeof operator yields the size (in bytes) of its operand, which may
be an expression or the parenthesized name of a type. The size is
determined from the type of the operand. The result is an integer. If the
type of the operand is a variable length array type, the operand is
evaluated; otherwise, the operand is not evaluated and the result is an
integer constant.
"""

(C11 says the same thing.)
