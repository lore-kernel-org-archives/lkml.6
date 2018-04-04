Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522880959; cv=none;
        d=google.com; s=arc-20160816;
        b=eXOmy1CNCVo1xVpMy23gZO9PAqcY1WvWqt9RSGNcgYNX3Sf5BoZADfn+IqRdfIQq8f
         GRtN5j0pP9lgDjXlxDtp4VCjT7zj8Z6VQuEAjtXNdhuuUPqLdkh6GYtcxWG8DeboI9Db
         Merlaig+nrPhoYQBqWN9A4rQlW7HtkwJfFZbMQKH77PGia5y5/CqsLyaGiU91nCxkTTg
         qC0Du3OtszFDbc8uOtBQ2UGzzIw3iSnVUFUHz+jgms/VOH7k7t2WPpKWfAeQ40dqzamE
         r0n6ahFjo2VQupgS9Yx1D7KtgHt5Q1ZaKoa54jqodTN27ksHt3GFFLEGao/xunX/ouST
         alig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=D/i685TLzvf+8+xd4mVTyIlm/xzULgWI8X/vGWMdA2U=;
        b=P9FO8z3vprV4FMYcCpPR5xYkBcDnfD4vxme/WTE8GFlNvecJ9kvbGgbOHHdFD3WyYI
         iRFz32ZrX0gwGQttQeq9tZ3WV2MhPYOmmRg6tUbXfIPd5dGWqtP9D3c8P4F1MNFWE9z0
         3W1S+uhzIh+8P4SmNIlLWQkEfS8C8TwoGx18R3sdViTlPTkJoIz3rLAI0dpQKF66X8tj
         L9btt5pnimQ0hMjVMm8UE01e+Vhoak1m6jZ2o2GJUlyrD+wrWBnl+YmKta0y57ZNVggc
         dG5q/r71xRFrPup+CP6RH3A4R1lXmD2C2AYcDVUAuLV/op0rNIg18Lqf6yLvvMhVfMb8
         jWcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QykNWscj;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=DeO6bqC/;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QykNWscj;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=DeO6bqC/;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/jeyn+5ndja4BvtQdxD4zxuTEoP6hMTYYO9zUBEzp19+YLYKSSqYryJFB5j90W+L80kkXCRwWz63TYwbjJZ9M=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAA2zVHqMS7HQggLnhQc9qjUhnD5MQXcyXkVnCQ0BoKqC8i3vgw@mail.gmail.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
 <20180404165914.GA9034@kroah.com> <CAA2zVHoteRJeGM=kmsZmaKP97K0LJhVF872KhpWE192A-=B4SA@mail.gmail.com>
 <CA+55aFysRcOu7F-kZKNWp_fY1DViQoz7OmXUBeD0xhXROvPYqA@mail.gmail.com> <CAA2zVHqMS7HQggLnhQc9qjUhnD5MQXcyXkVnCQ0BoKqC8i3vgw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 15:29:18 -0700
X-Google-Sender-Auth: sEq3t7szlU9WL-VqZawAkkDp05A
Message-ID: <CA+55aFztDvKyHp1GuNdj4xpUf4YpPrP+pqiQzwfpvXb-gBnwqQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: James Y Knight <jyknight@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Matthias Kaehlcke <mka@chromium.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>, Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596856424587024751?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 3:21 PM, James Y Knight <jyknight@google.com> wrote:
>
> But allowing random pointer arithmetic, and pointer arithmetic wraparound,
> is still different than asserting that an object _field access_ can
> overflow.

But that's not what the code does.

It never _accessed_ the field. It only looked at the *address* of the field.

So clang got this case wrong:

        &(pos)->member != NULL

where that "&" thing is very much important. There was no access. An
access would in fact have been a bug (and was the bug that the
compiler caused, because it removed the check for NULL).

You may consider this an "access", but to me, it's all just pointer
arithmetic, and not in the least different from the kind of pointer
arithmetic that "offsetof()" traditionally does.

So I think your "it's a field access" is just a syntactic argument and
should not semantically be *any* different from doing arithmetic on a
pointer.

            Linus
