Return-Path: <ndesaulniers@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522883469; cv=none;
        d=google.com; s=arc-20160816;
        b=U/ueKl4km134+Rk4Xi00ktheLy42J2NhK175Cd/NKHbiaEAGuJaGOMCh2ReNo4ag/k
         rkpdzNXZSjnO1BFRWvaP6GwFjknABkH5jLnJbxfjqV7qZIacRAxSB8/DGwN6+u+kC53C
         zkopH0BzcTVc9kTUkIernoNnAfD3raYiyW+PJhXVGJtE928NAOLdiGMNLnmdLCd3kcpS
         HNE8rqYDUcgu1h0MD6oPb874Z68ZO4rW8SpUw5LG57PYld8Ege7LIy35516spG9C2Eti
         FnMDGu4/osAUraIV0xqjEwE436QZ6AwphoCMROVk53RxKG6/ydpRPRjtEVFfMOG+nW/B
         MA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=O4BEtprmRdLBaRwujm8Kdk8wIGXDAT0htXMIWy2hO7w=;
        b=AsrPCfHhvmBsuERCoUNtJu3aaG/25Aj1lq711AaqsJoNY8TbKaBHgzdO3+n3OpSIVT
         vvTwlJEkdmlhsFe9LBNeAUHSaXi2Ly12hMaFHeLU8Wp+EbHwgCYTN53s8cSJt3i8faSd
         lEaEYDUUXBx3SL7AImVLJL7zTqExT2HOx1PiGx8vJzODxH2JO0cuPkTEdz+Mk8XTr5dk
         5ieJJkmJHhpkwKFp8pjEa2CDuSIT+9b2GQaTNt0Zce8TKPirYy52QGikmOmrE4rtLEoY
         hfxuM/QoYG8hvDF/sbpevLlPIOS5VVAtliiRojaiwWbblu4hvsUoBsQmhNMf2aZubO/x
         cD5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ni/kl0pX;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ni/kl0pX;
       spf=pass (google.com: domain of ndesaulniers@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ndesaulniers@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48i3txsrQkrA7GT9zZ6BfidwNNw29jVN68azT3spspguPa+OEnZ89qXNr51J5e2mrYYzGoRpzp0onnGz3Da9is=
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdkjB2LGXGn-9chPDtGyVmw9JF1FZ1ZBjSKEtK7BqbwF2g@mail.gmail.com>
 <CA+55aFyZA5t-+OyzSDDPGjDoaKsh=Erz8zuoEdDo7hOCBU6ZfQ@mail.gmail.com>
In-Reply-To: <CA+55aFyZA5t-+OyzSDDPGjDoaKsh=Erz8zuoEdDo7hOCBU6ZfQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 04 Apr 2018 23:10:58 +0000
Message-ID: <CAKwvOdn9unm=tzLs8pdenYZQbcQBump6AYrQAV=tYEx0hDhhFg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>,
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>, Manoj Gupta <manojgupta@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596859056628290774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 10:13 AM Linus Torvalds <
torvalds@linux-foundation.org> wrote:
> The fact that clang by default enables "-fmerge-all-constants"
> behavior is just inexcusable. That's not just "let's do invalid
> optimizations based on undefined behavior". That's an actual "let's do
> known invalid optimizations that are explicitly disallowed even by the
> standard".

Manoj already has a patch for this that looks like it's passed code review:
https://reviews.llvm.org/D45289
--
Thanks,
~Nick Desaulniers
