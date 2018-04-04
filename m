Return-Path: <ndesaulniers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522860843; cv=none;
        d=google.com; s=arc-20160816;
        b=BsgyNS7QBCKpJT2GCqGPbIVi0Ah+zKHcL094jgTee6rUQmzXRXBBLhQW6HX15gs4Xc
         PBkhRzd3qc64nGjH02hsiIHqeVa5EzwRdCSw7bYtihOOgvM2o8CsNROHGiHK8rfrRtji
         t4xNooSlYhkqAZ7N/trIvfO9r4cbR0hFUzKInl6Zdk1QcSAdebgYn/0UF3V2uGF0az7A
         HS2Fs4faqM8Wil4/lBPb3lavSx3kw+oJ4LikNZiX8vN5kIH2cKXSxWZ/1d6eyz89aeJu
         IuS4CqQ8yccMc+vUyc3+WWDPql43cD0V0wbKAaJQwuEVOgoK0YEwuSGG44ck2tNGlUwh
         ElQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=q6g8+gS9hkGxO5S3hqh+RkyeYEYTG2JqBKvhicSbeiM=;
        b=oEZ0Q3uCTs0WwfldgC3pHZjU6fgfBKUEqXx4ktlCpU+4r4IPGp58LB/Pl826pDA0dS
         LT8//rTz9QMgsrVq7sNaeAyqR/VYvWIQ5VsKHwo/ppotwlI34q3UhkiDRw8d7RlEMcsc
         3FkqRKptgT6xPBTZ+KEwKBuTaes2WYSHsRIaVrseQtdyvDVCOPA7FloSYEUV7Bf/PeAc
         Sh8jeTMaoLlL3YCh9Cty7em44SQXSi2N215afqMIuU4GXfmptcj4I+QvBz1fTjNbQFuv
         Is804cEZevaLaAKSdYNPMMQ4JPGzKfTCwfUKnGrEtpbgX9cyuOkmX+hZcvyimFbGn5Db
         BBUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kayWLYte;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kayWLYte;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48E98nhRlU+WGIm5G3b/uMTiqGJR+y63nVwEzJdoiovMiRYxa8/IJBe9phkdo0DKvieJfKbdDxfC3Fcm3CJhSA=
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com>
In-Reply-To: <20180404093823.GC25996@kroah.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 04 Apr 2018 16:53:52 +0000
Message-ID: <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596835332312130407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(re-sending as plain text)

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

> So please, work on fixing up clang for asm-goto and other "features"
> that the kernel requires, and maybe when all build options/configs are
> really solid and working well, will we be able to properly consider it
> as a reason to implement, or not implement, something in the kernel
> source.

Acknowledged.
-- 
Thanks,
~Nick Desaulniers
