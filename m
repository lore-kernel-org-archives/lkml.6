Return-Path: <jyknight@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522880477; cv=none;
        d=google.com; s=arc-20160816;
        b=cJHejijats7IQfixKmov+IiGqNE+vkFy12YQQmONDNwkunYWawuMC4C+mllgWiVrUq
         Npo5BAXCUO29mZA+aIIr0gE/L0BjtvxGlIBwIOwuCVcDL/ofNKgbuaVwPqXwXc+ZjTQj
         sW4B9dBfr1apd3zBv1nz9laGveLY0/0FjxZNrtBC1geTmrBz72rO2pzlzzOX0SNNyTYd
         /41Qyfj0HhRsUkIVvjM7cqGwDmQ0BZ6iMF5xmUURuiQZpvEsn/GL3vGWiI4IuwY+hnrZ
         3wSaHbztdj6jHCGf464aNxRyMfd9jBMb6Hwsrf86E/9v9yL6UzSB/721RhvTEV6O+Hsq
         b/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=aGIWht1kQ+Cq66J7jmCJZLGEtEiqVLY1anVMyHjG/js=;
        b=mMamX1rcLm9biGqEz+IcqNxXMZXA6OW3aXOkNdZrKwzEKt3rjYzv4Kyogy/SiWY0h7
         8r6L5f3E9vn4K4HWLJ1GQrRu7MrquMf8vJajbwDgJfLKyfk7T3A5n124KLWHweXOyjl6
         frT6XnFw3WsHHgHe99nUJkWUyaVeCPIQPTbde8lq3LK9G60Pl/LC8BAHM1uwNdZtrdNm
         /jSEXqPDaV1/3gy6r+ZE7O7IcU4y2ZPYDgeLj/ghFepM+E3Y3Ds3nNi6vLD5sbYzEeV2
         6+DiiGGMNTXGa0t8b7cZ34c1kTcT7mVPcWr50MQVxTKuBlSG4b71MXnKIctH+0Ey4BCh
         F0rA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ExD2uk6Z;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ExD2uk6Z;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/lThL7pfmgpQI3tMDp0/bRRRIXmCHoNp6m6nl1yBMbk7/W1XZ3n3WozwTVJIeBnJALTkXujhDMYSafCB4G8RA=
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
 <20180404165914.GA9034@kroah.com> <CAA2zVHoteRJeGM=kmsZmaKP97K0LJhVF872KhpWE192A-=B4SA@mail.gmail.com>
 <CA+55aFysRcOu7F-kZKNWp_fY1DViQoz7OmXUBeD0xhXROvPYqA@mail.gmail.com>
In-Reply-To: <CA+55aFysRcOu7F-kZKNWp_fY1DViQoz7OmXUBeD0xhXROvPYqA@mail.gmail.com>
From: James Y Knight <jyknight@google.com>
Date: Wed, 04 Apr 2018 22:21:05 +0000
Message-ID: <CAA2zVHqMS7HQggLnhQc9qjUhnD5MQXcyXkVnCQ0BoKqC8i3vgw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gregkh@linuxfoundation.org, Nick Desaulniers <ndesaulniers@google.com>, mka@chromium.org,
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596855920222153945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 3:42 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:
> So we'd definitely want that "-fno-strict-overflow" to affect pointer
> arithmetic too (or have a separate flag for the pointer equivalent of
> "we play games that may temporarily wrap pointer values around"..

The -fno-strict-overflow flag in clang does do that. You can subtract any
two random pointers you have, whether they're in the same object or not,
even if the math overflows. And you can later add things back together, and
end up back where you started, and load the value. No problem, even though
subtracting pointers from unrelated objects is illegal according to C.

That's why container_of as it's written in the kernel does work in clang --
wrapping arithmetic when given a NULL pointer and everything. (as a
sidenote...it would be a readability improvement to make container_of do
its math with a uintptr_t instead of a void*, since it would be more
*obviously* correct...)

But allowing random pointer arithmetic, and pointer arithmetic wraparound,
is still different than asserting that an object _field access_ can
overflow. Clang does not believe that can happen -- it assumes that an
object will still be contiguous. And that's why the llist stuff used to be
broken, before it was corrected to do simply do math on a uintptr_t (which
is a nice and simple and sane fix!).
